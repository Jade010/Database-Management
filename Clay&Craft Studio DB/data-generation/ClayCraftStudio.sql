-- ==================
-- CREATE DATABASE
-- ==================
CREATE DATABASE ClayCraftStudio;

-- ================
-- CREATE TABLES
-- ================
CREATE TABLE Staff (
    staff_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
	skill_level VARCHAR(20) CHECK (skill_level IN ('beginner', 'intermediate', 'expert')),
    start_date DATE
);

CREATE TABLE Products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    base_price DECIMAL(10, 2)
);

CREATE TABLE ProductInstances (
    instance_id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT,
    created_by INT,
    date_created DATE NOT NULL,
    glaze_type VARCHAR(50),
    quality_grade VARCHAR(1) CHECK (quality_grade IN ('A', 'B', 'C')),
	status VARCHAR(20) CHECK (status IN ('available', 'sold', 'defective')),

	FOREIGN KEY (product_id) REFERENCES Products(product_id),
	FOREIGN KEY (created_by) REFERENCES Staff(staff_id)
);

CREATE TABLE Customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Orders (
  order_id INT IDENTITY(1,1) PRIMARY KEY,
  customer_id INT NOT NULL ,
  order_date DATE NOT NULL,
  qty INT,
  
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE OrderItems (
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    product_instance_id INT,
	price_sold DECIMAL(10,2) NOT NULL,

	FOREIGN KEY (order_id) REFERENCES Orders(order_id),
	FOREIGN KEY (product_instance_id) REFERENCES ProductInstances(instance_id)
);

-- =================
-- MANUAL INSERTS
-- =================

-- Staff
INSERT INTO Staff (first_name, last_name, skill_level, start_date) VALUES 
('Sophie', 'Kim', 'expert', '2019-01-01'), -- Studio Director
('Joan', 'Silva', 'expert', '2019-06-10'), -- Ceramic Artist
('Milo', 'Tran', 'intermediate', '2019-09-05'), -- Ceramic Artist
('Leila', 'Young', 'intermediate', '2021-11-22'), -- Ceramic Artist
('Ben', 'Carr', 'beginner', '2024-01-01') -- New Ceramic Artist

-- Products
INSERT INTO Products (product_name, description, base_price) VALUES
('Ceramic Mug', 'Handcrafted ceramic mug for hot or cold beverages. Durable and microwave-safe.', 22.00), -- 1. Ceramic Mugs
('Dinnerware Set (Plates & Bowls)', 'Matching set of handcrafted dinner plates and bowls. Suitable for everyday use or special occasions.', 75.00), -- 2. Dinnerware Sets
('Ceramic Baking Dish', 'Oven-safe ceramic baking dish perfect for casseroles, lasagna, and roasting.', 48.00), -- 3. Baking Dish
('Travel Cup with Silicone Sleeve & Lid', 'Eco-friendly, handmade ceramic travel cup with heat-protective silicone sleeve and BPA-free lid.', 30.00), -- 4. Portable Travel Cup with Silicone Sleeve & Lid
('Self-Watering Planter', 'Double-layered ceramic planter that allows plants to absorb water gradually from a base reservoir.', 40.00), -- 5. Self-Watering Planter
('Teatime Set', 'Elegant handmade ceramic set including a teapot and two matching cups. Ideal for personal tea service.', 60.00); -- 6. Teatime Set
 
