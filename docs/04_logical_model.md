# 04 — Logical Model

CATEGORY(category_id PK, name, description, type)

ACCOUNT(account_id PK, name, description, type)

MOVEMENT(movement_id PK, category_id FK, account_id FK, description, date, amount, owner, is_recurring, transfer_group_id)