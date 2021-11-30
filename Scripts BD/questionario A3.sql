USE Atividade3
GO

--1) Consultar CPF, com máscara (XXX.XXX.XXX-XX), nome, rua, numero, bairro dos clientes do Plano Sul América
SELECT SUBSTRING(pa.cpf, 1, 3) + '.' + SUBSTRING(pa.cpf, 4, 3) + '.' + SUBSTRING(pa.cpf, 7, 3) + '-' + SUBSTRING(pa.cpf, 10, 2) as cpf, pa.nome, pa.rua, pa.numero, pa.bairro
FROM Planos pl INNER JOIN Paciente pa
ON pl.codigo = pa.plano
WHERE pl.nome = 'Sul América'

--2) Consultar Nome do plano, quantidade de clientes em uma coluna denominada qtd_clientes
SELECT pl.nome, COUNT(pc.cpf) AS Qtd_Clientes
FROM Planos pl INNER JOIN Paciente pc
ON pl.codigo = pc.plano
GROUP BY pl.nome

--3) Consultar Quantos médicos não tiveram consultas cadastradas
SELECT COUNT(med.codigo) AS Qntd
FROM Medico med LEFT OUTER JOIN Consulta con
ON con.medico = med.codigo
WHERE con.medico IS NULL AND con.data_hora IS NULL AND con.paciente IS NULL

--4) Consultar nome do cliente, telefone, nome do plano de saúde, data da consulta(formato dd/mm/yyyy), hora da consulta(formato hh:mm) dos pacientes com asma (usar o termo asma na filtragem)
SELECT p.nome, p.telefone, pl.nome, CONVERT(CHAR(10), c.data_hora, 103) AS Data_da_consulta, CONVERT(CHAR(5), c.data_hora, 108) AS Hora_da_consulta
FROM Consulta c INNER JOIN Paciente p
ON p.cpf = c.paciente
INNER JOIN Planos pl
ON pl.codigo = p.plano
WHERE c.diagnostico LIKE '%asma%'


