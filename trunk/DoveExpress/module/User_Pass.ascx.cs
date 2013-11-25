using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Modules_User_Pass : System.Web.UI.UserControl
{
    private int UserID; 
    protected void Page_Load(object sender, EventArgs e)
    {
        /*if (!ITCLIB.Security.Security.CanViewModule("User_Pass"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        if (!ITCLIB.Security.Security.CanEditModule("User_Pass"))
        {
            dvUser_Pass.DefaultMode = DetailsViewMode.ReadOnly;
        }*/
        UserID = (int)Session["UserID"];
        Session["LastUrl"] = Request.Url.ToString();
    }
    protected void CheckPassword(object source, ServerValidateEventArgs args)
    {
        TextBox txtPassword1 = (TextBox)dvUser_Pass.FindControl("txtPassword1");
        string encryptpass = ITCLIB.Security.Security.Encrypt(txtPassword1.Text.Trim());
        string SelectSQL = "Select USERS.C_LOGINNAME FROM USERS WHERE USERS.PK_ID = '" + UserID + "' AND USERS.C_PASSWORD = '" + encryptpass + "'";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            args.IsValid = true;
        }
        else
        {
            args.IsValid = false;
        }
    }
    protected void dvUser_Pass_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
    {
        TextBox txtPassword2 = (TextBox)dvUser_Pass.FindControl("txtPassword2");
        string encryptpass = ITCLIB.Security.Security.Encrypt(txtPassword2.Text.Trim());
        User_PassDataSource.UpdateParameters["PK_ID"].DefaultValue = UserID.ToString();
        User_PassDataSource.UpdateParameters["C_PASSWORD"].DefaultValue = encryptpass;
    }
    protected void dvUser_Pass_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        ITCLIB.Admin.JavaScript.ShowMessage("Thay đổi mật khẩu thành công", this);
        ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated UserPass", "Thành công");
    }
}
