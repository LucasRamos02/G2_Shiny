library(shiny)
library(readxl)
library(ggplot2)
library(tidyverse)

# Carregar dados e modelo no escopo global
read_excel("KC1_classlevel_numdefect.xlsx")
modelo <- lm(NUMDEFECTS ~ sumLOC_TOTAL, data = dados)

ui <- fluidPage(
  titlePanel("Previsão de Defeitos - Modelo Direto no Shiny"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("loc", "Informe sumLOC_TOTAL:", value = 1000, min = 0),
      actionButton("btn", "Prever Defeitos")
    ),
    
    mainPanel(
      verbatimTextOutput("resultado"),
      plotOutput("grafico")
    )
  )
)

server <- function(input, output) {
  
  previsao <- eventReactive(input$btn, {
    req(input$loc)
    valor <- input$loc
    pred <- predict(modelo, newdata = data.frame(sumLOC_TOTAL = valor))
    paste("Previsão de número de defeitos:", round(pred, 2))
  })
  
  output$resultado <- renderText({
    previsao()
  })
  
  output$grafico <- renderPlot({
    ggplot(dados, aes(x = sumLOC_TOTAL, y = NUMDEFECTS)) +
      geom_point(color = "blue") +
      geom_smooth(method = "lm", se = FALSE, color = "red") +
      labs(title = "Dispersão entre sumLOC_TOTAL e NUMDEFECTS")
  })
}

shinyApp(ui, server)
