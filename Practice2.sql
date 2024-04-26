--Practice 2
SELECT *
FROM employees;
--ex01
SELECT COUNT(*),
    COUNT(manager_id) haveMngCNt
FROM employees;

--ex02
SELECT MAX(Salary)as 최고임금, MIN(salary) as 최저임금,
   MAX(salary) - MIN(salary) 임금차이
FROM employees;
--ex03
SELECT TO_CHAR(MAX(hire_date),'YYYY년 MM월 DD일') AS last_hire_date
FROM employees;
--ex04
SELECT ROUND(AVG(salary),1) 평균임금, MAX(salary) 최고임금,
        MIN(salary) 최저임금
FROM employees;
--ex05
SELECT  job_id,ROUND(AVG(salary),1) 평균임금, MAX(salary) 최고임금,
        MIN(salary) 최저임금
FROM employees
WHERE salary>=2500
ORDER BY salary DESC;