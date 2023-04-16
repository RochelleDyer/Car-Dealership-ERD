--Car Dealership ERD

--Create Customer Table
CREATE TABLE customer (
  customer_id SERIAL primary key,
  first_name VARCHAR(100),
  last_name VARCHAR(100)
);

--Create Salesperson Table
CREATE TABLE salesperson (
  sales_id SERIAL primary key,
  first_name VARCHAR(100),
  last_name VARCHAR(100)
);

--Create Mechanic Table
CREATE TABLE mechanic (
  mechanic_id SERIAL primary key,
  first_name VARCHAR(100),
  last_name VARCHAR(100)
);

--Create Car Table
CREATE TABLE car (
  serial_number SERIAL primary key,
  car_make VARCHAR(100),
  car_model VARCHAR(100)
);

--Create Parts Table
CREATE TABLE parts (
  parts_id SERIAL primary key,
  order_date DATE,
  parts_cost NUMERIC(10,2)
);

--Create Service Ticket Table
CREATE TABLE service_ticket (
  service_id SERIAL primary key,
  customer_id INTEGER not null,
  sales_id INTEGER not null,
  mechanic_id INTEGER not null,
  serial_number INTEGER not null,
  parts_id INTEGER not null,
  foreign key (customer_id) references customer (customer_id),
  foreign key (sales_id) references salesperson (sales_id),
  foreign key (mechanic_id) references mechanic (mechanic_id),
  foreign key (serial_number) references car (serial_number),
  foreign key (parts_id) references parts (parts_id)
);

--Create Invoice Table
CREATE TABLE invoice (
  invoice_id SERIAL primary key,
  invoice_total NUMERIC(10,2),
  customer_id INTEGER not null,
  sales_id INTEGER not null,
  serial_number INTEGER not null,
  car_make INTEGER not null,
  car_model INTEGER not null,
  foreign key (customer_id) references customer (customer_id),
  foreign key (sales_id) references salesperson (sales_id),
  foreign key (serial_number) references car (serial_number)
);

--Insert data into Customer table
insert into customer (customer_id, first_name, last_name)
values (1, 'Kimberly', 'Preston');
insert into customer (customer_id, first_name, last_name)
values (2, 'Sandy', 'Kellogg');

--Insert data into Salesperson table
insert into salesperson (sales_id, first_name, last_name)
values (1, 'Jeff', 'Beckner');
insert into salesperson (sales_id, first_name, last_name)
values (2, 'Tim', 'Stevens');

--Insert data into Mechanic table
insert into mechanic (mechanic_id, first_name, last_name)
values (1, 'Jamie', 'Preston');
insert into mechanic (mechanic_id, first_name, last_name)
values (2, 'Nathan', 'Dyer');

--Insert data into Car table
insert into car (serial_number, car_make, car_model)
values (1, 'Honda', 'Fit');
insert into car (serial_number, car_make, car_model)
values (2, 'Ford', 'Escape');

--Insert data into Parts table
insert into parts (parts_id, parts_cost, order_date)
values (1, 159.65, NOW()::TIMESTAMP);
insert into parts (parts_id, parts_cost, order_date)
values (2, 325.25, NOW()::TIMESTAMP);

--Insert data into Service Ticket table
insert into service_ticket (service_id, customer_id, sales_id, mechanic_id, serial_number, parts_id)
values (1,2,1,2,1,2);
insert into service_ticket (service_id, customer_id, sales_id, mechanic_id, serial_number, parts_id)
values (2,1,2,1,2,1);

--Insert data into Invoice table
insert into invoice (invoice_id, invoice_total, customer_id, sales_id, serial_number, car_make, car_model)
values (1, 635.50, 1, 2, 1, 1, 1);
insert into invoice (invoice_id, invoice_total, customer_id, sales_id, serial_number, car_make, car_model)
values (2, 2350, 2, 1, 2, 2, 2);

--Using functions to add data to a table
create function add_customers(_customer_id INTEGER, _first_name VARCHAR(100), _last_name VARCHAR(100))
returns void
as $MAIN$
begin 
		insert into customer(customer_id, first_name, last_name)
		values (_customer_id, _first_name, _last_name);
end;
$MAIN$
language plpgsql;

select add_customers (3,'Meredith', 'Temples');
select add_customers (4,'Melissa', 'Frasier');
select add_customers (5,'Allison', 'Dyer');
select * from customer;

--Insert data manually
insert into mechanic(mechanic_id, first_name, last_name) values (3, 'Shane', 'Thaxton' );
select * from mechanic
