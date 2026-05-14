<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/MasterPage.master"
AutoEventWireup="true"
CodeFile="Dashboard.aspx.cs"
Inherits="Admin_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>

        .dashboard-title {
            font-size: 32px;
            font-weight: 700;
            color: #111827;
            margin-bottom: 8px;
        }

        .dashboard-subtitle {
            color: #6b7280;
            margin-bottom: 35px;
        }

        .stats-card {
            border-radius: 24px;
            padding: 30px;
            color: white;
            position: relative;
            overflow: hidden;
            transition: 0.3s;
            height: 180px;
        }

        .stats-card:hover {
            transform: translateY(-6px);
        }

        .stats-icon {
            width: 65px;
            height: 65px;
            border-radius: 18px;
            background: rgba(255,255,255,0.2);
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 28px;
            margin-bottom: 25px;
        }

        .stats-number {
            font-size: 38px;
            font-weight: 700;
        }

        .stats-text {
            font-size: 16px;
            opacity: 0.9;
        }

        .bg-projects {
            background: linear-gradient(135deg, #4f46e5, #7c3aed);
        }

        .bg-tasks {
            background: linear-gradient(135deg, #06b6d4, #3b82f6);
        }

        .bg-completed {
            background: linear-gradient(135deg, #10b981, #22c55e);
        }

        .bg-overdue {
            background: linear-gradient(135deg, #ef4444, #f97316);
        }

        .section-card {
            background: white;
            border-radius: 24px;
            padding: 25px;
            margin-top: 30px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
        }

        .section-title {
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 20px;
            color: #111827;
        }

        .activity-item {
            display: flex;
            align-items: center;
            padding: 18px 0;
            border-bottom: 1px solid #f3f4f6;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 50px;
            height: 50px;
            border-radius: 15px;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            margin-right: 18px;
            font-size: 20px;
        }

        .activity-content h6 {
            margin: 0;
            font-weight: 600;
            color: #111827;
        }

        .activity-content p {
            margin: 0;
            color: #6b7280;
            font-size: 14px;
        }

        .chart-placeholder {
            height: 320px;
            border-radius: 20px;
            background: linear-gradient(135deg, #f9fafb, #f3f4f6);
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            color: #6b7280;
        }

        .chart-placeholder i {
            font-size: 60px;
            margin-bottom: 15px;
            color: #4f46e5;
        }

    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Heading -->
    <h2 class="dashboard-title">Dashboard Overview</h2>

    <p class="dashboard-subtitle">
        Monitor your projects, tasks and team performance in real-time.
    </p>

    <!-- Statistics -->
    <div class="row g-4">

        <!-- Projects -->
        <div class="col-lg-3 col-md-6">

            <div class="stats-card bg-projects">

                <div class="stats-icon">
                    <i class="bi bi-folder-fill"></i>
                </div>

                <div class="stats-number">
                    <asp:Label ID="lblProjects" runat="server" Text="0"></asp:Label>
                </div>

                <div class="stats-text">
                    Total Projects
                </div>

            </div>

        </div>

        <!-- Tasks -->
        <div class="col-lg-3 col-md-6">

            <div class="stats-card bg-tasks">

                <div class="stats-icon">
                    <i class="bi bi-list-check"></i>
                </div>

                <div class="stats-number">
                    <asp:Label ID="lblTasks" runat="server" Text="0"></asp:Label>
                </div>

                <div class="stats-text">
                    Total Tasks
                </div>

            </div>

        </div>

        <!-- Completed -->
        <div class="col-lg-3 col-md-6">

            <div class="stats-card bg-completed">

                <div class="stats-icon">
                    <i class="bi bi-check-circle-fill"></i>
                </div>

                <div class="stats-number">
                    <asp:Label ID="lblCompleted" runat="server" Text="0"></asp:Label>
                </div>

                <div class="stats-text">
                    Completed Tasks
                </div>

            </div>

        </div>

        <!-- Overdue -->
        <div class="col-lg-3 col-md-6">

            <div class="stats-card bg-overdue">

                <div class="stats-icon">
                    <i class="bi bi-exclamation-circle-fill"></i>
                </div>

                <div class="stats-number">
                    <asp:Label ID="lblOverdue" runat="server" Text="0"></asp:Label>
                </div>

                <div class="stats-text">
                    Overdue Tasks
                </div>

            </div>

        </div>

    </div>

    <!-- Charts & Activities -->
    <div class="row">

        <!-- Chart -->
        <div class="col-lg-8">

            <div class="section-card">

                <h4 class="section-title">
                    Task Analytics
                </h4>

                <div class="chart-placeholder">

                    <i class="bi bi-bar-chart-line-fill"></i>

                    <h5>Analytics Chart</h5>

                    <p>
                        Integrate Chart.js or Google Charts here
                    </p>

                </div>

            </div>

        </div>

        <!-- Activities -->
        <div class="col-lg-4">

            <div class="section-card">

                <h4 class="section-title">
                    Recent Activities
                </h4>

                <!-- Activity -->
                <div class="activity-item">

                    <div class="activity-icon bg-primary">
                        <i class="bi bi-folder-plus"></i>
                    </div>

                    <div class="activity-content">
                        <h6>New Project Created</h6>
                        <p>Website Redesign Project</p>
                    </div>

                </div>

                <!-- Activity -->
                <div class="activity-item">

                    <div class="activity-icon bg-success">
                        <i class="bi bi-check-circle"></i>
                    </div>

                    <div class="activity-content">
                        <h6>Task Completed</h6>
                        <p>Homepage UI Completed</p>
                    </div>

                </div>

                <!-- Activity -->
                <div class="activity-item">

                    <div class="activity-icon bg-warning">
                        <i class="bi bi-person-plus"></i>
                    </div>

                    <div class="activity-content">
                        <h6>New Team Member</h6>
                        <p>Rahul joined the team</p>
                    </div>

                </div>

                <!-- Activity -->
                <div class="activity-item">

                    <div class="activity-icon bg-danger">
                        <i class="bi bi-clock-history"></i>
                    </div>

                    <div class="activity-content">
                        <h6>Task Deadline</h6>
                        <p>API Integration due today</p>
                    </div>

                </div>

            </div>

        </div>

    </div>

</asp:Content>