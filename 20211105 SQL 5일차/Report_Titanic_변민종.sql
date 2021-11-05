use mydata;
show tables;

select * from dataset4;


-- 총 승객 수 : 총 714명의 승객이 탑승
SELECT 
    COUNT(passengerid) N_Passengers,
    COUNT(DISTINCT passengerid) N_D_Passengers
FROM
    dataset4;

CREATE VIEW N_Passengers AS
    SELECT 
        COUNT(passengerid) N_Passengers,
        COUNT(DISTINCT passengerid) N_D_Passengers
    FROM
        dataset4;

    
-- 성별 분석
/*
남녀 성별에 따른 탑승인원, 생존인원, 생존율을 비교
남성이 20.53%의 생존율, 여성은 75.48% 의 생존율을 보여준다. 
*/
SELECT 
    Sex,
    COUNT(passengerid) N_Passengers,
    SUM(survived) N_Survived,
    format(sum(survived)/COUNT(Passengerid)*100,2) Survived_Rate
FROM
    dataset4
GROUP BY 1;    


-- 연령대별 분석
/*
연령대별로 탑승인원, 생존인원, 생존율을 비교
어린이(0-9세)의 생존율이 가장 높음을 보여준다.
*/
SELECT 
    CONCAT(TRUNCATE(age, - 1),
            ' - ',
            TRUNCATE(age, - 1) + 9) AgeBand,
    COUNT(Passengerid) N_Passengers, sum(survived) N_Survived, format(sum(survived)/COUNT(Passengerid)*100,2) Survived_Rate
FROM
    dataset4
GROUP BY 1
ORDER BY 1;


-- 성별 + 연령대
/*
성별과 연령대로 비교
여성의 경우 전체적으로 60% 이상의 생존율 보여주며 남성보다 압도적으로 높다.
*/
SELECT 
    CONCAT(TRUNCATE(age, - 1),
            ' - ',
            TRUNCATE(age, - 1) + 9) AgeBand,
    Sex,
    COUNT(Passengerid) N_Passengers,
    SUM(survived) N_Survived,
    FORMAT(SUM(survived) / COUNT(Passengerid) * 100,
        2) Survived_Rate
FROM
    dataset4
GROUP BY 1 , 2
ORDER BY 2 , 1;


-- 남성, 연령대
SELECT 
    CONCAT(TRUNCATE(age, - 1),
            ' - ',
            TRUNCATE(age, - 1) + 9) AgeBand,
    Sex,
    COUNT(Passengerid) N_Passengers,
    SUM(survived) N_Survived,
    FORMAT(SUM(survived) / COUNT(Passengerid) * 100,
        2) Survived_Rate
FROM
    dataset4
GROUP BY 1 , 2
HAVING sex = 'male'
ORDER BY 1;

CREATE VIEW Age_Survived_Rate_Male AS
    SELECT 
        CONCAT(TRUNCATE(age, - 1),
                ' - ',
                TRUNCATE(age, - 1) + 9) AgeBand,
        Sex,
        COUNT(Passengerid) N_Passengers,
        SUM(survived) N_Survived,
        FORMAT(SUM(survived) / COUNT(Passengerid) * 100,
            2) Survived_Rate
    FROM
        dataset4
    GROUP BY 1 , 2
    HAVING sex = 'male'
    ORDER BY 1;


-- 여성, 연령대
SELECT 
    CONCAT(TRUNCATE(age, - 1),
            ' - ',
            TRUNCATE(age, - 1) + 9) AgeBand,
    Sex,
    COUNT(Passengerid) N_Passengers,
    SUM(survived) N_Survived,
    FORMAT(SUM(survived) / COUNT(Passengerid) * 100,
        2) Survived_Rate
FROM
    dataset4
GROUP BY 1 , 2
HAVING sex = 'female'
ORDER BY 1;

CREATE VIEW Age_Survived_Rate_Female AS
    SELECT 
        CONCAT(TRUNCATE(age, - 1),
                ' - ',
                TRUNCATE(age, - 1) + 9) AgeBand,
        Sex,
        COUNT(Passengerid) N_Passengers,
        SUM(survived) N_Survived,
        FORMAT(SUM(survived) / COUNT(Passengerid) * 100,
            2) Survived_Rate
    FROM
        dataset4
    GROUP BY 1 , 2
    HAVING sex = 'female'
    ORDER BY 1;

select * from Age_Survived_Rate_Female;


-- 같은 연령대 기준 성별에 따른 생존율 차이
/*
남성과 여성의 연령대별 생존율 차이 비교
남녀 생존율 차이가 한눈에 들어온다.
성별, 연령대 분석으로 봤을 때, '여성, 어린이' 먼저 탈출하도록 하였음을 알수있다.
*/
SELECT 
    m.Ageband,
    m.Survived_rate Male_Survived_Rate,
    f.Survived_rate Female_Survived_Rate,
    FORMAT(f.Survived_rate - m.Survived_rate,
        2) Survived_Rate_DIFF
FROM
    Age_Survived_Rate_Male m
        LEFT JOIN
    Age_Survived_Rate_Female f ON m.ageband = f.ageband;


