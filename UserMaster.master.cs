using System;
using System.Data;
using System.Data.SqlClient;
using TeamSync.Helpers;

namespace TeamSync
{
    public partial class UserMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // LOGIN CHECK

            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadUserData();
            }
        }

        private void LoadUserData()
        {
            try
            {
                string query = @"
                    SELECT
                        FullName,
                        Role,
                        ProfileImage
                    FROM Users
                    WHERE UserID=@UserID";

                SqlParameter[] param =
                {
                    new SqlParameter("@UserID",
                    Session["UserId"])
                };

                DataTable dt =
                    DatabaseHelper.GetDataTable(
                        query,
                        param
                    );

                if (dt.Rows.Count > 0)
                {
                    lblUserName.Text =
                        dt.Rows[0]["FullName"].ToString();

                    lblRole.Text =
                        dt.Rows[0]["Role"].ToString();
                }
            }
            catch
            {

            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();

            Session.Abandon();

            Response.Redirect("~/Login.aspx");
        }
    }
}