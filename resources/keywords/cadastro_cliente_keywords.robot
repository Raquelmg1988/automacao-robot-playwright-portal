*** Settings ***
Library    Browser
Library    String

Resource    ../variables_local.robot
Resource    ../locators/locators.robot


*** Keywords ***

Ir Para Tela Cadastro
    Go To    ${URL}criar-conta
    Wait For Load State    load
    Wait For Elements State    ${INPUT_NOME}    visible    30s

Preencher Dados Usuario
    [Arguments]    ${nome}    ${sobrenome}    ${celular}    ${email}    ${senha}
    Fill Text    ${INPUT_NOME}    ${nome}
    Fill Text    ${INPUT_SOBRENOME}    ${sobrenome}
    Fill Text    ${INPUT_CELULAR}    ${celular}
    Fill Text    ${INPUT_EMAIL_CADASTRO}    ${email}

    # 🚀 MODIFICAÇÃO AQUI: Playwright digita simulando o teclado real
    Type Text    ${INPUT_SENHA_CADASTRO}     ${senha}
    Type Text    ${INPUT_CONFIRMAR_SENHA}    ${senha}

    Press Keys    ${INPUT_CONFIRMAR_SENHA}    Tab
    Wait For Elements State    ${BTN_CONTINUAR}    enabled    30s
    Click    ${BTN_CONTINUAR}
    Wait For Elements State    ${INPUT_CNPJ}    visible    30s

Preencher Dados Usuario Valido
    ${email}=    Gerar Email Aleatorio
    Log To Console    Email gerado: ${email}
    Preencher Dados Usuario    Raquel    Goncalves    ${CELULAR_TESTE}    ${email}    ${SENHA_TESTE}

Preencher CNPJ Novo
    ${cnpj}=    Gerar CNPJ Aleatorio
    Log To Console    CNPJ gerado: ${cnpj}
    Wait For Elements State    ${INPUT_CNPJ}    visible    30s
    Click    ${INPUT_CNPJ}
    Fill Text    ${INPUT_CNPJ}    ${cnpj}
    Press Keys    ${INPUT_CNPJ}    Tab
    Sleep    2s
    ${valor}=    Get Property    ${INPUT_CNPJ}    value
    Log To Console    CNPJ preenchido: ${valor}

Preencher CNPJ Existente
    Wait For Elements State    ${INPUT_CNPJ}    visible    30s
    Fill Text    ${INPUT_CNPJ}    ${CNPJ_EXISTENTE}

Preencher Dados Cliente
    [Arguments]    ${razao}    ${fantasia}    ${cep}
    Wait For Elements State    ${INPUT_RAZAO_SOCIAL}    visible    15s
    Fill Text    ${INPUT_RAZAO_SOCIAL}    ${razao}
    Fill Text    ${INPUT_NOME_FANTASIA}   ${fantasia}

    Click    text=Selecione um segmento
    Click    role=option[name="Clínica"]
    Sleep    1s

    Click    text=Selecione um código de segmento
    Click    role=option[name="ENSINO"]
    Sleep    1s

    Click    text=Selecione um tipo de cliente
    Click    role=option[name="ORGAOS PUBLICOS"]
    Sleep    1s

    Click    text=Selecione uma especialidade
    Click    role=option[name="FUNCIONÁRIO DO GRUPO ELFA"]
    Sleep    2s

    Fill Text    ${INPUT_FATURAMENTO_ANUAL}      1000000
    Fill Text    ${INPUT_EXPECTATIVA_COMPRA}     500000
    Fill Text    ${INPUT_CEP}    ${cep}
    Press Keys   ${INPUT_CEP}    Tab
    Sleep    3s
    Fill Text    ${INPUT_NUMERO}    123
    Wait For Elements State    ${BTN_CONTINUAR}    enabled    20s

Clicar Continuar Com Loader
    ${enabled}=    Get Property    ${BTN_CONTINUAR}    disabled
    Log To Console    BOTAO DESABILITADO? ${enabled}
    Wait For Elements State    ${BTN_CONTINUAR}    enabled    30s
    Click    ${BTN_CONTINUAR}
    Sleep    5s
    ${body}=    Get Text    body
    Log To Console    ${body}
    ${count}=    Get Element Count    xpath=//input[@type='file']
    Log To Console    TOTAL INPUTS FILE APOS CONTINUAR: ${count}
    Take Screenshot

