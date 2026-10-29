create database customerservicedb;
create database bankingdb;
use bankingdb;

create table tbl_customers
(
	customer_id int primary key auto_increment,
    customer_name varchar(50) not null,
    customer_email varchar(50) unique,
    customer_password varchar(50) check(length(customer_password) > 8),
    customer_phone varchar(50) check(length(customer_phone)=10)
)auto_increment = 202601;

desc tbl_customers;


create table tbl_accounts
(
	account_no int primary key auto_increment,
    account_type varchar(50) check(account_type in('savings','current')),
    balance double check (balance>0),
    account_pin int not null,
    customer_id int references tbl_customers(customer_id)
)auto_increment=260001;


-- 3rd_table 
create table tbl_transactions
(
	transactionId int,
    transaction_date datetime,
    amount double
);


alter table tbl_transactions drop column transactionId;
desc tbl_transactions;

alter table tbl_transactions
add column transactionId int auto_increment,
add primary key(transactionId);

-- Help

alter table tbl_transactions
add constraint chk_transaction_date check(transaction_date>=sysdate());

alter table tbl_transactions drop constraint chk_transaction_date;
desc tbl_transactions;

-- apply check constarint on amount: Amount should be greater than zero

alter table tbl_transactions add constraint chk_amount check(amount>0);

alter table tbl_transactions 
add column account_no int,
add constraint fk_account foreign key (account_no)
references tbl_accounts(account_no);




INSERT INTO tbl_customers
    (customer_name, customer_email, customer_password, customer_phone)
VALUES
    ('Ava Patel', 'ava.patel@example.com', 'AvaPass2026!', '2125550101'),
    ('Liam Johnson', 'liam.johnson@example.com', 'LiamPass2026!', '2125550102'),
    ('Mia Chen', 'mia.chen@example.com', 'MiaPass2026!', '2125550103'),
    ('Noah Williams', 'noah.williams@example.com', 'NoahPass2026!', '2125550104'),
    ('Sophia Garcia', 'sophia.garcia@example.com', 'SophiaPass2026!', '2125550105'),
    ('Ethan Brown', 'ethan.brown@example.com', 'EthanPass2026!', '2125550106'),
    ('Isabella Davis', 'isabella.davis@example.com', 'IsabellaPass2026!', '2125550107'),
    ('Lucas Miller', 'lucas.miller@example.com', 'LucasPass2026!', '2125550108'),
    ('Amara Wilson', 'amara.wilson@example.com', 'AmaraPass2026!', '2125550109'),
    ('Oliver Moore', 'oliver.moore@example.com', 'OliverPass2026!', '2125550110'),
    ('Zoe Taylor', 'zoe.taylor@example.com', 'ZoePass2026!', '2125550111'),
    ('James Anderson', 'james.anderson@example.com', 'JamesPass2026!', '2125550112'),
    ('Priya Thomas', 'priya.thomas@example.com', 'PriyaPass2026!', '2125550113'),
    ('Benjamin Jackson', 'benjamin.jackson@example.com', 'BenjaminPass2026!', '2125550114'),
    ('Layla White', 'layla.white@example.com', 'LaylaPass2026!', '2125550115');
 
INSERT INTO tbl_accounts
    (account_type, balance, account_pin, customer_id)
VALUES
    ('savings', 4250.75, 1842, 202601),
    ('current', 8200.00, 2951, 202602),
    ('savings', 1375.50, 3064, 202603),
    ('current', 12600.25, 4173, 202604),
    ('savings', 5680.00, 5286, 202605),
    ('current', 2450.90, 6395, 202606),
    ('savings', 9100.00, 7418, 202607),
    ('current', 3325.65, 8527, 202608),
    ('savings', 7180.40, 9631, 202609),
    ('current', 15400.00, 1742, 202610),
    ('savings', 2890.25, 2853, 202611),
    ('current', 6300.80, 3964, 202612),
    ('savings', 11250.00, 4075, 202613),
    ('current', 4875.35, 5186, 202614),
    ('savings', 7650.60, 6297, 202615);
 
INSERT INTO tbl_transactions
    (transaction_date, amount, account_no)
