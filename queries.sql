-- applying condition
 select room_type from rooms where hotel_id=12011;
-- range search 
 select hotel_id,hotel_name, rating from hotels where hotel_id>=12011 and hotel_id<=12015;
 select hotel_id ,hotel_name from hotels
 where hotel_id>=12011 or rating<='5*'; 
 select hotel_id,hotel_name,rating from hotels 
  where hotel_id between 12011 and 12015;
  select hotel_id,hotel_name from hotels
  where hotel_id  not between 12011 and 12015;
  select hotel_id,no_of_rooms from hotels where hotel_id in(12011,12015);
  select hotel_id,no_of_rooms from hotels where hotel_id not in (12011,12015);
  
  --order by
  select hotel_id, no_of_rooms,rating from hotels order by rating ;
  select hotel_id, no_of_rooms,rating from hotels order by rating DESC ;

  --matching 
  select cust_id,cust_name from customers where
   cust_name  like 'F%' ;
   select distinct(hotel_id) from rooms;
--aggregate function
   select max(hotel_id) from hotels;
   select min(hotel_id) from hotels;
   select count (hotel_id) from rooms;
   select count(*) from hotels; 
   select avg(hotel_id) from hotels;
   select count(distinct(hotel_id)) from rooms ;
   select avg(nvl(hotel_id,0)) from hotels;
--group by
   select booking_date, count(booking_id) from booking_payment where amount> 5000 group by booking_date;
   select booking_date, count(booking_id) from booking_payment group by booking_date;
--having 
   select booking_date,count(booking_id)  from booking_payment group by booking_date having count(booking_id) <3000;
--uninon operation 
 select  cust_id,cust_name ,date_of_birth from customers where cust_id <22014
 union  select cust_id ,cust_name,date_of_birth from customers where cust_id >22017;
 
 select  cust_id,cust_name ,date_of_birth from customers where cust_id >22014
 intersect  select cust_id ,cust_name,date_of_birth from customers where cust_id >22017;

 select  cust_id,cust_name ,date_of_birth from customers where cust_id >22014
 minus  select cust_id ,cust_name,date_of_birth from customers where cust_id >22017;

 select cust_name,cust_id from customers where cust_name in('Farhan Pollok','Faias Promit');
 
 select cust_name,cust_id from customers where cust_name in(
    select cust_name from customers 
    where cust_type='VIP'
 );
 --simple join 
select c.cust_name,b.booking_date,amount from customers c join booking_payment b 
on c.cust_id=b.cust_id;
--natural join 
select c.cust_name,b.booking_date,amount from customers c natural join booking_payment b ;
---inner join
select c.cust_name,b.booking_date,amount from customers c inner join booking_payment b 
on c.cust_id=b.cust_id;

select c.cust_name,b.booking_date,amount from customers c left outer join booking_payment b 
on c.cust_id=b.cust_id;
select c.cust_name,b.booking_date,amount from customers c right outer join booking_payment b 
on c.cust_id=b.cust_id;
select c.cust_name,b.booking_date,amount from customers c  full outer join booking_payment b 
on c.cust_id=b.cust_id;

---self join 
select a.cust_id from customers a minus
select a.cust_id from customesrs a join customers b on a.cust_id < b.cust_id;

 ---trigger,transaction,pl sql, view


 --PL_SQL 

-- PL/SQL Procedure for displaying a Single Row

set serveroutput on
declare
var_cust_id  customers.cust_id%type;
var_cust_name customers.cust_name%type;
var_cust_type customers.cust_type%type;
begin
select cust_id, cust_name, cust_type  into var_cust_id , var_cust_name, var_cust_type from customers where cust_id = 22011;
dbms_output.put_line('customer_Id : ' || var_cust_id || ', Customer_Name : ' || var_cust_name|| ', Customer_Type : ' || var_cust_type );

end;
/


-- PL/SQL Procedure for displaying Multiple Rows (using Cursor)

set serveroutput on
declare
cursor cust_cursor is select cust_id, cust_name, cust_type from customers;
customers_row cust_cursor%rowtype;
begin

open cust_cursor;
loop
	fetch cust_cursor into customers_row;
	exit when cust_cursor%rowcount > 5;
	dbms_output.put_line('Customer_Id : ' || customers_row.cust_id);
	dbms_output.put_line('Customer_Name : ' || customers_row.cust_name);
	dbms_output.put_line('Customer_Type : ' || customers_row.cust_type);
end loop;
close cust_cursor;

end;
/


-- PL/SQL Procedure for Customers's Info
set serveroutput on
create or replace procedure get_customers_info is
c_id customers.cust_id%type ;
c_name customers.cust_name%type;
c_dob customers.date_of_birth%type;

