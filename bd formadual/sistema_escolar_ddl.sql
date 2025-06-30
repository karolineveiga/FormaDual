-- Criação do Banco de Dados
CREATE DATABASE Sistema_Escolar;

-- Conectando ao banco de dados
\c Sistema_Escolar;

-- ==========================
-- Tabelas Independentes
-- ==========================

-- Tabela: Professor
CREATE TABLE Professor (
    id_professor SERIAL PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20),
    habilidades TEXT,
    certificacoes TEXT
);

-- Tabela: Responsavel
CREATE TABLE Responsavel (
    id_responsavel SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    permissao VARCHAR(50),
    situacao_financeira VARCHAR(15) DEFAULT 'Regular'
);

-- Tabela: Usuario
CREATE TABLE Usuario (
    id_usuario SERIAL PRIMARY KEY,
    login VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    tipo_usuario VARCHAR(20) NOT NULL,
    id_professor INT,
    id_responsavel INT,
    FOREIGN KEY (id_professor) REFERENCES Professor(id_professor),
    FOREIGN KEY (id_responsavel) REFERENCES Responsavel(id_responsavel)
);

-- Tabela: Turma
CREATE TABLE Turma (
    id_turma SERIAL PRIMARY KEY,
    nome_turma VARCHAR(100) NOT NULL,
    horario VARCHAR(100),
    local VARCHAR(100),
    id_professor INT,
    FOREIGN KEY (id_professor) REFERENCES Professor(id_professor)
);

-- Tabela: Aluno
CREATE TABLE Aluno (
    id_aluno SERIAL PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    data_nascimento DATE,
    id_turma INT,
    id_responsavel INT,
    observacoes TEXT,
    status_financeiro VARCHAR(15) DEFAULT 'Regular',
    FOREIGN KEY (id_turma) REFERENCES Turma(id_turma),
    FOREIGN KEY (id_responsavel) REFERENCES Responsavel(id_responsavel)
);

-- ==========================
-- Demais Tabelas Relacionadas
-- ==========================

-- Tabela: Presenca
CREATE TABLE Presenca (
    id_presenca SERIAL PRIMARY KEY,
    id_aluno INT,
    data DATE,
    presente BOOLEAN,
    FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno)
);

-- Tabela: Pagamento
CREATE TABLE Pagamento (
    id_pagamento SERIAL PRIMARY KEY,
    id_aluno INT,
    data_pagamento DATE,
    valor NUMERIC(10,2),
    forma_pagamento VARCHAR(50),
    referencia VARCHAR(100),
    status VARCHAR(20),
    tipo VARCHAR(50),
    FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno)
);

-- Tabela: Caixa
CREATE TABLE Caixa (
    id_caixa SERIAL PRIMARY KEY,
    id_usuario INT,
    data_abertura TIMESTAMP,
    saldo_inicial NUMERIC(10,2),
    data_fechamento TIMESTAMP,
    saldo_final NUMERIC(10,2),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Tabela: Log_Sistema
CREATE TABLE Log_Sistema (
    id_log SERIAL PRIMARY KEY,
    id_usuario INT,
    data_hora TIMESTAMP,
    tipo_acao VARCHAR(100),
    entidade_afetada VARCHAR(100),
    descricao TEXT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Tabela: Cardapio
CREATE TABLE Cardapio (
    id_cardapio SERIAL PRIMARY KEY,
    data DATE,
    turno VARCHAR(20),
    titulo VARCHAR(150),
    id_turma INT,
    FOREIGN KEY (id_turma) REFERENCES Turma(id_turma)
);

-- Tabela: Item_Cardapio
CREATE TABLE Item_Cardapio (
    id_item SERIAL PRIMARY KEY,
    id_cardapio INT,
    descricao VARCHAR(255),
    FOREIGN KEY (id_cardapio) REFERENCES Cardapio(id_cardapio)
);

-- Tabela: Tag_Atencao
CREATE TABLE Tag_Atencao (
    id_tag SERIAL PRIMARY KEY,
    id_aluno INT,
    tipo VARCHAR(100),
    descricao TEXT,
    FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno)
);

-- Tabela: Evento
CREATE TABLE Evento (
    id_evento SERIAL PRIMARY KEY,
    titulo VARCHAR(150),
    descricao TEXT,
    data_inicio TIMESTAMP,
    data_fim TIMESTAMP,
    publico VARCHAR(100),
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Tabela: Material
CREATE TABLE Material (
    id_material SERIAL PRIMARY KEY,
    titulo VARCHAR(150),
    descricao TEXT,
    data_upload TIMESTAMP,
    tipo VARCHAR(100),
    url VARCHAR(255),
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Tabela: Horario
CREATE TABLE Horario (
    id_horario SERIAL PRIMARY KEY,
    id_turma INT,
    dia_semana VARCHAR(20),
    horario_inicio TIME,
    horario_fim TIME,
    FOREIGN KEY (id_turma) REFERENCES Turma(id_turma)
);

-- Tabela: Comunicado
CREATE TABLE Comunicado (
    id_comunicado SERIAL PRIMARY KEY,
    titulo VARCHAR(150),
    descricao TEXT,
    data_envio TIMESTAMP,
    publico VARCHAR(100),
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Tabela: Relatorio
CREATE TABLE Relatorio (
    id_relatorio SERIAL PRIMARY KEY,
    tipo VARCHAR(100),
    periodo VARCHAR(100),
    data_geracao TIMESTAMP,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Tabela: Fa_Coin
CREATE TABLE Fa_Coin (
    id_coin SERIAL PRIMARY KEY,
    id_responsavel INT,
    origem VARCHAR(100),
    valor NUMERIC(10,2),
    data_credito DATE,
    motivo TEXT,
    FOREIGN KEY (id_responsavel) REFERENCES Responsavel(id_responsavel)
);

-- Tabela: Atividade
CREATE TABLE Atividade (
    id_atividade SERIAL PRIMARY KEY,
    descricao TEXT,
    data_realizacao DATE
);

-- Tabela: Atividade_Aluno
CREATE TABLE Atividade_Aluno (
    id_atividade INT,
    id_aluno INT,
    PRIMARY KEY (id_atividade, id_aluno),
    FOREIGN KEY (id_atividade) REFERENCES Atividade(id_atividade),
    FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno)
);
