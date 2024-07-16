DROP DATABASE IF EXISTS `Lobster_Inventory`;

CREATE DATABASE `Lobster_Inventory`;
USE `Lobster_Inventory`;


CREATE TABLE `suppliers` (
    `supplier_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `supplier_name` varchar(50),
    `contact_number` varchar(20),
    `street` varchar(50),
    `City` varchar(50),
    `Province` varchar(50)
);

CREATE TABLE `raw_materials`(
    `raw_material_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `supplier_id` int NOT NULL,
    `material_name` varchar(50),
    `weight_in_kg` decimal(6,2),
    `delivery_date` date,
    CONSTRAINT `supplier_id_fk` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers`(`supplier_id`)
);

CREATE TABLE `inventory_pack` (
    `inventory_pack_id` int AUTO_INCREMENT PRIMARY KEY,
    `name` varchar(50),
    `quantity` int,
    `minquantity` int,
    `category` varchar(50),
    `weight` decimal(6,2),
    `price` decimal(7,2),
    `status` ENUM('Available', 'Unavailable') DEFAULT 'Available',
    `active_status` ENUM('Active', 'Inactive') DEFAULT 'Active'
);

CREATE TABLE `inventory_daily_record` (
    `date` date,
    `inventory_pack_id` int(11),
    `starting_quantity` int,
    `additional_quantity` int DEFAULT 0,
    `sold_quantity` int DEFAULT 0,
    `wasted_quantity` int DEFAULT 0,
    `ending_quantity` int,
    `total_sales` decimal(10,2),
    CONSTRAINT `inventory_pack_id_fk` FOREIGN KEY (`inventory_pack_id`) REFERENCES `inventory_pack`(`inventory_pack_id`),
    PRIMARY KEY (`date`, `inventory_pack_id`)
);

CREATE TABLE `role`(
    `role_id` int(11) NOT NULL AUTO_INCREMENT,
    `role_name` varchar(10),
    PRIMARY KEY(`role_id`)
) ENGINE=INNODB;

CREATE TABLE `users`(
    `user_id` int(11) NOT NULL AUTO_INCREMENT,
    `role_id` int(11),
    `icon_path` varchar(255) NOT NULL,
    `user_fname` varchar(50) NOT NULL,
    `user_lname` varchar(50) NOT NULL,
    `email` varchar(50) NOT NULL,
    `user_password` varchar(255) NOT NULL,
    PRIMARY KEY(`user_id`),
    CONSTRAINT `role_id_fk` FOREIGN KEY (`role_id`) REFERENCES `role`(`role_id`)
) ENGINE=INNODB;

CREATE TABLE `actions`(
    `action_id` int(11) NOT NULL AUTO_INCREMENT,
    `action_name` varchar(50) NOT NULL,
    PRIMARY KEY(`action_id`)
) ENGINE=INNODB;

-- Inserting Roles and Users

INSERT INTO `role` (`role_id`, `role_name`) VALUES
(1, 'Owner'),
(2, 'Manager'),
(3, 'Staff');

INSERT INTO `users` (`user_id`, `role_id`, `icon_path`, `user_fname`, `user_lname`, `email`, `user_password`) VALUES
(1, 1, 'employeeProfile/owner.jpg', 'Sam', 'Russ', 'samuel@gmail.com', '$2y$10$W0WhXwQDcjdwOSavwvg2TOYUeemHHTMDfCxiY88Q8mI44G03RguJ6');

-- Inserting Suppliers and Raw Materials

INSERT INTO `suppliers` (`supplier_name`, `contact_number`, `street`, `City`, `Province`) VALUES
('Live Seafoods', '1234567890', '123 Ocean St', 'Seaside', 'Aquatica'),
('Meat Products', '0987654321', '456 Farm Rd', 'Agritown', 'Plainsville');

INSERT INTO `raw_materials` (`supplier_id`, `material_name`, `weight_in_kg`, `delivery_date`) VALUES
(1, 'Lobster', 50.00, '2024-07-01'),
(2, 'Chicken', 100.00, '2024-07-02'),
(2, 'Pork', 200.00, '2024-07-02'),
(2, 'Beef', 300.00, '2024-07-03');

-- Inserting Inventory Pack Data

INSERT INTO `inventory_pack` (`name`, `quantity`, `minquantity`, `category`, `weight`, `price`, `status`, `active_status`) VALUES
('Lemon Chicken', 20, 5, 'Chicken', 11.00, 200.00, 'Available', 'Active'),
('Lemon Chicken Large', 50, 10, 'Chicken', 50.00, 500.00, 'Available', 'Active'),
('3 Cups Chicken', 10, 3, 'Chicken', 11.00, 100.00, 'Available', 'Active'),
('Deep Fried Chicken', 80, 20, 'Chicken', 88.00, 500.00, 'Available', 'Active'),
('Half Chicken', 40, 10, 'Chicken', 99.00, 250.00, 'Available', 'Active'),
('Sweet&Sour Pork', 60, 20, 'Pork', 1.50, 350.00, 'Available', 'Active'),
('Salt&Pepper Spare Ribs', 70, 25, 'Pork', 2.00, 350.00, 'Available', 'Active'),
('Stir Fry Pork', 30, 15, 'Pork', 5.00, 350.00, 'Available', 'Active'),
('Sisig', 45, 20, 'Pork', 2.30, 280.00, 'Available', 'Active'),
('Steak Bites with Garlic Sauce', 55, 25, 'Beef', 7.50, 390.00, 'Available', 'Active'),
('Bistek Tagalog', 65, 30, 'Beef', 1.00, 390.00, 'Available', 'Active'),
('Beef Stir Fried', 75, 35, 'Beef', 2.00, 220.00, 'Available', 'Active'),
('Beef Stir Fried Large', 85, 40, 'Beef', 3.00, 260.00, 'Available', 'Active'),
('Beef Stir Fried Extra Large', 95, 45, 'Beef', 5.00, 350.00, 'Available', 'Active'),
('Mussels Chilean', 100, 50, 'Seafoods', 0.5, 550.00, 'Available', 'Active'),
('Pampano', 75, 25, 'Seafoods', 1.00, 480.00, 'Available', 'Active'),
('Curacha', 60, 20, 'Seafoods', 1.00, 1500.00, 'Available', 'Active'),
('Shrimps Tempura', 80, 30, 'Seafoods', 0.5, 550.00, 'Available', 'Active'),
('Shrimps Platter', 90, 35, 'Seafoods', 0.5, 550.00, 'Available', 'Active'),
('Salt & Pepper Shrimps', 100, 40, 'Seafoods', 0.5, 550.00, 'Available', 'Active'),
('Seafood Boil Full', 120, 50, 'Seafoods', 2.00, 1799.00, 'Available', 'Active'),
('Seafood Boil Half', 60, 25, 'Seafoods', 1.00, 799.00, 'Available', 'Active'),
('Spiny Lobster Medium', 40, 20, 'Seafoods', 1.00, 1400.00, 'Available', 'Active'),
('Spiny Lobster Large', 30, 15, 'Seafoods', 1.00, 1600.00, 'Available', 'Active'),
('Spiny Lobster XL', 20, 10, 'Seafoods', 1.00, 1900.00, 'Available', 'Active'),
('Live Tiger Lobster', 25, 10, 'Live Seafoods', 1.00, 5000.00, 'Available', 'Active'),
('Live Alimango', 35, 15, 'Live Seafoods', 0.4, 2400.00, 'Available', 'Active'),
('Live Lapu Lapu', 40, 20, 'Live Seafoods', 1.00, 1600.00, 'Available', 'Active');

-- Inserting Inventory Daily Record Data
INSERT INTO `inventory_daily_record` (`date`, `inventory_pack_id`, `starting_quantity`, `additional_quantity`, `wasted_quantity`, `ending_quantity`, `total_sales`) VALUES
-- Lemon Chicken
('2024-07-09', 1, 10, 5, 0, 14, 999.00 * (10 + 5 - 14)),
('2024-07-10', 1, 14, 7, 0, 20, 999.00 * (14 + 7 - 20)),
('2024-07-11', 1, 20, 8, 0, 25, 999.00 * (20 + 8 - 25)),
-- 3 Cups Chicken
('2024-07-09', 3, 20, 10, 0, 28, 100.00 * (20 + 10 - 28)),
('2024-07-10', 3, 28, 12, 0, 34, 100.00 * (28 + 12 - 34)),
('2024-07-11', 3, 34, 14, 0, 40, 100.00 * (34 + 14 - 40)),
-- Deep Fried Chicken
('2024-07-09', 4, 30, 15, 0, 42, 500.00 * (30 + 15 - 42)),
('2024-07-10', 4, 42, 16, 0, 52, 500.00 * (42 + 16 - 52)),
('2024-07-11', 4, 52, 17, 0, 65, 500.00 * (52 + 17 - 65)),
-- Half Chicken
('2024-07-09', 5, 40, 20, 0, 56, 250.00 * (40 + 20 - 56)),
('2024-07-10', 5, 56, 22, 0, 65, 250.00 * (56 + 22 - 65)),
('2024-07-11', 5, 65, 24, 0, 80, 250.00 * (65 + 24 - 80)),
-- Sweet&Sour Pork
('2024-07-09', 6, 50, 25, 0, 70, 350.00 * (50 + 25 - 70)),
('2024-07-10', 6, 70, 27, 0, 90, 350.00 * (70 + 27 - 90)),
('2024-07-11', 6, 90, 30, 0, 105, 350.00 * (90 + 30 - 105)),
-- Salt&Pepper Spare Ribs
('2024-07-09', 7, 60, 30, 0, 84, 350.00 * (60 + 30 - 84)),
('2024-07-10', 7, 84, 32, 0, 105, 350.00 * (84 + 32 - 105)),
('2024-07-11', 7, 105, 35, 0, 120, 350.00 * (105 + 35 - 120)),
-- Stir Fry Pork
('2024-07-09', 8, 70, 35, 0, 98, 350.00 * (70 + 35 - 98)),
('2024-07-10', 8, 98, 37, 0, 120, 350.00 * (98 + 37 - 120)),
('2024-07-11', 8, 120, 40, 0, 145, 350.00 * (120 + 40 - 145)),
-- Sisig
('2024-07-09', 9, 80, 40, 0, 112, 280.00 * (80 + 40 - 112)),
('2024-07-10', 9, 112, 42, 0, 140, 280.00 * (112 + 42 - 140)),
('2024-07-11', 9, 140, 45, 0, 170, 280.00 * (140 + 45 - 170)),
-- Steak Bites with Garlic Sauce
('2024-07-09', 10, 90, 45, 0, 126, 390.00 * (90 + 45 - 126)),
('2024-07-10', 10, 126, 47, 0, 165, 390.00 * (126 + 47 - 165)),
('2024-07-11', 10, 165, 50, 0, 200, 390.00 * (165 + 50 - 200)),
-- Bistek Tagalog
('2024-07-09', 11, 100, 50, 0, 140, 390.00 * (100 + 50 - 140)),
('2024-07-10', 11, 140, 52, 0, 185, 390.00 * (140 + 52 - 185)),
('2024-07-11', 11, 185, 55, 0, 220, 390.00 * (185 + 55 - 220)),
-- Beef Stir Fried
('2024-07-09', 12, 110, 55, 0, 154, 390.00 * (110 + 55 - 154)),
('2024-07-10', 12, 154, 57, 0, 200, 390.00 * (154 + 57 - 200)),
('2024-07-11', 12, 200, 60, 0, 248, 390.00 * (200 + 60 - 248));
