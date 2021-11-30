CREATE DATABASE LojaDeBrinquedos
GO
USE LojaDeBrinquedos

CREATE TABLE FORNECEDORES (
codigo			INT					NOT NULL,
nome			VARCHAR(50)			NOT NULL,
atividade		VARCHAR(150)		NOT NULL,
telefone		VARCHAR(10)			NOT NULL,
PRIMARY KEY (codigo));

CREATE TABLE CLIENTE (
codigo			INT					NOT NULL,
nome			VARCHAR(100)		NOT NULL,
endereco		VARCHAR(200)		NOT NULL,
telefone		VARCHAR(10)			NOT NULL,
idade			INT					NOT NULL,
PRIMARY KEY (codigo));

CREATE TABLE PRODUTO (
codigo				INT					NOT NULL,
nome				VARCHAR(200)		NOT NULL,
valor_unitario		DECIMAL(7,2)		NOT NULL,
qde_estoque			INT					NOT NULL,
descricao			VARCHAR(200)		NOT NULL,
codigo_fornecedor	INT					NOT NULL,
PRIMARY KEY (codigo),
FOREIGN KEY (codigo_fornecedor) REFERENCES FORNECEDORES(codigo));

CREATE TABLE PEDIDO (
codigo				INT					NOT NULL,
codigo_cliente		INT					NOT NULL,
codigo_produto		INT					NOT NULL,
qde					INT					NOT NULL,
valor_total			DECIMAL(7,2)		NOT NULL,
data_				DATETIME			NOT NULL,
PRIMARY KEY (codigo, codigo_cliente, codigo_produto),
FOREIGN KEY (codigo_cliente) REFERENCES CLIENTE(codigo),
FOREIGN KEY (codigo_produto) REFERENCES PRODUTO(codigo));