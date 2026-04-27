*** Settings ***
Library     Browser
Library     OperatingSystem
Library     Collections
Resource    ../locators/locators.robot
Resource    login_cliente_keywords.robot
Resource    common_keywords.robot

*** Keywords ***

Ir Para Pedidos
    Wait For Load State    networkidle
    Wait For Elements State    ${MENU_PEDIDOS}    visible    30s
    Click    ${MENU_PEDIDOS}
    Wait For Elements State    ${PEDIDO_ROW}    visible    30s

Filtrar Por Status
    [Arguments]    ${status}
    Click    ${FILTRO_STATUS}
    # O "exact=True" garante que ele clique apenas em "Faturado" e ignore o "Não Faturado"
    Click    text="${status}"
    Log    Filtro por status aplicado: ${status}

Filtrar Por Periodo
    [Arguments]    ${periodo}
    Click    ${FILTRO_PERIODO}
    Click    text=${periodo}
    Log    Filtro por período aplicado: ${periodo}

Validar Lista Pedidos
    Wait For Elements State    ${PEDIDO_ROW}    visible    10s
    ${count}=    Get Element Count    ${PEDIDO_ROW}
    Run Keyword If    ${count} == 0    Fail    ❌ Nenhum pedido encontrado
    Log    Lista de pedidos carregada com ${count} itens

Abrir Primeiro Pedido
    # Força o clique na primeira célula da primeira linha para garantir a ação
    Click    ${PEDIDO_ROW} >> td >> nth=0
    # Aguarda o título da página de detalhes ou um elemento fixo
    Wait For Elements State    xpath=//h1[contains(., "Pedido")]    visible    30s
    Wait For Load State    networkidle

Baixar Nota Fiscal Primeiro Pedido
    Click    ${PEDIDO_ROW} >> nth=0 >> xpath=//button[contains(@class,"menu")]
    Wait For Elements State    ${BTN_NF_PDF}    visible    5s
    Click    ${BTN_NF_PDF}

Validar Boleto Primeiro Pedido
    Click    ${PEDIDO_ROW} >> nth=0 >> xpath=//button[contains(@class,"menu")]
    Wait For Elements State    ${BTN_BOLETO}    visible    5s

Validar Comprovante Primeiro Pedido
    Click    ${PEDIDO_ROW} >> nth=0 >> xpath=//button[contains(@class,"menu")]
    Wait For Elements State    ${BTN_COMPROVANTE}    visible    5s

Validar Detalhes do Pedido
    Wait For Elements State    text=Resumo do Pedido    visible    10s
    Wait For Elements State    text=Nota fiscal    visible    10s