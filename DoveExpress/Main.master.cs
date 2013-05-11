using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Main : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (ITCLIB.Security.Security.IsLogedIn())
        {
            ITCLIB.Security.User user = new ITCLIB.Security.User();
            user = (ITCLIB.Security.User)Session["User"];
            lblFullName.Text = "Người dùng: <b>" + user.UserName + "</b>";
            Control control = new Control();
            if (Request.QueryString["ctl"] != null)
            {
                RadAjaxManager.Dispose();
                RadAjaxManager.ClientEvents.OnRequestStart = "onRequestStart";
                AjaxSetting _AjaxSetting = new AjaxSetting();
                AjaxUpdatedControl _AjaxUpdatedControl = new AjaxUpdatedControl();                
                switch ((string)Request.QueryString["ctl"].ToLower())
                {
                    case "groupuser":
                        _AjaxSetting.AjaxControlID = "RadGridGroupUser";
                        _AjaxUpdatedControl.ControlID = "RadGridGroupUser";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelGroupUser";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManager.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/GroupUsers.ascx");
                        break;
                    case "user":
                        _AjaxSetting.AjaxControlID = "RadGridUserAdmin";
                        _AjaxUpdatedControl.ControlID = "RadGridUserAdmin";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelUserAdmin";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManager.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/UserAdmins.ascx");
                        break;
                    case "user_pass":
                        control = LoadControl("module/User_Pass.ascx");
                        break;
                    case "actionlog":
                        control = LoadControl("module/ActionLog.ascx");
                        break;
                    case "errorlog":
                        control = LoadControl("module/ErrorLog.ascx");
                        break;
                    case "user_log":
                        control = LoadControl("module/User_Log.ascx");
                        break;
                    case "user_info":
                        control = LoadControl("module/User_Info.ascx");
                        break;
                    case "logout":
                            Session.Clear();
                            Response.Redirect("Login.aspx", true);
                        break;
                    case "khuvuc":
                        control = LoadControl("module/KHUVUC.ascx");
                        break;
                    case "quocgia":
                        _AjaxSetting.AjaxControlID = "RadSplitterQUOCGIA";
                        _AjaxUpdatedControl.ControlID = "RadSplitterQUOCGIA";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelQUOCGIA";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManager.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/QUOCGIA.ascx");
                        break;
                    case "tinhthanh":
                        _AjaxSetting.AjaxControlID = "RadSplitterTINHTHANH";
                        _AjaxUpdatedControl.ControlID = "RadSplitterTINHTHANH";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelTINHTHANH";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManager.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/TINHTHANH.ascx");
                        break;
                    case "quanhuyen":
                        _AjaxSetting.AjaxControlID = "RadSplitterQUANHUYEN";
                        _AjaxUpdatedControl.ControlID = "RadSplitterQUANHUYEN";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelQUANHUYEN";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManager.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/QUANHUYEN.ascx");
                        break;
                    case "mabangcuoc":
                        _AjaxSetting.AjaxControlID = "RadGridMABANGCUOC";
                        _AjaxUpdatedControl.ControlID = "RadGridMABANGCUOC";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelMABANGCUOC";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManager.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/MABANGCUOC.ascx");
                        break;
                    case "masanpham":
                        _AjaxSetting.AjaxControlID = "RadGridMASANPHAM";
                        _AjaxUpdatedControl.ControlID = "RadGridMASANPHAM";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelMASANPHAM";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManager.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/MASANPHAM.ascx");
                        break;
                    case "mavung":
                        _AjaxSetting.AjaxControlID = "RadGridMAVUNG";
                        _AjaxUpdatedControl.ControlID = "RadGridMAVUNG";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelMAVUNG";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManager.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/MAVUNG.ascx");
                        break;
                    case "chitietcuoc":
                        _AjaxSetting.AjaxControlID = "RadGridCHITIETCUOC";
                        _AjaxUpdatedControl.ControlID = "RadGridCHITIETCUOC";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelCHITIETCUOC";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManager.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/CHITIETCUOC.ascx");
                        break;
                     case "tygia":                    
                        control = LoadControl("module/TYGIA.ascx");
                        break;
                     case "phongban":
                        _AjaxSetting.AjaxControlID = "RadSplitterDEPT";
                        _AjaxUpdatedControl.ControlID = "RadSplitterDEPT";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelDept";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManager.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/Depts.ascx");
                        break;
                     case "nhomkhachhang":
                        _AjaxSetting.AjaxControlID = "RadGridNHOMKHACHHANG";
                        _AjaxUpdatedControl.ControlID = "RadGridNHOMKHACHHANG";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelNHOMKHACHHANG";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManager.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/NHOMKHACHHANG.ascx");
                        break;
                     case "khachhang":
                        _AjaxSetting.AjaxControlID = "RadGridKHACHHANG";
                        _AjaxUpdatedControl.ControlID = "RadGridKHACHHANG";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelKHACHHANG";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManager.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/KHACHHANG.ascx");
                        break;




                    
                }             
            }
            else
            {
                
            }
            ContentPlaceHolder.Controls.Add(control);
        }
        else
        {
            Session["LastUrl"] = Request.Url.ToString();
            Response.Redirect("Login.aspx", true);
        }
    }
}
