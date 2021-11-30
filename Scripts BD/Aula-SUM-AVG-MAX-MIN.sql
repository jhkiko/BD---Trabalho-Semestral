USE aulajoin10

SELECT * FROM alunos
SELECT * FROM materias
SELECT * FROM avaliacoes
SELECT * FROM notas ORDER by id_materia, id_avaliacao
SELECT * FROM alunomateria

/* Funções de Agregação
SUM(), AVG(), COUNT(), MAX(), MIN()
*/

-- Consultar a média das notas de cada avaliação por matéria

SELECT SUM(nt.nota) AS media_p2_bd
FROM materias mat, notas nt, avaliacoes av
WHERE mat.id = nt.id_materia
	AND av.id = nt.id_avaliacao
	AND av.tipo = 'P2'
	AND mat.nome LIKE 'Banco%'


/* Consultar RA do aluno (mascarado), a nota final dos alunos
de alguma matéria e uma coluna conceito
(aprovado caso nota >=6, reprovado, caso contrário)
*/

SELECT SUBSTRING (al.ra, 1, 9) + '-' + SUBSTRING (al.ra, 10, 1) AS ra,
	av.tipo,
	CAST(av.peso * nt.nota AS DECIMAL(7,1))
FROM alunos al INNER JOIN notas nt
ON al.ra = nt.ra_aluno
INNER JOIN materias mat
ON mat.id = nt.id_materia
INNER JOIn avaliacoes av
ON av.id = nt.id_avaliacao
WHERE mat.nome LIKE 'Banco%'

/* 
Consultar quais alunos estão aprovados em alguma matéria
(nota final >= 6,0)
*/
SELECT SUBSTRING(al.ra, 1, 9) + '-' + SUBSTRING(al.ra,10,1) AS ra, al nome
FROM alunos al INNER JOIN notas nt
ON al.ra = nt.ra_aluno
INNER JOIN materias mat
ON mat.id = nt.id_materia
INNER JOIN avaliacoes av
ON av.id = nt.id_avaliacao
WHERE mat.nome LIKE 'Banco%'
GROUP BY al.ra, al.nome
HAVING SUM(av.peso * nt.nota) >= 6.0
