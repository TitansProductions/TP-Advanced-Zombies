CREATE TABLE IF NOT EXISTS `tp_user_statistics` (
  `identifier` varchar(46) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deaths` int(11) DEFAULT 0,
  `zombie_kills` int(11) DEFAULT 0,
  PRIMARY KEY (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;