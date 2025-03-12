--1)
SELECT 
    e.Fname AS Employee_First_Name, 
    e.Lname AS Employee_Last_Name, 
    CONVERT(date, e.Bdate) AS Birth_Date, 
    e.Address, 
    d.Dname AS Department_Name, 
    d.MGRSSN AS Manager_ID, 
    e.Salary AS Employee_Salary, 
    (SELECT AVG(Salary) FROM Employee) AS Average_Salary
FROM 
    Employee e
JOIN 
    Departments d ON e.Dno = d.Dnum
WHERE 
    e.Salary > (SELECT AVG(Salary) FROM Employee)
ORDER BY 
    e.Salary DESC;

------------------------------------------
--2)
SELECT 
    e.Fname AS Employee_First_Name, 
    e.Lname AS Employee_Last_Name, 
    COUNT(d.Dependent_name) AS Number_of_Dependents
FROM 
    Employee e
LEFT JOIN 
    Dependent d ON e.SSN = d.ESSN
GROUP BY 
    e.Fname, e.Lname
ORDER BY 
    e.Fname, e.Lname;
---------------------------------------------
--3)
SELECT 
    s.Fname AS Supervisor_First_Name, 
    s.Lname AS Supervisor_Last_Name, 
    s.SSN AS Supervisor_SSN,
    CONVERT(date, s.Bdate) AS Supervisor_Birth_Date,
    s.Address AS Supervisor_Address,
    s.Sex AS Supervisor_Sex,
    s.Salary AS Supervisor_Salary,
    s.SuperSSN AS Supervisor_SSN,
    s.Dno AS Supervisor_Department_No,
    COUNT(e.SSN) AS Number_of_Employees
FROM 
    Employee e
JOIN 
    Employee s ON e.SuperSSN = s.SSN
GROUP BY 
    s.Fname, s.Lname, s.SSN, s.Bdate, s.Address, s.Sex, s.Salary, s.SuperSSN, s.Dno
ORDER BY 
    COUNT(e.SSN) desc;
------------------------------------------
--4)
SELECT 
    p.Pname AS Project_Name, 
    p.Plocation AS Project_Location, 
    p.City AS Project_City,
    COUNT(DISTINCT w.ESSN) AS Number_of_Employees,
    SUM(w.Hours) AS Total_Worked_Hours
FROM 
    Project p
JOIN 
    Works_for w ON p.Pnumber = w.Pno
GROUP BY 
    p.Pname, p.Plocation, p.City
ORDER BY 
    SUM(w.Hours) desc;
--------------------------------------------
--5)
SELECT TOP 1
    p.Pname AS Project_Name, 
    p.Plocation AS Project_Location, 
    p.City AS Project_City,
    SUM(w.Hours) AS Total_Worked_Hours
FROM 
    Project p
JOIN 
    Works_for w ON p.Pnumber = w.Pno
GROUP BY 
    p.Pname, p.Plocation, p.City
ORDER BY 
    Total_Worked_Hours DESC;
-------------------------------------------
--6)
SELECT 
    d.Dname AS Department_Name,
    COUNT(e.SSN) AS Number_of_Employees,
    SUM(e.Salary) AS Total_Salary
FROM 
    Departments d
LEFT JOIN 
    Employee e ON d.Dnum = e.Dno
GROUP BY 
    d.Dname
ORDER BY 
    d.Dname;
------------------------------------------
--7)
WITH DepartmentSalaries AS (
    SELECT 
        d.Dnum,
        d.Dname,
        d.MGRSSN,
		d.[MGRStart Date],
        SUM(e.Salary) AS Total_Salary
    FROM 
        Departments d
    LEFT JOIN 
        Employee e ON d.Dnum = e.Dno
    GROUP BY 
        d.Dnum, d.Dname, d.MGRSSN,d.[MGRStart Date]
),
AverageSalary AS (
    SELECT 
        AVG(Total_Salary) AS AvgTotalSalary
    FROM 
        DepartmentSalaries
)
SELECT 
    ds.Dnum,
    ds.Dname,
    ds.MGRSSN,
	CONVERT(date, ds.[MGRStart Date]) AS MGRStart_Date,
    ds.Total_Salary,
	a.AvgTotalSalary
FROM 
    DepartmentSalaries ds,
    AverageSalary a
WHERE 
    ds.Total_Salary > a.AvgTotalSalary
ORDER BY 
    ds.Dname;
---------------------------------------------
--8)
WITH OldestDepartment AS (
    SELECT TOP 1
        Dnum,
        Dname,
        MGRSSN,
        [MGRStart Date]
    FROM 
        Departments
    ORDER BY 
        [MGRStart Date]
)
SELECT 
    d.Dnum AS Department_Number,
    d.Dname AS Department_Name,
    d.MGRSSN AS Manager_SSN,
    m.Fname AS Manager_First_Name,
    m.Lname AS Manager_Last_Name,
    CONVERT(date, m.Bdate) AS Manager_Birth_Date,
    m.Address AS Manager_Address,
    m.Sex AS Manager_Sex,
    m.Salary AS Manager_Salary,
    CONVERT(date, d.[MGRStart Date])AS Manager_Start_Date,
    CASE 
        WHEN d.Dnum = od.Dnum THEN 'Oldest Department'
		ELSE ''
    END AS Department_Type
FROM 
    Departments d
JOIN 
    Employee m ON d.MGRSSN = m.SSN
