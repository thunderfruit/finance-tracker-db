# 02 — Requirements

## Functional Requirements

### Movements
- Record income, expense, and transfer movements
- Each movement must have: date, amount, category, account, owner
- Description field is optional (free text note)
- Amount must never be zero
- Income amounts must be positive
- Expense amounts must be negative
- Transfer movements create two linked rows (one negative outflow, one positive inflow)
- Transfer pairs are linked via a shared transfer_group_id (UUID)

### Categories
- Each category has a name, optional description, and type (income/expense/transfer)
- Category type is enforced at database level via ENUM
- Any category can be used with any account (no account-category binding)

### Accounts
- Each account has a name, optional description, and type
- Supported account types: debit, credit, investment, cash, salary
- Account type list can grow in the future (implemented via VARCHAR + CHECK, not ENUM)

### Owners
- Each movement is labeled with an owner: mine, father, mother, house, mine_project
- Owner list can grow in the future (implemented via VARCHAR + CHECK, not ENUM)

## Non-Functional Requirements
- Single user only — no authentication system
- No real personal data committed to the public repository
- Database credentials stored in .env file, never committed to Git
- Monthly and yearly summaries calculated via SQL aggregate queries (no extra tables needed)