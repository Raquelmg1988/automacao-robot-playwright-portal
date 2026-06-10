*** Settings ***
Library     Browser

Resource    ../variables_local.robot
Resource    ../locators/locators.robot
Resource    common_keywords.robot


*** Keywords ***

Fazer Login Cliente
    Abrir Sessao Logada


Abrir Sessao Logada

    New Browser    chromium    headless=False

    New Context
    ...    storageState=${AUTH_STATE_JSON}

    New Page    ${URL}

    Wait For Load State
    ...    networkidle

    Aguardar UI Livre

    Usuario Esta Logado


Usuario Esta Logado

    ${url}=    Get Url

    Log To Console
    ...    URL atual: ${url}

    Should Not Contain
    ...    ${url}
    ...    login