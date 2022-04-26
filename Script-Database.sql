SET NAMES utf8mb4;

-- SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for Cap Danh Muc
-- ----------------------------
DROP TABLE IF EXISTS `big_category`;
CREATE TABLE `big_category` (
  `BigCatID` int unsigned NOT NULL AUTO_INCREMENT,
  `BigCatName` nvarchar(50) COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`BigCatID`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Table structure for Danh Muc
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `CatID` int unsigned NOT NULL AUTO_INCREMENT,
  `CatName` nvarchar(50) COLLATE utf8_general_ci NOT NULL,
  `BigCat` int unsigned NOT NULL, 
  PRIMARY KEY (`CatID`),
  FOREIGN KEY (`BigCat`) REFERENCES big_category(`BigCatID`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `Username` varchar(50) COLLATE utf8_general_ci NOT NULL,
  `Password` varchar(255) COLLATE utf8_general_ci NOT NULL,
  `Name` varchar(50) COLLATE utf8_general_ci NOT NULL,
  `Address` nvarchar(80) COLLATE utf8_general_ci NOT NULL,
  `Number` varchar(11) COLLATE utf8_general_ci NOT NULL,
  `Type` char(1) NOT NULL,
  PRIMARY KEY (`Username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `ProID` int unsigned NOT NULL AUTO_INCREMENT,
  `CatID` int unsigned NOT NULL,
  `ProName` nvarchar(200) COLLATE utf8_general_ci NOT NULL,
  `Price` int unsigned NOT NULL,
  `LinkURL` char(200) NOT NULL,
  `Stock` int unsigned NOT NULL,
  `ProState` bit NOT NULL, 
  `Description` text COLLATE utf8_general_ci NOT NULL,
  
  PRIMARY KEY (`ProID`),
  FOREIGN KEY (`CatID`) REFERENCES category(`CatID`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Gio hang
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `User` char(50) COLLATE utf8_general_ci NOT NULL,
  `ProID` int unsigned NOT NULL,
  `Stock` int NOT NULL,
  `Date` datetime NOT NULL,

  PRIMARY KEY (`ProID`,`User`),
  FOREIGN KEY (`ProID`) REFERENCES product(`ProID`),
  FOREIGN KEY (`User`) REFERENCES user(`Username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Don dat hang
-- pending 1, 2 approved, 3  shipping, 4 success, 5 canceled
-- ----------------------------
DROP TABLE IF EXISTS `order_list`;
CREATE TABLE `order_list` (
  `OrderID` int unsigned NOT NULL AUTO_INCREMENT,
  `User` char(50) COLLATE utf8_general_ci NOT NULL,
  `Date` datetime NOT NULL,
  `State` int unsigned NOT NULL, 
  PRIMARY KEY (`OrderID`),
  FOREIGN KEY (`User`) REFERENCES user(`Username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Chi tiet don dat hang
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail` (
  `OrderID` int unsigned NOT NULL,
  `ProID` int unsigned NOT NULL,
  `Stock` int unsigned NOT NULL,
  PRIMARY KEY (`OrderID`,`ProID`),
  FOREIGN KEY (`OrderID`) REFERENCES order_list(`OrderID`),
  FOREIGN KEY (`ProID`) REFERENCES product(`ProID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Insert Data

-- ----------------------------
-- Records of Danh Muc
-- ----------------------------
BEGIN;
INSERT INTO `big_category` VALUES (1, 'RAM');
INSERT INTO `big_category` VALUES (2, 'SSD');
INSERT INTO `big_category` VALUES (3, 'CPU');
COMMIT;

-- ----------------------------
-- Records of Danh Muc
-- ----------------------------
BEGIN;
INSERT INTO `category` VALUES (1, 'Hynix',1);
INSERT INTO `category` VALUES (2, 'Crucial',1);
INSERT INTO `category` VALUES (3, 'Samsung',2);
INSERT INTO `category` VALUES (4, 'Intel',2);
INSERT INTO `category` VALUES (5, 'Intel',3);
INSERT INTO `category` VALUES (6, 'AMD',3);
COMMIT;

-- User (1) - Admin (2)
-- ----------------------------
-- Records of User
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES ('minhan2022','$2a$10$Aq.r.RZmDExi19OZkzKqW.7BrhuVHL8nYWVh7vtHCiS/MeM55wIOG','Minh An','155 Nguyễn Chí Thanh, Phường 9, Quận 5, TP.HCM','0933442606','1');
COMMIT;

-- ----------------------------
-- Records of Admin
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES ('admin2','$2a$10$Aq.r.RZmDExi19OZkzKqW.7BrhuVHL8nYWVh7vtHCiS/MeM55wIOG','Minh An','150 Nguyễn Chí Thanh, Phường 9, Quận 5, TP.HCM','0933442602','2');
COMMIT;


-- ----------------------------
-- Records of Product
-- ----------------------------
BEGIN;

-- Ring
INSERT INTO `product` VALUES (1,1,'Ram Laptop DDR3L Hynix 4GB Bus 1600 SODIMM PC3L-12800',400000,'https://res.cloudinary.com/macomp/image/upload/v1650960624/macomp/N8ee3Qh_qzckqy.jpg',100,1,'<div><p>Nếu như bạn vừa mới mua cho mình một thiết bị máy tính xách tay thế hệ mới, nhưng cảm thấy dung lượng ram hiện tại sẵn có trên máy tính quá thấp, không thể đáp ứng được nhu cầu học tập, làm việc của bạn? Thì bạn cần phải nâng cấp sản phẩm RAM Laptop Samsung 8GB DDR4 3200 cho máy tính của mình để máy có thể hoạt động mượt mà hơn.</p><p>Một số ưu điểm nổi bât của RAM Laptop DDR4 Samsung 8GB Bus 3200 M471A1K43DB1-CWE</p><p><em><strong>Tốc độ cực cao:</strong></em> Sản phẩm này<strong> </strong>được thiết kế với xung bus cực lớn lên đến 3200MHz, nhờ đó các tác vụ xử lý dữ liệu diễn ra trên máy tính của bạn đều được xử lý vô cùng nhanh chóng.</p><p><em><strong>Dung lượng lớn:</strong></em> Hỗ trợ bộ nhớ tối đa lên tới 8GB, tuy không quá nhiều nhưng đối với người dùng bình thường thì mình tin rằng đây là một mức dung lượng vô cùng lý tưởng.</p><p><em><strong>Điện năng tiêu thụ cực thấp: </strong></em>Với mức điện áp yêu cầu chỉ 1.2V, điều này giúp giảm thiểu lượng điện năng tiêu thụ của máy tính và cho phép máy tính của bạn có thể sử dụng được trong thời gian dài hơn.</p></div>');
INSERT INTO `product` VALUES (2,1,'RAM Laptop DDR5 Hynix 32GB Bus 4800 HMCG88MEBSA092N',7200000,'https://res.cloudinary.com/macomp/image/upload/v1650960992/macomp/RAM-Laptop-DDR5-Hynix-32GB-Bus-4800-HMCG88MEBSA092N-hinh-anh-1_nyrmpt.jpg',100,1,'<div><p>Nếu như bạn vừa mới mua cho mình một thiết bị máy tính xách tay thế hệ mới, nhưng cảm thấy dung lượng ram hiện tại sẵn có trên máy tính quá thấp, không thể đáp ứng được nhu cầu học tập, làm việc của bạn? Thì bạn cần phải nâng cấp sản phẩm RAM Laptop Samsung 8GB DDR4 3200 cho máy tính của mình để máy có thể hoạt động mượt mà hơn.</p><p>Một số ưu điểm nổi bât của RAM Laptop DDR4 Samsung 8GB Bus 3200 M471A1K43DB1-CWE</p><p><em><strong>Tốc độ cực cao:</strong></em> Sản phẩm này<strong> </strong>được thiết kế với xung bus cực lớn lên đến 3200MHz, nhờ đó các tác vụ xử lý dữ liệu diễn ra trên máy tính của bạn đều được xử lý vô cùng nhanh chóng.</p><p><em><strong>Dung lượng lớn:</strong></em> Hỗ trợ bộ nhớ tối đa lên tới 8GB, tuy không quá nhiều nhưng đối với người dùng bình thường thì mình tin rằng đây là một mức dung lượng vô cùng lý tưởng.</p><p><em><strong>Điện năng tiêu thụ cực thấp: </strong></em>Với mức điện áp yêu cầu chỉ 1.2V, điều này giúp giảm thiểu lượng điện năng tiêu thụ của máy tính và cho phép máy tính của bạn có thể sử dụng được trong thời gian dài hơn.</p></div>');
INSERT INTO `product` VALUES (3,1,'RAM PC DDR5 Hynix 8GB Bus 4800 HMCG66MEBUA081N',1880000,'https://res.cloudinary.com/macomp/image/upload/v1650961028/macomp/3_j2sdd6_jizt2p.jpg',100,1,'<div><p>Nếu như bạn vừa mới mua cho mình một thiết bị máy tính xách tay thế hệ mới, nhưng cảm thấy dung lượng ram hiện tại sẵn có trên máy tính quá thấp, không thể đáp ứng được nhu cầu học tập, làm việc của bạn? Thì bạn cần phải nâng cấp sản phẩm RAM Laptop Samsung 8GB DDR4 3200 cho máy tính của mình để máy có thể hoạt động mượt mà hơn.</p><p>Một số ưu điểm nổi bât của RAM Laptop DDR4 Samsung 8GB Bus 3200 M471A1K43DB1-CWE</p><p><em><strong>Tốc độ cực cao:</strong></em> Sản phẩm này<strong> </strong>được thiết kế với xung bus cực lớn lên đến 3200MHz, nhờ đó các tác vụ xử lý dữ liệu diễn ra trên máy tính của bạn đều được xử lý vô cùng nhanh chóng.</p><p><em><strong>Dung lượng lớn:</strong></em> Hỗ trợ bộ nhớ tối đa lên tới 8GB, tuy không quá nhiều nhưng đối với người dùng bình thường thì mình tin rằng đây là một mức dung lượng vô cùng lý tưởng.</p><p><em><strong>Điện năng tiêu thụ cực thấp: </strong></em>Với mức điện áp yêu cầu chỉ 1.2V, điều này giúp giảm thiểu lượng điện năng tiêu thụ của máy tính và cho phép máy tính của bạn có thể sử dụng được trong thời gian dài hơn.</p></div>');
INSERT INTO `product` VALUES (4,1,'RAM Hynix 8GB DDR3L 1600MHz ECC Registered',700000,'https://res.cloudinary.com/macomp/image/upload/v1650961028/macomp/3_j2sdd6_jizt2p.jpg',100,1,'<div><p>Nếu như bạn vừa mới mua cho mình một thiết bị máy tính xách tay thế hệ mới, nhưng cảm thấy dung lượng ram hiện tại sẵn có trên máy tính quá thấp, không thể đáp ứng được nhu cầu học tập, làm việc của bạn? Thì bạn cần phải nâng cấp sản phẩm RAM Laptop Samsung 8GB DDR4 3200 cho máy tính của mình để máy có thể hoạt động mượt mà hơn.</p><p>Một số ưu điểm nổi bât của RAM Laptop DDR4 Samsung 8GB Bus 3200 M471A1K43DB1-CWE</p><p><em><strong>Tốc độ cực cao:</strong></em> Sản phẩm này<strong> </strong>được thiết kế với xung bus cực lớn lên đến 3200MHz, nhờ đó các tác vụ xử lý dữ liệu diễn ra trên máy tính của bạn đều được xử lý vô cùng nhanh chóng.</p><p><em><strong>Dung lượng lớn:</strong></em> Hỗ trợ bộ nhớ tối đa lên tới 8GB, tuy không quá nhiều nhưng đối với người dùng bình thường thì mình tin rằng đây là một mức dung lượng vô cùng lý tưởng.</p><p><em><strong>Điện năng tiêu thụ cực thấp: </strong></em>Với mức điện áp yêu cầu chỉ 1.2V, điều này giúp giảm thiểu lượng điện năng tiêu thụ của máy tính và cho phép máy tính của bạn có thể sử dụng được trong thời gian dài hơn.</p></div>');
INSERT INTO `product` VALUES (5,1,'RAM PC DDR5 Hynix 16GB Bus 4800 HMCG78MEBUA081N',3800000,'https://res.cloudinary.com/macomp/image/upload/v1650961045/macomp/5_obad0i_i33j30.png',100,1,'<div><p>Nếu như bạn vừa mới mua cho mình một thiết bị máy tính xách tay thế hệ mới, nhưng cảm thấy dung lượng ram hiện tại sẵn có trên máy tính quá thấp, không thể đáp ứng được nhu cầu học tập, làm việc của bạn? Thì bạn cần phải nâng cấp sản phẩm RAM Laptop Samsung 8GB DDR4 3200 cho máy tính của mình để máy có thể hoạt động mượt mà hơn.</p><p>Một số ưu điểm nổi bât của RAM Laptop DDR4 Samsung 8GB Bus 3200 M471A1K43DB1-CWE</p><p><em><strong>Tốc độ cực cao:</strong></em> Sản phẩm này<strong> </strong>được thiết kế với xung bus cực lớn lên đến 3200MHz, nhờ đó các tác vụ xử lý dữ liệu diễn ra trên máy tính của bạn đều được xử lý vô cùng nhanh chóng.</p><p><em><strong>Dung lượng lớn:</strong></em> Hỗ trợ bộ nhớ tối đa lên tới 8GB, tuy không quá nhiều nhưng đối với người dùng bình thường thì mình tin rằng đây là một mức dung lượng vô cùng lý tưởng.</p><p><em><strong>Điện năng tiêu thụ cực thấp: </strong></em>Với mức điện áp yêu cầu chỉ 1.2V, điều này giúp giảm thiểu lượng điện năng tiêu thụ của máy tính và cho phép máy tính của bạn có thể sử dụng được trong thời gian dài hơn.</p></div>');

INSERT INTO `product` VALUES (6,2,'RAM PC DDR5 Crucial 32GB Bus 4800 CT32G48C40U5',7200000,'https://res.cloudinary.com/macomp/image/upload/v1650961078/macomp/6_oet69m_sjfux4.jpg',100,1,'<div><p>Nếu như bạn vừa mới mua cho mình một thiết bị máy tính xách tay thế hệ mới, nhưng cảm thấy dung lượng ram hiện tại sẵn có trên máy tính quá thấp, không thể đáp ứng được nhu cầu học tập, làm việc của bạn? Thì bạn cần phải nâng cấp sản phẩm RAM Laptop Samsung 8GB DDR4 3200 cho máy tính của mình để máy có thể hoạt động mượt mà hơn.</p><p>Một số ưu điểm nổi bât của RAM Laptop DDR4 Samsung 8GB Bus 3200 M471A1K43DB1-CWE</p><p><em><strong>Tốc độ cực cao:</strong></em> Sản phẩm này<strong> </strong>được thiết kế với xung bus cực lớn lên đến 3200MHz, nhờ đó các tác vụ xử lý dữ liệu diễn ra trên máy tính của bạn đều được xử lý vô cùng nhanh chóng.</p><p><em><strong>Dung lượng lớn:</strong></em> Hỗ trợ bộ nhớ tối đa lên tới 8GB, tuy không quá nhiều nhưng đối với người dùng bình thường thì mình tin rằng đây là một mức dung lượng vô cùng lý tưởng.</p><p><em><strong>Điện năng tiêu thụ cực thấp: </strong></em>Với mức điện áp yêu cầu chỉ 1.2V, điều này giúp giảm thiểu lượng điện năng tiêu thụ của máy tính và cho phép máy tính của bạn có thể sử dụng được trong thời gian dài hơn.</p></div>');
INSERT INTO `product` VALUES (7,2,'RAM PC DDR5 Crucial 16GB Bus 4800 CT16G48C40U5',3850000,'https://res.cloudinary.com/macomp/image/upload/v1650961212/macomp/7_yhl0bk_r8cm3f.jpg',100,1,'<div><p>Nếu như bạn vừa mới mua cho mình một thiết bị máy tính xách tay thế hệ mới, nhưng cảm thấy dung lượng ram hiện tại sẵn có trên máy tính quá thấp, không thể đáp ứng được nhu cầu học tập, làm việc của bạn? Thì bạn cần phải nâng cấp sản phẩm RAM Laptop Samsung 8GB DDR4 3200 cho máy tính của mình để máy có thể hoạt động mượt mà hơn.</p><p>Một số ưu điểm nổi bât của RAM Laptop DDR4 Samsung 8GB Bus 3200 M471A1K43DB1-CWE</p><p><em><strong>Tốc độ cực cao:</strong></em> Sản phẩm này<strong> </strong>được thiết kế với xung bus cực lớn lên đến 3200MHz, nhờ đó các tác vụ xử lý dữ liệu diễn ra trên máy tính của bạn đều được xử lý vô cùng nhanh chóng.</p><p><em><strong>Dung lượng lớn:</strong></em> Hỗ trợ bộ nhớ tối đa lên tới 8GB, tuy không quá nhiều nhưng đối với người dùng bình thường thì mình tin rằng đây là một mức dung lượng vô cùng lý tưởng.</p><p><em><strong>Điện năng tiêu thụ cực thấp: </strong></em>Với mức điện áp yêu cầu chỉ 1.2V, điều này giúp giảm thiểu lượng điện năng tiêu thụ của máy tính và cho phép máy tính của bạn có thể sử dụng được trong thời gian dài hơn.</p></div>');
INSERT INTO `product` VALUES (8,2,'RAM PC DDR5 Crucial 8GB Bus 4800 CT8G48C40U5',1880000,'https://res.cloudinary.com/macomp/image/upload/v1650961230/macomp/7_yhl0bk_lqitfp.jpg',100,1,'<div><p>Nếu như bạn vừa mới mua cho mình một thiết bị máy tính xách tay thế hệ mới, nhưng cảm thấy dung lượng ram hiện tại sẵn có trên máy tính quá thấp, không thể đáp ứng được nhu cầu học tập, làm việc của bạn? Thì bạn cần phải nâng cấp sản phẩm RAM Laptop Samsung 8GB DDR4 3200 cho máy tính của mình để máy có thể hoạt động mượt mà hơn.</p><p>Một số ưu điểm nổi bât của RAM Laptop DDR4 Samsung 8GB Bus 3200 M471A1K43DB1-CWE</p><p><em><strong>Tốc độ cực cao:</strong></em> Sản phẩm này<strong> </strong>được thiết kế với xung bus cực lớn lên đến 3200MHz, nhờ đó các tác vụ xử lý dữ liệu diễn ra trên máy tính của bạn đều được xử lý vô cùng nhanh chóng.</p><p><em><strong>Dung lượng lớn:</strong></em> Hỗ trợ bộ nhớ tối đa lên tới 8GB, tuy không quá nhiều nhưng đối với người dùng bình thường thì mình tin rằng đây là một mức dung lượng vô cùng lý tưởng.</p><p><em><strong>Điện năng tiêu thụ cực thấp: </strong></em>Với mức điện áp yêu cầu chỉ 1.2V, điều này giúp giảm thiểu lượng điện năng tiêu thụ của máy tính và cho phép máy tính của bạn có thể sử dụng được trong thời gian dài hơn.</p></div>');

INSERT INTO `product` VALUES (9,3,'SSD Samsung PM881 128GB M2 2280 SATA',580000,'https://res.cloudinary.com/macomp/image/upload/v1650961246/macomp/9_txnu9y_vntv70.jpg',100,1,'<div><p>Nếu như bạn vừa mới mua cho mình một thiết bị máy tính xách tay thế hệ mới, nhưng cảm thấy dung lượng ram hiện tại sẵn có trên máy tính quá thấp, không thể đáp ứng được nhu cầu học tập, làm việc của bạn? Thì bạn cần phải nâng cấp sản phẩm RAM Laptop Samsung 8GB DDR4 3200 cho máy tính của mình để máy có thể hoạt động mượt mà hơn.</p><p>Một số ưu điểm nổi bât của RAM Laptop DDR4 Samsung 8GB Bus 3200 M471A1K43DB1-CWE</p><p><em><strong>Tốc độ cực cao:</strong></em> Sản phẩm này<strong> </strong>được thiết kế với xung bus cực lớn lên đến 3200MHz, nhờ đó các tác vụ xử lý dữ liệu diễn ra trên máy tính của bạn đều được xử lý vô cùng nhanh chóng.</p><p><em><strong>Dung lượng lớn:</strong></em> Hỗ trợ bộ nhớ tối đa lên tới 8GB, tuy không quá nhiều nhưng đối với người dùng bình thường thì mình tin rằng đây là một mức dung lượng vô cùng lý tưởng.</p><p><em><strong>Điện năng tiêu thụ cực thấp: </strong></em>Với mức điện áp yêu cầu chỉ 1.2V, điều này giúp giảm thiểu lượng điện năng tiêu thụ của máy tính và cho phép máy tính của bạn có thể sử dụng được trong thời gian dài hơn.</p></div>');
INSERT INTO `product` VALUES (10,3,'SSD Samsung 980 1TB M2 2280 PCIe NVMe',2800000,'https://res.cloudinary.com/macomp/image/upload/v1650961254/macomp/10_lejdm6_fjle4q.jpg',100,1,'<div><p>Nếu như bạn vừa mới mua cho mình một thiết bị máy tính xách tay thế hệ mới, nhưng cảm thấy dung lượng ram hiện tại sẵn có trên máy tính quá thấp, không thể đáp ứng được nhu cầu học tập, làm việc của bạn? Thì bạn cần phải nâng cấp sản phẩm RAM Laptop Samsung 8GB DDR4 3200 cho máy tính của mình để máy có thể hoạt động mượt mà hơn.</p><p>Một số ưu điểm nổi bât của RAM Laptop DDR4 Samsung 8GB Bus 3200 M471A1K43DB1-CWE</p><p><em><strong>Tốc độ cực cao:</strong></em> Sản phẩm này<strong> </strong>được thiết kế với xung bus cực lớn lên đến 3200MHz, nhờ đó các tác vụ xử lý dữ liệu diễn ra trên máy tính của bạn đều được xử lý vô cùng nhanh chóng.</p><p><em><strong>Dung lượng lớn:</strong></em> Hỗ trợ bộ nhớ tối đa lên tới 8GB, tuy không quá nhiều nhưng đối với người dùng bình thường thì mình tin rằng đây là một mức dung lượng vô cùng lý tưởng.</p><p><em><strong>Điện năng tiêu thụ cực thấp: </strong></em>Với mức điện áp yêu cầu chỉ 1.2V, điều này giúp giảm thiểu lượng điện năng tiêu thụ của máy tính và cho phép máy tính của bạn có thể sử dụng được trong thời gian dài hơn.</p></div>');
INSERT INTO `product` VALUES (11,3,'SSD Samsung PM981A 256GB M2 2280 PCIe NVMe',900000,'https://res.cloudinary.com/macomp/image/upload/v1650961273/macomp/11_xdcdnt_v5dro8.jpg',100,1,'<div><p>Nếu như bạn vừa mới mua cho mình một thiết bị máy tính xách tay thế hệ mới, nhưng cảm thấy dung lượng ram hiện tại sẵn có trên máy tính quá thấp, không thể đáp ứng được nhu cầu học tập, làm việc của bạn? Thì bạn cần phải nâng cấp sản phẩm RAM Laptop Samsung 8GB DDR4 3200 cho máy tính của mình để máy có thể hoạt động mượt mà hơn.</p><p>Một số ưu điểm nổi bât của RAM Laptop DDR4 Samsung 8GB Bus 3200 M471A1K43DB1-CWE</p><p><em><strong>Tốc độ cực cao:</strong></em> Sản phẩm này<strong> </strong>được thiết kế với xung bus cực lớn lên đến 3200MHz, nhờ đó các tác vụ xử lý dữ liệu diễn ra trên máy tính của bạn đều được xử lý vô cùng nhanh chóng.</p><p><em><strong>Dung lượng lớn:</strong></em> Hỗ trợ bộ nhớ tối đa lên tới 8GB, tuy không quá nhiều nhưng đối với người dùng bình thường thì mình tin rằng đây là một mức dung lượng vô cùng lý tưởng.</p><p><em><strong>Điện năng tiêu thụ cực thấp: </strong></em>Với mức điện áp yêu cầu chỉ 1.2V, điều này giúp giảm thiểu lượng điện năng tiêu thụ của máy tính và cho phép máy tính của bạn có thể sử dụng được trong thời gian dài hơn.</p></div>');
INSERT INTO `product` VALUES (12,3,'SSD Samsung PM991 1TB M2 2242 PCIe NVMe',4650000,'https://res.cloudinary.com/macomp/image/upload/v1650961284/macomp/12_ttbygr_cmyzu1.jpg',100,1,'<div><p>Nếu như bạn vừa mới mua cho mình một thiết bị máy tính xách tay thế hệ mới, nhưng cảm thấy dung lượng ram hiện tại sẵn có trên máy tính quá thấp, không thể đáp ứng được nhu cầu học tập, làm việc của bạn? Thì bạn cần phải nâng cấp sản phẩm RAM Laptop Samsung 8GB DDR4 3200 cho máy tính của mình để máy có thể hoạt động mượt mà hơn.</p><p>Một số ưu điểm nổi bât của RAM Laptop DDR4 Samsung 8GB Bus 3200 M471A1K43DB1-CWE</p><p><em><strong>Tốc độ cực cao:</strong></em> Sản phẩm này<strong> </strong>được thiết kế với xung bus cực lớn lên đến 3200MHz, nhờ đó các tác vụ xử lý dữ liệu diễn ra trên máy tính của bạn đều được xử lý vô cùng nhanh chóng.</p><p><em><strong>Dung lượng lớn:</strong></em> Hỗ trợ bộ nhớ tối đa lên tới 8GB, tuy không quá nhiều nhưng đối với người dùng bình thường thì mình tin rằng đây là một mức dung lượng vô cùng lý tưởng.</p><p><em><strong>Điện năng tiêu thụ cực thấp: </strong></em>Với mức điện áp yêu cầu chỉ 1.2V, điều này giúp giảm thiểu lượng điện năng tiêu thụ của máy tính và cho phép máy tính của bạn có thể sử dụng được trong thời gian dài hơn.</p></div>');

INSERT INTO `product` VALUES (13,4,'SSD Enterprise Intel DC S4500 240GB SSDSC2KB240G701',1750000,'https://res.cloudinary.com/macomp/image/upload/v1650961360/macomp/13_bxofsj_amlq6i.jpg',100,1,'<div><p>Nếu như bạn vừa mới mua cho mình một thiết bị máy tính xách tay thế hệ mới, nhưng cảm thấy dung lượng ram hiện tại sẵn có trên máy tính quá thấp, không thể đáp ứng được nhu cầu học tập, làm việc của bạn? Thì bạn cần phải nâng cấp sản phẩm RAM Laptop Samsung 8GB DDR4 3200 cho máy tính của mình để máy có thể hoạt động mượt mà hơn.</p><p>Một số ưu điểm nổi bât của RAM Laptop DDR4 Samsung 8GB Bus 3200 M471A1K43DB1-CWE</p><p><em><strong>Tốc độ cực cao:</strong></em> Sản phẩm này<strong> </strong>được thiết kế với xung bus cực lớn lên đến 3200MHz, nhờ đó các tác vụ xử lý dữ liệu diễn ra trên máy tính của bạn đều được xử lý vô cùng nhanh chóng.</p><p><em><strong>Dung lượng lớn:</strong></em> Hỗ trợ bộ nhớ tối đa lên tới 8GB, tuy không quá nhiều nhưng đối với người dùng bình thường thì mình tin rằng đây là một mức dung lượng vô cùng lý tưởng.</p><p><em><strong>Điện năng tiêu thụ cực thấp: </strong></em>Với mức điện áp yêu cầu chỉ 1.2V, điều này giúp giảm thiểu lượng điện năng tiêu thụ của máy tính và cho phép máy tính của bạn có thể sử dụng được trong thời gian dài hơn.</p></div>');
INSERT INTO `product` VALUES (14,4,'SSD Enterprise Intel DC S4500 480GB SSDSC2KB480G701',2850000,'https://res.cloudinary.com/macomp/image/upload/v1650961374/macomp/14_s1zlim_qnl5st.jpg',100,1,'<div><p>Nếu như bạn vừa mới mua cho mình một thiết bị máy tính xách tay thế hệ mới, nhưng cảm thấy dung lượng ram hiện tại sẵn có trên máy tính quá thấp, không thể đáp ứng được nhu cầu học tập, làm việc của bạn? Thì bạn cần phải nâng cấp sản phẩm RAM Laptop Samsung 8GB DDR4 3200 cho máy tính của mình để máy có thể hoạt động mượt mà hơn.</p><p>Một số ưu điểm nổi bât của RAM Laptop DDR4 Samsung 8GB Bus 3200 M471A1K43DB1-CWE</p><p><em><strong>Tốc độ cực cao:</strong></em> Sản phẩm này<strong> </strong>được thiết kế với xung bus cực lớn lên đến 3200MHz, nhờ đó các tác vụ xử lý dữ liệu diễn ra trên máy tính của bạn đều được xử lý vô cùng nhanh chóng.</p><p><em><strong>Dung lượng lớn:</strong></em> Hỗ trợ bộ nhớ tối đa lên tới 8GB, tuy không quá nhiều nhưng đối với người dùng bình thường thì mình tin rằng đây là một mức dung lượng vô cùng lý tưởng.</p><p><em><strong>Điện năng tiêu thụ cực thấp: </strong></em>Với mức điện áp yêu cầu chỉ 1.2V, điều này giúp giảm thiểu lượng điện năng tiêu thụ của máy tính và cho phép máy tính của bạn có thể sử dụng được trong thời gian dài hơn.</p></div>');

INSERT INTO `product` VALUES (15,5,'CPU Intel Core i5-10400F',3599000,'https://res.cloudinary.com/macomp/image/upload/v1650961387/macomp/15_nwakpx_vxq6ml.jpg',100,1,'<div><p>Nếu như bạn vừa mới mua cho mình một thiết bị máy tính xách tay thế hệ mới, nhưng cảm thấy dung lượng ram hiện tại sẵn có trên máy tính quá thấp, không thể đáp ứng được nhu cầu học tập, làm việc của bạn? Thì bạn cần phải nâng cấp sản phẩm RAM Laptop Samsung 8GB DDR4 3200 cho máy tính của mình để máy có thể hoạt động mượt mà hơn.</p><p>Một số ưu điểm nổi bât của RAM Laptop DDR4 Samsung 8GB Bus 3200 M471A1K43DB1-CWE</p><p><em><strong>Tốc độ cực cao:</strong></em> Sản phẩm này<strong> </strong>được thiết kế với xung bus cực lớn lên đến 3200MHz, nhờ đó các tác vụ xử lý dữ liệu diễn ra trên máy tính của bạn đều được xử lý vô cùng nhanh chóng.</p><p><em><strong>Dung lượng lớn:</strong></em> Hỗ trợ bộ nhớ tối đa lên tới 8GB, tuy không quá nhiều nhưng đối với người dùng bình thường thì mình tin rằng đây là một mức dung lượng vô cùng lý tưởng.</p><p><em><strong>Điện năng tiêu thụ cực thấp: </strong></em>Với mức điện áp yêu cầu chỉ 1.2V, điều này giúp giảm thiểu lượng điện năng tiêu thụ của máy tính và cho phép máy tính của bạn có thể sử dụng được trong thời gian dài hơn.</p></div>');
INSERT INTO `product` VALUES (16,5,'CPU Intel Core i7-12700F',8999000,'https://res.cloudinary.com/macomp/image/upload/v1650961397/macomp/16_djxiag_zgr7im.jpg',100,1,'<div><p>Nếu như bạn vừa mới mua cho mình một thiết bị máy tính xách tay thế hệ mới, nhưng cảm thấy dung lượng ram hiện tại sẵn có trên máy tính quá thấp, không thể đáp ứng được nhu cầu học tập, làm việc của bạn? Thì bạn cần phải nâng cấp sản phẩm RAM Laptop Samsung 8GB DDR4 3200 cho máy tính của mình để máy có thể hoạt động mượt mà hơn.</p><p>Một số ưu điểm nổi bât của RAM Laptop DDR4 Samsung 8GB Bus 3200 M471A1K43DB1-CWE</p><p><em><strong>Tốc độ cực cao:</strong></em> Sản phẩm này<strong> </strong>được thiết kế với xung bus cực lớn lên đến 3200MHz, nhờ đó các tác vụ xử lý dữ liệu diễn ra trên máy tính của bạn đều được xử lý vô cùng nhanh chóng.</p><p><em><strong>Dung lượng lớn:</strong></em> Hỗ trợ bộ nhớ tối đa lên tới 8GB, tuy không quá nhiều nhưng đối với người dùng bình thường thì mình tin rằng đây là một mức dung lượng vô cùng lý tưởng.</p><p><em><strong>Điện năng tiêu thụ cực thấp: </strong></em>Với mức điện áp yêu cầu chỉ 1.2V, điều này giúp giảm thiểu lượng điện năng tiêu thụ của máy tính và cho phép máy tính của bạn có thể sử dụng được trong thời gian dài hơn.</p></div>');
INSERT INTO `product` VALUES (17,5,'CPU Intel Core i9-11900F',11199000,'https://res.cloudinary.com/macomp/image/upload/v1650961413/macomp/17_ngvgkf_crxykl.jpg',100,1,'<div><p>Nếu như bạn vừa mới mua cho mình một thiết bị máy tính xách tay thế hệ mới, nhưng cảm thấy dung lượng ram hiện tại sẵn có trên máy tính quá thấp, không thể đáp ứng được nhu cầu học tập, làm việc của bạn? Thì bạn cần phải nâng cấp sản phẩm RAM Laptop Samsung 8GB DDR4 3200 cho máy tính của mình để máy có thể hoạt động mượt mà hơn.</p><p>Một số ưu điểm nổi bât của RAM Laptop DDR4 Samsung 8GB Bus 3200 M471A1K43DB1-CWE</p><p><em><strong>Tốc độ cực cao:</strong></em> Sản phẩm này<strong> </strong>được thiết kế với xung bus cực lớn lên đến 3200MHz, nhờ đó các tác vụ xử lý dữ liệu diễn ra trên máy tính của bạn đều được xử lý vô cùng nhanh chóng.</p><p><em><strong>Dung lượng lớn:</strong></em> Hỗ trợ bộ nhớ tối đa lên tới 8GB, tuy không quá nhiều nhưng đối với người dùng bình thường thì mình tin rằng đây là một mức dung lượng vô cùng lý tưởng.</p><p><em><strong>Điện năng tiêu thụ cực thấp: </strong></em>Với mức điện áp yêu cầu chỉ 1.2V, điều này giúp giảm thiểu lượng điện năng tiêu thụ của máy tính và cho phép máy tính của bạn có thể sử dụng được trong thời gian dài hơn.</p></div>');
INSERT INTO `product` VALUES (18,5,'CPU Intel Core i9-11900K',15490000,'https://res.cloudinary.com/macomp/image/upload/v1650961425/macomp/18_icnb0w_wbjtok.jpg',100,1,'<div><p>Nếu như bạn vừa mới mua cho mình một thiết bị máy tính xách tay thế hệ mới, nhưng cảm thấy dung lượng ram hiện tại sẵn có trên máy tính quá thấp, không thể đáp ứng được nhu cầu học tập, làm việc của bạn? Thì bạn cần phải nâng cấp sản phẩm RAM Laptop Samsung 8GB DDR4 3200 cho máy tính của mình để máy có thể hoạt động mượt mà hơn.</p><p>Một số ưu điểm nổi bât của RAM Laptop DDR4 Samsung 8GB Bus 3200 M471A1K43DB1-CWE</p><p><em><strong>Tốc độ cực cao:</strong></em> Sản phẩm này<strong> </strong>được thiết kế với xung bus cực lớn lên đến 3200MHz, nhờ đó các tác vụ xử lý dữ liệu diễn ra trên máy tính của bạn đều được xử lý vô cùng nhanh chóng.</p><p><em><strong>Dung lượng lớn:</strong></em> Hỗ trợ bộ nhớ tối đa lên tới 8GB, tuy không quá nhiều nhưng đối với người dùng bình thường thì mình tin rằng đây là một mức dung lượng vô cùng lý tưởng.</p><p><em><strong>Điện năng tiêu thụ cực thấp: </strong></em>Với mức điện áp yêu cầu chỉ 1.2V, điều này giúp giảm thiểu lượng điện năng tiêu thụ của máy tính và cho phép máy tính của bạn có thể sử dụng được trong thời gian dài hơn.</p></div>');

INSERT INTO `product` VALUES (19,6,'CPU AMD RYZEN 3 Pro 4350G Renoir (3.8GHz Up to 4.0GHz, AM4, 4 Cores 8 Threads)',3699000,'https://res.cloudinary.com/macomp/image/upload/v1650961454/macomp/19_lcose1_bgghpp.jpg',100,1,'<div><p>Nếu như bạn vừa mới mua cho mình một thiết bị máy tính xách tay thế hệ mới, nhưng cảm thấy dung lượng ram hiện tại sẵn có trên máy tính quá thấp, không thể đáp ứng được nhu cầu học tập, làm việc của bạn? Thì bạn cần phải nâng cấp sản phẩm RAM Laptop Samsung 8GB DDR4 3200 cho máy tính của mình để máy có thể hoạt động mượt mà hơn.</p><p>Một số ưu điểm nổi bât của RAM Laptop DDR4 Samsung 8GB Bus 3200 M471A1K43DB1-CWE</p><p><em><strong>Tốc độ cực cao:</strong></em> Sản phẩm này<strong> </strong>được thiết kế với xung bus cực lớn lên đến 3200MHz, nhờ đó các tác vụ xử lý dữ liệu diễn ra trên máy tính của bạn đều được xử lý vô cùng nhanh chóng.</p><p><em><strong>Dung lượng lớn:</strong></em> Hỗ trợ bộ nhớ tối đa lên tới 8GB, tuy không quá nhiều nhưng đối với người dùng bình thường thì mình tin rằng đây là một mức dung lượng vô cùng lý tưởng.</p><p><em><strong>Điện năng tiêu thụ cực thấp: </strong></em>Với mức điện áp yêu cầu chỉ 1.2V, điều này giúp giảm thiểu lượng điện năng tiêu thụ của máy tính và cho phép máy tính của bạn có thể sử dụng được trong thời gian dài hơn.</p></div>');
INSERT INTO `product` VALUES (20,6,'CPU AMD Ryzen 5 5600G 3.9GHz 6 cores 12 threads 16MB 100-100000252BOX',5500000,'https://res.cloudinary.com/macomp/image/upload/v1650961470/macomp/20_kw3t5v_vtltfx.webp',100,1,'<div><p>Nếu như bạn vừa mới mua cho mình một thiết bị máy tính xách tay thế hệ mới, nhưng cảm thấy dung lượng ram hiện tại sẵn có trên máy tính quá thấp, không thể đáp ứng được nhu cầu học tập, làm việc của bạn? Thì bạn cần phải nâng cấp sản phẩm RAM Laptop Samsung 8GB DDR4 3200 cho máy tính của mình để máy có thể hoạt động mượt mà hơn.</p><p>Một số ưu điểm nổi bât của RAM Laptop DDR4 Samsung 8GB Bus 3200 M471A1K43DB1-CWE</p><p><em><strong>Tốc độ cực cao:</strong></em> Sản phẩm này<strong> </strong>được thiết kế với xung bus cực lớn lên đến 3200MHz, nhờ đó các tác vụ xử lý dữ liệu diễn ra trên máy tính của bạn đều được xử lý vô cùng nhanh chóng.</p><p><em><strong>Dung lượng lớn:</strong></em> Hỗ trợ bộ nhớ tối đa lên tới 8GB, tuy không quá nhiều nhưng đối với người dùng bình thường thì mình tin rằng đây là một mức dung lượng vô cùng lý tưởng.</p><p><em><strong>Điện năng tiêu thụ cực thấp: </strong></em>Với mức điện áp yêu cầu chỉ 1.2V, điều này giúp giảm thiểu lượng điện năng tiêu thụ của máy tính và cho phép máy tính của bạn có thể sử dụng được trong thời gian dài hơn.</p></div>');
INSERT INTO `product` VALUES (21,6,'CPU AMD Ryzen 7 5700G (8C/16T, 3.8 GHz - 4.6 GHz, 4MB) - AM4',9390000,'https://res.cloudinary.com/macomp/image/upload/v1650961483/macomp/21_skomiz_hz6x4i.webp',100,1,'<div><p>Nếu như bạn vừa mới mua cho mình một thiết bị máy tính xách tay thế hệ mới, nhưng cảm thấy dung lượng ram hiện tại sẵn có trên máy tính quá thấp, không thể đáp ứng được nhu cầu học tập, làm việc của bạn? Thì bạn cần phải nâng cấp sản phẩm RAM Laptop Samsung 8GB DDR4 3200 cho máy tính của mình để máy có thể hoạt động mượt mà hơn.</p><p>Một số ưu điểm nổi bât của RAM Laptop DDR4 Samsung 8GB Bus 3200 M471A1K43DB1-CWE</p><p><em><strong>Tốc độ cực cao:</strong></em> Sản phẩm này<strong> </strong>được thiết kế với xung bus cực lớn lên đến 3200MHz, nhờ đó các tác vụ xử lý dữ liệu diễn ra trên máy tính của bạn đều được xử lý vô cùng nhanh chóng.</p><p><em><strong>Dung lượng lớn:</strong></em> Hỗ trợ bộ nhớ tối đa lên tới 8GB, tuy không quá nhiều nhưng đối với người dùng bình thường thì mình tin rằng đây là một mức dung lượng vô cùng lý tưởng.</p><p><em><strong>Điện năng tiêu thụ cực thấp: </strong></em>Với mức điện áp yêu cầu chỉ 1.2V, điều này giúp giảm thiểu lượng điện năng tiêu thụ của máy tính và cho phép máy tính của bạn có thể sử dụng được trong thời gian dài hơn.</p></div>');

COMMIT;

BEGIN;
INSERT INTO `cart` VALUES ('minhan2022',15,3,'2022-02-11 11:12:01');
COMMIT;

BEGIN;
INSERT INTO `order_list` VALUES (5,'minhan2022','2021-11-11 11:12:01',4);
INSERT INTO `order_list` VALUES (6,'minhan2022','2021-12-11 11:12:01',3);
INSERT INTO `order_list` VALUES (7,'minhan2022','2022-01-11 11:12:01',3);
INSERT INTO `order_list` VALUES (8,'minhan2022','2021-02-11 11:12:01',3);
INSERT INTO `order_list` VALUES (9,'minhan2022','2021-03-11 11:12:01',4);
INSERT INTO `order_list` VALUES (10,'minhan2022','2020-12-11 11:12:01',1);
INSERT INTO `order_list` VALUES (11,'minhan2022','2021-11-11 11:12:01',2);
INSERT INTO `order_list` VALUES (12,'minhan2022','2021-12-11 11:12:01',2);
INSERT INTO `order_list` VALUES (13,'minhan2022','2021-01-11 11:12:01',2);
COMMIT;

BEGIN;
INSERT INTO `order_detail` VALUES (3,4,1);
INSERT INTO `order_detail` VALUES (3,2,2);

INSERT INTO `order_detail` VALUES (4,3,1);
INSERT INTO `order_detail` VALUES (4,4,1);
INSERT INTO `order_detail` VALUES (5,3,1);
INSERT INTO `order_detail` VALUES (6,9,2);
INSERT INTO `order_detail` VALUES (7,11,1);

INSERT INTO `order_detail` VALUES (7,9,2);
INSERT INTO `order_detail` VALUES (7,14,1);
INSERT INTO `order_detail` VALUES (8,14,1);
INSERT INTO `order_detail` VALUES (9,14,1);
INSERT INTO `order_detail` VALUES (9,12,1);
INSERT INTO `order_detail` VALUES (10,10,1);
INSERT INTO `order_detail` VALUES (10,11,1);
INSERT INTO `order_detail` VALUES (11,10,1);

INSERT INTO `order_detail` VALUES (11,1,1);
INSERT INTO `order_detail` VALUES (11,15,1);
INSERT INTO `order_detail` VALUES (12,17,2);
INSERT INTO `order_detail` VALUES (12,18,1);
INSERT INTO `order_detail` VALUES (13,15,2);
INSERT INTO `order_detail` VALUES (13,20,2);
COMMIT;


-- ----------------------------
-- Records of order
-- ----------------------------

-- Full text search

ALTER TABLE `product`
ADD FULLTEXT(ProName);