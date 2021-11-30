CREATE DATABASE Hospital
GO
USE Hospital

CREATE TABLE PACIENTES (
cpf				VARCHAR(11)				NOT NULL,
nome			VARCHAR(200)			NOT NULL,
rua				VARCHAR(200)			NOT NULL,
n				INT						NOT NULL,
bairro			VARCHAR(100)			NOT NULL,
telefone		VARCHAR(20),
PRIMARY KEY (cpf) );

CREATE TABLE MEDICO (
codigo			INT							NOT NULL,
nome			VARCHAR(100)				NOT NULL,
especialidade	VARCHAR(100)				NOT NULL,
PRIMARY KEY (codigo) );

CREATE TABLE PRONTUARIO (
data_			DATE					NOT NULL,
cpf_paciente	VARCHAR(11)				NOT NULL,
codigo_medico	INT						NOT NULL,
diagnostico		VARCHAR(200)			NOT NULL,
medicamento		VARCHAR(200)			NOT NULL,
PRIMARY KEY(data_, cpf_paciente, codigo_medico),
FOREIGN KEY (cpf_paciente) REFERENCES PACIENTES(cpf),
FOREIGN KEY (codigo_medico) REFERENCES MEDICO(codigo) );