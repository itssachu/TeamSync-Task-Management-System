<%@ Page Title="Tasks" Language="C#" MasterPageFile="~/MasterPage.Master"
    AutoEventWireup="true"
    CodeBehind="Tasks.aspx.cs"
    Inherits="TeamSync.Admin.Tasks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        body {
            background: #f5f7fb;
            font-family: 'Segoe UI', sans-serif;
        }

        .task-wrapper {
            padding: 25px;
        }

        .page-title {
            font-size: 32px;
            font-weight: 700;
            color: #0f172a;
        }

        .page-subtitle {
            color: #64748b;
            margin-bottom: 25px;
        }

        .custom-card {
            background: white;
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            margin-bottom: 25px;
        }

        .section-title {
            font-size: 22px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #1e293b;
        }

        .form-label {
            font-weight: 600;
            margin-bottom: 8px;
            color: #334155;
        }

        .form-control {
            height: 50px;
            border-radius: 12px;
            border: 1px solid #dbeafe;
            box-shadow: none !important;
        }

        textarea.form-control {
            height: 120px !important;
            resize: none;
        }

        .btn-create {
            width: 100%;
            height: 50px;
            border: none;
            border-radius: 12px;
            background: linear-gradient(135deg,#2563eb,#4f46e5);
            color: white;
            font-weight: 600;
            transition: .3s;
        }

        .btn-create:hover {
            transform: translateY(-2px);
            opacity: .95;
        }

        .table th {
            background: #2563eb;
            color: white;
            border: none;
            padding: 15px;
        }

        .table td {
            padding: 14px;
            vertical-align: middle;
        }

        .status-badge {
            padding: 7px 14px;
            border-radius: 30px;
            color: white;
            font-size: 12px;
            font-weight: 600;
        }

        .pending {
            background: #f59e0b;
        }

        .progress-status {
            background: #3b82f6;
        }

        .completed {
            background: #10b981;
        }

        @media(max-width:768px) {

            .task-wrapper {
                padding: 15px;
            }

            .page-title {
                font-size: 24px;
            }
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid task-wrapper">

        <!-- PAGE HEADER -->

        <div class="page-title">
            Task Management
        </div>

        <div class="page-subtitle">
            Manage project tasks and assign work to team members
        </div>

        <div class="row">

            <!-- CREATE TASK -->

            <div class="col-lg-4">

                <div class="custom-card">

                    <div class="section-title">
                        Create New Task
                    </div>

                    <!-- TASK TITLE -->

                    <div class="mb-3">

                        <label class="form-label">
                            Task Title
                        </label>

                        <asp:TextBox ID="txtTaskName"
                            runat="server"
                            CssClass="form-control"
                            placeholder="Enter task title">
                        </asp:TextBox>

                    </div>

                    <!-- DESCRIPTION -->

                    <div class="mb-3">

                        <label class="form-label">
                            Description
                        </label>

                        <asp:TextBox ID="txtDescription"
                            runat="server"
                            CssClass="form-control"
                            TextMode="MultiLine"
                            placeholder="Enter task details">
                        </asp:TextBox>

                    </div>

                    <!-- PROJECT -->

                    <div class="mb-3">

                        <label class="form-label">
                            Select Project
                        </label>

                        <asp:DropDownList ID="ddlProject"
                            runat="server"
                            CssClass="form-control">
                        </asp:DropDownList>

                    </div>

                    <!-- ASSIGNED USER -->

                    <div class="mb-3">

                        <label class="form-label">
                            Assign To
                        </label>

                        <asp:DropDownList ID="ddlUser"
                            runat="server"
                            CssClass="form-control">
                        </asp:DropDownList>

                    </div>

                    <!-- PRIORITY -->

                    <div class="mb-3">

                        <label class="form-label">
                            Priority
                        </label>

                        <asp:DropDownList ID="ddlPriority"
                            runat="server"
                            CssClass="form-control">

                            <asp:ListItem Text="Low" Value="Low"></asp:ListItem>

                            <asp:ListItem Text="Medium" Value="Medium" Selected="True"></asp:ListItem>

                            <asp:ListItem Text="High" Value="High"></asp:ListItem>

                        </asp:DropDownList>

                    </div>

                    <!-- STATUS -->

                    <div class="mb-3">

                        <label class="form-label">
                            Status
                        </label>

                        <asp:DropDownList ID="ddlStatus"
                            runat="server"
                            CssClass="form-control">

                            <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>

                            <asp:ListItem Text="In Progress" Value="In Progress"></asp:ListItem>

                            <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>

                        </asp:DropDownList>

                    </div>

                    <!-- START DATE -->

                    <div class="mb-3">

                        <label class="form-label">
                            Start Date
                        </label>

                        <asp:TextBox ID="txtStartDate"
                            runat="server"
                            CssClass="form-control"
                            TextMode="Date">
                        </asp:TextBox>

                    </div>

                    <!-- DUE DATE -->

                    <div class="mb-4">

                        <label class="form-label">
                            Due Date
                        </label>

                        <asp:TextBox ID="txtDueDate"
                            runat="server"
                            CssClass="form-control"
                            TextMode="Date">
                        </asp:TextBox>

                    </div>

                    <!-- BUTTON -->

                    <asp:Button ID="btnAddTask"
                        runat="server"
                        Text="Create Task"
                        CssClass="btn-create"
                        OnClick="btnAddTask_Click" />

                    <div class="text-center mt-3">

                        <asp:Label ID="lblMessage"
                            runat="server">
                        </asp:Label>

                    </div>

                </div>

            </div>

            <!-- TASK LIST -->

            <div class="col-lg-8">

                <div class="custom-card">

                    <div class="section-title">
                        All Tasks
                    </div>

                    <div class="table-responsive">

                        <asp:GridView ID="gvTasks"
                            runat="server"
                            AutoGenerateColumns="False"
                            CssClass="table table-hover"
                            GridLines="None">

                            <Columns>

                                <asp:BoundField DataField="TaskTitle"
                                    HeaderText="Task" />

                                <asp:BoundField DataField="ProjectName"
                                    HeaderText="Project" />

                                <asp:BoundField DataField="AssignedToName"
                                    HeaderText="Assigned To" />

                                <asp:BoundField DataField="Priority"
                                    HeaderText="Priority" />

                                <asp:TemplateField HeaderText="Status">

                                    <ItemTemplate>

                                        <span class='status-badge <%# GetStatusClass(Eval("Status").ToString()) %>'>

                                            <%# Eval("Status") %>

                                        </span>

                                    </ItemTemplate>

                                </asp:TemplateField>

                                <asp:BoundField DataField="DueDate"
                                    HeaderText="Due Date"
                                    DataFormatString="{0:dd MMM yyyy}" />

                            </Columns>

                        </asp:GridView>

                    </div>

                </div>

            </div>

        </div>

    </div>

</asp:Content>