LEFT JOIN 
    OldestDepartment od ON d.Dnum = od.Dnum
ORDER BY 
    d.Dname;
------------------------------------------------------
--9)
SELECT 
    e.Sex AS Gender,
    COUNT(*) AS Number_of_Employees
FROM 
    Employee e
GROUP BY 
    e.Sex;
------------------------------------------------------
--10)
WITH Managers AS (
    SELECT 
        MGRSSN
    FROM 
        Departments
),
Supervisors AS (
    SELECT 
        DISTINCT SuperSSN
    FROM 
        Employee
    WHERE 
        SuperSSN IS NOT NULL
)
SELECT 
    e.SSN AS Employee_SSN,
    e.Fname AS First_Name,
    e.Lname AS Last_Name,
    CONVERT(date, e.Bdate) AS Birth_Date,
    e.Address AS Address,
    e.Sex AS Gender,
    e.Salary AS Salary,
    CASE
        WHEN e.SSN IN (SELECT MGRSSN FROM Managers) THEN 'Manager'
        WHEN e.SSN IN (SELECT SuperSSN FROM Supervisors) THEN 'Supervisor'
        ELSE 'Unknown'
    END AS Role
FROM 
    Employee e
WHERE 
    e.SSN IN (SELECT MGRSSN FROM Managers)
    OR e.SSN IN (SELECT SuperSSN FROM Supervisors)
ORDER BY 
    e.Fname, e.Lname;
-------------------------------------------------------------
--11)
SELECT 
    e.SSN AS Employee_SSN,
    e.Fname AS First_Name,
    e.Lname AS Last_Name,
    CONVERT(date, e.Bdate) AS Birth_Date,
    e.Address AS Address,
    e.Sex AS Gender,
    e.Salary AS Current_Salary,
    e.Salary * 1.25 AS New_Salary
FROM 
    Employee e
ORDER BY 
    e.Fname, e.Lname;
----------------------------------------------------------------
--12)

INSERT INTO Departments (Dnum, Dname, MGRSSN, [MGRStart Date])
VALUES (40, 'DP4', 321654, '2024-07-03');

INSERT INTO Employee (SSN, Fname, Lname, Bdate, Address, Sex, Salary, SuperSSN, Dno)
VALUES (101029, 'Adel', 'Ibrahim', '1990-10-01', '75 Fifth settlement, Cairo', 'M', 2000, 321654, 40);
----------------------------------------------------------------
--13)
UPDATE Departments
SET 
    Dname = 'DP4',
    MGRSSN = 101029,
    [MGRStart Date] = '2024-06-30'
WHERE 
    Dnum = 40;
-----------------------------------------------------------------
--14)
go
CREATE VIEW vw_Top3Employees AS
WITH EmployeeWorkHours AS (
    SELECT 
        e.SSN,
        e.Fname,
        e.Lname,
        e.Dno,
        d.Dname,
        d.MGRSSN,
        COUNT(DISTINCT w.Pno) AS Project_Count,
        SUM(w.Hours) AS Total_Worked_Hours
    FROM 
        Employee e
    JOIN 
        Works_for w ON e.SSN = w.ESSN
    JOIN 
        Departments d ON e.Dno = d.Dnum
    GROUP BY 
        e.SSN, e.Fname, e.Lname, e.Dno, d.Dname, d.MGRSSN
),
EmployeeDependents AS (
    SELECT 
        ESSN,
        COUNT(*) AS Number_of_Dependents
    FROM 
        Dependent
    GROUP BY 
        ESSN
)
SELECT TOP 3
    ewh.SSN AS Employee_SSN,
    ewh.Fname + ' ' + ewh.Lname AS Full_Name,
    ewh.Dname AS Department_Name,
    ewh.MGRSSN AS Manager_SSN,
    ewh.Project_Count,
    ewh.Total_Worked_Hours,
    COALESCE(ed.Number_of_Dependents, 0) AS Number_of_Dependents
FROM 
    EmployeeWorkHours AS ewh
LEFT JOIN 
    EmployeeDependents ed ON ewh.SSN = ed.ESSN
ORDER BY 
    ewh.Total_Worked_Hours DESC;
	go
/*
IF OBJECT_ID('vw_Top3Employees', 'V') IS NOT NULL
    DROP VIEW vw_Top3Employees;
*/
SELECT * FROM vw_Top3Employees;
-----------------------------------------------------------------
--15)
SELECT 
    e.Fname + ' ' + e.Lname AS Employee_Full_Name
FROM 
    Employee e
JOIN 
    Employee s ON e.SuperSSN = s.SSN
WHERE 
    s.Fname = 'Kamel' AND s.Lname = 'Mohamed';
-----------------------------------------------------------------
--16)

/*IF OBJECT_ID('vw_CompletedProjects', 'V') IS NOT NULL
    DROP VIEW vw_CompletedProjects;
*/GO

CREATE VIEW vw_CompletedProjects AS
SELECT 
    p.Pnumber AS Project_No,
    p.Pname AS Project_Name,
    p.Plocation AS Project_Location,
    SUM(w.Hours) AS Total_Worked_Hours
FROM 
    Project p
JOIN 
    Works_for w ON p.Pnumber = w.Pno
GROUP BY 
    p.Pnumber, p.Pname, p.Plocation
HAVING 
    SUM(w.Hours) > 40;
GO
SELECT * FROM vw_CompletedProjects;

------------------------------------------------------------
select*
from Employee
