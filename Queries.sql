1. Overwork Detection


SELECT e.emp_id, e.emp_name, e.department, COUNT(a.work_date) AS Overwork_Days
FROM Employee e
JOIN Attendance a
ON e.emp_id = a.emp_id
WHERE a.hours_worked > 10
GROUP BY e.emp_id, e.emp_name, e.department
HAVING COUNT(a.work_date) >= 2;



2. Leave Check(Last 60 Days)


SELECT e.emp_id, e.emp_name, e.department
FROM Employee e
WHERE NOT EXISTS (
    SELECT 1 FROM LeaveRecord l
    WHERE l.emp_id = e.emp_id 
    AND l.leave_date >= DATEADD(DAY, -60, GETDATE())
);


3.Burnout Risk Report


SELECT e.emp_id, e.emp_name, e.department,
CASE 
    WHEN COUNT(CASE WHEN a.hours_worked > 10 THEN 1 END) >= 2 
         AND NOT EXISTS (
             SELECT 1 FROM LeaveRecord l
             WHERE l.emp_id = e.emp_id 
             AND l.leave_date >= DATEADD(DAY, -60, GETDATE())
         ) THEN 'High Risk'
    WHEN COUNT(CASE WHEN a.hours_worked > 10 THEN 1 END) >= 2 THEN 'Moderate Risk'
    ELSE 'Low Risk'
END AS Risk_Level
FROM Employee e
LEFT JOIN Attendance a ON e.emp_id = a.emp_id
GROUP BY e.emp_id, e.emp_name, e.department;