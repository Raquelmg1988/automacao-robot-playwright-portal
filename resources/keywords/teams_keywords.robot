*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    XML
Library    DateTime

*** Variables ***
${TEAMS_WEBHOOK}    https://defaultc7a5011d2f6e4277a9a4eb6b43903b.25.environment.api.powerplatform.com:443/powerautomate/automations/direct/workflows/fc14fe12c84d487ab124f2768e257721/triggers/manual/paths/invoke?api-version=1&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=nuDqoyAn_--bs9iB2ot1u6q0uwD4Cbkhgkcroc8BPZM

*** Keywords ***

Enviar Resultado Para Teams
    [Arguments]    ${resultado}

    Wait Until Keyword Succeeds    10x    2s    File Should Exist    ${EXECDIR}/output.xml
    Sleep    1s

    ${xml}=    Parse XML    ${EXECDIR}/output.xml

    ${tests}=    XML.Get Element Count    ${xml}    .//test
    ${passed}=   XML.Get Element Count    ${xml}    .//test/status[@status="PASS"]
    ${failed}=   XML.Get Element Count    ${xml}    .//test/status[@status="FAIL"]

    ${data}=     Get Current Date    result_format=%d/%m/%Y %H:%M:%S

    ${card}=    Create Dictionary
    ...    type=AdaptiveCard
    ...    version=1.4
    ...    msteams=Create Dictionary    width=Full
    ...    body=Create List
    ...    actions=Create List

    ${body}=    Create List
    ...    Create Dictionary    type=TextBlock    size=Large    weight=Bolder    text=🚀 Execução de Testes Automatizados - Portal do Cliente
    ...    Create Dictionary    type=TextBlock    text=📅 Data: ${data}
    ...    Create Dictionary    type=TextBlock    text=🧪 Total: ${tests}
    ...    Create Dictionary    type=TextBlock    text=✅ Sucesso: ${passed}
    ...    Create Dictionary    type=TextBlock    text=❌ Falhas: ${failed}
    ...    Create Dictionary    type=TextBlock    text=🔎 Status Final: ${resultado}

    Set To Dictionary    ${card}    body    ${body}

    ${actions}=    Create List
    ...    Create Dictionary    type=Action.OpenUrl    title=Ver Relatório    url=https://<URL_DO_SEU_RELATORIO>
    Set To Dictionary    ${card}    actions    ${actions}

    ${payload}=    Create Dictionary    type=message    attachments=Create List    Create Dictionary    contentType=application/vnd.microsoft.card.adaptive    content=${card}

    ${headers}=  Create Dictionary    Content-Type=application/json

    Create Session    teams    ${TEAMS_WEBHOOK}    verify=False

    ${response}=    POST On Session
    ...    teams
    ...    /
    ...    json=${payload}
    ...    headers=${headers}
    ...    expected_status=any

    Log To Console    \n📢 Teams Status: ${response.status_code}
    Log To Console    📢 Response: ${response.text}