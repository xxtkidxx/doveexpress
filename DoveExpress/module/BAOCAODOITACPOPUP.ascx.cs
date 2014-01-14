using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class module_BAOCAODOITACPOPUP : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!ITCLIB.Security.Security.CanPrintModule("BAOCAO"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }

        Session["LastUrl"] = Request.Url.ToString();
        RadAjaxManager ajaxManager = RadAjaxManager.GetCurrent(Page);
        ajaxManager.AjaxRequest += new RadAjaxControl.AjaxRequestDelegate(RadScriptManager_AjaxRequestNGPU);
        ajaxManager.ClientEvents.OnResponseEnd = "onResponseEndNGPU";
        cmbDoiTac.SelectedIndex = 0;
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
                UpdateSQL += "UPDATE [NHANGUI] SET [FK_DOITAC] = '" + cmbDoiTac.SelectedValue + "',[C_GIADOITAC] = '" + txtC_GIADOITAC.Text + "' WHERE [C_BILL] = '" + C_BILL.Trim() + "';";
            }
            ITCLIB.Admin.SQL UpdateQuery = new ITCLIB.Admin.SQL();
            UpdateQuery.ExecuteNonQuery(UpdateSQL);
            string script = string.Format("var result = '{0}'", "Cập nhật thông tin Bill thành công");
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
        }
    }
}