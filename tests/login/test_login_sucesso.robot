*** Settings ***
Library    Browser

Resource   ../../resources/keywords/pedidos_keywords.robot

Suite Setup       Abrir Sessao Logada
Suite Teardown    Close Browser


*** Test Cases ***

Abrir Primeiro Pedido

    ${body}=    Get Text    body

    Log To Console
    ...    ${body}



Validar Pedidos

    Ir Para Pedidos

    Validar Lista Pedidos


Validar Filtros de Pedidos

    Ir Para Pedidos

    Filtrar Por Status    Faturado

    Validar Lista Pedidos


Validar Detalhes Pedido

    Ir Para Pedidos

    Abrir Primeiro Pedido

    Validar Detalhes do Pedido