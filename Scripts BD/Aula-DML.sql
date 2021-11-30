create database aulaselect
use aulaselect

CREATE DATABASE loja

USE loja

create table pessoa(
codigo int identity not null,
nome varchar(30) not null,
sobrenome varchar(100) not null,
logradouro varchar(200) not null,
numero int not null,
bairro varchar(100) null,
cep char(9) null,
telefone varchar(11)
primary key (codigo))

insert into pessoa values
('Jo�o','dos Santos','Av. �guia de Haia',1875,'Cid. A.E. Carvalho','09874974','11985473654'),
('Maria','da Silva', 'Av. S�o Miguel', 125,'S�o Miguel','09651854','1123654878'),
('Ana','de Souza','Av. do Imperador',1532, 'Cid. A.E. Carvalho','09874974',null)

insert into pessoa values
('Teste','do Teste','Av. Teste',1111,null,null,'11985473654')


create table produto(
codigo int identity(101,1) not null,
nome varchar(50) not null,
valor decimal(7,2) not null
primary key (codigo))

insert into produto values
('Chiclete', 0.50),
('Bala',0.05),
('Pirulito',0.10)

create table venda(
codigo_pessoa int not null,
codigo_produto int not null,
quantidade int not null,
preco_total decimal(7,2) not null,
data_compra date not null
primary key (codigo_pessoa, codigo_produto,data_compra)
foreign key (codigo_pessoa) references pessoa (codigo),
foreign key (codigo_produto) references produto (codigo))

insert into venda values
(1,101,3,1.5,'2013-04-15'),
(1,102,10,0.5,'2013-04-15'),
(2,102,20,1.0,'2013-04-15'),
(1,102,30,1.5,'2013-04-16'),
(1,103,5,0.5,'2013-04-16')

select * from pessoa
select * from produto
select * from venda

-- Atualizar nome do Paulo de Carvalho para Jo�o Paulo de Carvalho
/*
UPDATE nomeTabela
SET coluna1 = novoValor, coluna2 = novoValor, ...
WHERE condicao
*/

UPDATE pessoa
SET nome = 'Jo�o', sobrenome = 'Paulo de Carvalho'
WHERE codigo = 4

UPDATE pessoa
SET nome = 'Jo�o', sobrenome = 'Paulo de Carvalho'
WHERE nome = 'Paulo' AND sobrenome = 'de Caravalho'

/*
SELECT coluna1, coluna2, ... , colunaN
FROM nomeTabela
WHERE condicao
*/

-- Consulta simples do endere�o e telefone de todos
SELECT logradouro AS rua, numero, cep, bairro, telefone
FROM pessoa

-- Consulta simples do endere�o e telefone de Jo�o
SELECT logradouro, numero, bairro, cep, telefone
FROM pessoa
WHERE nome = 'Jo�o'

-- Se houver mais de um Jo�o
SELECT logradouro, numero, bairro, cep, telefone
FROM pessoa
WHERE nome = 'Jo�o' AND sobrenome = 'dos Santos'

-- se n�o souber o sobrenome exato de Jo�o
SELECT nome, sobrenome, logradouro, numero, bairro, cep, telefone
FROM pessoa
WHERE nome LIKE 'Jo%'

SELECT nome, sobrenome, logradouro, numero, bairro, cep, telefone
FROM pessoa
WHERE nome LIKE 'Jo%' AND sobrenome LIKE '%Car%'

-- Nome e Sobrenome concatenados de quem n�o tem telefone
SELECT nome+' '+sobrenome AS nome_completo
FROM pessoa
WHERE telefone IS NULL
-- Nome e Sobrenome concatenados de quem tem telefone em Ordem alfab�tica

SELECT nome+' '+sobrenome AS nome_completo 
FROM pessoa 
WHERE telefone IS NOT NULL 
ORDER BY nome

-- nome_completo, endere�o_completo de Maria da Silva
SELECT nome+' '+sobrenome AS nome_completo,
	logradouro+' n�'+CAST(numero AS VARCHAR(7))+
	' CEP:'+cep+' Bairro:'+Bairro
	AS endereco_completo
FROM pessoa
WHERE nome = 'Maria' AND sobrenome = 'da Silva'


SELECT nome+' '+sobrenome AS nome_completo,
	logradouro+' n�'+CONVERT(VARCHAR(7),numero)+
	' CEP:'+cep+' Bairro:'+Bairro
	AS endereco_completo
FROM pessoa
WHERE nome = 'Maria' AND sobrenome = 'da Silva'


-- Calcular 5% de desconto no valor dos produtos
SELECT * FROM Produto

SELECT nome, valor, 
	CAST(valor * 0.95 AS DECIMAL(7,2)) AS valor_desconto
FROM PRODUTO



SELECT nome, valor, 
	CAST(valor - valor * 0.05 AS DECIMAL(7,2)) AS valor_desconto
FROM PRODUTO


--CAST (coluna AS novoTipoDado)
-- Mostrar quais produtos custam menos de 0.25 e seus valores
SELECT nome, valor
FROM produto
WHERE valor <= 0.25

-- Mostrar quais produtos custam mais de 0.25 e seus valores
SELECT nome, valor
FROM produto
WHERE valor > 0.25

-- Mostrar quais produtos tem pre�o entre 0.05 e 0.15
SELECT nome, valor
FROM produto
WHERE valor >= 0.05 AND valor < 0.15

--BETWEEN
SELECT nome, valor
FROM produto
WHERE valor BETWEEN 0.05 AND 0.15

-- Mostrar quais produtos tem pre�o menor que 0.05 e maior que 0.15
SELECT nome, valor
FROM produto
WHERE valor NOT BETWEEN 0.05 AND 0.15

--Informa��es de compra com data formatada
SELECT codigo_pessoa, codigo_produto, quantidade,
	CONVERT(CHAR(10),data_compra,103) as data,
	CONVERT(CHAR(5),data_compra,108) as hora 
FROM venda

--Excluir a pessoa Maria
/*
DELETE nomeTabela
WHERE condicao
*/
DELETE pessoa
WHERE nome LIKE 'Mar%'