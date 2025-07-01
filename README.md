# 📊 G2 - Análise Estatística e Modelagem Preditiva com Aplicação Web em Shiny

Trabalho da disciplina **Análise Estatística e Modelagem Preditiva com Aplicação Web em Shiny**.

---

## ✅ Objetivos

- Realizar análise estatística descritiva e inferencial em um dataset de software orientado a objetos.
- Criar um modelo de **regressão linear** para prever o número de defeitos (NUMDEFECTS).
- Construir uma **API REST** com `plumber`.
- Desenvolver uma aplicação **interativa com Shiny** e publicar online.
- Organizar e documentar todo o processo em um repositório GitHub.

---

## 📁 Arquivos no Repositório

| Arquivo | Descrição |
|--------|-----------|
| `app.R` | Código da aplicação web Shiny. Permite inserir métricas e prever o número de defeitos. |
| `plumber.R` | API REST construída com o pacote `plumber`, que retorna a previsão do modelo. |
| `analise.R` | Script com a análise estatística descritiva, testes de normalidade, correlações e regressão linear. |
| `KC1_classlevel_numdefect.xlsx` | Dataset original utilizado na análise, contendo métricas de qualidade de software por classe. |

---

## 🌐 Aplicação Shiny Online

A aplicação está publicada e disponível em:

🔗 [https://lucasramos.shinyapps.io/g2_shiny/](https://lucasramos.shinyapps.io/g2_shiny/)

Funcionalidades:

- Inserção de valores de entrada para `sumLOC_TOTAL`
- Previsão de `NUMDEFECTS` usando o modelo de regressão
- Visualização de gráficos de dispersão, boxplots e histogramas

---

## 🔌 API REST (Plumber)

A API REST foi testada **localmente** com o pacote `plumber`.  
Ela aceita valores via GET e retorna a previsão de `NUMDEFECTS`.

### Exemplo de uso local:

```r
# No RStudio:
library(plumber)
pr <- plumb("plumber.R")
pr$run(port = 8000)
