using System;
using System.Data;
using System.Data.SqlClient;
using TeamSync;
using TeamSync.Helpers;

namespace TeamSync.Admin
{
    public partial class Tasks : System.Web.UI.Page
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

                LoadUsers();

                LoadTasks();
            }
        }

        // =====================================================
        // LOAD PROJECTS DROPDOWN
        // =====================================================

        private void LoadProjects()
        {
            try
            {
                string query = "SELECT * FROM Projects ORDER BY ProjectName ASC";

                DataTable dt = DatabaseHelper.GetDataTable(query);

                ddlProject.DataSource = dt;

                ddlProject.DataTextField = "ProjectName";

                ddlProject.DataValueField = "ProjectID";

                ddlProject.DataBind();

                ddlProject.Items.Insert(0, "Select Project");
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;

                lblMessage.Text = ex.Message;
            }
        }

        // =====================================================
        // LOAD USERS DROPDOWN
        // =====================================================

        private void LoadUsers()
        {
            try
            {
                string query = "SELECT * FROM Users ORDER BY FullName ASC";

                DataTable dt = DatabaseHelper.GetDataTable(query);

                ddlUser.DataSource = dt;

                ddlUser.DataTextField = "FullName";

                ddlUser.DataValueField = "UserID";

                ddlUser.DataBind();

                ddlUser.Items.Insert(0, "Select User");
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;

                lblMessage.Text = ex.Message;
            }
        }

        // =====================================================
        // LOAD TASKS
        // =====================================================

        private void LoadTasks()
        {
            try
            {
                string query = @"
                    SELECT 
                        T.TaskID,
                        T.TaskTitle,
                        P.ProjectName,
                        U.FullName,
                        T.Status,
                        T.DueDate

                    FROM Tasks T

                    INNER JOIN Projects P
                    ON T.ProjectId = P.ProjectID

                    INNER JOIN Users U
                    ON T.AssignedTo = U.UserID

                    ORDER BY T.TaskID DESC";

                DataTable dt = DatabaseHelper.GetDataTable(query);

                gvTasks.DataSource = dt;

                gvTasks.DataBind();
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;

                lblMessage.Text = ex.Message;
            }
        }

        // =====================================================
        // ADD TASK
        // =====================================================

        protected void btnAddTask_Click(object sender, EventArgs e)
        {
            try
            {
                string taskName = txtTaskName.Text.Trim();

                string description = txtDescription.Text.Trim();

                string projectId = ddlProject.SelectedValue;

                string assignedTo = ddlUser.SelectedValue;

                string status = ddlStatus.SelectedValue;

                string dueDate = txtDueDate.Text;

                // Validation
                if (taskName == "")
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;

                    lblMessage.Text = "Task name is required";

                    return;
                }

                if (projectId == "Select Project")
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;

                    lblMessage.Text = "Please select a project";

                    return;
                }

                if (assignedTo == "Select User")
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;

                    lblMessage.Text = "Please select a user";

                    return;
                }

                // Insert Query
                string query = @"
                    INSERT INTO Tasks
                    (
                        TaskTitle,
                        TaskDescription,
                        ProjectId,
                        AssignedTo,
                        Status,
                        DueDate,
                        CreatedAt
                    )

                    VALUES
                    (
                        @TaskTitle,
                        @TaskDescription,
                        @ProjectId,
                        @AssignedTo,
                        @Status,
                        @DueDate,
                        GETDATE()
                    )";

                SqlParameter[] param =
                {
                    new SqlParameter("@TaskTitle", taskName),

                    new SqlParameter("@TaskDescription", description),

                    new SqlParameter("@ProjectId", projectId),

                    new SqlParameter("@AssignedTo", assignedTo),

                    new SqlParameter("@Status", status),

                    new SqlParameter("@DueDate", dueDate)
                };

                int result = DatabaseHelper.ExecuteQuery(query, param);

                if (result > 0)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Green;

                    lblMessage.Text = "Task created successfully";

                    txtTaskName.Text = "";

                    txtDescription.Text = "";

                    txtDueDate.Text = "";

                    ddlProject.SelectedIndex = 0;

                    ddlUser.SelectedIndex = 0;

                    ddlStatus.SelectedIndex = 0;

                    LoadTasks();
                }
                else
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;

                    lblMessage.Text = "Failed to create task";
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