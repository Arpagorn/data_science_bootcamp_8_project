-- open database
.open restaurant.db
  
-- Create restaurant's table
CREATE TABLE IF NOT EXISTS employees (
  employeeID int unique,
  name text,
  position text,
  area text
);
INSERT INTO employees VALUES
  (1,'Cersei','Manager','dining'),
  (2,'Walter','Chef','kitchen'),
  (3,'Hermione','Sous_Chef','kitchen'),
  (4,'Luna','Waitress','dining'),
  (5,'Michael','Waiter','dining');

CREATE TABLE task (
  task text unique,
  area text,
  responsible_employee INT,
  performance text
);
INSERT INTO task values
  ('customer_service','dining',1,'excellent'),
  ('cooking','kitchen',2,'excellent'),
  ('food_preparation','kitchen',3,'good'),
  ('takes_customer_orders','dining',4,'excellent'),
  ('serves_food','dining',5,'good'),
  ('stock_Controller','kitchen',1,'excellent');

CREATE TABLE IF NOT EXISTS menu (
  menuname text unique,
  ingredient text,
  price int,
  salevolume_perday Int
);
INSERT INTO menu values
  ('Garden_salad','Fresh_lettuce',150,20),
  ('Grilled_salmon_steak','Salmon',280,21),
  ('Shrimp_salad_roll','Shrimp',170,30),
  ('Fruit_salad','Apple',150,17);

CREATE TABLE stock (
  ingredient text unique,
  quantityInStock_kg int,
  price_kg int,
  supplier text,
  responsible_employee int
);
INSERT INTO stock values
  ("Fresh_lettuce",10,50,"Supplier_A",1),
  ("Salmon",8,150,"Supplier_B",3),
  ("Shrimp",20,100,"Supplier_B",3),
  ("Apple",15,70,"Supplier_C",1);

-- list table in db
.table
--change display in shell
.mode column
  
--1.JOIN
SELECT
  me.menuname,
  me.ingredient,
  me.salevolume_perday,
  st.quantityInStock_kg,
  em.name AS control_by
  FROM menu AS me
JOIN stock AS st
ON me.ingredient = st.ingredient
JOIN employees AS em
ON em.employeeID = st.responsible_employee;

--2.Subquery to find excellent performance employee
SELECT name AS Excellent_performance FROM employees 
  WHERE employeeID IN (
  SELECT responsible_employee from task
  WHERE performance LIKE 'ex%'
);

--3. Common Table Expression - good performance employee
WITH  set1 AS (SELECT * FROM employees),
      set2 AS (SELECT * from task
                WHERE performance = 'good')
SELECT 
  set1.name AS Good_performance,
  set1.area,
  set2.task
FROM set1
JOIN set2
ON set1.employeeID = set2.responsible_employee;

--4.aggregate functions
SELECT 
  Menuname,
  price*salevolume_perday AS Total
  FROM Menu;

SELECT 
  AVG(Total) averagesale_per_day,
  MAX(Total),
  MIN(Total)
FROM (SELECT 
  Menuname,
  price*salevolume_perday AS Total
  FROM Menu);
