using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Popup : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (ITCLIB.Security.Security.IsLogedIn())
        {
            ITCLIB.Security.User user = new ITCLIB.Security.User();
            user = (ITCLIB.Security.User)Session["User"];
            Control control = new Control();
            if (Request.QueryString["ctl"] != null)
            {
                RadAjaxManagerPopup.Dispose();
                RadAjaxManagerPopup.ClientEvents.OnRequestStart = "onRequestStart";
                AjaxSetting _AjaxSetting = new AjaxSetting();
                AjaxUpdatedControl _AjaxUpdatedControl = new AjaxUpdatedControl();                
                switch ((string)Request.QueryString["ctl"].ToLower())
                {
                    case "user_priv_module":
                        control = LoadControl("module/User_Priv_Module.ascx");
                        break;
                    case "nhanguipopup":
                        _AjaxSetting.AjaxControlID = "RadAjaxPanelNHANGUIPOPUP";
                        _AjaxUpdatedControl.ControlID = "RadAjaxPanelNHANGUIPOPUP";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelNHANGUIPOPUP";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        //RadAjaxManagerPopup.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/NHANGUIPOPUP.ascx");
                        break;
                    case "doitacpopup":
                        _AjaxSetting.AjaxControlID = "RadAjaxPanelBAOCAODOITACPOPUP";
                        _AjaxUpdatedControl.ControlID = "RadAjaxPanelBAOCAODOITACPOPUP";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelBAOCAODOITACPOPUP";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        //RadAjaxManagerPopup.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/BAOCAODOITACPOPUP.ascx");
                        break;
                    case "nhanguitracking":
                        _AjaxSetting.AjaxControlID = "RadAjaxPanelNHANGUITRACKING";
                        _AjaxUpdatedControl.ControlID = "RadAjaxPanelNHANGUITRACKING";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelNHANGUITRACKING";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManagerPopup.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/NHANGUITRACKING.ascx");
                        break;
                }
                ContentPlaceHolderPopup.Controls.Add(control);
            }
            else
            {
                control = LoadControl("module/FirstView.ascx");
            }
        }        
        else 
        {
            Session["LastUrl"] = Request.Url.ToString();
            Response.Redirect("Login.aspx", true);
        }
    }
}
