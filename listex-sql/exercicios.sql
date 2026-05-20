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
where Cod_TipoProd = 3;

# 37 -----------------------------------------------------------
select f.Nome_Func,
       count(p.Num_Ped) as total_pedidos
from funcionario f
         left join pedido p on f.Cod_Func = p.Cod_Func
group by f.Cod_Func, f.Nome_Func;

# 38 -----------------------------------------------------------
select f.Nome_Func      as funcionario,
       c.Nome_Cli       as cliente,
       count(p.Num_Ped) as total_pedidos
from pedido p
         inner join funcionario f on p.Cod_Func = f.Cod_Func
         inner join cliente c on p.Cod_Cli = c.Cod_Cli
group by f.Cod_Func,
         f.Nome_Func,
         c.Cod_Cli,
         c.Nome_Cli
order by f.Nome_Func,
         c.Nome_Cli;

# 39 -----------------------------------------------------------
select c.Cod_Cli,
       c.Nome_Cli      as cliente,
       te.Cod_TipoEnd,
       te.Nome_TipoEnd as tipo_endereco,
       count(*)        as total_enderecos
from endereco e
         inner join cliente c
                    on e.Cod_Cli = c.Cod_Cli
         inner join tipoend te
                    on e.Cod_TipoEnd = te.Cod_TipoEnd
group by c.Cod_Cli,
         c.Nome_Cli,
         te.Cod_TipoEnd,
         te.Nome_TipoEnd
order by c.Cod_Cli,
         te.Cod_TipoEnd;

# 40 -----------------------------------------------------------
select sum(Sal_Func) as total_salarios
from funcionario;

# 41 -----------------------------------------------------------
select 'Casado' as estado_civil,
       count(*) as total_clientes
from cliente c
where c.Cod_Cli in (
    select Cod_Cli
    from conjuge
)

union

select 'Solteiro' as estado_civil,
       count(*) as total_clientes
from cliente c
where c.Cod_Cli not in (
    select Cod_Cli
    from conjuge
);

# 42 -----------------------------------------------------------
select c.Nome_Cli as cliente,
       count(e.EMail_Cli) as total_emails
from cliente c
         left join email e
                   on c.Cod_Cli = e.Cod_Cli
group by c.Cod_Cli,
         c.Nome_Cli
order by c.Nome_Cli;