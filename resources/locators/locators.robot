*** Variables ***

# =========================
# MENU
# =========================

${MENU_PEDIDOS}
...    css=a[href="/pedidos"]

# =========================
# PEDIDOS
# =========================

${PEDIDO_ROWS}
...    css=tbody tr

${PRIMEIRO_PEDIDO}
...    css=tbody tr >> nth=0

# =========================

# DETALHES PEDIDO
# =========================

${RESUMO_PEDIDO}
...    text=Resumo do Pedido

${DETALHE_PEDIDO_TITULO}
...    text=Resumo do Pedido

# =========================
# FILTROS
# =========================

${FILTRO_STATUS}
...    xpath=//button[contains(.,'Todos status') or contains(.,'Faturado') or contains(.,'Não Faturado') or contains(.,'Cancelado')]

${OPCAO_FATURADO}
...    role=option[name="Faturado"]

${OPCAO_NAO_FATURADO}
...    role=option[name="Não Faturado"]

${OPCAO_CANCELADO}
...    role=option[name="Cancelado"]

${BTN_LIMPAR_FILTROS}
...    text=Limpar Filtros


# =========================
# MENU AÇÕES (3 PONTINHOS)
# =========================
${MENU_ACOES_PEDIDO}    css=tbody tr >> nth=0 >> button[aria-haspopup="menu"]

${MENU_NF_PDF}
...    text=Nota Fiscal (PDF)

${MENU_XML}
...    text=XML Nota Fiscal

${MENU_BOLETOS}
...    text=Boletos

${MENU_COMPROVANTE}
...    text=Comprovante de entrega


# =========================
# DOWNLOADS (TELA DETALHE)
# =========================

${BTN_NOTA_FISCAL}
...    role=button[name="Nota fiscal"]

${BTN_XML_NOTA_FISCAL}
...    role=button[name="XML Nota fiscal"]

${BTN_BOLETO}
...    text=Boleto

${BTN_COMPROVANTE_ENTREGA}
...    text=Comprovante de entrega

${BTN_LAUDO}
...    xpath=//button[contains(@class,'underline')]



# =========================
# CADASTRO - ETAPA 1
# DADOS DO USUÁRIO
# =========================

${INPUT_NOME}
...    css=input[name="name"]

${INPUT_SOBRENOME}
...    css=input[name="surname"]

${INPUT_CELULAR}
...    css=input[name="phone"]

${INPUT_EMAIL_CADASTRO}
...    css=input[name="email"]

${INPUT_SENHA_CADASTRO}
...    css=input[name="passwordConfirmation.password"]

${INPUT_CONFIRMAR_SENHA}
...    css=input[name="passwordConfirmation.confirmPassword"]

${BTN_CONTINUAR}
...    css=button[type="submit"]


# =========================
# CADASTRO - ETAPA 2
# DADOS DO CLIENTE
# =========================

${INPUT_CNPJ}
...    css=input[placeholder="00.000.000/0000-00"]

${INPUT_RAZAO_SOCIAL}
...    css=input[placeholder="Razão Social"]

${INPUT_NOME_FANTASIA}
...    css=input[placeholder="Nome fantasia"]

${INPUT_FATURAMENTO_ANUAL}
...    css=input[name="anualIncome"]

${INPUT_EXPECTATIVA_COMPRA}
...    css=input[name="purchaseExpectancy"]

${INPUT_CEP}
...    css=input[name="cep"]

${INPUT_NUMERO}
...    css=input[name="number"]

${MARCAR_LGPD}
...    id=privacy-and-lgpd


# =========================
# COMBOS CADASTRO CLIENTE
# =========================

${COMBO_SEGMENTO}
...    text=Selecione um segmento

${COMBO_CODIGO_SEGMENTO}
...    text=Selecione um código de segmento

${COMBO_TIPO_CLIENTE}
...    text=Selecione um tipo de cliente

${COMBO_ESPECIALIDADE}
...    text=Selecione uma especialidade

${OPCAO_CLINICA}
...    role=option[name="Clínica"]

${OPCAO_ENSINO}
...    role=option[name="ENSINO"]

${OPCAO_ORGAOS_PUBLICOS}
...    role=option[name="ORGAOS PUBLICOS"]

${OPCAO_FUNCIONARIO_ELFA}
...    role=option[name="FUNCIONÁRIO DO GRUPO ELFA"]


# =========================
# DOCUMENTOS
# =========================

${INPUT_UPLOAD_CNPJ}     xpath=(//input[@type='file'])[1]

${INPUT_UPLOAD_ALVARA}     xpath=(//input[@type='file'])[2]

${INPUT_UPLOAD_CRT}     xpath=(//input[@type='file'])[3]

${BTN_FINALIZAR_CADASTRO}     text=Finalizar cadastro


# =========================
# MFA
# =========================

${MFA_INPUT}
...    css=input[type="text"]


# =========================
# MENSAGENS DE VALIDAÇÃO
# =========================

${MSG_EMAIL_EXISTENTE}    text=Já existe um usuário cadastrado com este e-mail

${MSG_CNPJ_EXISTENTE}
...    xpath=//*[contains(text(),'já possui')]

${MSG_CAMPO_OBRIGATORIO}
...    css=.text-destructive >> nth=0

${MSG_CADASTRO_ANALISE}    xpath=//*[contains(text(),'Seu cadastro está em análise')]


# =========================
# REGRAS DE SENHA
# =========================

${REGRA_SENHA_MIN}
...    text=Mínimo de 8 caracteres

${REGRA_SENHA_MINUSCULA}
...    text=Uma letra minúscula

${REGRA_SENHA_MAIUSCULA}
...    text=Uma letra maiúscula

${REGRA_SENHA_NUMERO}
...    text=Um número

${REGRA_SENHA_ESPECIAL}
...    text=Um caractere especial