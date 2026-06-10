*** Settings ***
Library    Browser

Resource    ../../resources/variables_local.robot
Resource    ../../resources/locators/locators.robot


*** Test Cases ***

Teste Sessao

    New Browser    chromium    headless=False

    New Context
    ...    storageState=${AUTH_STATE_JSON}
    ...    viewport={'width': 1600, 'height': 900}

    New Page    ${URL}

    Wait For Load State    networkidle

    Sleep    10s

    ${url}=    Get Url
    Log To Console    URL atual: ${url}

    Run Keyword And Ignore Error
    ...    Click    text=Fechar

    Run Keyword And Ignore Error
    ...    Click    button:has-text("Fechar")

    Run Keyword And Ignore Error
    ...    Click    css=button[class*="rounded-3xl"]

    Sleep    5s

    Wait Until Keyword Succeeds
    ...    2 min
    ...    5s
    ...    Wait For Elements State
    ...    ${MENU_PEDIDOS}
    ...    visible
    ...    30s

    Log To Console    ✅ Sessão funcionando

    Sleep    5s

    Close Browser