<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master"
    AutoEventWireup="true"
    CodeFile="Tasks.aspx.cs"
    Inherits="TeamSync.Admin.Tasks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        body {
            background: #f4f7fc;
            font-family: 'Segoe UI', sans-serif;
        }

        .task-container {
            padding: 30px;
        }

        .page-title {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 25px;
            color: #1e293b;
        }

        .card-box {
            background: white;
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.06);
            margin-bottom: 30px;
        }

        .form-control {
            height: 50px;
            border-radius: 12px;
            border: 1px solid #dbeafe;
            box-shadow: none;
        }

        textarea.form-control {
            height: 120px;
            resize: none;
        }

        .btn-primary {
            background: linear-gradient(135deg,#2563eb,#4f46e5);
            border: none;
            height: 50px;
            border-radius: 12px;
            font-weight: 600;
            width: 100%;
        }

        .btn-primary:hover {
            opacity: 0.9;
        }

        .table th {
            background: #2563eb;
            color: white;
            border: none;
        }

        .table td {
            vertical-align: middle;
        }

        .status-badge {
            padding: 8px 15px;
            border-radius: 30px;
            color: white;
            font-size: 12px;
            font-weight: 600;
        }

        .pending {
            background: #f59e0b;
        }

        .progress {
            background: #3b82f6;
        }

        .completed {
            background: #10b981;
        }

        @media(max-width:768px) {

            .page-title {
                font-size: 24px;
            }
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid task-container">

        <div class="page-title">
            Task Management
        </div>

        <div class="row">

            <!-- Add Task -->
            <div class="col-lg-4">

                <div class="card-box">

                    <h4 class="mb-4">Create New Task</h4>

                    <!-- Task Name -->
                    <div class="mb-3">

                        <label>Task Name</label>

                        <asp:TextBox ID="txtTaskName"
                            runat="server"
                            CssClass="form-control"
                            placeholder="Enter task name">
                        </asp:TextBox>

                    </div>

                    <!-- Description -->
                    <div class="mb-3">

                        <label>Description</label>

                        <asp:TextBox ID="txtDescription"
                            runat="server"
                            CssClass="form-control"
                            TextMode="MultiLine"
                            placeholder="Enter task description">
                        </asp:TextBox>

                    </div>

                    <!-- Project -->
                    <div class="mb-3">

                        <label>Select Project</label>

                        <asp:DropDownList ID="ddlProject"
                            runat="server"
                            CssClass="form-control">
                        </asp:DropDownList>

                    </div>

                    <!-- Assigned User -->
                    <div class="mb-3">

                        <label>Assign To</label>

                        <asp:DropDownList ID="ddlUser"
                            runat="server"
                            CssClass="form-control">
                        </asp:DropDownList>

                    </div>

                    <!-- Status -->
                    <div class="mb-3">

                        <label>Status</label>

                        <asp:DropDownList ID="ddlStatus"
                            runat="server"
                            CssClass="form-control">

                            <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>

                            <asp:ListItem Text="In Progress" Value="In Progress"></asp:ListItem>

                            <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>

                        </asp:DropDownList>

                    </div>

                    <!-- Due Date -->
                    <div class="mb-3">

                        <label>Due Date</label>

                        <asp:TextBox ID="txtDueDate"
                            runat="server"
                            CssClass="form-control"
                            TextMode="Date">
                        </asp:TextBox>

                    </div>

                    <!-- Button -->
                    <div class="mb-3">

                        <asp:Button ID="btnAddTask"
                            runat="server"
                            Text="Create Task"
                            CssClass="btn btn-primary"
                            OnClick="btnAddTask_Click" />

                    </div>

                    <div class="text-center">

                        <asp:Label ID="lblMessage"
                            runat="server">
                        </asp:Label>

                    </div>

                </div>

            </div>

            <!-- Task List -->
            <div class="col-lg-8">

                <div class="card-box">

                    <h4 class="mb-4">All Tasks</h4>

                    <div class="table-responsive">

                        <asp:GridView ID="gvTasks"
                            runat="server"
                            AutoGenerateColumns="False"
                            CssClass="table table-hover table-bordered"
                            GridLines="None">

                            <Columns>

                                <asp:BoundField DataField="TaskName"
                                    HeaderText="Task Name" />

                                <asp:BoundField DataField="ProjectName"
                                    HeaderText="Project" />

                                <asp:BoundField DataField="FullName"
                                    HeaderText="Assigned To" />

                                <asp:BoundField DataField="Status"
                                    HeaderText="Status" />

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