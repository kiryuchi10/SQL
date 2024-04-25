SELECT *
FROM employees;
--ex01
SELECT first_name ||' '||last_name as 이름, salary 월급, phone_number 전화번호, hire_date 입사일
FROM employees
ORDER BY hire_date ASC;
--ex02
SELECT job_id 업무이름, salary 최고월급
FROM employees
ORDER BY salary  DESC;
--ex03
SELECT manager_id,commission_pct,salary,
      nvl(commission_pct,0)
FROM employees;

--ex04
SELECT job_id,salary
FROM employees
WHERE salary >=10000
ORDER BY salary DESC;
--ex05
SELECT first_name,salary,
        nvl(commission_pct,0) commission_pct
From employees
ORDER BY salary DESC;

--ex06
SELECT first_name,salary,hire_date,department_id,
        TO_CHAR(hire_date, 'YYYY-MM')
FROM employees
WHERE department_id in (10,90,100);
--ex07
SELECT first_name,salary
FROM employees
WHERE LOWER(first_name) LIKE  '%s%';
--ex08
SELECT *
FROM departments
ORDER BY LENGTH(department_name) DESC;
--ex09
SELECT UPPER(country_name) 나라
FROM countries
ORDER BY country_name ASC;
--ex10
SELECT first_name,salary,phone_number,hire_date,
        SUBSTR(REPLACE(phone_number,'.','-'),3) 전화번호
FROM employees;
WHERE hire_date < TO_DATE('13/12/31', 'YY/MM/DD');


