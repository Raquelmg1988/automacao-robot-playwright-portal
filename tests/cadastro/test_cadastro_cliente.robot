*** Settings ***
Library     Browser
Resource    ../../resources/variables_local.robot
Resource    ../../resources/keywords/login_cliente_keywords.robot
Resource    ../../resources/keywords/cadastro_cliente_keywords.robot
Resource    ../../resources/keywords/evidencias_keywords.robot
Resource    ../../resources/keywords/common_keywords.robot


Suite Setup    Abrir Sessao Logada
Test Teardown    Capturar Evidencia Se Falhar

*** Test Cases ***

Validar Cadastro Novo Cliente
    [Documentation]    Fluxo completo de cadastro para um novo CNPJ
    Ir Para Tela Cadastro
    Preencher Dados Usuario Valido
    Preencher CNPJ Novo
    Marcar LGPD
    Clicar Continuar Com Loader
    Validar Mensagem Cadastro Em Analise

Validar Cadastro Cliente Existente
    [Documentation]    Fluxo de cadastro para um CNPJ que já possui conta (revinculação)
    Ir Para Tela Cadastro
    Preencher Dados Usuario Valido
    Preencher CNPJ Existente
    Marcar LGPD
    Clicar Continuar Com Loader
    Wait For Elements State    text=Código de verificação    visible    30s
    # O código abaixo é um exemplo, no teste real precisaria de intervenção ou mock
    Preencher Codigo Validacao    LXIJOD
    Click    text=Validar código
    Wait For Elements State    text=Bem-vindo    visible    30s

Validar Email Ja Cadastrado
    [Documentation]    Valida o bloqueio de cadastro com e-mail já existente no sistema
    Ir Para Tela Cadastro
    Preencher Dados Usuario    Raquel    Goncalves    21999999999    raquelmg88@gmail.com    Teste@123
    Wait For Elements State    ${MSG_EMAIL_EXISTENTE}    visible    30s

Validar Campos Obrigatorios
    [Documentation]    Valida as mensagens de erro ao tentar prosseguir com campos vazios
    Ir Para Tela Cadastro
    Click    ${BTN_CONTINUAR}
    Wait For Elements State    ${MSG_CAMPO_OBRIGATORIO}    visible    30s