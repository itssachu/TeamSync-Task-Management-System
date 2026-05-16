<%@ Page Title="My Tasks" Language="C#" MasterPageFile="~/UserMaster.master" AutoEventWireup="true" CodeBehind="MyTasks.aspx.cs" Inherits="TeamSync.User.MyTasks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>

        .page-header {
            margin-bottom: 30px;
        }

        .page-title {
            font-size: 34px;
            font-weight: 700;
            color: #0f172a;
        }

        .page-subtitle {
            color: #64748b;
            margin-top: 5px;
        }

        .filter-card {
            background: white;
            border-radius: 22px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            margin-bottom: 25px;
        }

        .task-card {
            background: white;
            border-radius: 22px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }

        .gridview {
            width: 100%;
            border-collapse: collapse;
        }

        .gridview th {
            background: #4f46e5;
            color: white;
            padding: 16px;
            font-weight: 600;
            border: none;
        }

        .gridview td {
            padding: 16px;
            border-bottom: 1px solid #e2e8f0;
            color: #334155;
            vertical-align: middle;
        }

        .gridview tr:hover {
            background: #f8fafc;
        }

        .badge-status {
            padding: 8px 14px;
            border-radius: 50px;
            font-size: 13px;
            font-weight: 600;
        }

        .status-pending {
            background: #fef3c7;
            color: #92400e;
        }

        .status-progress {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .status-completed {
            background: #d1fae5;
            color: #065f46;
        }

        .priority-high {
            color: #dc2626;
            font-weight: 700;
        }

        .priority-medium {
            color: #d97706;
            font-weight: 700;
        }

        .priority-low {
            color: #059669;
            font-weight: 700;
        }

        .btn-update {
            border: none;
            padding: 10px 18px;
            border-radius: 12px;
            background: linear-gradient(135deg,#4f46e5,#7c3aed);
            color: white;
            font-weight: 600;
            transition: 0.3s;
        }

        .btn-update:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(79,70,229,0.3);
        }

        .form-select {
            height: 48px;
            border-radius: 12px;
        }

        @media(max-width:768px) {

            .gridview {
                font-size: 13px;
            }

            .page-title {
                font-size: 28px;
            }
        }

    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Header -->
    <div class="page-header">

        <div class="page-title">
            My Tasks
        </div>

        <div class="page-subtitle">
            View and manage your assigned tasks
        </div>

    </div>

    <!-- Filters -->
    <div class="filter-card">

        <div class="row g-3">

            <div class="col-md-4">

                <asp:DropDownList
                    ID="ddlStatus"
                    runat="server"
                    CssClass="form-select"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">

                    <asp:ListItem Text="All Status" Value=""></asp:ListItem>
                    <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                    <asp:ListItem Text="In Progress" Value="In Progress"></asp:ListItem>
                    <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>

                </asp:DropDownList>

            </div>

        </div>

    </div>

    <!-- Task Table -->
    <div class="task-card">

        <div class="table-responsive">

            <asp:GridView
                ID="gvTasks"
                runat="server"
                AutoGenerateColumns="False"
                CssClass="gridview"
                DataKeyNames="TaskID"
                OnRowCommand="gvTasks_RowCommand">

                <Columns>

                    <asp:BoundField
                        DataField="TaskTitle"
                        HeaderText="Task" />

                    <asp:BoundField
                        DataField="Description"
                        HeaderText="Description" />

                    <asp:TemplateField HeaderText="Priority">

                        <ItemTemplate>

                            <span class='<%#
                                Eval("Priority").ToString() == "High"
                                ? "priority-high"
                                : Eval("Priority").ToString() == "Medium"
                                ? "priority-medium"
                                : "priority-low"
                            %>'>

                                <%# Eval("Priority") %>

                            </span>

                        </ItemTemplate>

                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Status">

                        <ItemTemplate>

                            <span class='<%#
                                Eval("Status").ToString() == "Pending"
                                ? "badge-status status-pending"
                                : Eval("Status").ToString() == "Completed"
                                ? "badge-status status-completed"
                                : "badge-status status-progress"
                            %>'>

                                <%# Eval("Status") %>

                            </span>

                        </ItemTemplate>

                    </asp:TemplateField>

                    <asp:BoundField
                        DataField="DueDate"
                        HeaderText="Due Date"
                        DataFormatString="{0:dd MMM yyyy}" />

                    <asp:TemplateField HeaderText="Update">

                        <ItemTemplate>

                            <asp:DropDownList
                                ID="ddlTaskStatus"
                                runat="server"
                                CssClass="form-select">

                                <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                                <asp:ListItem Text="In Progress" Value="In Progress"></asp:ListItem>
                                <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>

                            </asp:DropDownList>

                        </ItemTemplate>

                    </asp:TemplateField>

                    <asp:TemplateField>

                        <ItemTemplate>

                            <asp:Button
                                ID="btnUpdate"
                                runat="server"
                                Text="Update"
                                CssClass="btn-update"
                                CommandName="UpdateTask"
                                CommandArgument='<%# Eval("TaskID") %>' />

                        </ItemTemplate>

                    </asp:TemplateField>

                </Columns>

            </asp:GridView>

        </div>

    </div>

</asp:Content>