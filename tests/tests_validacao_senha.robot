*** Settings ***
Library     Browser
Resource    ../resources/variables_local.robot
Resource    ../resources/keywords/login_cliente_keywords.robot
Resource    ../resources/keywords/evidencias_keywords.robot
Resource    ../resources/keywords/cadastro_cliente_keywords.robot
Resource    ../resources/keywords/teams_keywords.robot

Test Teardown    Capturar Evidencia Se Falhar

*** Test Cases ***

Validar Senhas Invalidas
    [Documentation]    Valida as mensagens de erro para diferentes padrões de senha inválida
    [Template]    Testar Senha Invalida

    # Senha           # Comentário
    1234567           # Curta
    senha123          # Sem maiúscula
    SENHA123          # Sem minúscula
    SenhaSemNumero    # Sem número
    Senha123          # Sem especial
    senha@123         # Sem número/maiúscula (depende da regra)
    ${EMPTY}          # Vazia

Validar Regras de Senha no Cadastro
    [Documentation]    Valida se os indicadores de segurança da senha aparecem corretamente
    Ir Para Tela Cadastro
    
    # Testando senha curta (menos de 8 caracteres)
    Fill Text    ${INPUT_SENHA_CADASTRO}    Ab1@
    Wait For Elements State    ${REGRA_SENHA_MIN}    visible    30s
    
    # Testando senha sem letra maiúscula
    Fill Text    ${INPUT_SENHA_CADASTRO}    teste123@
    Wait For Elements State    ${REGRA_SENHA_MAIUSCULA}    visible    30s