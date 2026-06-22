*** Settings ***
Library     Browser
Library     String

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

    Click    ${MENU_PEDIDOS}

    Sleep    3s

    Limpar Filtros Pedidos


Limpar Filtros Pedidos

    Aguardar UI Livre

    ${existe}=    Run Keyword And Return Status
    ...    Get Text
    ...    text=Limpar Filtros

    IF    ${existe}
        Click    text=Limpar Filtros
        Sleep    2s
    END

Validar Tabela Carregada

    ${rows}=    Get Element Count    ${PEDIDO_ROWS}

    IF    ${rows} > 0
        Log To Console    Pedidos encontrados: ${rows}
        RETURN
    END

    ${body}=    Get Text    body

    IF    "Nenhum pedido disponível" in """${body}"""
        Log To Console    Nenhum pedido disponível para o filtro aplicado
        RETURN
    END

    Take Screenshot
    Fail    Falha ao carregar pedidos


Validar Menu Acoes Pedido
    Ir Para Pedidos

    # Localiza e clica no primeiro botão de menu da tabela que NÃO esteja desabilitado
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


Validar Lista Pedidos

    Validar Tabela Carregada


Filtrar Por Status
    [Arguments]    ${status}

    Limpar Filtros Pedidos

    Aguardar UI Livre
    Scroll To Top

    Wait For Elements State
    ...    ${FILTRO_STATUS}
    ...    visible
    ...    10s

    Click    ${FILTRO_STATUS}

    Wait For Elements State
    ...    role=option[name="${status}"]
    ...    visible
    ...    10s

    Click    role=option[name="${status}"]

    Sleep    2s


Validar Status Na Tabela
    [Arguments]    ${status}

    ${texto}=    Get Text    body

    ${texto}=     Convert To Lower Case    ${texto}
    ${status}=    Convert To Lower Case    ${status}

    Should Contain    ${texto}    ${status}


Filtrar Por Periodo
    [Arguments]    ${periodo}

    Limpar Filtros Pedidos

    Aguardar UI Livre

    Click    role=button[name="${periodo}"]

    Sleep    2s

    Validar Tabela Carregada


Abrir Primeiro Pedido

    Click
    ...    xpath=(//tbody/tr[1]//button)[last()]


Validar Detalhes do Pedido

    Wait For Elements State
    ...    ${RESUMO_PEDIDO}
    ...    visible
    ...    30s

  


