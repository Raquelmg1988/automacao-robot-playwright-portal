*** Settings ***
Library     Browser

Resource    ../resources/variables_local.robot
Resource    ../resources/locators/locators.robot
Resource    ../resources/keywords/login_cliente_keywords.robot
Resource    ../resources/keywords/evidencias_keywords.robot
Resource    ../resources/keywords/cadastro_cliente_keywords.robot
Resource    ../resources/keywords/senha_cliente_keywords.robot

Test Teardown    Capturar Evidencia Se Falhar

*** Test Cases ***

Validar Senhas Invalidas
    [Documentation]    Valida mensagens para senhas inválidas
    [Template]    Testar Senha Invalida

    1234567
    senha123
    SENHA123
    SenhaSemNumero
    Senha123
    senha@123
    ${EMPTY}

Validar Regras de Senha no Cadastro
    Ir Para Tela Cadastro

    Fill Text    ${INPUT_SENHA_CADASTRO}    Ab1@

    Wait For Elements State
    ...    ${REGRA_SENHA_MIN}
    ...    visible
    ...    30s

    Clear Text    ${INPUT_SENHA_CADASTRO}

    # Testando senha sem maiúscula
    Fill Text    ${INPUT_SENHA_CADASTRO}    teste123@

    Wait For Elements State
    ...    ${REGRA_SENHA_MAIUSCULA}
    ...    visible
    ...    30s