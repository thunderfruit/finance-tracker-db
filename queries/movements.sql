-- All movements with full details
SELECT
    m.date,
    m.description,
    m.amount,
    m.owner,
    c.name AS category,
    a.name AS account
FROM movement m
JOIN category c ON m.category_id = c.category_id
JOIN account a ON m.account_id = a.account_id
ORDER BY m.date DESC;

-- Movements filtered by owner
SELECT
    m.date,
    m.description,
    m.amount,
    c.name AS category,
    a.name AS account
FROM movement m
JOIN category c ON m.category_id = c.category_id
JOIN account a ON m.account_id = a.account_id
WHERE m.owner = 'father'
ORDER BY m.date DESC;