CREATE DATABASE Atividade3
GO
USE Atividade3

CREATE TABLE Planos(
codigo		INT			NOT NULL,
nome		VARCHAR(50)	NOT NULL,
telefone	CHAR(8)		NOT NULL
PRIMARY KEY (codigo))

INSERT INTO Planos VALUES
(1234,'Amil','41599856'),
(2345,'Sul América','45698745'),
(3456,'Unimed','48759836'),
(4567,'Bradesco Saúde','47265897'),
(5678,'Intermédica','41415269')

CREATE TABLE Paciente(
cpf			CHAR(11)	NOT NULL,
nome		VARCHAR(50)	NOT NULL,
rua			VARCHAR(50)	NOT NULL,
numero		INT			NOT NULL,
bairro		VARCHAR(30)	NOT NULL,
telefone	CHAR(8)		NOT NULL,
plano		INT			NOT NULL
PRIMARY KEY (cpf)
FOREIGN KEY (plano) REFERENCES Planos(codigo))

INSERT INTO Paciente VALUES
('85987458920','Maria Paula','R. Voluntários da Pátria',589,'Santana','98458741',2345),
('87452136900','Ana Julia','R. XV de Novembro',657,'Centro','69857412',5678),
('23659874100','João Carlos','R. Sete de Setembro',12,'República','74859632',1234),
('63259874100','José Lima','R. Anhaia',768,'Barra Funda','96524156',2345)

CREATE TABLE Medico(
codigo			INT			NOT NULL,
nome			VARCHAR(50)	NOT NULL,
especialidade	VARCHAR(30)	NOT NULL,
plano			INT
PRIMARY KEY (codigo)
FOREIGN KEY (plano) REFERENCES Planos(codigo))

INSERT INTO Medico VALUES 
(1,	'Claudio',	'Clínico Geral',	1234),
(2,	'Larissa',	'Ortopedista',	2345),
(3,	'Juliana',	'Otorrinolaringologista',	4567),
(4,	'Sérgio',	'Pediatra',	1234),
(5,	'Julio',	'Clínico Geral',	4567),
(6,	'Samara',	'Cirurgião',	1234)

CREATE TABLE Consulta(
medico		INT			NOT NULL,
paciente	CHAR(11)	NOT NULL,		
data_hora	DATETIME	NOT NULL,
diagnostico	VARCHAR(20)	NOT NULL
PRIMARY KEY (medico, paciente, data_hora)
FOREIGN KEY (medico) REFERENCES Medico(codigo),
FOREIGN KEY (paciente) REFERENCES Paciente(cpf))

INSERT INTO Consulta  VALUES 
(1,	'85987458920',	'2020-02-10 10:30',	'Gripe'),
(2,	'23659874100',	'2020-02-10 11:00',	'Pé Fraturado'),
(4,	'85987458920',	'2020-02-11 14:00',	'Pneumonia'),
(2,	'23659874100',	'2020-02-11 15:00',	'Asma'),
(3,	'87452136900',	'2020-02-11 16:00',	'Sinusite'),
(5,	'63259874100',	'2020-02-11 17:00',	'Rinite'),
(4,	'23659874100',	'2020-02-11 18:00',	'Asma'),
(5,	'63259874100',	'2020-02-12 10:00',	'Rinoplastia')

SELECT * FROM Planos
SELECT * FROM Paciente
SELECT * FROM Medico
SELECT * FROM Consulta