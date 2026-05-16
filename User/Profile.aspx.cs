using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using TeamSync.Helpers;

namespace TeamSync.User
{
    public partial class Profile : System.Web.UI.Page
    {
        string imagePath = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            // LOGIN CHECK

            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadProfile();
                LoadStatistics();
            }
        }

        // =========================
        // LOAD PROFILE
        // =========================

        private void LoadProfile()
        {
            try
            {
                int userId =
                    Convert.ToInt32(Session["UserId"]);

                string query = @"
                    SELECT *
                    FROM Users
                    WHERE UserID = @UserID
                ";

                SqlParameter[] param =
                {
                    new SqlParameter("@UserID", userId)
                };

                DataTable dt =
                    DatabaseHelper.GetDataTable(query, param);

                if (dt.Rows.Count > 0)
                {
                    lblName.Text =
                        dt.Rows[0]["FullName"].ToString();

                    lblRole.Text =
                        dt.Rows[0]["Role"].ToString();

                    txtFullName.Text =
                        dt.Rows[0]["FullName"].ToString();

                    txtEmail.Text =
                        dt.Rows[0]["Email"].ToString();

                    // PROFILE IMAGE

                    if (dt.Rows[0]["ProfileImage"] != DBNull.Value)
                    {
                        string img =
                            dt.Rows[0]["ProfileImage"].ToString();

                        if (!string.IsNullOrEmpty(img))
                        {
                            imgProfile.ImageUrl = img;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Error loading profile: " + ex.Message,
                    false
                );
            }
        }

        // =========================
        // LOAD STATS
        // =========================

        private void LoadStatistics()
        {
            try
            {
                int userId =
                    Convert.ToInt32(Session["UserId"]);

                string query = @"

                    SELECT
                        COUNT(*) AS TotalTasks,

                        SUM(
                            CASE
                                WHEN Status='Completed'
                                THEN 1
                                ELSE 0
                            END
                        ) AS CompletedTasks,

                        SUM(
                            CASE
                                WHEN Status!='Completed'
                                THEN 1
                                ELSE 0
                            END
                        ) AS PendingTasks

                    FROM Tasks
                    WHERE AssignedTo=@UserID
                ";

                SqlParameter[] param =
                {
                    new SqlParameter("@UserID", userId)
                };

                DataTable dt =
                    DatabaseHelper.GetDataTable(query, param);

                if (dt.Rows.Count > 0)
                {
                    lblTotalTasks.Text =
                        dt.Rows[0]["TotalTasks"].ToString();

                    lblCompletedTasks.Text =
                        dt.Rows[0]["CompletedTasks"].ToString();

                    lblPendingTasks.Text =
                        dt.Rows[0]["PendingTasks"].ToString();
                }
            }
            catch
            {

            }
        }

        // =========================
        // UPDATE PROFILE
        // =========================

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                int userId =
                    Convert.ToInt32(Session["UserId"]);

                // IMAGE UPLOAD

                if (fuProfile.HasFile)
                {
                    string folder =
                        Server.MapPath("~/Uploads/Profile/");

                    if (!Directory.Exists(folder))
                    {
                        Directory.CreateDirectory(folder);
                    }

                    string fileName =
                        Guid.NewGuid().ToString()
                        + Path.GetExtension(
                            fuProfile.FileName
                        );

                    string fullPath =
                        Path.Combine(folder, fileName);

                    fuProfile.SaveAs(fullPath);

                    imagePath =
                        "~/Uploads/Profile/" + fileName;
                }
                else
                {
                    imagePath = imgProfile.ImageUrl;
                }

                string query = @"

                    UPDATE Users
                    SET
                        FullName=@FullName,
                        Email=@Email,
                        ProfileImage=@ProfileImage
                ";

                // PASSWORD UPDATE ONLY IF ENTERED

                if (!string.IsNullOrEmpty(txtPassword.Text))
                {
                    query += ", Password=@Password ";
                }

                query += " WHERE UserID=@UserID ";

                SqlParameter[] param;

                if (!string.IsNullOrEmpty(txtPassword.Text))
                {
                    param = new SqlParameter[]
                    {
                        new SqlParameter("@FullName", txtFullName.Text.Trim()),
                        new SqlParameter("@Email", txtEmail.Text.Trim()),
                        new SqlParameter("@ProfileImage", imagePath),
                        new SqlParameter("@Password", txtPassword.Text.Trim()),
                        new SqlParameter("@UserID", userId)
                    };
                }
                else
                {
                    param = new SqlParameter[]
                    {
                        new SqlParameter("@FullName", txtFullName.Text.Trim()),
                        new SqlParameter("@Email", txtEmail.Text.Trim()),
                        new SqlParameter("@ProfileImage", imagePath),
                        new SqlParameter("@UserID", userId)
                    };
                }

                DatabaseHelper.ExecuteQuery(query, param);

                LoadProfile();

                ShowMessage(
                    "Profile updated successfully.",
                    true
                );
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Error: " + ex.Message,
                    false
                );
            }
        }

        // =========================
        // SHOW MESSAGE
        // =========================

        private void ShowMessage(
            string message,
            bool success
        )
        {
            pnlMessage.Visible = true;

            lblMessage.Text = message;

            if (success)
            {
                pnlMessage.CssClass =
                    "alert alert-success alert-custom";
            }
            else
            {
                pnlMessage.CssClass =
                    "alert alert-danger alert-custom";
            }
        }
    }
}