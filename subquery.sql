/*
User 테이블 정보 : UserId, JoinedDate, Name
StoreA 테이블 정보 : PurchaseId, UserId, ProductId
StoreB 테이블 정보 : PurchaseId, UserId, ProductId
ProductInformation 테이블 정보 : category, ProducId, ProductName, Price
*/


# Q1
# ProductInformation 테이블에서 category 를 기준으로 각 그룹별 Price의 최대값을 구한 뒤
# 최대값이 3000 이상인 값들만 구하세요.

SELECT category, max_price
FROM (SELECT category, max(price) as max_price
		FROM Productinformation
        GROUP BY category
		) AS A
WHERE max_price >= 3000;
# FROM 에서 사용할 경우에는 위의 예제처럼 AS 를 사용하여 A, 즉 테이블 명을 지정해줘야 한다.
# 다시 정리를 하면 위의 결과를 A 테이블이라고 정의하는 것\.
# 이 때, MAX(Price) AS MAX_PRICE 라고 하지 않고 쿼리를 짜게 될 경우 쿼리가 실행되지 않는다.
# 서브쿼리에서의 결과 중 PRICE 라는 필드명이 존재하지 않기 때문!
# 따라서 집계 함수 결과를 서브쿼리 내에서 사용할 경우에는 AS 를 사용하여 다른 필드명으로 바꾸어 준 뒤 사용하도록 한다다. 


# Q2
# User 테이블에서 StoreA 를 이용한 기록이 없는 회원들의 UserId를 구하세요.

SELECT UserId
FROM User
WHERE UserId NOT IN (
		SELECT UserId
		FROM StoreA );
# StoreA 를 이용한 기록이 없는 회원의 UserId 를 구하기 위해서는
# User 테이블에서 StoreA 를 이용한 회원의 UserId 를 제외하면 된다.
# WHERE 뒤에 서브쿼리를 쓸 경우 AS를 쓰면 안 된다!


# Q3
# User 테이블은 회원의 정보를 담은 테이블이며,
# StoreA, StoreB 테이블은 각 상점에서 발생한 구매에 대한 구매번호(PurchaseId)와 구매회원의 아이디(UserId), 구매 상품의 아이디(ProductId)가 저장되어 있는 테이블입니다.
#이 테이블들을 이어 User 테이블의 UserId 기준으로 UserId, UserId 별 StoreA, StoreB에서의 구매횟수를 구하세요.
# 만약, 해당 UserId의 구매횟수가 0일 경우 0으로 나타내세요. (UserId 기준 오름차순 정렬하세요.)

SELECT U.UserId,
		IFNULL(SA.CNT, 0) AS A,
        IFNULL(SB.CNT, 0) AS B
FROM User AS U

LEFT JOIN (
	SELECT UserId, count(UserId) AS CNT
	FROM StoreA
	GROUP BY UserId
	) AS SA
ON SA.UserId = U.UserId

LEFT JOIN (
	SELECT UserId, count(UserId) AS CNT
	FROM StoreB
	GROUP BY UserId
	) AS SB
ON SB.UserId = U.UserId
ORDER BY U.UserId ASC;


# Q4
# User 테이블은 회원의 정보를 담은 테이블이며,
# StoreA, StoreB 테이블은 각 상점에서 발생한 구매에 대한 구매번호(PurchaseId)와 구매회원의 아이디(UserId), 구매 상품의 아이디(ProductId)가 저장되어 있는 테이블입니다.
# ProductInformation 테이블은 StoreA 와 StoreB 에서 판매되는 물품의 정보를 담고 있습니다.
# 이 테이블들을 이어 User 테이블의 UserId 기준으로 UserId, UserId 별 StoreA, StoreB에서의 구매횟수와 구매금액을 구하세요.
# 만약, 해당 UserId의 구매횟수가 0일 경우 0으로 나타내세요. (UserId 기준 오름차순 정렬하세요.)

SELECT U.UserId,
		IFNULL(SA.CNT, 0) AS A_CNT,
		IFNULL(SA.TOTAL_PRICE, 0) AS A_PRICE,
		IFNULL(SB.CNT, 0) AS B_CNT,
		IFNULL(SB.TOTAL_PRICE, 0) AS B_PRICE
FROM User AS U

LEFT JOIN (
	SELECT 
	A.UserId, COUNT(A.UserId) AS CNT,  SUM(P.Price) AS TOTAL_PRICE
    FROM StoreA AS A

    # 물품정보
    INNER JOIN ProductInformation AS P
    ON P.ProductId = A.ProductId AND P.category = 'StoreA'

    GROUP BY A.UserId
	) AS SA
ON SA.UserId = U.UserId

LEFT JOIN (
	SELECT 
	B.UserId, COUNT(B.UserId) AS CNT,  SUM(P.Price) AS TOTAL_PRICE
    FROM StoreB AS B

    # 물품정보
    INNER JOIN ProductInformation AS P
    ON P.ProductId = B.ProductId AND P.category = 'StoreB'

    GROUP BY B.UserId
) AS SB
ON SB.UserId = U.UserId

ORDER BY U.UserId ASC;



