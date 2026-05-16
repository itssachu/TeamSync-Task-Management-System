<%@ Page Title="Dashboard"
    Language="C#"
    MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true"
    CodeBehind="Dashboard.aspx.cs"
    Inherits="Admin_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <!-- Chart JS -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>

        .dashboard-header {
            margin-bottom: 35px;
        }

        .dashboard-title {
            font-size: 34px;
            font-weight: 700;
            color: #111827;
            margin-bottom: 8px;
        }

        .dashboard-subtitle {
            color: #6b7280;
            font-size: 15px;
        }

        /* ===========================
           STAT CARDS
        ============================*/

        .stats-card {
            border-radius: 26px;
            padding: 28px;
            position: relative;
            overflow: hidden;
            color: white;
            height: 190px;
            transition: 0.3s ease;
            box-shadow: 0 12px 30px rgba(0,0,0,0.08);
        }

        .stats-card:hover {
            transform: translateY(-8px);
        }

        .stats-card::before {
            content: '';
            position: absolute;
            width: 180px;
            height: 180px;
            background: rgba(255,255,255,0.08);
            border-radius: 50%;
            top: -70px;
            right: -70px;
        }

        .stats-icon {
            width: 68px;
            height: 68px;
            border-radius: 18px;
            background: rgba(255,255,255,0.18);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin-bottom: 25px;
        }

        .stats-number {
            font-size: 42px;
            font-weight: 700;
            line-height: 1;
        }

        .stats-text {
            margin-top: 10px;
            font-size: 15px;
            opacity: 0.95;
        }

        .bg-projects {
            background: linear-gradient(135deg,#4f46e5,#7c3aed);
        }

        .bg-tasks {
            background: linear-gradient(135deg,#0891b2,#2563eb);
        }

        .bg-completed {
            background: linear-gradient(135deg,#059669,#22c55e);
        }

        .bg-overdue {
            background: linear-gradient(135deg,#dc2626,#f97316);
        }

        /* ===========================
           SECTION CARD
        ============================*/

        .dashboard-card {
            background: white;
            border-radius: 26px;
            padding: 28px;
            box-shadow: 0 12px 30px rgba(0,0,0,0.05);
            height: 100%;
        }

        .card-title-custom {
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 25px;
            color: #111827;
        }

        /* ===========================
           CHART
        ============================*/

        .chart-wrapper {
            position: relative;
            height: 360px;
        }

        /* ===========================
           ACTIVITY
        ============================*/

        .activity-item {
            display: flex;
            align-items: center;
            padding: 18px 0;
            border-bottom: 1px solid #f1f5f9;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 55px;
            height: 55px;
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 20px;
            margin-right: 18px;
            flex-shrink: 0;
        }

        .activity-content h6 {
            margin: 0;
            font-weight: 600;
            color: #111827;
            font-size: 15px;
        }

        .activity-content p {
            margin: 4px 0 0;
            color: #6b7280;
            font-size: 14px;
        }

        /* ===========================
           RESPONSIVE
        ============================*/

        @media(max-width:991px) {

            .stats-card {
                height: auto;
            }

            .chart-wrapper {
                height: 300px;
            }

        }

    </style>

</asp:Content>

<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <!-- HIDDEN LABELS -->

    <asp:Label ID="lblPending"
        runat="server"
        ClientIDMode="Static"
        Style="display:none;"></asp:Label>

    <asp:Label ID="lblInProgress"
        runat="server"
        ClientIDMode="Static"
        Style="display:none;"></asp:Label>

    <asp:Label ID="lblCompletedHidden"
        runat="server"
        ClientIDMode="Static"
        Style="display:none;"></asp:Label>

    <asp:Label ID="lblOverdueHidden"
        runat="server"
        ClientIDMode="Static"
        Style="display:none;"></asp:Label>

    <!-- HEADER -->

    <div class="dashboard-header">

        <h2 class="dashboard-title">
            Dashboard Overview
        </h2>

        <p class="dashboard-subtitle">
            Monitor projects, tasks, progress and team activities in real-time.
        </p>

    </div>

    <!-- STATS -->

    <div class="row g-4">

        <!-- PROJECTS -->

        <div class="col-xl-3 col-md-6">

            <div class="stats-card bg-projects">

                <div class="stats-icon">
                    <i class="bi bi-folder-fill"></i>
                </div>

                <div class="stats-number">
                    <asp:Label ID="lblProjects"
                        runat="server"
                        Text="0"></asp:Label>
                </div>

                <div class="stats-text">
                    Total Projects
                </div>

            </div>

        </div>

        <!-- TASKS -->

        <div class="col-xl-3 col-md-6">

            <div class="stats-card bg-tasks">

                <div class="stats-icon">
                    <i class="bi bi-list-task"></i>
                </div>

                <div class="stats-number">
                    <asp:Label ID="lblTasks"
                        runat="server"
                        Text="0"></asp:Label>
                </div>

                <div class="stats-text">
                    Total Tasks
                </div>

            </div>

        </div>

        <!-- COMPLETED -->

        <div class="col-xl-3 col-md-6">

            <div class="stats-card bg-completed">

                <div class="stats-icon">
                    <i class="bi bi-check-circle-fill"></i>
                </div>

                <div class="stats-number">
                    <asp:Label ID="lblCompleted"
                        runat="server"
                        Text="0"></asp:Label>
                </div>

                <div class="stats-text">
                    Completed Tasks
                </div>

            </div>

        </div>

        <!-- OVERDUE -->

        <div class="col-xl-3 col-md-6">

            <div class="stats-card bg-overdue">

                <div class="stats-icon">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                </div>

                <div class="stats-number">
                    <asp:Label ID="lblOverdue"
                        runat="server"
                        Text="0"></asp:Label>
                </div>

                <div class="stats-text">
                    Overdue Tasks
                </div>

            </div>

        </div>

    </div>

    <!-- CHART + ACTIVITIES -->

    <div class="row mt-4 g-4">

        <!-- CHART -->

        <div class="col-lg-8">

            <div class="dashboard-card">

                <h4 class="card-title-custom">
                    Task Analytics
                </h4>

                <div class="chart-wrapper">

                    <canvas id="taskChart"></canvas>

                </div>

            </div>

        </div>

        <!-- ACTIVITIES -->

        <div class="col-lg-4">

            <div class="dashboard-card">

                <h4 class="card-title-custom">
                    Recent Activities
                </h4>

                <div class="activity-item">

                    <div class="activity-icon bg-primary">
                        <i class="bi bi-folder-plus"></i>
                    </div>

                    <div class="activity-content">
                        <h6>Project Created</h6>
                        <p>New development project added.</p>
                    </div>

                </div>

                <div class="activity-item">

                    <div class="activity-icon bg-success">
                        <i class="bi bi-check-circle"></i>
                    </div>

                    <div class="activity-content">
                        <h6>Task Completed</h6>
                        <p>One task has been marked completed.</p>
                    </div>

                </div>

                <div class="activity-item">

                    <div class="activity-icon bg-warning">
                        <i class="bi bi-clock-history"></i>
                    </div>

                    <div class="activity-content">
                        <h6>Pending Tasks</h6>
                        <p>Track all pending tasks efficiently.</p>
                    </div>

                </div>

                <div class="activity-item">

                    <div class="activity-icon bg-danger">
                        <i class="bi bi-exclamation-circle"></i>
                    </div>

                    <div class="activity-content">
                        <h6>Overdue Tasks</h6>
                        <p>Tasks requiring immediate attention.</p>
                    </div>

                </div>

            </div>

        </div>

    </div>

    <!-- CHART SCRIPT -->

    <script>

        window.addEventListener('load', function () {

            var completed =
                parseInt(document.getElementById('lblCompletedHidden').textContent) || 0;

            var pending =
                parseInt(document.getElementById('lblPending').textContent) || 0;

            var progress =
                parseInt(document.getElementById('lblInProgress').textContent) || 0;

            var overdue =
                parseInt(document.getElementById('lblOverdueHidden').textContent) || 0;

            var canvas = document.getElementById('taskChart');

            if (!canvas)
                return;

            var ctx = canvas.getContext('2d');

            new Chart(ctx, {

                type: 'doughnut',

                data: {

                    labels: [
                        'Completed',
                        'Pending',
                        'In Progress',
                        'Overdue'
                    ],

                    datasets: [{

                        data: [
                            completed,
                            pending,
                            progress,
                            overdue
                        ],

                        backgroundColor: [
                            '#22c55e',
                            '#f59e0b',
                            '#3b82f6',
                            '#ef4444'
                        ],

                        borderWidth: 0,
                        hoverOffset: 12

                    }]
                },

                options: {

                    responsive: true,

                    maintainAspectRatio: false,

                    cutout: '40%',

                    plugins: {

                        legend: {

                            position: 'bottom',

                            labels: {

                                usePointStyle: true,
                                padding: 22,

                                font: {
                                    size: 13
                                }

                            }

                        }

                    }

                }

            });

        });

    </script>

</asp:Content>