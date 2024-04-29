---------------
--Join
---------------

--employees와 departments
DESC employees;
DESC departments;

SELECT *
FROM employees,departments;

SELECT * FROM employees;
SELECT * FROM departments;

--카티젼 프로덕트
SELECT *
FROM employees,departments
WHERE employees.department_id=departments.department_id;
-- INNER JOIN
SELECT first_name,
       emp.department_id,
       dept.department_id,
       department_name
FROM employees emp,departments dept
WHERE emp.department_id=dept.department_id;

SELECT * FROM employees;

SELECT * FROM employees
WHERE department_id is NULL;

SELECT emp.first_name,
       dept.department_name
FROM employees emp JOIN departments dept USING(department_id);

---------------
-- Theta Join
---------------

-- Join 조건이 = 아닌 다른 조건을 

-- 급여가 직군 평균 급여보다 낮은 직원들 목록
SELECT emp.employee_id,
       emp.first_name,
       emp.salary,
       emp.job_id,
       j.job_id,
       j.job_title
FROM employees emp
      JOIN jobs j
            ON emp.job_id=j.job_id
WHERE salary<=((j.min_salary+j.max_salary)/2);

------------
--outer join
------------
-- 조건을 만족하는 짝이 없는 튜플도 NULL을 포함해서 결과 출력에 참여시키는 방법
-- 모든 결과를 표현한 테이블이 어느 쪽에 위치하는가에 따라 LEFT, RIGHT, FULL OUTER JOIN으로 구분
-- ORACLE SQL의 경우 NULL이 출력되는 쪽에 (+)를 붙인다. 

-------------------
-- LEFT OUTER JOIN
-------------------

SELECT emp.first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp, departments dept
WHERE emp.department_id=dept.department_id(+); -- null이 포한된 테이블 쪽에 (+)로 표기

SELECT * FROM employees WHERE department_ID IS NULL; -- Kimberly-> 부서에 소속되지 않음

-- ANSI SQL - 명시적으로 JOIN 방법을 정한다
SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp
    LEFT OUTER JOIN departments dept
        ON emp.department_ID=dept.department_id;

-- ORACLE SQL
SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp, departments dept
WHERE emp.department_id(+)=dept.department_id;

--ANSI SQL
SELECT first_name,
    emp.department_id,
    dept.department_id
    department_name
FROM employees emp 
    RIGHT OUTER JOIN departments dept
        ON emp.department_id=dept.department_id;
        
---------------
--FUll OUTER JOIN
---------------

-- JOIN에 참여한 모든 테이블의 모든 레코드를 출력에 참여
-- 짝이 없는 레코드들은 null을 포함해서 출력에 참여

--ANSI SQL
SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp FULL OUTER JOIN
    departments dept
        ON emp.department_id=dept.department_id;

-- 조인할 테이블에 같은 이름의 컬럼이 있을 경우, 해당 컬럼을 기준으로 JOIN
-- 실제 본인이 JOIN 할 조건과 일치하는지 확인 
SELECT * FROM employees emp NATURAL JOIN departments dept;

SELECT * FROM employees emp JOIN departments dept ON emp.department_id=dept.department_id;
SELECT * FROM employees emp JOIN departments dept on emp.manager_id=dept.manager_id AND emp.department_id=dept.department_id;



-- 자기 자신과 JOIN
-- 자신을 두번 호출 -> 별칭을 반드시 부여해야 할 필요가 있는 조인

SELECT 
    emp.employee_id,
    emp.first_name,
    emp.manager_id,
    man.first_name
FROM employees emp, employees man
WHERE emp.manager_id = man.employee_id;

--ANSI
--Join의 의도를 명확하게하고 조인 조건과 SELECTION 조건을 분리하는 효과

SELECT 
    emp.employee_id, emp.first_name, emp.last_name,
    dept.department_name
FROM employees emp,
    departments dept
        JOIN departments dept
            ON emp.department_id =dept.department_id
ORDER BY dept.department_name ASC, emp.employee_id DESC;

SELECT emp.id 사번,
    emp.first_name 급여,
    dept.department_name 부서명,
    j.job_title 현재업무
FROM employees emp,departments dept,jobs j
WHERE emp.departement_id = dept.department_id AND
    emp.job_id=j.job_id
ORDER BY emp.employee_id ASC;

--ANSI JOIN
SELECT emp.job_id 사번,
    emp.first_name 급여,
    dept.department_name 부서명,
    j.job_title 현재업무
FROM employees emp
        JOIN departments dept
            ON emp.department_id =dept.department_id
                JOIN jobs j
                    ON emp.job_id=j.job_id
ORDER BY emp.employee_id ASC;    

--
SELECT
    emp.employee_id 사번,
    emp.first_name 이름,
    emp.salary 급여,
    dept.department_name 부서명
    j.job_title 현재업무
FROM employees emp, deparments dept, jobs j
WHERE 
    emp.department_id=dept.department_id(+) AND --NULL이 포함된 테이블 쪽애 (+)
    emp.job_id =j.job_id
