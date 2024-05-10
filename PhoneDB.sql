-- Step 1: Create a table
DROP TABLE PHONEDB;
DELETE FROM phoneDB;

CREATE TABLE phoneDB (
--    list_info VARCHAR2(20),
    name VARCHAR2(50),
    mobile_number VARCHAR2(20),
    landline_number VARCHAR2(20)
);

-- Step 2: Insert data into the table
--INSERT INTO phoneDB (list_info,name, mobile_number, landline_number) VALUES (1,'고길동', '010-8788-8881', '032-8890-2974');
--INSERT INTO phoneDB (list_info,name, mobile_number, landline_number) VALUES (2,'둘리', '010-1212-3434', '02-5678-8765');
--INSERT INTO phoneDB (list_info,name, mobile_number, landline_number) VALUES (3,'마이콜', '010-7102-6327', '02-9192-5069');
--INSERT INTO phoneDB (list_info,name, mobile_number, landline_number) VALUES (4,'또치', '010-6514-5113', '02-7976-9368');
--INSERT INTO phoneDB (list_info,name, mobile_number, landline_number) VALUES (5,'홍길동', '010-7777-7777', '02-3333-3333');

INSERT INTO phoneDB (name, mobile_number, landline_number) VALUES ('고길동', '010-8788-8881', '032-8890-2974');
INSERT INTO phoneDB (name, mobile_number, landline_number) VALUES ('둘리', '010-1212-3434', '02-5678-8765');
INSERT INTO phoneDB (name, mobile_number, landline_number) VALUES ('마이콜', '010-7102-6327', '02-9192-5069');
INSERT INTO phoneDB (name, mobile_number, landline_number) VALUES ('또치', '010-6514-5113', '02-7976-9368');
INSERT INTO phoneDB (name, mobile_number, landline_number) VALUES ('홍길동', '010-7777-7777', '02-3333-3333');

ALTER TABLE phoneDB
ADD CONSTRAINT pk_name PRIMARY KEY (name);
--ADD CONSTRAINT pk_list_info PRIMARY KEY (list_info);
ROLLBACK;
SELECT * FROM phoneDB;