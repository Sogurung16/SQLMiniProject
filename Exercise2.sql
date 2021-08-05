CREATE DATABASE sonam_db

USE sonam_db

/*  2.1 Write the correct SQL statement to create the following table:

    Spartans Table – include details about all the Spartans on this course. 
    Separate Title, First Name and Last Name into separate columns, and include 
    University attended, course taken and mark achieved. Add any other columns 
    you feel would be appropriate.  

    IMPORTANT NOTE: For data protection reasons do NOT include date of birth in this exercise. */

CREATE TABLE spartansTable(
    id INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(5),
    firstName VARCHAR(15),
    lastName VARCHAR(15),
    universityAttended VARCHAR(30),
    courseTaken VARCHAR(30),
    markAchieved VARCHAR(10)
)

SELECT * FROM spartansTable

/*  Write SQL statements to add the details of the Spartans in your course to the table 
    you have created.	 */

INSERT INTO spartansTable (title, firstName, lastName, universityAttended, courseTaken, markAchieved)
VALUES 
('Mr', 'Sonam', 'Gurung', 'Brunel University', 'Computer Science', '1st')