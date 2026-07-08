*** Settings ***
Library     Browser

Resource    ../variables_local.robot
Resource    ../locators/locators.robot
Resource    common_keywords.robot


*** Keywords ***

Fazer Login Cliente
    Abrir Sessao Logada

Abrir Sessao Logada

    Set Browser Timeout    30s

    New Browser    chromium    headless=True

    New Context
    ...    storageState=${AUTH_STATE_JSON}

    New Page    ${URL}dashboard

    Wait For Elements State
    ...    ${MENU_PEDIDOS}
    ...    visible
    ...    30s

    Aguardar UI Livre

    Usuario Esta Logado


Usuario Esta Logado

    ${url}=    Get Url

    Log To Console
    ...    URL atual: ${url}

    Should Not Contain
    ...    ${url}
    ...    login

    Should Contain
    ...    ${url}
    ...    dashboard