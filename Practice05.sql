SELECT * FROM employees;
SELECT first_name, employee_id,manager_id FROM employees;

SELECT
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    m.employee_id AS manager_id,
    e.employee_id
FROM
    employees e
LEFT JOIN
    employees m ON e.manager_id = m.employee_id
WHERE
    e.manager_id IS NULL OR e.manager_id != e.employee_id
ORDER BY
    m.employee_id;
--문제1. 
--담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의  
--이름, 매니저 아이디, 커미션 비율, 월급을 출력하세요. 
--SELECT e.이름, e.매니저_아이디, e.커미션_비율, e.월급
--FROM 직원 e
--JOIN 직원 m ON e.매니저_아이디 = m.직원_아이디
--WHERE e.커미션_비율 IS NULL
--AND e.월급 > 3000;

SELECT e.first_name, e.manager_id, e.commission_pct, e.salary,e.employee_id
FROM employees e
    JOIN employees m 
        ON e.manager_id=m.employee_id
WHERE e.commission_pct IS NULL
    AND e.salary >3000
ORDER BY salary DESC;

--(45건) 
--문제2.  
--각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 급여
--(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id)를 조회하세
--요  -조건절 비교 방법으로 작성하세요 -급여의 내림차순으로 정렬하세요 
--입사일은 2001-01-13 토요일 형식으로 출력합니다. 
--전화번호는 515-123-4567 형식으로 출력합니다. 
--1.515.555.0100
--(11건) 
SELECT e.employee_id, e.first_name , e.salary,
    TO_CHAR(e.hire_date, 'YYYY-MM-DD DAY') AS 입사일,
    SUBSTR(e.phone_number, 3, 3) || '-' || 
    SUBSTR(e.phone_number, 7, 3) || '-' || 
    SUBSTR(e.phone_number, 11, 4) AS 전화번호,
    e.department_id AS 부서번호
FROM employees e 
WHERE (e.department_id, e.salary) IN (
        SELECT 
            department_id, MAX(salary)
        FROM 
            employees
        GROUP BY 
            department_id
    )
ORDER BY salary DESC;

--문제3 
--매니저별로 평균급여 최소급여 최대급여를 알아보려고 한다. 
--통계대상(직원)은 2015년 이후의 입사자 입니다. -매니저별 평균급여가 5000이상만 출력합니다. 
--매니저별 평균급여의 내림차순으로 출력합니다. 
--매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다. 
--출력내용은 매니저 아이디, 매니저이름(first_name), 매니저별 평균급여, 매니저별 최소급여, 
--매니저별 최대급여 입니다. 
--(9건) 
SELECT
    m.manager_id AS 매니저_아이디,
    m.first_name AS 매니저_이름,
    ROUND(AVG(e.salary), 1) AS 매니저별_평균급여,
    MIN(e.salary) AS 매니저별_최소급여,
    MAX(e.salary) AS 매니저별_최대급여
FROM
    employees e
JOIN
    employees m ON e.manager_id = m.employee_id
WHERE
    e.hire_date >= DATE '2015-01-01'
GROUP BY
    m.manager_id, m.first_name
HAVING
    AVG(e.salary) >= 5000
ORDER BY
    매니저별_평균급여 DESC;
--문제4. 
--각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명
--(department_name), 매니저(manager)의 이름(first_name)을 조회하세요. 
--부서가 없는 직원(Kimberely)도 표시합니다. 
--(106명) 
SELECT
    e.employee_id AS 사번,
    e.first_name AS 이름,
    COALESCE(d.department_name, '부서 없음') AS 부서명,
    COALESCE(m.first_name, '부서 없음') AS 매니저
FROM
    employees e
LEFT JOIN
    departments d ON e.department_id = d.department_id
LEFT JOIN
    employees m ON e.manager_id = m.employee_id;
