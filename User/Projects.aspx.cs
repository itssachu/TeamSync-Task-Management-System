using System;
using System.Data;
using System.Data.SqlClient;
using TeamSync.Helpers;

namespace TeamSync.User
{
    public partial class Projects : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // =========================
            // SESSION CHECK
            // =========================

            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadProjectStats();

                LoadProjects();
            }
        }

        // =========================
        // LOAD STATS
        // =========================

        private void LoadProjectStats()
        {
            try
            {
                int userId =
                    Convert.ToInt32(Session["UserId"]);

                // TOTAL

                string totalQuery = @"

                    SELECT COUNT(*)

                    FROM Projects
                ";

                lblTotalProjects.Text =
                    DatabaseHelper.ExecuteScalar(
                        totalQuery
                    ).ToString();

                // ACTIVE

                string activeQuery = @"

                    SELECT COUNT(*)

                    FROM Projects

                    WHERE Status='Active'
                ";

                lblActiveProjects.Text =
                    DatabaseHelper.ExecuteScalar(
                        activeQuery
                    ).ToString();

                // COMPLETED

                string completedQuery = @"

                    SELECT COUNT(*)

                    FROM Projects

                    WHERE Status='Completed'
                ";

                lblCompletedProjects.Text =
                    DatabaseHelper.ExecuteScalar(
                        completedQuery
                    ).ToString();
            }
            catch
            {

            }
        }

        // =========================
        // LOAD PROJECTS
        // =========================

        private void LoadProjects()
        {
            try
            {
                string query = @"

                    SELECT
                        ProjectID,
                        ProjectName,
                        Description,
                        Status,
                        Progress,
                        CreatedAt,

                        (
                            SELECT COUNT(*)
                            FROM Users
                        ) AS TeamCount

                    FROM Projects

                    ORDER BY ProjectID DESC
                ";

                DataTable dt =
                    DatabaseHelper.GetDataTable(query);

                if (dt.Rows.Count > 0)
                {
                    rptProjects.DataSource = dt;

                    rptProjects.DataBind();

                    pnlEmpty.Visible = false;
                }
                else
                {
                    pnlEmpty.Visible = true;
                }
            }
            catch
            {

            }
        }
    }
}