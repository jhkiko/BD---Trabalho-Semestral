USE aulajoin10

SELECT * FROM alunos
SELECT * FROM materias
SELECT * FROM avaliacoes
SELECT * FROM notas ORDER by id_materia, id_avaliacao
SELECT * FROM alunomateria

/*Funções de Agregação
SUM(), AVG(), COUNT(), MAX(), MIN() 

GROUP BY - Cláusula de Agregação
HAVING - Filtro para Funções de Agregação
*/


--Consultar a média das notas de cada avaliação por matéria
--Select Média aritmética a partir da soma com filtro de Avaliação e Matéria
SELECT CAST(SUM(nt.nota) / 40 AS DECIMAL(7,1)) AS media_p2_bd
FROM materias mat INNER JOIN notas nt
ON mat.id = nt.id_materia
INNER JOIN avaliacoes av
ON av.id = nt.id_avaliacao
WHERE av.tipo = 'P2'
	AND mat.nome LIKE 'Banco%'

SELECT CAST(SUM(nt.nota) / 40 AS DECIMAL(7,1)) AS media_p2_bd
FROM materias mat, notas nt, avaliacoes av
WHERE mat.id = nt.id_materia
	AND av.id = nt.id_avaliacao
	AND av.tipo = 'P2'
	AND mat.nome LIKE 'Banco%'


--Select Média aritmética com filtro de Avaliação e Matéria
SELECT CAST(AVG(nt.nota) AS DECIMAL(7,1)) AS media_p2_bd
FROM materias mat INNER JOIN notas nt
ON mat.id = nt.id_materia
INNER JOIN avaliacoes av
ON av.id = nt.id_avaliacao
WHERE av.tipo = 'P2'
	AND mat.nome LIKE 'Banco%'

SELECT CAST(AVG(nt.nota) AS DECIMAL(7,1)) AS media_p2_bd
FROM materias mat, notas nt, avaliacoes av
WHERE mat.id = nt.id_materia
	AND av.id = nt.id_avaliacao
	AND av.tipo = 'P2'
	AND mat.nome LIKE 'Banco%'

--Agrupando por matéria e tipo de avaliação
SELECT mat.nome, av.tipo,
	CAST(AVG(nt.nota) AS DECIMAL(7,1)) AS media_p2_bd
FROM materias mat INNER JOIN notas nt
ON mat.id = nt.id_materia
INNER JOIN avaliacoes av
ON av.id = nt.id_avaliacao
GROUP BY mat.nome, av.tipo
ORDER BY mat.nome, av.tipo

SELECT mat.nome, av.tipo,
	CAST(AVG(nt.nota) AS DECIMAL(7,1)) AS media_p2_bd
FROM materias mat, notas nt, avaliacoes av
WHERE mat.id = nt.id_materia
	AND av.id = nt.id_avaliacao
GROUP BY mat.nome, av.tipo
ORDER BY mat.nome, av.tipo



--Consultar o RA do aluno (mascarado), a nota final dos alunos, 
--de alguma matéria e uma coluna conceito 
--(aprovado caso nota >= 6, reprovado, caso contrário)
SELECT SUBSTRING(al.ra, 1, 9) + '-' + SUBSTRING(al.ra, 10, 1) AS ra,
	CAST(SUM(av.peso * nt.nota) AS DECIMAL(7,1)) AS nota_final,
	CASE WHEN SUM(av.peso * nt.nota) >= 6
		THEN 
			'AP'
		ELSE
			'RN'
	END AS conceito
FROM alunos al INNER JOIN notas nt
ON al.ra = nt.ra_aluno
INNER JOIN materias mat
ON mat.id = nt.id_materia
INNER JOIN avaliacoes av
ON av.id = nt.id_avaliacao
WHERE mat.nome LIKE 'Banco%'
GROUP BY al.ra

