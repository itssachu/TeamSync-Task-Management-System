<%@ Page Title="User Profile" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeFile="MyProfile.aspx.cs" Inherits="TeamSync.User.MyProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        :root { --primary-color: #4361ee; --bg-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .profile-container { max-width: 1000px; margin: 2rem auto; }
        .profile-header { background: var(--bg-gradient); color: white; border-radius: 15px; padding: 30px; margin-bottom: 2rem; box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
        .profile-image-box { position: relative; width: 120px; height: 120px; border-radius: 50%; border: 4px solid white; overflow: hidden; }
        .profile-image { width: 100%; height: 100%; object-fit: cover; }
        .upload-btn { position: absolute; bottom: 0; width: 100%; background: rgba(0,0,0,0.5); color: white; border: none; font-size: 12px; padding: 5px; cursor: pointer; }
        .info-card { background: white; border-radius: 15px; padding: 25px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); margin-bottom: 20px; border: 1px solid #eee; }
        .security-section { background: #2b2d42; color: white; border-radius: 15px; padding: 25px; }
        .form-label { font-weight: 600; color: #555; margin-bottom: 8px; }
        .save-btn { background: #4cc9f0; color: white; border: none; padding: 10px 25px; border-radius: 8px; font-weight: bold; transition: 0.3s; }
        .save-btn:hover { background: #4361ee; transform: translateY(-2px); }
    </style>

    <div class="profile-container">
        <div class="profile-header d-flex align-items-center">
            <div class="profile-image-box me-4">
                <asp:Image ID="imgProfile" runat="server" CssClass="profile-image" ImageUrl="~/Images/default-avatar.png" />
                <asp:FileUpload ID="fuProfile" runat="server" style="display:none;" onchange="this.form.submit()" />
                <button type="button" class="upload-btn" onclick="document.getElementById('<%= fuProfile.ClientID %>').click();">Change</button>
            </div>
            <div>
                <h2 class="mb-1"><asp:Label ID="lblDisplayName" runat="server"></asp:Label></h2>
                <span class="badge bg-light text-primary"><asp:Label ID="lblRoleBadge" runat="server"></asp:Label></span>
            </div>
        </div>

        <div class="info-card">
            <h4 class="mb-4">Personal Information</h4>
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label">Full Name</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Phone Number</label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Job Role</label>
                    <asp:TextBox ID="txtRole" runat="server" CssClass="form-control" ReadOnly="true" BackColor="#f8f9fa"></asp:TextBox>
                </div>
                <div class="col-12">
                    <label class="form-label">Bio</label>
                    <asp:TextBox ID="txtBio" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                </div>
            </div>
        </div>

        <div class="security-section">
            <h4 class="mb-4 text-white">Account Security</h4>
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label text-white">New Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                </div>
                <div class="col-md-6">
                    <label class="form-label text-white">Confirm Password</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                </div>
            </div>
            <div class="mt-4">
                <asp:Button ID="btnSave" runat="server" Text="Update Profile" CssClass="save-btn" OnClick="btnSave_Click" />
                <asp:Label ID="lblMessage" runat="server" CssClass="ms-3"></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>