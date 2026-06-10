from playwright.sync_api import sync_playwright

with sync_playwright() as p:
    browser = p.chromium.launch(headless=False)

    context = browser.new_context()

    page = context.new_page()

    page.goto("https://hml.portaldocliente.grupoelfa.com.br/")

    input("Faça login completo + MFA e pressione ENTER")

    context.storage_state(path="auth_state.json")

    print("✅ auth_state.json gerado")

    browser.close()