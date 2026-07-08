Write-Host "Executando testes..."

# Caminho para o auth_state.json (sessao salva)
$AUTH_STATE = Join-Path $PSScriptRoot "auth_state.json"

if (!(Test-Path $AUTH_STATE)) {
    Write-Host "⚠️  auth_state.json nao encontrado. Gere a sessao via API antes (bypass de MFA):" -ForegroundColor Yellow
    Write-Host "    python gerar_auth.py" -ForegroundColor Cyan
    Write-Host "    (defina antes EMAIL_CLIENTE, SENHA_CLIENTE e QA_API_KEY no ambiente)" -ForegroundColor Cyan
    exit 1
}

if (!(Test-Path "results")) {
    New-Item -ItemType Directory -Path results | Out-Null
}

Write-Host "✅ auth_state.json encontrado. Iniciando testes..." -ForegroundColor Green

robot `
    -v AUTH_STATE_JSON:$AUTH_STATE `
    --listener allure_robotframework:results/allure-results `
    -d results `
    --exclude manual `
    tests

Write-Host "Gerando relatorio Allure..."

if (Get-Command allure -ErrorAction SilentlyContinue) {
    allure serve results/allure-results
} else {
    Write-Host "⚠️  Allure nao encontrado no PATH. Instale ou adicione ao PATH para ver o relatorio." -ForegroundColor Yellow
    Write-Host "    Resultados disponiveis em: results/" -ForegroundColor Cyan
}