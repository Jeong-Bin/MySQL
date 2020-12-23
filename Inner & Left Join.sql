# Inner Join ----------------------------------------------------------------------

# User 테이블은 회원의 정보를 담은 테이블이며,
# StoreA 테이블은 A상점에서 발생한 구매에 대한 구매번호(PurchaseId)와 구매회원의 아이디(UserId), 구매 상품의 아이디(ProductId)가 저장되어 있는 테이블입니다.
# 이 두 테이블을 이어 구매번호, 구매회원의 아이디, 구매 상품의 아이디, 구매 회원의 이름을 나타내세요.
SELECT storea.purchaseid, storea.userid, storea.ProductId, user.name
FROM user
INNER JOIN storea
ON user.userID = storea.userID;

# storeB
SELECT SB.purchaseid, SB.userid, SB.ProductId, U.name
FROM user as U
INNER JOIN storeb as SB
ON U.userID = SB.userID;

# storeA 에서
# UserId 가 100 이상인 회원들의 구매번호, 구매회원의 아이디, 구매 상품의 아이디, 구매 회원의 이름을 나타내세요.
SELECT SA.purchaseid, SA.userid, SA.ProductId, U.name
FROM user AS U
INNER JOIN storea AS SA
ON U.userID = SA.userID
WHERE SA.UserId >= 100
order by SA.UserId asc;

# 위와 같은 조건에서 WHERE SA~ 가 아닌 ON U~ 를 사용함
SELECT SA.purchaseid, SA.userid, SA.ProductId, U.name
FROM user AS U
INNER JOIN storea AS SA
ON U.userID = SA.userID
	AND U.UserId >= 100
order by SA.UserId asc;


# Left Join ----------------------------------------------------------------------

# User 테이블은 회원의 정보를 담은 테이블이며,
# StoreA 테이블은 A상점에서 발생한 구매에 대한 구매번호(PurchaseId)와 구매회원의 아이디(UserId), 구매 상품의 아이디(ProductId)가 저장되어 있는 테이블입니다.\
# 이 두 테이블을 이어 구매번호, 구매회원의 아이디, 구매 상품의 아이디, 구매 회원의 이름을 나타내세요.
SELECT SA.purchaseid, SA.userid, SA.ProductId, U.name
from user AS U
LEFT JOIN StoreA as SA
ON U.userid = sa.userid;
# INNER JOIN의 1번 문제와 동일한 문제 이지만 NULL 값이 나타남.
# Left Join 을 사용하면 User에는 있지만 StoreA에서의 정보가 없는 인원들의 값은 NULL로 표시된다.
# 즉, storeA가 기준이 된다!

# storeB
SELECT SB.purchaseid, SB.userid, SB.ProductId, U.name
from StoreB as SB
LEFT JOIN user AS U
ON U.userid = sB.userid;

# UserID 테이블과 storeA 테이블을 이어 User 테이블의 UserId 기준으로 UserId, UserId 별 구매횟수를 구하세요.
# 만약, 해당 UserId의 구매횟수가 0일 경우 0으로 나타내세요. (UserId 기준 오름차순 정렬하세요.)
SELECT U.userid, ifnull(COUNT(SA.ProductId), 0) AS "구매횟수"
from user AS U
LEFT JOIN StoreA as SA
ON U.userid = sa.userid
GROUP BY U.userid
ORDER BY U.userid ASC;
