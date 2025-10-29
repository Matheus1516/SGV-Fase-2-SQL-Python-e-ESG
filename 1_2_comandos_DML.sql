----------------------------------------------------
-- FIAP - START DATA MANAGEMENT - FASE 2
-- Grupo 75 - Aquiles Vitor da Silva
-- 1_2_comandos_DML.sql
----------------------------------------------------


-- a.1) Inserindo cliente "pessoa fisica" (tabela MC_CLIENTE)
INSERT INTO MC_CLIENTE (NM_CLIENTE, QT_ESTRELAS, VL_MEDIO_COMPRA, ST_CLIENTE, DS_EMAIL, NR_TELEFONE, NM_LOGIN, DS_SENHA) 
    VALUES ('Carlos Silva', 4, 350.00, 'A', 'carlos.silva@email.com', '11987654321', 'carlos_silva', 'senha123');

-- Cliente pessoa física (dados complementares)(TABELA MC_CLI_FISICA)
INSERT INTO MC_CLI_FISICA (NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, DS_GENERO, NR_CPF) 
    VALUES ((SELECT NR_CLIENTE FROM MC_CLIENTE WHERE NM_LOGIN = 'carlos_silva'), TO_DATE('15/06/1995','DD/MM/YYYY'), 'M', 'Masculino', '04134283892');

-- Endereço do cliente físico (TABELA_MC_END_CLI)
INSERT INTO MC_END_CLI (NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, DS_COMPLEMENTO_END, DT_INICIO, DT_TERMINO, ST_END) 
VALUES ((SELECT NR_CLIENTE FROM MC_CLIENTE WHERE NM_LOGIN = 'carlos_silva'),1, 120, 'Apartamento 15', TO_DATE('10/04/2024','DD/MM/YYYY'), NULL, 'A');


-- a.2) Inserindo cliente "pessoa jurídica" (TABELA MC_CLI_JURIDICA)
INSERT INTO MC_CLIENTE (NM_CLIENTE, QT_ESTRELAS, VL_MEDIO_COMPRA, ST_CLIENTE, DS_EMAIL, NR_TELEFONE, NM_LOGIN, DS_SENHA) 
    VALUES ('TechStore LTDA', 5, 1200.00, 'A', 'contato@techstore.com', '11997113837', 'techstore', 'senha123');

-- Cliente pessoa jurídica (dados complementares)(TABELA MC_CLI_JURIDICA)
INSERT INTO MC_CLI_JURIDICA (NR_CLIENTE, DT_FUNDACAO, NR_CNPJ, NR_INSCR_EST) 
    VALUES ((SELECT NR_CLIENTE FROM MC_CLIENTE WHERE NM_LOGIN = 'techstore'), TO_DATE('20/02/2015','DD/MM/YYYY'), '89892443000148', NULL);

-- Endereço do cliente jurídico(TABELA MC_CLI_JURIDICA)
INSERT INTO MC_END_CLI (NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, DS_COMPLEMENTO_END, DT_INICIO, DT_TERMINO, ST_END) 
    VALUES ((SELECT NR_CLIENTE FROM MC_CLIENTE WHERE NM_LOGIN = 'techstore'), 2, 300, 'Sala 05', TO_DATE('05/05/2024','DD/MM/YYYY'), NULL, 'A');



-- b) Tentativa de cliente com login duplicado
INSERT INTO MC_CLIENTE (NM_CLIENTE, QT_ESTRELAS, VL_MEDIO_COMPRA, ST_CLIENTE, DS_EMAIL, NR_TELEFONE, NM_LOGIN, DS_SENHA) 
    VALUES ('Carlos Silva 2', 3, 250.00, 'A', 'carlos.silva2@email.com', '11988887777', 'carlos_silva', 'senha456');



-- c) Atualizando cargo e aplicando 12% de aumento de salário
UPDATE MC_FUNCIONARIO
SET DS_CARGO = 'Gerente Financeiro',
    VL_SALARIO = VL_SALARIO * 1.12
WHERE CD_FUNCIONARIO = 4;

-- Verificar resultado
SELECT CD_FUNCIONARIO, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO 
FROM MC_FUNCIONARIO
WHERE CD_FUNCIONARIO = 4;



-- d) Inativando endereço e preenchendo data de término
UPDATE MC_END_CLI
SET ST_END = 'I',
    DT_TERMINO = TO_DATE('14/10/2025','DD/MM/YYYY')
WHERE NR_CLIENTE = (SELECT NR_CLIENTE FROM MC_CLIENTE WHERE NM_LOGIN = 'carlos_silva');

-- Verificar resultado
SELECT NR_CLIENTE, ST_END, DT_INICIO, DT_TERMINO
FROM MC_END_CLI
WHERE NR_CLIENTE = (SELECT NR_CLIENTE FROM MC_CLIENTE WHERE NM_LOGIN = 'carlos_silva');



-- e) Tentando excluir um estado que possui cidade cadastrada
DELETE FROM MC_ESTADO WHERE SG_ESTADO = 'SP';



-- f) Tentando atualizar produto com status inválido 'X'
UPDATE MC_PRODUTO
SET ST_PRODUTO = 'X'
WHERE CD_PRODUTO = 1;



-- g) Confirmando todas as transações pendentes
COMMIT;
