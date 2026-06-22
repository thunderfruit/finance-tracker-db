-- ============================================
-- Demo/test data (FAKE values only — no real personal data)
-- ============================================

-- Extension needed for gen_random_uuid()
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Categories
INSERT INTO category (name, description, type) VALUES
('Salary', 'Monthly salary', 'income'),
('Food', 'Groceries and eating out', 'expense'),
('Internal Transfer', 'Moving money between my own accounts', 'transfer');

-- Accounts
INSERT INTO account (name, description, type) VALUES
('Main Debit', 'Primary debit account', 'debit'),
('Investments', 'Investment account', 'investment');

-- Valid income
INSERT INTO movement (category_id, account_id, description, date, amount, owner, is_recurring)
VALUES (1, 1, 'Demo salary', '2026-06-01', 2000.00, 'mine', FALSE);

-- Valid expense
INSERT INTO movement (category_id, account_id, description, date, amount, owner, is_recurring)
VALUES (2, 1, 'Demo groceries', '2026-06-05', -85.30, 'mine', FALSE);

-- Valid transfer pair
INSERT INTO movement (category_id, account_id, description, date, amount, owner, is_recurring, transfer_group_id)
VALUES (3, 1, 'Demo transfer out', '2026-06-10', -200.00, 'mine', FALSE, gen_random_uuid());

INSERT INTO movement (category_id, account_id, description, date, amount, owner, is_recurring, transfer_group_id)
VALUES (3, 2, 'Demo transfer in', '2026-06-10', 200.00, 'mine', FALSE,
        (SELECT transfer_group_id FROM movement WHERE description = 'Demo transfer out'));