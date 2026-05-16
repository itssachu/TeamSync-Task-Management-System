using System;
using System.Data.SqlClient;
using TeamSync.Helpers;

namespace TeamSync.User
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                lblName.Text =
                    Session["Name"].ToString();

                LoadDashboardData();
            }
        }

        private void LoadDashboardData()
        {
            try
            {
                int userId =
                    Convert.ToInt32(Session["UserId"]);

                // ====================================
                // TOTAL TASKS
                // ====================================

                string totalQuery = @"
                    SELECT COUNT(*)
                    FROM Tasks
                    WHERE AssignedTo=@UserID";

                lblTotalTasks.Text =
                    DatabaseHelper.ExecuteScalar(
                        totalQuery,
                        new SqlParameter[]
                        {
                            new SqlParameter("@UserID", userId)
                        }
                    ).ToString();

                // ====================================
                // PENDING TASKS
                // ====================================

                string pendingQuery = @"
                    SELECT COUNT(*)
                    FROM Tasks
                    WHERE AssignedTo=@UserID
                    AND Status='Pending'";

                lblPendingTasks.Text =
                    DatabaseHelper.ExecuteScalar(
                        pendingQuery,
                        new SqlParameter[]
                        {
                            new SqlParameter("@UserID", userId)
                        }
                    ).ToString();

                lblPendingHidden.Text =
                    lblPendingTasks.Text;

                // ====================================
                // COMPLETED TASKS
                // ====================================

                string completedQuery = @"
                    SELECT COUNT(*)
                    FROM Tasks
                    WHERE AssignedTo=@UserID
                    AND Status='Completed'";

                lblCompletedTasks.Text =
                    DatabaseHelper.ExecuteScalar(
                        completedQuery,
                        new SqlParameter[]
                        {
                            new SqlParameter("@UserID", userId)
                        }
                    ).ToString();

                lblCompletedHidden.Text =
                    lblCompletedTasks.Text;

                // ====================================
                // OVERDUE TASKS
                // ====================================

                string overdueQuery = @"
                    SELECT COUNT(*)
                    FROM Tasks
                    WHERE AssignedTo=@UserID
                    AND DueDate < GETDATE()
                    AND Status!='Completed'";

                lblOverdueTasks.Text =
                    DatabaseHelper.ExecuteScalar(
                        overdueQuery,
                        new SqlParameter[]
                        {
                            new SqlParameter("@UserID", userId)
                        }
                    ).ToString();

                lblOverdueHidden.Text =
                    lblOverdueTasks.Text;

                // ====================================
                // RECENT TASKS
                // ====================================

                LoadRecentTasks();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }

        private void LoadRecentTasks()
        {
            try
            {
                int userId =
                    Convert.ToInt32(Session["UserId"]);

                string query = @"
                    SELECT TOP 5
                    TaskTitle,
                    Status,
                    Priority,
                    DueDate
                    FROM Tasks
                    WHERE AssignedTo=@UserID
                    ORDER BY TaskID DESC";

                rptTasks.DataSource =
                    DatabaseHelper.GetDataTable(
                        query,
                        new SqlParameter[]
                        {
                            new SqlParameter("@UserID", userId)
                        }
                    );

                rptTasks.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
    }
}