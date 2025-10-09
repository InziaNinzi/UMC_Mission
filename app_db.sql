-- DROP DATABASE IF EXISTS app_db

create database app_db;
USE app_db;

CREATE TABLE 주소
(
    주소_id      INT AUTO_INCREMENT PriMARY KEY,
    우편번호       INT          NOT NULL,
    시도         VARCHAR(100) NOT NULL,
    구군         VARCHAR(100) NOT NULL,
    동리         VARCHAR(100) NOT NULL,
    도로명        VARCHAR(100) NOT NULL,
    건물번호       VARCHAR(20)  NOT NULL,
    상세정보       VARCHAR(100) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE 사용자정보 (
                       사용자_id INT AUTO_INCREMENT PRIMARY KEY ,
                       id VARCHAR(15) NOT NULL ,
                       성별 ENUM('m','f','u') NOT NULL ,
                       비밀번호 VARCHAR(255) NOT NULL ,
                       생년월일 DATE NOT NULL ,
                       탈퇴신청시간 DATETIME NOT NULL ,
                       탈퇴예정시간 DATETIME NOT NULL,
                       created_at DATETIME NOT NULL ,
                       updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE 식당정보 (
                      가게_id INT AUTO_INCREMENT PRIMARY KEY,
                      주소_id INT NOT NULL,
                      가게이름 VARCHAR(100) NOT NULL,
                      가게정보 VARCHAR(300) NOT NULL,
                      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                      updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                      CONSTRAINT fk_식당정보_주소 FOREIGN KEY (주소_id) REFERENCES 주소(주소_id)
);

CREATE TABLE 리뷰 (
                    리뷰_id INT AUTO_INCREMENT PRIMARY KEY,
                    가게_id INT NOT NULL,
                    주소_id INT NOT NULL,
                    사용자_id INT NOT NULL,
                    리뷰제목 VARCHAR(100) NOT NULL,
                    리뷰내용 VARCHAR(1000) NOT NULL,
                    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                    CONSTRAINT fk_리뷰_식당 FOREIGN KEY (가게_id) REFERENCES 식당정보(가게_id),
                    CONSTRAINT fk_리뷰_주소 FOREIGN KEY (주소_id) REFERENCES 주소(주소_id),
                    CONSTRAINT fk_리뷰_사용자 FOREIGN KEY (사용자_id) REFERENCES 사용자정보(사용자_id)
);

CREATE TABLE 사용자별주소 (
                        사용자_id INT NOT NULL,
                        주소_id INT NOT NULL,
                        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        PRIMARY KEY (사용자_id, 주소_id),
                        CONSTRAINT fk_사용자별주소_사용자 FOREIGN KEY (사용자_id) REFERENCES 사용자정보(사용자_id),
                        CONSTRAINT fk_사용자별주소_주소 FOREIGN KEY (주소_id) REFERENCES 주소(주소_id)
);

CREATE TABLE 선호음식종류 (
                        food_id INT AUTO_INCREMENT PRIMARY KEY,
                        food_name VARCHAR(50) NOT NULL,
                        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE 유저선호도 (
                       food_id INT NOT NULL,
                       사용자_id INT NOT NULL,
                       created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                       updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                       PRIMARY KEY (food_id, 사용자_id),
                       CONSTRAINT fk_유저선호도_food FOREIGN KEY (food_id) REFERENCES 선호음식종류(food_id),
                       CONSTRAINT fk_유저선호도_사용자 FOREIGN KEY (사용자_id) REFERENCES 사용자정보(사용자_id)
);

CREATE TABLE 식당_음식 (
                       가게_id INT NOT NULL,
                       food_id INT NOT NULL,
                       created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                       updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                       PRIMARY KEY (가게_id, food_id),
                       CONSTRAINT fk_식당_음식_식당 FOREIGN KEY (가게_id) REFERENCES 식당정보(가게_id),
                       CONSTRAINT fk_식당_음식_food FOREIGN KEY (food_id) REFERENCES 선호음식종류(food_id)
);

CREATE TABLE 미션 (
                    미션_id INT AUTO_INCREMENT PRIMARY KEY,
                    미션이름 VARCHAR(50) NOT NULL,
                    미션내용 TEXT NOT NULL,
                    미션기간 DATETIME NOT NULL,
                    Field5 VARCHAR(255) NULL
);

CREATE TABLE 사용자별미션 (
                        미션_id INT NOT NULL,
                        사용자_id INT NOT NULL,
                        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        PRIMARY KEY (미션_id, 사용자_id),
                        CONSTRAINT fk_사용자별미션_미션 FOREIGN KEY (미션_id) REFERENCES 미션(미션_id),
                        CONSTRAINT fk_사용자별미션_사용자 FOREIGN KEY (사용자_id) REFERENCES 사용자정보(사용자_id)
);