-- 객실등급 별 생존율
/*
객실등급별로 탑승객의 생존율을 비교
객실 등급이 높을수록 생존율이 높은 것을 알 수있다.
타이타닉 호의 구조도를 봤을 때 높은 객실등급일 수록 갑판과 가까이 있어 탈출이 용이했을 것이다.
*/
SELECT 
    Pclass,
    COUNT(passengerid) N_Passengers,
    SUM(Survived) N_Survived,
    FORMAT(SUM(survived) / COUNT(Passengerid) * 100,
        2) Survived_Rate
FROM
    dataset4
GROUP BY 1
ORDER BY 1;


-- 객실등급 + 성별 + 연령
SELECT 
    Pclass,
    Sex,
    CONCAT(TRUNCATE(age, - 1),
            ' - ',
            TRUNCATE(age, - 1) + 9) AgeBand,
    COUNT(Passengerid) N_Passengers,
    SUM(survived) N_Survived,
    FORMAT(SUM(survived) / COUNT(Passengerid) * 100,
        2) Survived_Rate
FROM
    dataset4
GROUP BY 1 , 2, 3
ORDER BY 2 , 1;


-- 생존율이 가장 높은 Case
/*
여성의 생존율이 전체적으로 높지만 
3등급 여성 탑승객의 경우 생존율은 1,2등급 여성 탑승객과 큰 차이를 보인다.
*/
SELECT 
    Pclass,
    Sex,
    CONCAT(TRUNCATE(age, - 1),
            ' - ',
            TRUNCATE(age, - 1) + 9) AgeBand,
    COUNT(Passengerid) N_Passengers,
    SUM(survived) N_Survived,
    FORMAT(SUM(survived) / COUNT(Passengerid) * 100,
        2) Survived_Rate
FROM
    dataset4
GROUP BY 1 , 2 , 3
ORDER BY FLOOR(Survived_Rate) DESC , 1 , 2 , 3;

-- 등급별 연령별 여성의 생존율
SELECT 
    Pclass,
    Sex,
    CONCAT(TRUNCATE(age, - 1),
            ' - ',
            TRUNCATE(age, - 1) + 9) AgeBand,
    COUNT(Passengerid) N_Passengers,
    SUM(survived) N_Survived,
    FORMAT(SUM(survived) / COUNT(Passengerid) * 100,
        2) Survived_Rate
FROM
    dataset4
GROUP BY 1 , 2 , 3
HAVING sex = 'female'
ORDER BY FLOOR(Survived_Rate) DESC , 1 , 2 , 3;

CREATE VIEW Survived_Rate_Pclass_Female AS
    SELECT 
        Pclass,
        Sex,
        CONCAT(TRUNCATE(age, - 1),
                ' - ',
                TRUNCATE(age, - 1) + 9) AgeBand,
        COUNT(Passengerid) N_Passengers,
        SUM(survived) N_Survived,
        FORMAT(SUM(survived) / COUNT(Passengerid) * 100,
            2) Survived_Rate
    FROM
        dataset4
    GROUP BY 1 , 2 , 3
    HAVING sex = 'female'
    ORDER BY FLOOR(Survived_Rate) DESC , 1 , 2 , 3;

-- 등급별 여성 생존율 평균 
SELECT 
    Pclass, Sex, FORMAT(AVG(Survived_rate), 2) Avg_Survived_Rate
FROM
    Survived_Rate_Pclass_Female
GROUP BY pclass
ORDER BY pclass;


-- 승선 항구별 승객 수
SELECT 
    Embarked, COUNT(Passengerid) N_Passengers
FROM
    dataset4
GROUP BY 1
ORDER BY 1;


-- 승선 항구별 성별 승객 수
SELECT 
    Embarked, Sex, COUNT(Passengerid) N_Passengers
FROM
    dataset4
GROUP BY 1, 2
ORDER BY 1, 2;

CREATE VIEW N_Passenger_Sex_Embarked AS
    SELECT 
        Embarked, Sex, COUNT(Passengerid) N_Passengers
    FROM
        dataset4
    GROUP BY 1 , 2
    ORDER BY 1 , 2;


-- 승선 항구별, 성별 승객 비중(%)
-- a) 승선 항구별 전체 승객 수
SELECT 
    Embarked, COUNT(Passengerid) N_Passengers
FROM
    dataset4
GROUP BY 1;

CREATE VIEW N_Passengers_Total AS
    SELECT 
        Embarked, COUNT(Passengerid) N_Passengers
    FROM
        dataset4
    GROUP BY 1;
    
-- b) 테이블 결합
SELECT 
    a.Embarked,
    a.Sex,
    a.N_Passengers,
    b.N_passengers N_Passengers_TOT,
    a.n_Passengers / b.n_passengers passengers_Rate_Embarked
FROM
    N_Passenger_Sex_Embarked a
        LEFT JOIN
    N_Passengers_Total b ON a.embarked = b.embarked;


-- 출발지와 목적지별 승객 수
select Embarked, Boarded, Destination from dataset4;

SELECT 
    Boarded, Destination, COUNT(passengerid) N_Passengers
FROM
    dataset4
GROUP BY boarded , destination
ORDER BY 3 DESC;



select * from dataset4;