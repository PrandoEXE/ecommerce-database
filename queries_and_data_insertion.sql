use ecommerce;
show tables;

insert into clients (Fname, Minit, Lname, CPF, Address)
	values('Maria', 'M', 'Silva', 123456789, 'rua silva da prata 29, Centro - Cidade das flores'),
		  ('Matheus', 'O', 'Pimentel', 987654321, 'rua alameda 289, Centro - Cidade das flores'),
		  ('Ricardo', 'F', 'Silva', 456789123, 'avenida alameda vinha 1009, Centro - Cidade das flores'),
          ('Julia', 'S', 'França', 789123456, 'rua lareijras vinha 861, Centro - Cidade das flores'),
          ('Roberta', 'G', 'Assis', 987456321, 'avenida koller 19, Centro - Cidade das flores'),
          ('Isabela', 'M', 'Cruz', 654789123, 'rua alameda das flores 28, Centro - Cidade das flores');
          
insert into product(Pname, Classification_kids, Category, avaliation, size, Pvalue)
	values('Fone de ouvido',false,'Eletrônico','4',null, '50'),
		  ('Barbie Elsa',true,'Brinquedos','3',null, '40'),
          ('Microfone Vedo',false,'Eletrônico','4',null,'80'),
          ('Body Carters',true,'Vestimenta','5',null, '50'),
		  ('Sofa Retrátil',false,'Móveis','3','	3x57x80','100'),
          ('Farinha de Arroz',false,'Alimentos','2',null, '10'),
          ('Fire Stick da Amazon',false,'Eletrônico','3',null, '150');
          
select * from clients;
select * from product;

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash)
	value(1, default, 'compra pelo aplicativo', null, 1),
		(2, default, 'compra pelo aplicativo', 50, 0),
        (3,'Confirmado', null, null, 1),
		(4, default, 'compra via website', 150, 1);
        
select * from orders;

insert into ProductOrder(idPOproduct, idPOorder, PoQuantity, PoStatus)
	value(1,1,2,null),
		 (2,1,2,null),
         (3,2,1,null);
         
select * from ProductOrder;

insert into productStorage (storageLocation, quantity)
	value('Rio de Janeiro', 1000),
		 ('Rio de Janeiro', 500),
         ('São Paulo', 10),
         ('São Paulo', 100),
         ('São Paulo', 10),
         ('Brasília	', 60);
         
select * from productStorage;
         
insert into storageLocation (idLproduct, idLstorage, location)
	value(1, 2,'RJ'),
		 (2, 6,'GO');
         
select * from storageLocation;
         
insert into Supplier (socialName, CNPJ, contact)
	value('Almeida e filhos', 123456789123,'21985474'),
		 ('Eletrônicos Silva', 123456123456,'21985484'),
         ('Eletrônicos Valma', 321654987321,'21888474');
         
select * from Supplier;

insert into productSupplier (idPsSupplier, idPsProduct, quantity)
	value( 1, 1,500),
		 ( 1, 2,400),
         ( 2, 4,633),
         ( 3, 3, 5),
         ( 2, 5, 10);
         
select * from productSupplier;

insert into seller (socialName, AbsName, CNPJ, CPF, location)
	value('Tech Eletronics', 'TE', 123789456789, null, 'Rio de Janeiro'),
		 ('Botique Durgas', 'BD', null, 123654987, 'Rio de Janeiro'),
         ('Kids Worlds', 'KW', 456987321456, null, 'São Paulo');
         
select * from seller;

insert into productSeller (idPseller, idPproduct, ProdQuantity)
	value(1,6,80),
		 (2,7,10);
         
insert into delivery (idDeliveryOrder, deliveryStatus, trackingCode)
values 
(1, 'Enviado', 'BR123'),
(2, 'Em transporte', 'BR456');


-- Quantos pedidos por cliente
select 
    c.Fname,
    c.Lname,
    count(o.idOrder) as total_pedidos
from clients c
left join orders o on c.idClient = o.idOrderClient
group by c.idClient;

-- Valor total por pedido
select 
    po.idPOorder,
    sum(po.PoQuantity * p.Pvalue) as total_pedido
from ProductOrder po
join product p on po.idPOproduct = p.idProduct
group by po.idPOorder;

-- Clientes que gastaram mais de 100
select 
    c.idClient,
    sum(p.Pvalue * po.PoQuantity) as total_gasto
from clients c
join orders o on c.idClient = o.idOrderClient
join ProductOrder po on o.idOrder = po.idPOorder
join product p on po.idPOproduct = p.idProduct
group by c.idClient
having total_gasto > 100;

-- Produtos com estoque baixo
select 
    p.Pname,
    ps.quantity
from product p
join productStorage ps on p.idProduct = ps.idProdStorage
where ps.quantity < 50;

-- Relação fornecedor com produto

select 
    s.socialName as fornecedor,
    p.Pname as produto
from supplier s
join productSupplier ps on s.idSupplier = ps.idPsSupplier
join product p on ps.idPsProduct = p.idProduct;

-- Vendedor também é fornecedor 

select 
    s.socialName
from seller s
join supplier f 
    on s.CNPJ = f.CNPJ;

-- Pedidos com entrega
select * from delivery;
select 
    c.Fname,
    o.idOrder,
    d.deliveryStatus,
    d.trackingCode
from orders o
join clients c on o.idOrderClient = c.idClient
join delivery d on d.idDeliveryOrder = o.idOrder;

-- Ordenação de produto pelo valor

select * 
from product
order by Pvalue desc;