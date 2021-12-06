# Leitura de base de dados
base = read.csv('C:\\Users\\leand\\naive-bayes-r\\credit_data.csv')

# Apaga coluna client_id (não é importante)
base$clientid = NULL

# Gera estatisticas da base
summary(base)

# Muda idades inválidas para a média
base$age = ifelse(base$age < 0, mean(base$age[base$age > 0], na.rm = TRUE), base$age)

# Mudaa idades inexistentes para a média
base$age = ifelse(is.na(base$age), mean(base$age[base$age > 0], na.rm=TRUE), base$age)

# define um factor level para base
base$default = factor(base$default, levels = c(0,1))

# instalação do pacote parar dividir a base
install.packages("caTools")
library(caTools)
set.seed(1)

# cria base de treinamento com 80% da base original
divisao = sample.split(base$default, SplitRatio = 0.8)
base_treinamento = subset(base, divisao == TRUE)
# print(divisao)

# base de testes com 20%
base_testes = subset(base, divisao == FALSE)

# cria o classificador naiveBayes
library(e1071)
classificador = naiveBayes(x = base_treinamento[-4], y = base_treinamento$default)
print(classificador)

# calcula os dados com a base de testes e imprime a matriz de confusÃ£o
previsoes = predict(classificador, newdata = base_testes[-4])
matriz_confusao = table(base_testes[, 4], previsoes)
print(matriz_confusao)

# instala bibloteca para criar estatisticas
install.packages('caret')
library(caret)

# estatisticas do algoritmo de previsão
confusionMatrix(matriz_confusao)

