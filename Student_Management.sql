CREATE DATABASE Student_Management;
USE Student_Management;

CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    dob DATE,
    gender ENUM('Male', 'Female', 'Other')
);


-- Create Courses Table
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100),
    course_code VARCHAR(10) UNIQUE,
    credits INT
);

-- Create Enrollments Table (Links Students & Courses)
CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);


-- Create Attendance Table
CREATE TABLE Attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    total_classes INT,
    attended_classes INT,
    attendance_percentage DECIMAL(5,2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

-- Create Grades Table
CREATE TABLE Grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    test_score DECIMAL(5,2),
    final_score DECIMAL(5,2),
    status ENUM('Pass', 'Fail'),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);


-- Insert Sample Data into Students
INSERT INTO Students (first_name, last_name, email, dob, gender) VALUES
('John', 'Doe', 'john.doe@email.com', '2000-05-15', 'Male'),
('Alice', 'Smith', 'alice.smith@email.com', '1999-09-21', 'Female'),
('Bob', 'Johnson', 'bob.johnson@email.com', '2001-07-30', 'Male');

-- Insert Sample Data into Courses
INSERT INTO Courses (course_name, course_code, credits) VALUES
('Database Management', 'DB101', 3),
('Web Development', 'WD102', 4),
('Machine Learning', 'ML103', 5);

-- Insert Sample Data into Enrollments
INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-01-10'),
(1, 2, '2024-01-12'),
(2, 2, '2024-01-15'),
(3, 3, '2024-01-18');

-- Insert Sample Data into Attendance
INSERT INTO Attendance (student_id, course_id, total_classes, attended_classes, attendance_percentage) VALUES
(1, 1, 30, 28, 93.33),
(1, 2, 25, 20, 80.00),
(2, 2, 25, 18, 72.00),
(3, 3, 20, 12, 60.00);

-- Insert Sample Data into Grades
INSERT INTO Grades (student_id, course_id, test_score, final_score, status) VALUES
(1, 1, 85, 90, 'Pass'),
(1, 2, 78, 75, 'Pass'),
(2, 2, 65, 70, 'Pass'),
(3, 3, 50, 55, 'Fail');