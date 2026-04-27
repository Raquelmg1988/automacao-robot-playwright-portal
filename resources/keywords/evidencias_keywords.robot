*** Settings ***
Library    Browser
Library    OperatingSystem
Library    Collections

*** Keywords ***

Capturar Evidencia
    Create Directory    results/screenshots
    Take Screenshot
    Log    Screenshot capturado

Capturar Video
    ${videos}=    List Files In Directory    results/videos

    FOR    ${video}    IN    @{videos}
        Log    Video gerado: ${video}
    END

Capturar Evidencia Completa
    Capturar Evidencia
    Capturar Video

Capturar Evidencia Se Falhar
    Run Keyword If Test Failed    Run Keyword And Ignore Error    Capturar Evidencia Completa