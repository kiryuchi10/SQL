-- 주석처리
-- 마지막에 세미콜론으로 끝난다
-- 키워드들은 대소문자를 구분하지 않는다
-- 실제 데이터의 경우 대소문자를 구분한다


--테이블 구조 확인 (DESCRIBE)
DESCRIBE employees;
--describe EMPLOYEES;

DESCRIBE departments;
DESCRIBE locations;

--* : 테이블 내의 모든 컬럼 Projection, 테이블 설계시에 정의한 순서대로 
SELECT * FROM employees; 

-- 특정 컬럼만 projecion하고자 하면 열 목록을 명시

-- employees 테이블의 first name과 phone number, hire date, salary

SELECT first_name,phone_number,hire_date,salary FROM employees;

--사원의 이름, 성 급여, 전화번호, 입사일 정보 출력
SELECT first_name,last_name,phone_number, hire_date FROM employees;

--사원 정보로부터 사번, 이름 성 정보 출력
SELECT employee_id,first_name,last_name FROM employees;

-- 산술연산 : 기본적인 산술연산을 수행할 수 있다.
-- 특정 테이블의 갑시 아닌 시스템으로부터 데이터를 받아오고자 할때 : dual  (가상 테이블)
SELECT 3.14159 * 10 * 10 FROM dual;

SELECT first_name,
    salary,
    salary * 12
FROM employees;

-- 다음 문장을 실행해 봅시다. 수치 데이터가 아니면 산술 연산 불가 
SELECT first_name,
    job_id,
    job_id*12
From employees;

--NVL 활용 대체값 계산
SELECT first_name,salary, commission_pct,
    salary+salary*NVL(commission_pct,0) -- NVL null 이면 0, null 아니면 commission_pct
FROM employees;

--null은 0이나 ""와 다르게 빈 값이다. 

--별칭 alias
--projection 단계에서 출력용으로 표시되는 임시 컬럼 제목

--컬럼명 뒤에 별칭
--컬럼명 뒤에 as 별칭
--표시명에 특수문자 포한된 경우 ""로 묶어서 부여

--직원 아이디, 이름, 급여 출력
--직원 아이디는 empNo 이름은 f_name, 급여는 dnjfrmqdmfh vytl

SELECT employee_id empNo
    ,first_name as "f-name"
    ,salary as "급여"
FROM employees;

--직원 이름(first_name, last_name 합쳐서 출력) name
-- 급여 (커미션이 포함된 급여), 급여 *12 연봉 별칭으로 표기

SELECT first_name+last_name,
    salary+salary*nvl(commission_pct,0),
    salary*12
FROM employees;

SELECT first_name ||' '|| last_name "Full Name",
       salary+salary*nvl(commission_pct,0),
    salary*12
FROM employees;

--연습 : alias 붙이기 (employees 테이블)
--이름:

SELECT first_name ||' '|| last_name as "이름" ,
    hire_date 입사일 , phone_number 전화번호, 
    salary 급여,salary*12 연봉 
FROM employees;

--where
--특정 조건을 기준으로 레코드를 선택 (Selection)
--비교연산 , =,<>,>,<,<=

--사원들 중에서 급여가 15000 이상인 직원과

SELECT first_name,salary 
FROM employees
Where salary >15000;

--입사일이 07/01/01 이후인 직원들의 이름과 입사일
SELECT 
    first_name, hire_date
FROM employees
WHERE hire_date>='17/01/01';

SELECT
    first_name,salary
FROM employees
WHERE salary <=4000
    or
      salary>=17000;

SELECT
    first_name,salary
FROM employees
WHERE salary >=14000
    AND
      salary<17000;

--BETWEEN :범위 비교

SELECT
    first_name,salary
FROM employees
WHERE salary BETWEEN 14000 AND 17000;


-- Null 체크, =,<> 사용하면 안도미
--IS NULL, IS NOT NULL

--commission을 받지 않는 사람들 (commission_pct =NULL)
SELECT first_name,commission_pct
FROM employees 
WHERE commission_pct IS NULL;

SELECT first_name,commission_pct
FROM employees 
WHERE commission_pct IS NOT NULL;

