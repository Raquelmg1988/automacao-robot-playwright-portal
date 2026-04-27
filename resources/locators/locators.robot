*** Variables ***

# LOGIN
${INPUT_EMAIL}           css=input[placeholder="Informe seu e-mail"]
${INPUT_SENHA}           css=input[placeholder="Digite sua senha"]
${BTN_ENTRAR}            xpath=//button[text()="Entrar"]

# MFA 
${MFA_INPUT}             css=input[type="text"]
${MFA_BTN_VALIDAR}       xpath=//button[text()="Validar código"]
${MFA_BTN_CANCELAR}      xpath=//button[text()="Cancelar"]
${MFA_REENVIAR}          xpath=//button[text()="Reenviar o código"]
${MFA_MSG_ERRO}          css=.mfa-error-message

# HOME / DASHBOARD
${HOME_PAGE_SELECTOR}    xpath=//a[contains(text(), "Pedidos")]

# MENU / PEDIDOS
${MENU_PEDIDOS}          xpath=//a[@href="/pedidos"]
# Seleciona o botão de status especificamente dentro da área de filtros
${FILTRO_STATUS}         xpath=//button[@role="combobox" and contains(., "status")]
${FILTRO_PERIODO}        xpath=//button[@role="combobox" and contains(., "período")]
${PEDIDO_ROW}            css=tr >> nth=1
${BTN_NF_PDF}            xpath=//div[text()="Nota fiscal"]
${BTN_BOLETO}            xpath=//div[text()="Boleto"]
${BTN_COMPROVANTE}       xpath=//div[text()="Comprovante de entrega"]

# MENSAGENS
${MSG_ERRO}                  text=Usuário ou senha inválidos
${MSG_ERRO_EMAIL}            text=Informe um e-mail válido
${MSG_ERRO_CELULAR}          text=Informe um número válido
${MSG_CAMPO_OBRIGATORIO}     css=.text-destructive >> nth=0
${MSG_EMAIL_EXISTENTE}       text=Já existe um usuário cadastrado com este e-mail
${MSG_ERRO_TOAST}            text=Oops! Parece que encontramos um problema

# REGRAS SENHA
${REGRA_SENHA_MIN}        text=Mínimo de 8 caracteres
${REGRA_SENHA_MINUSCULA}  text=Uma letra minúscula
${REGRA_SENHA_MAIUSCULA}  text=Uma letra maiúscula
${REGRA_SENHA_NUMERO}     text=Um número
${REGRA_SENHA_ESPECIAL}   text=Um caractere especial

# CADASTRO
${INPUT_NOME}                 css=input[placeholder="Informe seu nome"]
${INPUT_SOBRENOME}            css=input[placeholder="Seu sobrenome"]
${INPUT_CELULAR}              css=input[placeholder="Seu celular"]
${INPUT_EMAIL_CADASTRO}       css=input[name="email"]
${INPUT_SENHA_CADASTRO}       css=input[type="password"] >> nth=0
${INPUT_CONFIRMAR_SENHA}      css=input[name="passwordConfirmation.confirmPassword"]

# CADASTRO ETAPA 2
${INPUT_CNPJ}                css=input[placeholder="00.000.000/0000-00"]
${INPUT_CEP}                 id=cep
${INPUT_ESTADO}              id=estado
${INPUT_FATURAMENTO}         id=faturamento

# BOTÕES E TÍTULOS
${BTN_CONTINUAR}              text=Continuar
${BTN_CANCELAR}               xpath=//button[text()="Cancelar"]
${BTN_CRIAR_CONTA}            xpath=//a[contains(text(), "cadastre-se aqui")]
${CADASTRO_TITULO}            xpath=//h1[contains(text(), "Faça seu cadastro")]
${MARCAR_LGPD}                xpath=//span[contains(text(), "Estou ciente")]
