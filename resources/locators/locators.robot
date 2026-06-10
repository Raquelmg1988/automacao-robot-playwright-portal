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
...    role=option[name=Cancelado"]

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

