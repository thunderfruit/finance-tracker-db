# Finance Tracker DB

A personal finance tracker database built with PostgreSQL 16.
Designed to replace manual Excel tracking with a structured, 
queryable relational database.

## Features

- Track income, expenses, and transfers between accounts
- Classify movements by category and account type
- Label movements by owner (personal, family, projects)
- Flag recurring movements (rent, subscriptions, etc.)
- Enforced data integrity via CHECK constraints and triggers
- Monthly and yearly summaries via SQL aggregate queries

## Database Schema

Three tables: `category`, `account`, `movement`

```sql
CATEGORY(category_id PK, name, description, type)
ACCOUNT(account_id PK, name, description, type)
MOVEMENT(movement_id PK, category_id FK, account_id FK, 
         description, date, amount, owner, 
         is_recurring, transfer_group_id)
```

See `docs/` for the full design process (planning → requirements → 
conceptual → logical → physical → design decisions).

## Tech Stack

- PostgreSQL 16
- pgAdmin 4
- StarUML (ER diagram)
- Git + GitHub

## Project Structure

```
finance-tracker-db/
├── sql/
│   ├── 01_schema.sql       # ENUM type + CREATE TABLE statements
│   ├── 02_trigger.sql      # Amount sign validation trigger
│   └── 03_test_data.sql    # Fake demo data for testing only
├── docs/
│   ├── 01_planning.md
│   ├── 02_requirements.md
│   ├── 03_conceptual_model.png
│   ├── 04_logical_model.md
│   ├── 05_physical_model.md
│   └── 06_design_decisions.md
├── .env.example            # Environment variable template
├── .gitignore
└── README.md
```

## Local Setup

### 1. Clone the repository
```bash
git clone https://github.com/thunderfruit/finance-tracker-db.git
cd finance-tracker-db
```

### 2. Create your environment file
```bash
cp .env.example .env
```
Fill in your PostgreSQL credentials in `.env`:
```
DB_HOST=localhost
DB_PORT=5432
DB_NAME=finance_tracker
DB_USER=your_postgres_user
DB_PASSWORD=your_postgres_password
```

### 3. Create the database
In pgAdmin 4 or psql, create a new database:
```sql
CREATE DATABASE finance_tracker;
```

### 4. Run the schema
```bash
psql -U your_postgres_user -d finance_tracker -f sql/01_schema.sql
psql -U your_postgres_user -d finance_tracker -f sql/02_trigger.sql
```

### 5. (Optional) Load demo data
```bash
psql -U your_postgres_user -d finance_tracker -f sql/03_test_data.sql
```

## Key Design Decisions

See [`docs/06_design_decisions.md`](docs/06_design_decisions.md) for
detailed reasoning behind every major schema decision, including:
- Why `DECIMAL` over `FLOAT` for amounts
- Why signed amounts (positive/negative)
- Why two rows per transfer (not one row with two account columns)
- Why a trigger instead of a CHECK constraint for sign validation

## Notes

- No real personal data is committed to this repository
- `sql/03_test_data.sql` contains fake demo values only
- `.env` is git-ignored — never committed