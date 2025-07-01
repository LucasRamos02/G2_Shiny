# Instalar os pacotes necessários (só na primeira vez)
install.packages(c("tidyverse", "readxl", "PerformanceAnalytics", "ggpubr", "plumber", "shiny"))

# Carregar pacotes
library(tidyverse)
library(readxl)

# Ler o dataset (ele está na mesma pasta do projeto!)
library(readxl)
read_excel("KC1_classlevel_numdefect.xlsx")


# Ver as primeiras linhas e estrutura dos dados
head(dados)
glimpse(dados)

# Estatísticas descritivas principais
summary(dados)

# Estatísticas mais completas para variáveis numéricas
# Estatísticas com NA removidos
dados %>% 
  summarise(across(where(is.numeric), list(
    media = ~mean(., na.rm = TRUE),
    mediana = ~median(., na.rm = TRUE),
    desvio = ~sd(., na.rm = TRUE),
    minimo = ~min(., na.rm = TRUE),
    maximo = ~max(., na.rm = TRUE),
    amplitude = ~max(., na.rm = TRUE) - min(., na.rm = TRUE)
  ), .names = "{.col}_{.fn}"))

# Função para calcular moda
moda <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

# Moda para cada variável numérica
sapply(dados %>% select(where(is.numeric)), moda)


# Instalar e carregar ggplot2 e ggpubr caso não tenha
library(ggplot2)
library(ggpubr)

# Histogramas com curva de densidade
dados %>%
  pivot_longer(cols = where(is.numeric)) %>%
  ggplot(aes(x = value)) +
  facet_wrap(~name, scales = "free") +
  geom_histogram(aes(y = ..density..), fill = "skyblue", bins = 30) +
  geom_density(color = "red", size = 1) +
  labs(title = "Histogramas com Curva de Densidade")

# Teste de normalidade para cada variável numérica
normalidade <- dados %>%
  select(where(is.numeric)) %>%
  summarise(across(everything(), ~shapiro.test(.)$p.value))

print(normalidade)

# Boxplots
dados %>%
  pivot_longer(cols = where(is.numeric)) %>%
  ggplot(aes(y = value, x = name)) +
  geom_boxplot(fill = "lightgreen") +
  coord_flip() +
  labs(title = "Boxplots das Variáveis")

# Carregar pacote necessário
library(PerformanceAnalytics)

# Selecionar apenas variáveis numéricas
dados_numericos <- dados %>% select(where(is.numeric))

# Matriz de correlação com gráficos
chart.Correlation(dados_numericos, histogram = TRUE, pch = 19)

# Correlação entre variáveis
matriz_cor <- cor(dados_numericos, use = "complete.obs")

# Ordenar pela correlação com NUMDEFECTS
sort(matriz_cor["NUMDEFECTS", ], decreasing = TRUE)

# Gráfico de dispersão com linha de tendência
ggplot(dados, aes(x = LOC, y = NUMDEFECTS)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Dispersão entre LOC e NUMDEFECTS")

ggplot(dados, aes(x = sumLOC_TOTAL, y = NUMDEFECTS)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Dispersão entre sumLOC_TOTAL e NUMDEFECTS")

modelo <- lm(NUMDEFECTS ~ sumLOC_TOTAL, data = dados)
summary(modelo)

par(mfrow = c(2, 2))
plot(modelo)
