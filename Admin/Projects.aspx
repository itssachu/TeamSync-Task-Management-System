<%@ Page Title="Projects" Language="C#" MasterPageFile="~/MasterPage.Master"
    AutoEventWireup="true"
    CodeBehind="Projects.aspx.cs"
    Inherits="TeamSync.Admin.Projects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        body {
            background: #f5f7fb;
            font-family: 'Segoe UI', sans-serif;
        }

        .project-wrapper {
            padding: 25px;
        }

        .page-header {
            margin-bottom: 25px;
        }

        .page-title {
            font-size: 32px;
            font-weight: 700;
            color: #1e293b;
        }

        .page-subtitle {
            color: #64748b;
            margin-top: 5px;
        }

        .custom-card {
            background: #fff;
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            margin-bottom: 25px;
        }

        .section-title {
            font-size: 22px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #0f172a;
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
            transition: 0.3s;
        }

        .btn-create:hover {
            transform: translateY(-2px);
            opacity: .95;
        }

        .table {
            border-radius: 15px;
            overflow: hidden;
        }

        .table th {
            background: #2563eb;
            color: white;
            border: none;
            padding: 15px;
        }

        .table td {
            vertical-align: middle;
            padding: 14px;
        }

        .status-badge {
            padding: 8px 16px;
            border-radius: 30px;
            color: white;
            font-size: 12px;
            font-weight: 600;
        }

        .status-active {
            background: #10b981;
        }

        .status-completed {
            background: #6366f1;
        }

        .status-pending {
            background: #f59e0b;
        }

        .empty-box {
            text-align: center;
            padding: 40px;
            color: #94a3b8;
        }

        @media(max-width:768px) {

            .project-wrapper {
                padding: 15px;
            }

            .page-title {
                font-size: 24px;
            }
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid project-wrapper">

        <!-- HEADER -->

        <div class="page-header">

            <div class="page-title">
                Project Management
            </div>

            <div class="page-subtitle">
                Create and manage all projects from one place
            </div>

        </div>

        <div class="row">

            <!-- CREATE PROJECT -->

            <div class="col-lg-4">

                <div class="custom-card">

                    <div class="section-title">
                        Create New Project
                    </div>

                    <div class="mb-3">

                        <label class="form-label">
                            Project Name
                        </label>

                        <asp:TextBox ID="txtProjectName"
                            runat="server"
                            CssClass="form-control"
                            placeholder="Enter project name">
                        </asp:TextBox>

                    </div>

                    <div class="mb-3">

                        <label class="form-label">
                            Description
                        </label>

                        <asp:TextBox ID="txtDescription"
                            runat="server"
                            TextMode="MultiLine"
                            CssClass="form-control"
                            placeholder="Write project details">
                        </asp:TextBox>

                    </div>

                    <div class="mb-3">

                        <label class="form-label">
                            Status
                        </label>

                        <asp:DropDownList ID="ddlStatus"
                            runat="server"
                            CssClass="form-control">

                            <asp:ListItem Text="Active" Value="Active"></asp:ListItem>

                            <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>

                            <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>

                        </asp:DropDownList>

                    </div>

                    <div class="mb-3">

                        <label class="form-label">
                            Start Date
                        </label>

                        <asp:TextBox ID="txtStartDate"
                            runat="server"
                            TextMode="Date"
                            CssClass="form-control">
                        </asp:TextBox>

                    </div>

                    <div class="mb-4">

                        <label class="form-label">
                            End Date
                        </label>

                        <asp:TextBox ID="txtEndDate"
                            runat="server"
                            TextMode="Date"
                            CssClass="form-control">
                        </asp:TextBox>

                    </div>

                    <asp:Button ID="btnAddProject"
                        runat="server"
                        Text="Create Project"
                        CssClass="btn-create"
                        OnClick="btnAddProject_Click" />

                    <div class="mt-3 text-center">

                        <asp:Label ID="lblMessage"
                            runat="server">
                        </asp:Label>

                    </div>

                </div>

            </div>

            <!-- PROJECT LIST -->

            <div class="col-lg-8">

                <div class="custom-card">

                    <div class="section-title">
                        All Projects
                    </div>

                    <div class="table-responsive">

                        <asp:GridView ID="gvProjects"
                            runat="server"
                            AutoGenerateColumns="False"
                            CssClass="table table-hover"
                            GridLines="None"
                            EmptyDataText="No projects found">

                            <Columns>

                                <asp:BoundField DataField="ProjectName"
                                    HeaderText="Project" />

                                <asp:BoundField DataField="Description"
                                    HeaderText="Description" />

                                <asp:BoundField DataField="StartDate"
                                    HeaderText="Start"
                                    DataFormatString="{0:dd MMM yyyy}" />

                                <asp:BoundField DataField="EndDate"
                                    HeaderText="End"
                                    DataFormatString="{0:dd MMM yyyy}" />

                                <asp:TemplateField HeaderText="Status">

                                    <ItemTemplate>

                                        <span class='status-badge <%# GetStatusClass(Eval("Status").ToString()) %>'>

                                            <%# Eval("Status") %>

                                        </span>

                                    </ItemTemplate>

                                </asp:TemplateField>

                                <asp:BoundField DataField="CreatedByName"
                                    HeaderText="Created By" />

                                <asp:BoundField DataField="CreatedAt"
                                    HeaderText="Created On"
                                    DataFormatString="{0:dd MMM yyyy}" />

                            </Columns>

                        </asp:GridView>

                    </div>

                </div>

            </div>

        </div>

    </div>

</asp:Content>