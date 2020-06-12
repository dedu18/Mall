use db_mall;

DROP TABLE if EXISTS `tb_user`;
CREATE TABLE `tb_user` (
	`id` BIGINT (20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
	`username` VARCHAR (100) NOT NULL COMMENT '用户名',
	`password` VARCHAR (100) NOT NULL COMMENT '密码',
	`nackname` VARCHAR (100) NOT NULL DEFAULT '' COMMENT '昵称',
	`phone` VARCHAR (100) NOT NULL COMMENT '手机',
	`email` VARCHAR (100) NOT NULL DEFAULT '' COMMENT '邮箱',
	`create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
	`is_enable` TINYINT (1) NOT NULL DEFAULT '1' COMMENT '是否有效，0为否，1为是',
	`is_delete` TINYINT (1) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
	PRIMARY KEY (`id`)
) ENGINE = INNODB AUTO_INCREMENT = 23 DEFAULT CHARSET = utf8 COMMENT = '用户表';
INSERT INTO `tb_user` (id,username,password,nackname,phone) VALUES (1, 'admin', 'admin', '系统管理员', '13333333333');

DROP TABLE IF EXISTS `tb_user_address`;
CREATE TABLE `tb_user_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` bigint(20) NOT NULL COMMENT '用户主键id',
  `recipient_name` varchar(100) NOT NULL DEFAULT '' COMMENT '收件人名称',
  `province` varchar(100) DEFAULT '' COMMENT '省',
  `city` varchar(100) DEFAULT '' COMMENT '市',
  `area` varchar(100) DEFAULT '' COMMENT '区',
  `address` varchar(200) DEFAULT '' COMMENT '详细地址',
  `phone` varchar(100) NOT NULL COMMENT '手机',
  `postal_code` varchar(100) NOT NULL DEFAULT '' COMMENT '邮编',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效，0为否，1为是',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='用户地址信息表';

-- ----------------------------
-- Table structure for tb_category
-- ----------------------------
DROP TABLE IF EXISTS `tb_category`;
CREATE TABLE `tb_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(32) NOT NULL COMMENT '类目名称',
  `parent_id` bigint(20) NOT NULL COMMENT '父类目id,顶级类目为0',
  `is_parent` tinyint(1) NOT NULL COMMENT '是否为父节点，0为否，1为是',
  `sort` int(4) NULL DEFAULT '1' COMMENT '排序指数，越小越靠前',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效，0为否，1为是',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`id`),
  KEY `key_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品类目表';

INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1, '图书、音像、电子书刊', 0, 1, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (2, '电子书刊', 1, 1, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (3, '电子书', 2, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (4, '网络原创', 2, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (5, '数字杂志', 2, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (6, '多媒体图书', 2, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (7, '音像', 1, 1, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (8, '音乐', 7, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (9, '影视', 7, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (10, '教育音像', 7, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (11, '英文原版', 1, 1, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (12, '少儿', 11, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (13, '商务投资', 11, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (14, '英语学习与考试', 11, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (15, '文学', 11, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (16, '传记', 11, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (17, '励志', 11, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (18, '文艺', 1, 1, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (19, '小说', 18, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (20, '文学', 18, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (21, '青春文学', 18, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (22, '传记', 18, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (23, '艺术', 18, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (24, '少儿', 1, 1, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (25, '少儿', 24, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (26, '0-2岁', 24, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (27, '3-6岁', 24, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (28, '7-10岁', 24, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (29, '11-14岁', 24, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (30, '人文社科', 1, 1, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (31, '历史', 30, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (32, '哲学', 30, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (33, '国学', 30, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (34, '政治/军事', 30, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (35, '法律', 30, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (36, '人文社科', 30, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (37, '心理学', 30, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (38, '文化', 30, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (39, '社会科学', 30, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (40, '经管励志', 1, 1, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (41, '经济', 40, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (42, '金融与投资', 40, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (43, '管理', 40, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (44, '励志与成功', 40, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (45, '生活', 1, 1, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (46, '生活', 45, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (47, '健身与保健', 45, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (48, '家庭与育儿', 45, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (49, '旅游', 45, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (50, '烹饪美食', 45, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (51, '科技', 1, 1, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (52, '工业技术', 51, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (53, '科普读物', 51, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (54, '建筑', 51, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (55, '医学', 51, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (56, '科学与自然', 51, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (57, '计算机与互联网', 51, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (58, '电子通信', 51, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (59, '教育', 1, 1, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (60, '中小学教辅', 59, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (61, '教育与考试', 59, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (62, '外语学习', 59, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (63, '大中专教材', 59, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (64, '字典词典', 59, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (65, '港台图书', 1, 1, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (66, '艺术/设计/收藏', 65, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (67, '经济管理', 65, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (68, '文化/学术', 65, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (69, '少儿', 65, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (70, '其他', 1, 1, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (71, '工具书', 70, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (72, '杂志/期刊', 70, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (73, '套装书', 70, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (74, '手机', 0, 1, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (75, '手机通讯', 74, 1, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (76, '手机', 75, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (77, '对讲机', 75, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (78, '运营商', 74, 1, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (79, '合约机', 78, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (80, '选号中心', 78, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (81, '装宽带', 78, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (82, '办套餐', 78, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (83, '手机配件', 74, 1, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (84, '移动电源', 83, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (85, '电池/移动电源', 83, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (86, '蓝牙耳机', 83, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (87, '充电器/数据线', 83, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (88, '苹果周边', 83, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (89, '手机耳机', 83, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (90, '手机贴膜', 83, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (91, '手机存储卡', 83, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (92, '充电器', 83, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (93, '数据线', 83, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (94, '手机保护套', 83, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (95, '车载配件', 83, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (96, 'iPhone 配件', 83, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (97, '手机电池', 83, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (98, '创意配件', 83, 0, 15);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (99, '便携/无线音响', 83, 0, 16);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (100, '手机饰品', 83, 0, 17);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (101, '拍照配件', 83, 0, 18);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (102, '手机支架', 83, 0, 19);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (103, '家用电器', 0, 1, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (104, '大 家 电', 103, 1, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (105, '平板电视', 104, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (106, '空调', 104, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (107, '冰箱', 104, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (108, '洗衣机', 104, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (109, '家庭影院', 104, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (110, 'DVD/电视盒子', 104, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (111, '迷你音响', 104, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (112, '冷柜/冰吧', 104, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (113, '家电配件', 104, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (114, '功放', 104, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (115, '回音壁/Soundbar', 104, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (116, 'Hi-Fi专区', 104, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (117, '电视盒子', 104, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (118, '酒柜', 104, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (119, '厨卫大电', 103, 1, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (120, '燃气灶', 119, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (121, '油烟机', 119, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (122, '热水器', 119, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (123, '消毒柜', 119, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (124, '洗碗机', 119, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (125, '厨房小电', 103, 1, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (126, '料理机', 125, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (127, '榨汁机', 125, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (128, '电饭煲', 125, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (129, '电压力锅', 125, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (130, '豆浆机', 125, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (131, '咖啡机', 125, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (132, '微波炉', 125, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (133, '电烤箱', 125, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (134, '电磁炉', 125, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (135, '面包机', 125, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (136, '煮蛋器', 125, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (137, '酸奶机', 125, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (138, '电炖锅', 125, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (139, '电水壶/热水瓶', 125, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (140, '电饼铛', 125, 0, 15);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (141, '多用途锅', 125, 0, 16);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (142, '电烧烤炉', 125, 0, 17);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (143, '果蔬解毒机', 125, 0, 18);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (144, '其它厨房电器', 125, 0, 19);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (145, '养生壶/煎药壶', 125, 0, 20);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (146, '电热饭盒', 125, 0, 21);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (147, '生活电器', 103, 1, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (148, '取暖电器', 147, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (149, '净化器', 147, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (150, '加湿器', 147, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (151, '扫地机器人', 147, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (152, '吸尘器', 147, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (153, '挂烫机/熨斗', 147, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (154, '插座', 147, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (155, '电话机', 147, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (156, '清洁机', 147, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (157, '除湿机', 147, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (158, '干衣机', 147, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (159, '收录/音机', 147, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (160, '电风扇', 147, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (161, '冷风扇', 147, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (162, '其它生活电器', 147, 0, 15);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (163, '生活电器配件', 147, 0, 16);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (164, '净水器', 147, 0, 17);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (165, '饮水机', 147, 0, 18);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (166, '个护健康', 103, 1, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (167, '剃须刀', 166, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (168, '剃/脱毛器', 166, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (169, '口腔护理', 166, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (170, '电吹风', 166, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (171, '美容器', 166, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (172, '理发器', 166, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (173, '卷/直发器', 166, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (174, '按摩椅', 166, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (175, '按摩器', 166, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (176, '足浴盆', 166, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (177, '血压计', 166, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (178, '电子秤/厨房秤', 166, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (179, '血糖仪', 166, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (180, '体温计', 166, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (181, '其它健康电器', 166, 0, 15);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (182, '计步器/脂肪检测仪', 166, 0, 16);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (183, '五金家装', 103, 1, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (184, '电动工具', 183, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (185, '手动工具', 183, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (186, '仪器仪表', 183, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (187, '浴霸/排气扇', 183, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (188, '灯具', 183, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (189, 'LED灯', 183, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (190, '洁身器', 183, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (191, '水槽', 183, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (192, '龙头', 183, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (193, '淋浴花洒', 183, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (194, '厨卫五金', 183, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (195, '家具五金', 183, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (196, '门铃', 183, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (197, '电气开关', 183, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (198, '插座', 183, 0, 15);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (199, '电工电料', 183, 0, 16);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (200, '监控安防', 183, 0, 17);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (201, '电线/线缆', 183, 0, 18);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (202, '数码', 0, 1, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (203, '摄影摄像', 202, 1, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (204, '数码相机', 203, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (205, '单电/微单相机', 203, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (206, '单反相机', 203, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (207, '摄像机', 203, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (208, '拍立得', 203, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (209, '运动相机', 203, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (210, '镜头', 203, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (211, '户外器材', 203, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (212, '影棚器材', 203, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (213, '冲印服务', 203, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (214, '数码相框', 203, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (215, '数码配件', 202, 1, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (216, '存储卡', 215, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (217, '读卡器', 215, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (218, '滤镜', 215, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (219, '闪光灯/手柄', 215, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (220, '相机包', 215, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (221, '三脚架/云台', 215, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (222, '相机清洁/贴膜', 215, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (223, '机身附件', 215, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (224, '镜头附件', 215, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (225, '电池/充电器', 215, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (226, '移动电源', 215, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (227, '数码支架', 215, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (228, '智能设备', 202, 1, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (229, '智能手环', 228, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (230, '智能手表', 228, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (231, '智能眼镜', 228, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (232, '运动跟踪器', 228, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (233, '健康监测', 228, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (234, '智能配饰', 228, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (235, '智能家居', 228, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (236, '体感车', 228, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (237, '其他配件', 228, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (238, '智能机器人', 228, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (239, '无人机', 228, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (240, '影音娱乐', 202, 1, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (241, 'MP3/MP4', 240, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (242, '智能设备', 240, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (243, '耳机/耳麦', 240, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (244, '便携/无线音箱', 240, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (245, '音箱/音响', 240, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (246, '高清播放器', 240, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (247, '收音机', 240, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (248, 'MP3/MP4配件', 240, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (249, '麦克风', 240, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (250, '专业音频', 240, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (251, '苹果配件', 240, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (252, '电子教育', 202, 1, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (253, '学生平板', 252, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (254, '点读机/笔', 252, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (255, '早教益智', 252, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (256, '录音笔', 252, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (257, '电纸书', 252, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (258, '电子词典', 252, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (259, '复读机', 252, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (260, '虚拟商品', 202, 1, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (261, '延保服务', 260, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (262, '杀毒软件', 260, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (263, '积分商品', 260, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (264, '家居家装', 0, 1, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (265, '家纺', 264, 1, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (266, '桌布/罩件', 265, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (267, '地毯地垫', 265, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (268, '沙发垫套/椅垫', 265, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (269, '床品套件', 265, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (270, '被子', 265, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (271, '枕芯', 265, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (272, '床单被罩', 265, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (273, '毯子', 265, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (274, '床垫/床褥', 265, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (275, '蚊帐', 265, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (276, '抱枕靠垫', 265, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (277, '毛巾浴巾', 265, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (278, '电热毯', 265, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (279, '窗帘/窗纱', 265, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (280, '布艺软饰', 265, 0, 15);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (281, '凉席', 265, 0, 16);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (282, '灯具', 264, 1, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (283, '台灯', 282, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (284, '节能灯', 282, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (285, '装饰灯', 282, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (286, '落地灯', 282, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (287, '应急灯/手电', 282, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (288, 'LED灯', 282, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (289, '吸顶灯', 282, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (290, '五金电器', 282, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (291, '筒灯射灯', 282, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (292, '吊灯', 282, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (293, '氛围照明', 282, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (294, '生活日用', 264, 1, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (295, '保暖防护', 294, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (296, '收纳用品', 294, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (297, '雨伞雨具', 294, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (298, '浴室用品', 294, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (299, '缝纫/针织用品', 294, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (300, '洗晒/熨烫', 294, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (301, '净化除味', 294, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (302, '家装软饰', 264, 1, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (303, '相框/照片墙', 302, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (304, '装饰字画', 302, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (305, '节庆饰品', 302, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (306, '手工/十字绣', 302, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (307, '装饰摆件', 302, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (308, '帘艺隔断', 302, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (309, '墙贴/装饰贴', 302, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (310, '钟饰', 302, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (311, '花瓶花艺', 302, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (312, '香薰蜡烛', 302, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (313, '创意家居', 302, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (314, '宠物生活', 264, 1, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (315, '宠物主粮', 314, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (316, '宠物零食', 314, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (317, '医疗保健', 314, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (318, '家居日用', 314, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (319, '宠物玩具', 314, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (320, '出行装备', 314, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (321, '洗护美容', 314, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (322, '电脑办公', 0, 1, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (323, '电脑整机', 322, 1, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (324, '笔记本', 323, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (325, '超极本', 323, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (326, '游戏本', 323, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (327, '平板电脑', 323, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (328, '平板电脑配件', 323, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (329, '台式机', 323, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (330, '服务器/工作站', 323, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (331, '笔记本配件', 323, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (332, '一体机', 323, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (333, '电脑配件', 322, 1, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (334, 'CPU', 333, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (335, '主板', 333, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (336, '显卡', 333, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (337, '硬盘', 333, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (338, 'SSD固态硬盘', 333, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (339, '内存', 333, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (340, '机箱', 333, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (341, '电源', 333, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (342, '显示器', 333, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (343, '刻录机/光驱', 333, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (344, '散热器', 333, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (345, '声卡/扩展卡', 333, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (346, '装机配件', 333, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (347, '组装电脑', 333, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (348, '外设产品', 322, 1, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (349, '移动硬盘', 348, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (350, 'U盘', 348, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (351, '鼠标', 348, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (352, '键盘', 348, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (353, '鼠标垫', 348, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (354, '摄像头', 348, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (355, '手写板', 348, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (356, '硬盘盒', 348, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (357, '插座', 348, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (358, '线缆', 348, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (359, 'UPS电源', 348, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (360, '电脑工具', 348, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (361, '游戏设备', 348, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (362, '电玩', 348, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (363, '电脑清洁', 348, 0, 15);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (364, '网络仪表仪器', 348, 0, 16);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (365, '游戏设备', 322, 1, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (366, '游戏机', 365, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (367, '游戏耳机', 365, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (368, '手柄/方向盘', 365, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (369, '游戏软件', 365, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (370, '游戏周边', 365, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (371, '网络产品', 322, 1, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (372, '路由器', 371, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (373, '网卡', 371, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (374, '交换机', 371, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (375, '网络存储', 371, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (376, '4G/3G上网', 371, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (377, '网络盒子', 371, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (378, '网络配件', 371, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (379, '办公设备', 322, 1, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (380, '投影机', 379, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (381, '投影配件', 379, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (382, '多功能一体机', 379, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (383, '打印机', 379, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (384, '传真设备', 379, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (385, '验钞/点钞机', 379, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (386, '扫描设备', 379, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (387, '复合机', 379, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (388, '碎纸机', 379, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (389, '考勤机', 379, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (390, '收款/POS机', 379, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (391, '会议音频视频', 379, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (392, '保险柜', 379, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (393, '装订/封装机', 379, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (394, '安防监控', 379, 0, 15);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (395, '办公家具', 379, 0, 16);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (396, '白板', 379, 0, 17);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (397, '文具/耗材', 322, 1, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (398, '硒鼓/墨粉', 397, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (399, '墨盒', 397, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (400, '色带', 397, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (401, '纸类', 397, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (402, '办公文具', 397, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (403, '学生文具', 397, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (404, '财会用品', 397, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (405, '文件管理', 397, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (406, '本册/便签', 397, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (407, '计算器', 397, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (408, '笔类', 397, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (409, '画具画材', 397, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (410, '刻录碟片/附件', 397, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (411, '服务产品', 322, 1, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (412, '上门安装', 411, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (413, '延保服务', 411, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (414, '维修保养', 411, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (415, '电脑软件', 411, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (416, '京东服务', 411, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (417, '厨具', 0, 1, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (418, '烹饪锅具', 417, 1, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (419, '炒锅', 418, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (420, '煎锅', 418, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (421, '压力锅', 418, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (422, '蒸锅', 418, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (423, '汤锅', 418, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (424, '奶锅', 418, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (425, '锅具套装', 418, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (426, '煲类', 418, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (427, '水壶', 418, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (428, '火锅', 418, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (429, '刀剪菜板', 417, 1, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (430, '菜刀', 429, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (431, '剪刀', 429, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (432, '刀具套装', 429, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (433, '砧板', 429, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (434, '瓜果刀/刨', 429, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (435, '多功能刀', 429, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (436, '厨房配件', 417, 1, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (437, '保鲜盒', 436, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (438, '烘焙/烧烤', 436, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (439, '饭盒/提锅', 436, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (440, '储物/置物架', 436, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (441, '厨房DIY/小工具', 436, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (442, '水具酒具', 417, 1, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (443, '塑料杯', 442, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (444, '运动水壶', 442, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (445, '玻璃杯', 442, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (446, '陶瓷/马克杯', 442, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (447, '保温杯', 442, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (448, '保温壶', 442, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (449, '酒杯/酒具', 442, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (450, '杯具套装', 442, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (451, '餐具', 417, 1, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (452, '餐具套装', 451, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (453, '碗/碟/盘', 451, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (454, '筷勺/刀叉', 451, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (455, '一次性用品', 451, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (456, '果盘/果篮', 451, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (457, '酒店用品', 417, 1, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (458, '自助餐炉', 457, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (459, '酒店餐具', 457, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (460, '酒店水具', 457, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (461, '茶具/咖啡具', 417, 1, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (462, '整套茶具', 461, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (463, '茶杯', 461, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (464, '茶壶', 461, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (465, '茶盘茶托', 461, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (466, '茶叶罐', 461, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (467, '茶具配件', 461, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (468, '茶宠摆件', 461, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (469, '咖啡具', 461, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (470, '其他', 461, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (471, '个护化妆', 0, 1, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (472, '清洁用品', 471, 1, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (473, '纸品湿巾', 472, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (474, '衣物清洁', 472, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (475, '清洁工具', 472, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (476, '驱虫用品', 472, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (477, '家庭清洁', 472, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (478, '皮具护理', 472, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (479, '一次性用品', 472, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (480, '面部护肤', 471, 1, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (481, '洁面', 480, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (482, '乳液面霜', 480, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (483, '面膜', 480, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (484, '剃须', 480, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (485, '套装', 480, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (486, '精华', 480, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (487, '眼霜', 480, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (488, '卸妆', 480, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (489, '防晒', 480, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (490, '防晒隔离', 480, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (491, 'T区护理', 480, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (492, '眼部护理', 480, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (493, '精华露', 480, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (494, '爽肤水', 480, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (495, '身体护理', 471, 1, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (496, '沐浴', 495, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (497, '润肤', 495, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (498, '颈部', 495, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (499, '手足', 495, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (500, '纤体塑形', 495, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (501, '美胸', 495, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (502, '套装', 495, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (503, '精油', 495, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (504, '洗发护发', 495, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (505, '染发/造型', 495, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (506, '香薰精油', 495, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (507, '磨砂/浴盐', 495, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (508, '手工/香皂', 495, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (509, '洗发', 495, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (510, '护发', 495, 0, 15);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (511, '染发', 495, 0, 16);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (512, '磨砂膏', 495, 0, 17);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (513, '香皂', 495, 0, 18);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (514, '口腔护理', 471, 1, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (515, '牙膏/牙粉', 514, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (516, '牙刷/牙线', 514, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (517, '漱口水', 514, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (518, '套装', 514, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (519, '女性护理', 471, 1, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (520, '卫生巾', 519, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (521, '卫生护垫', 519, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (522, '私密护理', 519, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (523, '脱毛膏', 519, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (524, '其他', 519, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (525, '洗发护发', 471, 1, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (526, '洗发', 525, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (527, '护发', 525, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (528, '染发', 525, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (529, '造型', 525, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (530, '假发', 525, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (531, '套装', 525, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (532, '美发工具', 525, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (533, '脸部护理', 525, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (534, '香水彩妆', 471, 1, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (535, '香水', 534, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (536, '底妆', 534, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (537, '腮红', 534, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (538, '眼影', 534, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (539, '唇部', 534, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (540, '美甲', 534, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (541, '眼线', 534, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (542, '美妆工具', 534, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (543, '套装', 534, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (544, '防晒隔离', 534, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (545, '卸妆', 534, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (546, '眉笔', 534, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (547, '睫毛膏', 534, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (548, '服饰内衣', 0, 1, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (549, '女装', 548, 1, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (550, 'T恤', 549, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (551, '衬衫', 549, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (552, '针织衫', 549, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (553, '雪纺衫', 549, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (554, '卫衣', 549, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (555, '马甲', 549, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (556, '连衣裙', 549, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (557, '半身裙', 549, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (558, '牛仔裤', 549, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (559, '休闲裤', 549, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (560, '打底裤', 549, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (561, '正装裤', 549, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (562, '小西装', 549, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (563, '短外套', 549, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (564, '风衣', 549, 0, 15);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (565, '毛呢大衣', 549, 0, 16);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (566, '真皮皮衣', 549, 0, 17);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (567, '棉服', 549, 0, 18);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (568, '羽绒服', 549, 0, 19);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (569, '大码女装', 549, 0, 20);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (570, '中老年女装', 549, 0, 21);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (571, '婚纱', 549, 0, 22);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (572, '打底衫', 549, 0, 23);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (573, '旗袍/唐装', 549, 0, 24);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (574, '加绒裤', 549, 0, 25);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (575, '吊带/背心', 549, 0, 26);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (576, '羊绒衫', 549, 0, 27);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (577, '短裤', 549, 0, 28);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (578, '皮草', 549, 0, 29);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (579, '礼服', 549, 0, 30);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (580, '仿皮皮衣', 549, 0, 31);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (581, '羊毛衫', 549, 0, 32);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (582, '设计师/潮牌', 549, 0, 33);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (583, '男装', 548, 1, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (584, '衬衫', 583, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (585, 'T恤', 583, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (586, 'POLO衫', 583, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (587, '针织衫', 583, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (588, '羊绒衫', 583, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (589, '卫衣', 583, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (590, '马甲/背心', 583, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (591, '夹克', 583, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (592, '风衣', 583, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (593, '毛呢大衣', 583, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (594, '仿皮皮衣', 583, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (595, '西服', 583, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (596, '棉服', 583, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (597, '羽绒服', 583, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (598, '牛仔裤', 583, 0, 15);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (599, '休闲裤', 583, 0, 16);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (600, '西裤', 583, 0, 17);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (601, '西服套装', 583, 0, 18);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (602, '大码男装', 583, 0, 19);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (603, '中老年男装', 583, 0, 20);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (604, '唐装/中山装', 583, 0, 21);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (605, '工装', 583, 0, 22);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (606, '真皮皮衣', 583, 0, 23);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (607, '加绒裤', 583, 0, 24);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (608, '卫裤/运动裤', 583, 0, 25);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (609, '短裤', 583, 0, 26);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (610, '设计师/潮牌', 583, 0, 27);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (611, '羊毛衫', 583, 0, 28);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (612, '内衣', 548, 1, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (613, '文胸', 612, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (614, '女式内裤', 612, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (615, '男式内裤', 612, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (616, '睡衣/家居服', 612, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (617, '塑身美体', 612, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (618, '泳衣', 612, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (619, '吊带/背心', 612, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (620, '抹胸', 612, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (621, '连裤袜/丝袜', 612, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (622, '美腿袜', 612, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (623, '商务男袜', 612, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (624, '保暖内衣', 612, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (625, '情侣睡衣', 612, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (626, '文胸套装', 612, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (627, '少女文胸', 612, 0, 15);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (628, '休闲棉袜', 612, 0, 16);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (629, '大码内衣', 612, 0, 17);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (630, '内衣配件', 612, 0, 18);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (631, '打底裤袜', 612, 0, 19);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (632, '打底衫', 612, 0, 20);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (633, '秋衣秋裤', 612, 0, 21);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (634, '情趣内衣', 612, 0, 22);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (635, '洗衣服务', 548, 1, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (636, '服装洗护', 635, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (637, '服饰配件', 548, 1, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (638, '太阳镜', 637, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (639, '光学镜架/镜片', 637, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (640, '围巾/手套/帽子套装', 637, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (641, '袖扣', 637, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (642, '棒球帽', 637, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (643, '毛线帽', 637, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (644, '遮阳帽', 637, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (645, '老花镜', 637, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (646, '装饰眼镜', 637, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (647, '防辐射眼镜', 637, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (648, '游泳镜', 637, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (649, '女士丝巾/围巾/披肩', 637, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (650, '男士丝巾/围巾', 637, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (651, '鸭舌帽', 637, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (652, '贝雷帽', 637, 0, 15);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (653, '礼帽', 637, 0, 16);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (654, '真皮手套', 637, 0, 17);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (655, '毛线手套', 637, 0, 18);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (656, '防晒手套', 637, 0, 19);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (657, '男士腰带/礼盒', 637, 0, 20);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (658, '女士腰带/礼盒', 637, 0, 21);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (659, '钥匙扣', 637, 0, 22);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (660, '遮阳伞/雨伞', 637, 0, 23);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (661, '口罩', 637, 0, 24);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (662, '耳罩/耳包', 637, 0, 25);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (663, '假领', 637, 0, 26);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (664, '毛线/布面料', 637, 0, 27);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (665, '领带/领结/领带夹', 637, 0, 28);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (666, '钟表', 0, 1, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (667, '钟表', 666, 1, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (668, '男表', 667, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (669, '瑞表', 667, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (670, '女表', 667, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (671, '国表', 667, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (672, '日韩表', 667, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (673, '欧美表', 667, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (674, '德表', 667, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (675, '儿童手表', 667, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (676, '智能手表', 667, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (677, '闹钟', 667, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (678, '座钟挂钟', 667, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (679, '钟表配件', 667, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (680, '鞋靴', 0, 1, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (681, '流行男鞋', 680, 1, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (682, '商务休闲鞋', 681, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (683, '正装鞋', 681, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (684, '休闲鞋', 681, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (685, '凉鞋/沙滩鞋', 681, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (686, '男靴', 681, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (687, '功能鞋', 681, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (688, '拖鞋/人字拖', 681, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (689, '雨鞋/雨靴', 681, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (690, '传统布鞋', 681, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (691, '鞋配件', 681, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (692, '帆布鞋', 681, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (693, '增高鞋', 681, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (694, '工装鞋', 681, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (695, '定制鞋', 681, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (696, '时尚女鞋', 680, 1, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (697, '高跟鞋', 696, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (698, '单鞋', 696, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (699, '休闲鞋', 696, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (700, '凉鞋', 696, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (701, '女靴', 696, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (702, '雪地靴', 696, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (703, '拖鞋/人字拖', 696, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (704, '踝靴', 696, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (705, '筒靴', 696, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (706, '帆布鞋', 696, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (707, '雨鞋/雨靴', 696, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (708, '妈妈鞋', 696, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (709, '鞋配件', 696, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (710, '特色鞋', 696, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (711, '鱼嘴鞋', 696, 0, 15);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (712, '布鞋/绣花鞋', 696, 0, 16);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (713, '马丁靴', 696, 0, 17);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (714, '坡跟鞋', 696, 0, 18);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (715, '松糕鞋', 696, 0, 19);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (716, '内增高', 696, 0, 20);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (717, '防水台', 696, 0, 21);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (718, '母婴', 0, 1, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (719, '奶粉', 718, 1, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (720, '婴幼奶粉', 719, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (721, '孕妈奶粉', 719, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (722, '营养辅食', 718, 1, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (723, '益生菌/初乳', 722, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (724, '米粉/菜粉', 722, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (725, '果泥/果汁', 722, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (726, 'DHA', 722, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (727, '宝宝零食', 722, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (728, '钙铁锌/维生素', 722, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (729, '清火/开胃', 722, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (730, '面条/粥', 722, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (731, '尿裤湿巾', 718, 1, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (732, '婴儿尿裤', 731, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (733, '拉拉裤', 731, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (734, '婴儿湿巾', 731, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (735, '成人尿裤', 731, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (736, '喂养用品', 718, 1, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (737, '奶瓶奶嘴', 736, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (738, '吸奶器', 736, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (739, '暖奶消毒', 736, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (740, '儿童餐具', 736, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (741, '水壶/水杯', 736, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (742, '牙胶安抚', 736, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (743, '围兜/防溅衣', 736, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (744, '辅食料理机', 736, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (745, '食物存储', 736, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (746, '洗护用品', 718, 1, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (747, '宝宝护肤', 746, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (748, '洗发沐浴', 746, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (749, '奶瓶清洗', 746, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (750, '驱蚊防晒', 746, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (751, '理发器', 746, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (752, '洗澡用具', 746, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (753, '婴儿口腔清洁', 746, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (754, '洗衣液/皂', 746, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (755, '日常护理', 746, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (756, '座便器', 746, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (757, '童车童床', 718, 1, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (758, '婴儿推车', 757, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (759, '餐椅摇椅', 757, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (760, '婴儿床', 757, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (761, '学步车', 757, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (762, '三轮车', 757, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (763, '自行车', 757, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (764, '电动车', 757, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (765, '扭扭车', 757, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (766, '滑板车', 757, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (767, '婴儿床垫', 757, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (768, '寝居服饰', 718, 1, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (769, '婴儿外出服', 768, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (770, '婴儿内衣', 768, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (771, '婴儿礼盒', 768, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (772, '婴儿鞋帽袜', 768, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (773, '安全防护', 768, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (774, '家居床品', 768, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (775, '睡袋/抱被', 768, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (776, '爬行垫', 768, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (777, '妈妈专区', 718, 1, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (778, '妈咪包/背婴带', 777, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (779, '产后塑身', 777, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (780, '文胸/内裤', 777, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (781, '防辐射服', 777, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (782, '孕妈装', 777, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (783, '孕期营养', 777, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (784, '孕妇护肤', 777, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (785, '待产护理', 777, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (786, '月子装', 777, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (787, '防溢乳垫', 777, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (788, '童装童鞋', 718, 1, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (789, '套装', 788, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (790, '上衣', 788, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (791, '裤子', 788, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (792, '裙子', 788, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (793, '内衣/家居服', 788, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (794, '羽绒服/棉服', 788, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (795, '亲子装', 788, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (796, '儿童配饰', 788, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (797, '礼服/演出服', 788, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (798, '运动鞋', 788, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (799, '皮鞋/帆布鞋', 788, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (800, '靴子', 788, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (801, '凉鞋', 788, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (802, '功能鞋', 788, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (803, '户外/运动服', 788, 0, 15);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (804, '安全座椅', 718, 1, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (805, '提篮式', 804, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (806, '安全座椅', 804, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (807, '增高垫', 804, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (808, '礼品箱包', 0, 1, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (809, '潮流女包', 808, 1, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (810, '钱包', 809, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (811, '手拿包', 809, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (812, '单肩包', 809, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (813, '双肩包', 809, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (814, '手提包', 809, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (815, '斜挎包', 809, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (816, '钥匙包', 809, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (817, '卡包/零钱包', 809, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (818, '精品男包', 808, 1, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (819, '男士钱包', 818, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (820, '男士手包', 818, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (821, '卡包名片夹', 818, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (822, '商务公文包', 818, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (823, '双肩包', 818, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (824, '单肩/斜挎包', 818, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (825, '钥匙包', 818, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (826, '功能箱包', 808, 1, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (827, '电脑包', 826, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (828, '拉杆箱', 826, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (829, '旅行包', 826, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (830, '旅行配件', 826, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (831, '休闲运动包', 826, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (832, '拉杆包', 826, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (833, '登山包', 826, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (834, '妈咪包', 826, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (835, '书包', 826, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (836, '相机包', 826, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (837, '腰包/胸包', 826, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (838, '礼品', 808, 1, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (839, '火机烟具', 838, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (840, '礼品文具', 838, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (841, '军刀军具', 838, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (842, '收藏品', 838, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (843, '工艺礼品', 838, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (844, '创意礼品', 838, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (845, '礼盒礼券', 838, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (846, '鲜花绿植', 838, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (847, '婚庆节庆', 838, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (848, '京东卡', 838, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (849, '美妆礼品', 838, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (850, '礼品定制', 838, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (851, '京东福卡', 838, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (852, '古董文玩', 838, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (853, '奢侈品', 808, 1, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (854, '箱包', 853, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (855, '钱包', 853, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (856, '服饰', 853, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (857, '腰带', 853, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (858, '太阳镜/眼镜框', 853, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (859, '配件', 853, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (860, '鞋靴', 853, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (861, '饰品', 853, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (862, '名品腕表', 853, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (863, '高档化妆品', 853, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (864, '婚庆', 808, 1, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (865, '婚嫁首饰', 864, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (866, '婚纱摄影', 864, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (867, '婚纱礼服', 864, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (868, '婚庆服务', 864, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (869, '婚庆礼品/用品', 864, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (870, '婚宴', 864, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (871, '食品饮料、保健食品', 0, 1, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (872, '进口食品', 871, 1, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (873, '饼干蛋糕', 872, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (874, '糖果/巧克力', 872, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (875, '休闲零食', 872, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (876, '冲调饮品', 872, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (877, '粮油调味', 872, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (878, '牛奶', 872, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (879, '地方特产', 871, 1, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (880, '其他特产', 879, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (881, '新疆', 879, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (882, '北京', 879, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (883, '山西', 879, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (884, '内蒙古', 879, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (885, '福建', 879, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (886, '湖南', 879, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (887, '四川', 879, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (888, '云南', 879, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (889, '东北', 879, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (890, '休闲食品', 871, 1, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (891, '休闲零食', 890, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (892, '坚果炒货', 890, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (893, '肉干肉脯', 890, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (894, '蜜饯果干', 890, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (895, '糖果/巧克力', 890, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (896, '饼干蛋糕', 890, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (897, '无糖食品', 890, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (898, '粮油调味', 871, 1, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (899, '米面杂粮', 898, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (900, '食用油', 898, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (901, '调味品', 898, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (902, '南北干货', 898, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (903, '方便食品', 898, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (904, '有机食品', 898, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (905, '饮料冲调', 871, 1, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (906, '饮用水', 905, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (907, '饮料', 905, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (908, '牛奶乳品', 905, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (909, '咖啡/奶茶', 905, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (910, '冲饮谷物', 905, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (911, '蜂蜜/柚子茶', 905, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (912, '成人奶粉', 905, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (913, '食品礼券', 871, 1, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (914, '月饼', 913, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (915, '大闸蟹', 913, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (916, '粽子', 913, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (917, '卡券', 913, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (918, '茗茶', 871, 1, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (919, '铁观音', 918, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (920, '普洱', 918, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (921, '龙井', 918, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (922, '绿茶', 918, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (923, '红茶', 918, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (924, '乌龙茶', 918, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (925, '花草茶', 918, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (926, '花果茶', 918, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (927, '养生茶', 918, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (928, '黑茶', 918, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (929, '白茶', 918, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (930, '其它茶', 918, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (931, '珠宝', 0, 1, 15);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (932, '时尚饰品', 931, 1, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (933, '项链', 932, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (934, '手链/脚链', 932, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (935, '戒指', 932, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (936, '耳饰', 932, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (937, '毛衣链', 932, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (938, '发饰/发卡', 932, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (939, '胸针', 932, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (940, '饰品配件', 932, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (941, '婚庆饰品', 932, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (942, '黄金', 931, 1, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (943, '黄金吊坠', 942, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (944, '黄金项链', 942, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (945, '黄金转运珠', 942, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (946, '黄金手镯/手链/脚链', 942, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (947, '黄金耳饰', 942, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (948, '黄金戒指', 942, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (949, 'K金饰品', 931, 1, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (950, 'K金吊坠', 949, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (951, 'K金项链', 949, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (952, 'K金手镯/手链/脚链', 949, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (953, 'K金戒指', 949, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (954, 'K金耳饰', 949, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (955, '金银投资', 931, 1, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (956, '投资金', 955, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (957, '投资银', 955, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (958, '投资收藏', 955, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (959, '银饰', 931, 1, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (960, '银吊坠/项链', 959, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (961, '银手镯/手链/脚链', 959, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (962, '银戒指', 959, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (963, '银耳饰', 959, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (964, '足银手镯', 959, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (965, '宝宝银饰', 959, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (966, '钻石', 931, 1, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (967, '裸钻', 966, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (968, '钻戒', 966, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (969, '钻石项链/吊坠', 966, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (970, '钻石耳饰', 966, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (971, '钻石手镯/手链', 966, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (972, '翡翠玉石', 931, 1, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (973, '项链/吊坠', 972, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (974, '手镯/手串', 972, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (975, '戒指', 972, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (976, '耳饰', 972, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (977, '挂件/摆件/把件', 972, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (978, '玉石孤品', 972, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (979, '水晶玛瑙', 931, 1, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (980, '项链/吊坠', 979, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (981, '耳饰', 979, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (982, '手镯/手链/脚链', 979, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (983, '戒指', 979, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (984, '头饰/胸针', 979, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (985, '摆件/挂件', 979, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (986, '彩宝', 931, 1, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (987, '琥珀/蜜蜡', 986, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (988, '碧玺', 986, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (989, '红宝石/蓝宝石', 986, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (990, '坦桑石', 986, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (991, '珊瑚', 986, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (992, '祖母绿', 986, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (993, '葡萄石', 986, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (994, '其他天然宝石', 986, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (995, '项链/吊坠', 986, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (996, '耳饰', 986, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (997, '手镯/手链', 986, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (998, '戒指', 986, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (999, '铂金', 931, 1, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1000, '铂金项链/吊坠', 999, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1001, '铂金手镯/手链/脚链', 999, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1002, '铂金戒指', 999, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1003, '铂金耳饰', 999, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1004, '木手串/把件', 931, 1, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1005, '小叶紫檀', 1004, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1006, '黄花梨', 1004, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1007, '沉香木', 1004, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1008, '金丝楠', 1004, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1009, '菩提', 1004, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1010, '其他', 1004, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1011, '橄榄核/核桃', 1004, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1012, '檀香', 1004, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1013, '珍珠', 931, 1, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1014, '珍珠项链', 1013, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1015, '珍珠吊坠', 1013, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1016, '珍珠耳饰', 1013, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1017, '珍珠手链', 1013, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1018, '珍珠戒指', 1013, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1019, '珍珠胸针', 1013, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1020, '汽车用品', 0, 1, 16);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1021, '维修保养', 1020, 1, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1022, '机油', 1021, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1023, '正时皮带', 1021, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1024, '添加剂', 1021, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1025, '汽车喇叭', 1021, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1026, '防冻液', 1021, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1027, '汽车玻璃', 1021, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1028, '滤清器', 1021, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1029, '火花塞', 1021, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1030, '减震器', 1021, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1031, '柴机油/辅助油', 1021, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1032, '雨刷', 1021, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1033, '车灯', 1021, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1034, '后视镜', 1021, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1035, '轮胎', 1021, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1036, '轮毂', 1021, 0, 15);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1037, '刹车片/盘', 1021, 0, 16);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1038, '维修配件', 1021, 0, 17);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1039, '蓄电池', 1021, 0, 18);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1040, '底盘装甲/护板', 1021, 0, 19);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1041, '贴膜', 1021, 0, 20);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1042, '汽修工具', 1021, 0, 21);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1043, '改装配件', 1021, 0, 22);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1044, '车载电器', 1020, 1, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1045, '导航仪', 1044, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1046, '安全预警仪', 1044, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1047, '行车记录仪', 1044, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1048, '倒车雷达', 1044, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1049, '蓝牙设备', 1044, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1050, '车载影音', 1044, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1051, '净化器', 1044, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1052, '电源', 1044, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1053, '智能驾驶', 1044, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1054, '车载电台', 1044, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1055, '车载电器配件', 1044, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1056, '吸尘器', 1044, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1057, '智能车机', 1044, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1058, '冰箱', 1044, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1059, '汽车音响', 1044, 0, 15);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1060, '车载生活电器', 1044, 0, 16);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1061, '美容清洗', 1020, 1, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1062, '车蜡', 1061, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1063, '补漆笔', 1061, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1064, '玻璃水', 1061, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1065, '清洁剂', 1061, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1066, '洗车工具', 1061, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1067, '镀晶镀膜', 1061, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1068, '打蜡机', 1061, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1069, '洗车配件', 1061, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1070, '洗车机', 1061, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1071, '洗车水枪', 1061, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1072, '毛巾掸子', 1061, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1073, '汽车装饰', 1020, 1, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1074, '脚垫', 1073, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1075, '座垫', 1073, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1076, '座套', 1073, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1077, '后备箱垫', 1073, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1078, '头枕腰靠', 1073, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1079, '方向盘套', 1073, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1080, '香水', 1073, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1081, '空气净化', 1073, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1082, '挂件摆件', 1073, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1083, '功能小件', 1073, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1084, '车身装饰件', 1073, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1085, '车衣', 1073, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1086, '安全自驾', 1020, 1, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1087, '安全座椅', 1086, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1088, '胎压监测', 1086, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1089, '防盗设备', 1086, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1090, '应急救援', 1086, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1091, '保温箱', 1086, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1092, '地锁', 1086, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1093, '摩托车', 1086, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1094, '充气泵', 1086, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1095, '储物箱', 1086, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1096, '自驾野营', 1086, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1097, '摩托车装备', 1086, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1098, '汽车服务', 1020, 1, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1099, '清洗美容', 1098, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1100, '功能升级', 1098, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1101, '保养维修', 1098, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1102, '油卡充值', 1098, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1103, '车险', 1098, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1104, '加油卡', 1098, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1105, 'ETC', 1098, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1106, '驾驶培训', 1098, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1107, '赛事改装', 1020, 1, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1108, '赛事服装', 1107, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1109, '赛事用品', 1107, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1110, '制动系统', 1107, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1111, '悬挂系统', 1107, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1112, '进气系统', 1107, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1113, '排气系统', 1107, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1114, '电子管理', 1107, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1115, '车身强化', 1107, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1116, '赛事座椅', 1107, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1117, '运动健康', 0, 1, 17);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1118, '运动鞋包', 1117, 1, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1119, '跑步鞋', 1118, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1120, '休闲鞋', 1118, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1121, '篮球鞋', 1118, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1122, '板鞋', 1118, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1123, '帆布鞋', 1118, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1124, '足球鞋', 1118, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1125, '乒羽网鞋', 1118, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1126, '专项运动鞋', 1118, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1127, '训练鞋', 1118, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1128, '拖鞋', 1118, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1129, '运动包', 1118, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1130, '运动服饰', 1117, 1, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1131, '羽绒服', 1130, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1132, '棉服', 1130, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1133, '运动裤', 1130, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1134, '夹克/风衣', 1130, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1135, '卫衣/套头衫', 1130, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1136, 'T恤', 1130, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1137, '套装', 1130, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1138, '乒羽网服', 1130, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1139, '健身服', 1130, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1140, '运动背心', 1130, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1141, '毛衫/线衫', 1130, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1142, '运动配饰', 1130, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1143, '骑行运动', 1117, 1, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1144, '折叠车', 1143, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1145, '山地车/公路车', 1143, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1146, '电动车', 1143, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1147, '其他整车', 1143, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1148, '骑行服', 1143, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1149, '骑行装备', 1143, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1150, '平衡车', 1143, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1151, '垂钓用品', 1117, 1, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1152, '鱼竿鱼线', 1151, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1153, '浮漂鱼饵', 1151, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1154, '钓鱼桌椅', 1151, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1155, '钓鱼配件', 1151, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1156, '钓箱鱼包', 1151, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1157, '其它', 1151, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1158, '游泳用品', 1117, 1, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1159, '泳镜', 1158, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1160, '泳帽', 1158, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1161, '游泳包防水包', 1158, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1162, '女士泳衣', 1158, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1163, '男士泳衣', 1158, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1164, '比基尼', 1158, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1165, '其它', 1158, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1166, '户外鞋服', 1117, 1, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1167, '冲锋衣裤', 1166, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1168, '速干衣裤', 1166, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1169, '滑雪服', 1166, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1170, '羽绒服/棉服', 1166, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1171, '休闲衣裤', 1166, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1172, '抓绒衣裤', 1166, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1173, '软壳衣裤', 1166, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1174, 'T恤', 1166, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1175, '户外风衣', 1166, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1176, '功能内衣', 1166, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1177, '军迷服饰', 1166, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1178, '登山鞋', 1166, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1179, '雪地靴', 1166, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1180, '徒步鞋', 1166, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1181, '越野跑鞋', 1166, 0, 15);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1182, '休闲鞋', 1166, 0, 16);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1183, '工装鞋', 1166, 0, 17);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1184, '溯溪鞋', 1166, 0, 18);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1185, '沙滩/凉拖', 1166, 0, 19);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1186, '户外袜', 1166, 0, 20);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1187, '户外装备', 1117, 1, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1188, '帐篷/垫子', 1187, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1189, '睡袋/吊床', 1187, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1190, '登山攀岩', 1187, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1191, '户外配饰', 1187, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1192, '背包', 1187, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1193, '户外照明', 1187, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1194, '户外仪表', 1187, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1195, '户外工具', 1187, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1196, '望远镜', 1187, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1197, '旅游用品', 1187, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1198, '便携桌椅床', 1187, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1199, '野餐烧烤', 1187, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1200, '军迷用品', 1187, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1201, '救援装备', 1187, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1202, '滑雪装备', 1187, 0, 15);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1203, '极限户外', 1187, 0, 16);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1204, '冲浪潜水', 1187, 0, 17);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1205, '健身训练', 1117, 1, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1206, '综合训练器', 1205, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1207, '其他大型器械', 1205, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1208, '哑铃', 1205, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1209, '仰卧板/收腹机', 1205, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1210, '其他中小型器材', 1205, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1211, '瑜伽舞蹈', 1205, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1212, '甩脂机', 1205, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1213, '踏步机', 1205, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1214, '武术搏击', 1205, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1215, '健身车/动感单车', 1205, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1216, '跑步机', 1205, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1217, '运动护具', 1205, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1218, '体育用品', 1117, 1, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1219, '羽毛球', 1218, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1220, '乒乓球', 1218, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1221, '篮球', 1218, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1222, '足球', 1218, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1223, '网球', 1218, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1224, '排球', 1218, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1225, '高尔夫', 1218, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1226, '台球', 1218, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1227, '棋牌麻将', 1218, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1228, '轮滑滑板', 1218, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1229, '其他', 1218, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1230, '玩具乐器', 0, 1, 18);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1231, '适用年龄', 1230, 1, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1232, '0-6个月', 1231, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1233, '6-12个月', 1231, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1234, '1-3岁', 1231, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1235, '3-6岁', 1231, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1236, '6-14岁', 1231, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1237, '14岁以上', 1231, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1238, '遥控/电动', 1230, 1, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1239, '遥控车', 1238, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1240, '遥控飞机', 1238, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1241, '遥控船', 1238, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1242, '机器人', 1238, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1243, '轨道/助力', 1238, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1244, '毛绒布艺', 1230, 1, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1245, '毛绒/布艺', 1244, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1246, '靠垫/抱枕', 1244, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1247, '娃娃玩具', 1230, 1, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1248, '芭比娃娃', 1247, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1249, '卡通娃娃', 1247, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1250, '智能娃娃', 1247, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1251, '模型玩具', 1230, 1, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1252, '仿真模型', 1251, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1253, '拼插模型', 1251, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1254, '收藏爱好', 1251, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1255, '健身玩具', 1230, 1, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1256, '炫舞毯', 1255, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1257, '爬行垫/毯', 1255, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1258, '户外玩具', 1255, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1259, '戏水玩具', 1255, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1260, '动漫玩具', 1230, 1, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1261, '电影周边', 1260, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1262, '卡通周边', 1260, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1263, '网游周边', 1260, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1264, '益智玩具', 1230, 1, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1265, '摇铃/床铃', 1264, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1266, '健身架', 1264, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1267, '早教启智', 1264, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1268, '拖拉玩具', 1264, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1269, '积木拼插', 1230, 1, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1270, '积木', 1269, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1271, '拼图', 1269, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1272, '磁力棒', 1269, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1273, '立体拼插', 1269, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1274, 'DIY玩具', 1230, 1, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1275, '手工彩泥', 1274, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1276, '绘画工具', 1274, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1277, '情景玩具', 1274, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1278, '创意减压', 1230, 1, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1279, '减压玩具', 1278, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1280, '创意玩具', 1278, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1281, '乐器', 1230, 1, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1282, '钢琴', 1281, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1283, '电子琴/电钢琴', 1281, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1284, '吉他/尤克里里', 1281, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1285, '打击乐器', 1281, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1286, '西洋管弦', 1281, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1287, '民族管弦乐器', 1281, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1288, '乐器配件', 1281, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1289, '电脑音乐', 1281, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1290, '工艺礼品乐器', 1281, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1291, '口琴/口风琴/竖笛', 1281, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1292, '手风琴', 1281, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1293, '彩票、旅行、充值、票务', 0, 1, 19);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1294, '彩票', 1293, 1, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1295, '双色球', 1294, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1296, '大乐透', 1294, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1297, '福彩3D', 1294, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1298, '排列三', 1294, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1299, '排列五', 1294, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1300, '七星彩', 1294, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1301, '七乐彩', 1294, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1302, '竞彩足球', 1294, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1303, '竞彩篮球', 1294, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1304, '新时时彩', 1294, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1305, '机票', 1293, 1, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1306, '国内机票', 1305, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1307, '酒店', 1293, 1, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1308, '国内酒店', 1307, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1309, '酒店团购', 1307, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1310, '旅行', 1293, 1, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1311, '度假', 1310, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1312, '景点', 1310, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1313, '租车', 1310, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1314, '火车票', 1310, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1315, '旅游团购', 1310, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1316, '充值', 1293, 1, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1317, '手机充值', 1316, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1318, '游戏', 1293, 1, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1319, '游戏点卡', 1318, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1320, 'QQ充值', 1318, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1321, '票务', 1293, 1, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1322, '电影票', 1321, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1323, '演唱会', 1321, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1324, '话剧歌剧', 1321, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1325, '音乐会', 1321, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1326, '体育赛事', 1321, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1327, '舞蹈芭蕾', 1321, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1328, '戏曲综艺', 1321, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1329, '生鲜', 0, 1, 20);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1330, '产地直供', 1329, 1, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1331, '东北', 1330, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1332, '华北', 1330, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1333, '西北', 1330, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1334, '华中', 1330, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1335, '华东', 1330, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1336, '华南', 1330, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1337, '西南', 1330, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1338, '水果', 1329, 1, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1339, '苹果', 1338, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1340, '橙子', 1338, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1341, '奇异果/猕猴桃', 1338, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1342, '车厘子/樱桃', 1338, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1343, '芒果', 1338, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1344, '蓝莓', 1338, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1345, '火龙果', 1338, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1346, '葡萄/提子', 1338, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1347, '柚子', 1338, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1348, '香蕉', 1338, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1349, '牛油果', 1338, 0, 11);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1350, '梨', 1338, 0, 12);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1351, '菠萝/凤梨', 1338, 0, 13);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1352, '桔/橘', 1338, 0, 14);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1353, '柠檬', 1338, 0, 15);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1354, '草莓', 1338, 0, 16);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1355, '桃/李/杏', 1338, 0, 17);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1356, '更多水果', 1338, 0, 18);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1357, '水果礼盒/券', 1338, 0, 19);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1358, '猪牛羊肉', 1329, 1, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1359, '牛肉', 1358, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1360, '羊肉', 1358, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1361, '猪肉', 1358, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1362, '内脏类', 1358, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1363, '海鲜水产', 1329, 1, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1364, '鱼类', 1363, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1365, '虾类', 1363, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1366, '蟹类', 1363, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1367, '贝类', 1363, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1368, '海参', 1363, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1369, '海产干货', 1363, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1370, '其他水产', 1363, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1371, '海产礼盒', 1363, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1372, '禽肉蛋品', 1329, 1, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1373, '鸡肉', 1372, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1374, '鸭肉', 1372, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1375, '蛋类', 1372, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1376, '其他禽类', 1372, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1377, '冷冻食品', 1329, 1, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1378, '水饺/馄饨', 1377, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1379, '汤圆/元宵', 1377, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1380, '面点', 1377, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1381, '火锅丸串', 1377, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1382, '速冻半成品', 1377, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1383, '奶酪黄油', 1377, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1384, '熟食腊味', 1329, 1, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1385, '熟食', 1384, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1386, '腊肠/腊肉', 1384, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1387, '火腿', 1384, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1388, '糕点', 1384, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1389, '礼品卡券', 1384, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1390, '饮品甜品', 1329, 1, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1391, '冷藏果蔬汁', 1390, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1392, '冰激凌', 1390, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1393, '其他', 1390, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1394, '蔬菜', 1329, 1, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1395, '叶菜类', 1394, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1396, '茄果瓜类', 1394, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1397, '根茎类', 1394, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1398, '鲜菌菇', 1394, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1399, '葱姜蒜椒', 1394, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1400, '半加工蔬菜', 1394, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1401, '整车', 0, 1, 21);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1402, '全新整车', 1401, 1, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1403, '微型车', 1402, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1404, '小型车', 1402, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1405, '紧凑型车', 1402, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1406, '中型车', 1402, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1407, '中大型车', 1402, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1408, '豪华车', 1402, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1409, 'MPV', 1402, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1410, 'SUV', 1402, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1411, '跑车', 1402, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1412, '二手车', 1401, 1, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1413, '微型车（二手）', 1412, 0, 1);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1414, '小型车（二手）', 1412, 0, 2);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1415, '紧凑型车（二手）', 1412, 0, 3);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1416, '中型车（二手）', 1412, 0, 4);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1417, '中大型车（二手）', 1412, 0, 5);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1418, '豪华车（二手）', 1412, 0, 6);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1419, 'MPV（二手）', 1412, 0, 7);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1420, 'SUV（二手）', 1412, 0, 8);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1421, '跑车（二手）', 1412, 0, 9);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1422, '皮卡（二手）', 1412, 0, 10);
INSERT INTO `tb_category` (id,name,parent_id,is_parent,sort) VALUES (1423, '面包车（二手）', 1412, 0, 11);


-- ----------------------------
-- Table structure for tb_brand
-- ----------------------------
DROP TABLE IF EXISTS `tb_brand`;
CREATE TABLE `tb_brand` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(32) NOT NULL COMMENT '品牌名称',
  `image` varchar(128) DEFAULT '' COMMENT '品牌图片URL地址',
  `letter` char(1) DEFAULT '' COMMENT '品牌首字母',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效，0为否，1为是',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='品牌表';

INSERT INTO `tb_brand`(id,name,image,letter,is_enable,is_delete) VALUES (null, '华为（HUAWEI）', 'http://img10.360buyimg.com/popshop/jfs/t5662/36/8888655583/7806/1c629c01/598033b4Nd6055897.jpg', 'H', 1, 0);
INSERT INTO `tb_brand`(id,name,image,letter,is_enable,is_delete) VALUES (null, 'Apple', 'http://img12.360buyimg.com/popshop/jfs/t2989/240/151377693/3895/30ad9044/574d36dbN262ef26d.jpg', 'A', 1, 0);
INSERT INTO `tb_brand`(id,name,image,letter,is_enable,is_delete) VALUES (null, '小米（MI）', 'http://img10.360buyimg.com/popshop/jfs/t7084/169/439244907/4647/724c7958/598042c9N6e4e79e5.jpg', 'X', 1, 0);
INSERT INTO `tb_brand`(id,name,image,letter,is_enable,is_delete) VALUES (null, '一加', 'http://img14.360buyimg.com/popshop/jfs/t2398/233/975959106/6263/a786f5b8/563b33ffN9c288c6c.jpg', 'Y', 1, 0);
INSERT INTO `tb_brand`(id,name,image,letter,is_enable,is_delete) VALUES (null, '锤子（smartisan）', 'http://img13.360buyimg.com/popshop/jfs/t1954/102/907711365/5487/9f26868f/5631ccdeNe8df5efb.jpg', 'C', 1, 0);
INSERT INTO `tb_brand`(id,name,image,letter,is_enable,is_delete) VALUES (null, '海尔（Haier）', 'http://image.leyou.com/group1/M00/00/00/wKhSZFufmLeAektLAAAZT9-WCLY396.jpg', 'H', 1, 0);
INSERT INTO `tb_brand`(id,name,image,letter,is_enable,is_delete) VALUES (null, '海信（Hisense）', '', 'H', 1, 0);
INSERT INTO `tb_brand`(id,name,image,letter,is_enable,is_delete) VALUES (null, '黑莓（BlackBerry）', '', 'H', 1, 0);
INSERT INTO `tb_brand`(id,name,image,letter,is_enable,is_delete) VALUES (null, '华硕（ASUS）', '', 'H', 1, 0);


-- ----------------------------
-- Table structure for tb_category_brand
-- ----------------------------
DROP TABLE IF EXISTS `tb_category_brand`;
CREATE TABLE `tb_category_brand` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `category_id` bigint(20) NOT NULL COMMENT '商品类目id',
  `brand_id` bigint(20) NOT NULL COMMENT '品牌id',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效，0为否，1为是',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`id`),
  KEY `idx_catid_brandid` (`category_id`,`brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品分类和品牌的关联表';


-- ----------------------------
-- Table structure for tb_specification_group
-- ----------------------------
DROP TABLE IF EXISTS `tb_specification_group`;
CREATE TABLE `tb_specification_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '规格组主键id',
  `name` varchar(32) NOT NULL COMMENT '规格组名称',
  `category_id` bigint(20) NOT NULL COMMENT '商品类目主键id',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效，0为否，1为是',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`id`),
  KEY `idx_category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='规格分组表，每个商品类目对应多个规格参数组';

-- ----------------------------
-- Records of tb_specification_group
-- ----------------------------
INSERT INTO `tb_specification_group` VALUES ('1', '主体', '74', '2019-09-19 17:40:30', '2019-09-19 17:40:30', '1', '0');
INSERT INTO `tb_specification_group` VALUES ('2', '基本信息', '74', '2019-09-19 18:10:06', '2019-09-19 18:10:06', '1', '0');


-- ----------------------------
-- Table structure for tb_specification
-- ----------------------------
DROP TABLE IF EXISTS `tb_specification`;
CREATE TABLE `tb_specification` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(32) NOT NULL COMMENT '规格属性名称',
  `searchable` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否可搜索，0为否，1为是',
  `global` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否类目全局属性，0为否，1为是',
  `group_id` bigint(20) NOT NULL COMMENT '规格分组主键id',
  `group_name` varchar(32) NOT NULL COMMENT '规格组名称',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效，0为否，1为是',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='规格属性名表';

-- ----------------------------
-- Records of tb_specification
-- ----------------------------
INSERT INTO `tb_specification` VALUES ('1', '入网型号', '0', '1', '1', '主体', '2019-09-19 17:44:22', '2019-09-19 17:44:22', '1', '0');
INSERT INTO `tb_specification` VALUES ('2', '产品名称', '0', '1', '1', '主体', '2019-09-19 17:44:43', '2019-09-19 17:44:43', '1', '0');
INSERT INTO `tb_specification` VALUES ('3', '机身颜色', '0', '1', '2', '基本信息', '2019-09-19 18:10:54', '2019-09-19 18:10:54', '1', '0');
INSERT INTO `tb_specification` VALUES ('4', '机身长度', '0', '1', '2', '基本信息', '2019-09-19 18:11:29', '2019-09-19 18:11:29', '1', '0');


-- ----------------------------
-- Table structure for tb_specification_value
-- ----------------------------
DROP TABLE IF EXISTS `tb_specification_value`;
CREATE TABLE `tb_specification_value` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `specification_id` bigint(20) NOT NULL COMMENT '规格属性名主键id',
  `specification_name` varchar(32) NOT NULL COMMENT '规格属性名称',
  `value` varchar(32) NULL COMMENT '规格属性值',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效，0为否，1为是',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='规格属性值表';

-- ----------------------------
-- Table structure for tb_spu
-- ----------------------------
DROP TABLE IF EXISTS `tb_spu`;
CREATE TABLE `tb_spu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '标题',
  `sub_title` varchar(256) DEFAULT '' COMMENT '子标题',
  `categoty_ids` bigint(20) NOT NULL COMMENT '-分隔的类目id',
  `categoty_names` bigint(20) NOT NULL COMMENT '-分隔的类目名称',
  `brand_id` bigint(20) NOT NULL COMMENT '品牌id',
  `saleable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否上架，0下架，1上架',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效，0为否，1为是',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='spu表';

-- ----------------------------
-- Table structure for tb_spu_detail
-- ----------------------------
DROP TABLE IF EXISTS `tb_spu_detail`;
CREATE TABLE `tb_spu_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `spu_id` bigint(20) NOT NULL COMMENT 'spu主键id',
  `description` text COMMENT '商品描述信息',
  `packing_list` varchar(1024) DEFAULT '' COMMENT '包装清单',
  `after_service` varchar(1024) DEFAULT '' COMMENT '售后服务',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效，0为否，1为是',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`id`),
  KEY `idx_spu_id` (`spu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='spu其他详情表';

-- ----------------------------
-- Table structure for tb_sku
-- ----------------------------
DROP TABLE IF EXISTS `tb_sku`;
CREATE TABLE `tb_sku` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `spu_id` bigint(20) NOT NULL COMMENT 'spu主键id',
  `title` varchar(256) NOT NULL COMMENT '商品标题',
  `images` varchar(1024) DEFAULT '' COMMENT ',分隔的商品图片链接',
  `price` decimal(13,2) DEFAULT NULL COMMENT '销售价格，单位为分',
  `specs` varchar(32) DEFAULT '' COMMENT ',分隔的销售属性',
  `spec_values` varchar(255) DEFAULT NULL COMMENT ',分隔的销售属性值',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效，0为否，1为是',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`id`),
  KEY `idx_spu_id` (`spu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='sku表';

-- ----------------------------
-- Table structure for tb_stock
-- ----------------------------
DROP TABLE IF EXISTS `tb_stock`;
CREATE TABLE `tb_stock` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `sku_id` bigint(20) NOT NULL COMMENT 'sku主键id',
  `seckill_stock` int(9) DEFAULT '0' COMMENT '可秒杀库存',
  `seckill_total` int(9) DEFAULT '0' COMMENT '秒杀总数量',
  `stock` int(9) NOT NULL COMMENT '库存数量',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效，0为否，1为是',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`id`),
  KEY `idx_sku_id` (`sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='库存表';



-- ----------------------------
-- Table structure for tb_order
-- ----------------------------
DROP TABLE IF EXISTS `tb_order`;
CREATE TABLE `tb_order` (
  `id` bigint(20) NOT NULL COMMENT '订单id',
  `total_price` decimal(13,2) NOT NULL COMMENT '商品总金额 单位：分',
  `buyer_id` varchar(32) NOT NULL COMMENT '用户id',
  `sku_id` bigint(20) NOT NULL COMMENT '商品skuId',
  `num` int(11) NOT NULL COMMENT '购买数量',
  `title` varchar(256) NOT NULL COMMENT '商品标题',
   `source_type` int(1) DEFAULT '2' COMMENT '订单来源：1:app端，2：pc端，3：微信端',
  `logistics_name` varchar(20) DEFAULT NULL COMMENT '物流名称',
  `logistics_code` varchar(20) DEFAULT NULL COMMENT '物流单号',
  `receiver_state` varchar(128) DEFAULT NULL COMMENT '收获地址（省）',
  `receiver_city` varchar(256) DEFAULT NULL COMMENT '收获地址（市）',
  `receiver_district` varchar(256) DEFAULT NULL COMMENT '收获地址（区/县）',
  `receiver_address` varchar(256) DEFAULT NULL COMMENT '收获地址（街道、住址等详细地址）',
  `receiver_mobile` varchar(11) DEFAULT NULL COMMENT '收货人手机',
  `receiver_postcode` varchar(16) DEFAULT NULL COMMENT '收货人邮编',
  `receiver_name` varchar(32) DEFAULT NULL COMMENT '收货人',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '订单创建时间',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '订单更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单基本信息表';


-- ----------------------------
-- Table structure for tb_order_status
-- ----------------------------
DROP TABLE IF EXISTS `tb_order_status`;
CREATE TABLE `tb_order_status` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id ',
  `order_id` bigint(20) NOT NULL COMMENT '订单id',
  `status` int(1) DEFAULT NULL COMMENT '状态：1、未付款 2、已付款,未发货 3、已发货,未确认 4、交易成功 5、交易关闭 6、已评价',
  `consign_time` TIMESTAMP NULL COMMENT '发货时间',
  `end_time` TIMESTAMP NULL COMMENT '交易完成时间',
  `close_time` TIMESTAMP NULL COMMENT '交易关闭时间',
  `comment_time` TIMESTAMP NULL COMMENT '评价时间',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '状态更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_orderId_status` (`order_id`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单状态表';


-- ----------------------------
-- Table structure for tb_pay
-- ----------------------------
DROP TABLE IF EXISTS `tb_pay`;
CREATE TABLE `tb_pay` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id ',
  `order_id` bigint(20) NOT NULL COMMENT '订单号',
  `total_pay` decimal(13,2) NOT NULL COMMENT '支付金额（分）',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `wechat_paycode` varchar(32) DEFAULT NULL COMMENT '微信交易号码',
  `status` tinyint(1) NOT NULL COMMENT '交易状态，1 未支付, 2已支付, 3 已退款, 4 支付错误, 5 已关闭',
  `pay_type` tinyint(1) DEFAULT 0 COMMENT '支付方式：0 未知, 1 微信支付, 2 支付宝支付',
  `pay_time` TIMESTAMP NULL COMMENT '支付时间',
  `closed_time` TIMESTAMP NULL COMMENT '关闭时间',
  `refund_time` TIMESTAMP NULL COMMENT '退款时间',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '支付订单创建时间',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '支付订单更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_orderId_status` (`order_id`, `status`),
  KEY `idx_userId` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单支付表';