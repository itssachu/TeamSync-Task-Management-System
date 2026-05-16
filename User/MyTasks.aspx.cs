using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using TeamSync.Helpers;

namespace TeamSync.User
{
    public partial class MyTasks : System.Web.UI.Page
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
                LoadTasks();
            }
        }

        // =========================
        // LOAD TASKS
        // =========================

        private void LoadTasks()
        {
            try
            {
                int userId =
                    Convert.ToInt32(Session["UserId"]);

                string query = @"

                    SELECT
                        TaskID,
                        TaskTitle,
                        TaskDescription,
                        Priority,
                        Status,
                        DueDate

                    FROM Tasks

                    WHERE AssignedTo=@UserID
                ";

                // FILTER STATUS

                if (ddlStatus.SelectedValue != "")
                {
                    query += " AND Status=@Status";
                }

                query += " ORDER BY DueDate ASC";

                SqlParameter[] param;

                if (ddlStatus.SelectedValue != "")
                {
                    param = new SqlParameter[]
                    {
                        new SqlParameter("@UserID", userId),
                        new SqlParameter("@Status", ddlStatus.SelectedValue)
                    };
                }
                else
                {
                    param = new SqlParameter[]
                    {
                        new SqlParameter("@UserID", userId)
                    };
                }

                DataTable dt =
                    DatabaseHelper.GetDataTable(
                        query,
                        param
                    );

                gvTasks.DataSource = dt;

                gvTasks.DataBind();

                // SET DROPDOWN VALUES

                foreach (GridViewRow row in gvTasks.Rows)
                {
                    DropDownList ddl =
                        (DropDownList)row.FindControl("ddlTaskStatus");

                    string currentStatus =
                        dt.Rows[row.RowIndex]["Status"].ToString();

                    ddl.SelectedValue = currentStatus;
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }

        // =========================
        // FILTER
        // =========================

        protected void ddlStatus_SelectedIndexChanged(
            object sender,
            EventArgs e)
        {
            LoadTasks();
        }

        // =========================
        // UPDATE TASK STATUS
        // =========================

        protected void gvTasks_RowCommand(
            object sender,
            GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateTask")
            {
                try
                {
                    Button btn =
                        (Button)e.CommandSource;

                    GridViewRow row =
                        (GridViewRow)btn.NamingContainer;

                    DropDownList ddl =
                        (DropDownList)row.FindControl(
                            "ddlTaskStatus");

                    string newStatus =
                        ddl.SelectedValue;

                    int taskId =
                        Convert.ToInt32(
                            e.CommandArgument);

                    string query = @"

                        UPDATE Tasks

                        SET Status=@Status

                        WHERE TaskID=@TaskID
                    ";

                    SqlParameter[] param =
                    {
                        new SqlParameter("@Status", newStatus),

                        new SqlParameter("@TaskID", taskId)
                    };

                    DatabaseHelper.ExecuteQuery(
                        query,
                        param
                    );

                    LoadTasks();
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }
            }
        }
    }
}