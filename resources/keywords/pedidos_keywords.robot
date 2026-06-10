*** Settings ***
Library     Browser

Resource    ../variables_local.robot
Resource    ../locators/locators.robot
Resource    common_keywords.robot
Resource    login_cliente_keywords.robot


*** Keywords ***

Ir Para Pedidos

    Aguardar UI Livre

    Wait For Elements State
    ...    ${MENU_PEDIDOS}
    ...    visible
    ...    30s

    ${url_antes}=    Get Url
    Log To Console    URL antes: ${url_antes}

    Click    ${MENU_PEDIDOS}

    Wait For Elements State
    ...    ${PEDIDO_ROWS}
    ...    visible
    ...    30s

    ${url_depois}=    Get Url
    Log To Console    URL depois: ${url_depois}


Validar Tabela Carregada

    Wait For Elements State
    ...    ${PEDIDO_ROWS}
    ...    visible
    ...    30s

    ${rows}=    Get Element Count    ${PEDIDO_ROWS}

    Log To Console    Total linhas encontradas: ${rows}

    IF    ${rows} > 0
        Log To Console    ✅ Tabela carregada com pedidos
        RETURN
    END

    ${body}=    Get Text    body

    IF    "Nenhum pedido disponível" in """${body}"""
        Log To Console    ✅ Filtro sem resultados — comportamento esperado
        RETURN
    END

    Take Screenshot
    Fail    ❌ Falha ao carregar pedidos


Validar Lista Pedidos

    Validar Tabela Carregada

    ${rows}=    Get Element Count    ${PEDIDO_ROWS}

    IF    ${rows} == 0
        Log To Console    ⚠️ Sem pedidos para o filtro aplicado
        RETURN
    END

    Log To Console    ✅ ${rows} pedidos encontrados


Abrir Primeiro Pedido

    Validar Lista Pedidos

    ${row}=    Get Element
    ...    css=tbody tr >> nth=0

    Wait For Elements State
    ...    ${row}
    ...    visible
    ...    30s

    Click    ${row} >> button


Validar Detalhes do Pedido

    Wait For Elements State
    ...    ${DETALHE_PEDIDO_TITULO}
    ...    visible
    ...    30s

    Wait For Elements State
    ...    ${DETALHE_NOTA_FISCAL}
    ...    visible
    ...    30s


Validar Tela Detalhes

    ${url}=    Get Url
    Log To Console    URL detalhes: ${url}

    ${body}=    Get Text    main

    Should Contain    ${body}    Pedido
    Should Contain    ${body}    Nota fiscal


Filtrar Por Status
    [Arguments]    ${status}

    Aguardar UI Livre
    Scroll To Top

    Wait For Elements State
    ...    ${FILTRO_STATUS}
    ...    visible
    ...    30s

    Click    ${FILTRO_STATUS}

    Click    role=option[name="${status}"]

    Wait For Elements State
    ...    ${PEDIDO_ROWS}
    ...    visible
    ...    30s


Validar Status Na Tabela
    [Arguments]    ${status}

    ${texto}=    Get Text    ${PEDIDO_ROWS}

    Log To Console    ${texto}

    Should Contain    ${texto}    ${status}


Filtrar Por Periodo
    [Arguments]    ${periodo}

    Aguardar UI Livre

    Click    role=button[name="${periodo}"]

    Wait For Elements State
    ...    ${PEDIDO_ROWS}
    ...    visible
    ...    30s