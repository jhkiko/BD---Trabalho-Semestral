CREATE DATABASE Faculdade
GO
USE Faculdade

CREATE TABLE ALUNO(
ra			INT				IDENTITY(12345,1)		NOT NULL,
nome		VARCHAR(100)							NOT NULL,
sobrenome	VARCHAR(100)							NOT NULL,
rua			VARCHAR(200)							NOT NULL,
numero		INT										NOT NULL,	
bairro		VARCHAR(100)							NOT NULL,
cep			INT										NOT NULL,
telefone	INT												,
PRIMARY KEY (ra) );

CREATE TABLE CURSOS(
codigo_curso	INT				IDENTITY			NOT NULL,
nome			VARCHAR(100)						NOT NULL,
carga_horaria	INT									NOT NULL,
turno			VARCHAR(50)							NOT NULL,
PRIMARY KEY (codigo_curso) );

CREATE TABLE DISCIPLINAS (
codigo_disciplina	INT				IDENTITY			NOT NULL,
nome				VARCHAR(100)						NOT NULL,
carga_horaria		INT									NOT NULL,
turno				VARCHAR(50)							NOT NULL,
semestre			INT									NOT NULL,
PRIMARY KEY (codigo_disciplina) );

