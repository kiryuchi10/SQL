--Practice 2
SELECT *
FROM employees;

SELECT*
FROM jobs;
--ex01
SELECT COUNT(manager_id) haveMngCNt
FROM employees;

--ex02
SELECT MAX(Salary)as 최고임금, MIN(salary) as 최저임금,
   MAX(salary) - MIN(salary) 임금차이
FROM employees;
--ex03
SELECT TO_CHAR(MAX(hire_date),'YYYY"년" MM"월" DD"일"') AS 마지막입사
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
GROUP BY job_id
ORDER BY 최저임금 DESC,평균임금 ASC;


--ex06
SELECT job_id
    ,min(salary) AS 최저임금, ROUND(AVG(salary),2) AS 평균임금,max(salary) AS 최고임금 
FROM employees
GROUP BY job_id
ORDER BY 최저임금 DESC,
         평균임금,
         job_id;
--ex07
SELECT TO_CHAR(MAX(hire_date),'YYYY-MM-DD Day','NLS_DATE_LANGUAGE=KOREAN') AS 최장근속
FROM employees;
--ex08
SELECT department_id,
     min(salary) AS 최저임금, ROUND(AVG(salary),2) AS 평균임금,max(salary) AS 최고임금
     ,ROUND(AVG(salary)-min(salary),0) AS 차이
FROM employees 
HAVING AVG(salary)-min(salary)<2000
GROUP BY department_id
ORDER BY 차이 DESC;
--ex09
--2015년 이후 입사자중 관리자별로 평균급여 최소급여 최대급여를 알아보려고 한다. 
--출력은 관리자별로 평균급여가 5000이상 중에 평균급여 최소급여 최대급여를 출력합니다. 
--평균급여의 내림차순으로 정렬하고 평균급여는 소수점 첫째짜리에서 반올림 하여 출력합니다.
SELECT job_id,
     min(salary) AS 최저임금, ROUND(AVG(salary),2) AS 평균임금,max(salary) AS 최고임금
FROM employees 
WHERE hire_date >= TO_DATE('15/01/01', 'YY/MM/DD') AND job_id LIKE ('%MAN%') OR
    job_id LIKE('%MGR%')
GROUP BY job_id
HAVING AVG(salary) >=5000
ORDER BY 평균임금 DESC;
--ex10
--아래회사는 보너스 지급을 위해 직원을 입사일 기준으로 나눌려고 합니다.  
--입사일이 12/12/31일 이전이면 '창립맴버, 13년은 '13년입사’, 14년은 ‘14년입사’  
--이후입사자는 ‘상장이후입사’ optDate 컬럼의 데이터로 출력하세요. 
--정렬은 입사일로 오름차순으로 정렬합니다.
SELECT
    employee_id,
    first_name,
    hire_date,
    CASE
        WHEN hire_date < TO_DATE('2012-12-31', 'YYYY-MM-DD') THEN '창립맴버'
        WHEN TO_CHAR(hire_date, 'YYYY') = '2013' THEN '13년입사'
        WHEN TO_CHAR(hire_date, 'YYYY') = '2014' THEN '14년입사'
        ELSE '상장이후입사'
    END AS optDate
FROM
    employees
ORDER BY
    hire_date ASC;
    
    
