<!DOCTYPE html>
<html>
<head>
    <title>Student Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .hero-section { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 70vh; }
        .card-hover { transition: all 0.3s ease; }
        .card-hover:hover { transform: translateY(-10px); box-shadow: 0 20px 40px rgba(0,0,0,0.1); }
    </style>
</head>
<body>
    <div class="hero-section text-white d-flex align-items-center">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8 text-center">
                    <h1 class="display-4 fw-bold mb-4">Student Management System</h1>
                    <p class="lead mb-5">Mark attendance, track biometric records, and manage courses efficiently</p>
                    <div class="row g-4 justify-content-center">
                        <div class="col-md-4">
                            <a href="teacher_login.php" class="btn btn-light btn-lg card-hover w-100 h-100 p-4 text-center">
                                <i class="bi bi-person-badge fs-1 mb-3 d-block"></i>
                                <h4>Teacher Portal</h4>
                                <p>Mark student & teacher attendance<br><strong>Biometric Login</strong></p>
                            </a>
                        </div>
                        <div class="col-md-4">
                            <a href="student_login.php" class="btn btn-outline-light btn-lg card-hover w-100 h-100 p-4 text-center">
                                <i class="bi bi-person-student fs-1 mb-3 d-block"></i>
                                <h4>Student Portal</h4>
                                <p>View attendance records<br>Check biometric status</p>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container py-5">
        <div class="row text-center">
            <div class="col-md-4 mb-4">
                <i class="bi bi-fingerprint fs-1 text-primary mb-3"></i>
                <h5>Biometric Authentication</h5>
                <p>Fingerprint login for teachers & students</p>
            </div>
            <div class="col-md-4 mb-4">
                <i class="bi bi-calendar-check fs-1 text-success mb-3"></i>
                <h5>Real-time Attendance</h5>
                <p>Instant student & teacher tracking</p>
            </div>
            <div class="col-md-4 mb-4">
                <i class="bi bi-shield-check fs-1 text-warning mb-3"></i>
                <h5>Secure Access</h5>
                <p>Role-based authentication system</p>
            </div>
        </div>
    </div>
</body>
</html>