SELECT SUBSTRING(al.ra, 1, 9) + '-' + SUBSTRING(al.ra, 10, 1) AS ra,
	CAST(SUM(av.peso * nt.nota) AS DECIMAL(7,1)) AS nota_final,
	CASE WHEN SUM(av.peso * nt.nota) >= 6
		THEN 
			'AP'
		ELSE
			'RN'
	END AS conceito
FROM alunos al, notas nt, materias mat, avaliacoes av
WHERE al.ra = nt.ra_aluno
	AND mat.id = nt.id_materia
	AND av.id = nt.id_avaliacao
	AND mat.nome LIKE 'Banco%'
GROUP BY al.ra


--Consultar nome da matéria e quantos alunos estão matriculados
SELECT mat.nome, COUNT(al.nome) AS total_alunos
FROM alunos al, alunomateria am, materias mat
WHERE al.ra = am.ra_aluno
	AND mat.id = am.id_materia
GROUP BY mat.nome

SELECT mat.nome, COUNT(al.nome) AS total_alunos
FROM alunos al INNER JOIN alunomateria am 
ON al.ra = am.ra_aluno
INNER JOIN materias mat
ON mat.id = am.id_materia
GROUP BY mat.nome

--Consultar quantos alunos não estão matriculados
SELECT COUNT(al.ra) AS nao_matriculados
FROM alunos al LEFT OUTER JOIN alunomateria am
ON al.ra = am.ra_aluno
WHERE am.ra_aluno IS NULL

SELECT COUNT(ra) total_alunos
FROM alunos

--Consultar quais alunos estão aprovados em alguma matéria 
--(nota final >= 6,0)
SELECT SUBSTRING(al.ra, 1, 9) + '-' + SUBSTRING(al.ra, 10, 1) AS ra,
	al.nome
FROM alunos al INNER JOIN notas nt
ON al.ra = nt.ra_aluno
INNER JOIN materias mat
ON mat.id = nt.id_materia
INNER JOIN avaliacoes av
ON av.id = nt.id_avaliacao
WHERE mat.nome LIKE 'Banco%'
GROUP BY al.ra, al.nome
HAVING SUM(av.peso * nt.nota) >= 6.0

SELECT SUBSTRING(al.ra, 1, 9) + '-' + SUBSTRING(al.ra, 10, 1) AS ra,
	al.nome
FROM alunos al, notas nt, materias mat, avaliacoes av
WHERE al.ra = nt.ra_aluno
	AND mat.id = nt.id_materia
	AND av.id = nt.id_avaliacao
	AND mat.nome LIKE 'Banco%'
GROUP BY al.ra, al.nome
HAVING SUM(av.peso * nt.nota) >= 6.0


--Consultar quantos alunos estão aprovados em alguma matéria
--(nota final >= 6,0)
SELECT COUNT(ra) AS aprovados
FROM alunos 
WHERE ra IN
(
	SELECT al.ra
	FROM alunos al INNER JOIN notas nt
	ON al.ra = nt.ra_aluno
	INNER JOIN materias mat
	ON mat.id = nt.id_materia
	INNER JOIN avaliacoes av
	ON av.id = nt.id_avaliacao
	WHERE mat.nome LIKE 'Banco%'
	GROUP BY al.ra
	HAVING SUM(av.peso * nt.nota) >= 6.0
)

SELECT COUNT(ra) AS aprovados
FROM alunos 
WHERE ra IN
(
	SELECT al.ra
	FROM alunos al, notas nt, materias mat, avaliacoes av
	WHERE al.ra = nt.ra_aluno
		AND mat.id = nt.id_materia
		AND av.id = nt.id_avaliacao
		AND mat.nome LIKE 'Banco%'
	GROUP BY al.ra, al.nome
	HAVING SUM(av.peso * nt.nota) >= 6.0
)

--Consultar quantos alunos estão reprovados em alguma matéria
--(nota final < 6,0)
--Método 1
SELECT COUNT(ra) AS reprovados
FROM alunos 
WHERE ra IN
(
	SELECT al.ra
	FROM alunos al INNER JOIN notas nt
	ON al.ra = nt.ra_aluno
	INNER JOIN materias mat
	ON mat.id = nt.id_materia
	INNER JOIN avaliacoes av
	ON av.id = nt.id_avaliacao
	WHERE mat.nome LIKE 'Banco%'
	GROUP BY al.ra
	HAVING SUM(av.peso * nt.nota) < 6.0
)

