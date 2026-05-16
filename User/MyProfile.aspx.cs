using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using TeamSync.Helpers;

namespace TeamSync.User
{
    public partial class MyProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Safety Check: If Session is null, stop everything immediately.
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                LoadProfile();
            }
            else if (fuProfile.HasFile)
            {
                // Handle the auto-postback from the file upload
                HandleImageUpload();
            }
        }

        private void LoadProfile()
        {
            try
            {
                // 2. Safely get Session ID
                string userId = Session["UserId"].ToString();
                if (string.IsNullOrEmpty(userId)) return;

                string query = "SELECT FullName, Email, PhoneNumber, Role, Bio, ProfileImage FROM Users WHERE UserID=@UserID";
                SqlParameter[] param = { new SqlParameter("@UserID", userId) };

                DataTable dt = DatabaseHelper.GetDataTable(query, param);

                // 3. Safety Check: Ensure DataTable and Rows are not null
                if (dt != null && dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];

                    // Using Convert.ToString is safer than .ToString() because it handles DBNull
                    lblDisplayName.Text = Convert.ToString(row["FullName"]);
                    lblRoleBadge.Text = Convert.ToString(row["Role"]);
                    txtName.Text = Convert.ToString(row["FullName"]);
                    txtEmail.Text = Convert.ToString(row["Email"]);
                    txtPhone.Text = Convert.ToString(row["PhoneNumber"]);
                    txtRole.Text = Convert.ToString(row["Role"]);
                    txtBio.Text = Convert.ToString(row["Bio"]);

                    string imgUrl = Convert.ToString(row["ProfileImage"]);
                    imgProfile.ImageUrl = !string.IsNullOrEmpty(imgUrl) ? imgUrl : "~/Images/default-avatar.png";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string userId = Session["UserId"].ToString();
                if (string.IsNullOrEmpty(userId)) return;

                // Password match check
                if (txtPassword.Text.Trim() != txtConfirmPassword.Text.Trim())
                {
                    ShowAlert("Passwords do not match!");
                    return;
                }

                string query;
                if (!string.IsNullOrEmpty(txtPassword.Text.Trim()))
                {
                    query = @"UPDATE Users SET FullName=@FullName, Email=@Email, PhoneNumber=@PhoneNumber, 
                              Bio=@Bio, PasswordHash=@Pass WHERE UserID=@UserID";
                }
                else
                {
                    query = @"UPDATE Users SET FullName=@FullName, Email=@Email, PhoneNumber=@PhoneNumber, 
                              Bio=@Bio WHERE UserID=@UserID";
                }

                SqlParameter[] param = {
                    new SqlParameter("@FullName", txtName.Text.Trim()),
                    new SqlParameter("@Email", txtEmail.Text.Trim()),
                    new SqlParameter("@PhoneNumber", txtPhone.Text.Trim()),
                    new SqlParameter("@Bio", txtBio.Text.Trim()),
                    new SqlParameter("@Pass", txtPassword.Text.Trim()),
                    new SqlParameter("@UserID", userId)
                };

                int result = DatabaseHelper.ExecuteQuery(query, param);
                if (result > 0)
                {
                    ShowAlert("Profile updated successfully!");
                    LoadProfile();
                }
            }
            catch (Exception ex)
            {
                ShowAlert("Error: " + ex.Message);
            }
        }

        private void HandleImageUpload()
        {
            try
            {
                string userId = Session["UserId"].ToString();
                if (string.IsNullOrEmpty(userId)) return;

                string folderPath = Server.MapPath("~/Uploads/Profile/");
                if (!Directory.Exists(folderPath)) Directory.CreateDirectory(folderPath);

                string fileName = Guid.NewGuid().ToString() + Path.GetExtension(fuProfile.FileName);
                string virtualPath = "~/Uploads/Profile/" + fileName;

                fuProfile.SaveAs(Path.Combine(folderPath, fileName));

                string query = "UPDATE Users SET ProfileImage=@Img WHERE UserID=@UserID";
                SqlParameter[] param = {
                    new SqlParameter("@Img", virtualPath),
                    new SqlParameter("@UserID", userId)
                };

                DatabaseHelper.ExecuteQuery(query, param);
                imgProfile.ImageUrl = virtualPath;
                ShowAlert("Profile photo updated!");
            }
            catch (Exception ex)
            {
                ShowAlert("Upload error: " + ex.Message);
            }
        }

        private void ShowAlert(string message)
        {
            // {0} acts as the placeholder for the escaped message
            string script = string.Format("alert('{0}');", message.Replace("'", "\\'"));
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", script, true);
        }
    }
}