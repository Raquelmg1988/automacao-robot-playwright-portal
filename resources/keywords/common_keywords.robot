*** Settings ***
Library    Browser
Resource   teams_keywords.robot

*** Keywords ***

Aguardar Loading Sumir
    Run Keyword And Ignore Error
    ...    Wait For Elements State    css=.fixed.inset-0    hidden    20s


Finalizar Suite
    Run Keyword And Ignore Error
    ...    teams_keywords.Enviar Resultado Para Teams    ${SUITE STATUS}

    Close Browser