ORDER BY emp.employee_id ASC;


--ANSI JOIN
SELECT emp.job_id 사번,
    emp.first_name 이름,
    emp.salary 급여,
    dept.department_name 부서명,
    j.job_title 현재업무
FROM employees emp
        LEFT OUTER JOIN departments dept -- RIGHT OUTER JOIN시 kimberly의 값이 나오지 않을수도
            ON emp.department_id =dept.department_id
                JOIN jobs j
                    ON emp.job_id=j.job_id
ORDER BY emp.employee_id ASC;    

-----------------
--Griuo Aggregatiib
--집계 : 여러 행으로부터 데이터를 수집, 하나의 행으로 반환

--COUNT
--employees

SELECT COUNT(*) FROM employees;

--*로 카운트 하면 모든 행의 수를 반환
-- 특정 컬럼 내에 null 값이 포함되어 있는지의 여부는 중요하지 않음

-- commission을 받는 직원의 수를 알고 싶을 경우
-- commission_pct가 null인 경우를 제외하고 싶을 경우
SELECT COUNT(commission_pct) FROM employees;
-- 컬럼 내에 포함된 null 데이터를 카운트하지 않음

--위 쿼리는 아래 쿼리와 같다 
SELECT COUNT(*) FROM employees
WHERE commission_pct IS NOT NULL;


--sum : 합계 함수
-- 모든 사원의 급여의 합계
SELECT SUM(salary) FROM employees;


--AVG: 평균함수
--사원들의 평균 급여?
SELECT AVG(salary) FROM employees;

SELECT AVG(commission_pct) FROM employees;

--AVG 함수는 ㅜㅕㅣㅣ rkqdl vhgkaehldj dlTdmf ruddn rm rkqtdmf wlqrP tncldptj wpdhl
-- null 갑승 ㄹ집계 결과에 포함시킬지의 여부는 정책으로 결정하고 수행해야한다. 

SELECT 
    MIN(salary),
    MAX(salary),
    AVG(salary),
    MEDIAN(salary)
FROM employees;

SELECT department_id,AVG(salary)
FROM employees;

SELECT department_id FROM employees;
SELECT AVG(salary) FROM employees;
SELECT department_id,salary
FROM employees
ORDER BY department_id;

SELECT department_id,AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id ASC;


-- 부서별 평균 급여에 부서명도 포함하여 출력
SELECT emp.department_id, dept.department_name, ROUND(AVG(salary),2)
FROM employees emp
    JOIN departments dept
        ON emp.department_id=dept.department_id
GROUP BY emp.department_id,dept.department_name
ORDER BY emp.department_id;

-- GROUP BY 절 이후 GROUP BY에 참여한 컬럼과 집계 함수만 남는다. 

-- 평균 급여가 7000 이상인 부서만 출력
SELECT 
    department_id,AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;

SELECT 
    department_id,AVG(salary)
FROM employees
HAVING AVG(salary)>7000
GROUP BY department_id
ORDER BY department_id;

--ROLL UP 
--GROUP BY절과 함께 사용
--그룹지어진 결과에 대한 좀 더 상세한 요약을 제공하는 기능 수행
--일종의 ITEM TOTAL

SELECT 
    department_id,
    job_id,
    SUM(salary)
FROM employees
GROUP BY ROLLUP(department_id, job_id);

--CUBE
--CrossTab에 대한 Summary를 함계 추출하는 함수
--ROLLup 함수에 의해 출력되는 ITEM TOTAL 값과 함께
--COLUMN TOTAL 값을 함께 추출
SELECT 
    department_id,
    job_id,
    SUM(salary)
FROM employees
GROUP BY CUBE (department_id,job_id)
ORDER BY department_id

--------------
-- SUBQUERY
--------------

--모든 직원 급여의 중앙값보다 많은 급여를 받는 사원의 목록

--1) 직원 급여의 중앙값?
--2) 1)번의 결과보다 많은 급여를 받는 직원의 목록

--1) 직업 급여의 중앙값
SELECT MEDIAN(salary) FROM employees;--6200
SELECT first_name,salary
FROM employees
WHERE salary>=6200;

-- 1),2) 쿼리 합치기
SELECT first_name, salary
FROM employees
WHERE salary>=(SELECT MEDIAN(salary) FROM employees)
ORDER BY salary DESC;

--Susan보다 늦게 입사한 사원의 정보 
--1) 수잔의 입사일
--2) 1)번의 결과보다 늦게 입사한 사원의 정보를 추출

--1) susan의 입사일
SELECT hire_date FROM employees
WHERE first_name= 'Susan';--12/06/07

SELECT first_name,hire_date
FROM employees
WHERE hire_date>TO_CHAR('12/06/07');

--두 쿼리 합치기
SELECT first_name, hire_date
FROM employees
WHERE hire_date>(SELECT hire_date FROM employees WHERE first_name='Susan');

--연습문제