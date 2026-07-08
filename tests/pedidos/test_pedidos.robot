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


Validar Filtro Status Cancelado
    Ir Para Pedidos
    Filtrar Por Status    Cancelado

    ${body}=    Get Text    body

    IF    "Nenhum pedido disponível" in """${body}"""
        Log To Console    Cliente sem pedidos cancelados
    ELSE
        Should Contain    ${body}    Cancelado
    END


Validar Filtro Ultima Semana
    Ir Para Pedidos
    Filtrar Por Periodo    Última semana
    Validar Tabela Carregada


Validar Filtro Ultima Semana + Faturado
    Ir Para Pedidos
    Filtrar Por Periodo    Última semana
    Filtrar Por Status    Faturado
    Validar Tabela Carregada


Validar Filtro Ultima Semana + Nao Faturado
    Ir Para Pedidos
    Filtrar Por Periodo    Última semana
    Filtrar Por Status    Não Faturado
    Validar Tabela Carregada


Validar Detalhes Pedido
    Ir Para Pedidos

    ${rows}=    Get Element Count    ${PEDIDO_ROWS}

    IF    ${rows} > 0
        Abrir Primeiro Pedido
        Validar Detalhes do Pedido
    ELSE
        Skip    Cliente sem pedidos
    END

 Validar Downloads Na Tela Detalhe Pedido
    Ir Para Pedidos

    ${rows}=    Get Element Count    ${PEDIDO_ROWS}

    IF    ${rows} > 0
        Abrir Primeiro Pedido
        Validar Detalhes do Pedido

        ${body}=    Get Text    body

        IF    "Nota fiscal" in """${body}"""
            Log To Console    Botão Nota Fiscal disponível
        END

        IF    "XML Nota fiscal" in """${body}"""
            Log To Console    Botão XML disponível
        END

        IF    "Boleto" in """${body}"""
            Log To Console    Opção Boleto disponível
        END

        IF    "Comprovante de entrega" in """${body}"""
            Log To Console    Comprovante disponível
        END

    ELSE
        Skip    Cliente sem pedidos
    END

Validar Menu Acoes Pedido
    Ir Para Pedidos

    # Usando seletor CSS puro com filtro de habilitado de forma explícita
    Click    css=tbody tr button[aria-haspopup="menu"]:not([disabled]) >> nth=0

    Wait For Elements State
    ...    ${MENU_NF_PDF}
    ...    visible
    ...    10s

    ${body}=    Get Text    body

    Should Contain    ${body}    Nota Fiscal

    IF    "XML Nota Fiscal" in """${body}"""
        Log To Console    XML disponível
    END

    IF    "Boletos" in """${body}"""
        Log To Console    Boletos disponível
    END

    IF    "Comprovante de entrega" in """${body}"""
        Log To Console    Comprovante disponível
    END