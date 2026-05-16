use bcofio;

SELECT
    C.Nome_Cli,
    C.Renda_Cli,
    COALESCE(SUM(I.Qtd_Vend), 0) AS total_produtos_adquiridos
FROM Cliente C
         LEFT JOIN Pedido P
                   ON C.Cod_Cli = P.Cod_Cli
         LEFT JOIN Itens I
                   ON P.Num_Ped = I.Num_Ped
GROUP BY
    C.Cod_Cli,
    C.Nome_Cli,
    C.Renda_Cli;

FALTA A PRINT