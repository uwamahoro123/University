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