VALUES
    ('2027-01-05 09:15:00', 125.50, 260001),
    ('2027-01-07 11:30:00', 240.00, 260002),
    ('2027-01-09 14:05:00', 75.25, 260003),
    ('2027-01-12 16:45:00', 510.00, 260004),
    ('2027-01-15 10:20:00', 89.99, 260005),
    ('2027-01-18 13:10:00', 325.75, 260006),
    ('2027-01-21 08:50:00', 150.00, 260007),
    ('2027-01-24 17:25:00', 64.50, 260008),
    ('2027-01-27 12:40:00', 430.20, 260009),
    ('2027-02-02 15:00:00', 275.00, 260010),
    ('2027-02-06 09:35:00', 95.80, 260011),
    ('2027-02-10 18:15:00', 680.00, 260012),
    ('2027-02-14 10:55:00', 210.45, 260013),
    ('2027-02-19 14:30:00', 155.00, 260014),
    ('2027-02-25 11:05:00', 390.60, 260015);



select * from tbl_customers;
update tbl_customers set customer_password = 'Ava@12345' where customer_id = 202616;

update tbl_customers set customer_password = 'Ava@12345', customer_phone='123456789'
where customer_id=202617;

-- -----------------DQL queries ----------------
select * from tbl_customers;

-- selection
select customer_id, customer_name from tbl_customers;

-- projection
select * from tbl_customers where customer_id>202618;

-- logical operators
select * from tbl_accounts where account_type='savings';

-- fetch all savings accounts having balance more than 10k
select * from tbl_accounts where account_type = 'savings' and balance>10000;


-- fetch all accounts which is either savings account or have balance greater than 10000.
select * from tbl_accounts where account_type = 'savings' or balance>10000;

-- fetch either savings account or current account with balance greater than 10000.
select * from tbl_accounts where account_type = 'savings' or (account_type='current' and balance>10000);


truncate table tbl_transactions;
alter table tbl_transactions
add column transaction_type varchar(50) not null,
add constraint chk_transaction_type check(transaction_type in ('debit','credit'));

INSERT INTO tbl_transactions
    (transaction_date, amount, account_no, transaction_type)
VALUES
    ('2026-11-01 09:15:00', 125.50, 260001, 'debit'),
    ('2026-11-01 10:30:00', 500.00, 260002, 'credit'),
    ('2026-11-02 11:45:00', 75.25, 260003, 'debit'),
    ('2026-11-02 14:00:00', 1200.00, 260004, 'credit'),
    ('2026-11-03 08:20:00', 89.99, 260005, 'debit'),
    ('2026-11-03 16:10:00', 325.75, 260006, 'credit'),
    ('2026-11-04 09:05:00', 150.00, 260007, 'debit'),
    ('2026-11-04 13:25:00', 64.50, 260008, 'debit'),
    ('2026-11-05 10:40:00', 430.20, 260009, 'credit'),
    ('2026-11-05 15:55:00', 275.00, 260010, 'debit'),
    ('2026-11-06 08:35:00', 95.80, 260011, 'debit'),
    ('2026-11-06 17:15:00', 680.00, 260012, 'credit'),
    ('2026-11-07 11:00:00', 210.45, 260013, 'debit'),
    ('2026-11-07 14:30:00', 155.00, 260014, 'credit'),
    ('2026-11-08 09:50:00', 390.60, 260015, 'debit'),
    ('2026-11-09 12:10:00', 850.00, 260001, 'credit'),
    ('2026-11-09 16:45:00', 42.75, 260002, 'debit'),
    ('2026-11-10 08:55:00', 300.00, 260003, 'credit'),
    ('2026-11-10 13:35:00', 110.25, 260004, 'debit'),
    ('2026-11-11 10:15:00', 725.00, 260005, 'credit'),
    ('2026-11-11 15:20:00', 58.40, 260006, 'debit'),
    ('2026-11-12 09:40:00', 410.00, 260007, 'credit'),
    ('2026-11-12 14:05:00', 205.90, 260008, 'debit'),
    ('2026-11-13 11:25:00', 950.00, 260009, 'credit'),
    ('2026-11-13 16:30:00', 135.00, 260010, 'debit');


--  fetch all the transactions done by account numbers;

select * from tbl_transactions where account_no=260007;


-- fetch all transactions done by set of account numbers(260001,260009,260004,260002)

select * from tbl_transactions where account_no in (260001,260009,260004,260002);

-- fetch all transactions done by set of account numbers except (260001,260009,260004,260002)
select * from tbl_transactions where account_no not in (260001,260009,260004,260002);

-- fetch transactions where transaction amount ranges from 100 to 900
select * from tbl_transactions where amount between 100 and 900;

-- fetch transactions where transaction amount not ranges from 100 to 900
select * from tbl_transactions where amount not between 100 and 900;

-- ------------------------------ Aggregate Functions ------------------------------
-- find the total amount of transactions done so far
select sum(amount) 'total amount' from tbl_transactions;


-- find the average amount of transactions done so far
select avg(amount) 'total amount' from tbl_transactions;