SELECT first_name, department_id 
FROM employees
WHERE department_id = 10 OR 
      department_id =20  OR    
      department_id =40;
    
-- In 연산자 : 특정 집합의 요소 비교
SELECT first_name, department_id 
FROM employees
WHERE department_id IN (10,20,40);

----------
--Like 연산
----------
--와일드카드 (%,_)를 이용한 부분 문자열 매핑
--% : 0 개 이상의 정해지지 않는 문자열
--_ : 1개의 정해지지 않는 문자

--이름에 am을 포함하고 있는 사원의 이름과 급여 출력
SELECT first_name, salary 
FROM employees
WHERE LOWER(first_name) LIKE  '%am%';

-- 이름의 두번 째의 글자가 a인 사원의 이름과 급여

SELECT first_name, salary 
FROM employees
WHERE LOWER(first_name) LIKE  '_a%';

--이름의 4번째 글자가 a인 사원
SELECT first_name, salary 
FROM employees
WHERE LOWER(first_name) LIKE  '___a%';
--이름이 4글자인 사원 중에서 두번째 글자가 a인 사원의 이름과 급여
SELECT first_name, salary 
FROM employees
WHERE LOWER(first_name) LIKE  '%_a__%';

-- 부서 ID가 90인 사원 중 , 급여가 20000 이상인 사원
SELECT first_name, department_id,salary
FROM employees
WHERE department_id = 90  AND salary >=20000;

--입사일이 01/01/01~07/12/31에 있는 사원의 목록
SELECT first_name, hire_date
FROM employees
WHERE hire_date BETWEEN '11/01/01' AND '17/12/31';

--manager_id가 100, 120 147인사원의 명단
SELECT first_name, manager_id
FROM employees
WHERE manager_id IN (100,120,147);

------------------
-- ORDER BY
------------------

--특정 컬럼명, 연산식, 아니면 별칭, 컬럼순서를 기준으로 레코드를 정렬 


-- 부서 번호 오름차순으로 정렬, 부서번호, 급여, 이름 출력해보자 
SELECT department_id, salary, first_name 
FROM employees
ORDER By department_id ASC; --ASC는 생략가능
-- 급여가 10000 이상, 급여의 내림차순으로 출력 , 이름, 급여 
SELECT department_id, salary, first_name 
FROM employees
WHERE salary >=10000
ORDER BY salary DESC;
-- 부서번호 급여 이름순으로 출력, 정렬 기준 부서번호 오름차순, 급여 내림차순
SELECT department_id, salary, first_name 
FROM employees
ORDER BY department_id ASC,salary DESC;

-- 정렬 기준을 어떻게 세우느냐에 따라 성능, 출력 결과 영향을 미칠 수 있다

--문자열 단일행 함수
SELECT first_name,last_name
FROM employees;

SELECT first_name,last_name,
    CONCAT(first_name,CONCAT(' ',last_name)),
    first_name||' '|| last_name,
    INITCAP(first_name ||' '||last_name)
FROM employees;

SELECT first_name,last_name,
    LOWER(first_name),-- 모두 소문자로
    UPPER(first_name),-- 모두 대문자로 
    LPAD(first_name,20,'*'),-- *로 빈자리채우기 왼쪽
    RPAD(first_name,20,'*')
FROM employees;

SELECT '   Oracle  ',
    '*******Database*********',
    LTRIM('             Oracle          '),
    LTRIM('             Oracle          '),
    SUBSTR('Oracle Database',8,4),
    SUBSTR('Oracle Database',-8,4),
    LENGTH('Oracle Database')
FROM dual;

SELECT 3.14159,
    ABS(-3.14),
    CEIL(3.14),--올림
    FLOOR(3.14),--버림
    ROUND(3.14159,3),
    ROUND(3.5),
    TRUNC(3.5),
    TRUNC(3.14159,3), --소수점 네째 자리에서 버림
    SIGN(-3.14159), --부호 (-1: 음수, 0:), 1:양수)
    MOD(7,3),
    POWER(2,4)
FROM dual;

--쟈네
SELECT * 
FROM nls_session_parameters;

SELECT CONCAT('Hello World', ' ', '!!!!!!')
FROM DUAL;



--DATa Formtat
SELECT value FROM nls_session_parameters
WHERE parameter='NLS_Date_Format';


