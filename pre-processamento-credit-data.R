base = read.csv('C:\\Users\\leand\\naive-bayes-r\\credit_data.csv')
base$clientid = NULL
summary(base)

idadeInvalida = base[base$age < 18 & !is.na(base$age), 1:3]

# apagar a coluna inteira (não é muito recomendável)
# base$age = NULL

# apagar somente os registros com problemas.
# base = base[base$age > 0, ]

# preencher os dados manualmente

# calcular a média da idade
mean(base$age , na.rm = TRUE)
mean(base$age[base$age > 0], na.rm = TRUE)
# base$age[base$age < 0] = mean(base$age[base$age > 0], na.rm = TRUE)
base$age = ifelse(base$age < 0, mean(base$age[base$age > 0], na.rm = TRUE), base$age)

base$age = ifelse(is.na(base$age), mean(base$age[base$age > 0], na.rm=TRUE), base$age)

base[, 1:3] = scale(base[, 1:3])
summary(base)

install.packages("caTools")
library(caTools)
set.seed(1)
divisao = sample.split(base$default, SplitRatio = 0.75)
base_treinamento = subset(base, divisao == TRUE)

base_testes = subset(base, divisao == FALSE)


