using System;
using System.Data;
using System.Text;
using TeamSync.Helpers;

namespace TeamSync.User
{
    public partial class Calendar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // ==========================
            // SESSION CHECK
            // ==========================

            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadEvents();

                LoadCalendarEvents();
            }
        }

        // ==========================
        // LOAD EVENT LIST
        // ==========================

        private void LoadEvents()
        {
            try
            {
                string query = @"

                    SELECT TOP 5
                        TaskTitle AS Title,
                        DueDate AS EventDate
                    FROM Tasks
                    WHERE DueDate >= GETDATE()

                    ORDER BY DueDate ASC
                ";

                DataTable dt =
                    DatabaseHelper.GetDataTable(query);

                lblTotalEvents.Text =
                    dt.Rows.Count.ToString();

                if (dt.Rows.Count > 0)
                {
                    rptEvents.DataSource = dt;

                    rptEvents.DataBind();

                    pnlNoEvents.Visible = false;
                }
                else
                {
                    pnlNoEvents.Visible = true;
                }
            }
            catch
            {

            }
        }

        // ==========================
        // LOAD CALENDAR EVENTS
        // ==========================

        private void LoadCalendarEvents()
        {
            try
            {
                string query = @"

                    SELECT
                        TaskTitle,
                        DueDate,
                        Status
                    FROM Tasks
                ";

                DataTable dt =
                    DatabaseHelper.GetDataTable(query);

                StringBuilder json =
                    new StringBuilder();

                json.Append("[");

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string title =
                        dt.Rows[i]["TaskTitle"].ToString();

                    string date =
                        Convert.ToDateTime(
                            dt.Rows[i]["DueDate"]
                        ).ToString("yyyy-MM-dd");

                    string status =
                        dt.Rows[i]["Status"].ToString();

                    string color =
                        "#4f46e5";

                    if (status == "Completed")
                    {
                        color = "#10b981";
                    }
                    else if (status == "Pending")
                    {
                        color = "#ef4444";
                    }
                    else if (status == "In Progress")
                    {
                        color = "#f59e0b";
                    }

                    json.Append("{");

                    json.AppendFormat(
                        "\"title\":\"{0}\",",
                        title.Replace("\"", "")
                    );

                    json.AppendFormat(
                        "\"start\":\"{0}\",",
                        date
                    );

                    json.AppendFormat(
                        "\"backgroundColor\":\"{0}\",",
                        color
                    );

                    json.AppendFormat(
                        "\"borderColor\":\"{0}\"",
                        color
                    );

                    json.Append("}");

                    if (i < dt.Rows.Count - 1)
                    {
                        json.Append(",");
                    }
                }

                json.Append("]");

                hfEvents.Value =
                    json.ToString();
            }
            catch
            {

            }
        }
    }
}