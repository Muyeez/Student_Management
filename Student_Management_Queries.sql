-- Retrieve all students
SELECT * FROM Students;

-- Retrieve all courses
SELECT * FROM Courses;

-- Retrieve students enrolled in a specific course (e.g., Web Development)
SELECT s.student_id, s.first_name, s.last_name, c.course_name 
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Web Development';

-- Calculate overall attendance percentage for each student
SELECT s.student_id, s.first_name, s.last_name, 
       ROUND(AVG(a.attendance_percentage), 2) AS overall_attendance
FROM Attendance a
JOIN Students s ON a.student_id = s.student_id
GROUP BY s.student_id;

-- Find students who failed at least one course
SELECT s.student_id, s.first_name, s.last_name, c.course_name, g.final_score, g.status
FROM Grades g
JOIN Students s ON g.student_id = s.student_id
JOIN Courses c ON g.course_id = c.course_id
WHERE g.status = 'Fail';

-- Get the average test score for each course
SELECT c.course_id, c.course_name, ROUND(AVG(g.test_score), 2) AS avg_test_score
FROM Grades g
JOIN Courses c ON g.course_id = c.course_id
GROUP BY c.course_id;

-- Find students with attendance below 70%
SELECT s.student_id, s.first_name, s.last_name, c.course_name, a.attendance_percentage
FROM Attendance a
JOIN Students s ON a.student_id = s.student_id
JOIN Courses c ON a.course_id = c.course_id
WHERE a.attendance_percentage < 70;

-- Retrieve top-performing student per course based on final score
SELECT s.student_id, s.first_name, s.last_name, c.course_name, g.final_score
FROM Grades g
JOIN Students s ON g.student_id = s.student_id
JOIN Courses c ON g.course_id = c.course_id
WHERE g.final_score = (
    SELECT MAX(final_score) FROM Grades WHERE course_id = g.course_id
);

-- Count total enrollments per course
SELECT c.course_id, c.course_name, COUNT(e.student_id) AS total_students
FROM Enrollments e
JOIN Courses c ON e.course_id = c.course_id
GROUP BY c.course_id;

-- Find students who have enrolled but have no recorded attendance
SELECT s.student_id, s.first_name, s.last_name, c.course_name
FROM Enrollments e
LEFT JOIN Attendance a ON e.student_id = a.student_id AND e.course_id = a.course_id
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE a.attendance_id IS NULL;