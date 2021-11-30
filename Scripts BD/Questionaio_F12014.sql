USE f12014
--Consultar o nome da equipe e o nome do piloto, dos envolvidos na temporada

SELECT e.nome, p.nome
FROM equipe e INNER JOIN temporada t
ON e.codigo = t.numero_piloto
INNER JOIN piloto p
ON p.numero = t.numero_piloto

--Para definir o resultado final do campeonato de pilotos, consultar o numero do piloto, 
--o nome do piloto, o nome da equipe e o total de pontos marcados pelo piloto no campeonato

SELECT p.numero, p.nome, e.nome, t.pontos
FROM piloto p, equipe e INNER JOIN temporada t	
ON e.codigo = t.numero_piloto

--Para definir o resultado final do campeonato de construtores (equipes), consultar o nome da equipe 
--e o total de pontos marcados pela equipe no campeonato 
--feito por todos os pilotos que correram pela equpe no ano)

SELECT e.nome, t.pontos
FROM piloto p, equipe e INNER JOIN temporada t
ON e.codigo = t.numero_piloto

--Consultar o numero do piloto e o nome do piloto dos pilotos inscritos que não participaram
--de nenhuma corrida nesse campeonato

SELECT p.numero, p.nome
FROM piloto p LEFT OUTER JOIN temporada t
ON t.numero_piloto = p.numero
WHERE t.numero_piloto IS NULL

--Consultar o numero do piloto, o nome do piloto, o nome da equipe (em uma coluna chamada equipe),
--a posição e a quanqtidade de vezes que o piloto chegou nessa posição (coluna chamada qtd),
--do piloto que tem Hamilton no nome.
--Se a posição for 0 (Escrever DNF), se for 1 (Escrever 1o.), se for 2 (Escrever 2o.), e assim por diante.

SELECT p.numero, p.nome, e.nome AS equipe, t.posicao, COUNT (t.posicao) AS qtd
FROM equipe e, piloto p INNER JOIN temporada t
ON t.numero_piloto = p.numero
WHERE p.nome LIKE '%Hamilton%'
-- Falta case when
GROUP BY p.numero,p.nome, e.nome, t.posicao


--Consultar, o código da corrida, o pais, e a quantidade de abandonos 
--(quantidade de pilotos cuja posicao = 0) em uma coluna chamada qtd_abandonos
--Essa consulta devrá ser feita para corridas com mais de 5 abandonos
--A saída deve ser ordenada pelo código de corridas (crescente)
