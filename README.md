# 🗂️ Practical MySQL Exercises - Queries

## 📌 Description  
This repository contains two database design and SQL practice exercises built using **MySQL**.  
Each exercise focuses on creating and managing relational databases to simulate real-world scenarios.

- **Exercise 1 – Universidad**:  
  A system to manage students, professors, subjects, degrees, departments, and academic years.  
  The database tracks student enrollment, professor assignments, subjects per degree and semester, and academic years.  
  Queries include retrieving student and professor information, filtering by birth year or phone number, and aggregating academic data.

- **Exercise 2 – Tienda**:  
  A database to manage products, customers, orders, and sales in a retail store.  
  It includes entities for products, categories, customers, orders, and employees.  
  The structure supports inventory management, sales tracking, and customer data analysis.

## 💻 Technologies Used  
- **MySQL** – Database management system  
- **Docker** – Environment for running MySQL containers  
- **MySQL Workbench** – For schema design and queries  

## 📋 Requirements  
Before starting, make sure you have:  
- A working **MySQL server** (local or Docker).  
- A SQL client such as **MySQL Workbench**, **DBeaver**, or the **MySQL CLI**.  

## 🛠️ Installation & Setup  
1. Start your MySQL server or Docker container.  
2. Open MySQL Workbench (or another SQL client).  
3. Run the provided `.sql` scripts to create each database:  
   - `schema_universidad.sql` for **Exercise 1 – Universidad**  
   - `schema_tienda.sql` for **Exercise 2 – Tienda**  
4. Insert the provided sample data using the included `INSERT` statements.  

## 🧪 Example Queries  
Some example queries included in the exercises:

- **Universidad:**  
  - List students and professors with their associated data.  
  - Retrieve subjects taught per semester and degree.  
  - Count students enrolled per academic year.  

- **Tienda:**  
  - List products per category.  
  - Count orders handled by a specific employee.  
  - Track sales per product and customer.  

## 🎯 Learning Objectives  
- Practice **database modeling** with entities and relationships.  
- Apply **SQL commands** for creating tables, inserting data, and running queries.  
- Understand **1:N** and **N:M** relationships between real-world entities.  
- Gain hands-on experience working with **MySQL Workbench** and **Docker**.  
