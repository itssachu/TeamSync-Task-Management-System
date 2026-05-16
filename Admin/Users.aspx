<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master"
    AutoEventWireup="true"
    CodeBehind="Users.aspx.cs"
    Inherits="TeamSync.Admin.Users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>

        .users-wrapper {
            padding: 30px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }

        .page-title {
            font-size: 32px;
            font-weight: 700;
            color: #0f172a;
        }

        .card-box {
            background: white;
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.06);
            margin-bottom: 25px;
        }

        .form-control {
            height: 50px;
            border-radius: 12px;
            border: 1px solid #dbeafe;
            box-shadow: none;
        }

        textarea.form-control {
            height: auto;
        }

        .btn-main {
            background: linear-gradient(135deg,#2563eb,#4f46e5);
            border: none;
            color: white;
            height: 50px;
            border-radius: 12px;
            width: 100%;
            font-weight: 600;
        }

        .btn-main:hover {
            opacity: .9;
        }

        .table {
            border-radius: 15px;
            overflow: hidden;
        }

        .table th {
            background: #2563eb;
            color: white;
            border: none;
            padding: 14px;
        }

        .table td {
            vertical-align: middle;
            padding: 14px;
        }

        .profile-img {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #e2e8f0;
        }

        .status-active {
            background: #dcfce7;
            color: #166534;
            padding: 6px 14px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-inactive {
            background: #fee2e2;
            color: #991b1b;
            padding: 6px 14px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 600;
        }

        .role-admin {
            background: #dbeafe;
            color: #1d4ed8;
            padding: 6px 14px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 600;
        }

        .role-member {
            background: #ecfccb;
            color: #3f6212;
            padding: 6px 14px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 600;
        }

        .action-btn {
            border: none;
            border-radius: 10px;
            padding: 8px 12px;
            color: white;
        }

        .edit-btn {
            background: #2563eb;
        }

        .delete-btn {
            background: #dc2626;
        }

        @media(max-width:768px) {

            .page-title {
                font-size: 24px;
            }

            .users-wrapper {
                padding: 15px;
            }
        }

    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid users-wrapper">

        <div class="page-header">

            <div class="page-title">
                Team Members
            </div>

        </div>

        <div class="row">

            <!-- ADD USER -->

            <div class="col-lg-4">

                <div class="card-box">

                    <h4 class="mb-4">Add New User</h4>

                    <div class="mb-3">
                        <label>Full Name</label>

                        <asp:TextBox ID="txtFullName"
                            runat="server"
                            CssClass="form-control"
                            placeholder="Enter full name">
                        </asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <label>Email Address</label>

                        <asp:TextBox ID="txtEmail"
                            runat="server"
                            CssClass="form-control"
                            TextMode="Email"
                            placeholder="Enter email">
                        </asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <label>Password</label>

                        <asp:TextBox ID="txtPassword"
                            runat="server"
                            CssClass="form-control"
                            TextMode="Password"
                            placeholder="Enter password">
                        </asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <label>Role</label>

                        <asp:DropDownList ID="ddlRole"
                            runat="server"
                            CssClass="form-control">

                            <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                            <asp:ListItem Text="Member" Value="Member"></asp:ListItem>

                        </asp:DropDownList>
                    </div>

                    <div class="mb-3">
                        <label>Profile Image</label>

                        <asp:FileUpload ID="fuProfile"
                            runat="server"
                            CssClass="form-control" />
                    </div>

                    <div class="mb-3">

                        <asp:Button ID="btnAddUser"
                            runat="server"
                            Text="Add User"
                            CssClass="btn-main"
                            OnClick="btnAddUser_Click" />

                    </div>

                    <div class="text-center mt-2">

                        <asp:Label ID="lblMessage"
                            runat="server">
                        </asp:Label>

                    </div>

                </div>

            </div>

            <!-- USERS TABLE -->

            <div class="col-lg-8">

                <div class="card-box">

                    <h4 class="mb-4">All Users</h4>

                    <div class="table-responsive">

                        <asp:GridView ID="gvUsers"
                            runat="server"
                            AutoGenerateColumns="False"
                            CssClass="table table-hover"
                            GridLines="None">

                            <Columns>

                                <asp:TemplateField HeaderText="User">

                                    <ItemTemplate>

                                        <div class="d-flex align-items-center">

                                            <img src='<%# Eval("ProfileImage") %>'
                                                class="profile-img me-2" />

                                            <div>

                                                <div class="fw-bold">
                                                    <%# Eval("FullName") %>
                                                </div>

                                                <small class="text-muted">
                                                    <%# Eval("Email") %>
                                                </small>

                                            </div>

                                        </div>

                                    </ItemTemplate>

                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Role">

                                    <ItemTemplate>

                                        <span class='<%# Eval("Role").ToString() == "Admin" ? "role-admin" : "role-member" %>'>
                                            <%# Eval("Role") %>
                                        </span>

                                    </ItemTemplate>

                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Status">

                                    <ItemTemplate>

                                        <span class='<%# Convert.ToBoolean(Eval("IsActive")) ? "status-active" : "status-inactive" %>'>
                                            <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>
                                        </span>

                                    </ItemTemplate>

                                </asp:TemplateField>

                                <asp:BoundField DataField="CreatedAt"
                                    HeaderText="Created"
                                    DataFormatString="{0:dd MMM yyyy}" />

                            </Columns>

                        </asp:GridView>

                    </div>

                </div>

            </div>

        </div>

    </div>

</asp:Content>