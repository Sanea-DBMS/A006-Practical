CREATE VIEW BankStatement AS
    SELECT * FROM Transactiondetails
    WHERE AccountID = 1;

SELECT * FROM BankStatement;

ALTER TABLE AccountDetails 
Add AccountStatus VARCHAR(8) DEFAULT('Active');

SELECT * FROM AccountDetails;

alter table AccountDetails rename column AccountDetails to AccountID;

CREATE DEFINER=`root`@`localhost` PROCEDURE `Ministatement` (Par_AccountID INT)
BEGIN
    DECLARE Var_Name CHAR(30);
    DECLARE Var_Currentbalance INT;

    -- Show current date and time
    SELECT NOW() AS Today_DateTime;

    -- Check if the account exists
    IF EXISTS (
        SELECT * FROM Accountdetails
        WHERE AccountID = Par_AccountID
    )
    THEN
        -- Display the account ID
        SELECT Par_AccountID AS AccountID;

        -- Retrieve and store customer name and current balance
        SELECT Name, Currentbalance INTO Var_Name, Var_Currentbalance
        FROM Accountdetails
        WHERE AccountID = Par_AccountID;

        -- Display customer name
        SELECT Var_Name AS CustomerName;

        -- Show transactions from the last 6 months
        SELECT * FROM Transactiondetails
        WHERE AccountID = Par_AccountID
        AND TIMESTAMPDIFF(MONTH, Transactiontime, NOW()) <= 6;
    ELSE
        -- Handle invalid account ID
        SELECT 'Invalid AccountID' AS Message;
    END IF;
END;

ALTER TABLE Accountdetails
ADD Accountstatus CHAR(28) DEFAULT('Active');

SELECT * FROM Accountdetails;

CREATE DEFINER=`root`@`localhost` PROCEDURE `AccountStatusUpdate`()
BEGIN

    UPDATE Accountdetails
    SET Accountstatus = 'Active'
    WHERE AccountID IN (
        SELECT AccountID FROM Transactiondetails
        WHERE TIMESTAMPDIFF(MONTH, Transactiontime, NOW()) <= 6
    );

    UPDATE Accountdetails
    SET Accountstatus = 'Inactive'
    WHERE AccountID NOT IN (
        SELECT AccountID FROM Transactiondetails
        WHERE TIMESTAMPDIFF(MONTH, Transactiontime, NOW()) <= 6
    );
END;
SELECT * FROM Accountdetails;