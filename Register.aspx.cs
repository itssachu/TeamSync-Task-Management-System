using System;
using System.Data.SqlClient;
using TeamSync.Helpers;

namespace TeamSync
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                // =========================
                // VALIDATION
                // =========================

                if (txtName.Text.Trim() == "" ||
                    txtEmail.Text.Trim() == "" ||
                    txtPassword.Text.Trim() == "")
                {
                    lblMessage.ForeColor =
                        System.Drawing.Color.Red;

                    lblMessage.Text =
                        "All fields are required!";

                    return;
                }

                // PASSWORD MATCH CHECK

                if (txtPassword.Text.Trim() !=
                    txtConfirmPassword.Text.Trim())
                {
                    lblMessage.ForeColor =
                        System.Drawing.Color.Red;

                    lblMessage.Text =
                        "Passwords do not match!";

                    return;
                }

                // =========================
                // CHECK EXISTING EMAIL
                // =========================

                string checkQuery =
                    "SELECT COUNT(*) FROM Users WHERE Email=@Email";

                SqlParameter[] checkParam =
                {
                    new SqlParameter("@Email",
                    txtEmail.Text.Trim())
                };

                int exists = Convert.ToInt32(
                    DatabaseHelper.ExecuteScalar(
                        checkQuery,
                        checkParam
                    )
                );

                if (exists > 0)
                {
                    lblMessage.ForeColor =
                        System.Drawing.Color.Red;

                    lblMessage.Text =
                        "Email already exists!";

                    return;
                }

                // =========================
                // INSERT USER
                // =========================

                string query = @"
                    INSERT INTO Users
                    (
                        FullName,
                        Email,
                        Password,
                        Role,
                        CreatedAt
                    )

                    VALUES
                    (
                        @FullName,
                        @Email,
                        @Password,
                        @Role,
                        GETDATE()
                    )";

                SqlParameter[] param =
                {
                    new SqlParameter("@FullName",
                    txtName.Text.Trim()),

                    new SqlParameter("@Email",
                    txtEmail.Text.Trim()),

                    new SqlParameter("@Password",
                    txtPassword.Text.Trim()),

                    new SqlParameter("@Role",
                    "Member")
                };

                int result = DatabaseHelper.ExecuteQuery(
                    query,
                    param
                );

                // =========================
                // SUCCESS
                // =========================

                if (result > 0)
                {
                    Session["SuccessMessage"] =
                        "Registration successful! Please login.";

                    Response.Redirect("~/Login.aspx");
                }
                else
                {
                    lblMessage.ForeColor =
                        System.Drawing.Color.Red;

                    lblMessage.Text =
                        "Registration failed!";
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