SELECT COUNT(ra) AS reprovados
FROM alunos 
WHERE ra IN
(
	SELECT al.ra
	FROM alunos al, notas nt, materias mat, avaliacoes av
	WHERE al.ra = nt.ra_aluno
		AND mat.id = nt.id_materia
		AND av.id = nt.id_avaliacao
		AND mat.nome LIKE 'Banco%'
	GROUP BY al.ra, al.nome
	HAVING SUM(av.peso * nt.nota) < 6.0
)

--Método 2
SELECT COUNT(ra) AS aprovados
FROM alunos al INNER JOIN alunomateria am
ON al.ra = am.ra_aluno
INNER JOIN materias mat
ON mat.id = am.id_materia
WHERE mat.nome LIKE 'Banco%'
	AND al.ra NOT IN
(
	SELECT al.ra
	FROM alunos al INNER JOIN notas nt
	ON al.ra = nt.ra_aluno
	INNER JOIN materias mat
	ON mat.id = nt.id_materia
	INNER JOIN avaliacoes av
	ON av.id = nt.id_avaliacao
	WHERE mat.nome LIKE 'Banco%'
	GROUP BY al.ra
	HAVING SUM(av.peso * nt.nota) >= 6.0
)

SELECT COUNT(ra) AS aprovados
FROM alunos al, alunomateria am, materias mat
WHERE al.ra = am.ra_aluno
	AND mat.id = am.id_materia
	AND mat.nome LIKE 'Banco%'
	AND al.ra NOT IN
(
	SELECT al.ra
	FROM alunos al, notas nt, materias mat, avaliacoes av
	WHERE al.ra = nt.ra_aluno
		AND mat.id = nt.id_materia
		AND av.id = nt.id_avaliacao
		AND mat.nome LIKE 'Banco%'
	GROUP BY al.ra, al.nome
	HAVING SUM(av.peso * nt.nota) >= 6.0
)

--Consultar a maior e menor notas das avaliações das matérias
SELECT mat.nome, av.tipo, MAX(nt.nota) AS maior_nota,
	MIN(nt.nota) AS menor_nota
FROM materias mat INNER JOIN notas nt
ON mat.id = nt.id_materia
INNER JOIN avaliacoes av
ON av.id = nt.id_avaliacao
GROUP BY mat.nome, av.tipo
ORDER BY mat.nome, av.tipo

SELECT mat.nome, av.tipo, MAX(nt.nota) AS maior_nota,
	MIN(nt.nota) AS menor_nota
FROM materias mat, notas nt, avaliacoes av
WHERE mat.id = nt.id_materia
	AND av.id = nt.id_avaliacao
GROUP BY mat.nome, av.tipo
ORDER BY mat.nome, av.tipo

--Consultar a menor notas das avaliações das matérias
--que não sejam zero
SELECT mat.nome, av.tipo, MIN(nt.nota) AS nota_minima
FROM materias mat INNER JOIN notas nt
ON mat.id = nt.id_materia
INNER JOIN avaliacoes av
ON av.id = nt.id_avaliacao
WHERE nt.nota IN
(
	SELECT nota
	FROM notas 
	WHERE nota > 0
)
GROUP BY mat.nome, av.tipo

SELECT mat.nome, av.tipo, MIN(nt.nota) AS nota_minima
FROM materias mat, notas nt, avaliacoes av
WHERE mat.id = nt.id_materia
	AND av.id = nt.id_avaliacao
	AND nt.nota IN
(
	SELECT nota
	FROM notas 
	WHERE nota > 0
)
GROUP BY mat.nome, av.tipo

