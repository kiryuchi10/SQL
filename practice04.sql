--서브쿼리(SUBQUERY) SQL 문제입니다. 
--문제1. 
--평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요. 
--(56건) 
SELECT first_name, salary
FROM employees
WHERE salary<(SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;

--문제2.  
--평균급여 이상, 최대급여 이하의 월급을 받는 사원의  
--직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를 급여의 오름차
--순으로 정렬하여 출력하세요  
--(51건) 
SELECT employee_id,first_name, salary
FROM employees
WHERE salary<=(SELECT MAX(salary) FROM employees) AND salary>=(SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;

--문제3. 
--직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소
--를 알아보려고 한다. 
--도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주
--(state_province), 나라아이디(country_id) 를 출력하세요 
--(1건) 
SELECT emp.first_name,emp.last_name,loc.location_id, loc.street_address, loc.postal_code,loc.city,
        loc.state_province
FROM employees emp
    JOIN departments dept
        ON emp.department_id=dept.department_id
    JOIN locations loc
        ON dept.location_id=loc.location_id
WHERE first_name='Steven' AND last_name='King';
    

--문제4. 
--job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 급여의 내림차순으로 
--출력하세요  -ANY연산자 사용 
--(74건) 
SELECT employee_id,job_id, first_name, salary
FROM employees
WHERE job_id = ANY ('ST_MAN')
ORDER BY salary DESC;
--문제5.  
--각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name)과 급여
--(salary) 부서번호(department_id)를 조회하세요  
--단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다.  
--조건절비교, 테이블조인 2가지 방법으로 작성하세요 
--(11건) 
SELECT emp.department_id, dept.department_name, ROUND(AVG(salary),2)
FROM employees emp
    JOIN departments dept
        ON emp.department_id=dept.department_id
GROUP BY emp.department_id,dept.department_name
ORDER BY emp.department_id;
--문제6. 
--각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다.  
--연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오  
--(19건)
SELECT emp.department_id, dept.department_name, ROUND(SUM(salary),2)
FROM employees emp
    JOIN departments dept
        ON emp.department_id=dept.department_id
    JOIN jobs j
        ON emp.job_id=j.job_id
GROUP BY emp.department_id,dept.department_name,j.job_title
ORDER BY j.job_title DESC;
--문제7. 
--자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원번호(employee_id), 이름
--(first_name)과 급여(salary)을 조회하세요  
--(38건) 
SELECT 
    first_name,
    salary,
    department_id
FROM employees outer
WHERE salary >(SELECT AVG(salary)
                FROM employees
                WHERE department_id =outer.department_id);

--문제8. 
--직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력
--하세요 
SELECT 
       *
FROM (
    SELECT
        employee_id,
        first_name,
        salary,
        hire_date,
        ROW_NUMBER() OVER (ORDER BY hire_date DESC) AS rank
    FROM 
        employees
)
WHERE 
    rank BETWEEN 11 AND 15;