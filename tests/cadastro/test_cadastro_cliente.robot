*** Settings ***

Library     Browser

Resource    ../../resources/variables_local.robot
Resource    ../../resources/locators/locators.robot
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/keywords/cadastro_cliente_keywords.robot
Resource    ../../resources/keywords/evidencias_keywords.robot

Suite Setup      Run Keywords
...              Set Browser Timeout    30s
...              AND    New Browser    browser=chromium    headless=True    args=["--disable-gpu", "--disable-software-rasterizer"]
...              AND    New Page    ${URL}


Test Setup       Ir Para Tela Cadastro

Suite Teardown   Close Browser
Test Teardown    Capturar Evidencia Se Falhar


*** Test Cases ***

Validar Cadastro Novo Cliente
    [Documentation]
    ...    Fluxo de cadastro automatizado até a conclusão do cadastro.
    ...    Valida o envio dos documentos e a exibição da tela de ativação da conta.

    Ir Para Tela Cadastro

    ${email}=    Gerar Email Aleatorio

    Preencher Dados Usuario
    ...    Raquel
    ...    Goncalves
    ...    81999999999
    ...    ${email}
    ...    SenhaForte@123

    Preencher CNPJ Novo

    Preencher Dados Cliente
    ...    Empresa Teste
    ...    Empresa Teste
    ...    20040002

    Marcar LGPD

    Clicar Continuar Com Loader

    Anexar Documentos Cadastro

    # Esta keyword agora faz o clique, valida o modal rosa, clica em Ok e valida a URL final
    Finalizar Cadastro


Validar Cadastro Cliente Existente
    [Documentation]
    ...    Valida o cadastro utilizando um CNPJ já existente.

    Ir Para Tela Cadastro

    ${email}=    Gerar Email Aleatorio

    Preencher Dados Usuario
    ...    Raquel
    ...    Goncalves
    ...    81999999999
    ...    ${email}
    ...    SenhaForte@123

    Preencher CNPJ Existente

    Wait For Elements State
    ...    ${MARCAR_LGPD}
    ...    visible
    ...    30s

    Marcar LGPD

    Click    ${BTN_FINALIZAR_CADASTRO}

    # Aguarda o texto da tela de ativação por e-mail que apareceu no log
    Wait For Elements State
    ...    xpath=//*[contains(text(),'Para ativar a sua conta informe no campo abaixo o código de verificação')]
    ...    visible
    ...    30s
    
    Take Screenshot


Validar Email Ja Cadastrado
    Ir Para Tela Cadastro

    Fill Text    ${INPUT_NOME}               Raquel
    Fill Text    ${INPUT_SOBRENOME}          Goncalves
    Fill Text    ${INPUT_CELULAR}            81999999999
    Fill Text    ${INPUT_EMAIL_CADASTRO}     raquel.goncalves@grupoelfa.com
    Fill Text    ${INPUT_SENHA_CADASTRO}     SenhaForte@123
    Fill Text    ${INPUT_CONFIRMAR_SENHA}    SenhaForte@123

    Press Keys    ${INPUT_CONFIRMAR_SENHA}    Tab

    Sleep    3s

    Click    ${BTN_CONTINUAR}

    Sleep    3s

    ${body}=    Get Text    body

    Should Contain
    ...    ${body}
    ...    Já existe um usuário cadastrado com este e-mail


Validar Campos Obrigatorios
    Ir Para Tela Cadastro

    Click    ${BTN_CONTINUAR}

    Wait For Elements State
    ...    ${MSG_CAMPO_OBRIGATORIO}
    ...    visible
    ...    20s