--Retornar nome da matéria, tipo da avaliação e as 2 maiores notas
SELECT TOP 2 al.nome, mat.nome, av.tipo, nt.nota
FROM materias mat INNER JOIN notas nt
ON mat.id = nt.id_materia
INNER JOIN avaliacoes av
ON av.id = nt.id_avaliacao
INNER JOIN alunos al
ON al.ra = nt.ra_aluno
WHERE mat.nome LIKE 'Banco%'
ORDER BY nt.nota DESC

SELECT TOP 2 al.nome, mat.nome, av.tipo, nt.nota
FROM materias mat, notas nt, avaliacoes av, alunos al
WHERE mat.id = nt.id_materia
	AND av.id = nt.id_avaliacao
	AND al.ra = nt.ra_aluno
	AND mat.nome LIKE 'Banco%'
ORDER BY nt.nota DESC

--Fazer uma consulta que retorne o RA formatado e o nome dos 
--alunos que tem a menor nota da P1 de banco de dados
SELECT SUBSTRING(al.ra, 1, 9) + '-' + SUBSTRING(al.ra, 10, 1) AS ra, 
	al.nome, nt.nota
FROM alunos al INNER JOIN notas nt
ON al.ra = nt.ra_aluno
INNER JOIN materias mat
ON mat.id = nt.id_materia
WHERE mat.nome LIKE 'Banco%'
	AND nt.nota IN 
(
	SELECT MIN(nt.nota)
	FROM materias mat INNER JOIN notas nt
	ON mat.id = nt.id_materia
	INNER JOIN avaliacoes av
	ON av.id = nt.id_avaliacao
	WHERE mat.nome LIKE 'Banco%'
		AND av.tipo = 'P1'
	GROUP BY mat.nome, av.tipo
)

SELECT SUBSTRING(al.ra, 1, 9) + '-' + SUBSTRING(al.ra, 10, 1) AS ra,
	al.nome, nt.nota
FROM alunos al, notas nt, materias mat
WHERE al.ra = nt.ra_aluno
	AND mat.id = nt.id_materia
	AND mat.nome LIKE 'Banco%'
	AND nt.nota IN 
(
	SELECT MIN(nt.nota)
	FROM materias mat, notas nt, avaliacoes av
	WHERE mat.id = nt.id_materia
		AND av.id = nt.id_avaliacao
		AND mat.nome LIKE 'Banco%'
		AND av.tipo = 'P1'
	GROUP BY mat.nome, av.tipo
)



--Montar a seguinte tabela de saída:
--(ra formatado, nome, nota_final, conceito, 
--faltante(quanto faltou para passar (null 
--para aprovados)), min_exame (quanto precisa 
--tirar no exame para passar (null para 
--alunos com notas maior que 6,0 e menor que
--3,0)))
--exame : nota_final + nota_exame / 2 >= 6.0
--12 - nota_final = nota mínima no exame

SELECT SUBSTRING(al.ra, 1, 9) + '-' + SUBSTRING(al.ra, 10, 1) AS ra,
	al.nome,
	CAST(SUM(av.peso * nt.nota) AS DECIMAL(7,1)) AS nota_final,
	CASE WHEN SUM(av.peso * nt.nota) >= 6
		THEN 
			'AP'
		ELSE
			'RN'
	END AS conceito,
	CASE WHEN SUM(av.peso * nt.nota) >= 6.0
		THEN 
			NULL
		ELSE 
			CAST(6.0 - SUM(av.peso * nt.nota) AS DECIMAL(7,1))
	END AS faltante,
	CASE WHEN SUM(av.peso * nt.nota) >= 6.0
		THEN
			NULL
		ELSE 
			CASE WHEN SUM(av.peso * nt.nota) < 3.0 
				THEN
					NULL
				ELSE
					CAST(12 - SUM(av.peso * nt.nota) AS DECIMAL(7,1))
			END
	END AS min_exame
FROM alunos al INNER JOIN notas nt
ON al.ra = nt.ra_aluno
INNER JOIN materias mat
ON mat.id = nt.id_materia
INNER JOIN avaliacoes av
ON av.id = nt.id_avaliacao
WHERE mat.nome LIKE 'Banco%'
GROUP BY al.ra, al.nome, mat.nome
ORDER BY al.nome

