CREATE DATABASE bcoFIO;

USE  bcoFIO;

CREATE TABLE TipoEnd
(
  Cod_TipoEnd int not null auto_increment,
  Nome_TipoEnd varchar(30) not null,

  Constraint PK_TipoEnd Primary Key(Cod_TipoEnd),
  Constraint UQ_TipoEnd Unique(Nome_TipoEnd)
);

CREATE TABLE Estado
(
  Sigla_Est char(02) not null,
  Nome_Est varchar(100) not null,

  Constraint PK_Est Primary Key(Sigla_Est),
  Constraint UQ_Est Unique(Nome_Est)
);

CREATE TABLE Cidade
(
  Cod_Cid int Not Null auto_increment,
  Sigla_Est char(02) Not Null,
  Nome_Cid varchar(100) Not Null,

  Constraint PK_Cid Primary Key(Cod_Cid),
  Constraint FK_Cid Foreign Key(Sigla_Est) References Estado(Sigla_Est),
  Constraint UQ_Cid Unique(Sigla_Est,Nome_Cid)
);

CREATE TABLE TipoCli
(
  Cod_TipoCli int not null auto_increment,
  Nome_TipoCli varchar(100) not null,

  Constraint PK_TipoCli Primary key(Cod_TipoCli),
  Constraint UQ_TipoCli Unique(Nome_TipoCli)
);

CREATE TABLE Cliente
(
  Cod_Cli int not null auto_increment,
  Cod_TipoCli int not null,
  Nome_Cli varchar(100) not null,
  Data_CadCli varchar(8) not null ,
  Renda_Cli decimal(10,2) not null Default 0,
  Sexo_Cli char(01) not null Default 'F',

  Constraint PK_Cli Primary Key(Cod_Cli),
  Constraint FK_Cli Foreign Key(Cod_TipoCli)References TipoCli(Cod_TipoCli),
  Constraint CH_Cli1 Check(Renda_Cli >=0),
  Constraint CH_Cli2 Check(Sexo_Cli IN('F','M'))
);

CREATE TABLE Conjuge
(
  Cod_Cli int not null,
  Nome_Conj char(30) not null,
  Renda_Conj decimal(10,2) not null Default 0,
  Sexo_Conj char(01) not null Default 'M',

  Constraint PK_Conj Primary Key(Cod_Cli),
  Constraint FK_Conj Foreign Key(Cod_Cli) References Cliente(Cod_Cli),
  Constraint CH_Conj1 Check(Renda_Conj >=0),
  Constraint CH_Conj2 Check(Sexo_Conj IN ('F','M'))
);

CREATE TABLE Endereco
(
  Cod_End int not null auto_increment,
  Cod_TipoEnd int not null,
  Cod_Cid int not null,
  Cod_Cli int not null,
  Nome_Rua varchar(100) not null,
  Nome_Bairro varchar(100) not null,
  Compl_End varchar(100) null,

  Constraint PK_End Primary Key(Cod_End),
  Constraint FK_End1 Foreign Key(Cod_TipoEnd) References TipoEnd(Cod_TipoEnd),
  Constraint FK_End2 Foreign Key(Cod_Cid) References Cidade(Cod_Cid),
  Constraint FK_End3 Foreign Key(Cod_Cli) References Cliente(Cod_Cli)
);

CREATE TABLE Credito
(
  Num_Lanc int not null auto_increment,
  Cod_Cli int not null,
  Cred_Cli decimal(10,2) not null,
  Data_CredCli timestamp not null,

  Constraint PK_Cred Primary Key(Num_Lanc),
  Constraint FK_Cred Foreign Key(Cod_Cli) References Cliente(Cod_Cli),
  Constraint CH_Cred Check(Cred_Cli > 0)
);

CREATE TABLE Fone
(
  Num_Lanc int not null auto_increment,
  Cod_Cli int not null,
  Num_Fone char(10) not null,
  Num_DDD char(05) not null Default '011',

  Constraint PK_Fone Primary Key(Num_Lanc),
  Constraint FK_Fone Foreign Key(Cod_Cli) References Cliente(Cod_Cli)
);

CREATE TABLE EMail
(
  Num_Lanc int not null auto_increment,
  Cod_Cli int not null,
  EMail_Cli varchar(255) not null,

  Constraint PK_Email Primary Key(Num_Lanc),
  Constraint FK_Email Foreign Key(Cod_Cli) References Cliente(Cod_Cli)
);

CREATE TABLE StatusPedido
(
  Cod_Sta smallint not null auto_increment,
  Sta_Ped varchar(100) not null,

  Constraint PK_StatusPed Primary Key(Cod_Sta),
  Constraint UQ_StatusPed Unique(Sta_Ped)
);

CREATE TABLE Funcionario
(
  Cod_Func int not null auto_increment,
  Nome_Func varchar(100) not null,
  Data_CadFunc timestamp not null Default current_timestamp,
  Sexo_Func char(01) not null Default 'F',
  Sal_Func decimal(10,2) not null Default 200,
  End_Func varchar(100) not null,

  Constraint PK_Func Primary Key(Cod_Func),
  Constraint CH_Func2 Check(Sexo_Func IN ('F','M')),
  Constraint CH_Func3 Check(Sal_Func >=0)
);