-- find the minimum amount of transactions done so far
select min(amount) 'total amount' from tbl_transactions;

-- find the maximum amount of transactions done so far
select max(amount) 'total amount' from tbl_transactions;

-- find the total number of transactions done so far
select count(amount) 'total amount' from tbl_transactions;

-- find the total amount of transactions done by an account.
select sum(amount) 'total amount' from tbl_transactions where account_no=260001;

-- find the total amount of debit transactions done by an account.
select sum(amount) 'total amount' from tbl_transactions where account_no=260001 and transaction_type='debit';

-- list the account number and total amount of transactions done by an account.
select account_no, sum(amount) 'total amount' from tbl_transactions where account_no=260001;


-- list account numbers and their total amount of transactions
-- select sum(amount) from tbl_transactions where account_no = 260001;
-- select sum(amount) from tbl_transactions where account_no = 260002;
-- select sum(amount) from tbl_transactions where account_no = 260003;


select account_no,sum(amount) from tbl_transactions group by account_no;


-- list account numbers and their total amount of transactions for selected accounts(260001,260005,260009,260007)
select account_no,sum(amount) from tbl_transactions 
where account_no in (260001,260005,260009,260007) 
group by account_no;


-- list account numbers and their total amount of transactions for selected accounts(260001,260005,260009,260007) where total amount of transaction is greater than 900
select account_no,sum(amount) from tbl_transactions 
where account_no in (260001,260005,260009,260007) 
group by account_no 
having sum(amount)>900;


-- sort the above rows in increasing order of total amount.
select account_no,sum(amount) from tbl_transactions 
where account_no in (260001,260005,260009,260007) 
group by account_no 
having sum(amount)>900 order by sum(amount);



-- --------------------------- joins ---------------------------------------
-- inner join: data from matching condition
-- fetch customer id and the account balance available

select c.customer_id , balance from tbl_customers c
inner join
tbl_accounts a
on c.customer_id=a.customer_id;

-- generate a report to show account number, account type, transaction id and transaction amount.
select a.account_no, a.account_type, transactionId, amount from tbl_accounts a 
inner join
tbl_transactions t
on a.account_no = t.account_no;



-- left join
-- Check if any customer not having an account.

select c.customer_id, account_no
from tbl_customers c
left join tbl_accounts a 
on c.customer_id = a.customer_id;


-- check all acccounts and their transactions and find out which account do not have any transaction.

select a.account_no, transactionId from tbl_accounts a 
left join tbl_transactions t
on a.account_no = t.account_no;

insert into tbl_accounts
	(account_type,balance,account_pin, customer_id)
values
	('savings', 6598.75, 1234, null);
    
-- Right Join
-- Display customer id and all account_no evrn if there is no customer for the account






-- full join not supported, achieve the same using UNION

select c.customer_id, account_no from tbl_customers c
left join tbl_accounts a 
on c.customer_id = a.customer_id
UNION
select c.customer_id, account_no from tbl_customers c 
right join tbl_accounts a 
on c.customer_id = a.customer_id;


-- self join
create table tbl_employees
(
	employee_id int primary key auto_increment,
    employee_name varchar(50),
    employee_designation varchar(50),
    manager_id int
);

INSERT INTO tbl_employees (employee_name, employee_designation, manager_id) VALUES
-- Level 1: Executive (Top of the hierarchy, no manager)
('Alice Smith', 'Chief Executive Officer', NULL),
 
-- Level 2: Department Heads (Report directly to Alice, employee_id = 1)
('Bob Jones', 'VP of Engineering', 1),
('Charlie Brown', 'VP of Marketing', 1),
('Diana Prince', 'VP of Human Resources', 1),
 
-- Level 3: Managers (Report to Engineering/Marketing Heads)
('Evan Wright', 'Engineering Manager', 2),
('Fiona Gallagher', 'QA Manager', 2),
('George Clark', 'Marketing Director', 3),
 
-- Level 4: Senior & Junior Staff
('Hannah Abbott', 'Senior Software Engineer', 5),
('Ian Malcolm', 'Software Engineer', 5),
('Julia Roberts', 'Junior Software Engineer', 5),
('Kevin Bacon', 'Senior QA Engineer', 6),
('Laura Croft', 'QA Automation Engineer', 6),
('Michael Scott', 'Content Strategy Manager', 7),
('Nancy Drew', 'SEO Specialist', 7),
('Oliver Twist', 'HR Coordinator', 4);

-- generate a report to view the manager names of each employee.

select emp.employee_id, emp.employee_name, emp.employee_designation, mgr.employee_name 'manager name', mgr.employee_designation 'Manager Designation' 
from tbl_employees emp
join 
tbl_employees mgr
on emp.manager_id = mgr.employee_id;



