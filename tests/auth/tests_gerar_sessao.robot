*** Settings ***
Library    Browser
Library    OperatingSystem

Resource    ../../resources/variables_local.robot
Resource    ../../resources/locators/locators.robot


*** Test Cases ***

Gerar Sessao Logada
    [Documentation]    Geracao manual de sessao (login + MFA no navegador).
    ...    Fluxo legado: prefira "python gerar_auth.py", que gera a sessao via API
    ...    sem MFA manual. Marcado como manual para nao rodar em execucoes automaticas.
    [Tags]    manual

    New Browser    chromium    headless=False

    New Context
    ...    viewport={'width': 1600, 'height': 900}

    New Page    ${URL}

    Log To Console    ⚠️ Faça login manual + MFA

    Wait Until Keyword Succeeds
    ...    3 min
    ...    5 sec
    ...    Verificar Dashboard

    Sleep    5s

    ${state}=    Save Storage State

    Copy File
    ...    ${state}
    ...    ${AUTH_STATE_JSON}

    Log To Console    ✅ Sessão salva com sucesso


*** Keywords ***

Verificar Dashboard

    Wait For Load State    networkidle

    Sleep    15s

    ${url}=    Get Url

    Log To Console    URL atual: ${url}

    Should Not Contain    ${url}    login

    Run Keyword And Ignore Error
    ...    Click    text=Fechar

    Run Keyword And Ignore Error
    ...    Click    button:has-text("Fechar")

    Run Keyword And Ignore Error
    ...    Click    css=button[class*="rounded-3xl"]

    Sleep    5s

    Log To Console    ✅ Dashboard validado