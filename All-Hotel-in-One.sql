
----ALTER user username identified by newpass replace oldpass----


----------------lab1-----------------
DROP TABLE rooms;
DROP TABLE hotel_ratings;
DROP TABLE booking_payment;
DROP TABLE hotels;
DROP TABLE customers;
CREATE TABLE hotels
(
    hotel_id integer,
    hotel_name varchar2(20) NOT NULL,
    hotel_type varchar2(10),
    no_of_rooms integer NOT NULL,
    rating number(2,1)
);
ALTER TABLE hotels ADD CONSTRAINT pk_hotels PRIMARY KEY (hotel_id);


CREATE TABLE customers
(
    cust_id integer PRIMARY KEY,
    cust_name varchar2(20) NOT NULL,
    date_of_birth date NOT NULL,
    cust_type varchar2(10),
    cust_age number(3,0)
);




CREATE TABLE booking_payment
(
    booking_id integer NOT NULL,
    booking_date date NOT NULL,
    amount integer NOT NULL,
    hotel_id integer NOT NULL,
    custumer_id integer NOT NULL,
    PRIMARY KEY (booking_id, booking_date),
    FOREIGN KEY (hotel_id) REFERENCES hotels ON DELETE CASCADE
);
ALTER TABLE booking_payment ADD CONSTRAINT fk_hotel_to_bp FOREIGN KEY (custumer_id) REFERENCES customers(cust_id);
ALTER TABLE booking_payment RENAME COLUMN custumer_id to cust_id;

CREATE TABLE hotel_ratings
(
    cust_id integer NOT NULL,
    hotel_id integer NOT NULL,
    rating number(2,1),
    PRIMARY KEY (hotel_id,cust_id),
    FOREIGN KEY (hotel_id) REFERENCES hotels ON DELETE CASCADE,
    FOREIGN KEY (cust_id) REFERENCES customers
);


CREATE TABLE rooms
(
    hotel_id integer NOT NULL,
    room_no integer NOT NULL,
    room_type varchar2(10) NOT NULL,
    booking_id integer,
    booking_date date,
    PRIMARY KEY (hotel_id, room_no),
    FOREIGN KEY (hotel_id) REFERENCES hotels ON DELETE CASCADE,
    FOREIGN KEY (booking_id,booking_date) REFERENCES booking_payment
);
DESC hotels;
DESC customers;
DESC booking_payment;
DESC hotel_ratings;
DESC rooms;





INSERT INTO hotels(hotel_id, hotel_name, hotel_type, no_of_rooms, rating) values(12011,'Hotel Royal Tulip','5*',84,2.0);
INSERT INTO hotels(hotel_id, hotel_name, hotel_type, no_of_rooms, rating) values(12012,'Hotel Cox Today','3*',84,4.0);
INSERT INTO hotels(hotel_id, hotel_name, hotel_type, no_of_rooms, rating) values(12013,'Hotel Seagul','3*',84,5.0);
INSERT INTO hotels(hotel_id, hotel_name, hotel_type, no_of_rooms, rating) values(12014,'Hotel Dominos','3*',84,4.0);
INSERT INTO hotels(hotel_id, hotel_name, hotel_type, no_of_rooms, rating) values(12015,'Hotel Queen','5*',84,3.0);
INSERT INTO hotels(hotel_id, hotel_name, hotel_type, no_of_rooms, rating) values(12016,'Hotel A','5*',84,2.0);
INSERT INTO hotels(hotel_id, hotel_name, hotel_type, no_of_rooms, rating) values(12017,'Hotel B','3*',84,1.0);
INSERT INTO hotels(hotel_id, hotel_name, hotel_type, no_of_rooms, rating) values(12018,'Hotel C','3*',84,3.0);
INSERT INTO hotels(hotel_id, hotel_name, hotel_type, no_of_rooms, rating) values(12019,'Hotel D','3*',84,5.0);
INSERT INTO hotels(hotel_id, hotel_name, hotel_type, no_of_rooms, rating) values(12020,'Hotel E','5*',84,5.0);

