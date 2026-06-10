*** Settings ***
Library    Browser

Resource    ../../resources/variables_local.robot
Resource    ../../resources/keywords/login_cliente_keywords.robot
Resource    ../../resources/keywords/evidencias_keywords.robot

Test Teardown    Capturar Evidencia Se Falhar


*** Test Cases ***

Validar Login Com Sessao Salva

    Abrir Sessao Logada

    Usuario Esta Logado
