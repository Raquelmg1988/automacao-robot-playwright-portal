Write-Host "Executando testes..."

# Caminho para o auth_state.json (sessao salva)
$AUTH_STATE = Join-Path $PSScriptRoot "auth_state.json"

if (!(Test-Path $AUTH_STATE)) {
    Write-Host "⚠️  auth_state.json nao encontrado. Execute o teste de geracao de sessao antes." -ForegroundColor Yellow
    Write-Host "    robot -d results tests/tests_gerar_sessao.robot" -ForegroundColor Cyan
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