using System;
using System.Data;
using TeamSync;
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
            // =========================================
            // TOTAL PROJECTS
            // =========================================

            string projectQuery = "SELECT COUNT(*) FROM Projects";

            lblProjects.Text =
                DatabaseHelper.ExecuteScalar(projectQuery).ToString();

            // =========================================
            // TOTAL TASKS
            // =========================================

            string taskQuery = "SELECT COUNT(*) FROM Tasks";

            lblTasks.Text =
                DatabaseHelper.ExecuteScalar(taskQuery).ToString();

            // =========================================
            // COMPLETED TASKS
            // =========================================

            string completedQuery =
                "SELECT COUNT(*) FROM Tasks WHERE Status='Completed'";

            lblCompleted.Text =
                DatabaseHelper.ExecuteScalar(completedQuery).ToString();

            // =========================================
            // OVERDUE TASKS
            // =========================================

            string overdueQuery = @"
                SELECT COUNT(*)
                FROM Tasks
                WHERE DueDate < GETDATE()
                AND Status != 'Completed'";

            lblOverdue.Text =
                DatabaseHelper.ExecuteScalar(overdueQuery).ToString();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }
}