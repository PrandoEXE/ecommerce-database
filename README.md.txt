# Projeto Banco de Dados E-commerce

## Descrição
Modelagem lógica de um banco de dados para um sistema de e-commerce.

## Funcionalidades
- Clientes PF e PJ
- Pedidos
- Produtos
- Fornecedores
- Estoque
- Pagamentos múltiplos
- Entrega com rastreamento

## Estrutura do Projeto
- esquema_relacional.sql → criação das tabelas e relacionamentos
- queries.sql → inserção de dados e consultas SQL

## Consultas implementadas

### Total de pedidos por cliente
select c.Fname, count(o.idOrder)
from clients c
left join orders o on c.idClient = o.idOrderClient
group by c.idClient;

### Valor total por pedido
select po.idPOorder, sum(po.PoQuantity * p.Pvalue)
from ProductOrder po
join product p on po.idPOproduct = p.idProduct
group by po.idPOorder;

### Clientes que mais gastam
select c.idClient, sum(p.Pvalue * po.PoQuantity) as total
from clients c
join orders o on c.idClient = o.idOrderClient
join ProductOrder po on o.idOrder = po.idPOorder
join product p on po.idPOproduct = p.idProduct
group by c.idClient
having total > 100;

## Autor
Matheus Prando.EXE
