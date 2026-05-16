use bcofio;

select * from estado;

select
    estado.Sigla_Est,
    cidade.Nome_Cid
from estado
inner join cidade
    on estado.Sigla_Est = cidade.Sigla_Est;