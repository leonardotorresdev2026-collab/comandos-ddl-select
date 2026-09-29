DROP DATABASE IF EXISTS DBLojaGamer;

CREATE DATABASE IF NOT EXISTS DBLojaGamer
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_general_ci;

USE DBLojaGamer;

CREATE TABLE IF NOT EXISTS produtos (
id INT NOT NULL AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL UNIQUE,
categoria VARCHAR(30) NOT NULL,
preco DECIMAL(8,2) NOT NULL,
estoque INT DEFAULT 0,
data_cadastro DATE,
PRIMARY KEY (id)
) DEFAULT CHARSET = utf8mb4;

INSERT INTO produtos (nome, categoria, preco, estoque, data_cadastro) VALUES
('Mouse Sem Fio Logi', 'Periféricos', 89.90, 45, '2023-01-15'),
('Teclado Mecânico RGB', 'Periféricos', 250.00, 20, '2023-02-10'),
('Monitor UltraWide 29', 'Monitores', 1200.00, 8, '2022-11-20'),
('Headset Gamer USB', 'Periféricos', 180.50, 0, '2023-03-05'),
('Webcam Full HD 1080p', 'Periféricos', 210.00, 15, '2023-04-12'),
('Cadeira Ergonômica', 'Móveis', 850.00, 5, '2022-08-30'),
('Mesa Gamer em L', 'Móveis', 620.00, 3, '2022-09-15'),
('Notebook Core i5 16GB', 'Informática', 3450.00, 12, '2023-05-01'),
('SSD NVMe 1TB', 'Hardware', 420.00, 30, '2023-01-20'),
('HD Externo 2TB', 'Hardware', 380.00, 0, '2022-10-10'),
('Memória RAM 16GB DDR4', 'Hardware', 280.00, 25, '2023-02-28'),
('Placa de Vídeo RTX 3060', 'Hardware', 2100.00, 4, '2023-03-18'),
('Processador Ryzen 7', 'Hardware', 1450.00, 10, '2023-04-02'),
('Fonte Atx 650w Bronze', 'Hardware', 350.00, 18, '2023-01-05'),
('Gabinete Mid Tower', 'Hardware', 290.00, 7, '2022-12-01'),
('Impressora Multifuncional', 'Escritório', 780.00, 6, '2023-02-15'),
('Nobreak 1200VA', 'Escritório', 920.00, 2, '2022-07-22'),
('Filtro de Linha 6 Tomadas', 'Escritório', 45.90, 50, '2023-05-10'),
('Hub USB 3.0 4 Portas', 'Periféricos', 65.00, 0, '2023-03-22'),
('Suporte para Monitor Duo', 'Móveis', 190.00, 14, '2023-01-30'),
('Suporte para Notebook', 'Móveis', 75.00, 22, '2023-04-20'),
('Cabo HDMI 2.1 2m', 'Periféricos', 35.00, 60, '2023-02-05'),
('Roteador Wi-Fi 6 Gigabit', 'Redes', 320.00, 9, '2023-03-30'),
('Switch 8 Portas Gigabit', 'Redes', 140.00, 11, '2022-11-05'),
('Mochila para Notebook', 'Escritório', 160.00, 16, '2023-01-18');

/*1. [Seleção de Campos e Ordenação] Exiba o nome, a categoria e o preço de todos os
produtos, ordenando do produto mais barato para o mais caro.*/
select nome, categoria, preco
from produtos
order by preco asc;

/*2. [Operador LIKE] Liste todos os produtos cujos nomes começam com a palavra
'Suporte'.*/
select * 
from produtos
where nome like 'Suporte%';

/*3. [Operador LIKE] Encontre todos os produtos que possuem o termo 'Gamer' em
qualquer parte do nome.*/
select * 
from produtos
where nome like '%Gamer%';

/*4. [Operadores Lógicos AND] Selecione o nome, a categoria e o estoque dos produtos da
categoria 'Hardware' que custam menos de R$ 500,00.*/
select nome, categoria, estoque
from produtos
where categoria = 'Hardware' and preco < 500
order by preco asc;

/*5. [Operadores Lógicos OR] Liste o nome e a categoria dos produtos que pertencem à
categoria 'Móveis' OU à categoria 'Escritório'.*/
select nome, categoria
from produtos
where categoria = 'Móveis' or categoria = 'Escritório';

/*6. [Operador IN] Exiba o nome e a categoria dos produtos que fazem parte de uma das
seguintes categorias: 'Redes', 'Monitores' ou 'Informática'.*/
select nome, categoria
from produtos
where categoria in ('Redes', 'Monitores', 'Informática');

/*7. [Filtro de Estoque / ZEROS] Mostre o nome e a categoria de todos os produtos que
estão com o estoque totalmente esgotado (estoque igual a 0).*/
select nome, categoria
from produtos
where estoque = 0;

