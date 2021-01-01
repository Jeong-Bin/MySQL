# UNION 과 UNION ALL은 생성된 두 개 이상의 쿼리의 결과를 이어줄 때 사용한다다.
# UNION (DISTINCT)을 이용하여 쿼리의 결과를 이어줄 때는 테이블 간의 중복된 결과를 지우고
# UNION ALL을 이용하면 테이블 간의 중복 유무에 상관없이 데이터를 출력한다.

# UNION / UNION ALL 을 사용할 때는 필드 개수와 필드 순서를 동일하게 만들어야 한다.

# Q1
# StoreA 에 존재하는 UserId 와 StoreB 를 존재하는 UserId 를 출력하세요.
SELECT DISTINCT UserId  # 여기서 사용한 DISTINCT는 UserId 간의 중복을 지우기 위함
FROM StoreA
UNION
SELECT DISTINCT UserId
FROM StoreB
order by UserId;


# Q2
# UNION ALL을 이용
SELECT DISTINCT UserId
FROM StoreA
UNION All
SELECT DISTINCT UserId
FROM StoreB
order by UserId;