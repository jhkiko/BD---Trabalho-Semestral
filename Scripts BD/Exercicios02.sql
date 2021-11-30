USE Concessionaria

SELECT * FROM CLIENTE
SELECT * FROM CARRO
SELECT * FROM PECAS
SELECT * FROM SERVICO

SELECT cli.telefone, c.marca, c.cor
FROM Concessionaria.dbo.CARRO AS c
INNER JOIN Concessionaria.dbo.CLIENTE AS cli
ON c.placa = cli.carro_placa
AND c.modelo LIKE 'Ka'
AND c.cor LIKE 'Azul'

SELECT cli.logradouro, cli.n, cli.bairro, s.data_
FROM Concessionaria.dbo.SERVICO AS s
INNER JOIN Concessionaria.dbo.CLIENTE AS cli
ON s.carro = cli.carro_placa
AND s.data_ LIKE '%2009%'

SELECT c.placa
FROM Concessionaria.dbo.CARRO AS c
WHERE (c.ano < 2001)

SELECT c.marca, c.modelo, c.cor
FROM Concessionaria.dbo.CARRO AS c
INNER JOIN Concessionaria.dbo.CARRO as cc
ON c.placa = cc.placa
WHERE (c.ano > 2005)

SELECT p.codigo, p.nome, p.valor
FROM Concessionaria.dbo.PECAS AS p
WHERE (p.valor < 80)