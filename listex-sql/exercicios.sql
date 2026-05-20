use bcofio;

# 1 ------------------------------------------------------------
select *
from tipoprod;

# 2 ------------------------------------------------------------
select *
from tipocli
where Cod_TipoCli between 1 and 6;

# 3 ------------------------------------------------------------
select *
from estado;

# 4 ------------------------------------------------------------
select estado.Sigla_Est,
       cidade.Nome_Cid
from estado
         inner join cidade
                    on estado.Sigla_Est = cidade.Sigla_Est;

# 5 ------------------------------------------------------------
select cliente.Nome_Cli,
       cliente.Data_CadCli,
       cliente.Renda_Cli
from bcofio.cliente;

# 9 ------------------------------------------------------------
select cliente.Nome_Cli,
       cliente.Renda_Cli,
       cliente.Renda_Cli * 1.10 as renda_com_acrescimo
from cliente;

# 10 -----------------------------------------------------------
select Nome_Cli,
       Renda_Cli,
       Renda_Cli * 1.10 AS Renda_Com_Acrescimo
from Cliente
where Renda_Cli < 1000.00;

# 11 -----------------------------------------------------------
select C.Nome_Cli,
       C.Renda_Cli,
       COALESCE(SUM(I.Qtd_Vend), 0) AS total_produtos_adquiridos
from Cliente C
         left join Pedido P
                   ON C.Cod_Cli = P.Cod_Cli
         left join Itens I
                   ON P.Num_Ped = I.Num_Ped
group by C.Cod_Cli,
         C.Nome_Cli,
         C.Renda_Cli;

# 12 -----------------------------------------------------------
update funcionario
set Sal_Func = Sal_Func * 1.20
where Sexo_Func = 'F'
    and Sal_Func < 1000.00;

# 13 -----------------------------------------------------------
update produto
set Val_UnitProd = Val_UnitProd * 1.10
where Cod_TipoProd = 1;

# 14 -----------------------------------------------------------
update produto
set Val_UnitProd = Val_UnitProd * 1.05
where Cod_TipoProd = 2;

# 15 -----------------------------------------------------------
update produto
set Val_UnitProd = Val_UnitProd * 0.80
where  Cod_TipoProd = 3;