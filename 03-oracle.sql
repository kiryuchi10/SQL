--connect system/manage

CREATE USER himedia IDENTIFIED BY himedia;
--oracle 18버전부터 container database 개념도입

CREATE USER C##HIMEDIA IDENTIFIED BY himedia;

ALTER USER C##HIMEDIA IDENTIFIED BY new_password;

DROP USER C##HIMEDIA CASCADE;

ALTER SESSION SET "_ORACLE_SCRIPT"=true;
CREATE USER himedia IDENTIFIED BY himedia;

GRANT CONNECT, RESOURCE TO himedia;

DESCRIBE test;
INSERT INTO test VALUES (2024);
--USERS 테이블스페이스에 대한 권한이 없다
--18이상 
ALTER USER himedia DEFAULT TABLESPACE USES
    QUOTA unlimited on USERS;

INSERT INTO test VALUES(2024);
SELECT * FROM test;

SELECT * FROM USER_USERS;
SELECT * FROM ALL_USERS;

SELECT * FROM DBA_USERS;

--시나리오 : HR 스키마의 employees 테이블 조회 권한을 himeida에게 부여하고자 한다. 