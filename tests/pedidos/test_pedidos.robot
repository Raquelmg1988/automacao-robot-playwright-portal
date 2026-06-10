*** Settings ***
Library     Browser

Resource    ../../resources/variables_local.robot
Resource    ../../resources/locators/locators.robot
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/keywords/pedidos_keywords.robot
Resource    ../../resources/keywords/evidencias_keywords.robot

Suite Setup       Abrir Sessao Logada
Suite Teardown    Close Browser
Test Teardown     Capturar Evidencia Se Falhar


*** Test Cases ***

Validar Pedidos
    Ir Para Pedidos
    Validar Lista Pedidos


Validar Filtro Status Faturado
    Ir Para Pedidos
    Filtrar Por Status    Faturado
    Validar Status Na Tabela    Faturado


Validar Filtro Status Nao Faturado
    Ir Para Pedidos
    Filtrar Por Status    Não Faturado
    Validar Status Na Tabela    Não faturado


Validar Filtro Ultima Semana
    Ir Para Pedidos
    Filtrar Por Periodo    Última semana
    Validar Tabela Carregada


Validar Filtro Ultima Semana + Faturado
    Ir Para Pedidos
    Filtrar Por Status    Faturado
    Filtrar Por Periodo    Última semana
    Validar Tabela Carregada


Validar Filtro Ultima Semana + Nao Faturado
    Ir Para Pedidos
    Filtrar Por Status    Não Faturado
    Filtrar Por Periodo    Última semana
    Validar Tabela Carregada


Validar Detalhes Pedido
    Ir Para Pedidos
    Abrir Primeiro Pedido
    Validar Detalhes do Pedido