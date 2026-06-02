library(DBI)
library(RPostgres)
library(dotenv)

load_dot_env()

source("R/db.R")
source("R/queries.R")

con <- conectar_banco()

resultado_analise_1 <- executar_analise_1(con)
print(resultado_analise_1)

resultado_analise_2 <- executar_analise_2(con)
print(resultado_analise_2)

resultado_analise_3 <- executar_analise_3(con)
print(resultado_analise_3)

resultado_analise_4 <- executar_analise_4(con)
print(resultado_analise_4)

dbDisconnect(con)
