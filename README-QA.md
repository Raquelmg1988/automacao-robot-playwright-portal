# Automação de testes — Guia de QA (homologação)

Este guia explica como rodar a automação contra o ambiente de **homologação (hml)**
sem precisar passar pelo MFA manualmente.

A sessão autenticada é gerada pelo script [`gerar_auth.py`](gerar_auth.py), que faz login
na API usando uma **chave de API de QA** (bypass de MFA, habilitado **apenas em hml**). O
token retornado é salvo em `auth_state.json` no formato de _storage state_ do Playwright,
e as keywords do Robot (`Abrir Sessao Logada`) reutilizam essa sessão.

> Você vai precisar ter: **`QA_KEY_OWNER`** e
> **`QA_API_KEY`**. São eles que liberam a geração da sessão.

---

## 1. Configurar as variáveis de ambiente

Use uma conta **cliente** de teste. O e-mail **não** pode ser `@grupoelfa.com.br` nem
`@grupoelfa.onmicrosoft.com` — esses domínios são forçados ao login Microsoft e **não**
passam pelo bypass.

> ⚠️ Cole a `QA_API_KEY` em **uma única linha**, sem quebra/espaços.

**Windows (PowerShell):**

```powershell
$env:EMAIL_CLIENTE = "raquelmg88@gmail.com"     # conta cliente de teste
$env:SENHA_CLIENTE = "<senha da conta>"
$env:QA_API_KEY    = "<key enviada pelo backend>"
$env:QA_KEY_OWNER  = "<key-owner enviado pelo backend>"
# API_URL e WEB_ORIGIN já têm default de hml — só defina se for apontar para outro lugar
```

### Variáveis aceitas pelo `gerar_auth.py`

| Variável          | Obrigatória | Default                                               |
| ----------------- | ----------- | ----------------------------------------------------- |
| `EMAIL_CLIENTE`   | sim         | —                                                     |
| `SENHA_CLIENTE`   | sim         | —                                                     |
| `QA_API_KEY`      | sim         | —                                                     |
| `QA_KEY_OWNER`    | não         | `qa-automation`                                       |
| `API_URL`         | não         | `https://api-hml-portaldocliente.grupoelfa.com.br/v1` |
| `WEB_ORIGIN`      | não         | `https://hml.portaldocliente.grupoelfa.com.br`        |
| `AUTH_STATE_JSON` | não         | `./auth_state.json` (na raiz do projeto)              |

---

## 2. Gerar a sessão

```bash
python gerar_auth.py
```

Sucesso = mensagem `OK: auth_state.json gerado com sucesso em: ...` e o arquivo
**`auth_state.json`** criado na raiz do projeto.

---

## 3. Rodar os testes

**Windows:**

```powershell
.\run_tests.ps1
```

**Um teste isolado (qualquer SO):**

```bash
robot -v AUTH_STATE_JSON:<caminho>/auth_state.json -d results tests/login/test_login_sucesso.robot
```

---

## 4. Quando regerar a sessão

O token expira em ~**2 dias**. Quando os testes começarem a cair na tela de login,
rode novamente o **passo 3** (`python gerar_auth.py`) para obter uma sessão nova.

---

## Erros comuns

| Mensagem                                                  | O que significa                                                                        |
| --------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| `a resposta nao trouxe 'token' (needsMfaValidation=True)` | Key/owner incorretos, ambiente sem o bypass (tem que ser hml), ou e-mail `@grupoelfa`. |
| `login falhou (HTTP 401/403)` / `Invalid API Key`         | `QA_API_KEY`/`QA_KEY_OWNER` não conferem. Confirme os valores com o backend.           |
| `... NoValidUserDomain`                                   | Foi usado e-mail `@grupoelfa`. Use uma conta **cliente**.                              |
| `falha de rede ao chamar ...`                             | `API_URL` errado/instável ou sem acesso ao ambiente.                                   |

---

## Observações técnicas

- **Nunca** commite a `QA_API_KEY`, a senha, nem o `auth_state.json` (ele contém um token
  de acesso válido). Esses arquivos já estão no `.gitignore` (`.env`, `auth_state.json`,
  `resources/variables_local.robot`).
- O bypass funciona **apenas em homologação (hml)**. Em produção ele é inerte.
- Em CI, esses valores devem entrar como **variáveis mascaradas** do pipeline, nunca no código.
