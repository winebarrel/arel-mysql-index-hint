# original: https://github.com/railstutorial/sample_app_rails_4

DROP DATABASE IF EXISTS `arel_mysql_index_hint_test`;
CREATE DATABASE `arel_mysql_index_hint_test` DEFAULT CHARSET=utf8;

USE `arel_mysql_index_hint_test`;

DROP TABLE IF EXISTS `microposts`;
CREATE TABLE `microposts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_microposts_on_user_id_and_created_at` (`user_id`,`created_at`)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `relationships`;
CREATE TABLE `relationships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `follower_id` int(11) DEFAULT NULL,
  `followed_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_relationships_on_follower_id_and_followed_id` (`follower_id`,`followed_id`),
  KEY `index_relationships_on_followed_id` (`followed_id`),
  KEY `index_relationships_on_follower_id` (`follower_id`)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `password_digest` varchar(255) DEFAULT NULL,
  `remember_token` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  KEY `index_users_on_remember_token` (`remember_token`)
) DEFAULT CHARSET=utf8;
