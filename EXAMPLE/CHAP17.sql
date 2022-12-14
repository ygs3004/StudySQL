SET SERVEROUTPUT ON;
-- 17-1 RECORD 정의해서 사용
DECLARE
    TYPE REC_DEPT IS RECORD(
        DEPTNO NUMBER(2) NOT NULL := 99,
        DNAME DEPT.DNAME%TYPE,
        LOC DEPT.LOC%TYPE
    );
    DEPT_REC REC_DEPT;
BEGIN
    DEPT_REC.DEPTNO := 99;
    DEPT_REC.DNAME := 'DATABASE';
    DEPT_REC.LOC := 'SEOUL';
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || DEPT_REC.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || DEPT_REC.DNAME);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || DEPT_REC.LOC);
END;
/

-- 17-2 실습용 테이블
CREATE TABLE DEPT_RECORD
AS SELECT*FROM DEPT;

SELECT*FROM DEPT_RECORD;

-- 17-3 레코드 사용 INSERT
DECLARE
    TYPE REC_DEPT IS RECORD(
        DEPTNO NUMBER(2) NOT NULL :=99,
        DNAME DEPT.DNAME%TYPE,
        LOC DEPT.LOC%TYPE
    );
    DEPT_REC REC_DEPT;    
BEGIN
    DEPT_REC.DEPTNO :=99;
    DEPT_REC.DNAME :='DATABASE';
    DEPT_REC.LOC:='SEOUL';
    
    INSERT INTO DEPT_RECORD
    VALUES DEPT_REC;
END;
/

SELECT*FROM DEPT_RECORD;

-- 17-4 레코드 사용 UPDATE
DECLARE
    TYPE REC_DEPT IS RECORD(
        DEPTNO NUMBER(2) NOT NULL := 99,
        DNAME DEPT.DNAME%TYPE,
        LOC DEPT.LOC%TYPE
    );
    DEPT_REC REC_DEPT;
BEGIN
    DEPT_REC.DEPTNO := 50;
    DEPT_REC.DNAME := 'DB';
    DEPT_REC.LOC := 'SEOUL';
    
    UPDATE DEPT_RECORD
        SET ROW = DEPT_REC
        WHERE DEPTNO =99;
END;
/

SELECT*FROM DEPT_RECORD;

-- 17-5 레코드에 다른 레코드 포함
DECLARE
    TYPE REC_DEPT IS RECORD(
        DEPTNO DEPT.DEPTNO%TYPE,
        DNAME DEPT.DNAME%TYPE,
        LOC DEPT.LOC%TYPE
    );
    
    TYPE REC_EMP IS RECORD(
        EMPNO EMP.EMPNO%TYPE,
        ENAME EMP.ENAME%TYPE,
        DINFO REC_DEPT
    );
    EMP_REC REC_EMP;
BEGIN
    SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
        INTO EMP_REC.EMPNO, EMP_REC.ENAME, 
            EMP_REC.DINFO.DEPTNO,
            EMP_REC.DINFO.DNAME,
            EMP_REC.DINFO.LOC
     FROM EMP E, DEPT D
     WHERE E.DEPTNO=D.DEPTNO AND E.EMPNO=7788;
    DBMS_OUTPUT.PUT_LINE('EMPNO : ' || EMP_REC.EMPNO);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || EMP_REC.ENAME);

     DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || EMP_REC.DINFO.DEPTNO);
     DBMS_OUTPUT.PUT_LINE('DNAME : ' || EMP_REC.DINFO.DNAME);
     DBMS_OUTPUT.PUT_LINE('LOC : ' || EMP_REC.DINFO.LOC);     
END;
/

-- 17-6 연관배열 사용 (KEY. VALUE 구성)
DECLARE
    TYPE ITAB_EX IS TABLE OF VARCHAR2(20)
    INDEX BY PLS_INTEGER;
    
    TEXT_ARR ITAB_EX;
    
BEGIN
    TEXT_ARR(1) := '1ST DATA';
    TEXT_ARR(2) := '2ST DATA';
    TEXT_ARR(3) := '3ST DATA';
    TEXT_ARR(4) := '4ST DATA';
    
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR(1) : ' || TEXT_ARR(1));
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR(2) : ' || TEXT_ARR(2));
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR(3) : ' || TEXT_ARR(3));
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR(4) : ' || TEXT_ARR(4));
END;
/

-- 17-7 연관배열 자료형에 레코드 사용
DECLARE
    TYPE REC_DEPT IS RECORD(
    DEPTNO DEPT.DEPTNO%TYPE,
    DNAME DEPT.DNAME%TYPE
    );
    
    TYPE ITAB_DEPT IS TABLE OF REC_DEPT
    INDEX BY PLS_INTEGER;
    
    DEPT_ARR ITAB_DEPT;
    IDX PLS_INTEGER :=0;
    
BEGIN
    FOR i IN (SELECT DEPTNO, DNAME FROM DEPT) LOOP
        IDX := IDX+1;
        DEPT_ARR(IDX).DEPTNO := i.DEPTNO;
        DEPT_ARR(IDX).DNAME := i.DNAME;
        
        DBMS_OUTPUT.PUT_LINE(DEPT_ARR(IDX).DEPTNO || ':' || DEPT_ARR(IDX).DNAME);
    END LOOP;
END;
/


-- 17-8 %ROWTYPE 연관 배열 자료형 지정
DECLARE
    TYPE ITAB_DEPT IS TABLE OF DEPT%ROWTYPE
        INDEX BY PLS_INTEGER;

    DEPT_ARR ITAB_DEPT;
    IDX PLS_INTEGER := 0;
    
BEGIN 
    FOR i IN(SELECT * FROM DEPT) LOOP
        IDX := IDX+1;
        DEPT_ARR(IDX).DEPTNO := I.DEPTNO;
        DEPT_ARR(IDX).DNAME := I.DNAME;
        DEPT_ARR(IDX).LOC := I.LOC;
        
        DBMS_OUTPUT.PUT_LINE(
            DEPT_ARR(IDX).DEPTNO || ':' ||
            DEPT_ARR(IDX).DNAME || ':' ||
            DEPT_ARR(IDX).LOC);
    END LOOP;
END;
/

SET SERVEROUTPUT ON;

-- 17-9 컬렉션 메소드
DECLARE
    TYPE ITAB_EX IS TABLE OF VARCHAR2(20)
    INDEX BY PLS_INTEGER;
    
    TEXT_ARR ITAB_EX;
    
BEGIN
    TEXT_ARR(1) := '1ST DATA';
    TEXT_ARR(2) := '2ND DATA';
    TEXT_ARR(3) := '3RD DATA';
    TEXT_ARR(50) := '50TH DATA';
    
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR.COUNT : ' || TEXT_ARR.COUNT);
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR.FIRST : ' || TEXT_ARR.FIRST);
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR.LAST : ' || TEXT_ARR.LAST);
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR.PRIOR(50) : ' || TEXT_ARR.PRIOR(50));
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR.NEXT(50) : ' || TEXT_ARR.NEXT(50));
END;
/