<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master"
    AutoEventWireup="true"
    CodeFile="Projects.aspx.cs"
    Inherits="TeamSync.Admin.Projects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        body {
            background: #f4f7fc;
            font-family: 'Segoe UI', sans-serif;
        }

        .project-container {
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

        .gridview-style {
            border-radius: 15px;
            overflow: hidden;
        }

        .table th {
            background: #2563eb;
            color: white;
            border: none;
        }

        .table td {
            vertical-align: middle;
        }

        .badge-status {
            padding: 8px 14px;
            border-radius: 30px;
            color: white;
            font-size: 12px;
            font-weight: 600;
        }

        .active-status {
            background: #10b981;
        }

        .completed-status {
            background: #6366f1;
        }

        @media(max-width:768px) {

            .page-title {
                font-size: 24px;
            }
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid project-container">

        <div class="page-title">
            Project Management
        </div>

        <div class="row">

            <!-- Add Project -->
            <div class="col-lg-4">

                <div class="card-box">

                    <h4 class="mb-4">Create New Project</h4>

                    <div class="mb-3">

                        <label>Project Name</label>

                        <asp:TextBox ID="txtProjectName"
                            runat="server"
                            CssClass="form-control"
                            placeholder="Enter project name">
                        </asp:TextBox>

                    </div>

                    <div class="mb-3">

                        <label>Description</label>

                        <asp:TextBox ID="txtDescription"
                            runat="server"
                            CssClass="form-control"
                            TextMode="MultiLine"
                            placeholder="Enter project description">
                        </asp:TextBox>

                    </div>

                    <div class="mb-3">

                        <label>Status</label>

                        <asp:DropDownList ID="ddlStatus"
                            runat="server"
                            CssClass="form-control">

                            <asp:ListItem Text="Active" Value="Active"></asp:ListItem>

                            <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>

                        </asp:DropDownList>

                    </div>

                    <div class="mb-3">

                        <asp:Button ID="btnAddProject"
                            runat="server"
                            Text="Create Project"
                            CssClass="btn btn-primary"
                            OnClick="btnAddProject_Click" />

                    </div>

                    <div class="text-center">

                        <asp:Label ID="lblMessage"
                            runat="server"
                            ForeColor="Green">
                        </asp:Label>

                    </div>

                </div>

            </div>

            <!-- Project List -->
            <div class="col-lg-8">

                <div class="card-box">

                    <h4 class="mb-4">All Projects</h4>

                    <div class="table-responsive gridview-style">

                        <asp:GridView ID="gvProjects"
                            runat="server"
                            AutoGenerateColumns="False"
                            CssClass="table table-hover table-bordered"
                            GridLines="None">

                            <Columns>

                                <asp:BoundField DataField="ProjectName"
                                    HeaderText="Project Name" />

                                <asp:BoundField DataField="Description"
                                    HeaderText="Description" />

                                <asp:BoundField DataField="Status"
                                    HeaderText="Status" />

                                <asp:BoundField DataField="CreatedDate"
                                    HeaderText="Created Date"
                                    DataFormatString="{0:dd MMM yyyy}" />

                            </Columns>

                        </asp:GridView>

                    </div>

                </div>

            </div>

        </div>

    </div>

</asp:Content>