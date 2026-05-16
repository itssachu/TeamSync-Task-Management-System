<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TeamSync.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - Team Task Manager</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #4f46e5, #7c3aed);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            position: relative;
        }

        /* Responsive Back Button */
        .back-home {
            position: absolute;
            top: 20px;
            left: 20px;
            color: white;
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: 0.3s;
            z-index: 1000;
            background: rgba(255, 255, 255, 0.1);
            padding: 8px 15px;
            border-radius: 50px;
            backdrop-filter: blur(10px);
            font-size: 14px;
        }

        .back-home:hover {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            transform: translateX(-3px);
        }

        .login-container {
            width: 100%;
            max-width: 1100px;
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(20px);
            border-radius: 30px;
            overflow: hidden;
            box-shadow: 0 25px 50px rgba(0,0,0,0.25);
            display: flex;
            flex-direction: row;
        }

        /* Left Panel Styling */
        .left-panel {
            flex: 1.2;
            background: linear-gradient(135deg, rgba(255,255,255,0.15), rgba(255,255,255,0.05));
            color: white;
            padding: 60px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .logo {
            width: 60px;
            height: 60px;
            background: white;
            color: #4f46e5;
            border-radius: 15px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 28px;
            margin-bottom: 25px;
        }

        .left-panel h1 {
            font-size: clamp(2rem, 4vw, 3.2rem); /* Dynamic font size */
            font-weight: 700;
            margin-bottom: 20px;
            line-height: 1.1;
        }

        .left-panel p {
            font-size: 16px;
            opacity: 0.9;
            line-height: 1.6;
            margin-bottom: 30px;
        }

        .feature-item {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            font-size: 16px;
        }

        .feature-item i {
            font-size: 20px;
            margin-right: 12px;
            color: #a78bfa;
        }

        /* Right Panel Styling */
        .right-panel {
            flex: 1;
            background: white;
            padding: 60px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-title {
            font-size: 32px;
            font-weight: 700;
            color: #111827;
        }

        .login-subtitle {
            color: #6b7280;
            margin-bottom: 35px;
            font-size: 15px;
        }

        .input-group-custom {
            position: relative;
            margin-bottom: 20px;
        }

        .input-group-custom i {
            position: absolute;
            top: 50%;
            left: 18px;
            transform: translateY(-50%);
            color: #9ca3af;
            z-index: 10;
        }

        .form-control {
            height: 55px;
            border-radius: 12px;
            padding-left: 50px;
            font-size: 15px;
            border: 1px solid #e5e7eb;
        }

        .btn-login {
            width: 100%;
            height: 55px;
            border: none;
            border-radius: 12px;
            background: linear-gradient(135deg, #4f46e5, #7c3aed);
            color: white;
            font-weight: 600;
            transition: 0.3s;
            margin-top: 10px;
        }

        .btn-login:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }

        /* --- MEDIA QUERIES FOR FULL RESPONSIVENESS --- */

        /* Laptops / Small Desktops */
        @media (max-width: 1200px) {
            .left-panel, .right-panel { padding: 40px; }
        }

        /* Tablets (Landscape & Portrait) */
        @media (max-width: 991px) {
            body { padding: 60px 20px 20px 20px; } /* Space for back button */
            .login-container { flex-direction: column; max-width: 600px; }
            .left-panel { padding: 40px; text-align: center; align-items: center; }
            .logo { margin: 0 auto 20px auto; }
            .feature-box { display: flex; flex-wrap: wrap; justify-content: center; gap: 15px; }
            .feature-item { margin-bottom: 0; }
        }

        /* Mobile Devices */
        @media (max-width: 576px) {
            .login-container { border-radius: 20px; }
            .left-panel { padding: 30px 20px; }
            .right-panel { padding: 30px 20px; }
            .login-title { font-size: 26px; }
            .left-panel h1 { font-size: 28px; }
            .feature-box { flex-direction: column; align-items: flex-start; }
            .back-home { top: 10px; left: 10px; padding: 5px 12px; font-size: 12px; }
        }
    </style>
</head>
<body>

    <a href="HomePage.aspx" class="back-home">
        <i class="bi bi-arrow-left"></i> Back to Home
    </a>

    <form id="form1" runat="server">
        <div class="login-container">
            <!-- Left Side: Informational -->
            <div class="left-panel">
                <div class="logo">
                    <i class="bi bi-kanban-fill"></i>
                </div>
                <h1>Manage Your Team Smarter</h1>
                <p>Organize projects, assign tasks, and boost productivity with our modern platform.</p>
                
                <div class="feature-box">
                    <div class="feature-item"><i class="bi bi-check-circle-fill"></i> Easy Tracking</div>
                    <div class="feature-item"><i class="bi bi-people-fill"></i> Collaboration</div>
                    <div class="feature-item"><i class="bi bi-bar-chart-fill"></i> Real-Time Data</div>
                </div>
            </div>

            <!-- Right Side: Interaction -->
            <div class="right-panel">
                <h2 class="login-title">Welcome Back !</h2>
                <p class="login-subtitle">Login to manage your tasks.</p>

                <asp:Label ID="lblMessage" runat="server" CssClass="message d-block mb-3 text-danger small font-weight-bold"></asp:Label>

                <div class="input-group-custom">
                    <i class="bi bi-envelope-fill"></i>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email Address"></asp:TextBox>
                </div>

                <div class="input-group-custom">
                    <i class="bi bi-lock-fill"></i>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Password"></asp:TextBox>
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="Login Now" CssClass="btn-login" OnClick="btnLogin_Click" />

                <div class="register-link">
                    <span class="small">Don't have an account?</span>
                    <a href="Register.aspx" class="small">Create Account</a>
                </div>
            </div>
        </div>
    </form>

</body>
</html>