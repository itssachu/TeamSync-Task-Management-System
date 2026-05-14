using System;
using System.Data;
using System.Data.SqlClient;
using TeamSync;
using TeamSync.Helpers;

namespace TeamSync
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                string query = @"
                    SELECT *
                    FROM Users
                    WHERE Email=@Email
                    AND Password=@Password";

                SqlParameter[] param =
                {
                    new SqlParameter("@Email", txtEmail.Text.Trim()),
                    new SqlParameter("@Password", txtPassword.Text.Trim())
                };

                DataTable dt =
                    DatabaseHelper.GetDataTable(query, param);

                if (dt.Rows.Count > 0)
                {
                    // ============================
                    // CREATE SESSION
                    // ============================

                    Session["UserId"] =
                        dt.Rows[0]["UserID"].ToString();

                    Session["Name"] =
                        dt.Rows[0]["FullName"].ToString();

                    Session["Role"] =
                        dt.Rows[0]["Role"].ToString();

                    // ============================
                    // REDIRECT BASED ON ROLE
                    // ============================

                    if (Session["Role"].ToString() == "Admin")
                    {
                        Response.Redirect("~/Admin/Dashboard.aspx");
                    }
                    else
                    {
                        Response.Redirect("~/User/Profile.aspx");
                    }
                }
                else
                {
                    lblMessage.ForeColor =
                        System.Drawing.Color.Red;

                    lblMessage.Text =
                        "Invalid email or password!";
                }
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor =
                    System.Drawing.Color.Red;

                lblMessage.Text = ex.Message;
            }
        }
    }
}