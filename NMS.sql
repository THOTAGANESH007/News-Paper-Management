CREATE TABLE cart (
  cid int NOT NULL AUTO_INCREMENT,
  pid int DEFAULT NULL,
  uid int DEFAULT NULL,
  publicationName varchar(45) DEFAULT NULL,
  author varchar(45) DEFAULT NULL,
  price double DEFAULT NULL,
  totalPrice int DEFAULT NULL,
  PRIMARY KEY (cid)
);

CREATE TABLE deliveryAgent (
  did int NOT NULL AUTO_INCREMENT,
  name varchar(45) DEFAULT NULL,
  email varchar(45) DEFAULT NULL,
  phno varchar(45) DEFAULT NULL,
  password varchar(45) DEFAULT NULL,
  salary double DEFAULT 0,
  areaAssigned varchar(45) DEFAULT NULL,
  PRIMARY KEY (did)
);

CREATE TABLE publications (
  pid int NOT NULL AUTO_INCREMENT,
  publicationName varchar(45) DEFAULT NULL,
  author varchar(45) DEFAULT NULL,
  publicationType varchar(45) DEFAULT NULL,
  price double DEFAULT NULL,
  publicationStatus varchar(45) DEFAULT NULL,
  photo varchar(45) DEFAULT NULL,
  summary varchar(500) DEFAULT NULL,
  PRIMARY KEY (pid)
);

CREATE TABLE subscriptions (
  sid int NOT NULL AUTO_INCREMENT,
  uid int NOT NULL,
  customerName varchar(100) NOT NULL,
  email varchar(100) NOT NULL,
  phno varchar(15) NOT NULL,
  address varchar(255) DEFAULT NULL,
  publicationName varchar(100) NOT NULL,
  amount double NOT NULL,
  paymentType enum('Cash', 'Cheque') NOT NULL,
  startDate date NOT NULL,
  paymentStatus enum('Paid', 'Pending', 'Failed') NOT NULL,
  subscriptionStatus enum('Active', 'On Hold', 'Cancelled') NOT NULL,
  daysCount int DEFAULT 0,
  last_updated timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  landMark varchar(45) DEFAULT NULL,
  holdRequestDate date DEFAULT NULL,
  PRIMARY KEY (sid)
);

CREATE TABLE users (
  id int NOT NULL AUTO_INCREMENT,
  name varchar(45) DEFAULT NULL,
  email varchar(45) DEFAULT NULL,
  password varchar(45) DEFAULT NULL,
  phno varchar(45) DEFAULT NULL,
  address varchar(500) DEFAULT NULL,
  category varchar(45) DEFAULT NULL,
  notificationCount int DEFAULT 0,
  text varchar(300) DEFAULT 'Kindly Please Pay your bill!!!',
  PRIMARY KEY (id)
);



-- FOR INCREASING DAYS COUNT (--> 1)
CREATE EVENT incrementDaysCount
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP + INTERVAL 1 DAY
DO
  UPDATE subscriptions
  SET daysCount = CASE 
                     WHEN daysCount < 90 THEN daysCount + 1  -- Increment daysCount until it reaches a maximum of 90
                     ELSE daysCount
                  END,
      last_updated = CURRENT_TIMESTAMP  -- Update last_updated to the current timestamp
  WHERE startDate < CURDATE()  -- Only increment for subscriptions that started before today
    AND subscriptionStatus != 'On Hold';  -- Exclude subscriptions with status 'On Hold'
    
    
    
    
 -- FOR CANCELLING THE SUBSCRIPTION WHEN daysCount ID GREATER THAN 60 (--> 2)


DELIMITER $$

CREATE TRIGGER checkDaysCountBeforeUpdate
BEFORE UPDATE ON subscriptions
FOR EACH ROW
BEGIN
  IF NEW.daysCount >= 60 THEN
    SET NEW.subscriptionStatus = 'Cancelled';
  END IF;
END$$

DELIMITER ;




-- To reset the notification count when the payment status is paid (--> 3)


DELIMITER //

CREATE EVENT reset_notification_on_paid
ON SCHEDULE EVERY 1 MINUTE
DO
BEGIN
    UPDATE users AS u
    JOIN subscriptions AS s ON u.id = s.uid
    SET u.notificationCount = 0
    WHERE s.paymentStatus = 'Paid'
      AND s.last_updated > (NOW() - INTERVAL 1 MINUTE);
END //

DELIMITER ;


 (--> 4)
DELIMITER //

CREATE TRIGGER set_hold_request_date
BEFORE UPDATE ON subscriptions
FOR EACH ROW
BEGIN
    IF NEW.subscriptionStatus = 'On Hold' AND OLD.subscriptionStatus = 'Active' THEN
        SET NEW.holdRequestDate = CURDATE();
    END IF;
END //

DELIMITER ;



 (--> 5)
CREATE EVENT update_subscription_status
ON SCHEDULE EVERY 1 DAY
DO
    UPDATE subscriptions
    SET subscriptionStatus = 'On Hold'
    WHERE subscriptionStatus = 'Active' 
      AND holdRequestDate IS NOT NULL 
      AND holdRequestDate <= DATE_SUB(CURDATE(), INTERVAL 7 DAY);




 (--> 6)
DELIMITER //

CREATE EVENT daily_update_delivery_agent_salary
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    DECLARE increment DOUBLE;

    -- Update the salary for each delivery agent with matching active subscriptions
    UPDATE deliveryAgent da
    JOIN subscriptions s
    ON da.areaAssigned = s.landMark
    SET da.salary = da.salary + (s.amount / 30) * 0.025
    WHERE s.subscriptionStatus = 'Active';
END//

DELIMITER ;





