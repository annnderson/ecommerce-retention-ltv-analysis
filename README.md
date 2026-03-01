# 📊 Análise Estratégica de LTV, Retenção e Recorrência  
## Projeto – E-commerce Brasileiro

---

## 🎯 Objetivo

Realizar uma análise estratégica de comportamento de clientes com foco em:

- Receita e crescimento  
- Recorrência e retenção  
- Lifetime Value (LTV)  
- Segmentação RFM  
- Análise de Cohort  

O projeto busca identificar as principais alavancas de crescimento sustentável do negócio.

---

# 📌 Diagnóstico Executivo

## 💰 Receita e Volume

- **Receita Total:** R$ 16.008.872  
- **Total de Pedidos:** 99.441  
- **Clientes Únicos:** 96.096  
- **Ticket Médio:** R$ 160,99  

### 🔎 Interpretação

- O crescimento é impulsionado principalmente por **volume de pedidos**, não por ticket elevado.  
- O ticket médio é moderado, sugerindo consumo de bens não premium.  
- Há forte dependência de aquisição de novos clientes.

---

## 🔁 Recorrência

- **Clientes recorrentes:** 2.997  
- **Percentual de recorrência:** 3,12%  
- **Pedidos por cliente:** ~1,00  

### 🎯 Insight Estratégico

- 96,88% dos clientes compraram apenas uma vez.  
- O modelo de crescimento é baseado em aquisição contínua.  
- A retenção é estruturalmente baixa.

### 💵 Receita dos Recorrentes

- **Receita recorrentes:** R$ 944.022  
- Representam aproximadamente **5,9% da receita total**

Mesmo sendo 3,12% da base, geram apenas ~6% da receita, indicando baixa concentração financeira em clientes fiéis.

---

## 💳 Comparação de Ticket

- **Ticket médio geral:** R$ 160,99  
- **Ticket médio recorrentes:** R$ 148,85  

### 📌 Interpretação

Clientes recorrentes:

- Compram mais vezes  
- Gastam menos por pedido  
- Não compensam em valor unitário  

O crescimento via retenção exigiria **aumento de frequência**, não apenas manutenção da recompra.

---

# 📊 Segmentação RFM

A análise revelou concentração de receita nos segmentos:

- **Leais**
- **Em Risco**

### 🔎 Pontos-chave

- O segmento **Leais** sustenta o faturamento atual.  
- O segmento **Em Risco** apresenta ticket semelhante aos Leais, representando risco financeiro relevante.  
- O grupo **Campeões** possui baixa representatividade, indicando possível baixa maturidade de retenção.

### 📌 Implicação

A estratégia de CRM deve priorizar:

- Manutenção do segmento Leais  
- Recuperação ativa do segmento Em Risco  

---

# 📈 Análise de Retenção (Cohort)

### 📊 Padrão Observado

- Month 0 → 100%  
- Month 1 → entre 0,2% e 0,7%  
- Após Month 2 → retenção residual  

### 🚨 Insight Principal

- Recompra mensal inferior a 1%  
- Forte predominância de compra única  
- Retenção praticamente inexistente no médio prazo  

A Cohort valida estatisticamente o problema identificado na análise de recorrência.

---

# 🚨 Diagnóstico Estratégico Consolidado

O modelo atual apresenta:

- Baixa retenção (3,12%)  
- Baixa concentração de receita em recorrentes (~6%)  
- Forte dependência de aquisição  
- Risco estrutural caso investimento em mídia reduza  

### 📌 Crescimento Sustentável Depende de:

- Estratégias de fidelização  
- Aumento de frequência de compra  
- Incentivo a cross-sell e upsell  
- Ações estruturadas de CRM  

---

# 🛠 Técnicas Aplicadas

- Modelagem relacional em PostgreSQL  
- CTEs complexas  
- Cálculo de LTV  
- Segmentação RFM  
- Análise de Cohort com cálculo de retenção percentual  
- Estruturação de views analíticas  
- Integração com Power BI  

---

# 📊 Dashboard

## 🔹 Visão Executiva

<img width="1327" height="767" alt="Dashboard Executivo" src="https://github.com/user-attachments/assets/9109cb42-9ae9-4c44-b696-d97303e62f5e" />

---

## 🔹 Análise de Retenção por Cohort

<img width="1326" height="767" alt="Cohort de Retenção e Comportamento de Recompra" src="https://github.com/user-attachments/assets/9d3dfdc9-b087-4177-b43d-d5418fa340d6" />


---

# 🔗 Acesse o Dashboard 

[Visualizar Dashboard Online](https://app.powerbi.com/view?r=eyJrIjoiZDVhZjU5ZTktNjg0Ny00ZmMxLTk4MjAtMWUxNjBjZTkyZTUxIiwidCI6ImQ2MmVkZjk4LTJkNmYtNDBhOS05YTJhLWEwNmE4MmFlOTdlYyJ9)

---

# 📌 Conclusão

<img width="1154" height="645" alt="Conclusões finais" src="https://github.com/user-attachments/assets/aa3e0c82-9229-4e11-9692-c7fc27830463" />


O negócio analisado possui forte dependência de aquisição e baixa retenção estrutural.

A principal alavanca de crescimento sustentável está na ativação da base existente e aumento de frequência de compra.
