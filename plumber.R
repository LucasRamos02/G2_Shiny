library(plumber)
library(readxl)

# Carregar dados e treinar modelo (mesmo que já fez)
read_excel("KC1_classlevel_numdefect.xlsx")
modelo <- lm(NUMDEFECTS ~ sumLOC_TOTAL, data = dados)

#* @apiTitle API de Previsão de Defeitos

#* Prever NUMDEFECTS com base no sumLOC_TOTAL
#* @param sumLOC_TOTAL Número total de linhas de código
#* @get /prever
function(sumLOC_TOTAL) {
  valor <- as.numeric(sumLOC_TOTAL)
  previsao <- predict(modelo, newdata = data.frame(sumLOC_TOTAL = valor))
  list(previsao_NUMDEFECTS = round(previsao, 2))
}
