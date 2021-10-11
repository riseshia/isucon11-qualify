DROP TABLE IF EXISTS `isu_association_config`;
DROP TABLE IF EXISTS `isu_condition`;
DROP TABLE IF EXISTS `isu_trend`;
DROP TABLE IF EXISTS `isu`;
DROP TABLE IF EXISTS `user`;

CREATE TABLE `isu` (
  `id` bigint AUTO_INCREMENT,
  `jia_isu_uuid` CHAR(36) NOT NULL UNIQUE,
  `name` VARCHAR(255) NOT NULL,
  `image` LONGBLOB,
  `character` VARCHAR(255),
  `jia_user_id` VARCHAR(255) NOT NULL,
  `created_at` DATETIME(6) DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` DATETIME(6) DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
   PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;

CREATE TABLE `isu_condition` (
  `id` bigint,
  `jia_isu_uuid` CHAR(36) NOT NULL,
  `timestamp` DATETIME NOT NULL,
  `is_sitting` TINYINT(1) NOT NULL,
  `condition` VARCHAR(255) NOT NULL,
  `message` VARCHAR(255) NOT NULL,
  `created_at` DATETIME(6) DEFAULT CURRENT_TIMESTAMP(6),
   PRIMARY KEY(`jia_isu_uuid`, `timestamp`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;

CREATE TABLE `user` (
  `jia_user_id` VARCHAR(255) PRIMARY KEY,
  `created_at` DATETIME(6) DEFAULT CURRENT_TIMESTAMP(6)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;

CREATE TABLE `isu_association_config` (
  `name` VARCHAR(255) PRIMARY KEY,
  `url` VARCHAR(255) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;

CREATE TABLE `isu_trend` (
  `id` bigint AUTO_INCREMENT,
  `jia_isu_uuid` CHAR(36) NOT NULL UNIQUE,
  `timestamp` DATETIME NOT NULL,
  `is_sitting` TINYINT(1) NOT NULL,
  `condition` VARCHAR(255) NOT NULL,
  `message` VARCHAR(255) NOT NULL,
  PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;

ALTER TABLE isu ADD INDEX idx_uid_uuid_name(jia_user_id, jia_isu_uuid, name);
ALTER TABLE isu ADD INDEX idx_uuid_id(jia_user_id, id);

alter table isu_condition
PARTITION BY RANGE COLUMNS(jia_isu_uuid) (
  PARTITION p0 VALUES LESS THAN ('2'),
  PARTITION p1 VALUES LESS THAN ('4'),
  PARTITION p2 VALUES LESS THAN ('6'),
  PARTITION p3 VALUES LESS THAN ('8'),
  PARTITION p4 VALUES LESS THAN ('a'),
  PARTITION p5 VALUES LESS THAN ('c'),
  PARTITION p6 VALUES LESS THAN ('e'),
  PARTITION p7 VALUES LESS THAN ('g')
);
