CREATE DATABASE Exercicio_Aula_01
GO
USE Exercicio_Aula_01

CREATE TABLE Autores (
codigo_autores		INT				IDENTITY(10001,1)	NOT NULL,
nome				VARCHAR(100),
pais				VARCHAR(50),
biografia			VARCHAR(200),
PRIMARY KEY(codigo_autores));

CREATE TABLE Clientes (
codigo_clientes			INT			IDENTITY(1001,1)		NOT NULL,
nome					VARCHAR(100),
logradouro				VARCHAR(100),
numero					INT,
telefone				INT,
PRIMARY KEY(codigo_clientes));

CREATE TABLE Corredor (
codigo_corredor			INT					IDENTITY(3251,1)	NOT NULL,
tipo					VARCHAR(50),
PRIMARY KEY (codigo_corredor));

CREATE TABLE Livros (
codigo_livros			INT									NOT NULL,
cod_autor				INT									NOT NULL,
cod_corredor			INT									NOT NULL,
nome					VARCHAR(200),
pag						INT,
idioma					VARCHAR(100),
PRIMARY KEY(codigo_livros),
FOREIGN KEY(cod_autor) REFERENCES Autores(codigo_autores),
FOREIGN KEY(cod_corredor) REFERENCES Corredor(codigo_corredor));

CREATE TABLE Emprestimo (
cod_cli					INT,
data_emp				DATETIME,
cod_livro				INT,
PRIMARY KEY(cod_cli, cod_livro),
FOREIGN KEY(cod_cli) REFERENCES Clientes(codigo_clientes),
FOREIGN KEY(cod_livro) REFERENCES Livros(codigo_livros));
