using System;
using System.Data;
using System.Data.SqlClient;
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

        // =========================================================
        // LOAD PROJECTS
        // =========================================================

        private void LoadProjects()
        {
            try
            {
                string query = @"
                    SELECT
                        P.ProjectID,
                        P.ProjectName,
                        P.Description,
                        P.StartDate,
                        P.EndDate,
                        P.Status,
                        P.CreatedAt,
                        U.FullName AS CreatedByName

                    FROM Projects P

                    INNER JOIN Users U
                    ON P.CreatedBy = U.UserID

                    ORDER BY P.ProjectID DESC";

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

        // =========================================================
        // ADD PROJECT
        // =========================================================

        protected void btnAddProject_Click(object sender, EventArgs e)
        {
            try
            {
                string projectName = txtProjectName.Text.Trim();

                string description = txtDescription.Text.Trim();

                string status = ddlStatus.SelectedValue;

                string startDate = txtStartDate.Text;

                string endDate = txtEndDate.Text;

                int createdBy = Convert.ToInt32(Session["UserId"]);

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

                // Insert Project

                string query = @"
                    INSERT INTO Projects
                    (
                        ProjectName,
                        Description,
                        StartDate,
                        EndDate,
                        Status,
                        CreatedBy,
                        CreatedAt
                    )

                    VALUES
                    (
                        @ProjectName,
                        @Description,
                        @StartDate,
                        @EndDate,
                        @Status,
                        @CreatedBy,
                        GETDATE()
                    )";

                SqlParameter[] param =
                {
                    new SqlParameter("@ProjectName", projectName),

                    new SqlParameter("@Description", description),

                    new SqlParameter("@StartDate",
                        string.IsNullOrEmpty(startDate)
                        ? (object)DBNull.Value
                        : Convert.ToDateTime(startDate)),

                    new SqlParameter("@EndDate",
                        string.IsNullOrEmpty(endDate)
                        ? (object)DBNull.Value
                        : Convert.ToDateTime(endDate)),

                    new SqlParameter("@Status", status),

                    new SqlParameter("@CreatedBy", createdBy)
                };

                int result = DatabaseHelper.ExecuteQuery(query, param);

                if (result > 0)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Green;

                    lblMessage.Text = "Project created successfully";

                    ClearFields();

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

        // =========================================================
        // CLEAR FIELDS
        // =========================================================

        private void ClearFields()
        {
            txtProjectName.Text = "";

            txtDescription.Text = "";

            txtStartDate.Text = "";

            txtEndDate.Text = "";

            ddlStatus.SelectedIndex = 0;
        }

        // =========================================================
        // STATUS BADGE CSS
        // =========================================================

        protected string GetStatusClass(string status)
        {
            switch (status)
            {
                case "Active":
                    return "status-active";

                case "Completed":
                    return "status-completed";

                default:
                    return "status-pending";
            }
        }
    }
}