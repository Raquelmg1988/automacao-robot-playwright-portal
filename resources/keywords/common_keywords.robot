*** Settings ***
Library    Browser
Resource   teams_keywords.robot

*** Keywords ***

Finalizar Suite

    Run Keyword And Ignore Error
    ...    Enviar Resultado Para Teams    ${SUITE STATUS}

    Run Keyword And Ignore Error
    ...    Close Browser



Fechar Modal Comunicado Se Existir

    ${existe}=
    ...    Run Keyword And Return Status
    ...    Wait For Elements State
    ...    text=Fechar
    ...    visible
    ...    5s

    IF    ${existe}
        Click    text=Fechar

        Run Keyword And Ignore Error
        ...    Wait For Elements State
        ...    css=div.fixed.inset-0.bg-black\/40
        ...    hidden
        ...    10s
    END


Aguardar UI Livre

    Run Keyword And Ignore Error
    ...    Wait For Elements State
    ...    css=div.fixed.inset-0.bg-black\/40
    ...    hidden
    ...    10s

    Run Keyword And Ignore Error
    ...    Wait For Elements State
    ...    css=div[role="alertdialog"]
    ...    hidden
    ...    10s

    Fechar Modal Comunicado Se Existir


Scroll To Top

    Scroll To
    ...    ${MENU_PEDIDOS}