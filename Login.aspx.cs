using System;
using System.Data;
using System.Data.SqlClient;
using TeamSync.Helpers;

namespace TeamSync
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Show success message after registration

            if (Session["SuccessMessage"] != null)
            {
                lblMessage.ForeColor =
                    System.Drawing.Color.Green;

                lblMessage.Text =
                    Session["SuccessMessage"].ToString();

                Session["SuccessMessage"] = null;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                // =====================================
                // GET VALUES
                // =====================================

                string email =
                    txtEmail.Text.Trim();

                string password =
                    txtPassword.Text.Trim();

                // =====================================
                // VALIDATION
                // =====================================

                if (email == "" || password == "")
                {
                    lblMessage.ForeColor =
                        System.Drawing.Color.Red;

                    lblMessage.Text =
                        "Please enter email and password.";

                    return;
                }

                // =====================================
                // LOGIN QUERY
                // =====================================

                string query = @"

                    SELECT
                        UserID,
                        FullName,
                        Email,
                        Role,
                        ProfileImage,
                        IsActive
                    FROM Users

                    WHERE Email=@Email
                    AND PasswordHash=@PasswordHash
                    AND IsActive=1
                ";

                SqlParameter[] param =
                {
                    new SqlParameter(
                        "@Email",
                        email
                    ),

                    new SqlParameter(
                        "@PasswordHash",
                        password
                    )
                };

                DataTable dt =
                    DatabaseHelper.GetDataTable(
                        query,
                        param
                    );

                // =====================================
                // LOGIN SUCCESS
                // =====================================

                if (dt.Rows.Count > 0)
                {
                    Session["UserId"] =
                        dt.Rows[0]["UserID"].ToString();

                    Session["Name"] =
                        dt.Rows[0]["FullName"].ToString();

                    Session["Email"] =
                        dt.Rows[0]["Email"].ToString();

                    Session["Role"] =
                        dt.Rows[0]["Role"].ToString();

                    Session["ProfileImage"] =
                        dt.Rows[0]["ProfileImage"].ToString();

                    // =====================================
                    // REDIRECT BASED ON ROLE
                    // =====================================

                    if (Session["Role"].ToString() == "Admin")
                    {
                        Response.Redirect(
                            "~/Admin/Dashboard.aspx"
                        );
                    }
                    else
                    {
                        Response.Redirect(
                            "~/User/Dashboard.aspx"
                        );
                    }
                }
                else
                {
                    lblMessage.ForeColor =
                        System.Drawing.Color.Red;

                    lblMessage.Text =
                        "Invalid email or password.";
                }
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor =
                    System.Drawing.Color.Red;

                lblMessage.Text =
                    ex.Message;
            }
        }
    }
}