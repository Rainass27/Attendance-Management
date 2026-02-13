<?php 
session_start();
if(isset($_POST['biometric_login'])) {
    // Simulate biometric check (in real system = fingerprint scanner)
    $teacher_id = $_POST['teacher_id'];
    
    // Check if teacher exists
    $pdo = new PDO("mysql:host=localhost;dbname=student_management_system;charset=utf8mb4", "root", "Buburaina123$");
    $stmt = $pdo->prepare("SELECT employee_id, CONCAT(first_name, ' ', last_name) as name FROM employee WHERE employee_id = ?");
    $stmt->execute([$teacher_id]);
    $teacher = $stmt->fetch();
    
    if($teacher) {
        $_SESSION['teacher_id'] = $teacher_id;
        $_SESSION['teacher_name'] = $teacher['name'];
        header("Location: attendance_teacher.php");
        exit;
    } else {
        $error = "Invalid biometric ID!";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Teacher Biometric Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="card shadow mt-5">
                    <div class="card-body text-center p-5">
                        <i class="bi bi-fingerprint fs-1 text-primary mb-4"></i>
                        <h3>Teacher Biometric Login</h3>
                        <p class="text-muted">Scan fingerprint or enter ID</p>
                        
                        <?php if(isset($error)): ?>
                            <div class="alert alert-danger"><?php echo $error; ?></div>
                        <?php endif; ?>
                        
                        <form method="POST">
                            <div class="mb-4">
                                <label class="form-label fw-bold">Teacher ID</label>
                                <input type="number" name="teacher_id" class="form-control form-control-lg" 
                                       placeholder="Enter 13, 14, 15..." required>
                                <div class="form-text">Sneha Jacob (13), Ravi Sharma (14), Anita Iyer (15)</div>
                            </div>
                            <button type="submit" name="biometric_login" class="btn btn-primary w-100 btn-lg">
                                <i class="bi bi-fingerprint"></i> SCAN FINGERPRINT
                            </button>
                        </form>
                        
                        <hr class="my-4">
                        <a href="index.php" class="btn btn-link">← Back to Dashboard</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
