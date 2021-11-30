USE LojaDeBrinquedos
GO

SELECT * FROM CLIENTE
SELECT * FROM FORNECEDORES
SELECT * FROM PEDIDO
SELECT * FROM PRODUTO

SELECT p.qde, p.valor_total, (p.valor_total * 0.25) AS desconto
FROM PEDIDO p INNER JOIN CLIENTE c
ON c.codigo = p.codigo_cliente
WHERE c.nome LIKE '%Maria Clara%'

SELECT pr.nome
FROM PRODUTO pr
WHERE pr.qde_estoque = 0

UPDATE PRODUTO
SET valor_unitario = (6.00 * 0.10)
WHERE nome LIKE 'Chocolate com Paçoquinha';

UPDATE PRODUTO
SET qde_estoque = 10
WHERE nome LIKE 'Faqueiro';
