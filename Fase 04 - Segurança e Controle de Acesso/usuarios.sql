SET ROLE postgres;

-- =======================================================
-- ADMIN
-- =======================================================

CREATE ROLE admin WITH LOGIN PASSWORD 'educabrasil1234' CREATEROLE NOINHERIT;

GRANT SELECT, INSERT, DELETE, UPDATE
on escola, distrito, municipio, mesorregiao, microrregiao, uf, regiao
TO admin
WITH GRANT OPTION;

SET ROLE admin;


-- =======================================================
-- Usuários criados pelo admin
-- =======================================================

-- Gerente
CREATE ROLE gerente WITH NOINHERIT;

GRANT SELECT, UPDATE
ON escola, distrito, municipio, mesorregiao, microrregiao, uf, regiao
TO gerente;

-- Diretor
CREATE ROLE diretor WITH NOINHERIT;

GRANT SELECT, INSERT
ON escola, distrito, municipio, mesorregiao, microrregiao, uf, regiao
TO diretor;

-- Cliente
CREATE ROLE cliente WITH NOINHERIT;

GRANT SELECT
ON escola, distrito, municipio, mesorregiao, microrregiao, uf, regiao
TO cliente;