INSERT INTO customers(cust_id, cust_name, date_of_birth, cust_type, cust_age) values(22011,'Farhan Pollok',TO_DATE('30/05/1998', 'DD/MM/YYYY'),'VIP',23);
INSERT INTO customers(cust_id, cust_name, date_of_birth, cust_type, cust_age) values(22012,'Jamilul Huq',TO_DATE('17/12/1999', 'DD/MM/YYYY'),'CIP',22);
INSERT INTO customers(cust_id, cust_name, date_of_birth, cust_type, cust_age) values(22013,'Abir Hasan',TO_DATE('12/12/1997', 'DD/MM/YYYY'),'Normal',24);
INSERT INTO customers(cust_id, cust_name, date_of_birth, cust_type, cust_age) values(22014,'Faias Promit',TO_DATE('14/11/1996', 'DD/MM/YYYY'),'VIP',25);
INSERT INTO customers(cust_id, cust_name, date_of_birth, cust_type, cust_age) values(22015,'Tamim Hossain',TO_DATE('11/06/2000', 'DD/MM/YYYY'),'Normal',21);
INSERT INTO customers(cust_id, cust_name, date_of_birth, cust_type, cust_age) values(22016,'Kowshik',TO_DATE('30/05/1998', 'DD/MM/YYYY'),'VIP',23);
INSERT INTO customers(cust_id, cust_name, date_of_birth, cust_type, cust_age) values(22017,'Faias Promit',TO_DATE('17/12/1999', 'DD/MM/YYYY'),'Normal',22);
INSERT INTO customers(cust_id, cust_name, date_of_birth, cust_type, cust_age) values(22018,'Shoriful',TO_DATE('12/12/1997', 'DD/MM/YYYY'),'Normal',24);
INSERT INTO customers(cust_id, cust_name, date_of_birth, cust_type, cust_age) values(22019,'Arnob',TO_DATE('14/11/1996', 'DD/MM/YYYY'),'VIP',25);
INSERT INTO customers(cust_id, cust_name, date_of_birth, cust_type, cust_age) values(22020,'Parvej',TO_DATE('11/06/2000', 'DD/MM/YYYY'),'Normal',21);

INSERT INTO booking_payment(booking_id, booking_date, amount, hotel_id, cust_id) values(32011,TO_DATE('22/12/2021', 'DD/MM/YYYY'),3000,12011,22012);
INSERT INTO booking_payment(booking_id, booking_date, amount, hotel_id, cust_id) values(32012,TO_DATE('27/11/2021', 'DD/MM/YYYY'),4000,12011,22012);
INSERT INTO booking_payment(booking_id, booking_date, amount, hotel_id, cust_id) values(32013,TO_DATE('25/01/2022', 'DD/MM/YYYY'),5000,12011,22012);
INSERT INTO booking_payment(booking_id, booking_date, amount, hotel_id, cust_id) values(32014,TO_DATE('12/02/2022', 'DD/MM/YYYY'),3000,12011,22012);
INSERT INTO booking_payment(booking_id, booking_date, amount, hotel_id, cust_id) values(32015,TO_DATE('21/03/2022', 'DD/MM/YYYY'),2000,12011,22012);
INSERT INTO booking_payment(booking_id, booking_date, amount, hotel_id, cust_id) values(32016,TO_DATE('22/12/2021', 'DD/MM/YYYY'),5000,12012,22012);
INSERT INTO booking_payment(booking_id, booking_date, amount, hotel_id, cust_id) values(32017,TO_DATE('27/11/2021', 'DD/MM/YYYY'),9000,12013,22012);
INSERT INTO booking_payment(booking_id, booking_date, amount, hotel_id, cust_id) values(32018,TO_DATE('25/01/2022', 'DD/MM/YYYY'),10000,12014,22012);
INSERT INTO booking_payment(booking_id, booking_date, amount, hotel_id, cust_id) values(32019,TO_DATE('12/02/2022', 'DD/MM/YYYY'),11000,12015,22012);
INSERT INTO booking_payment(booking_id, booking_date, amount, hotel_id, cust_id) values(32020,TO_DATE('21/03/2022', 'DD/MM/YYYY'),19000,12018,22012);

