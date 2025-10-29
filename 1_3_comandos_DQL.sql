-- Consulta de produtos e suas categorias (tabelas MC_CATEGORIA_PROD e MC_PRODUTO)
SELECT C.CD_CATEGORIA       AS "CÓD. CATEGORIA", 
      C.DS_CATEGORIA        AS "CATEGORIA", 
      P.CD_PRODUTO          AS "CÓD. PRODUTO", 
      P.DS_PRODUTO          AS "DESC. PRODUTO", 
      P.VL_UNITARIO         AS "VALOR UNITÁRIO", 
      P.TP_EMBALAGEM        AS "TIPO EMBALAGEM", 
      P.VL_PERC_LUCRO       AS "LUCRO"
    FROM MC_CATEGORIA_PROD C LEFT OUTER JOIN MC_PRODUTO P
     ON (C.CD_CATEGORIA = P.CD_CATEGORIA)
    ORDER BY DS_CATEGORIA ASC, DS_PRODUTO ASC;

-- Consulta de clientes pessoas físicas (tabelas MC_CLIENTE e MC_CLI_FISICA)
SELECT
    F.NR_CLIENTE                 AS "CÓDIGO",
    C.NM_CLIENTE                 AS "NOME",
    C.DS_EMAIL                   AS "E-MAIL",
    C.NR_TELEFONE                AS "TELEFONE",
    C.NM_LOGIN                   AS "LOGIN",
    TO_CHAR(F.DT_NASCIMENTO, 'DD/MM/YYYY')                  AS "DATA NASCIMENTO",
    TO_CHAR(F.DT_NASCIMENTO,'D')                            AS "DIA SEMANA NASC",
    TRUNC(MONTHS_BETWEEN(SYSDATE, F.DT_NASCIMENTO)/12)      AS "IDADE",
    F.FL_SEXO_BIOLOGICO          AS "SEXO BIOLÓGICO",
    F.NR_CPF                     AS "CPF"
    FROM MC_CLIENTE C INNER JOIN MC_CLI_FISICA F
        ON (F.NR_CLIENTE = C.NR_CLIENTE);

-- Consulta de visualização de vídeos dos produtos (tabelas MC_PRODUTO MC_SGV_VISUALIZACAO_VIDEO)
SELECT
    V.CD_PRODUTO        AS "CÓDIGO PRODUTO",
    P.DS_PRODUTO        AS "DESCRIÇÃO PRODUTO",
    TO_CHAR(V.DT_VISUALIZACAO, 'DD/MM/YYYY') || ' ' ||
    LPAD(V.NR_HORA_VISUALIZACAO,2,'0') || ':' ||
    LPAD(V.NR_MINUTO_VIDEO,2,'0') || ':' ||
    LPAD(V.NR_SEGUNDO_VIDEO,2,'0') AS "DATA E HORA DE VISUALIZAÇÃO"
    FROM MC_PRODUTO P INNER JOIN MC_SGV_VISUALIZACAO_VIDEO V
        ON (P.CD_PRODUTO = V.CD_PRODUTO)
    ORDER BY DT_VISUALIZACAO DESC;