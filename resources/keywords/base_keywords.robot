*** Settings ***
Library    Browser
Resource   ../variables_local.robot

*** Keywords ***

Abrir Navegador
    New Browser    chromium    headless=False
    New Context
    New Page    ${URL}
    Wait For Elements State    body    visible    30s


Abrir Sessao Logada
    Set Browser Timeout    60s

    New Browser    chromium    headless=False

    New Context
    ...    storageState=${AUTH_STATE_JSON}

    New Page    ${URL}

    Sleep    5s

    ${url}=    Get Url
    Log To Console    URL APOS SESSAO: ${url}

    Wait For Elements State
    ...    ${MENU_PEDIDOS}
    ...    visible
    ...    60s


Fechar Sessao
    Close Browser