begin
c_id := 22011;
select cust_id, cust_name, date_of_birth into c_id, c_name, c_dob 
from customers where cust_id = c_id;
dbms_output.put_line('Customer Id: '|| c_id);
dbms_output.put_line('Customer Name: '|| c_name);
dbms_output.put_line('Customer Type: '|| c_dob);
end ;
/
show errors

begin
	get_customers_info;
end;
/





-- Function to get the Maximum amount of Payment int booking_payment table

set serveroutput on
create or replace function booking_pay_amount return number is
max_amount booking_payment.amount%type;
begin
select max(amount) into max_amount from booking_payment;
return max_amount;
end ;
/

begin
	dbms_output.put_line('Max Booking Payment Amount: ' || booking_pay_amount);
end;
/



-- PL/SQL Procedure which takes User Input & make Decision about hotel condition
set serveroutput on
declare
h_ratings hotels.rating%type;
h_id hotels.hotel_id%type := &HOTEL_ID;

begin
select  rating into h_ratings from hotels
where hotel_id = h_id;

dbms_output.put_line ('Hotel_id: ' || h_id);


if h_ratings >= 4.0 then
	dbms_output.put_line ('The Hotel is GOOD');
elsif h_ratings >= 3.0  then
	dbms_output.put_line ('The Hotel is MEDIUM');
elsif h_ratings >= 1.0 then
	dbms_output.put_line ('The Hotel is Bad');
end if;

exception
when others then
	dbms_output.put_line (sqlerrm);
end;
/



-- View (create, update, delete, drop)

create or replace view room_details as select hotel_id, room_no, room_type from rooms;

select * from room_details ;

update room_details  set room_type = 'Delux' where hotel_id= 12011 And room_no = 103 ;
select * from room_details;

delete from room_details  where hotel_id= 12011 And room_no = 103;
select * from room_details ;
   
drop view room_details ;






-- Trigger to check the Validity of Rating of a hotel 

set serveroutput on

create or replace trigger check_rating before insert or update on hotels
for each row
declare
min_rating number := 1.0;
max_rating number := 5.0;

begin

if :new.rating > max_rating then
	raise_application_error(-20000,'Rating should be less than 5.0');
elsif :new.rating < min_rating then
	raise_application_error(-20001,'Rating should be more than 1.0');
else dbms_output.put_line('New row inserted in hotel table Successfully');
end if;

end;
/
INSERT INTO hotels(hotel_id, hotel_name, hotel_type, no_of_rooms, rating) values(12021,'Hotel Khan Jahan','5*',84,0);
INSERT INTO hotels(hotel_id, hotel_name, hotel_type, no_of_rooms, rating) values(12022,'Hotel Amar Ekushe','5*',84,10.0);
INSERT INTO hotels(hotel_id, hotel_name, hotel_type, no_of_rooms, rating) values(12023,'Hotel Lalan Shah','5*',84,4.0);
select * from hotels;


-- TRANSACTION MANAGEMENT FOR CUSTOMER
select * from hotel_ratings;
savepoint sp1;
delete from hotel_ratings where cust_id =22012;
select * from hotel_ratings;
 
rollback to sp1;
select * from hotel_ratings;
commit;

INSERT INTO hotel_ratings(cust_id, hotel_id, rating) values(22013,12017,1.0);
savepoint sp2;
INSERT INTO hotel_ratings(cust_id, hotel_id, rating) values(22012,12017,3.0);
select * from hotel_ratings;

rollback to sp2;
select * from hotel_ratings;
rollback;
select * from hotel_ratings;



-- DATE FUNCTIONALITY

select sysdate from dual;
select current_date from dual;
select systimestamp from dual;


select hotel_name, CAST((sysdate-date_of_birth)/365 as int) as AGE from hotels;

select  booking_date, amount from booking_payment where booking_id =32012;
select add_months (booking_date, 2) as two_months_extension from booking_payment where booking_id =32012;
select add_months (booking_date, -5) as five_months_Reduction from booking_payment where  booking_id =32012;


select least (to_date('1-JUN-2021'), to_date('1-NOV-2021')) from dual;
select greatest (to_date('1-JUN-2021'), to_date('26-NOV-2021')) from dual;

select last_day(booking_date) from booking_payment where booking_id <= 32014;

select amount, extract(day from booking_date) as Day from booking_payment where booking_id <= 32014;
select amount, extract(month from booking_date) as Month from booking_payment where booking_id <= 32014;
select amount, extract(year from booking_date) as Year from booking_payment where booking_id <= 32014;











 




 




