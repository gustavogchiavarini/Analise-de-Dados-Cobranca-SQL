select * from Dados_Inadimplencia

-- Valor Total Inadimplente por Regi�o:
SELECT Regiao, SUM(CAST(Valor_Inadimplente AS DECIMAL(10, 2))) AS Total_Inadimplente
FROM Dados_Inadimplencia
GROUP BY Regiao
ORDER BY Total_Inadimplente DESC;

--Valor Total Recuperado por Canal de Cobran�a:

SELECT Canal_Cobranca, SUM(CAST(Valor_Recuperado AS DECIMAL(10, 2))) AS Total_Recuperado
FROM Dados_Inadimplencia
GROUP BY Canal_Cobranca
ORDER BY Total_Recuperado DESC;

-- M�dia de Tentativas de Cobran�a por Cliente:
SELECT ID_Cliente, AVG(CAST(Numero_Tentativas_Cobranca AS DECIMAL(10, 2))) AS Media_Tentativas
FROM Dados_Inadimplencia
GROUP BY ID_Cliente
ORDER BY Media_Tentativas DESC;

--Custo Total de Cobran�a por Regi�o:
SELECT Regiao, SUM(CAST(Custo_Cobranca AS DECIMAL(10, 2))) AS Total_Custo_Cobranca
FROM Dados_Inadimplencia
GROUP BY Regiao
ORDER BY Total_Custo_Cobranca DESC;

--Taxa de Recupera��o por Canal de Cobran�a:
SELECT Canal_Cobranca,
       SUM(CAST(Valor_Recuperado AS DECIMAL(10, 2))) / SUM(CAST(Valor_Inadimplente AS DECIMAL(10, 2))) AS Taxa_Recuperacao
FROM Dados_Inadimplencia
GROUP BY Canal_Cobranca
ORDER BY Taxa_Recuperacao DESC;

-- Tempo M�dio para Pagamento (em dias):
SELECT AVG(DATEDIFF(DAY, Data_Inicio_Cobranca, Data_Pagamento)) AS Tempo_Medio_Pagamento
FROM Dados_Inadimplencia


-- Clientes com Pagamentos Atrasados (mais de 30 dias):
SELECT ID_Cliente, CAST(Valor_Inadimplente AS DECIMAL(10, 2)), DATEDIFF(DAY, Data_Inicio_Cobranca, GETDATE()) AS Dias_Atraso
FROM Dados_Inadimplencia
WHERE DATEDIFF(DAY, Data_Inicio_Cobranca, GETDATE()) > 30;


--Custo de Cobran�a por Cliente:
SELECT ID_Cliente, SUM(CAST(Custo_Cobranca AS DECIMAL(10, 2))) AS Total_Custo_Cobranca
FROM Dados_Inadimplencia
GROUP BY ID_Cliente
ORDER BY Total_Custo_Cobranca DESC;

-- Valor Inadimplente por M�s de In�cio de Cobran�a:
SELECT FORMAT(CAST(Data_Inicio_Cobranca AS DATETIME), 'yyyy-MM') AS Mes, 
       SUM(CAST(Valor_Inadimplente AS DECIMAL(10, 2))) AS Total_Inadimplente
FROM Dados_Inadimplencia
GROUP BY FORMAT(CAST(Data_Inicio_Cobranca AS DATETIME), 'yyyy-MM')
ORDER BY Mes;

--Efici�ncia de Cobran�a por Regi�o:
SELECT Regiao,
       SUM(CAST(Valor_Recuperado AS DECIMAL(10, 2))) / SUM(CAST(Custo_Cobranca AS DECIMAL(10, 2))) AS Eficiencia_Cobranca
FROM Dados_Inadimplencia
GROUP BY Regiao
ORDER BY Eficiencia_Cobranca DESC;

-- Total de Valor Inadimplente e Recuperado por Cliente:
SELECT ID_Cliente,
       SUM(CAST(Valor_Inadimplente AS DECIMAL(10, 2))) AS Total_Inadimplente,
       SUM(CAST(Valor_Recuperado AS DECIMAL(10, 2))) AS Total_Recuperado
FROM Dados_Inadimplencia
GROUP BY ID_Cliente
ORDER BY Total_Inadimplente DESC;

-- N�mero de Clientes que Renegociaram a D�vida:
SELECT COUNT(DISTINCT ID_Cliente) AS Total_Renegociados
FROM Dados_Inadimplencia
WHERE Renegociou_Divida = 'Sim';


-- Valor M�dio de Inadimpl�ncia por Regi�o:
SELECT Regiao, AVG(CAST(Valor_Inadimplente AS DECIMAL(10, 2))) AS Media_Inadimplente
FROM Dados_Inadimplencia
GROUP BY Regiao
ORDER BY Media_Inadimplente DESC;

-- Total de Custo de Cobran�a por Canal:
SELECT Canal_Cobranca, SUM(CAST(Custo_Cobranca AS DECIMAL(10, 2))) AS Total_Custo_Cobranca
FROM Dados_Inadimplencia
GROUP BY Canal_Cobranca
ORDER BY Total_Custo_Cobranca DESC;