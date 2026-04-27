*** Settings ***
Library     Browser
Resource    ../resources/variables_local.robot
Resource    ../resources/keywords/login_cliente_keywords.robot
Resource    ../resources/keywords/pedidos_keywords.robot
Resource    ../resources/keywords/evidencias_keywords.robot
Resource    ../resources/keywords/teams_keywords.robot

Test Teardown    Capturar Evidencia Se Falhar

*** Test Cases ***

Ir Para Pedidos
    [Documentation]    Valida o acesso à tela de listagem de pedidos
    Fazer Login Cliente
    Ir Para Pedidos
    Wait For Elements State    ${PEDIDO_ROW}    visible    15s

Visualizar Pedidos Cliente
    [Documentation]    Valida a aplicação de filtros na lista de pedidos
    Fazer Login Cliente
    Ir Para Pedidos
    Filtrar Por Status     Faturado
    Filtrar Por Periodo    Última semana
    Validar Lista Pedidos

Validar Detalhes e Documentos do Pedido
    [Documentation]    Valida se os documentos (NF, Boleto, Comprovante) estão disponíveis
    Fazer Login Cliente
    Ir Para Pedidos
    Abrir Primeiro Pedido
    Validar Detalhes do Pedido
    Validar Boleto Primeiro Pedido
    Validar Comprovante Primeiro Pedido
    Baixar Nota Fiscal Primeiro Pedido