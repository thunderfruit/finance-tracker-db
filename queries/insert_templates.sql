-- queries/insert_templates.sql

-- Insert a new movement (template only -- replace values before running)
INSERT INTO movement (category_id, account_id, description, date, amount, owner, is_recurring)
VALUES (
    ?,          -- category_id: check queries/reference.sql
    ?,          -- account_id: check queries/reference.sql
    '',         -- description (optional)
    '',         -- date: format YYYY-MM-DD
    0.00,       -- amount: positive = income, negative = expense
    '',         -- owner: mine/father/mother/house/mine_project/lita
    FALSE       -- is_recurring
);

-- Insert a transfer pair (template only)
INSERT INTO movement (category_id, account_id, description, date, amount, owner, is_recurring, transfer_group_id)
VALUES
(?, ?, 'Transfer out', '', -0.00, '', FALSE, gen_random_uuid()),
(?, ?, 'Transfer in',  '', 0.00,  '', FALSE, (SELECT transfer_group_id FROM movement WHERE description = 'Transfer out'));