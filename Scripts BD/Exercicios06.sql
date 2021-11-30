USE Exercicios06
GO

SELECT CONVERT (CHAR(10), v.hora_chegada, 108) AS hora_chegada, CONVERT(CHAR(10), v.hora_saida,108) AS hora_saida, v.destino
FROM Viagem v

SELECT m.nome, m.codigo
FROM Motorista m
WHERE m.codigo IN
	( SELECT v.motorista
	FROM Viagem v
	WHERE v.destino LIKE '%Sorocaba%'
	);

SELECT o.descricao
FROM Onibus o
WHERE o.placa IN
	( SELECT v.onibus
	FROM Viagem v
	WHERE v.destino LIKE '%Rio de Janeiro%');

SELECT o.descricao, o.marca, o.ano
FROM Onibus o
WHERE o.placa IN
	( SELECT v.onibus
	FROM Viagem v
	WHERE v.motorista IN
	(SELECT m.codigo
	FROM Motorista m
	WHERE m.nome LIKE '%Luiz%'));