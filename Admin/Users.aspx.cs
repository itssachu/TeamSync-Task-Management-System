using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using TeamSync.Helpers;
using TeamSync.User;

namespace TeamSync.Admin
{
    public partial class Users : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }

            if (Session["Role"] == null ||
                Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadUsers();
            }
        }

        // ===================================================
        // LOAD USERS
        // ===================================================

        private void LoadUsers()
        {
            try
            {
                string query = @"
                SELECT
                    UserID,
                    FullName,
                    Email,
                    Role,
                    ProfileImage,
                    IsActive,
                    CreatedAt
                FROM Users
                ORDER BY UserID DESC";

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

        // ===================================================
        // ADD USER
        // ===================================================

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            try
            {
                string fullName = txtFullName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string password = txtPassword.Text.Trim();
                string role = ddlRole.SelectedValue;

                if (fullName == "" ||
                    email == "" ||
                    password == "")
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "All fields are required";
                    return;
                }

                // CHECK EMAIL

                string checkQuery =
                    "SELECT COUNT(*) FROM Users WHERE Email=@Email";

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
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Email already exists";
                    return;
                }

                // IMAGE UPLOAD

                string imagePath = "~/Uploads/default.png";

                if (fuProfile.HasFile)
                {
                    string folderPath =
                        Server.MapPath("~/Uploads/");

                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }

                    string fileName =
                        Guid.NewGuid().ToString() +
                        Path.GetExtension(fuProfile.FileName);

                    fuProfile.SaveAs(folderPath + fileName);

                    imagePath = "~/Uploads/" + fileName;
                }

                // INSERT USER

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
                    1,
                    GETDATE()
                )";

                SqlParameter[] param =
                {
                    new SqlParameter("@FullName", fullName),
                    new SqlParameter("@Email", email),
                    new SqlParameter("@PasswordHash", password),
                    new SqlParameter("@Role", role),
                    new SqlParameter("@ProfileImage", imagePath)
                };

                int result =
                    DatabaseHelper.ExecuteQuery(query, param);

                if (result > 0)
                {
                    lblMessage.ForeColor =
                        System.Drawing.Color.Green;

                    lblMessage.Text =
                        "User added successfully";

                    txtFullName.Text = "";
                    txtEmail.Text = "";
                    txtPassword.Text = "";
                    ddlRole.SelectedIndex = 0;

                    LoadUsers();
                }
                else
                {
                    lblMessage.ForeColor =
                        System.Drawing.Color.Red;

                    lblMessage.Text =
                        "Failed to add user";
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