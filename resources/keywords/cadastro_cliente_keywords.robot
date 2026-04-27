*** Settings ***
Library     Browser
Library     String
Resource    ../locators/locators.robot
Resource    common_keywords.robot

*** Keywords ***

Abrir Navegador
    New Browser    chromium    headless=False
    New Context
    New Page
Ir Para Tela Cadastro
    New Browser    chromium    headless=True
    New Context
    New Page    https://hml.portaldocliente.grupoelfa.com.br/criar-conta
    Set Viewport Size    1920    1080
    Wait For Elements State    ${INPUT_EMAIL_CADASTRO}    visible    30s

Preencher Dados Usuario
    [Arguments]    ${nome}    ${sobrenome}    ${celular}    ${email}    ${senha}
    
    Fill Text    ${INPUT_NOME}             ${nome}
    Fill Text    ${INPUT_SOBRENOME}        ${sobrenome}
    
    # Limpa a máscara do celular se necessário
    ${celular_limpo}=    Remove String    ${celular}    (    )    -    ${SPACE}
    ${celular_formatado}=    Set Variable    (21) 99999-9999
    Fill Text    ${INPUT_CELULAR}          ${celular_formatado}
    
    Fill Text    ${INPUT_EMAIL_CADASTRO}   ${email}
    Fill Text    ${INPUT_SENHA_CADASTRO}   ${senha}
    Fill Text    ${INPUT_CONFIRMAR_SENHA}  ${senha}
    
    Sleep    2s
    
    Wait For Elements State    ${BTN_CONTINUAR}    enabled    30s
    Click    ${BTN_CONTINUAR}
    
    Wait For Load State    networkidle
    
    # Aguarda a transição para a Etapa 2 (Dados do Cliente)
    Wait For Elements State    ${INPUT_CNPJ}    visible    30s

Preencher Dados Usuario Valido
    ${email}    Gerar Email Aleatorio
    Preencher Dados Usuario    Raquel    Goncalves    21999999999    ${email}    Teste@123

Preencher CNPJ Novo
    Wait For Elements State    ${INPUT_CNPJ}    visible    30s
    Fill Text    ${INPUT_CNPJ}    11.222.333/0001-81

Preencher CNPJ Existente
    Wait For Elements State    ${INPUT_CNPJ}    visible    15s
    Fill Text    ${INPUT_CNPJ}    00.508.745/0001-66

Marcar LGPD
    Wait For Elements State    ${MARCAR_LGPD}    visible    15s
    Click    ${MARCAR_LGPD}
    Sleep    1s

Clicar Continuar Com Loader
    Wait For Elements State    ${BTN_CONTINUAR}    enabled   30s
    Click    ${BTN_CONTINUAR}
    # Aguarda o processamento do cadastro
    Wait For Load State    networkidle

Validar Mensagem Cadastro Em Analise
    Wait For Elements State    text=Seu cadastro está em análise    visible    30s

Preencher Codigo Validacao
    [Arguments]    ${codigo}
    Fill Text    ${MFA_INPUT}    ${codigo}

Gerar Email Aleatorio
    ${numero}    Generate Random String    6    [NUMBERS]
    ${email}     Set Variable    qa_${numero}@gmail.com
    RETURN    ${email}

Testar Senha Invalida
    [Arguments]    ${senha}
    Ir Para Tela Cadastro
    Fill Text    ${INPUT_SENHA_CADASTRO}    ${senha}
    Click    ${BTN_CONTINUAR}
    Wait For Elements State    ${MSG_CAMPO_OBRIGATORIO}    visible    10s
