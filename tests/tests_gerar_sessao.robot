*** Settings ***
Library    Browser

*** Test Cases ***
Gerar Sessao Logada
    [Tags]    manual
    New Browser    chromium    headless=False
    New Context
    New Page    https://hml.portaldocliente.grupoelfa.com.br/

    # ⏳ tempo pra você logar manual + MFA
    Sleep    60s

    Save Storage State

    Close Browser