<?php 
session_start();
date_default_timezone_set('Asia/Kolkata');

// Session check - redirect if not logged in
if(!isset($_SESSION['teacher_id'])) {
    header("Location: teacher_login.php");
    exit;
}
$teacher_name = $_SESSION['teacher_name'] ?? 'Teacher';

$host = 'localhost';
$dbname = 'student_management_system';  
$username = 'root';
$password = '';

$pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
$pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);

$message = '';
$selected_course = $_POST['course_id'] ?? '';
$attendance_date = $_POST['attendance_date'] ?? date('Y-m-d');
$students = [];

// SIMPLIFIED - NO ERRORS, SHOWS ALL ACTIVE STUDENTS
if($selected_course) {
    $stmt = $pdo->query("SELECT student_id, CONCAT(first_name, ' ', last_name) as name FROM student WHERE enrollment_status = 'Active' ORDER BY name");
    $students = $stmt->fetchAll();
}

if(isset($_POST['save_attendance'])) {
    $course_id = $_POST['course_id'];
    $date = $_POST['attendance_date'];
    $saved = 0;
    
    // Save only STUDENT attendance - SIMPLE & CLEAN
    foreach($_POST['attendance'] as $student_id => $status) {
        $stmt = $pdo->prepare("INSERT INTO attendancestudent (student_id, offering_id, date, status) VALUES (?, ?, ?, ?) ON DUPLICATE KEY UPDATE status = VALUES(status)");
        $stmt->execute([$student_id, $course_id, $date, $status]);
        $saved++;
    }
    
    $message = "<div class='alert alert-success alert-dismissible fade show' role='alert'>
                    ✅ SAVED <strong>$saved</strong> STUDENT records to database! 
                    <button type='button' class='btn-close' data-bs-dismiss='alert'></button>
                </div>";
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Attendance - <?php echo $teacher_name; ?></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- SIDEBAR -->
        <div class="col-md-2 bg-primary text-white vh-100 p-4">
            <div class="mb-4">
                <h4>Hi, <?php echo $teacher_name; ?> 👋</h4>
                <small class="text-white-50">ID: <?php echo $_SESSION['teacher_id']; ?></small>
            </div>
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link text-white active"><i class="bi bi-calendar-check"></i> Attendance</a></li>
                <li class="nav-item"><a href="teacher_logout.php" class="nav-link text-white"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
            </ul>
        </div>

        <!-- MAIN CONTENT -->
        <div class="col-md-10 p-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="bi bi-calendar-check text-primary"></i> Mark Attendance</h2>
                <a href="index.php" class="btn btn-outline-secondary"><i class="bi bi-house"></i> Dashboard</a>
            </div>
            
            <?php echo $message; ?>
            
            <!-- COURSE SELECTION FORM -->
            <form method="POST">
            <div class="card shadow mb-4">
                <div class="card-body">
                    <div class="row g-3 align-items-end">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Course Offering</label>
                            <select name="course_id" class="form-select" id="courseSelect" required>
                                <option value="">Select Course...</option>
                                <?php
                                $stmt = $pdo->query("SELECT offering_id, course_name FROM course_offering ORDER BY course_name");
                                while($row = $stmt->fetch()) {
                                    $selected = ($selected_course == $row['offering_id']) ? 'selected' : '';
                                    echo "<option value='{$row['offering_id']}' $selected>{$row['course_name']}</option>";
                                }
                                ?>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Date</label>
                            <input type="date" name="attendance_date" class="form-control" value="<?php echo htmlspecialchars($attendance_date); ?>">
                        </div>
                        <div class="col-md-3">
                            <button type="submit" name="load_students" class="btn btn-primary w-100 btn-lg">
                                <i class="bi bi-people"></i> LOAD STUDENTS
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            </form>

            <!-- STUDENTS TABLE -->
            <?php if($selected_course && !empty($students)): ?>
            <div class="card shadow">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5><i class="bi bi-people"></i> <?php echo count($students); ?> Students - Course ID: <?php echo htmlspecialchars($selected_course); ?></h5>
                    <form method="POST" style="display:inline;">
                        <input type="hidden" name="course_id" value="<?php echo htmlspecialchars($selected_course); ?>">
                        <input type="hidden" name="attendance_date" value="<?php echo htmlspecialchars($attendance_date); ?>">
                        <input type="hidden" name="save_attendance" value="1">
                        <button type="submit" class="btn btn-success btn-lg">
                            <i class="bi bi-check-circle"></i> SAVE ATTENDANCE
                        </button>
                    </form>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th width="50%">Student Name (ID)</th>
                                <th width="25%">Status</th>
                                <th width="25%">Leaves Used/Max</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach($students as $student): ?>
                            <tr>
                                <td>
                                    <strong><?php echo htmlspecialchars($student['name']); ?></strong><br>
                                    <small class="text-muted">ID: <?php echo $student['student_id']; ?></small>
                                </td>
                                <td>
                                    <select name="attendance[<?php echo $student['student_id']; ?>]" class="form-select">
                                        <option value="Present" selected>Present</option>
                                        <option value="Leave">Leave</option>
                                        <option value="Absent">Absent</option>
                                    </select>
                                </td>
                                <td><span class="badge bg-success">0/4</span></td>
                            </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            </div>
            <?php endif; ?>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

