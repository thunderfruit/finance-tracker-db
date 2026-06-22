-- Monthly summary
SELECT
    DATE_TRUNC('month', m.date) AS month,
    c.type,
    SUM(m.amount) AS total
FROM movement m
JOIN category c ON m.category_id = c.category_id
GROUP BY DATE_TRUNC('month', m.date), c.type
ORDER BY month DESC, c.type;

-- Yearly summary
SELECT
    DATE_TRUNC('year', m.date) AS year,
    c.type,
    SUM(m.amount) AS total
FROM movement m
JOIN category c ON m.category_id = c.category_id
GROUP BY DATE_TRUNC('year', m.date), c.type
ORDER BY year DESC, c.type;

-- Spending per category this month
SELECT
    c.name AS category,
    SUM(m.amount) AS total
FROM movement m
JOIN category c ON m.category_id = c.category_id
WHERE DATE_TRUNC('month', m.date) = DATE_TRUNC('month', CURRENT_DATE)
GROUP BY c.name
ORDER BY total ASC;