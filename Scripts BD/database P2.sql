CREATE DATABASE amostra
GO
USE amostra
GO
CREATE TABLE departamento(
depto_no CHAR(2) NOT NULL,
depto_nome VARCHAR(25) NOT NULL,
localizacao CHAR(30) NULL
PRIMARY KEY (depto_no))
GO
CREATE TABLE projeto   (
proj_no CHAR(2) NOT NULL,
proj_nome VARCHAR(15) NOT NULL,
orcamento DECIMAL(9,2) NULL
PRIMARY KEY (proj_no))
GO
CREATE TABLE empregado  (
emp_no INT NOT NULL, 
emp_pri_nome VARCHAR(20) NOT NULL,
emp_ult_nome VARCHAR(20) NOT NULL,
depto_no CHAR(2) NOT NULL
PRIMARY KEY (emp_no)
FOREIGN KEY (depto_no) REFERENCES departamento(depto_no))
GO
CREATE TABLE emp_proj	(
emp_no INTEGER NOT NULL,
proj_no CHAR(2) NOT NULL,
trabalho VARCHAR(15) NULL,
data_inicio DATETIME NULL
PRIMARY KEY (emp_no,proj_no)
FOREIGN KEY (emp_no) REFERENCES empregado(emp_no),
FOREIGN KEY (proj_no) REFERENCES projeto(proj_no))

INSERT INTO departamento VALUES ('d1', 'pesquisa','Dallas')
INSERT INTO departamento VALUES ('d2', 'contabilidade', 'Seattle')
INSERT INTO departamento VALUES ('d3', 'marketing', 'Dallas')
INSERT INTO departamento VALUES ('d4', 'TI', 'Seattle')
INSERT INTO projeto VALUES ('p1', 'Apollo', 120000.00)
INSERT INTO projeto VALUES ('p2', 'Gemini', 95000.00)
INSERT INTO projeto VALUES ('p3', 'Mercury', 186500.00)
INSERT INTO projeto VALUES ('p4', 'Juno', 18750.00)
INSERT INTO empregado VALUES(25348, 'Matthew', 'Smith','d3')
INSERT INTO empregado VALUES(10102, 'Ann', 'Jones','d3')
INSERT INTO empregado VALUES(18316, 'John', 'Barrimore', 'd1')
INSERT INTO empregado VALUES(29346, 'James', 'James', 'd2')
INSERT INTO empregado VALUES(9031, 'Elsa', 'Bertoni', 'd2')
INSERT INTO empregado VALUES(2581, 'Elke', 'Hansel', 'd2')
INSERT INTO empregado VALUES(28559, 'Sybill', 'Moser', 'd1')
INSERT INTO emp_proj VALUES (10102,'p1', 'analista', '2006-10-01')
INSERT INTO emp_proj VALUES (10102, 'p3', 'gerente', '2008-01-01')
INSERT INTO emp_proj VALUES (25348, 'p2', 'escriturário', '2007-02-15')
INSERT INTO emp_proj VALUES (18316, 'p2', NULL, '2006-06-01')
INSERT INTO emp_proj VALUES (29346, 'p2', NULL, '2006-12-15')
INSERT INTO emp_proj VALUES (2581, 'p3', 'analista', '2007-10-15')
INSERT INTO emp_proj VALUES (9031, 'p1', 'gerente', '2007-04-15')
INSERT INTO emp_proj VALUES (28559, 'p1', NULL, '2007-08-01')
INSERT INTO emp_proj VALUES (28559, 'p2', 'escriturário', '2008-02-01')
INSERT INTO emp_proj VALUES (9031, 'p3', 'escriturário', '2006-11-15')  
INSERT INTO emp_proj VALUES (29346, 'p1','escriturário', '2007-01-04')

SELECT * FROM departamento
SELECT * FROM projeto
SELECT * FROM empregado
SELECT * FROM emp_proj