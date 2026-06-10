*** Settings ***
Library     Browser

Resource    ../locators/locators.robot
Resource    common_keywords.robot
Resource    cadastro_cliente_keywords.robot

*** Keywords ***

Testar Senha Invalida
    [Arguments]    ${senha}

    Ir Para Tela Cadastro

    Fill Text
    ...    ${INPUT_SENHA_CADASTRO}
    ...    ${senha}

    ${botao_habilitado}=
    ...    Run Keyword And Return Status
    ...    Wait For Elements State
    ...    ${BTN_CONTINUAR}
    ...    enabled
    ...    5s

    IF    ${botao_habilitado}
        Click    ${BTN_CONTINUAR}
    END

    Wait For Elements State
    ...    ${MSG_CAMPO_OBRIGATORIO}
    ...    visible
    ...    10s


Validar Regra MinimoCaracteres

    Fill Text
    ...    ${INPUT_SENHA_CADASTRO}
    ...    Ab1@

    Wait For Elements State
    ...    ${REGRA_SENHA_MIN}
    ...    visible
    ...    30s

Validar Regra Maiuscula

    Clear Text
    ...    ${INPUT_SENHA_CADASTRO}

    Fill Text
    ...    ${INPUT_SENHA_CADASTRO}
    ...    teste123@

    Wait For Elements State
    ...    ${REGRA_SENHA_MAIUSCULA}
    ...    visible
    ...    30s