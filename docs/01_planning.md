# 01 — Planning

## Project Goal
Build a personal finance tracker to replace manual Excel tracking.
Record personal income and expenses with category and account classification.

## Scope — v1 (included)
- Track income, expenses, and transfers between accounts
- Classify movements by category and account
- Label movements by owner (mine, house, ...)
- Mark movements as recurring (flag only — no automatic generation)
- Support monthly and yearly summary queries

## Scope — deliberately excluded from v1
- Budget limits and overspending warnings
- Automatic recurring transaction generation (amounts change too often)
- Loan/debt tracking system (handled as regular income/expense categories)
- Multi-user authentication (single user only)
- Savings envelope sub-allocation (planned for future phase)

## Tech Stack
- Database: PostgreSQL 16
- Tools: pgAdmin 4, StarUML
- OS: Fedora Linux
- Version control: Git + GitHub