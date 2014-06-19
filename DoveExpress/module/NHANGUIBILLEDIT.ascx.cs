using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class module_NHANGUIBILLEDIT : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!ITCLIB.Security.Security.CanEditModule("NHANGUI"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }

        Session["LastUrl"] = Request.Url.ToString();
        RadAjaxManager ajaxManager = RadAjaxManager.GetCurrent(Page);
        ajaxManager.AjaxRequest += new RadAjaxControl.AjaxRequestDelegate(RadScriptManager_AjaxRequestNGPU);
        ajaxManager.ClientEvents.OnResponseEnd = "onResponseEndNGPU";
    }
    protected void RadScriptManager_AjaxRequestNGPU(object sender, AjaxRequestEventArgs e)
    {
        string Alarm = "";
        if (txtC_BILLOLD.Text != "" && txtC_BILLNEW.Text != "")
        {
            if (!CheckBillQuick(txtC_BILLOLD.Text.Trim()))
            {
                if (CheckBillQuick(txtC_BILLNEW.Text.Trim()))
                {
                    string UpdateSQL = "UPDATE [NHANGUI] SET [C_BILL] = '" + txtC_BILLNEW.Text.Trim() + " ' WHERE [C_BILL] = '" + txtC_BILLOLD.Text.Trim() + "';" + "UPDATE [SOQUYTIENMAT] SET [C_BILL] = '" + txtC_BILLNEW.Text.Trim() + " ' WHERE [C_BILL] = '" + txtC_BILLOLD.Text.Trim() + "';" + "UPDATE [TRACKING] SET [C_BILL] = '" + txtC_BILLNEW.Text.Trim() + " ' WHERE [C_BILL] = '" + txtC_BILLOLD.Text.Trim() + "'";
                    ITCLIB.Admin.SQL UpdateQuery = new ITCLIB.Admin.SQL();
                    UpdateQuery.ExecuteNonQuery(UpdateSQL);
                    Alarm = string.Format("Cập nhật thông tin Bill thành công");
                }
                else
                {
                    Alarm = string.Format("Số Bill mới đã có trong cơ sở dữ liệu");
                }
            }
            else
            {
                Alarm = string.Format("Không tồn tại số Bill cũ trong cơ sở dữ liệu");
            }           
        }
        else
        {
            Alarm = string.Format("Hãy nhập số Bill cũ và số Bill mới");
        }
        string script = string.Format("var result = '{0}'", Alarm);
        ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
    }
    protected bool CheckBillQuick(string C_BILL)
    {
        string SelectSQL;
        SelectSQL = "Select NHANGUI.C_BILL FROM NHANGUI WHERE NHANGUI.C_BILL = '" + C_BILL + "'";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            return false;
        }
        else
        {
            return true;
        }
    }
}