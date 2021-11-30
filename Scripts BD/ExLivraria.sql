CREATE DATABASE ExLivraria
GO
USE ExLivraria

CREATE TABLE LIVRO( 
codigo_livro		INT				NOT NULL,
nome				VARCHAR(100)	NOT NULL,
lingua				VARCHAR(50)		NOT NULL		DEFAULT 'PT-BR',
ano					INT				NOT NULL		CHECK (ano > 1990),

PRIMARY KEY (codigo_livro) );

CREATE TABLE AUTOR(
codigo_autor	INT									NOT NULL,
nome			VARCHAR(100)		UNIQUE			NOT NULL,
nasc			DATE								NOT	NULL,
pais			VARCHAR(50)							NOT NULL		CHECK (pais = 'Brasil' OR pais = 'Alemanha'),
biografia		VARCHAR(255)						NOT NULL

PRIMARY KEY (codigo_autor) );

CREATE TABLE LIVRO_AUTOR(
lcodigo_livro		INT		NOT NULL,
lcodigo_autor		INT		NOT NULL
PRIMARY KEY (lcodigo_livro, lcodigo_autor),
FOREIGN KEY (lcodigo_livro) REFERENCES LIVRO(codigo_livro),
FOREIGN KEY (lcodigo_autor) REFERENCES AUTOR(codigo_autor) );

CREATE TABLE EDICOES(
isbn		INT				NOT NULL,
preco		DECIMAL(7,2)	NOT NULL			CHECK (preco > 0.0),
ano			INT				NOT NULL			CHECK (ano > 1993),
num_paginas	INT				NOT NULL			CHECK (num_paginas >= 0),
qtd_estoque	INT				NOT NULL,
PRIMARY KEY (isbn) );

CREATE TABLE EDITORA(
codigo_editora		INT							NOT NULL,
nome				VARCHAR(50)		UNIQUE		NOT NULL,
logradouro			VARCHAR(255)				NOT NULL,
numero				INT							NOT NULL	CHECK (numero >= 0),
cep					CHAR(8)						NOT NULL,
telefone			CHAR(11)					NOT NULL,
PRIMARY KEY(codigo_editora) );

CREATE TABLE LIVRO_EDICOES_EDITORA(
edicoes_isbn			INT		NOT NULL,
editora_codigo_editora	INT		NOT NULL,
livro_codigo_livro		INT		NOT NULL,
PRIMARY KEY(edicoes_isbn, editora_codigo_editora, livro_codigo_livro),
FOREIGN KEY(edicoes_isbn) REFERENCES EDICOES(isbn),
FOREIGN KEY(editora_codigo_editora) REFERENCES EDITORA(codigo_editora),
FOREIGN KEY(livro_codigo_livro) REFERENCES LIVRO(codigo_livro) );


