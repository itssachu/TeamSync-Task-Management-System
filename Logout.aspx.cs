using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TeamSync
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear all sessions
            Session.Clear();

            // Abandon session
            Session.Abandon();

            // Redirect to login page
            Response.Redirect("HomePage.aspx");
        }
    }
}