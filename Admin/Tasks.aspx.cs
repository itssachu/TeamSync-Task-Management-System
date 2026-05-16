using System;
using System.Data;
using System.Data.SqlClient;
using TeamSync.Helpers;

namespace TeamSync.Admin
{
    public partial class Tasks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
        // LOAD PROJECTS
        // =====================================================

        private void LoadProjects()
        {
            try
            {
                string query = @"
                    SELECT *
                    FROM Projects
                    ORDER BY ProjectName ASC";

                DataTable dt = DatabaseHelper.GetDataTable(query);

                ddlProject.DataSource = dt;

                ddlProject.DataTextField = "ProjectName";

                ddlProject.DataValueField = "ProjectID";

                ddlProject.DataBind();

                ddlProject.Items.Insert(0,
                    new System.Web.UI.WebControls.ListItem("Select Project", ""));
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;

                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        // =====================================================
        // LOAD USERS
        // =====================================================

        private void LoadUsers()
        {
            try
            {
                string query = @"
                    SELECT *
                    FROM Users
                    WHERE IsActive = 1
                    ORDER BY FullName ASC";

                DataTable dt = DatabaseHelper.GetDataTable(query);

                ddlUser.DataSource = dt;

                ddlUser.DataTextField = "FullName";

                ddlUser.DataValueField = "UserID";

                ddlUser.DataBind();

                ddlUser.Items.Insert(0,
                    new System.Web.UI.WebControls.ListItem("Select User", ""));
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;

                lblMessage.ForeColor = System.Drawing.Color.Red;
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
                        T.Priority,
                        T.Status,
                        T.DueDate,

                        P.ProjectName,

                        U.FullName AS AssignedToName

                    FROM Tasks T

                    INNER JOIN Projects P
                    ON T.ProjectID = P.ProjectID

                    LEFT JOIN Users U
                    ON T.AssignedTo = U.UserID

                    ORDER BY T.TaskID DESC";

                DataTable dt = DatabaseHelper.GetDataTable(query);

                gvTasks.DataSource = dt;

                gvTasks.DataBind();
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;

                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        // =====================================================
        // CREATE TASK
        // =====================================================

        protected void btnAddTask_Click(object sender, EventArgs e)
        {
            try
            {
                string taskTitle = txtTaskName.Text.Trim();

                string description = txtDescription.Text.Trim();

                string projectID = ddlProject.SelectedValue;

                string assignedTo = ddlUser.SelectedValue;

                string priority = ddlPriority.SelectedValue;

                string status = ddlStatus.SelectedValue;

                string startDate = txtStartDate.Text;

                string dueDate = txtDueDate.Text;

                int assignedBy = Convert.ToInt32(Session["UserId"]);

                // VALIDATION

                if (taskTitle == "")
                {
                    lblMessage.Text = "Task title is required";

                    lblMessage.ForeColor = System.Drawing.Color.Red;

                    return;
                }

                if (projectID == "")
                {
                    lblMessage.Text = "Please select project";

                    lblMessage.ForeColor = System.Drawing.Color.Red;

                    return;
                }

                if (assignedTo == "")
                {
                    lblMessage.Text = "Please select user";

                    lblMessage.ForeColor = System.Drawing.Color.Red;

                    return;
                }

                // INSERT TASK

                string query = @"
                    INSERT INTO Tasks
                    (
                        ProjectID,
                        TaskTitle,
                        TaskDescription,
                        AssignedTo,
                        AssignedBy,
                        Priority,
                        Status,
                        StartDate,
                        DueDate,
                        CreatedAt
                    )

                    VALUES
                    (
                        @ProjectID,
                        @TaskTitle,
                        @TaskDescription,
                        @AssignedTo,
                        @AssignedBy,
                        @Priority,
                        @Status,
                        @StartDate,
                        @DueDate,
                        GETDATE()
                    )";

                SqlParameter[] param =
                {
                    new SqlParameter("@ProjectID", projectID),

                    new SqlParameter("@TaskTitle", taskTitle),

                    new SqlParameter("@TaskDescription", description),

                    new SqlParameter("@AssignedTo", assignedTo),

                    new SqlParameter("@AssignedBy", assignedBy),

                    new SqlParameter("@Priority", priority),

                    new SqlParameter("@Status", status),

                    new SqlParameter("@StartDate",
                        string.IsNullOrEmpty(startDate)
                        ? (object)DBNull.Value
                        : Convert.ToDateTime(startDate)),

                    new SqlParameter("@DueDate",
                        string.IsNullOrEmpty(dueDate)
                        ? (object)DBNull.Value
                        : Convert.ToDateTime(dueDate))
                };

                int result = DatabaseHelper.ExecuteQuery(query, param);

                if (result > 0)
                {
                    lblMessage.Text = "Task created successfully";

                    lblMessage.ForeColor = System.Drawing.Color.Green;

                    ClearFields();

                    LoadTasks();
                }
                else
                {
                    lblMessage.Text = "Failed to create task";

                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;

                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        // =====================================================
        // CLEAR FIELDS
        // =====================================================

        private void ClearFields()
        {
            txtTaskName.Text = "";

            txtDescription.Text = "";

            txtStartDate.Text = "";

            txtDueDate.Text = "";

            ddlProject.SelectedIndex = 0;

            ddlUser.SelectedIndex = 0;

            ddlPriority.SelectedIndex = 1;

            ddlStatus.SelectedIndex = 0;
        }

        // =====================================================
        // STATUS CLASS
        // =====================================================

        protected string GetStatusClass(string status)
        {
            switch (status)
            {
                case "Completed":
                    return "completed";

                case "In Progress":
                    return "progress-status";

                default:
                    return "pending";
            }
        }
    }
}