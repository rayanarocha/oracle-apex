--consultando todas as as linhas da tabela CUSTOMER
select * from customer;

-- consultando apenas as tabelas CUSTOMER_ID e NAME da tabela CUSTOMER
select customer_id, name from customer;

-- selecionando todas as linhas da tabelas PRODUCT
select * from product;

-- calculando +7% acima de PRICE
select 
product_id, 
description, 
price, 
price * 1.07 as taxed_price 
from product;

-- alterando o nome da coluna PRICE para UNTAXED_PRICE dentro da instrução SELECT
select
product_id,
description,
price as untaxed_price,
price * 1.07 as taxed_price
from product;

-- formatando casas decimais da coluna TAXED_PRICE
select
product_id,
description,
price,
round(price * 1.07, 2) as taxed_price
from product;