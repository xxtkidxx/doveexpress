using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class module_NHANGUIPOPUP : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!ITCLIB.Security.Security.CanPrintModule("NHANGUIPH"))
        {
            ITCLIB.Security.Security.ReturnUrl();        }

        Session["LastUrl"] = Request.Url.ToString();
        RadAjaxManager ajaxManager = RadAjaxManager.GetCurrent(Page);
        ajaxManager.AjaxRequest += new RadAjaxControl.AjaxRequestDelegate(RadScriptManager_AjaxRequestNGPU);
        ajaxManager.ClientEvents.OnResponseEnd = "onResponseEndNGPU";
        radC_NGAYGIOPHAT.SelectedDate = System.DateTime.Now;
        //cmbFK_NHANVIENPHAT.SelectedIndex = 0;
        //cmbFK_NHANVIENKHAITHAC.SelectedIndex = 0;
    }
    protected void RadScriptManager_AjaxRequestNGPU(object sender, AjaxRequestEventArgs e)
    {
        if (Request.QueryString["IDBILL"] != null)
        {
            string[] IDBILLS;
            IDBILLS = Request.QueryString["IDBILL"].Replace("BILL-", "").Split('-');
            string UpdateSQL = "";
            foreach (string C_BILL in IDBILLS)
            {
                //UpdateSQL += "UPDATE [NHANGUI] SET [FK_NHANVIENPHAT] = '" + cmbFK_NHANVIENPHAT.SelectedValue + "',[C_NGAYGIOPHAT] = '" + radC_NGAYGIOPHAT.SelectedDate + "',[FK_NHANVIENKHAITHAC] = '" + cmbFK_NHANVIENKHAITHAC.SelectedValue + "',[C_NGUOIKYNHAN] = N'" + txtC_NGUOIKYNHAN.Text + "', [C_BOPHAN]= N'" + txtC_BOPHAN.Text + "' WHERE [C_BILL] = '" + C_BILL.Trim() + "';";
                if (cmbFK_TRANGTHAI.SelectedValue != "0")
                {
                    UpdateSQL += "INSERT INTO TRACKING (C_BILL, C_DATE, FK_TRANGTHAI, C_DESC) VALUES ('" + C_BILL.Trim() + "','" + String.Format("{0:yyyy-MM-dd hh:mm:ss tt}", radC_NGAYGIOPHAT.SelectedDate) + "',N'" + cmbFK_TRANGTHAI.SelectedValue + "'," + (txtC_DESC.Text == "" ? "NULL" : "N'" + txtC_DESC.Text + "'") + ")";
                }                
            }
            ITCLIB.Admin.SQL UpdateQuery = new ITCLIB.Admin.SQL();
            UpdateQuery.ExecuteNonQuery(UpdateSQL);
            string script = string.Format("var result = '{0}'","Cập nhật thông tin Bill thành công");
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
        }
    }    
}