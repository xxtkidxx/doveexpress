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
                    case "group_users":
                        _AjaxSetting.AjaxControlID = "RadGridGroupUser";
                        _AjaxUpdatedControl.ControlID = "RadGridGroupUser";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelGroupUser";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManager.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/GroupUsers.ascx");
                        break;
                    case "useradmins":
                        _AjaxSetting.AjaxControlID = "RadGridUserAdmin";
                        _AjaxUpdatedControl.ControlID = "RadGridUserAdmin";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelUserAdmin";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManager.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/UserAdmins.ascx");
                        break;
                    case "usercompanys":
                        _AjaxSetting.AjaxControlID = "RadGridUserCompany";
                        _AjaxUpdatedControl.ControlID = "RadGridUserCompany";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelUserCompany";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManager.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/UserCompanys.ascx");
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
                        {
                            Session.Clear();
                            Response.Redirect("Login.aspx", true);
                        }
                        break;


                    case "khuvuc":
                        control = LoadControl("module/KHUVUC.ascx");
                        break;
                    case "vitriduans":
                        control = LoadControl("module/Vitriduan.ascx");
                        break;
                    case "trangthaiduans":
                        control = LoadControl("module/Trangthaiduan.ascx");
                        break;
                    case "trinhdos":
                        control = LoadControl("module/Trinhdo.ascx");
                        break;
                    case "nguonkinhphis":
                        control = LoadControl("module/Nguonkinhphi.ascx");
                        break;
                    case "nguonvons":
                        control = LoadControl("module/Nguonvon.ascx");
                        break;
                    case "depts":
                        _AjaxSetting.AjaxControlID = "RadSplitterDEPT";
                        _AjaxUpdatedControl.ControlID = "RadSplitterDEPT";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelDept";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManager.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/Depts.ascx");
                        break;
                    case "nganhnghe":
                        _AjaxSetting.AjaxControlID = "RadGridNganhnghes";
                        _AjaxUpdatedControl.ControlID = "RadGridNganhnghes";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelNganhnghe";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManager.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/Nganhnghe.ascx");
                        break;
                    case "donvidutoans":
                        _AjaxSetting.AjaxControlID = "RadGridDONVIDUTOAN";
                        _AjaxUpdatedControl.ControlID = "RadGridDONVIDUTOAN";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelDONVIDUTOAN";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManager.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/DONVIDUTOAN.ascx");
                        break;
                        
                    case "doanhnghieps":
                        _AjaxSetting.AjaxControlID = "RadGridDoanhNghieps";
                        _AjaxUpdatedControl.ControlID = "RadGridDoanhNghieps";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxProxyDoanhNghiep";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManager.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/Doanhnghiep.ascx");
                        break;
                    case "dntypes":
                        _AjaxSetting.AjaxControlID = "RadGridLoaiHinhDN";
                        _AjaxUpdatedControl.ControlID = "RadGridLoaiHinhDN";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxProxyLoaiHinhDN";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManager.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/Doanhnghiep_Loaihinh.ascx");
                        break;
                    case "dnhtdautus":
                        _AjaxSetting.AjaxControlID = "RadGridHinhthucDautu";
                        _AjaxUpdatedControl.ControlID = "RadGridHinhthucDautu";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxProxyHinhthucDautu";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManager.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/Doanhnghiep_Hinhthucdautu.ascx");
                        break;
                    case "duans":
                        _AjaxSetting.AjaxControlID = "RadGridDUAN";
                        _AjaxUpdatedControl.ControlID = "RadGridDUAN";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelDUAN";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManager.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/DUANs.ascx");
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
