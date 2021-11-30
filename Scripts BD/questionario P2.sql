USE amostra
GO
SELECT * FROM departamento
SELECT * FROM projeto
SELECT * FROM empregado
SELECT * FROM emp_proj

-- 1) Consultar o nome completo (concatenado), o trabalho e o nome do projeto e a data em padrão BR (DD/MM/YYYY),

SELECT e.emp_pri_nome, e.emp_ult_nome, ep.trabalho, p.proj_nome,  CONVERT(VARCHAR(10), ep.data_inicio,103) AS data_padrao_BR, MIN(DATEDIFF(DAY,ep.data_inicio,GETDATE())) AS funcionario_mais_velho
FROM emp_proj ep INNER JOIN empregado e
ON e.emp_no = ep.emp_no
INNER JOIN projeto p
ON p.proj_no = ep.proj_no
GROUP BY e.emp_pri_nome, e.emp_ult_nome, ep.trabalho, p.proj_nome, ep.data_inicio;

-- do funcionário mais velho em projetos dentre os cadastrados
SELECT ep.emp_no, e.emp_pri_nome,	MIN(DATEDIFF(DAY,ep.data_inicio,GETDATE())) AS funcionario_mais_velho
FROM emp_proj ep INNER JOIN empregado e
ON e.emp_no = ep.emp_no
GROUP BY ep.emp_no, ep.data_inicio, e.emp_pri_nome

-- 2) Nome do Departamento, Localização do departamento que não tem funcionários cadastrados.
-- A localização deve mostrar apenas as duas primeiras letras, seguidas de um ponto(.).

SELECT d.depto_nome, d.localizacao,	SUBSTRING(d.localizacao,1,2) + '.' AS localizacao, e.depto_no
FROM departamento d FULL OUTER JOIN empregado e
ON e.depto_no = d.depto_no;

-- 3) Consultar quantos funcionários estão cadastrados em cada projeto (nome de coluna 'quantidade')
-- e o nome do projeto, ordenado de maneira descrescente pelo nome do projeto

SELECT  ep.emp_no, p.proj_nome, MAX(ep.proj_no) AS quantidade
FROM emp_proj ep INNER JOIN empregado e
ON e.emp_no = ep.emp_no
INNER JOIN projeto p
ON ep.proj_no = p.proj_no
GROUP BY ep.emp_no, p.proj_nome
ORDER BY p.proj_nome DESC;

-- 4) Consultar quantos projetos não tem empregados associados (A coluna deve chamar 'quantidade')

SELECT ep.emp_no as quantidade
FROM emp_proj ep INNER JOIN projeto p
ON p.proj_no = ep.proj_no
FULL OUTER JOIN empregado e
ON e.emp_no = ep.emp_no
WHERE p.proj_no IS NULL
AND ep.emp_no IS NULL;