-- ============================================
-- Personal Finance Tracker — Database Schema
-- ============================================

-- Category type ENUM (stable set: income, expense, transfer)
CREATE TYPE category_type AS ENUM ('income', 'expense', 'transfer');

-- CATEGORY
CREATE TABLE category (
    category_id   SERIAL PRIMARY KEY,
    name          VARCHAR(50) NOT NULL,
    description   VARCHAR(50),
    type          category_type NOT NULL
);

-- ACCOUNT
CREATE TABLE account (
    account_id    SERIAL PRIMARY KEY,
    name          VARCHAR(50) NOT NULL,
    description   VARCHAR(50),
    type          VARCHAR(50) NOT NULL
                  CHECK (type IN ('debit', 'credit', 'investment', 'cash', 'salary'))
);

-- MOVEMENT (renamed from "transaction" to avoid PostgreSQL reserved-word risk)
CREATE TABLE movement (
    movement_id        SERIAL PRIMARY KEY,
    category_id         INTEGER NOT NULL REFERENCES category(category_id),
    account_id           INTEGER NOT NULL REFERENCES account(account_id),
    description         VARCHAR(50),
    date                 DATE NOT NULL,
    amount               DECIMAL(10,2) NOT NULL CHECK (amount <> 0),
    owner                VARCHAR(50) NOT NULL
                         CHECK (owner IN ('mine', 'father', 'mother', 'house', 'mine_project')),
    is_recurring        BOOLEAN NOT NULL DEFAULT FALSE,
    transfer_group_id   UUID
);