Marcar LGPD
    Wait For Elements State    ${MARCAR_LGPD}    visible    30s
    Click    ${MARCAR_LGPD}
    ${checked}=    Get Attribute    ${MARCAR_LGPD}    aria-checked
    Should Be Equal    ${checked}    true

Anexar Documentos Cadastro
    Log To Console    INICIANDO UPLOAD

    # 🚀 CORREÇÃO DO CAMINHO FIXO: Pega rigorosamente a partir da raiz do projeto
    # Note que usamos barras normais (/) que funcionam no Windows e no Linux do GitLab
    ${cnpj_file}=      Set Variable    ${EXECDIR}/resources/files/cartao_cnpj.pdf
    ${alvara_file}=    Set Variable    ${EXECDIR}/resources/files/alvara.pdf
    ${crt_file}=       Set Variable    ${EXECDIR}/resources/files/crt.pdf

    Sleep    5s

    ${count}=    Get Element Count    xpath=//input[@type='file']
    Log To Console    TOTAL INPUT FILE ENCONTRADOS: ${count}

    Wait For Elements State    ${INPUT_UPLOAD_CNPJ}      attached    20s
    Wait For Elements State    ${INPUT_UPLOAD_ALVARA}    attached    20s

    # Executa o upload dos arquivos nos inputs ocultos do Playwright
    Upload File By Selector    ${INPUT_UPLOAD_CNPJ}      ${cnpj_file}
    Upload File By Selector    ${INPUT_UPLOAD_ALVARA}    ${alvara_file}

    # 🚀 ESSENCIAL: Aguarda o portal processar o upload dos PDFs antes de seguir
    Sleep    8s
    Take Screenshot

    ${tem_crt}=    Run Keyword And Return Status    Wait For Elements State    ${INPUT_UPLOAD_CRT}    attached    5s

    IF    ${tem_crt}
        Log To Console    CRT ENCONTRADO
        Upload File By Selector    ${INPUT_UPLOAD_CRT}    ${crt_file}
        Sleep    3s
    ELSE
        Log To Console    CRT NAO ENCONTRADO
    END

    Log To Console    DOCUMENTOS ANEXADOS
    Take Screenshot

Finalizar Cadastro

    # 1. Dá um tempo pequeno para garantir que os uploads de arquivos foram processados no back-end
    Sleep    3s

    # 2. Garante que o botão está visível e pronto para receber o clique
    Wait For Elements State    ${BTN_FINALIZAR_CADASTRO}    visible    30s

    # 3. Clica diretamente no botão usando o locator mapeado
    Click    ${BTN_FINALIZAR_CADASTRO}

    # 4. 🚀 CORREÇÃO AQUI: Aumenta o timeout para 60 segundos para suportar a lentidão do ambiente hml
    Wait For Elements State    xpath=//*[contains(text(),'Seu cadastro está em análise.')]    visible    60s
    Log To Console    ✅ Modal de análise detectado com sucesso!
    Take Screenshot

    # 5. Clica no botão "Ok" do modal rosa
    Click    xpath=//button[contains(text(),'Ok')]

    # 6. Garante que voltou para a página inicial limpa
    Get Url    ==    https://hml.portaldocliente.grupoelfa.com.br/

Preencher Codigo Validacao
    [Arguments]    ${codigo}
    Wait For Elements State    ${MFA_INPUT}    visible    30s
    Fill Text    ${MFA_INPUT}    ${codigo}

Gerar Email Aleatorio
    ${rand}=    Generate Random String    8    [LOWER]
    RETURN    teste_${rand}@mailinator.com

Gerar CNPJ Aleatorio
    ${cnpj}=    Evaluate    __import__('faker').Faker('pt_BR').cnpj()
    Log To Console    CNPJ GERADO: ${cnpj}
    RETURN    ${cnpj}
