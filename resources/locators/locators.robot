*** Variables ***

# =========================
# MENU
# =========================

${MENU_PEDIDOS}
...    css=a[href="/pedidos"]

# =========================
# PEDIDOS
# =========================

${BTN_ABRIR_PEDIDO}
...    css=tbody tr >> role=button

${PEDIDO_ROWS}
...    css=tbody tr

${COLUNA_STATUS}
...    xpath=//tbody/tr/td[6]

# =========================
# FILTROS
# =========================

${FILTRO_STATUS}
...    xpath=//label[contains(., 'Status')]/following::button[@role='combobox'][1]

${OPCAO_FATURADO}
...    role=option[name="Faturado"]

${OPCAO_NAO_FATURADO}
...    role=option[name="Não Faturado"]

${OPCAO_CANCELADO}
...    role=option[name="Cancelado"]

# =========================
# PERIODO
# =========================

${FILTRO_ULTIMA_SEMANA}
...    text=Última semana

${FILTRO_ULTIMO_MES}
...    text=Último mês

${BTN_APLICAR_FILTROS}
...    text=Aplicar filtros

# =========================
# DETALHE PEDIDO
# =========================

${DETALHE_PEDIDO_TITULO}
...    role=heading[name="Resumo do Pedido"]

${DETALHE_NOTA_FISCAL}
...    css=main >> text=Nota fiscal

# =========================
# CADASTRO CLIENTE
# =========================

${INPUT_EMAIL_CADASTRO}
...    css=input[type="email"]

${INPUT_CNPJ_CADASTRO}
...    css=input[name="cnpj"]

${INPUT_CELULAR_CADASTRO}
...    css=input[type="tel"]

${BTN_CONTINUAR_CADASTRO}
...    text=Continuar

${MSG_EMAIL_EXISTENTE}
...    text=E-mail já cadastrado

${MSG_CNPJ_EXISTENTE}
...    xpath=//*[contains(text(),'já possui')]

# =========================
# FORMULÁRIO DE CADASTRO - ETAPA 1
# =========================

${INPUT_NOME}
...    css=input[placeholder="Informe seu nome"]

${INPUT_SOBRENOME}
...    css=input[placeholder="Seu sobrenome"]

${INPUT_CELULAR}
...    css=input[placeholder="Seu celular"]

${INPUT_SENHA_CADASTRO}
...    css=input[type="password"] >> nth=0

${INPUT_CONFIRMAR_SENHA}
...    css=input[name="passwordConfirmation.confirmPassword"]

${BTN_CONTINUAR}
...    text=Continuar

${MARCAR_LGPD}
...    xpath=//span[contains(text(), "Estou ciente")]

# =========================
# FORMULÁRIO DE CADASTRO - ETAPA 2
# =========================

${INPUT_CNPJ}
...    css=input[placeholder="00.000.000/0000-00"]

# =========================
# MFA
# =========================

${MFA_INPUT}
...    css=input[type="text"]

# =========================
# VALIDAÇÃO DE SENHA
# =========================

${MSG_CAMPO_OBRIGATORIO}
...    css=.text-destructive >> nth=0

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

