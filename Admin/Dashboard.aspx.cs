using System;
using TeamSync.Helpers;

public partial class Admin_Dashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDashboardData();
        }
    }

    private void LoadDashboardData()
    {
        try
        {
            // =========================
            // TOTAL PROJECTS
            // =========================

            string projectQuery =
                "SELECT COUNT(*) FROM Projects";

            object totalProjects =
                DatabaseHelper.ExecuteScalar(projectQuery);

            lblProjects.Text =
                totalProjects != null
                ? totalProjects.ToString()
                : "0";

            // =========================
            // TOTAL TASKS
            // =========================

            string taskQuery =
                "SELECT COUNT(*) FROM Tasks";

            object totalTasks =
                DatabaseHelper.ExecuteScalar(taskQuery);

            lblTasks.Text =
                totalTasks != null
                ? totalTasks.ToString()
                : "0";

            // =========================
            // COMPLETED TASKS
            // =========================

            string completedQuery =
                "SELECT COUNT(*) FROM Tasks WHERE Status='Completed'";

            object completedTasks =
                DatabaseHelper.ExecuteScalar(completedQuery);

            lblCompleted.Text =
                completedTasks != null
                ? completedTasks.ToString()
                : "0";

            lblCompletedHidden.Text =
                lblCompleted.Text;

            // =========================
            // PENDING TASKS
            // =========================

            string pendingQuery =
                "SELECT COUNT(*) FROM Tasks WHERE Status='Pending'";

            object pendingTasks =
                DatabaseHelper.ExecuteScalar(pendingQuery);

            lblPending.Text =
                pendingTasks != null
                ? pendingTasks.ToString()
                : "0";

            // =========================
            // IN PROGRESS TASKS
            // =========================

            string progressQuery =
                "SELECT COUNT(*) FROM Tasks WHERE Status='In Progress'";

            object progressTasks =
                DatabaseHelper.ExecuteScalar(progressQuery);

            lblInProgress.Text =
                progressTasks != null
                ? progressTasks.ToString()
                : "0";

            // =========================
            // OVERDUE TASKS
            // =========================

            string overdueQuery = @"
                SELECT COUNT(*)
                FROM Tasks
                WHERE DueDate < GETDATE()
                AND Status != 'Completed'";

            object overdueTasks =
                DatabaseHelper.ExecuteScalar(overdueQuery);

            lblOverdue.Text =
                overdueTasks != null
                ? overdueTasks.ToString()
                : "0";

            lblOverdueHidden.Text =
                lblOverdue.Text;
        }
        catch (Exception ex)
        {
            Response.Write(
                "<script>alert('Error Loading Dashboard: "
                + ex.Message.Replace("'", "")
                + "');</script>");
        }
    }
}