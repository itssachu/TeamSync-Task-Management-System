<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="TeamSync.User.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <!-- Chart JS -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        .page-title {
            font-size: 32px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 30px;
        }

        .stats-card {
            background: white;
            border-radius: 22px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            transition: 0.3s;
            height: 100%;
        }

        .stats-card:hover {
            transform: translateY(-5px);
        }

        .stats-icon {
            width: 65px;
            height: 65px;
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            color: white;
            margin-bottom: 18px;
        }

        .bg-blue {
            background: linear-gradient(135deg,#3b82f6,#2563eb);
        }

        .bg-green {
            background: linear-gradient(135deg,#10b981,#059669);
        }

        .bg-orange {
            background: linear-gradient(135deg,#f59e0b,#d97706);
        }

        .bg-red {
            background: linear-gradient(135deg,#ef4444,#dc2626);
        }

        .stats-number {
            font-size: 34px;
            font-weight: 700;
            color: #0f172a;
        }

        .stats-title {
            color: #64748b;
            font-size: 15px;
            margin-top: 5px;
        }

        .dashboard-card {
            background: white;
            border-radius: 22px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            margin-top: 25px;
        }

        .card-title-custom {
            font-size: 22px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #0f172a;
        }

        .task-item {
            padding: 15px;
            border-radius: 15px;
            background: #f8fafc;
            margin-bottom: 15px;
            border-left: 5px solid #3b82f6;
        }

        .task-title {
            font-size: 17px;
            font-weight: 600;
            color: #0f172a;
        }

        .task-meta {
            margin-top: 5px;
            font-size: 14px;
            color: #64748b;
        }

        .chart-container {
            height: 350px;
        }

        .welcome-box {
            background: linear-gradient(135deg,#4f46e5,#7c3aed);
            color: white;
            border-radius: 25px;
            padding: 40px;
            margin-bottom: 30px;
        }

        .welcome-box h2 {
            font-size: 36px;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .welcome-box p {
            opacity: 0.9;
            margin-bottom: 0;
        }

        @media(max-width:768px) {

            .welcome-box h2 {
                font-size: 28px;
            }

            .stats-number {
                font-size: 28px;
            }
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Welcome Section -->
    <div class="welcome-box">

        <h2>
            Welcome,
            <asp:Label ID="lblName" runat="server"></asp:Label>
            👋
        </h2>

        <p>
            Here’s your productivity overview and latest task updates.
        </p>

    </div>

    <!-- Stats Cards -->
    <div class="row g-4">

        <!-- Total Tasks -->
        <div class="col-lg-3 col-md-6">

            <div class="stats-card">

                <div class="stats-icon bg-blue">
                    <i class="bi bi-list-task"></i>
                </div>

                <div class="stats-number">
                    <asp:Label ID="lblTotalTasks" runat="server" Text="0"></asp:Label>
                </div>

                <div class="stats-title">
                    Total Tasks
                </div>

            </div>

        </div>

        <!-- Pending -->
        <div class="col-lg-3 col-md-6">

            <div class="stats-card">

                <div class="stats-icon bg-orange">
                    <i class="bi bi-hourglass-split"></i>
                </div>

                <div class="stats-number">
                    <asp:Label ID="lblPendingTasks" runat="server" Text="0"></asp:Label>
                </div>

                <div class="stats-title">
                    Pending Tasks
                </div>

            </div>

        </div>

        <!-- Completed -->
        <div class="col-lg-3 col-md-6">

            <div class="stats-card">

                <div class="stats-icon bg-green">
                    <i class="bi bi-check-circle-fill"></i>
                </div>

                <div class="stats-number">
                    <asp:Label ID="lblCompletedTasks" runat="server" Text="0"></asp:Label>
                </div>

                <div class="stats-title">
                    Completed Tasks
                </div>

            </div>

        </div>

        <!-- Overdue -->
        <div class="col-lg-3 col-md-6">

            <div class="stats-card">

                <div class="stats-icon bg-red">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                </div>

                <div class="stats-number">
                    <asp:Label ID="lblOverdueTasks" runat="server" Text="0"></asp:Label>
                </div>

                <div class="stats-title">
                    Overdue Tasks
                </div>

            </div>

        </div>

    </div>

    <!-- Charts + Recent Tasks -->
    <div class="row">

        <!-- Chart -->
        <div class="col-lg-7">

            <div class="dashboard-card">

                <h4 class="card-title-custom">
                    Task Analytics
                </h4>

                <div class="chart-container">
                    <canvas id="taskChart"></canvas>
                </div>

            </div>

        </div>

        <!-- Recent Tasks -->
        <div class="col-lg-5">

            <div class="dashboard-card">

                <h4 class="card-title-custom">
                    Recent Tasks
                </h4>

                <asp:Repeater ID="rptTasks" runat="server">

                    <ItemTemplate>

                        <div class="task-item">

                            <div class="task-title">
                                <%# Eval("TaskTitle") %>
                            </div>

                            <div class="task-meta">

                                Status:
                                <%# Eval("Status") %>

                                |
                                Priority:
                                <%# Eval("Priority") %>

                                <br />

                                Due:
                                <%# Convert.ToDateTime(Eval("DueDate")).ToString("dd MMM yyyy") %>

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

            </div>

        </div>

    </div>

    <!-- Hidden Labels -->
    <asp:Label ID="lblPendingHidden" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblCompletedHidden" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblOverdueHidden" runat="server" Visible="false"></asp:Label>

    <!-- Chart Script -->
    <script>

        window.onload = function () {

            var pending =
                document.getElementById('<%= lblPendingHidden.ClientID %>').innerText;

            var completed =
                document.getElementById('<%= lblCompletedHidden.ClientID %>').innerText;

            var overdue =
                document.getElementById('<%= lblOverdueHidden.ClientID %>').innerText;

            var ctx =
                document.getElementById('taskChart');

            new Chart(ctx,
                {
                    type: 'doughnut',

                    data:
                    {
                        labels:
                            [
                                'Pending',
                                'Completed',
                                'Overdue'
                            ],

                        datasets:
                            [{
                                data:
                                    [
                                        pending,
                                        completed,
                                        overdue
                                    ],

                                backgroundColor:
                                    [
                                        '#f59e0b',
                                        '#10b981',
                                        '#ef4444'
                                    ],

                                borderWidth: 0
                            }]
                    },

                    options:
                    {
                        responsive: true,
                        maintainAspectRatio: false
                    }
                });
        };

    </script>

</asp:Content>