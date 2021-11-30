CREATE DATABASE Exercicios06
GO
USE Exercicios06

CREATE TABLE Motorista (
codigo			INT				NOT NULL,
nome			VARCHAR(200)	NOT NULL,
idade			INT				NOT NULL,
naturalidade	VARCHAR(100)	NOT NULL,
PRIMARY KEY (codigo));

CREATE TABLE Onibus (
placa			VARCHAR(20)		NOT NULL,
marca			VARCHAR(50)		NOT NULL,
ano				INT				NOT NULL,
descricao		VARCHAR(100)	NOT NULL,
PRIMARY KEY (placa));

CREATE TABLE Viagem (
codigo			INT				NOT NULL,
onibus			VARCHAR(20)		NOT NULL,
motorista		INT				NOT NULL,
hora_saida		VARCHAR(5)		NOT NULL,
hora_chegada	VARCHAR(5)		NOT NULL,
destino			VARCHAR(50)		NOT NULL,
PRIMARY KEY (codigo),
FOREIGN KEY (onibus) REFERENCES Onibus(placa),
FOREIGN KEY (motorista) REFERENCES Motorista(codigo));
