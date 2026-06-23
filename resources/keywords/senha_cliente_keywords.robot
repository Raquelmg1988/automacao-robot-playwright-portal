*** Settings ***
Library     Browser

Resource    ../locators/locators.robot
Resource    common_keywords.robot
Resource    cadastro_cliente_keywords.robot

*** Keywords ***

Testar Senha Invalida
    [Arguments]    ${senha}

    Ir Para Tela Cadastro

    Clear Text    ${INPUT_SENHA_CADASTRO}
    
    IF    "${senha}" != "${EMPTY}"
        Fill Text     ${INPUT_SENHA_CADASTRO}    ${senha}
    END

    Press Keys    ${INPUT_SENHA_CADASTRO}    Tab

    IF    "${senha}" == "${EMPTY}"
        Click    ${BTN_CONTINUAR}
        Wait For Elements State    ${MSG_CAMPO_OBRIGATORIO}    visible    5s
    ELSE
        ${status_botao}=    Get Element States    ${BTN_CONTINUAR}
        
        IF    "enabled" in ${status_botao}
            Click    ${BTN_CONTINUAR}
            
            Wait For Elements State    css=.text-destructive    visible    5s
        ELSE
            
            Log To Console    Sucesso: Botão Continuar permaneceu desabilitado para a senha: ${senha}
        END
    END


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