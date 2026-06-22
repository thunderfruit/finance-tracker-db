-- Total balance per owner
SELECT owner, SUM(amount) AS balance
FROM movement
GROUP BY owner
ORDER BY owner;

-- Balance for a specific owner
SELECT SUM(amount) AS father_balance
FROM movement
WHERE owner = 'father';

-- Balance per account
SELECT a.name AS account, SUM(m.amount) AS balance
FROM movement m
JOIN account a ON m.account_id = a.account_id
GROUP BY a.name
ORDER BY a.name;