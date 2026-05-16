<%@ Page Title="Notifications" Language="C#" MasterPageFile="~/UserMaster.master"
    AutoEventWireup="true"
    CodeBehind="Notifications.aspx.cs"
    Inherits="TeamSync.User.Notifications" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title>Notifications</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />

    <style>
        body {
            background: #f4f7fb;
            font-family: 'Segoe UI', sans-serif;
        }

        .notification-wrapper {
            padding: 30px;
        }

        .page-title {
            font-size: 32px;
            font-weight: 700;
            color: #111827;
            margin-bottom: 25px;
        }

        .stats-card {
            background: linear-gradient(135deg,#4f46e5,#7c3aed);
            color: white;
            border-radius: 22px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
        }

        .stats-card h2 {
            font-size: 40px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stats-card p {
            opacity: 0.9;
            margin-bottom: 0;
        }

        .notification-card {
            background: white;
            border-radius: 20px;
            padding: 22px;
            margin-bottom: 18px;
            display: flex;
            align-items: flex-start;
            gap: 18px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.05);
            transition: 0.3s;
        }

        .notification-card:hover {
            transform: translateY(-3px);
        }

        .notification-icon {
            width: 55px;
            height: 55px;
            border-radius: 15px;
            background: rgba(79,70,229,0.1);
            color: #4f46e5;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            flex-shrink: 0;
        }

        .notification-content {
            flex: 1;
        }

        .notification-title {
            font-size: 18px;
            font-weight: 700;
            color: #111827;
            margin-bottom: 8px;
        }

        .notification-message {
            color: #6b7280;
            line-height: 1.7;
            margin-bottom: 8px;
        }

        .notification-date {
            color: #9ca3af;
            font-size: 13px;
        }

        .empty-box {
            background: white;
            border-radius: 22px;
            padding: 60px 30px;
            text-align: center;
            box-shadow: 0 8px 20px rgba(0,0,0,0.05);
        }

        .empty-box i {
            font-size: 70px;
            color: #d1d5db;
        }

        .empty-box h3 {
            margin-top: 18px;
            font-weight: 700;
            color: #111827;
        }

        .empty-box p {
            color: #6b7280;
        }

        @media(max-width:768px) {

            .notification-wrapper {
                padding: 15px;
            }

            .page-title {
                font-size: 25px;
            }

            .notification-card {
                flex-direction: column;
            }
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid notification-wrapper">

        <!-- PAGE TITLE -->
        <div class="page-title">
            Notifications
        </div>

        <!-- TOP CARD -->
        <div class="stats-card">

            <h2>
                <asp:Label ID="lblTotalNotifications" runat="server" Text="0"></asp:Label>
            </h2>

            <p>
                Total Recent Notifications
            </p>

        </div>

        <!-- NOTIFICATION LIST -->

        <asp:Repeater ID="rptNotifications" runat="server">

            <ItemTemplate>

                <div class="notification-card">

                    <div class="notification-icon">

                        <i class="bi bi-bell-fill"></i>

                    </div>

                    <div class="notification-content">

                        <div class="notification-title">
                            <%# Eval("Title") %>
                        </div>

                        <div class="notification-message">
                            <%# Eval("Message") %>
                        </div>

                        <div class="notification-date">

                            <i class="bi bi-clock"></i>

                            <%# Convert.ToDateTime(Eval("CreatedAt")).ToString("dd MMM yyyy hh:mm tt") %>

                        </div>

                    </div>

                </div>

            </ItemTemplate>

        </asp:Repeater>

        <!-- EMPTY -->
        <asp:Panel ID="pnlEmpty" runat="server" Visible="false">

            <div class="empty-box">

                <i class="bi bi-bell-slash"></i>

                <h3>No Notifications</h3>

                <p>
                    You currently do not have any notifications.
                </p>

            </div>

        </asp:Panel>

    </div>

</asp:Content>