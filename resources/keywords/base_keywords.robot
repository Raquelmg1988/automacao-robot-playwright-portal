*** Settings ***
Library    Browser

Resource    ../variables_local.robot


*** Keywords ***

Abrir Sessao Logada

    New Browser    chromium    headless=False

    New Context
    ...    storageState=${AUTH_STATE_JSON}
    ...    viewport={'width': 1600, 'height': 900}

    New Page    ${URL}

    Wait For Load State    networkidle

    Sleep    5s


Fechar Sessao

    Close Browser