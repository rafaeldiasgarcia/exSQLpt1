use bcofio;

select
    cliente.Nome_Cli,
    cliente.Renda_Cli,
    cliente.Renda_Cli * 1.10 as renda_com_acrescimo
from cliente
where Renda_Cli < 1000.00;