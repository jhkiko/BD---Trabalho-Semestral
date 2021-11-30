CREATE DATABASE exaula2
GO
USE exaula2
GO
CREATE TABLE fornecedor (
ID				INT				NOT NULL	PRIMARY KEY,
nome			VARCHAR(50)		NOT NULL,
logradouro		VARCHAR(100)	NOT NULL,
numero			INT				NOT NULL,
complemento		VARCHAR(30)		NOT NULL,
cidade			VARCHAR(70)		NOT NULL
)

GO
CREATE TABLE cliente (
cpf			CHAR(11)		NOT NULL		PRIMARY KEY,
nome		VARCHAR(50)		NOT NULL,	
telefone	VARCHAR(9)		NOT NULL,
)

GO
CREATE TABLE produto (
codigo		INT				NOT NULL	PRIMARY KEY,
descricao	VARCHAR(50)		NOT NULL,
fornecedor	INT				NOT NULL,
preco		DECIMAL(7,2)	NOT NULL
FOREIGN KEY (fornecedor) REFERENCES fornecedor(ID)
)

GO
CREATE TABLE venda (
codigo			INT				NOT NULL,
produto			INT				NOT NULL,
cliente			CHAR(11)		NOT NULL,
quantidade		INT				NOT NULL,
data			DATE			NOT NULL
PRIMARY KEY (codigo, produto, cliente, data)
FOREIGN KEY (produto) REFERENCES produto (codigo),
FOREIGN KEY (cliente) REFERENCES cliente (cpf)
)


--Quantos produtos não foram vendidos (nome da coluna qtd_prd_nao_vend) ?

SELECT COUNT(p.codigo) as [Produtos não vendidos]
FROM produto p LEFT OUTER JOIN venda v
ON   v.produto = p.codigo 
WHERE v.codigo IS NULL

--Descrição do produto, Nome do fornecedor, count() do produto nas vendas

SELECT p.descricao, f.nome, COUNT(v.produto)
FROM produto p, fornecedor f, venda v
WHERE p.fornecedor = f.ID
  AND p.codigo = v.produto
GROUP BY p.descricao, f.nome

-- Nome do cliente e Quantos produtos cada um comprou ordenado pela quantidade
SELECT c.nome, COUNT(v.quantidade) AS quantia
FROM cliente c INNER JOIN venda v
ON c.cpf = v.cliente
GROUP BY c.nome
ORDER BY quantia

--Descrição do produto e Quantidade de vendas do produto com menor valor do catálogo de produtos
SELECT p.descricao, SUM(v.quantidade) AS Quantia
FROM produto p INNER JOIN venda v
ON p.codigo = v.produto
WHERE p.preco IN (SELECT MIN (preco) FROM produto)
GROUP by p.descricao

--Nome do Fornecedor e Quantos produtos cada um fornece
SELECT f.nome, COUNT(p.codigo) as qtd
FROM fornecedor f INNER JOIN produto p
ON f.id = p.fornecedor
GROUP BY f.nome

--Considerando que hoje é 20/10/2019, consultar, sem repetições, o código da compra, nome do cliente, telefone do cliente (Mascarado XXXX-XXXX ou XXXXX-XXXX) e quantos dias da data da compra

SELECT DISTINCT v.codigo, c.nome,
    CASE WHEN (LEN(c.telefone) = 8) THEN SUBSTRING(c.telefone, 1, 4) + '-' + SUBSTRING(c.telefone, 5, 4)
         WHEN (LEN(c.telefone) = 9) THEN SUBSTRING(c.telefone, 1, 5) + '-' + SUBSTRING(c.telefone, 6, 4)
    END as telefone,
    DATEDIFF(DAY, v.data, '2019-10-20') AS [Dias apos a compra]
FROM cliente c INNER JOIN venda v
ON c.cpf = v.cliente

--CPF do cliente, mascarado (XXX.XXX.XXX-XX), Nome do cliente e quantidade comprada dos clientes que compraram mais de 2 produtos
SELECT v.codigo, SUBSTRING(c.cpf,1,3) + '-' + SUBSTRING(c.cpf,4,6) + '-' + SUBSTRING(c.cpf,7,9) + '-' + SUBSTRING (c.cpf,10,11) AS cpf_, 
c.nome
FROM cliente c
INNER JOIN venda v
ON c.cpf = v.cliente

--Sem repetições, Código da venda, CPF do cliente, mascarado (XXX.XXX.XXX-XX), Nome do Cliente e Soma do valor_total gasto(valor_total_gasto = preco do produto * quantidade de venda).Ordenar por nome do cliente



--Código da venda, data da venda em formato (DD/MM/AAAA) e uma coluna, chamada dia_semana, que escreva o dia da semana por extenso

--Exemplo: Caso dia da semana 1, escrever domingo. Caso 2, escrever segunda-feira, assim por diante, até caso dia 7, escrever sábado