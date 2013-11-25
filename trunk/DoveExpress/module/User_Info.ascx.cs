using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Modules_User_Info : System.Web.UI.UserControl
{
    private int UserID;
    protected void Page_Load(object sender, EventArgs e)
    {
        /*if (!ITCLIB.Security.Security.CanViewModule("User_Info"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        if (!ITCLIB.Security.Security.CanEditModule("User_Info"))
        {
            dvUser_Info.DefaultMode = DetailsViewMode.ReadOnly;
        }*/
        UserID = (int)Session["UserID"];
        Session["LastUrl"] = Request.Url.ToString();
    }
    protected void CheckEmail(object source, ServerValidateEventArgs args)
    {
        TextBox txtEmail = (TextBox)dvUser_Info.FindControl("txtEmail");
        string SelectSQL = "Select USERS.C_LOGINNAME FROM USERS WHERE USERS.C_EMAIL = '" + txtEmail.Text + "' AND USERS.PK_ID <> " + UserID;
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            args.IsValid = false;
        }
        else
        {
            args.IsValid = true;
        }
    }
    protected void dvUser_Info_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        if (e.AffectedRows != 0)
        {
            ITCLIB.Admin.JavaScript.ShowMessage("Thay đổi thông tin thành công", this);
            ITCLIB.Security.User sUser = new ITCLIB.Security.User();
            sUser = (ITCLIB.Security.User)Session["User"];
            TextBox txtName = (TextBox)dvUser_Info.FindControl("txtName");
            sUser.UserName = txtName.Text;
            Session["User"] = sUser;
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated UserInfo", "Thành công");
        }
    }
}
