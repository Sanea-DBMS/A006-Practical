CREATE TABLE CourseDetails (
    CourseID TINYINT PRIMARY KEY,
    CourseName VARCHAR(20) NOT NULL,
    Amount SMALLINT
);

INSERT INTO CourseDetails
VALUES 
(01, 'SQL', 15000),
(02, 'Power-BI', 12000);

SELECT * FROM CourseDetails;

CREATE TABLE StudentsDetails (
    SID INT PRIMARY KEY,
    SName CHAR(30) NOT NULL,
    Age TINYINT CHECK (Age > 18),
    Gender VARCHAR(20) CHECK (Gender = 'Male' OR Gender = 'Female'),
    CourseID TINYINT,
    FOREIGN KEY (CourseID) REFERENCES CourseDetails(CourseID)
);

INSERT INTO StudentsDetails
VALUES
(01, 'Ram', 20, 'Male', 01),
(02, 'Sham', 21, 'Male', 01),
(03, 'Sneha', 21, 'Female', 02),
(04, 'Priya', 22, 'Female', 01),
(05, 'Abhimanyu', 23, 'Male', 02);

SELECT * FROM StudentsDetails;
