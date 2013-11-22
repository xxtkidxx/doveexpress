using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class Admin_Modules_User_priv : System.Web.UI.UserControl
{
    private int guID;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!ITCLIB.Security.Security.IsSysAdmin())
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        if (Request.QueryString["ctl"] != null)
        {
            guID = int.Parse(Request.QueryString["guID"]);
        }
        Session["LastUrl"] = Request.Url.ToString();
    }
    protected void lblGroupUserName_PreRender(object sender, EventArgs e)
    {
        Label lblGroupUserName = (Label)sender;
        string SelectSQL = "SELECT C_NAME FROM GROUPUSER WHERE PK_ID =" + guID;
        ITCLIB.Admin.SQL result = new ITCLIB.Admin.SQL();
        DataTable oDataTable = result.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            DataRow oRow = oDataTable.Rows[0];
            lblGroupUserName.Text = (string)oRow["C_NAME"];
        }
    }
    protected void RadGridUserPrivModule_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdatePriv")
        {
            if (RadGridUserPrivModule.Items.Count > 0)
            {
                string UpdateSQL = "";
                foreach (GridDataItem item in RadGridUserPrivModule.Items)
                {
                    CheckBox chk1 = (CheckBox)item.FindControl("chkView");
                    CheckBox chk2 = (CheckBox)item.FindControl("chkAdd");
                    CheckBox chk3 = (CheckBox)item.FindControl("chkEdit");
                    CheckBox chk4 = (CheckBox)item.FindControl("chkDelete");
                    CheckBox chk5 = (CheckBox)item.FindControl("chkPrint");
                    ITCLIB.Security.Security security = new ITCLIB.Security.Security();
                    int value = security.ConvertPermissionToDB(chk1.Checked, chk2.Checked, chk3.Checked, chk4.Checked, chk5.Checked);
                    UpdateSQL += ";UPDATE GROUPUSER_MODULE SET C_LEVELPERMISSION=" + value + " WHERE FK_MODULE=" + (item.FindControl("hfModule") as HiddenField).Value + " AND FK_GROUPUSER=" + guID;
                }
                ITCLIB.Admin.SQL result = new ITCLIB.Admin.SQL();
                if (result.ExecuteNonQuery(UpdateSQL) != 0)
                {
                    SetMessage("Phân quyền thành công");
                    ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Permission GroupUsers", "Successed");
                }
            }
            else
            {
                SetMessage("Hãy cập nhật danh sách quyền.");
            }
            RadGridUserPrivModule.DataBind();
        }
        else if (e.CommandName == RadGrid.RebindGridCommandName)
        {
            ITCLIB.Security.Security security = new ITCLIB.Security.Security();
            ITCLIB.Security.Security.CheckPermissionModule(guID);
            RadGridUserPrivModule.DataBind();
        }
    }
    private void DisplayMessage(string text)
    {
        RadGridUserPrivModule.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridUserPrivModule_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
}
