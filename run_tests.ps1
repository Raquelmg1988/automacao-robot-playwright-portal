Write-Host "Executando testes..."

if (!(Test-Path "results")) {
    New-Item -ItemType Directory -Path results
}

robot --listener allure_robotframework `
      -d results `
      tests

Write-Host "Gerando relatorio Allure..."

allure serve results/allure-results

#Remove-Item -Recurse -Force results -ErrorAction SilentlyContinue