/*8. [Operador BETWEEN] Liste todos os produtos com preço entre R$ 100,00 e R$
400,00, ordenando do maior preço para o menor.*/
select *
from produtos
where preco between 100 and 400
order by preco desc;

/*9. [Operadores Lógicos NOT] Exiba o nome e a categoria de todos os produtos, exceto os
produtos da categoria 'Periféricos'.*/
select nome, categoria
from produtos
where not categoria = 'Periféricos';

/*10. [Função COUNT] Retorne a quantidade total de produtos cadastrados na tabela.*/
select count(*) as total_produtos
from produtos;

/*11. [Função COUNT com Filtro] Descubra quantos produtos cadastrados possuem valor
unitário superior a R$ 1.000,00.*/
select count(*) as carga_maior1000
from produtos
where preco > 1000;

/*12. [Função SUM] Calcule a quantidade total de itens que a loja possui em estoque somando
a coluna estoque.*/
select sum(estoque) as soma_estoque
from produtos;

/*13. [Função AVG] Exiba a média dos preços unitários de todos os produtos da tabela.*/
select avg(preco) as media_precos
from produtos;

/*14. [Funções MAX e MIN] Mostre o maior preço e o menor preço entre todos os produtos
em uma única consulta.*/
select min(preco) as menor_carga,
 max(preco) as maior_carga
from produtos;

/*15. [Função MAX com Filtro] Encontre o maior preço entre os produtos que pertencem à
categoria 'Periféricos'.*/
select max(preco) as maior_preçoPeriféricos
from produtos
where categoria = 'Periféricos';

/*16. [Group By Simples] Agrupe e exiba a quantidade total de produtos cadastrados por
cada categoria.*/
select categoria, count(*) as quantidade_produtos
from produtos
group by categoria;

/*17. [Group By com Soma] Exiba a quantidade total de itens em estoque (SUM(estoque))
para cada categoria.*/
select categoria, sum(estoque) as total_estoque
from produtos
group by categoria;

/*18. [Group By com Média] Mostre o preço médio dos produtos agrupados por cada
categoria.*/
SELECT categoria, AVG(preco) AS preco_medio
FROM produtos
GROUP BY categoria;

/*19. [Having com Count] Exiba as categorias que possuem mais de 4 produtos cadastrados.*/
SELECT categoria, COUNT(*) AS quantidade_produtos
FROM produtos
GROUP BY categoria
HAVING COUNT(*) > 4;

/*20. [Having com Média] Apresente apenas as categorias cuja média de preços seja superior
a R$ 300,00.*/
select categoria, avg(preco) as preco_medio
from produtos
group by categoria
having avg (preco) > 300;

/*21. [Desafio 1 - Cálculo de Valor de Inventário] Crie uma consulta que retorne o nome, o
preco, o estoque e uma coluna calculada chamada valor_total_estoque (que é o produto
entre preco e estoque). Exiba apenas produtos que possuem estoque e ordene pelo
maior valor em estoque acumulado.*/
SELECT 
nome,
preco,
estoque,
(preco * estoque) AS valor_total_estoque
FROM produtos
WHERE estoque > 0
ORDER BY valor_total_estoque DESC;

/*22. [Desafio 2 - Relatório de Reposição Urgente] Escreva uma consulta que traga os
produtos que precisam de reposição urgente. A regra é: produtos com estoque menor
ou igual a 5 unidades (incluindo zerados) E que pertençam às categorias 'Hardware' ou
'Periféricos'.*/
SELECT nome, categoria, estoque
FROM produtos
WHERE estoque <= 5
AND categoria IN ('Hardware', 'Periféricos');

/*23. [Desafio 3 - Análise de Cadastros por Período] Liste os produtos que foram
cadastrados durante o primeiro trimestre de 2023 (entre '2023-01-01' e '2023-03-31'),
ordenando pela data de cadastro mais recente.*/
SELECT *
FROM produtos
WHERE data_cadastro BETWEEN '2023-01-01' AND '2023-03-31'
ORDER BY data_cadastro DESC;

/*24. [Desafio 4 - Análise Combinada de Categorias Estratégicas] Descubra quais
categorias possuem uma média de estoque acumulado (AVG(estoque)) menor que 15
unidades, desconsiderando do cálculo a categoria 'Monitores'.*/
SELECT categoria, AVG(estoque) AS media_estoque
FROM produtos
WHERE categoria <> 'Monitores'
GROUP BY categoria
HAVING AVG(estoque) < 15;

/*25. [Desafio 5 - Produtos 'Fora do Padrão' de Preço] Encontre todos os produtos cujo
preço individual seja maior do que a média geral de preço de toda a tabela (Dica: utilize
uma subconsulta simples WHERE preco > (SELECT AVG(preco) FROM produtos)).*/
SELECT nome, categoria, preco
FROM produtos
WHERE preco > (
    SELECT AVG(preco)
    FROM produtos
);
