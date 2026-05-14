using System;
using System.Data;
using System.Data.SqlClient;
using TeamSync;
using TeamSync.Helpers;

namespace TeamSync.Admin
{
    public partial class Users : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Session Check
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }

            // Role Check
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadUsers();
            }
        }

        // =====================================================
        // LOAD USERS
        // =====================================================

        private void LoadUsers()
        {
            try
            {
                string query = "SELECT * FROM Users ORDER BY UserID DESC";

                DataTable dt = DatabaseHelper.GetDataTable(query);

                gvUsers.DataSource = dt;

                gvUsers.DataBind();
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;

                lblMessage.Text = ex.Message;
            }
        }

        // =====================================================
        // ADD USER
        // =====================================================

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            try
            {
                string fullName = txtFullName.Text.Trim();

                string email = txtEmail.Text.Trim();

                string password = txtPassword.Text.Trim();

                string role = ddlRole.SelectedValue;

                // Validation
                if (fullName == "" || email == "" || password == "")
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;

                    lblMessage.Text = "All fields are required";

                    return;
                }

                // Check Existing Email
                string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email=@Email";

                SqlParameter[] checkParam =
                {
                    new SqlParameter("@Email", email)
                };

                int exists = Convert.ToInt32(
                    DatabaseHelper.ExecuteScalar(checkQuery, checkParam)
                );

                if (exists > 0)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;

                    lblMessage.Text = "Email already exists";

                    return;
                }

                // Insert User
                string insertQuery = @"
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
                    new SqlParameter("@FullName", fullName),

                    new SqlParameter("@Email", email),

                    new SqlParameter("@Password", password),

                    new SqlParameter("@Role", role)
                };

                int result = DatabaseHelper.ExecuteQuery(insertQuery, param);

                if (result > 0)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Green;

                    lblMessage.Text = "User added successfully";

                    txtFullName.Text = "";

                    txtEmail.Text = "";

                    txtPassword.Text = "";

                    ddlRole.SelectedIndex = 0;

                    LoadUsers();
                }
                else
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;

                    lblMessage.Text = "Failed to add user";
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