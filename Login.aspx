<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="TeamSync.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - Team Task Manager</title>

    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

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
            overflow-x: hidden;
            padding: 20px;
        }

        .login-container {
            width: 100%;
            max-width: 1100px;
            min-height: 650px;
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(20px);
            border-radius: 30px;
            overflow: hidden;
            box-shadow: 0 25px 50px rgba(0,0,0,0.25);
            display: flex;
        }

        .left-panel {
            flex: 1;
            background: linear-gradient(135deg, rgba(255,255,255,0.15), rgba(255,255,255,0.05));
            color: white;
            padding: 60px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            position: relative;
        }

        .logo {
            width: 70px;
            height: 70px;
            background: white;
            color: #4f46e5;
            border-radius: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 30px;
            margin-bottom: 30px;
        }

        .left-panel h1 {
            font-size: 52px;
            font-weight: 700;
            margin-bottom: 20px;
            line-height: 1.2;
        }

        .left-panel p {
            font-size: 18px;
            opacity: 0.9;
            line-height: 1.8;
        }

        .feature-box {
            margin-top: 40px;
        }

        .feature-item {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            font-size: 17px;
        }

        .feature-item i {
            font-size: 22px;
            margin-right: 15px;
        }

        .right-panel {
            flex: 1;
            background: white;
            padding: 60px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-title {
            font-size: 38px;
            font-weight: 700;
            color: #111827;
            margin-bottom: 10px;
        }

        .login-subtitle {
            color: #6b7280;
            margin-bottom: 40px;
            font-size: 16px;
        }

        .form-control {
            height: 58px;
            border-radius: 15px;
            border: 1px solid #d1d5db;
            padding-left: 50px;
            font-size: 15px;
        }

        .form-control:focus {
            box-shadow: none;
            border-color: #4f46e5;
        }

        .input-group-custom {
            position: relative;
            margin-bottom: 25px;
        }

        .input-group-custom i {
            position: absolute;
            top: 18px;
            left: 18px;
            color: #6b7280;
            z-index: 10;
        }

        .btn-login {
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

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(79,70,229,0.3);
        }

        .register-link {
            text-align: center;
            margin-top: 25px;
            color: #6b7280;
        }

        .register-link a {
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
            .login-container {
                flex-direction: column;
            }

            .left-panel {
                padding: 40px;
            }

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
                padding: 30px 20px;
            }

            .left-panel h1 {
                font-size: 32px;
            }

            .login-title {
                font-size: 30px;
            }
        }
    </style>
</head>

<body>

    <form id="form1" runat="server">

        <div class="login-container">

            <!-- Left Side -->
            <div class="left-panel">

                <div class="logo">
                    <i class="bi bi-kanban-fill"></i>
                </div>

                <h1>Manage Your Team Smarter</h1>

                <p>
                    Organize projects, assign tasks, track progress and boost your team's productivity with our modern task management platform.
                </p>

                <div class="feature-box">

                    <div class="feature-item">
                        <i class="bi bi-check-circle-fill"></i>
                        Easy Task Tracking
                    </div>

                    <div class="feature-item">
                        <i class="bi bi-people-fill"></i>
                        Team Collaboration
                    </div>

                    <div class="feature-item">
                        <i class="bi bi-bar-chart-fill"></i>
                        Real-Time Dashboard
                    </div>

                </div>

            </div>

            <!-- Right Side -->
            <div class="right-panel">

                <h2 class="login-title">Welcome Back 👋</h2>

                <p class="login-subtitle">
                    Login to continue managing your projects and tasks.
                </p>

                <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>

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
                        placeholder="Enter your password">
                    </asp:TextBox>

                </div>

                <!-- Login Button -->
                <asp:Button ID="btnLogin" runat="server" Text="Login Now" CssClass="btn-login" OnClick="btnLogin_Click" />

                <!-- Register -->
                <div class="register-link">
                    Don't have an account?
                    <a href="Register.aspx">Create Account</a>
                </div>

            </div>

        </div>

    </form>

</body>
</html>