CREATE DATABASE yingo;

USE yingo;

CREATE TABLE `admin` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `username` VARCHAR(255),
  `nickname` VARCHAR(255),
  `email` VARCHAR(255),
  `password` VARCHAR(255),
  `rol` INT,
  `user_pic` VARCHAR(255)
);

CREATE TABLE `category` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `category_name` VARCHAR(255),
  `category_alias` VARCHAR(255)
);

CREATE TABLE `file_data` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(255),
  `file_path` VARCHAR(255),
  `type` VARCHAR(255)
);

CREATE TABLE `product` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `category_id` INT,
  `name` VARCHAR(255),
  `description` TEXT,
  `product_pic` VARCHAR(255),
  `price` DECIMAL(10,2),
  `visible` BOOLEAN,
  `stock` INT,
  FOREIGN KEY (`category_id`) REFERENCES `category`(`id`)
);

CREATE TABLE `user` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `username` VARCHAR(255) UNIQUE NOT NULL,
    `nickname` VARCHAR(255),
    `email` VARCHAR(255) UNIQUE NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `userPic` VARCHAR(255),
    `gender` CHAR(1),
    `birthdate` DATE,
    `address` VARCHAR(255),
    `phone` VARCHAR(20),
    `money` DECIMAL(10,2)
);


CREATE TABLE `cart` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `user_id` INT,
  `created_at` DATETIME,
  `total` DECIMAL(10,2),
  FOREIGN KEY (`user_id`) REFERENCES `user`(`id`)
);

CREATE TABLE `cart_item` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `cart_id` INT,
  `product_id` INT,
  `quantity` INT,
  `price` DECIMAL(10,2),
  FOREIGN KEY (`cart_id`) REFERENCES `cart`(`id`),
  FOREIGN KEY (`product_id`) REFERENCES `product`(`id`)
);

CREATE TABLE `order` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `user_id` INT,
  `created_at` DATETIME,
  `total` DECIMAL(10,2),
  `status` VARCHAR(255),
  FOREIGN KEY (`user_id`) REFERENCES `user`(`id`)
);

CREATE TABLE `order_item` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `order_id` INT,
  `product_id` INT,
  `quantity` INT,
  `price` DECIMAL(10,2),
  FOREIGN KEY (`order_id`) REFERENCES `order`(`id`),
  FOREIGN KEY (`product_id`) REFERENCES `product`(`id`)
);

CREATE TABLE `offer` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `product_id` INT,
  `discount` DECIMAL(10,2),
  `quantity` INT,
  `price` DECIMAL(10,2),
  FOREIGN KEY (`product_id`) REFERENCES `product`(`id`)
);
/*
INSERT INTO `admin` (`usearname`, `nickname`, `email`, `password`, `rol`, `user_pic`) VALUES
('admin', 'admin', 'admin', 'admin', 1001, 'admin.png');

INSERT INTO `user` (`username`, `nickname`, `email`, `password`, `userPic`, `gender`, `birthdate`, `address`, `phone`, `money`) VALUES
('user', 'user', 'user', 'user', 'user.png', 'M', '2000-01-01', 'user', 'user', 0.00);

INSERT INTO `category` (`category_name`, `category_alias`) VALUES
('Category 1', 'category-1'),
('Category 2', 'category-2'),
('Category 3', 'category-3'),
('Category 4', 'category-4'),
('Category 5', 'category-5');

INSERT INTO `product` (`category_id`, `name`, `description`, `product_pic`, `price`, `visible`) VALUES
(1, 'Product 1', 'Product 1 description', 'product-1.png', 10.00, 1),
(2, 'Product 2', 'Product 2 description', 'product-2.png', 20.00, 1),
(3, 'Product 3', 'Product 3 description', 'product-3.png', 30.00, 1),
(4, 'Product 4', 'Product 4 description', 'product-4.png', 40.00, 1),
(5, 'Product 5', 'Product 5 description', 'product-5.png', 50.00, 1);*/
