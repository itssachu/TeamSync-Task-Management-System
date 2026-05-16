<%@ Page Title="Projects" Language="C#" MasterPageFile="~/UserMaster.master"
    AutoEventWireup="true"
    CodeBehind="Projects.aspx.cs"
    Inherits="TeamSync.User.Projects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title>My Projects</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />

    <style>
        body {
            background: #f4f7fb;
            font-family: 'Segoe UI', sans-serif;
        }

        .page-wrapper {
            padding: 30px;
        }

        .page-title {
            font-size: 32px;
            font-weight: 700;
            color: #111827;
            margin-bottom: 25px;
        }

        .stats-card {
            background: white;
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.06);
            margin-bottom: 25px;
            transition: 0.3s;
        }

        .stats-card:hover {
            transform: translateY(-4px);
        }

        .stats-icon {
            width: 65px;
            height: 65px;
            border-radius: 18px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 28px;
            color: white;
            margin-bottom: 18px;
        }

        .icon-total {
            background: linear-gradient(135deg,#4f46e5,#7c3aed);
        }

        .icon-active {
            background: linear-gradient(135deg,#10b981,#059669);
        }

        .icon-completed {
            background: linear-gradient(135deg,#f59e0b,#d97706);
        }

        .stats-number {
            font-size: 30px;
            font-weight: 700;
            color: #111827;
        }

        .stats-text {
            color: #6b7280;
            font-size: 15px;
        }

        .project-card {
            background: white;
            border-radius: 22px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0,0,0,0.06);
            transition: 0.3s;
            margin-bottom: 30px;
            height: 100%;
        }

        .project-card:hover {
            transform: translateY(-5px);
        }

        .project-header {
            padding: 25px;
            color: white;
            position: relative;
        }

        .gradient-1 {
            background: linear-gradient(135deg,#4f46e5,#7c3aed);
        }

        .gradient-2 {
            background: linear-gradient(135deg,#0ea5e9,#2563eb);
        }

        .gradient-3 {
            background: linear-gradient(135deg,#10b981,#059669);
        }

        .project-title {
            font-size: 24px;
            font-weight: 700;
        }

        .project-date {
            opacity: 0.9;
            margin-top: 6px;
        }

        .project-body {
            padding: 25px;
        }

        .project-description {
            color: #6b7280;
            line-height: 1.8;
            margin-bottom: 20px;
        }

        .project-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        .project-label {
            color: #6b7280;
            font-size: 14px;
        }

        .project-value {
            font-weight: 600;
            color: #111827;
        }

        .status-badge {
            padding: 8px 18px;
            border-radius: 30px;
            font-size: 13px;
            font-weight: 600;
            color: white;
        }

        .status-active {
            background: #10b981;
        }

        .status-completed {
            background: #6366f1;
        }

        .progress {
            height: 12px;
            border-radius: 20px;
            background: #e5e7eb;
        }

        .progress-bar {
            border-radius: 20px;
        }

        .empty-box {
            background: white;
            padding: 60px;
            border-radius: 20px;
            text-align: center;
            box-shadow: 0 8px 25px rgba(0,0,0,0.05);
        }

        .empty-box i {
            font-size: 70px;
            color: #cbd5e1;
        }

        .empty-box h3 {
            margin-top: 20px;
            font-weight: 700;
            color: #334155;
        }

        @media(max-width:768px) {

            .page-wrapper {
                padding: 15px;
            }

            .page-title {
                font-size: 26px;
            }
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid page-wrapper">

        <!-- TITLE -->
        <div class="page-title">
            My Projects
        </div>

        <!-- STATS -->
        <div class="row">

            <div class="col-lg-4 col-md-6">
                <div class="stats-card">

                    <div class="stats-icon icon-total">
                        <i class="bi bi-folder-fill"></i>
                    </div>

                    <div class="stats-number">
                        <asp:Label ID="lblTotalProjects" runat="server" Text="0"></asp:Label>
                    </div>

                    <div class="stats-text">
                        Total Projects
                    </div>

                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="stats-card">

                    <div class="stats-icon icon-active">
                        <i class="bi bi-lightning-charge-fill"></i>
                    </div>

                    <div class="stats-number">
                        <asp:Label ID="lblActiveProjects" runat="server" Text="0"></asp:Label>
                    </div>

                    <div class="stats-text">
                        Active Projects
                    </div>

                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="stats-card">

                    <div class="stats-icon icon-completed">
                        <i class="bi bi-check-circle-fill"></i>
                    </div>

                    <div class="stats-number">
                        <asp:Label ID="lblCompletedProjects" runat="server" Text="0"></asp:Label>
                    </div>

                    <div class="stats-text">
                        Completed Projects
                    </div>

                </div>
            </div>

        </div>

        <!-- PROJECTS -->
        <div class="row">

            <asp:Repeater ID="rptProjects" runat="server">

                <ItemTemplate>

                    <div class="col-lg-4 col-md-6">

                        <div class="project-card">

                            <div class='project-header <%# Container.ItemIndex % 3 == 0 ? "gradient-1" : Container.ItemIndex % 3 == 1 ? "gradient-2" : "gradient-3" %>'>

                                <div class="project-title">
                                    <%# Eval("ProjectName") %>
                                </div>

                                <div class="project-date">
                                    Created:
                                    <%# Convert.ToDateTime(Eval("CreatedAt")).ToString("dd MMM yyyy") %>
                                </div>

                            </div>

                            <div class="project-body">

                                <div class="project-description">
                                    <%# Eval("Description") %>
                                </div>

                                <div class="project-info">

                                    <div class="project-label">
                                        Status
                                    </div>

                                    <div>
                                        <span class='status-badge <%# Eval("Status").ToString() == "Completed" ? "status-completed" : "status-active" %>'>

                                            <%# Eval("Status") %>

                                        </span>
                                    </div>

                                </div>

                                <div class="project-info">

                                    <div class="project-label">
                                        Team Members
                                    </div>

                                    <div class="project-value">
                                        <%# Eval("TeamCount") %>
                                    </div>

                                </div>

                                <div class="project-info">

                                    <div class="project-label">
                                        Progress
                                    </div>

                                    <div class="project-value">
                                        <%# Eval("Progress") %>%
                                    </div>

                                </div>

                                <div class="progress mt-3">

                                    <div class="progress-bar bg-success"
                                        style='width:<%# Eval("Progress") %>%'>
                                    </div>

                                </div>

                            </div>

                        </div>

                    </div>

                </ItemTemplate>

            </asp:Repeater>

        </div>

        <!-- EMPTY -->
        <asp:Panel ID="pnlEmpty" runat="server" Visible="false">

            <div class="empty-box">

                <i class="bi bi-folder-x"></i>

                <h3>No Projects Found</h3>

                <p class="text-muted mt-2">
                    You are not assigned to any projects yet.
                </p>

            </div>

        </asp:Panel>

    </div>

</asp:Content>