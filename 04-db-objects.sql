-----------------------------
--DB OBJECTS
-----------------------------

-- SYSTEM으로
--VIEW 생성을 위한 SYSTEM 권한 
GRANT CREATE VIEW TO himedia;

GRANT SELECT ON HR.employees TO himedia;
GRANT SELECT ON HR.departments TO himedia;

--himedia로 돌아가자
--SIMPLE VIEW 
--논리적 테이블
--단일 테이블 혹은 단일 뷰를 베이스로 한 함수, 연산식을 포함하지 않은 뷰

--emp123
DESC emp123;

-- emp123 테이블 기반 , deparmtnet_id=10 부서 소속만 조회하는 뷰
CREATE OR REPLACE VIEW emp10
    AS SELECT employee_id, first_name,last_name,salary
        FROM emp123
        WHERE department_id=10;

SELECT * FROM tabs;
-- 일반 테이블처럼 활용할 수 있다. 
DESC emp10;

SELECT * FROM emp10;
SELECT first_name || ' ' ||last_name, salary FROM emp10;

--SIMPLE VIEW는 제약 사항에 걸리지 않는다면 INSERT, UPDATE,DELETE를 할 수 있다. 

UPDATE emp10 SET salary =salary*2;
SELECT * FROM emp10;

ROLLBACK;

CREATE OR REPLACE VIEW emp10 
    AS SELECT employee_id, first_name, last_name, salary
        FROM emp123
        WHERE department_id =10
    WITH READ ONLY;
    
UPDATE emp10 SET salary=salary*2;

-- COMPLEXT VIEW
-- 한 개 혹은 여러 개의 테이블 혹은 뷰에 JOIN, 함수, 연산식 등을 활용한 VIEW
-- 특별한 경우가 아니면 INSERT, UPDATE, DELETE 작업 수행 불가 
CREATE OR REPLACE VIEW emp_detail 
    (employee_id, employee_name, manager_name,department_name)
AS SELECT 
        emp.employee_id,
        emp.first_name ||' ' ||emp.last_name,
        man.first_name ||' '|| man.last_name,
        department_name
    FROM HR.employees emp
        JOIN HR.employees man
            ON emp.manager_id=man.employee_id
        JOIN HR.departments dept
            ON emp.department_id=dept.department_id;

DESC emp_detail;

SELECT * FROM emp_detail;

-- VIEW를 위한 딕셔너리 : VIEWS
SELECT * FROM USER_VIEWS;

--VIEW 포함 모든 DB 객체들의 정보 
SELECT * FROM USER_OBJECTS;

----------------------
-- INDEX
----------------------
--hr.employees 테이블 복사 s_emp 테이블 생성
CREATE TABLE s_emp 
    AS SELECT * FROM HR.employees;

DESC s_emp;

-- s_emp 테이블의 employee_id에 UNIQUE INDX를 걸어봄 
CREATE UNIQUE INDEX s_emp_id_pk
ON s_emp(employee_id);

--사용자가 가지고 있는 인덱스 확인 
SELECT * FROM USER_INDEXES;
--어느 인덱스가 어느 컬럼에 걸려 있는지 확인 
SELECT * FROM USER_IND_COLUMNS;

SELECT 
    t.INDEX_NAME, c.COLUMN_NAME, c.COLUMN_POSITION
FROM USER_INDEXES t
    JOIN USER_IND_COLUMNS c
    ON t.INDEX_NAME = c.INDEX_NAME
WHERE t.TABLE_NAME='S_EMP';

SELECT * FROM author;

INSERT INTO author (author_id,author_name)
VALUES(
    (SELECT MAX(author_id)+1 FROM author),
    '이문열');

ROLLBACK;

-- 순차 객체 SEQUENCE 
CREATE SEQUENCE seq_author_id
    START WITH 4
    INCREMENT BY 1
    MAXVALUE 1000000;
    
DROP SEQ_AUTHOR_ID;

--pk는 SEQUENCE 객체로부터 생성
INSERT INTO author (author_id,author_name, author_desc)
VALUES (

SELECT * FROM author;
SELECT * FROM user_objects WHERE OBJECT_TYPE='SEQUENCE';
DELETE FROM author;
COMMIT;

SELECT * FROM author;
