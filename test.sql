CREATE DATABASE sql_study default CHARACTER SET UTF8;
SELECT 1;
select 1 + 2;
select 'abc';
select NOW() AS "현재시각";

# FROM 으로 테이블을 불러올 때는 앞에 데이터베이스명. 을 붙이던가,
# 왼쪽 메뉴에서 데이터베이스명을 더블클릭해 굵은 글씨로 만들어줘야 한다.
SELECT * FROM sql_study.user;
select UserID, ProductId from storea;
select max(price), min(Price), sum(Price), avg(Price) from productinformation;

