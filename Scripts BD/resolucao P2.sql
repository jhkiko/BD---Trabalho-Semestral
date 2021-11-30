--Lazaro
-- 1) Consultar o nome completo (concatenado), o trabalho e o nome do
--projeto e a data em padr�o BR (DD/MM/YYYY),
-- do funcion�rio mais velho em projetos dentre os cadastrados
--Query da quest�o 1
SELECT e.emp_pri_nome, e.emp_ult_nome, ep.trabalho, p.proj_nome,
CONVERT(VARCHAR(10), ep.data_inicio,103) AS data_padrao_BR,
MIN(DATEDIFF(DAY,ep.data_inicio,GETDATE())) AS funcionario_mais_velho
FROM emp_proj ep INNER JOIN empregado e
ON e.emp_no = ep.emp_no
INNER JOIN projeto p
ON p.proj_no = ep.proj_no
GROUP BY e.emp_pri_nome, e.emp_ult_nome, ep.trabalho,
p.proj_nome, ep.data_inicio; -- do funcion�rio mais velho em projetos dentre os cadastrados SELECT ep.emp_no, e.emp_pri_nome, MIN(DATEDIFF(DAY,ep.data_inicio,GETDATE())) AS funcionario_mais_velho FROM emp_proj ep INNER JOIN empregado e ON e.emp_no = ep.emp_no GROUP BY ep.emp_no, ep.data_inicio, e.emp_pri_nome



-- Resposta poss�vel:
SELECT e.emp_pri_nome+' '+e.emp_ult_nome AS nome_completo,
ep.trabalho, p.proj_nome,
CONVERT(CHAR(10),ep.data_inicio,103) AS dt_inicio
FROM empregado e INNER JOIN emp_proj ep
ON e.emp_no = ep.emp_no
INNER JOIN projeto p
ON ep.proj_no = p.proj_no
WHERE ep.data_inicio IN
(SELECT MIN(data_inicio)
FROM emp_proj)


-- 2) Nome do Departamento, Localiza��o do departamento que n�o tem
--funcion�rios cadastrados.
-- A localiza��o deve mostrar apenas as duas primeiras letras,
--seguidas de um ponto(.).
--Query da quest�o 2
SELECT d.depto_nome, d.localizacao,
SUBSTRING(d.localizacao,1,2) + '.' AS localizacao,
e.depto_no
FROM departamento d FULL OUTER JOIN empregado e
ON e.depto_no = d.depto_no;



--Repsosta poss�vel:
SELECT d.depto_nome, SUBSTRING(d.localizacao,1,2)+'.' AS localizacao
FROM departamento d LEFT OUTER JOIN empregado e
ON d.depto_no = e.depto_no
WHERE e.depto_no IS NULL



-- 3) Consultar quantos funcion�rios est�o cadastrados em cada projeto
--(nome de coluna 'quantidade')
-- e o nome do projeto, ordenado de maneira descrescente pelo nome
--do projeto
--Query da quest�o 3
SELECT ep.emp_no, p.proj_nome, MAX(ep.proj_no) AS quantidade
FROM emp_proj ep INNER JOIN empregado e
ON e.emp_no = ep.emp_no
INNER JOIN projeto p
ON ep.proj_no = p.proj_no
GROUP BY ep.emp_no, p.proj_nome
ORDER BY p.proj_nome DESC;



--Resposta poss�vel:
SELECT COUNT(e.emp_no) AS quantidade, p.proj_nome
FROM empregado e INNER JOIN emp_proj ep
ON e.emp_no = ep.emp_no
INNER JOIN projeto p
ON p.proj_no = ep.proj_no
GROUP BY p.proj_nome
ORDER BY p.proj_nome DESC




-- 4) Consultar quantos projetos n�o tem empregados associados
--(A coluna deve chamar 'quantidade')
--Query da quest�o 4
SELECT ep.emp_no as quantidade
FROM emp_proj ep INNER JOIN projeto p
ON p.proj_no = ep.proj_no
FULL OUTER JOIN empregado e
ON e.emp_no = ep.emp_no
WHERE p.proj_no IS NULL
AND ep.emp_no IS NULL;



--Resposta poss�vel
SELECT COUNT(p.proj_no) AS quantidade
FROM emp_proj ep RIGHT OUTER JOIN projeto p
ON ep.proj_no = p.proj_no
WHERE ep.proj_no IS NULL


--Lazaro









