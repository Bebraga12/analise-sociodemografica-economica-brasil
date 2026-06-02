executar_analise_1 <- function(con) {
  query <- "
  SELECT
      uf,
      populacao_residente_pessoas_2022,
      area_territorial_km2_2022,
      populacao_residente_pessoas_2022 / area_territorial_km2_2022 AS densidade_calculada
  FROM
      estados
  ORDER BY
      densidade_calculada DESC;
  "

  resultado <- dbGetQuery(con, query)

  return(resultado)
}

executar_analise_2 <- function(con) {
  query <- "
  SELECT
      CASE
          WHEN idh_indice_desenvolvimento_humano_2021 >= 0.760 THEN 'IDH alto'
          WHEN idh_indice_desenvolvimento_humano_2021 >= 0.700 THEN 'IDH médio'
          ELSE 'IDH baixo'
      END AS faixa_idh,
      AVG(rendimento_mensal_domiciliar_per_capita_rs_2023) AS media_rendimento,
      SUM(populacao_residente_pessoas_2022) AS populacao_total,
      COUNT(*) AS quantidade_estados
  FROM
      estados
  GROUP BY
      faixa_idh
  ORDER BY
      media_rendimento DESC;
  "

  resultado <- dbGetQuery(con, query)

  return(resultado)
}

executar_analise_3 <- function(con) {
  query <- "
  SELECT
      uf,
      idh_indice_desenvolvimento_humano_2021
  FROM
      estados
  WHERE
      idh_indice_desenvolvimento_humano_2021 > (
          SELECT
              AVG(idh_indice_desenvolvimento_humano_2021)
          FROM
              estados
      )
  ORDER BY
      idh_indice_desenvolvimento_humano_2021 DESC;
  "

  resultado <- dbGetQuery(con, query)

  return(resultado)
}

executar_analise_4 <- function(con) {
  query <- "
  SELECT
      uf,
      rendimento_mensal_domiciliar_per_capita_rs_2023,
      idh_indice_desenvolvimento_humano_2021
  FROM
      estados
  WHERE
      (
          rendimento_mensal_domiciliar_per_capita_rs_2023 < 1500
          OR idh_indice_desenvolvimento_humano_2021 < 0.700
      )
      AND NOT uf = 'Distrito Federal'
  ORDER BY
      rendimento_mensal_domiciliar_per_capita_rs_2023 ASC;
  "

  resultado <- dbGetQuery(con, query)

  return(resultado)
}
