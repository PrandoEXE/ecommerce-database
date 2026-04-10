		-- cirando database de ecommerce--
	-- drop database ecommerce;
	create database ecommerce;
	use ecommerce;
	SHOW DATABASES;


	-- criar tabela cliente

	create table clients(
		idClient int auto_increment primary key,
		Fname varchar(20),
		Minit char (3),
		Lname varchar (20),
		CPF char (11) not null,
		Address varchar (255),
		constraint unique_cpf_client unique (CPF)
	);

	alter table clients auto_increment = 1;

	create table clients_pj(
		idClient int primary key,
		CNPJ char(14) unique,
		socialName varchar(255),
		foreign key (idClient) references clients(idClient)
	);

	alter table clients_pj auto_increment = 1;

	create table payments(
		idClient int,
		idPayment int,
		TypePayment enum('Boleto','Cartão','Dois Cartão'),
		LimitAvailable float,
		primary key(idClient, idPayment),
		constraint fk_payment_client 
		foreign key (idClient) references clients(idClient)
	);

	-- criar tabela produto 
	create table product(
		idProduct int auto_increment primary key,
		Pname varchar(20),
		Classification_kids boolean,
		Category enum('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis'),
		avaliation float default 0, 
		size varchar(10),
		Pvalue float(10)
	);

	alter table product auto_increment = 1;

	create table orders(
		idOrder int auto_increment primary key,
		idOrderClient int,
		orderStatus enum('Cancelado','Confirmado','Em Processamento') default 'Em Processamento',
		orderDescription varchar(255),
		sendValue float default 10,
		paymentCash bool default false,
		constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
			on update cascade 
	);

	alter table orders auto_increment = 1;

	create table delivery (
		idDelivery int auto_increment primary key,
		idDeliveryOrder int,
		deliveryStatus varchar(50),
		trackingCode varchar(100),
		foreign key (idDeliveryOrder) references orders(idOrder)
	);

	alter table delivery auto_increment = 1;

	-- criar tabela estoque
	create table productStorage(
		idProdStorage int auto_increment primary key,
		storageLocation varchar(255),
		quantity int default 0
	);

	alter table productStorage auto_increment = 1;

	-- criar tabela fornecedor

	create table supplier(
		idSupplier int auto_increment primary key,
		socialName varchar(255) not null,
		CNPJ char (15) not null,
		contact varchar(10) not null,
		constraint unique_supplier unique (CNPJ)
	);

	alter table supplier auto_increment = 1;

	-- criar tabela vendedor

	create table seller(
		idSeller int auto_increment primary key,
		AbsName varchar(255) not null,
		socialName varchar(255) not null,
		CNPJ char (15),
		CPF varchar(9),
		location varchar(255),
		constraint unique_cnpj_seller unique (CNPJ),
		constraint unique_cpf_seller unique (CPF)
	);

	alter table seller auto_increment = 1;

	create table ProductSeller(
		idPseller int,
		idPproduct int,
		ProdQuantity int default 1,
		primary key (idPseller, idPproduct),
		constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
		constraint fk_product_product foreign key (idPproduct) references product(idProduct)
	);

	create table ProductOrder(
		idPOproduct int,
		idPOorder int,
		PoQuantity int default 1,
		PoStatus enum('Disponivel', 'Sem estoque') default 'Disponivel',
		primary key (idPOproduct, idPOorder),
		constraint fk_productorder_product foreign key (idPOproduct) references product(idProduct),
		constraint fk_fk_productorder_order  foreign key (idPOorder) references orders(idOrder)
	);

	create table storageLocation(
		idLproduct int,
		idLstorage int,
		location varchar(255) not null,
		primary key (idLproduct, idLstorage),
		constraint fk_storagelocation_product foreign key (idLproduct) references product(idProduct),
		constraint fk_storagelocation_storage foreign key (idLstorage) references productStorage(idProdStorage)
	);

	create table productSupplier (
		idPsSupplier int,
		idPsProduct int,
		quantity int not null,	
		primary key (idPsSupplier, idPsProduct),
		constraint fk_product_supplier_supplier foreign key (idPsSupplier) references Supplier(idSupplier),
		constraint fk_product_supplier_product	foreign key (idPsProduct) references product(idProduct)
	);

	show tables;
	-- use information_schema;