SELECT sysdate FROM dual;
SELECT sysdate FROM employees;

--SELECT
--    sysdate,
--    ADD_MONTHS(sysdate,2),
--    Last_day(sysdate),
--    MONTHS_BETWEEN('12/09/24',sysdate),-- 두 날짜 사이의 개월 차
--    NEXT_DAY(sysdate,7),
--    ROUND(sysdate,'MONTH'),
--    TRUNCATE(sysdate,'MON)
--FROM DUAl;

SELECT first_name,hire_date,
    ROUND(MONTHS_BETWEEN(sysdate,hire_date)) as 근속일수
FROM employees;

SELECT first_name,to_char(salary*12,'$999,99.00') "SAL"
FROM employees
WHERE department_id=110;

----------------
---변환함수
----------------

--TO_NUMBERS(s,fmt) : 문자열 -> 숫자
--TO_DATE
--TO_CHAR(o,smt)

SELECT first_name,
    TO_CHAR(hire_date, 'YYYY-MM-DD')
FROM employees;

SELECT sysdate,
    TO_CHAR(sysdate, 'YYYY--MM-DD HH:MI:SS')
FROM dual;

SELECT 
    TO_CHAR(3000000,'L999,999,999.99')
FROM dual;

--모든 직원의 이름과 연봉 정보를 표시
SELECT
    first_name, salary,commission_pct,TO_CHAR(salary+salary* nvl(commission_pct,0)*12, '$999,999.99') 연봉
FROM employees;

--문자 -> 숫자 : TO_NUMBER
SELECT '$57,600',
    TO_NUMBER('$57,600','$999,999')/12 월급
FROM dual;

--문자열 -> 날짜 
SELECT '2012-09-24 13:48:00', 
    TO_DATE('2012-09-24 13:48:00','YYYY-MM-DD HH24:MI:SS')
FROM dual;

SELECT CONCAT('Hello World', ' ', '!!!!!!');


--날짜 연산
--Date +/- Number : 특정 날수를 더하거나 뺄 수 있다.
--Date-Date : 두 날짜의 경과 일수
--Date + Number / 24 : 특정 시간이 지난 후의 날짜
SELECT
    sysdate,
    sysdate+1,sysdate-1,
    sysdate-TO_DATE('20120924'),
    sysdate+48/24 -- 48 시간이 지난 후의 날짜
FROM dual;

SELECT first_name,
    salary,
    nvl(salary*commission_pct,0) commission
FROM employees;

SELECT first_name,
    salary,
    nvl2(commission_pct, salary*commission_pct,0) commission -- nvl2(조건문, null이 아닐때의 값, null일때의 값)
FROM employees;

-- CASE function
-- 보너스를 지급하기로 했습니다.
-- AD관련 직종에게는 20%, SA관련 직원에게는 10%, IT관련 직원들에게는 8%, 나머지에게는 5%
SELECT first_name, job_id,salary,
    SUBSTR(job_id,1,2),
    CASE SUBSTR(job_id,1,2)  WHEN 'AD' THEN salary*0.2
                             WHEN 'SA' THEN salary*0.1
                             WHEN 'IT' THEN salary*0.08
                             else salary*0.05
    END bonus
FROM employees;

SELECT first_name, job_id, salary,
    SUBSTR(job_id,1,2),
    DECODE(SUBSTR(job_id,1,2),
                        'AD',salary*0.2,
                        'SA',salary*0.1,
                        'IT',salary*0.08,
                        salary*0.05) bonus
FROM employees;




--연습문제
--직원의 이름, 부서, 팀을 출력
--팀은 부서 아이디로 결정 
--10~30이면 A, 40~50이면 B, 60~100이면 C 그룹, 나머지 부서는 Remainder
SELECT first_name||' '||last_name,department_id,
    CASE  WHEN department_id BETWEEN 10 AND 30 then 'A-GROUP'
          WHEN department_id BETWEEN 40 AND 50 then 'B-GROUP'
          WHEN department_id BETWEEN 60 AND 100 then 'C-GROUP'
          else 'Remainder'
    END 팀
FROM employees
ORDER BY 팀 ASC, 부서 ASC;


