USE Exercicios04

SELECT * FROM CLIENTE
SELECT * FROM PRODUTO
SELECT * FROM FORNECEDOR
SELECT * FROM VENDA

SELECT CONVERT(VARCHAR(10),v.data_,103) as data
FROM venda v 
WHERE v.codigo LIKE 4

-- Ordem alfabética de f.nome
SELECT f.nome, f.logradouro, f.n, f.complemento, f.cidade, f.telefone
FROM FORNECEDOR f
ORDER BY f.nome ASC

SELECT v.produto, v.quantidade, v.valor_total
FROM VENDA v INNER JOIN CLIENTE c
ON c.cpf = v.cliente
WHERE c.nome LIKE '%Julio Cesar%'

SELECT CONVERT(VARCHAR(10), v.data_,103) AS data, v.valor_total
FROM VENDA v INNER JOIN CLIENTE c
ON c.cpf = v.cliente
WHERE c.nome LIKE '%Paulo Cesar%'

SELECT p.descricao, p.preco
FROM PRODUTO p INNER JOIN VENDA v
ON v.produto = p.codigo
ORDER BY p.preco DESC
