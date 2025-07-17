CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    join_date DATE
);

CREATE TABLE Attendance (
    emp_id INT,
    work_date DATE,
    hours_worked INT,
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id)
);

CREATE TABLE LeaveRecord (
    emp_id INT,
    leave_date DATE,
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id)
);