INSERT INTO rooms(hotel_id, room_no, room_type, booking_id, booking_date) values(12011,101,'AC',32011,TO_DATE('22/12/2021', 'DD/MM/YYYY'));
INSERT INTO rooms(hotel_id, room_no, room_type, booking_id, booking_date) values(12011,102,'AC',32011,TO_DATE('22/12/2021', 'DD/MM/YYYY'));
INSERT INTO rooms(hotel_id, room_no, room_type, booking_id, booking_date) values(12011,103,'NON_AC',32012,TO_DATE('27/11/2021', 'DD/MM/YYYY'));
INSERT INTO rooms(hotel_id, room_no, room_type, booking_id, booking_date) values(12012,102,'AC',32013,TO_DATE('25/01/2022', 'DD/MM/YYYY'));
INSERT INTO rooms(hotel_id, room_no, room_type, booking_id, booking_date) values(12012,104,'NON_AC',32013,TO_DATE('25/01/2022', 'DD/MM/YYYY'));
INSERT INTO rooms(hotel_id, room_no, room_type, booking_id, booking_date) values(12015,101,'AC',32011,TO_DATE('22/12/2021', 'DD/MM/YYYY'));
INSERT INTO rooms(hotel_id, room_no, room_type, booking_id, booking_date) values(12015,102,'AC',32011,TO_DATE('22/12/2021', 'DD/MM/YYYY'));
INSERT INTO rooms(hotel_id, room_no, room_type, booking_id, booking_date) values(12017,103,'AC',32012,TO_DATE('27/11/2021', 'DD/MM/YYYY'));
INSERT INTO rooms(hotel_id, room_no, room_type, booking_id, booking_date) values(12017,102,'NON_AC',32013,TO_DATE('25/01/2022', 'DD/MM/YYYY'));
INSERT INTO rooms(hotel_id, room_no, room_type, booking_id, booking_date) values(12017,104,'AC',32013,TO_DATE('25/01/2022', 'DD/MM/YYYY'));

INSERT INTO hotel_ratings(cust_id, hotel_id, rating) values(22012,12012,5.0);
INSERT INTO hotel_ratings(cust_id, hotel_id, rating) values(22012,12013,4.0);
INSERT INTO hotel_ratings(cust_id, hotel_id, rating) values(22012,12014,3.0);
INSERT INTO hotel_ratings(cust_id, hotel_id, rating) values(22013,12012,1.0);
INSERT INTO hotel_ratings(cust_id, hotel_id, rating) values(22014,12012,2.0); 
INSERT INTO hotel_ratings(cust_id, hotel_id, rating) values(22015,12017,5.0);
INSERT INTO hotel_ratings(cust_id, hotel_id, rating) values(22015,12020,4.0);
INSERT INTO hotel_ratings(cust_id, hotel_id, rating) values(22017,12018,3.0);
INSERT INTO hotel_ratings(cust_id, hotel_id, rating) values(22016,12017,1.0);
INSERT INTO hotel_ratings(cust_id, hotel_id, rating) values(22020,12017,2.0); 

SELECT * from hotels;
SELECT * from customers;
SELECT * from  booking_payment;
SELECT * from rooms;
SELECT * from hotel_ratings;



------------------lab2----------------------

--SELECT * FROM tab;

ALTER TABLE customers ADD cust_address varchar2(20);
ALTER TABLE hotels ADD (
    hotel_address varchar2(20),
    hotel_desc varchar2(20)
);

ALTER TABLE customers MODIFY cust_address varchar2(30);
ALTER TABLE hotels MODIFY (
    hotel_address varchar2(30),
    hotel_desc varchar2(30)
);

ALTER TABLE hotels DROP COLUMN hotel_address;

ALTER TABLE hotels RENAME COLUMN hotel_desc to hotel_description;

DESC hotels;
DESC customers;
ALTER TABLE hotels DROP COLUMN hotel_description;
ALTER TABLE customers DROP COLUMN cust_address;

SELECT * FROM hotels; 
UPDATE hotels SET  rating=4.7 WHERE hotel_type='5*' ;
SELECT * FROM hotels;
DELETE FROM hotels WHERE hotel_name = 'Hotel A';
SELECT * FROM hotels;
DELETE FROM booking_payment where hotel_id = 12014;
SELECT * FROM hotels;
SELECT * FROM booking_payment;
DELETE FROM hotels WHERE hotel_id = 12015;
SELECT * FROM booking_payment;



--------------------lab3------------------------
-- applying operation on field data 
   select (no_of_rooms/5) as rooms_devded_by_five from hotels;

  