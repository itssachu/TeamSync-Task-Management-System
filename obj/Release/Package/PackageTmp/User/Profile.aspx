<%@ Page Title="Profile"
    Language="C#"
    MasterPageFile="~/MasterPage.Master"
    AutoEventWireup="true"
    CodeFile="Profile.aspx.cs"
    Inherits="TeamSync.User.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>

        body {
            background: #f4f7fc;
            font-family: 'Segoe UI', sans-serif;
        }

        .profile-container {
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
            padding: 30px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.06);
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

        .profile-icon {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: linear-gradient(135deg,#2563eb,#4f46e5);
            color: white;
            font-size: 40px;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px auto;
        }

        .readonly-box {
            background: #f1f5f9;
        }

        @media(max-width:768px) {

            .page-title {
                font-size: 24px;
            }
        }

    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid profile-container">

        <div class="page-title">
            My Profile
        </div>

        <div class="row justify-content-center">

            <div class="col-lg-6">

                <div class="card-box">

                    <!-- Profile Icon -->
                    <div class="profile-icon">
                        <%= Session["FullName"] != null 
                            ? Session["FullName"].ToString().Substring(0,1).ToUpper() 
                            : "U" %>
                    </div>

                    <h4 class="text-center mb-4">
                        Update Profile
                    </h4>

                    <!-- Full Name -->
                    <div class="mb-3">

                        <label class="mb-2">Full Name</label>

                        <asp:TextBox ID="txtFullName"
                            runat="server"
                            CssClass="form-control"
                            placeholder="Enter full name">
                        </asp:TextBox>

                    </div>

                    <!-- Email -->
                    <div class="mb-3">

                        <label class="mb-2">Email Address</label>

                        <asp:TextBox ID="txtEmail"
                            runat="server"
                            CssClass="form-control"
                            placeholder="Enter email address">
                        </asp:TextBox>

                    </div>

                    <!-- Role -->
                    <div class="mb-3">

                        <label class="mb-2">Role</label>

                        <asp:TextBox ID="txtRole"
                            runat="server"
                            CssClass="form-control readonly-box"
                            ReadOnly="true">
                        </asp:TextBox>

                    </div>

                    <!-- Password -->
                    <div class="mb-4">

                        <label class="mb-2">
                            New Password
                            <small>(Leave blank if not changing)</small>
                        </label>

                        <asp:TextBox ID="txtPassword"
                            runat="server"
                            CssClass="form-control"
                            TextMode="Password"
                            placeholder="Enter new password">
                        </asp:TextBox>

                    </div>

                    <!-- Button -->
                    <div class="mb-3">

                        <asp:Button ID="btnUpdate"
                            runat="server"
                            Text="Update Profile"
                            CssClass="btn btn-primary"
                            OnClick="btnUpdate_Click" />

                    </div>

                    <!-- Message -->
                    <div class="text-center">

                        <asp:Label ID="lblMessage"
                            runat="server"
                            Font-Bold="true">
                        </asp:Label>

                    </div>

                </div>

            </div>

        </div>

    </div>

</asp:Content>