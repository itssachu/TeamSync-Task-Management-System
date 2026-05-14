<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master"
    AutoEventWireup="true"
    CodeFile="Users.aspx.cs"
    Inherits="TeamSync.Admin.Users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        body {
            background: #f4f7fc;
            font-family: 'Segoe UI', sans-serif;
        }

        .user-container {
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

        .role-badge {
            padding: 8px 14px;
            border-radius: 30px;
            color: white;
            font-size: 12px;
            font-weight: 600;
        }

        .admin-role {
            background: #ef4444;
        }

        .member-role {
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

    <div class="container-fluid user-container">

        <div class="page-title">
            Team Members
        </div>

        <div class="row">

            <!-- Add User -->
            <div class="col-lg-4">

                <div class="card-box">

                    <h4 class="mb-4">Add New Member</h4>

                    <!-- Full Name -->
                    <div class="mb-3">

                        <label>Full Name</label>

                        <asp:TextBox ID="txtFullName"
                            runat="server"
                            CssClass="form-control"
                            placeholder="Enter full name">
                        </asp:TextBox>

                    </div>

                    <!-- Email -->
                    <div class="mb-3">

                        <label>Email Address</label>

                        <asp:TextBox ID="txtEmail"
                            runat="server"
                            CssClass="form-control"
                            TextMode="Email"
                            placeholder="Enter email">
                        </asp:TextBox>

                    </div>

                    <!-- Password -->
                    <div class="mb-3">

                        <label>Password</label>

                        <asp:TextBox ID="txtPassword"
                            runat="server"
                            CssClass="form-control"
                            TextMode="Password"
                            placeholder="Enter password">
                        </asp:TextBox>

                    </div>

                    <!-- Role -->
                    <div class="mb-3">

                        <label>User Role</label>

                        <asp:DropDownList ID="ddlRole"
                            runat="server"
                            CssClass="form-control">

                            <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>

                            <asp:ListItem Text="Member" Value="Member"></asp:ListItem>

                        </asp:DropDownList>

                    </div>

                    <!-- Button -->
                    <div class="mb-3">

                        <asp:Button ID="btnAddUser"
                            runat="server"
                            Text="Add Member"
                            CssClass="btn btn-primary"
                            OnClick="btnAddUser_Click" />

                    </div>

                    <!-- Message -->
                    <div class="text-center">

                        <asp:Label ID="lblMessage"
                            runat="server">
                        </asp:Label>

                    </div>

                </div>

            </div>

            <!-- Users Grid -->
            <div class="col-lg-8">

                <div class="card-box">

                    <h4 class="mb-4">All Team Members</h4>

                    <div class="table-responsive">

                        <asp:GridView ID="gvUsers"
                            runat="server"
                            AutoGenerateColumns="False"
                            CssClass="table table-hover table-bordered"
                            GridLines="None">

                            <Columns>

                                <asp:BoundField DataField="FullName"
                                    HeaderText="Full Name" />

                                <asp:BoundField DataField="Email"
                                    HeaderText="Email" />

                                <asp:BoundField DataField="Role"
                                    HeaderText="Role" />

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