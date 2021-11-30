USE aulajoin10

SELECT * FROM alunos
SELECT * FROM materias
SELECT * FROM avaliacoes
SELECT * FROM notas ORDER by id_materia, id_avaliacao
SELECT * FROM alunomateria
--1) Sabendo que MAX() é função de agregação, faça uma consulta que retorne a maior nota de P2 de Laboratório de Hardware

SELECT MAX(nt.nota) AS maior_nota_p2
FROM materias mat, notas nt, avaliacoes av
WHERE mat.id = nt.id_materia
	AND av.id = nt.id_avaliacao
	AND	av.tipo = 'P2'
	AND mat.nome LIKE '%Lab%'

--2) Consultar quantos alunos estão cadastrados e não estão em nenhuma matéria
SELECT COUNT(al.ra) AS alunos_nenhuma_materia
FROM materias mat, alunos al
WHERE mat.nome IS NULL

--3)
--Montar a seguinte tabela de saída:
--(ra formatado, nome, nota_final, conceito, 
--faltante(quanto faltou para passar (null 
--para aprovados)), min_exame (quanto precisa 
--tirar no exame para passar (null para 
--alunos com notas maior que 6,0 e menor que
--3,0)))

SELECT SUBSTRING (al.ra, 1, 9) + '-' + SUBSTRING (al.ra, 10, 1) AS ra,
	al.nome AS aluno_nome,
	av.tipo,
	SUBSTRING (CAST(-6 + av.peso * nt.nota AS VARCHAR),2,3) AS faltante
	
FROM alunos al INNER JOIN notas nt
ON al.ra = nt.ra_aluno
INNER JOIN materias mat
ON mat.id = nt.id_materia
INNER JOIN avaliacoes av
ON av.id = nt.id_avaliacao
WHERE av.tipo LIKE 'P1'

SELECT av.tipo,
	SUBSTRING (CAST(-6 + av.peso * nt.nota AS VARCHAR),2,3) AS faltante
FROM alunos al INNER JOIN notas nt
ON al.ra = nt.ra_aluno
INNER JOIN materias mat
ON mat.id = nt.id_materia
INNER JOIN avaliacoes av
ON av.id = nt.id_avaliacao
WHERE av.tipo LIKE 'P2'

SELECT av.tipo,
	SUBSTRING (CAST(-6 + av.peso * nt.nota AS VARCHAR),2,3) AS faltante
FROM alunos al INNER JOIN notas nt
ON al.ra = nt.ra_aluno
INNER JOIN materias mat
ON mat.id = nt.id_materia
INNER JOIN avaliacoes av
ON av.id = nt.id_avaliacao
WHERE av.tipo LIKE 'T'