-- Sub queries
-- fetch the customers details who are having savings account.
select * from tbl_customers where customer_id in (select customer_id from tbl_accounts where account_type = 'savings');

-- fetch account details where total transaction amount is greater than 100
select * from tbl_accounts where account_no in (
	select account_no from tbl_transactions group by account_no having sum(amount) > 1000
);

-- fetch customer details where total transaction amount is greater than 100
select * from tbl_customers where customer_id in(
	select customer_id from tbl_accounts where account_no in(
		select account_no from tbl_transactions group by account_no having sum(amount) > 1000
	)
);


-- find out the richest customer
select customer_name from tbl_customers where customer_id in (
	select customer_id from tbl_accounts where balance = (
		select max(balance) from tbl_accounts
	)
);


-- create procedure to withdraw amount from an account
drop procedure withdraw
DELIMITER //
create procedure withdraw(acc_no int,acc_pin int,amt double)
begin
	declare acc_balance double default 0;
	declare acc_count int default 0;
    select count(*),balance into acc_count, acc_balance from tbl_accounts
    where account_no=acc_no and account_pin=acc_pin
    group by account_no,balance;
    if acc_count > 0 then
       if amt<=acc_balance then
		update tbl_accounts set balance=balance-amt where
        account_no=acc_no;
       else
		select 'Insufficient Balance';
       end if;
	else
		select 'Invalid credentials';
    end if;
end;
//
DELIMITER ;
 
 
call withdraw(260001,1842,4500)



-- write a procedure to change customer password
delimiter //
drop procedure if exists change_customer_password;
create procedure change_customer_password(cust_id int, old_password varchar(255), new_password varchar(255))
begin
    declare cust_count int default 0;
    select count(*) into cust_count 
    from tbl_customers
    where customer_id = cust_id and customer_password = old_password;
    if cust_count > 0 then
        update tbl_customers 
        set customer_password = new_password 
        where customer_id = cust_id;
        select 'password updated successfully' as status;
    else
        select 'invalid customer id or current password' as status;
    end if;
end;
//
 
delimiter ;
 
 
call change_customer_password(202609, 'AmaraPass2026!', 'AmaraPass2027!');


DELIMITER //
create procedure deposit(acc_no int, amt double,out new_balance double)
begin
	declare acc_balance double default 0;
    declare acc_count int default 0;
    select count(*), balance into acc_count from tbl_accounts
    where account_no=acc_no group by account_no;
    set new_balance = acc_balance; -- current balance
    if acc_count > 0 then 
		if amt>0 then
			update tbl_accounts set balance = balance + amt where
            account_no = acc_no;
            select balance into acc_balance from tbl_accounts
				where account_no = acc_no;
			set new_Balance = acc_balance;
		else
			select 'Invalide amount';
		end if;
	else
		select ' Account number not found';
	end if;
end;
//
DELIMITER ;

call deposit (260001, -100, @new_balance);
select @new_balance 'New Balance';



DELIMITER //
create procedure transfer_money(sender_id INT, receiver_id INT, amt double)
begin
	UPDATE tbl_accounts 
    SET balance = balance - amt
    WHERE AccountID = sender_id;
    
    UPDATE tbl_accounts 
    SET balance = balance + amt
    WHERE account_no = receiver_id;
end;
delimiter ;


CALL transfer_money(260001, 260002, 50);








DELIMITER //
CREATE FUNCTION get_total_transactions(p_acc_no INT)
RETURNS DOUBLE
READS SQL DATA
BEGIN
	DECLARE total_amount DOUBLE DEFAULT 0.0;
    
    SELECT SUM(amount) INTO total_amount
    FROM tbl_transactions WHERE account_no = p_acc_no;
    RETURN total_amount;
END //
DELIMITER ;

select get_total_transactions(260001) 'Total Amount';



-- ---------------------- VIEWS -------------------------


create view savings_account_view
as
  select * from  tbl_accounts where account_type = 'savings';

select * from savings_account_view;


create view employee_account_view
as
  select account_no, account_type, balance from tbl_accounts;
  
select * from employee_account_view;


-- complex view: By joining tables. (Obtaining data from mutliple tables)
create view account_transaction_view
as 
	select a.account_no, account_type, transaction_id, amount from tbl_accounts a
    join
    tbl_transactions t on a.account_no = t.account_no;
    
select * from account_transaction_view;


create view insert_customer_view
as
select * from tbl_customers;


insert into insert_customer_view(customer_name, customer_password) values('james', 'james@123');