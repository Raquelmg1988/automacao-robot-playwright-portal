"""Gera o auth_state.json (storage state do Playwright) para a automacao.

Em vez de exigir login manual + MFA no navegador, este script chama a rota de
login do Portal do Cliente enviando a chave de API de QA. Esse bypass de MFA so
funciona no ambiente de homologacao (STAGE=hml) e apenas para a chave marcada com
canBypassMfa. O token retornado e injetado no localStorage (@PDC-auth) e salvo no
formato de storage state consumido pelas keywords do Robot (Abrir Sessao Logada).

Variaveis de ambiente:
  API_URL         API do backend.   default: https://api-hml-portaldocliente.grupoelfa.com.br/v1
  WEB_ORIGIN      Origem do front.   default: https://hml.portaldocliente.grupoelfa.com.br
  EMAIL_CLIENTE   (obrigatoria) e-mail do usuario de teste
  SENHA_CLIENTE   (obrigatoria) senha do usuario de teste
  QA_API_KEY      (obrigatoria) valor da chave criada na tabela DynamoDB de hml
  QA_KEY_OWNER    campo "owner" da chave.   default: qa-automation
  AUTH_STATE_JSON caminho de saida.   default: ./auth_state.json (ao lado deste script)
"""

import json
import os
import sys

import requests

# Mesma chave usada pelo front em pc-front/src/utils/auth.ts
TOKEN_STORAGE_KEY = "@PDC-auth"

DEFAULT_API_URL = "https://api-hml-portaldocliente.grupoelfa.com.br/v1"
DEFAULT_WEB_ORIGIN = "https://hml.portaldocliente.grupoelfa.com.br"


def _require_env(name):
    value = os.environ.get(name)
    if not value:
        sys.exit(f"ERRO: variavel de ambiente obrigatoria ausente: {name}")
    return value


def main():
    api_url = os.environ.get("API_URL", DEFAULT_API_URL).rstrip("/")
    web_origin = os.environ.get("WEB_ORIGIN", DEFAULT_WEB_ORIGIN).rstrip("/")
    email = _require_env("EMAIL_CLIENTE")
    senha = _require_env("SENHA_CLIENTE")
    api_key = _require_env("QA_API_KEY")
    key_owner = os.environ.get("QA_KEY_OWNER", "qa-automation")

    output_path = os.environ.get(
        "AUTH_STATE_JSON",
        os.path.join(os.path.dirname(os.path.abspath(__file__)), "auth_state.json"),
    )

    print(f"-> Autenticando {email} em {api_url} (bypass de MFA via chave de QA)...")

    try:
        resp = requests.post(
            f"{api_url}/user/login",
            json={"email": email, "password": senha},
            headers={"x-api-key": api_key, "key-owner": key_owner},
            timeout=30,
        )
    except requests.RequestException as err:
        sys.exit(f"ERRO: falha de rede ao chamar {api_url}/user/login: {err}")

    if resp.status_code != 200:
        sys.exit(f"ERRO: login falhou (HTTP {resp.status_code}): {resp.text}")

    data = resp.json()
    token = data.get("token")

    if not token:
        sys.exit(
            "ERRO: a resposta nao trouxe 'token' "
            f"(needsMfaValidation={data.get('needsMfaValidation')}).\n"
            "Verifique se o backend com o bypass esta no ambiente apontado por API_URL "
            "(STAGE=hml) e se a chave de QA existe na tabela DynamoDB de hml com "
            "owner=QA_KEY_OWNER, isValid=true e canBypassMfa=true.\n"
            f"Resposta: {data}"
        )

    state = {
        "cookies": [],
        "origins": [
            {
                "origin": web_origin,
                "localStorage": [{"name": TOKEN_STORAGE_KEY, "value": token}],
            }
        ],
    }

    with open(output_path, "w", encoding="utf-8") as f:
        json.dump(state, f, ensure_ascii=False, indent=2)

    print(f"OK: auth_state.json gerado com sucesso em: {output_path}")


if __name__ == "__main__":
    main()
