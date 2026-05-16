<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/UserMaster.master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="TeamSync.User.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .profile-wrapper { padding: 20px; }
        .profile-header {
            background: linear-gradient(135deg,#4f46e5,#7c3aed);
            border-radius: 20px;
            padding: 35px;
            color: white;
            margin-bottom: 30px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
        }
        .profile-image-box {
            width: 120px; height: 120px;
            border-radius: 50%;
            overflow: hidden;
            border: 4px solid rgba(255,255,255,0.3);
            background: white;
        }
        .profile-image-box img { width: 100%; height: 100%; object-fit: cover; }
        .profile-name-text { font-size: 28px; font-weight: 700; margin-top: 10px; }
        .profile-card {
            background: white; border-radius: 15px; padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05); margin-bottom: 25px;
        }
        .section-title { font-size: 20px; font-weight: 700; margin-bottom: 20px; color: #1e293b; }
        .btn-save {
            background: linear-gradient(135deg,#4f46e5,#7c3aed);
            border: none; color: white; height: 45px; border-radius: 10px;
            padding: 0 25px; font-weight: 600; transition: 0.3s;
        }
        .btn-save:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(79,70,229,0.4); color: white; }
        .stats-box {
            background: #f8fafc; border-radius: 15px; padding: 20px;
            text-align: center; border: 1px solid #e2e8f0;
        }
        .stats-box h2 { font-size: 30px; color: #4f46e5; font-weight: 700; margin-bottom: 5px; }
        .stats-box p { color: #64748b; margin-bottom: 0; font-size: 14px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid profile-wrapper">
        
        <!-- PROFILE HEADER -->
        <div class="profile-header">
            <div class="row align-items-center">
                <div class="col-md-auto text-center">
                    <div class="profile-image-box mx-auto">
                        <asp:Image ID="imgProfile" runat="server" ImageUrl="~/Uploads/default.png" />
                    </div>
                </div>
                <div class="col-md">
                    <div class="profile-name-text">
                        <asp:Label ID="lblName" runat="server" Text="User Name"></asp:Label>
                    </div>
                    <div class="opacity-75">
                        <asp:Label ID="lblRole" runat="server" Text="Role"></asp:Label>
                    </div>
                </div>
            </div>
        </div>

        <!-- SUCCESS/ERROR MESSAGE -->
        <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show border-0 shadow-sm mb-4">
            <asp:Label ID="lblMessage" runat="server"></asp:Label>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </asp:Panel>

        <div class="row">
            <!-- EDIT SECTION -->
            <div class="col-lg-8">
                <div class="profile-card">
                    <div class="section-title"><i class="bi bi-person-gear me-2"></i>Edit Personal Information</div>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Full Name</label>
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Enter full name"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Email Address</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Enter email"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">New Password (Leave blank to keep current)</label>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Update Profile Picture</label>
                            <asp:FileUpload ID="fuProfile" runat="server" CssClass="form-control" />
                        </div>
                        <div class="col-12 mt-4">
                            <asp:Button ID="btnUpdate" runat="server" Text="Save Changes" CssClass="btn-save" OnClick="btnUpdate_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- STATS SECTION -->
            <div class="col-lg-4">
                <div class="profile-card">
                    <div class="section-title"><i class="bi bi-bar-chart me-2"></i>Your Performance</div>
                    <div class="row g-3">
                        <div class="col-12">
                            <div class="stats-box">
                                <h2><asp:Label ID="lblTotalTasks" runat="server" Text="0"></asp:Label></h2>
                                <p>Total Tasks Assigned</p>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="stats-box">
                                <h2 class="text-success"><asp:Label ID="lblCompletedTasks" runat="server" Text="0"></asp:Label></h2>
                                <p>Completed</p>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="stats-box">
                                <h2 class="text-warning"><asp:Label ID="lblPendingTasks" runat="server" Text="0"></asp:Label></h2>
                                <p>Pending</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>