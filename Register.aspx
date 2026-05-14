<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="TeamSync.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register - TeamSync</title>

    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />

    <!-- Google Font -->
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
            overflow-x: hidden;
        }

        .register-container {
            width: 100%;
            max-width: 1200px;
            min-height: 720px;
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(20px);
            border-radius: 30px;
            overflow: hidden;
            display: flex;
            box-shadow: 0 25px 50px rgba(0,0,0,0.25);
        }

        .left-panel {
            flex: 1;
            background: linear-gradient(135deg, rgba(255,255,255,0.15), rgba(255,255,255,0.05));
            color: white;
            padding: 60px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .logo {
            width: 75px;
            height: 75px;
            border-radius: 20px;
            background: white;
            color: #4f46e5;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 32px;
            margin-bottom: 30px;
        }

        .left-panel h1 {
            font-size: 52px;
            font-weight: 700;
            margin-bottom: 20px;
            line-height: 1.2;
        }

        .left-panel p {
            font-size: 17px;
            line-height: 1.8;
            opacity: 0.9;
        }

        .features {
            margin-top: 40px;
        }

        .feature-item {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            font-size: 16px;
        }

        .feature-item i {
            margin-right: 15px;
            font-size: 22px;
        }

        .right-panel {
            flex: 1;
            background: white;
            padding: 60px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .register-title {
            font-size: 38px;
            font-weight: 700;
            color: #111827;
            margin-bottom: 10px;
        }

        .register-subtitle {
            color: #6b7280;
            margin-bottom: 35px;
        }

        .input-group-custom {
            position: relative;
            margin-bottom: 22px;
        }

        .input-group-custom i {
            position: absolute;
            top: 18px;
            left: 18px;
            color: #6b7280;
            z-index: 10;
        }

        .form-control {
            height: 58px;
            border-radius: 15px;
            border: 1px solid #d1d5db;
            padding-left: 50px;
            font-size: 15px;
        }

        .form-control:focus {
            border-color: #4f46e5;
            box-shadow: none;
        }

        .btn-register {
            width: 100%;
            height: 58px;
            border: none;
            border-radius: 15px;
            background: linear-gradient(135deg, #4f46e5, #7c3aed);
            color: white;
            font-size: 17px;
            font-weight: 600;
            transition: 0.3s;
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(79,70,229,0.35);
        }

        .login-link {
            margin-top: 25px;
            text-align: center;
            color: #6b7280;
        }

        .login-link a {
            text-decoration: none;
            color: #4f46e5;
            font-weight: 600;
        }

        .message {
            color: red;
            margin-bottom: 15px;
            font-weight: 500;
        }

        @media(max-width: 991px) {

            .register-container {
                flex-direction: column;
            }

            .left-panel,
            .right-panel {
                padding: 40px;
            }

            .left-panel h1 {
                font-size: 40px;
            }
        }

        @media(max-width: 576px) {

            .left-panel,
            .right-panel {
                padding: 25px;
            }

            .left-panel h1 {
                font-size: 32px;
            }

            .register-title {
                font-size: 30px;
            }
        }
    </style>
</head>

<body>

    <form id="form1" runat="server">

        <div class="register-container">

            <!-- Left Panel -->
            <div class="left-panel">

                <div class="logo">
                    <i class="bi bi-kanban-fill"></i>
                </div>

                <h1>Join TeamSync Today</h1>

                <p>
                    Simplify teamwork, track progress, assign tasks and manage projects efficiently with our smart task management platform.
                </p>

                <div class="features">

                    <div class="feature-item">
                        <i class="bi bi-check-circle-fill"></i>
                        Smart Project Management
                    </div>

                    <div class="feature-item">
                        <i class="bi bi-people-fill"></i>
                        Team Collaboration
                    </div>

                    <div class="feature-item">
                        <i class="bi bi-graph-up-arrow"></i>
                        Productivity Tracking
                    </div>

                </div>

            </div>

            <!-- Right Panel -->
            <div class="right-panel">

                <h2 class="register-title">Create Account 🚀</h2>

                <p class="register-subtitle">
                    Register your account to get started.
                </p>

                <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>

                <!-- Full Name -->
                <div class="input-group-custom">

                    <i class="bi bi-person-fill"></i>

                    <asp:TextBox
                        ID="txtName"
                        runat="server"
                        CssClass="form-control"
                        placeholder="Enter your full name">
                    </asp:TextBox>

                </div>

                <!-- Email -->
                <div class="input-group-custom">

                    <i class="bi bi-envelope-fill"></i>

                    <asp:TextBox
                        ID="txtEmail"
                        runat="server"
                        CssClass="form-control"
                        placeholder="Enter your email">
                    </asp:TextBox>

                </div>

                <!-- Password -->
                <div class="input-group-custom">

                    <i class="bi bi-lock-fill"></i>

                    <asp:TextBox
                        ID="txtPassword"
                        runat="server"
                        CssClass="form-control"
                        TextMode="Password"
                        placeholder="Create password">
                    </asp:TextBox>

                </div>

                <!-- Confirm Password -->
                <div class="input-group-custom">

                    <i class="bi bi-shield-lock-fill"></i>

                    <asp:TextBox
                        ID="txtConfirmPassword"
                        runat="server"
                        CssClass="form-control"
                        TextMode="Password"
                        placeholder="Confirm password">
                    </asp:TextBox>

                </div>

                <!-- Register Button -->
                <asp:Button
                    ID="btnRegister"
                    runat="server"
                    Text="Create Account"
                    CssClass="btn-register"
                    OnClick="btnRegister_Click" />

                <div class="login-link">
                    Already have an account?
                    <a href="Login.aspx">Login</a>
                </div>

            </div>

        </div>

    </form>

</body>
</html>