SELECT SUBSTRING(al.ra, 1, 9) + '-' + SUBSTRING(al.ra, 10, 1) AS ra,
	al.nome,
	CAST(SUM(av.peso * nt.nota) AS DECIMAL(7,1)) AS nota_final,
	CASE WHEN SUM(av.peso * nt.nota) >= 6
		THEN 
			'AP'
		ELSE
			'RN'
	END AS conceito,
	CASE WHEN SUM(av.peso * nt.nota) >= 6.0
		THEN 
			NULL
		ELSE 
			CAST(6.0 - SUM(av.peso * nt.nota) AS DECIMAL(7,1))
	END AS faltante,
	CASE WHEN SUM(av.peso * nt.nota) >= 6.0
		THEN
			NULL
		ELSE 
			CASE WHEN SUM(av.peso * nt.nota) < 3.0 
				THEN
					NULL
				ELSE
					CAST(12 - SUM(av.peso * nt.nota) AS DECIMAL(7,1))
			END
	END AS min_exame
FROM alunos al, notas nt, materias mat, avaliacoes av
	WHERE al.ra = nt.ra_aluno
	AND mat.id = nt.id_materia
	AND av.id = nt.id_avaliacao
	AND mat.nome LIKE 'Banco%'
GROUP BY al.ra, al.nome, mat.nome
ORDER BY al.nome

-- Montar a seguinte tabela de saída:
--(ra formatado, nome, nota)
--para os alunos que tem a maior e a menor 
--nota de uma disciplina e 
--uma avaliação a definir na clausula WHERE.

--P2 | Banco de Dados

SELECT SUBSTRING(al.ra, 1, 9) + '-' + SUBSTRING(al.ra, 10, 1) AS ra,
	al.nome,
	nt.nota
FROM alunos al INNER JOIN notas nt
ON al.ra = nt.ra_aluno
INNER JOIN materias mat
ON mat.id = nt.id_materia
INNER JOIN avaliacoes av
ON av.id = nt.id_avaliacao
WHERE mat.nome LIKE 'Banco%'
	AND (nt.nota IN
(
	SELECT MIN(nt.nota)
	FROM materias mat INNER JOIN notas nt
	ON nt.id_materia = mat.id
	INNER JOIN avaliacoes av
	ON av.id = nt.id_avaliacao
	WHERE mat.nome LIKE 'Banco%'
		AND av.tipo = 'P2'
)
	OR nt.nota IN 
(
	SELECT MAX(nt.nota)
	FROM materias mat INNER JOIN notas nt
	ON nt.id_materia = mat.id
	INNER JOIN avaliacoes av
	ON av.id = nt.id_avaliacao
	WHERE mat.nome LIKE 'Banco%'
		AND av.tipo = 'P2'
)
)
ORDER BY nt.nota, al.nome

SELECT SUBSTRING(al.ra, 1, 9) + '-' + SUBSTRING(al.ra, 10, 1) AS ra,
	al.nome,
	nt.nota
FROM alunos al, notas nt, materias mat, avaliacoes av
WHERE al.ra = nt.ra_aluno
	AND mat.id = nt.id_materia
	AND av.id = nt.id_avaliacao
	AND mat.nome LIKE 'Banco%'
	AND (nt.nota IN
(
	SELECT MIN(nt.nota)
	FROM materias mat, notas nt, avaliacoes av
	WHERE nt.id_materia = mat.id
		AND av.id = nt.id_avaliacao
		AND mat.nome LIKE 'Banco%'
		AND av.tipo = 'P2'
)
	OR nt.nota IN 
(
	SELECT MAX(nt.nota)
	FROM materias mat, notas nt, avaliacoes av
	WHERE nt.id_materia = mat.id
		AND av.id = nt.id_avaliacao
		AND mat.nome LIKE 'Banco%'
		AND av.tipo = 'P2'
)
)
ORDER BY nt.nota, al.nome