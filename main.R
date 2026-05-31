library(DBI)
library(odbc)
library(dotenv)

load_dot_env()

con <- dbConnect(
  odbc(),
  Driver = "ODBC Driver 18 for SQL Server",
  Server = Sys.getenv("AZURE_SQL_SERVER"),
  Database = Sys.getenv("AZURE_SQL_DATABASE"),
  UID = Sys.getenv("AZURE_SQL_USER"),
  PWD = Sys.getenv("AZURE_SQL_PASSWORD"),
  Port = as.integer(Sys.getenv("AZURE_SQL_PORT")),
  Encrypt = Sys.getenv("AZURE_SQL_ENCRYPT"),
  TrustServerCertificate = Sys.getenv("AZURE_SQL_TRUST_SERVER_CERTIFICATE")
)

resultado <- dbGetQuery(con, "
SELECT
    1 AS teste;
")

print(resultado)

dbDisconnect(con)
