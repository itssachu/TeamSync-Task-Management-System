<%@ Page Title="Calendar" Language="C#" MasterPageFile="~/UserMaster.master"
    AutoEventWireup="true"
    CodeBehind="Calendar.aspx.cs"
    Inherits="TeamSync.User.Calendar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title>Team Calendar</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />

    <!-- FullCalendar -->
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.css" rel="stylesheet" />

    <style>
        body {
            background: #f4f7fb;
            font-family: 'Segoe UI', sans-serif;
        }

        .calendar-wrapper {
            padding: 30px;
        }

        .page-title {
            font-size: 32px;
            font-weight: 700;
            color: #111827;
            margin-bottom: 25px;
        }

        .top-card {
            background: white;
            border-radius: 22px;
            padding: 25px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.06);
            margin-bottom: 25px;
        }

        .stats-card {
            background: linear-gradient(135deg,#4f46e5,#7c3aed);
            color: white;
            border-radius: 20px;
            padding: 25px;
            height: 100%;
        }

        .stats-card h2 {
            font-size: 34px;
            font-weight: 700;
        }

        .stats-card p {
            opacity: 0.9;
            margin-bottom: 0;
        }

        .event-card {
            background: #ffffff;
            border-radius: 18px;
            padding: 18px;
            margin-bottom: 18px;
            border-left: 5px solid #4f46e5;
            box-shadow: 0 5px 18px rgba(0,0,0,0.05);
        }

        .event-title {
            font-size: 18px;
            font-weight: 700;
            color: #111827;
        }

        .event-date {
            color: #6b7280;
            font-size: 14px;
            margin-top: 6px;
        }

        .calendar-card {
            background: white;
            border-radius: 25px;
            padding: 25px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.06);
        }

        #calendar {
            width: 100%;
        }

        .fc .fc-toolbar-title {
            font-size: 24px;
            font-weight: 700;
        }

        .fc .fc-button {
            background: #4f46e5 !important;
            border: none !important;
            padding: 8px 15px !important;
            border-radius: 10px !important;
        }

        .fc-event {
            border: none !important;
            padding: 4px !important;
            border-radius: 8px !important;
        }

        .empty-box {
            background: white;
            border-radius: 20px;
            padding: 40px;
            text-align: center;
            box-shadow: 0 8px 20px rgba(0,0,0,0.05);
        }

        .empty-box i {
            font-size: 70px;
            color: #d1d5db;
        }

        .empty-box h4 {
            margin-top: 15px;
            font-weight: 700;
        }

        @media(max-width:768px) {

            .calendar-wrapper {
                padding: 15px;
            }

            .page-title {
                font-size: 25px;
            }
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid calendar-wrapper">

        <!-- PAGE TITLE -->
        <div class="page-title">
            Team Calendar
        </div>

        <!-- TOP ROW -->
        <div class="row mb-4">

            <!-- STATS -->
            <div class="col-lg-4">

                <div class="stats-card">

                    <h2>
                        <asp:Label ID="lblTotalEvents" runat="server" Text="0"></asp:Label>
                    </h2>

                    <p>
                        Upcoming Events & Tasks
                    </p>

                </div>

            </div>

            <!-- UPCOMING EVENTS -->
            <div class="col-lg-8">

                <div class="top-card">

                    <h4 class="mb-4 fw-bold">
                        Upcoming Schedule
                    </h4>

                    <asp:Repeater ID="rptEvents" runat="server">

                        <ItemTemplate>

                            <div class="event-card">

                                <div class="event-title">
                                    <%# Eval("Title") %>
                                </div>

                                <div class="event-date">
                                    <i class="bi bi-calendar-event"></i>

                                    <%# Convert.ToDateTime(Eval("EventDate")).ToString("dd MMM yyyy") %>
                                </div>

                            </div>

                        </ItemTemplate>

                    </asp:Repeater>

                    <asp:Panel ID="pnlNoEvents" runat="server" Visible="false">

                        <div class="empty-box">

                            <i class="bi bi-calendar-x"></i>

                            <h4>No Upcoming Events</h4>

                            <p class="text-muted">
                                There are no upcoming schedules available.
                            </p>

                        </div>

                    </asp:Panel>

                </div>

            </div>

        </div>

        <!-- CALENDAR -->
        <div class="calendar-card">

            <div id="calendar"></div>

        </div>

    </div>

    <!-- Hidden Field -->
    <asp:HiddenField ID="hfEvents" runat="server" />

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>

    <script>

        document.addEventListener('DOMContentLoaded', function () {

            var calendarEl =
                document.getElementById('calendar');

            var eventsData =
                JSON.parse(document.getElementById('<%= hfEvents.ClientID %>').value);

            var calendar =
                new FullCalendar.Calendar(calendarEl, {

                    initialView: 'dayGridMonth',

                    height: 700,

                    headerToolbar: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'dayGridMonth,timeGridWeek,timeGridDay'
                    },

                    events: eventsData

                });

            calendar.render();
        });

    </script>

</asp:Content>