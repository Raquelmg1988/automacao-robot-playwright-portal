*** Settings ***
Library     Browser
Resource    ../resources/variables_local.robot
Resource    ../resources/keywords/login_cliente_keywords.robot
Resource    ../resources/keywords/evidencias_keywords.robot
Resource    ../resources/keywords/common_keywords.robot

Test Teardown    Capturar Evidencia Se Falhar
Suite Teardown   Finalizar Suite

*** Test Cases ***

Validar Login Cliente com Sucesso
    Fazer Login Cliente
    Validar Login Sucesso