-- Análise Descritiva (Visão Executiva)

-- Receita total
SELECT 
    ROUND(SUM(payment_value), 2) AS receita_total
FROM order_payments;


-- Total de pedidos
SELECT 
    COUNT(DISTINCT order_id) AS total_pedidos
FROM orders;

-- Ticket médio
SELECT 
    ROUND(SUM(payment_value) / COUNT(DISTINCT order_id), 2) AS ticket_medio
FROM order_payments;

-- Receita mensal (tendência temporal)
SELECT 
    DATE_TRUNC('month', o.order_purchase_timestamp) AS mes,
    ROUND(SUM(op.payment_value), 2) AS receita_mensal
FROM orders o
JOIN order_payments op 
    ON o.order_id = op.order_id
GROUP BY 1
ORDER BY 1;

-- Receita por estado (visão geográfica)

SELECT 
    c.customer_state,
    ROUND(SUM(op.payment_value), 2) AS receita
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_payments op ON o.order_id = op.order_id
GROUP BY 1
ORDER BY receita DESC;

-- Quantos clientes únicos existem?
SELECT
    COUNT(DISTINCT customer_unique_id) AS clientes_unicos
FROM customers; 

-- Qual a taxa média de recompra?
SELECT 
    COUNT(order_id)::numeric / 
    COUNT(DISTINCT customer_id) AS pedidos_por_cliente
FROM orders;

-- Número de clientes recorrentes
SELECT 
    COUNT(*) AS clientes_recorrentes
FROM (
    SELECT c.customer_unique_id
    FROM orders o
    JOIN customers c 
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
    HAVING COUNT(o.order_id) > 1
) t;


-- Percentual de recorrência
SELECT 
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(DISTINCT customer_unique_id) FROM customers),
        2
    ) AS percentual_recorrentes
FROM (
    SELECT c.customer_unique_id
    FROM orders o
    JOIN customers c 
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
    HAVING COUNT(o.order_id) > 1
) t;

-- RECEITA CLIENTES RECORRENTES
SELECT 
    ROUND(SUM(op.payment_value),2) AS receita_clientes_recorrentes
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_payments op ON o.order_id = op.order_id
WHERE c.customer_unique_id IN (
    SELECT c.customer_unique_id
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
    HAVING COUNT(o.order_id) > 1
);

-- Os clientes recorrentes têm ticket médio maior?
SELECT 
    ROUND(SUM(op.payment_value) / COUNT(DISTINCT o.order_id), 2) AS ticket_medio_recorrentes
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_payments op ON o.order_id = op.order_id
WHERE c.customer_unique_id IN (
    SELECT c.customer_unique_id
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
    HAVING COUNT(o.order_id) > 1
);