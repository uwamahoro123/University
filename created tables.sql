-- Create the Students table
CREATE TABLE Students (
    StudentID NUMBER PRIMARY KEY,
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    Age NUMBER,
    Gender VARCHAR2(10)
);

-- Create the Professors table
CREATE TABLE Professors (
    ProfessorID NUMBER PRIMARY KEY,
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    Department VARCHAR2(50)
);

-- Create the Courses table
CREATE TABLE Courses (
    CourseID NUMBER PRIMARY KEY,
    CourseName VARCHAR2(100),
    Credits NUMBER
);

-- Create the Enrollments table to establish a many-to-many relationship between Students and Courses
CREATE TABLE Enrollments (
    EnrollmentID NUMBER PRIMARY KEY,
    StudentID NUMBER,
    CourseID NUMBER,
    Semester VARCHAR2(20),
    Grade VARCHAR2(2),
    CONSTRAINT fk_StudentID FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CONSTRAINT fk_CourseID FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Create the ResearchPapers table
CREATE TABLE ResearchPapers (
    PaperID NUMBER PRIMARY KEY,
    PaperTitle VARCHAR2(200),
    ProfessorID NUMBER,
    PublishedDate DATE,
    CONSTRAINT fk_ProfessorID FOREIGN KEY (ProfessorID) REFERENCES Professors(ProfessorID)
);

-- Create the CourseProfessor table to establish a many-to-many relationship between Courses and Professors
CREATE TABLE CourseProfessor (
    AssignmentID NUMBER PRIMARY KEY,
    CourseID NUMBER,
    ProfessorID NUMBER,
    CONSTRAINT fk_CourseID_CP FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    CONSTRAINT fk_ProfessorID_CP FOREIGN KEY (ProfessorID) REFERENCES Professors(ProfessorID)
);
commit;

-- Insert data into Students table
INSERT INTO Students (StudentID, FirstName, LastName, Age, Gender)
VALUES (1, 'John', 'Doe', 20, 'Male');
INSERT INTO Students (StudentID, FirstName, LastName, Age, Gender)
VALUES (2, 'Jane', 'Smith', 22, 'Female');

-- Insert data into Professors table
INSERT INTO Professors (ProfessorID, FirstName, LastName, Department)
VALUES (1, 'Dr. Alice', 'Johnson', 'Computer Science');
INSERT INTO Professors (ProfessorID, FirstName, LastName, Department)
VALUES (2, 'Dr. Bob', 'Williams', 'Mathematics');

-- Insert data into Courses table
INSERT INTO Courses (CourseID, CourseName, Credits)
VALUES (1, 'Database Systems', 4);
INSERT INTO Courses (CourseID, CourseName, Credits)
VALUES (2, 'Algorithms', 3);

-- Insert data into Enrollments table
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, Semester, Grade)
VALUES (1, 1, 1, 'Fall 2023', 'A');
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, Semester, Grade)
VALUES (2, 1, 2, 'Spring 2024', 'B');
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, Semester, Grade)
VALUES (3, 2, 1, 'Fall 2023', 'A');

-- Insert data into ResearchPapers table
INSERT INTO ResearchPapers (PaperID, PaperTitle, ProfessorID, PublishedDate)
VALUES (1, 'Data Mining Techniques', 1, DATE '2023-05-01');
INSERT INTO ResearchPapers (PaperID, PaperTitle, ProfessorID, PublishedDate)
VALUES (2, 'Machine Learning Algorithms', 1, DATE '2023-07-15');

-- Insert data into CourseProfessor table
INSERT INTO CourseProfessor (AssignmentID, CourseID, ProfessorID)
VALUES (1, 1, 1);
INSERT INTO CourseProfessor (AssignmentID, CourseID, ProfessorID)
VALUES (2, 2, 1);
INSERT INTO CourseProfessor (AssignmentID, CourseID, ProfessorID)
VALUES (3, 2, 2);

-- Update the age of a student
UPDATE Students
SET Age = 21
WHERE StudentID = 1;

-- Update the department of a professor
UPDATE Professors
SET Department = 'Data Science'
WHERE ProfessorID = 1;

-- Update the grade of a student in a particular course
UPDATE Enrollments
SET Grade = 'A+'
WHERE EnrollmentID = 2;

-- Delete a student from the Students table
DELETE FROM Students
WHERE StudentID = 2;

-- Delete a course from the Courses table
DELETE FROM Courses
WHERE CourseID = 2;

-- Delete an enrollment record
DELETE FROM Enrollments
WHERE EnrollmentID = 3;


-- Select all students along with the courses they are enrolled in
SELECT s.StudentID, s.FirstName, s.LastName, c.CourseName, e.Semester, e.Grade
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID;

-- Select all professors along with the courses they teach
SELECT p.ProfessorID, p.FirstName, p.LastName, c.CourseName
FROM Professors p
JOIN CourseProfessor cp ON p.ProfessorID = cp.ProfessorID
JOIN Courses c ON cp.CourseID = c.CourseID;

-- Select all research papers along with their authors
SELECT r.PaperTitle, p.FirstName, p.LastName, r.PublishedDate
FROM ResearchPapers r
JOIN Professors p ON r.ProfessorID = p.ProfessorID;

-- Select all students who are taking courses taught by a specific professor
SELECT s.StudentID, s.FirstName, s.LastName, c.CourseName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
JOIN CourseProfessor cp ON c.CourseID = cp.CourseID
JOIN Professors p ON cp.ProfessorID = p.ProfessorID
WHERE p.ProfessorID = 1;

-- Select all courses along with the number of students enrolled in each course
SELECT c.CourseName, COUNT(e.StudentID) AS NumberOfStudents
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseName;