-- VIEW – KPIs Executivos
CREATE OR REPLACE VIEW vw_kpi_geral AS
SELECT
    COUNT(DISTINCT o.order_id) AS total_pedidos,
    COUNT(DISTINCT c.customer_unique_id) AS total_clientes,
    ROUND(SUM(op.payment_value), 2) AS receita_total,
    ROUND(SUM(op.payment_value) / COUNT(DISTINCT o.order_id), 2) AS ticket_medio,
    ROUND(COUNT(DISTINCT o.order_id)::numeric / 
          COUNT(DISTINCT c.customer_unique_id), 2) AS pedidos_por_cliente
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_payments op ON o.order_id = op.order_id;

-- VIEW – LTV Geral
CREATE OR REPLACE VIEW vw_ltv_geral AS
SELECT 
    COUNT(DISTINCT c.customer_unique_id) AS total_clientes,
    ROUND(COUNT(DISTINCT o.order_id) * 1.0 / 
          COUNT(DISTINCT c.customer_unique_id), 2) AS frequencia_media,
    ROUND(SUM(op.payment_value) / 
          COUNT(DISTINCT c.customer_unique_id), 2) AS ticket_medio,
    ROUND(
        (SUM(op.payment_value) / COUNT(DISTINCT c.customer_unique_id)) *
        (COUNT(DISTINCT o.order_id) * 1.0 / COUNT(DISTINCT c.customer_unique_id)),
        2
    ) AS ltv_medio
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_payments op ON o.order_id = op.order_id;

-- VIEW – RFM (base cliente)
CREATE OR REPLACE VIEW vw_rfm_base AS
SELECT 
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS frequencia,
    SUM(op.payment_value) AS total_gasto
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_payments op ON o.order_id = op.order_id
GROUP BY c.customer_unique_id;

-- VIEW – Segmentação por Frequência
CREATE OR REPLACE VIEW vw_rfm_segmento AS
SELECT 
    CASE 
        WHEN frequencia >= 5 THEN 'Alta Frequência'
        WHEN frequencia BETWEEN 2 AND 4 THEN 'Média Frequência'
        ELSE 'Baixa Frequência'
    END AS segmento_frequencia,
    COUNT(*) AS clientes,
    ROUND(AVG(total_gasto), 2) AS ltv_medio
FROM vw_rfm_base
GROUP BY 1
ORDER BY ltv_medio DESC;

-- VIEW – LTV Clientes Recorrentes
CREATE OR REPLACE VIEW vw_ltv_recorrentes AS
SELECT 
    COUNT(*) AS clientes_recorrentes,
    ROUND(AVG(frequencia), 2) AS frequencia_media,
    ROUND(AVG(total_gasto), 2) AS ltv_medio
FROM vw_rfm_base
WHERE frequencia > 1;

-- VIEW – Simulação de Crescimento de LTV
CREATE OR REPLACE VIEW vw_ltv_simulacao AS
WITH base AS (
    SELECT 
        COUNT(DISTINCT c.customer_unique_id) AS total_clientes,
        COUNT(DISTINCT o.order_id) * 1.0 / 
        COUNT(DISTINCT c.customer_unique_id) AS frequencia_media,
        SUM(op.payment_value) / 
        COUNT(DISTINCT c.customer_unique_id) AS ticket_medio
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_payments op ON o.order_id = op.order_id
)
SELECT 
    ROUND(ticket_medio, 2) AS ticket_medio,
    ROUND(frequencia_media, 2) AS frequencia_media,
    ROUND(frequencia_media * 1.2, 2) AS frequencia_20,
    ROUND(ticket_medio * frequencia_media * 1.2, 2) AS ltv_20,
    ROUND(frequencia_media * 1.5, 2) AS frequencia_50,
    ROUND(ticket_medio * frequencia_media * 1.5, 2) AS ltv_50
FROM base;

-- VIEW – Cohort Retention (retenção mensal)
CREATE OR REPLACE VIEW vw_cohort_retention AS
WITH primeira_compra AS (
    SELECT
        c.customer_unique_id,
        MIN(DATE_TRUNC('month', o.order_purchase_timestamp)) AS cohort_month
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
),
compras_cliente AS (
    SELECT
        c.customer_unique_id,
        DATE_TRUNC('month', o.order_purchase_timestamp) AS purchase_month
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
),
base_cohort AS (
    SELECT
        pc.customer_unique_id,
        pc.cohort_month,
        cc.purchase_month,
        DATE_PART('year', age(cc.purchase_month, pc.cohort_month)) * 12 +
        DATE_PART('month', age(cc.purchase_month, pc.cohort_month)) AS month_number
    FROM primeira_compra pc
    JOIN compras_cliente cc
        ON pc.customer_unique_id = cc.customer_unique_id
),
retencao_base AS (
    SELECT
        cohort_month,
        month_number,
        COUNT(DISTINCT customer_unique_id) AS clientes_ativos
    FROM base_cohort
    GROUP BY cohort_month, month_number
),
cohort_size AS (
    SELECT
        cohort_month,
        COUNT(DISTINCT customer_unique_id) AS total_clientes
    FROM primeira_compra
    GROUP BY cohort_month
)
SELECT
    r.cohort_month,
    r.month_number,
    r.clientes_ativos,
    ROUND(
        (r.clientes_ativos::numeric / c.total_clientes) * 100,
        2
    ) AS retention_percent
FROM retencao_base r
JOIN cohort_size c
    ON r.cohort_month = c.cohort_month
ORDER BY r.cohort_month, r.month_number;