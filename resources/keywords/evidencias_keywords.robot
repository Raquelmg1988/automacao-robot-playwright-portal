*** Settings ***
Library    Browser
Library    OperatingSystem
Library    Collections

*** Keywords ***

Capturar Evidencia
    # Ajustado com ${EXECDIR} para salvar na raiz correta do projeto
    Create Directory    ${EXECDIR}/results/screenshots
    Take Screenshot     filename=${EXECDIR}/results/screenshots/{index}-{test_name}
    Log    Screenshot capturado

Capturar Video
    # Verifica se a pasta existe antes de listar, evitando erros se não houver vídeos
    ${pasta_existe}=    Run Keyword And Return Status    Directory Should Exist    ${EXECDIR}/results/videos
    
    IF    ${pasta_existe}
        ${videos} =    List Files In Directory    ${EXECDIR}/results/videos
        FOR    ${video}    IN    @{videos}
            Log    Video gerado: ${video}
        END
    END


Capturar Evidencia Completa
    Capturar Evidencia
    Capturar Video

Capturar Evidencia Se Falhar
    Run Keyword If Test Failed    Run Keyword And Ignore Error    Capturar Evidencia Completa
