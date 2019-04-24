
-- Alunos:
--     Bianca Gomes Rodrigues      743512
--     Pietro Zuntini Bonfim       743588

--- Tipos Criados

CREATE TYPE binario_t AS ENUM('Sim', 'Não', '-1');

CREATE TYPE situacao_funcionamento_t AS ENUM('Em atividade', 'Paralisada', 'Extinta', '-1');
CREATE TYPE dependencia_adm_t AS ENUM('Federal', 'Estadual', 'Municipal', 'Privada', '-1');
CREATE TYPE localizacao_t AS ENUM('Urbana', 'Rural', '-1');


--- Tabela Região

CREATE TABLE Regiao (
    co_regiao numeric(1) NOT NULL PRIMARY KEY,                                          -- Código da Região
    nome_regiao varchar(100) NOT NULL                                                   -- Nome da Região
);


--- Tabela UF

CREATE TABLE UF (
    co_uf numeric(2) NOT NULL PRIMARY KEY,                                              -- Código do UF
    nome_uf varchar(100) NOT NULL,                                                      -- Nome do UF
    sigla_uf varchar(2) NOT NULL,                                                       -- Sigla do UF

    -- Chaves Estrangeiras
    co_regiao numeric(1) NOT NULL
        REFERENCES Regiao(co_regiao)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);


--- Tabela Mesorregião

CREATE TABLE Mesorregiao (
    co_mesorregiao numeric(4) NOT NULL PRIMARY KEY,                                     -- Código da Mesorregião
    nome_mesorregiao varchar(100) NOT NULL,                                             -- Nome da Messorregião 

    -- Chaves Estrangeiras
    co_uf numeric(2) NOT NULL
        REFERENCES UF(co_uf)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);


--- Tabela Microrregião

CREATE TABLE Microrregiao (
    co_microrregiao numeric(5) NOT NULL PRIMARY KEY,                                    -- Código da Microrregião
    nome_microrregiao varchar(100) NOT NULL,                                            -- Nome da Microrregião

    -- Chaves Estrangeiras
    co_mesorregiao numeric(4) NOT NULL
        REFERENCES Mesorregiao(co_mesorregiao)
        ON DELETE RESTRICT ON UPDATE RESTRICT      
);


--- Tabela Município

CREATE TABLE Municipio (
    co_municipio numeric(7) NOT NULL PRIMARY KEY,                                       -- Código do Município
    nome_municipio varchar(100) NOT NULL,                                               -- Nome do Município
    
    -- Chaves Estrangeiras
    co_microrregiao numeric(5) NOT NULL
        REFERENCES Microrregiao(co_microrregiao)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);


--- Tabela Distrito

CREATE TABLE Distrito (
    co_distrito numeric(9) NOT NULL PRIMARY KEY,                                        -- Código do Distrito
    nome_distrito varchar(100) NOT NULL,                                                -- Nome do Distrito

    -- Chaves Estrangeiras
    co_municipio numeric(7) NOT NULL
        REFERENCES Municipio(co_municipio)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);


--- Tabela Escola

CREATE TABLE Escola (

    --- * Informações Básicas sobre a Escola
    co_escola numeric(8) NOT NULL PRIMARY KEY,                                          -- Código da Escola
    nome_escola varchar(100) NOT NULL,                                                  -- Nome da Escola
    situacao_funcionamento situacao_funcionamento_t,                                    -- Situação de Funcionamento da Escola
    inicio_ano_letivo DATE,                                                             -- Data de Início do Ano Letivo
    termino_ano_letivo DATE,                                                            -- Data de Término do Ano Letivo
    
    -- * Informações de localização
    co_distrito numeric(9) NOT NULL                                                     -- Código Completo do Distrito da Escola
        REFERENCES Distrito(co_distrito)
        ON DELETE RESTRICT ON UPDATE RESTRICT,
    localizacao localizacao_t,                                                          -- Área da Localização da Escola


    dependencia_adm dependencia_adm_t,                                                  -- Tipo de Dependência Administrativa da Escola
    regulamentada binario_t,                                                            -- Se a Escola é regulamentada ou não
    qtd_salas_existentes integer,                                                       -- Número de salas existentes na escola
    qtd_salas_utilizadas integer,                                                       -- Número de salas sendo efetivamente utilizadas na escola
    qtd_funcionarios integer,                                                           -- Número de funcionários da escola
    
    --- * Informações Adicionais sobre a Escola
    agua_filtrada binario_t,                                                            -- Se a Escola possui água filtrada ou não
    esgoto binario_t,                                                                   -- Se a Escola possui sistema de esgoto ou não
    coleta_de_lixo binario_t,                                                           -- Se a Escola possui sistema de coleta de lixo ou não
    reciclagem binario_t,                                                               -- Se a Escola possui sistema de reciclagem de lixo ou não

    --- * Informações de Dependências da Escola
    sala_diretoria binario_t,                                                           -- Se a Escola possui uma sala de diretoria ou não
    sala_professor binario_t,                                                           -- Se a Escola possui salas de professor ou não
    laboratorio_informatica binario_t,                                                  -- Se a Escola possui um laboratório de informática ou não
    laboratorio_ciencias binario_t,                                                     -- Se a Escola possui um laboratório de ciências ou não
    quadra_esportes binario_t,                                                          -- Se a Escola possui quadra de esportes ou não
    cozinha binario_t,                                                                  -- Se a Escola possui cozinha ou não
    biblioteca binario_t,                                                               -- Se a Escola possui biblioteca ou não
    sala_leitura binario_t,                                                             -- Se a Escola possui sala de leitura ou não
    parque_infantil binario_t,                                                          -- Se a Escola possui parque infantil ou não
    bercario binario_t,                                                                 -- Se a Escola possui berçário ou não
    acessibilidade_deficiencia binario_t,                                               -- Se a Escola possui dependências e vias adequadas à alunos com                                                                                                  deficiência ou mobilidade reduzida, ou não
    secretaria binario_t,                                                               -- Se a Escola possui secretaria ou não
    refeitorio binario_t,                                                               -- Se a Escola possui refeitório ou não
    alimentacao binario_t,                                                              -- Se a Escola oferece alimentação ou não
    auditorio binario_t,                                                                -- Se a Escola possui auditório ou não
    alojamento_alunos binario_t,                                                        -- Se a Escola possui alojamento para alunos ou não
    alojamento_professores binario_t,                                                   -- Se a Escola possui alojamento para professores ou não
    area_verde binario_t,                                                               -- Se a Escola possui uma área verde ou não
    internet binario_t,                                                                 -- Se a Escola possui acesso à internet ou não
    
    --- * Informações de Oferta de Matrícula
    creche binario_t,                                                                   -- Se a Escola oferece creche ou não
    pre_escola binario_t,                                                               -- Se a Escola oferece pré-escola ou não
    ens_fundamental_anos_iniciais binario_t,                                            -- Se a Escola oferece Ensino Fundamental do 1º ao 5º ano ou não
    ens_fundamental_anos_finais binario_t,                                              -- Se a Escola oferece Ensino Fundamental do 5º ao 9º ano ou não
    ens_medio_normal binario_t,                                                         -- Se a Escola oferece Ensino Médio do 1º ao 3º ano ou não
    ens_medio_integrado binario_t                                                       -- Se a Escola oferece Ensino Médio integrado com Curso Técnico ou não
    
);