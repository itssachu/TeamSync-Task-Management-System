using System;
using System.Data;
using TeamSync.Helpers;

namespace TeamSync.User
{
    public partial class Notifications : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // =========================
            // LOGIN CHECK
            // =========================

            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadNotifications();
            }
        }

        // =========================
        // LOAD NOTIFICATIONS
        // =========================

        private void LoadNotifications()
        {
            try
            {
                int userId =
                    Convert.ToInt32(Session["UserId"]);

                string query = @"

                    SELECT TOP 20
                        Activity AS Title,
                        Activity AS Message,
                        ActivityDate AS CreatedAt
                    FROM ActivityLogs
                    WHERE UserID = @UserID
                    ORDER BY ActivityDate DESC
                ";

                System.Data.SqlClient.SqlParameter[] param =
                {
                    new System.Data.SqlClient.SqlParameter(
                        "@UserID",
                        userId
                    )
                };

                DataTable dt =
                    DatabaseHelper.GetDataTable(
                        query,
                        param
                    );

                lblTotalNotifications.Text =
                    dt.Rows.Count.ToString();

                if (dt.Rows.Count > 0)
                {
                    rptNotifications.DataSource = dt;

                    rptNotifications.DataBind();

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