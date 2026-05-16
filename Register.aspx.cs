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
                string fullName =
                    txtName.Text.Trim();

                string email =
                    txtEmail.Text.Trim();

                string password =
                    txtPassword.Text.Trim();

                string confirmPassword =
                    txtConfirmPassword.Text.Trim();

                // ====================================
                // VALIDATION
                // ====================================

                if (fullName == "" ||
                    email == "" ||
                    password == "" ||
                    confirmPassword == "")
                {
                    lblMessage.ForeColor =
                        System.Drawing.Color.Red;

                    lblMessage.Text =
                        "All fields are required.";

                    return;
                }

                // PASSWORD MATCH

                if (password != confirmPassword)
                {
                    lblMessage.ForeColor =
                        System.Drawing.Color.Red;

                    lblMessage.Text =
                        "Passwords do not match.";

                    return;
                }

                // PASSWORD LENGTH

                if (password.Length < 6)
                {
                    lblMessage.ForeColor =
                        System.Drawing.Color.Red;

                    lblMessage.Text =
                        "Password must be at least 6 characters.";

                    return;
                }

                // ====================================
                // CHECK EXISTING EMAIL
                // ====================================

                string checkQuery = @"
                    SELECT COUNT(*)
                    FROM Users
                    WHERE Email=@Email";

                SqlParameter[] checkParam =
                {
                    new SqlParameter("@Email", email)
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
                        "Email already exists.";

                    return;
                }

                // ====================================
                // DEFAULT PROFILE IMAGE
                // ====================================

                string defaultProfile =
                    "~/Uploads/default.png";

                // ====================================
                // INSERT USER
                // ====================================

                string query = @"

                    INSERT INTO Users
                    (
                        FullName,
                        Email,
                        PasswordHash,
                        Role,
                        ProfileImage,
                        IsActive,
                        CreatedAt
                    )

                    VALUES
                    (
                        @FullName,
                        @Email,
                        @PasswordHash,
                        @Role,
                        @ProfileImage,
                        @IsActive,
                        GETDATE()
                    )
                ";

                SqlParameter[] param =
                {
                    new SqlParameter(
                        "@FullName",
                        fullName
                    ),

                    new SqlParameter(
                        "@Email",
                        email
                    ),

                    new SqlParameter(
                        "@PasswordHash",
                        password
                    ),

                    new SqlParameter(
                        "@Role",
                        "Member"
                    ),

                    new SqlParameter(
                        "@ProfileImage",
                        defaultProfile
                    ),

                    new SqlParameter(
                        "@IsActive",
                        true
                    )
                };

                int result =
                    DatabaseHelper.ExecuteQuery(
                        query,
                        param
                    );

                // ====================================
                // SUCCESS
                // ====================================

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
                        "Registration failed.";
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