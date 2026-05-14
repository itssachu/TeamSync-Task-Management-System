using System;
using System.Data;
using System.Data.SqlClient;
using TeamSync.Helpers;

namespace TeamSync.User
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Session Check
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadProfile();
            }
        }

        // Load Profile
        private void LoadProfile()
        {
            try
            {
                string query = @"SELECT * FROM Users
                                 WHERE Id=@Id";

                SqlParameter[] param =
                {
                    new SqlParameter("@Id", Session["UserId"])
                };

                DataTable dt = DatabaseHelper.GetDataTable(query, param);

                if (dt.Rows.Count > 0)
                {
                    txtFullName.Text = dt.Rows[0]["FullName"].ToString();

                    txtEmail.Text = dt.Rows[0]["Email"].ToString();

                    txtRole.Text = dt.Rows[0]["Role"].ToString();
                }
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;

                lblMessage.Text = ex.Message;
            }
        }

        // Update Profile
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                string query = "";

                SqlParameter[] param;

                // If Password Changed
                if (txtPassword.Text.Trim() != "")
                {
                    query = @"UPDATE Users
                              SET FullName=@FullName,
                                  Email=@Email,
                                  Password=@Password
                              WHERE Id=@Id";

                    param = new SqlParameter[]
                    {
                        new SqlParameter("@FullName", txtFullName.Text.Trim()),
                        new SqlParameter("@Email", txtEmail.Text.Trim()),
                        new SqlParameter("@Password", txtPassword.Text.Trim()),
                        new SqlParameter("@Id", Session["UserId"])
                    };
                }
                else
                {
                    query = @"UPDATE Users
                              SET FullName=@FullName,
                                  Email=@Email
                              WHERE Id=@Id";

                    param = new SqlParameter[]
                    {
                        new SqlParameter("@FullName", txtFullName.Text.Trim()),
                        new SqlParameter("@Email", txtEmail.Text.Trim()),
                        new SqlParameter("@Id", Session["UserId"])
                    };
                }

                int result = DatabaseHelper.ExecuteQuery(query, param);

                if (result > 0)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Green;

                    lblMessage.Text = "Profile updated successfully";

                    LoadProfile();
                }
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;

                lblMessage.Text = ex.Message;
            }
        }
    }
}