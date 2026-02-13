<?php
session_start();
$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $studentid = trim($_POST['studentid']);
    
    // ✅ CORRECT: Matches your SQL dump
    $pdo = new PDO("mysql:host=localhost;dbname=student_management_system;charset=utf8mb4", "root", "");
    
    $stmt = $pdo->prepare("
        SELECT s.student_id, CONCAT(s.first_name, ' ', COALESCE(s.middle_name,''), ' ', s.last_name) as name
        FROM student s 
        WHERE s.student_id = ? AND s.enrollment_status = 'Active'
    ");
    $stmt->execute([$studentid]);
    $student = $stmt->fetch();
    
    if ($student) {
        $_SESSION['studentid'] = $student['student_id'];
        $_SESSION['studentname'] = $student['name'];
        header('Location: student_dashboard.php');
        exit;
    } else {
        $error = "❌ Invalid! Try: <strong>1=Aarav Patel, 2=Diya Shah, 3=Kabir Singh, 4=Isha Verma</strong>";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Student Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container">
        <div class="row justify-content-center mt-5">
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-body p-5 text-center">
                        <i class="bi bi-fingerprint display-4 text-primary mb-4"></i>
                        <h3>Student Portal</h3>
                        <p class="text-muted">Biometric Login (Enter Student ID)</p>
                        
                        <?php if ($error): ?>
                            <div class="alert alert-danger"><?= $error ?></div>
                        <?php endif; ?>
                        
                        <form method="POST">
                            <div class="mb-4">
                                <label class="form-label fw-bold fs-5">Student ID</label>
                                <input type="number" name="studentid" class="form-control form-control-lg" 
                                       placeholder="1, 2, 3, 4..." required autofocus>
                                <small class="text-muted d-block mt-1">
                                    Aarav Patel(1) • Diya Shah(2) • Kabir Singh(3) • Isha Verma(4)
                                </small>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 btn-lg py-3">
                                <i class="bi bi-fingerprint me-2"></i>SCAN FINGERPRINT
                            </button>
                        </form>
                        
                        <hr class="my-4">
                        <a href="index.php" class="btn btn-outline-secondary w-100">
                            ← Back to Dashboard
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

