*** Settings ***
Library     Browser
Library     OperatingSystem
Library     Collections
Library     String
Library     XML
Library     DateTime
Resource    ../locators/locators.robot
Resource    common_keywords.robot
Resource    ../variables_local.robot

*** Keywords ***

Abrir Portal
    [Arguments]    ${headless}=False
    New Browser    chromium    headless=${headless}
    
    ${file_exists}=    Run Keyword And Return Status
    ...    File Should Exist    ${EXECDIR}/${AUTH_STATE_JSON}
    
    IF    ${file_exists}
        Log To Console    \n📦 Carregando sessão do arquivo: ${EXECDIR}/${AUTH_STATE_JSON}
        New Context    storageState=${EXECDIR}/${AUTH_STATE_JSON}
    ELSE
        Log To Console    \n⚠️ Arquivo de sessão não encontrado. Iniciando nova sessão...
        New Context
    END
    
    New Page    ${URL}
    Set Browser Timeout    60s


Fazer Login Cliente
    [Arguments]    ${email}=${EMAIL_CLIENTE}    ${senha}=${SENHA_CLIENTE}
    Abrir Portal    headless=False
    
    ${ja_logado}=    Run Keyword And Return Status
    ...    Wait For Elements State    ${HOME_PAGE_SELECTOR}    visible    10s
    
    IF    ${ja_logado}
        Log To Console    \n✅ Já estou logado! Pulando login.
    ELSE
        Log To Console    \n🔑 Realizando login...
        Fill Text    ${INPUT_EMAIL}    ${email}
        Fill Text    ${INPUT_SENHA}    ${senha}
        Click    ${BTN_ENTRAR}
        
        ${status_mfa}=    Run Keyword And Return Status
        ...    Wait For Elements State    ${MFA_INPUT}    visible    10s
        
        IF    ${status_mfa}
            Log To Console    \n⚠️ MFA detectado! Aguardando...
            Wait For Elements State    ${HOME_PAGE_SELECTOR}    visible    120s
        END
        
        Save Storage State    path=${AUTH_STATE_JSON}
    END


Validar Login Sucesso
    Wait For Elements State    ${HOME_PAGE_SELECTOR}    visible    30s
    Get Url    contains    dashboard
    Log    Login realizado com sucesso!