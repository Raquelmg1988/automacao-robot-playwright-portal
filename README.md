# 🚀 Automação de Testes - Portal do Cliente

Projeto de automação de testes E2E para o Portal do Cliente, utilizando Robot Framework + Playwright, com geração de evidências (print + vídeo) e relatórios em Allure.

---

## 🧪 Tecnologias utilizadas

- Robot Framework
- Playwright (Browser Library)
- Allure Reports
- Python 3.11
- GitLab CI/CD

---

## 📁 Estrutura do Projeto
portal-do-cliente
│
├── tests # Casos de teste
├── resources
│ ├── keywords # Keywords reutilizáveis
│ ├── locators # Mapeamento de elementos
│ └── variables # Variáveis de ambiente
│
├── results # Evidências (não versionado)
├── requirements.txt
├── run_tests.ps1
└── README.md
---

## ⚙️ Pré-requisitos

- Python 3.10+
- Node.js (necessário para Playwright)
- Java (necessário para Allure)

---

## 📦 Instalação

```bash
pip install -r requirements.txt
rfbrowser init