CREATE TABLE Bonus
(
  Num_Lanc int not null auto_increment,
  Cod_Func int not null,
  Data_Bonus timestamp not null default current_timestamp,
  Val_Bonus decimal(10,2) not null,

  Constraint PK_Bonus Primary Key(Num_Lanc),
  Constraint FK_Bonus Foreign Key(Cod_Func) References Funcionario(Cod_Func),
  Constraint CH_Bonus2 Check(Val_Bonus > 0)
);

CREATE TABLE Pontuacao
(
  Num_Lanc int not null auto_increment,
  Cod_Func int not null,
  Data_Pto timestamp not null default current_timestamp,
  Pto_Func decimal(4,2) not null,

  Constraint PK_Pto Primary Key(Num_Lanc),
  Constraint FK_Pto Foreign Key(Cod_Func) References Funcionario(Cod_Func),
  Constraint CH_Pto2 Check(Pto_Func > 0)
);

CREATE TABLE Historico
(
  Num_Lanc int not null auto_increment,
  Cod_Func int not null,
  Data_Hist timestamp not null Default current_timestamp,
  Sal_Ant decimal(10,2) not null,
  Sal_Atual decimal(10,2) not null,

  Constraint PK_Hist Primary Key(Num_Lanc),
  Constraint FK_Hist Foreign Key(Cod_Func) References Funcionario(Cod_Func),
  Constraint CH_Hist2 Check(Sal_Ant >= 0),
  Constraint CH_Hist3 Check(Sal_Ant > 0)
);

CREATE TABLE Dependente
(
  Cod_Dep int auto_increment not null,
  Cod_Func int not null,
  Nome_Dep varchar(100) not null,
  Data_NascDep timestamp not null,
  Sexo_Dep char(01) not null Default 'F',

  Constraint PK_Dep Primary Key(Cod_Dep),
  Constraint FK_Dep Foreign Key(Cod_Func)References Funcionario(Cod_Func),
  Constraint CH_Dep Check(Sexo_Dep IN ('F','M'))
);

CREATE TABLE Pedido
(
  Num_Ped int auto_increment not null,
  Cod_Cli int not null,
  Cod_Func int not null,
  Cod_Sta smallint not null,
  Data_Ped timestamp not null Default current_timestamp,
  Val_Ped decimal(10,2) not null Default 0,

  Constraint PK_Pedido  Primary Key(Num_Ped),
  Constraint FK_Pedido1 Foreign Key(Cod_Cli) References Cliente(Cod_Cli),
  Constraint FK_Pedido2 Foreign Key(Cod_Func) References Funcionario(Cod_Func),
  Constraint CH_Pedido2 Check(Val_Ped >=0)
);

CREATE TABLE Parcela
(
  Num_Par smallint not null,
  Num_Ped int not null,
  Data_Venc timestamp not null Default current_timestamp,
  Val_Venc decimal(10,2) not null,
  Data_Pgto timestamp null,

  Constraint PK_Parcela Primary key(Num_Par,Num_Ped),
  Constraint FK_Parcela Foreign Key(Num_Ped)References Pedido(Num_Ped),
  Constraint CH_Parcela2 Check(Val_Venc >= 0)
);

CREATE TABLE TipoProd
(
  Cod_TipoProd int auto_increment not null,
  Nome_TipoProd varchar(100) not null,

  Constraint PK_TipoProd Primary Key(Cod_TipoProd),
  Constraint UQ_TipoProd Unique(Nome_TipoProd)
);

CREATE TABLE Produto
(
  Cod_Prod int auto_increment not null,
  Cod_TipoProd int not null,
  Nome_Prod varchar(100) not null,
  Qtd_EstqProd int not null Default 0,
  Val_UnitProd decimal(10,2) not null,

  Constraint PK_Prod Primary Key(Cod_Prod),
  Constraint FK_Prod Foreign Key(Cod_TipoProd) References TipoProd(Cod_TipoProd),
  Constraint UQ_Prod Unique(Nome_Prod),
  Constraint CH_Prod1 Check(Qtd_EstqProd >= 0),
  Constraint CH_Prod2 Check(Val_UnitProd >  0)
);

CREATE TABLE Itens
(
  Num_Ped int not null,
  Cod_Prod int not null,
  Qtd_Vend int not null,
  Val_Vend decimal(10,2) not null,

  Constraint PK_Itens Primary Key(Num_Ped,Cod_Prod),
  Constraint FK_Itens1 Foreign Key(Num_Ped)  References Pedido(Num_Ped),
  Constraint FK_Itens2 Foreign Key(Cod_Prod) References Produto(Cod_Prod),
  Constraint CH_Itens1 Check(Qtd_Vend > 0),
  Constraint CH_Itens2 Check(Val_Vend > 0)
);

SELECT * FROM Information_Schema.Tables
WHERE Table_Type = 'Base Table';
