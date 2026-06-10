*** Settings ***
Library    Browser
Library    String

Resource    ../variables_local.robot
Resource    ../locators/locators.robot


*** Keywords ***

Abrir Navegador
    [Arguments]    ${headless}=True

    New Browser    chromium    headless=${headless}
    New Context
    New Page    ${URL}

    Set Browser Timeout    60s
    Set Viewport Size    1920    1080


Ir Para Tela Cadastro

    Abrir Navegador

    Go To    ${URL}criar-conta

    Wait For Elements State
    ...    ${INPUT_EMAIL_CADASTRO}
    ...    visible
    ...    30s


Preencher Dados Usuario
    [Arguments]
    ...    ${nome}
    ...    ${sobrenome}
    ...    ${celular}
    ...    ${email}
    ...    ${senha}

    Fill Text    ${INPUT_NOME}              ${nome}
    Fill Text    ${INPUT_SOBRENOME}         ${sobrenome}
    Fill Text    ${INPUT_CELULAR}           ${celular}
    Fill Text    ${INPUT_EMAIL_CADASTRO}    ${email}
    Fill Text    ${INPUT_SENHA_CADASTRO}    ${senha}
    Fill Text    ${INPUT_CONFIRMAR_SENHA}   ${senha}

    Wait For Elements State
    ...    ${BTN_CONTINUAR}
    ...    enabled
    ...    30s

    Click    ${BTN_CONTINUAR}

    Wait For Elements State
    ...    ${INPUT_CNPJ}
    ...    visible
    ...    30s


Preencher Dados Usuario Valido

    ${email}=    Gerar Email Aleatorio

    Log To Console    Email gerado: ${email}

    Preencher Dados Usuario
    ...    Raquel
    ...    Goncalves
    ...    ${CELULAR_TESTE}
    ...    ${email}
    ...    ${SENHA_TESTE}


Preencher CNPJ Novo

    ${cnpj}=    Gerar CNPJ Aleatorio

    Log To Console    CNPJ gerado: ${cnpj}

    Wait For Elements State
    ...    ${INPUT_CNPJ}
    ...    visible
    ...    30s

    Fill Text    ${INPUT_CNPJ}    ${cnpj}


Preencher CNPJ Existente

    Wait For Elements State
    ...    ${INPUT_CNPJ}
    ...    visible
    ...    30s

    Fill Text    ${INPUT_CNPJ}    ${CNPJ_EXISTENTE}


Marcar LGPD

    Wait For Elements State
    ...    ${MARCAR_LGPD}
    ...    visible
    ...    30s

    Click    ${MARCAR_LGPD}


Clicar Continuar Com Loader

    Wait For Elements State
    ...    ${BTN_CONTINUAR}
    ...    enabled
    ...    30s

    Click    ${BTN_CONTINUAR}

    Wait For Elements State
    ...    text=Seu cadastro está em análise
    ...    visible
    ...    30s


Validar Mensagem Cadastro Em Analise

    Wait For Elements State
    ...    text=Seu cadastro está em análise
    ...    visible
    ...    30s


Preencher Codigo Validacao
    [Arguments]    ${codigo}

    Wait For Elements State
    ...    ${MFA_INPUT}
    ...    visible
    ...    30s

    Fill Text    ${MFA_INPUT}    ${codigo}


Gerar Email Aleatorio
    ${rand}=    Generate Random String    8    [LOWER]
    RETURN    teste_${rand}@mailinator.com


Gerar CNPJ Aleatorio
    # CNPJs fictícios com dígitos verificadores válidos para uso em testes
    @{cnpjs}=    Create List
    ...    11.222.333/0001-81
    ...    34.528.760/0001-09
    ...    45.990.175/0001-08
    ...    56.871.080/0001-53
    ${index}=    Evaluate    random.randint(0, 3)    modules=random
    RETURN    ${cnpjs}[${index}]