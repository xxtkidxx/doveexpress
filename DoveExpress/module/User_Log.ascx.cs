using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Modules_User_Log : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!ITCLIB.Security.Security.IsSysAdmin())
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        Session["LastUrl"] = Request.Url.ToString();
    }
    protected void gvUser_Log_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "ClearAll")
        {
            string DeleteSQL = "DELETE FROM USER_LOG";
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            SelectQuery.ExecuteNonQuery(DeleteSQL);
            gvUser_Log.DataBind();
        }
    }
}
