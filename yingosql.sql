CREATE DATABASE yingo;

USE yingo;

CREATE TABLE `user` (
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

CREATE TABLE `product` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `category_id` INT,
  `name` VARCHAR(255),
  `description` TEXT,
  `product_pic` VARCHAR(255),
  `price` DECIMAL(10,2),
  `visible` BOOLEAN,
  FOREIGN KEY (`category_id`) REFERENCES `category`(`id`)
);

