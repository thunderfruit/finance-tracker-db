# 06 — Design Decisions

## Why ENUM for category.type but VARCHAR + CHECK for account.type and owner?
ENUM is a fixed type in PostgreSQL — adding new values requires ALTER TYPE, which
is a schema-level change. category.type (income/expense/transfer) is a fundamental
accounting concept unlikely to grow. account.type and owner are user-defined labels
expected to grow over time, so VARCHAR + CHECK is easier to extend via a simple
constraint modification.

## Why DECIMAL(10,2) for amount and not FLOAT?
Floating-point types (FLOAT, REAL) cannot represent decimal fractions like 0.10
exactly in binary, causing small rounding errors that compound over thousands of
transactions. DECIMAL/NUMERIC stores exact decimal values — critical for financial data.

## Why signed amounts (positive/negative) instead of always-positive?
Transfer movements require two linked rows (one outflow, one inflow). With signed
amounts, a single SUM(amount) WHERE account_id = X gives the correct balance for
any account automatically, including transfers — no special-case logic needed in queries.
Always-positive amounts would require different query logic for income vs expense vs transfer.

## Why two rows per transfer instead of one row with two account columns?
Two linked rows keeps every movement row structurally identical, and balance queries
stay simple: SUM(amount) WHERE account_id = X always works correctly.
One row with a destination_account_id column would require every balance query to
also check the destination column for cases where the account is the transfer target
— extra logic every single time.

## Why UUID for transfer_group_id?
UUID generation (gen_random_uuid()) produces collision-free identifiers without
requiring coordination with existing IDs or a separate counter table.

## Why a trigger instead of a CHECK constraint for amount sign validation?
A CHECK constraint can only reference columns within the same row and same table.
Validating amount sign requires looking up category.type from a different table,
which CHECK cannot do. A BEFORE INSERT OR UPDATE trigger performs the cross-table
lookup at runtime and raises an exception if the sign is wrong.

## Why rename "transaction" to "movement"?
"transaction" is a reserved word in PostgreSQL (used for BEGIN TRANSACTION, etc.).
Naming a table "transaction" risks confusing errors. "movement" is semantically
equivalent and avoids the conflict entirely.

## What was deliberately excluded from v1 and why?
- Automatic recurring transaction generation — amounts change too often to automate reliably
- Budget limits and warnings — adds complexity without immediate need
- Loan/debt tracking system — handled simply as income/expense categories for now
- Multi-user authentication — single user only, no login system needed
- Savings envelope sub-allocation — planned for a future phase