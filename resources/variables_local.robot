*** Variables ***
${URL}    https://hml.portaldocliente.grupoelfa.com.br/

# LOGIN
${EMAIL_FUNCIONARIO}   %{EMAIL_FUNCIONARIO}
${EMAIL_CLIENTE}       %{EMAIL_CLIENTE}
${SENHA_CLIENTE}       %{SENHA_CLIENTE}

# ESTA LINHA É A CHAVE:
# Localmente, se o arquivo não existir, ele ignora. 
# Na Pipeline, o comando "-v AUTH_STATE_JSON:$AUTH_STATE_JSON_PATH" vai preencher este valor.
${AUTH_STATE_JSON}          auth_state.json

# TIMEOUTS
${MFA_TIMEOUT}         60s
${HOME_TIMEOUT}        30s

# MENSAGENS
${MSG_EMAIL_EXISTENTE}    E-mail já cadastrado
