from playwright.sync_api import sync_playwright
import time

with sync_playwright() as p:
    # 1. Abre o navegador visível para você interagir
    browser = p.chromium.launch(headless=False)
    context = browser.new_context()
    page = context.new_page()

    # 2. Navega para o portal do cliente
    page.goto("https://hml.portaldocliente.grupoelfa.com.br/")

    # 3. Pausa para você colocar e-mail, senha e o código do celular (MFA)
    input("👉 Faça o login completo com MFA. Quando estiver na Dashboard, volte aqui no terminal e aperte ENTER...")

    # 4. Aguarda os tokens do Azure AD assentarem no navegador
    print("Aguardando 5 segundos para consolidar os tokens da Microsoft...")
    time.sleep(5) 

    # 5. Salva o arquivo completo com os acessos válidos
    context.storage_state(path="auth_state.json")
    print("✅ auth_state.json gerado com sucesso!")

    browser.close()
