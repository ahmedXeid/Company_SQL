# Company_SD SQL Project

## 📊 Overview

This SQL project explores data from the `Company_SD` database, showcasing key insights into employees, departments, projects, and organizational structure.

Through structured SQL queries, it provides hands-on examples of real-world business analysis using advanced SQL techniques such as joins, aggregations, subqueries, views, and data modification.

---

## 📁 Project Structure

| Folder / File | Description |
|---------------|-------------|
| `sql/SQL_Answers.sql` | Full SQL script containing all queries and operations |
| `database/Company_SD.bak` | Backup file of the original database |
| `docs/SQL Questions.docx` | The Project questions provided |
| `README.md` | Project documentation and usage guide |

---

## 🚀 Features

- 🧮 **Average Salary Analysis**: List employees earning above the company’s average salary.  
- 👨‍👩‍👧 **Dependent Summary**: Count how many dependents each employee has.  
- 🧑‍💼 **Supervisor Analysis**: Number of employees under each supervisor with full details.  
- 🛠️ **Project Work Summary**: Total worked hours and employee count per project.  
- 🏆 **Top Projects**: Identify the project with the highest total work hours.  
- 🏢 **Department Salary Report**: Total salary and employee count per department.  
- 📈 **Manager Insights**: Show oldest departments and detailed manager information.  
- 👨‍💻 **Role-Based Filtering**: List employees who are managers or supervisors.  
- 💰 **Salary Update Simulation**: Calculate new salaries with a 25% increase.  
- 👨‍👦 **Supervisor-Based Filtering**: Employees under a specific supervisor.  
- 👀 **Views for Reuse**: Create reusable views for top employees and completed projects.  
- ➕ **Insert & Update Operations**: Insert new employee & department and update department details.

---

## 🛠 Technologies Used

- **SQL Server** (T-SQL)
- **SSMS** (SQL Server Management Studio)
- **Word** (for assignment documentation)

---

## 📊 Insights

✅ Managers & Supervisors form a layered hierarchy crucial to reporting structures.
✅ Project Distribution shows a significant imbalance in work hours across projects.
✅ Department Salary Analysis reveals financial spread and team sizes.
✅ Reusable Views help modularize analysis, enabling clean report structures.
✅ Data Insertions & Updates simulate HR operations in real environments.

## 🧩 Challenges & Solutions

✅ Challenge: Subquery Complexity
➤ Used CTEs and temporary views to improve readability.
✅ Challenge: Missing Data in Joins
➤ Applied LEFT JOINs with COALESCE to show null-safe outputs.
✅ Challenge: Query Performance and Readability
➤ Broke long queries into logical steps with comments and structured indentation.
✅ Challenge: Simulating Updates Safely
➤ Used SELECT-based simulation of UPDATE to preview data changes without affecting real tables.

## ✅ Conclusion

This SQL project demonstrates real-world database operations on a company dataset.
It combines structured queries with business logic to reveal meaningful insights and simulate scenarios like salary updates and employee insertions.

This project offers a comprehensive demonstration of SQL in action, whether you're analyzing organizational structure, monitoring department efficiency, or performing role-based filtering.

