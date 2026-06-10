*** Settings ***
Library    Browser

*** Test Cases ***
Teste Browser Simples
    New Browser    chromium    headless=False
    New Page       https://google.com
    Close Browser