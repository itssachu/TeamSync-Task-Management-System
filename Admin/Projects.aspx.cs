using System;
using System.Data;
using System.Data.SqlClient;
using TeamSync;
using TeamSync.Helpers;

namespace TeamSync.Admin
{
    public partial class Projects : System.Web.UI.Page
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
                LoadProjects();
            }
        }

        // =====================================================
        // LOAD ALL PROJECTS
        // =====================================================

        private void LoadProjects()
        {
            try
            {
                string query = "SELECT * FROM Projects ORDER BY ProjectID DESC";

                DataTable dt = DatabaseHelper.GetDataTable(query);

                gvProjects.DataSource = dt;

                gvProjects.DataBind();
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;

                lblMessage.Text = ex.Message;
            }
        }

        // =====================================================
        // ADD PROJECT
        // =====================================================

        protected void btnAddProject_Click(object sender, EventArgs e)
        {
            try
            {
                string projectName = txtProjectName.Text.Trim();

                string description = txtDescription.Text.Trim();

                string status = ddlStatus.SelectedValue;

                string CreatedBy = Session["UserId"].ToString();

                // Validation
                if (projectName == "")
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;

                    lblMessage.Text = "Project name is required";

                    return;
                }

                // Check Existing Project
                string checkQuery = @"
                    SELECT COUNT(*) 
                    FROM Projects 
                    WHERE ProjectName=@ProjectName";

                SqlParameter[] checkParam =
                {
                    new SqlParameter("@ProjectName", projectName)
                };

                int exists = Convert.ToInt32(
                    DatabaseHelper.ExecuteScalar(checkQuery, checkParam)
                );

                if (exists > 0)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;

                    lblMessage.Text = "Project already exists";

                    return;
                }

                // Insert Query
                string query = @"
                    INSERT INTO Projects
                    (
                        ProjectName,
                        Description,
                        Status,
                        CreatedAt,
                        CreatedBy
                    )

                    VALUES
                    (
                        @ProjectName,
                        @Description,
                        @Status,
                        GETDATE(),
                        @CreatedBy
                    )";

                SqlParameter[] param =
                {
                    new SqlParameter("@ProjectName", projectName),

                    new SqlParameter("@Description", description),

                    new SqlParameter("@Status", status),
                    new SqlParameter("@CreatedBy", CreatedBy)
                };

                int result = DatabaseHelper.ExecuteQuery(query, param);

                if (result > 0)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Green;

                    lblMessage.Text = "Project created successfully";

                    txtProjectName.Text = "";

                    txtDescription.Text = "";

                    ddlStatus.SelectedIndex = 0;

                    LoadProjects();
                }
                else
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;

                    lblMessage.Text = "Failed to create project";
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