--문제5. 
--2015년 이후 입사한 직원 중에 입사일이 11번째에서 20번째의 직원의  
--사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요 
SELECT
    row_num,
    employee_id AS 사번,
    first_name AS 이름,
    department_name AS 부서명,
    salary AS 급여,
    manager_id,
    TO_CHAR(hire_date, 'YYYY-MM-DD') AS 입사일
FROM (
    SELECT
        e.employee_id,
        e.first_name,
        d.department_name,
        d.manager_id,
        e.salary,
        e.hire_date,
        ROW_NUMBER() OVER (ORDER BY e.hire_date) AS row_num
    FROM
        employees e
    JOIN
        departments d ON e.department_id = d.department_id
    WHERE
        e.hire_date >= DATE '2015-01-01' AND e.hire_date < DATE '2016-01-01'
)
WHERE
    row_num BETWEEN 11 AND 20
ORDER BY
    hire_date;
    
SELECT
        e.employee_id,
        e.first_name,
        d.department_name,
        e.salary,
        e.hire_date,
        ROW_NUMBER() OVER (ORDER BY e.hire_date) AS row_num
    FROM
        employees e
    JOIN
        departments d ON e.department_id = d.department_id
    WHERE
        e.hire_date >= DATE '2015-01-01' AND e.hire_date < DATE '2016-01-01';
--문제6. 
--가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름
--(department_name)은? 
SELECT 
    e.first_name,
    e.last_name,
    e.salary,
    e.hire_date,
    d.department_name
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    e.hire_date = (
        SELECT 
            MAX(hire_date)
        FROM 
            employees
    );
--문제7. 
--평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 성
--(last_name)과  업무(job_title), 연봉(salary)을 조회하시오.
--몰라
SELECT
    employee_id,
    first_name,
    last_name,
    department_id AS 부서번호,
    AVG(salary) AS 평균급여
FROM
    (SELECT employee_id,
    first_name,
    last_name,
    department_id AS 부서번호,
    AVG(salary) AS 평균급여
    FROM employees
    WHERE salary=max(평균급여));
--inside FROM   
SELECT employee_id,
    first_name,
    last_name,
    department_id AS 부서번호,
    AVG(salary) AS 평균급여,
    ROW_NUMBER() OVER (ORDER BY e.평균급여) AS row_num
    FROM employees
    WHERE salary=max(평균급여)    
GROUP BY
    employee_id
ORDER BY
    AVG(salary) DESC
FETCH FIRST 3 ROW ONLY;

SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.job_title,
    e.salary
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    d.department_id = (
        SELECT 
            department_id
        FROM 
            (
            SELECT 
                department_id,
                AVG(salary) AS avg_salary
            FROM 
                employees
            GROUP BY 
                department_id
            ORDER BY 
                avg_salary DESC
            ) AS subquery
        LIMIT 1
    );
--문제8. 
--평균 급여(salary)가 가장 높은 부서는?  
SELECT
    department_id AS 부서번호,
    AVG(salary) AS 평균급여
FROM
    employees
GROUP BY
    department_id
ORDER BY
    AVG(salary) DESC
FETCH FIRST 1 ROW ONLY;


--문제9. 
--평균 급여(salary)가 가장 높은 지역은?  
SELECT
    l.city AS 지역,
    AVG(e.salary) AS 평균급여
FROM
    employees e
JOIN
    departments d ON e.department_id = d.department_id
JOIN
    locations l ON d.location_id = l.location_id
GROUP BY
    l.city
ORDER BY
    AVG(e.salary) DESC
FETCH FIRST 1 ROW ONLY;
--문제10. 
--평균 급여(salary)가 가장 높은 업무는?
SELECT
    j.job_title AS 업무,
    AVG(e.salary) AS 평균급여
FROM
    employees e
JOIN
    jobs j ON e.job_id = j.job_id
GROUP BY
    j.job_title
ORDER BY
    AVG(e.salary) DESC
FETCH FIRST 1 ROW ONLY;