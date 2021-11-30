CREATE DATABASE Concessionaria
GO
USE Concessionaria

CREATE TABLE CARRO (
placa		VARCHAR(7)				NOT NULL,
marca		VARCHAR(50)				NOT NULL,
modelo		VARCHAR(50)				NOT NULL,
cor			VARCHAR(50)				NOT NULL,
ano			INT						NOT NULL,
PRIMARY KEY (placa) );

CREATE TABLE CLIENTE (
nome		VARCHAR(100)			NOT NULL,
logradouro	VARCHAR(200)			NOT NULL,
n			INT						NOT NULL,
bairro		VARCHAR(100)			NOT NULL,
telefone	VARCHAR(20)				NOT NULL,
carro_placa	VARCHAR(7)				NOT NULL,
PRIMARY KEY (carro_placa),
FOREIGN KEY (carro_placa) REFERENCES CARRO(placa) );

CREATE TABLE PECAS (
codigo		INT						NOT NULL,
nome		VARCHAR(100)			NOT NULL,
valor		DECIMAL(7,2)			NOT NULL,
PRIMARY KEY (codigo) );

CREATE TABLE SERVICO (
carro		VARCHAR(7)				NOT NULL,
peca		INT						NOT NULL,
quantidade	INT						NOT NULL,
valor		DECIMAL(7,2)			NOT NULL,
data_		DATETIME				NOT NULL,
PRIMARY KEY (carro, peca, data_),
FOREIGN KEY (carro) REFERENCES CARRO(placa),
FOREIGN KEY (peca)	REFERENCES PECAS(codigo) );



