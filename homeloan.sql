create database learning_cursor ;
use learning_cursor ;

CREATE TABLE home_loan (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    loan_amount DECIMAL(10,2),
    interest_rate DECIMAL(5,2),
    tenure_years INT);

CREATE TABLE loan_result (
    loan_id INT,
    customer_name VARCHAR(100),
    total_interest DECIMAL(10,2),
    total_amount DECIMAL(10,2));

INSERT INTO home_loan (customer_name, loan_amount, interest_rate, tenure_years) VALUES
('Priya', 750000, 8.0, 8),
('Vikas', 450000, 9.2, 6),
('Anjali', 900000, 7.2, 12),
('Rohit', 650000, 8.8, 9),
('Kavita', 550000, 8.3, 7),
('Suresh', 300000, 9.5, 5),
('Meena', 850000, 7.8, 11),
('Arjun', 720000, 8.1, 10),
('Pooja', 600000, 8.7, 8),
('Nikhil', 950000, 7.0, 15);

DELIMITER //

CREATE PROCEDURE CalculateLoanDetails()
BEGIN
    DECLARE done INT DEFAULT 0;

    DECLARE lid INT;
    DECLARE cname VARCHAR(100);
    DECLARE amount DECIMAL(10,2);
    DECLARE rate DECIMAL(5,2);
    DECLARE years INT;
    DECLARE total_interest DECIMAL(10,2);
    DECLARE total_amount DECIMAL(10,2);


    DECLARE loan_cursor CURSOR FOR
    SELECT loan_id, customer_name, loan_amount, interest_rate, tenure_years FROM home_loan;

  
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN loan_cursor;

    read_loop: LOOP

        FETCH loan_cursor INTO lid, cname, amount, rate, years;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SET total_interest = (amount * rate * years) / 100;

        SET total_amount = amount + total_interest;

        INSERT INTO loan_result(loan_id, customer_name, total_interest, total_amount)
        VALUES (lid, cname, total_interest, total_amount);

    END LOOP;

    CLOSE loan_cursor;

END //

DELIMITER ;

CALL CalculateLoanDetails();

SELECT * FROM loan_result;