# 💇‍♀️ Pyloon’s Salon — Bash + PostgreSQL Appointment Scheduler

A command-line salon appointment scheduling system built with **Bash** and **PostgreSQL**.  
This project allows users to view available services, register as customers, and book appointments — all from the terminal.

---

## 🧠 Overview

This script simulates a simple salon appointment system.  
It allows you to:
- Display available salon services  
- Add new customers if they are not already registered  
- Schedule appointments with selected services and times  
- Store all information in a PostgreSQL database  

It was created as part of a FreeCodeCamp Relational Database certification project.

---

## ⚙️ Prerequisites

Before running the script, ensure you have the following installed:

- **Bash** (v4.0 or later)
- **PostgreSQL** (v12 or later)
- A **PostgreSQL user** named `freecodecamp`
- A **database** named `salon`

---

## 🗃️ Database Setup

Run the following commands inside `psql` to create the required database and tables:

```sql
CREATE DATABASE salon;

\c salon

CREATE TABLE customers(
  customer_id SERIAL PRIMARY KEY,
  phone VARCHAR(50) UNIQUE NOT NULL,
  name VARCHAR(50) NOT NULL
);

CREATE TABLE services(
  service_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

CREATE TABLE appointments(
  appointment_id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(customer_id),
  service_id INT REFERENCES services(service_id),
  time VARCHAR(50) NOT NULL
);

INSERT INTO services(name) VALUES
('cut'), 
('color'), 
('perm'), 
('style'), 
('trim');

```

🚀 Usage

1. Clone or download the script.
2. Make the script executable:

```bash
chmod +x salon.sh
```
3. Run the script:
```bash
./salon.sh
```
4. Follow the interactive prompts:

- Choose a service (e.g., 1 for cut)
- Enter your phone number
- Enter your name (if new)
- Choose your preferred time

## 💾 Example Interaction

```txt
~~~~~ PYLOON'S SALON ~~~~~

Welcome to Pyloon's Salon, how can I help you?

1) cut
2) color
3) perm
4) style
5) trim

2
What's your phone number?
555-5555
I don't have a record for that phone number, what's your name?
John
What time would you like your Beard Trim, John?
14:00
I have put you down for a color at 14:00, John.
```
## 👨‍💻 Author

Created by: Hugo Rocha

