<?php
session_start();
if (!isset($_SESSION['studentid'])) {
    header('Location: student_login.php'); exit;
}

$studentid = $_SESSION['studentid'];
$pdo = new PDO("mysql:host=localhost;dbname=student_management_system;charset=utf8mb4", "root", "");

// Student name
$stmt = $pdo->prepare("SELECT CONCAT(first_name, ' ', COALESCE(middle_name,''), ' ', last_name) as fullname FROM student WHERE student_id = ?");
$stmt->execute([$studentid]);
$student = $stmt->fetch();

// 🔥 AT-RISK CALCULATION (75% = WARNING, <60% = DANGER)
$stmt = $pdo->prepare("
    SELECT 
        COUNT(*) as total,
        SUM(CASE WHEN status='Present' THEN 1 ELSE 0 END) as present,
        SUM(CASE WHEN status IN ('Absent','Late') THEN 1 ELSE 0 END) as absent
    FROM attendancestudent WHERE student_id = ?
");
$stmt->execute([$studentid]);
$stats = $stmt->fetch();
$total_sessions = $stats['total'];
$present = $stats['present'];
$percentage = $total_sessions > 0 ? round(($present / $total_sessions) * 100) : 0;

// AT-RISK STATUS
$risk_status = '';
$risk_color = '';
if ($percentage < 60) {
    $risk_status = '🚨 HIGH RISK - Academic Probation';
    $risk_color = 'bg-danger';
} elseif ($percentage < 75) {
    $risk_status = '⚠️ AT RISK - Improve Attendance';
    $risk_color = 'bg-warning';
} else {
    $risk_status = '✅ GOOD STANDING';
    $risk_color = 'bg-success';
}

// Attendance records
$stmt = $pdo->prepare("
    SELECT att.date, att.status, 
           CASE 
               WHEN att.offering_id = 1 THEN 'Foundation Design Studio'
               WHEN att.offering_id = 2 THEN 'Visual Communication Studio'
               WHEN att.offering_id = 3 THEN 'Creative Coding Workshop'
               ELSE 'Class Session'
           END as course_name,
           DATE_FORMAT(att.date, '%b %d') as pretty_date
    FROM attendancestudent att
    WHERE att.student_id = ?
    ORDER BY att.date DESC LIMIT 5
");
$stmt->execute([$studentid]);
$attendance = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html>
<head>
    <title><?= htmlspecialchars($student['fullname']) ?> - Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; }
        .glass { background: rgba(255,255,255,0.95); backdrop-filter: blur(20px); }
        .risk-badge { font-size: 1.2rem; padding: 1rem 2rem; border-radius: 50px; }
    </style>
</head>
<body class="py-5">
    <div class="container">
        <!-- STUDENT HEADER -->
        <div class="row justify-content-center mb-4">
            <div class="col-md-8 text-center">
                <div class="glass card shadow-lg border-0 p-4">
                    <h1 class="display-4 fw-bold"><?= htmlspecialchars($student['fullname']) ?></h1>
                    <div class="badge bg-primary fs-4 px-4 py-2 mb-3">ID: <?= $studentid ?></div>
                    
                    <!-- 🔥 AT-RISK STATUS -->
                    <div class="risk-badge <?= $risk_color ?> text-white fw-bold shadow-lg">
                        <?= $risk_status ?>
                    </div>
                </div>
            </div>
        </div>

        <!-- STATS -->
        <div class="row g-4 mb-5 justify-content-center">
            <div class="col-md-3">
                <div class="card text-white shadow-lg h-100" style="background: linear-gradient(45deg, #0d6efd, #6610f2);">
                    <div class="card-body text-center py-4">
                        <h1 class="display-4 fw-bold"><?= $percentage ?>%</h1>
                        <p class="lead mb-0">Attendance Rate</p>
                        <?php if($percentage < 75): ?>
                            <small class="text-warning fw-bold">⚠️ BELOW AVERAGE</small>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-success text-white shadow-lg h-100">
                    <div class="card-body text-center py-4">
                        <h1 class="display-4"><?= $present ?></h1>
                        <p class="lead">Present</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-danger text-white shadow-lg h-100">
                    <div class="card-body text-center py-4">
                        <h1 class="display-4"><?= $stats['absent'] ?></h1>
                        <p class="lead">Absent/Late</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-info text-white shadow-lg h-100">
                    <div class="card-body text-center py-4">
                        <h1 class="display-4"><?= $total_sessions ?></h1>
                        <p class="lead">Total Sessions</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- ATTENDANCE TABLE -->
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="card glass shadow-lg border-0">
                    <div class="card-header bg-primary text-white">
                        <h4><i class="bi bi-calendar-check me-2"></i>Recent Attendance</h4>
                    </div>
                    <div class="card-body">
                        <?php if (empty($attendance)): ?>
                            <div class="text-center py-5 text-muted">
                                <i class="bi bi-calendar-x fs-1 mb-3"></i>
                                <h5>No attendance records</h5>
                            </div>
                        <?php else: ?>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>Date</th>
                                            <th>Course</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php foreach ($attendance as $record): ?>
                                        <tr>
                                            <td><strong><?= $record['pretty_date'] ?></strong></td>
                                            <td><?= htmlspecialchars($record['course_name']) ?></td>
                                            <td>
                                                <span class="badge fs-6 px-4 py-2 
                                                    <?= $record['status']=='Present' ? 'bg-success' : 'bg-danger' ?>">
                                                    <?= $record['status'] ?>
                                                </span>
                                            </td>
                                        </tr>
                                        <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
        </div>

        <!-- WARNING BOX for LOW ATTENDANCE -->
        <?php if($percentage < 75): ?>
        <div class="row justify-content-center mt-4">
            <div class="col-md-8">
                <div class="alert alert-warning shadow-lg">
                    <h5><i class="bi bi-exclamation-triangle me-2"></i><?= $risk_status ?></h5>
                    <p class="mb-2">You need <strong><?= 75 - $percentage ?>%</strong> more attendance to reach safe threshold!</p>
                    <hr>
                    <small>Contact your academic advisor if you have concerns.</small>
                </div>
            </div>
        </div>
        <?php endif; ?>
    </div>
</body>
</html>

