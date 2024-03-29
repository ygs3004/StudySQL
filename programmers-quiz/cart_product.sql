CART_PRODUCTS 테이블은 장바구니에 담긴 상품 정보를 담은 테이블입니다. CART_PRODUCTS 테이블의 구조는 다음과 같으며,
ID, CART_ID, NAME, PRICE는 각각 테이블의 아이디, 장바구니의 아이디, 상품 종류, 가격을 나타냅니다.

NAME  TYPE
ID  INT
CART_ID INT
NAME  VARCHAR
PRICE INT

CREATE TABLE IF NOT EXISTS CART_PRODUCTS (
  ID INT,
  CART_ID INT,
  NAME VARCHAR(30),
  PRICE INT
);

INSERT INTO CART_PRODUCTS (ID, CART_ID, NAME, PRICE) VALUES (1630, 83, 'Cereal', 3980);
INSERT INTO CART_PRODUCTS (ID, CART_ID, NAME, PRICE) VALUES (1631, 83, 'Multipurpose Supply', 3900);
INSERT INTO CART_PRODUCTS (ID, CART_ID, NAME, PRICE) VALUES (5491, 286, 'Yogurt', 2980);
INSERT INTO CART_PRODUCTS (ID, CART_ID, NAME, PRICE) VALUES (5504, 286, 'Milk', 1880);
INSERT INTO CART_PRODUCTS (ID, CART_ID, NAME, PRICE) VALUES (8435, 448, 'Milk', 1880);
INSERT INTO CART_PRODUCTS (ID, CART_ID, NAME, PRICE) VALUES (8437, 448, 'Yogurt', 2980);
INSERT INTO CART_PRODUCTS (ID, CART_ID, NAME, PRICE) VALUES (8438, 448, 'Tea', 11000);
INSERT INTO CART_PRODUCTS (ID, CART_ID, NAME, PRICE) VALUES (20236, 1034, 'Yogurt', 2980);
INSERT INTO CART_PRODUCTS (ID, CART_ID, NAME, PRICE) VALUES (20237, 1034, 'Butter', 4890);

-- 테이블 확인
SELECT * FROM CART_PRODUCTS;

-- 데이터 비우기
TRUNCATE CART_PRODUCTS;

-- 데이터 분석 팀에서는 우유(Milk)와 요거트(Yogurt)를 동시에 구입한 장바구니가 있는지 알아보려 합니다. 
-- 우유와 요거트를 동시에 구입한 장바구니의 아이디를 조회하는 SQL 문을 작성해주세요. 이때 결과는 장바구니의 아이디 순으로 나와야 합니다.

SELECT A.CART_ID
  FROM (SELECT CART_ID
          FROM CART_PRODUCTS
         WHERE NAME = 'Milk') A
  JOIN (SELECT CART_ID
          FROM CART_PRODUCTS
         WHERE NAME = 'Yogurt') B
    ON A.CART_ID = B.CART_ID
 WHERE A.CART_ID;
