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
                    case "user_priv_report":
                        control = LoadControl("module/User_Priv_Report.ascx");
                        break;
                    case "duanttdcs":
                        _AjaxSetting.AjaxControlID = "RadGridDUANTTDC";
                        _AjaxUpdatedControl.ControlID = "RadGridDUANTTDC";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelDUANTTDC";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManagerPopup.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/DUANTTDCs.ascx");
                        break;
                    case "thvdts":
                        _AjaxSetting.AjaxControlID = "RadGridDUANTHVDT";
                        _AjaxUpdatedControl.ControlID = "RadGridDUANTHVDT";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelDUANTHVDT";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManagerPopup.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/DUANTHVDTs.ascx");
                        break;   
                    case "dtkhs":
                        _AjaxSetting.AjaxControlID = "RadGridDTKH";
                        _AjaxUpdatedControl.ControlID = "RadGridDTKH";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelDTKH";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManagerPopup.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/DTKHs.ascx");
                        break;
                    case "dutoansxkds":
                        control = LoadControl("module/DUTOANSXKD.ascx");
                        break;
                    case "dnlaodong":
                        _AjaxSetting.AjaxControlID = "RadGridDoanhnghiepLaodong";
                        _AjaxUpdatedControl.ControlID = "RadGridDoanhnghiepLaodong";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelDoanhnghiepLaodong";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManagerPopup.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/Doanhnghiep_Laodong.ascx");
                        break;
                    case "dnnhahang":
                        _AjaxSetting.AjaxControlID = "RadGridDoanhnghiepNhahang";
                        _AjaxUpdatedControl.ControlID = "RadGridDoanhnghiepNhahang";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelDoanhnghiepNhahang";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManagerPopup.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/Doanhnghiep_Hoatdongnhahang.ascx");
                        break;
                    case "dndichvu":
                        _AjaxSetting.AjaxControlID = "RadGridDoanhnghiepDichVu";
                        _AjaxUpdatedControl.ControlID = "RadGridDoanhnghiepDichVu";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelDoanhnghiepDichVu";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManagerPopup.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/Doanhnghiep_Dichvu.ascx");
                        break;
                    case "dnthunhap":
                        _AjaxSetting.AjaxControlID = "RadGridDoanhnghiepDichVu";
                        _AjaxUpdatedControl.ControlID = "RadGridDoanhnghiepDichVu";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelDoanhnghiepDichVu";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManagerPopup.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/Doanhnghiep_Laodongthunhap.ascx");
                        break;
                    case "dndaotao":
                        _AjaxSetting.AjaxControlID = "RadGridDoanhnghiepDaotao";
                        _AjaxUpdatedControl.ControlID = "RadGridDoanhnghiepDaotao";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelDoanhnghiepDaotao";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManagerPopup.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/Doanhnghiep_Daotao.ascx");
                        break;
                    case "dngopvon":
                        _AjaxSetting.AjaxControlID = "RadGridDoanhnghiepGopvon";
                        _AjaxUpdatedControl.ControlID = "RadGridDoanhnghiepGopvon";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelDoanhnghiepGopvon";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManagerPopup.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/DoanhNghiep_Gopvon.ascx");
                        break;
                    case "dnhdduan":
                        _AjaxSetting.AjaxControlID = "RadGridDoanhnghiepHDDuan";
                        _AjaxUpdatedControl.ControlID = "RadGridDoanhnghiepHDDuan";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelDoanhnghiepHDDuan";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManagerPopup.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/Doanhnghiep_HDDuan.ascx");
                        break;
                    case "dntainan":
                        _AjaxSetting.AjaxControlID = "RadGridDoanhnghiepTainan";
                        _AjaxUpdatedControl.ControlID = "RadGridDoanhnghiepTainan";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelDoanhnghiepTainan";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManagerPopup.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/Doanhnghiep_Tainan.ascx");
                        break;
                    case "dncntt":
                        _AjaxSetting.AjaxControlID = "RadGridDoanhnghiepCNTT";
                        _AjaxUpdatedControl.ControlID = "RadGridDoanhnghiepCNTT";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelDoanhnghiepCNTT";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManagerPopup.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/Doanhnghiep_CNTT.ascx");
                        break;
                    case "dnbvmt":
                        _AjaxSetting.AjaxControlID = "RadGridDoanhnghiepBVMT";
                        _AjaxUpdatedControl.ControlID = "RadGridDoanhnghiepBVMT";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelDoanhnghiepBVMT";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManagerPopup.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/Doanhnghiep_BVMT.ascx");
                        break;
                    case "dnxaydung":
                        _AjaxSetting.AjaxControlID = "RadGridDoanhnghiepXaydung";
                        _AjaxUpdatedControl.ControlID = "RadGridDoanhnghiepXaydung";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelDoanhnghiepXaydung";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManagerPopup.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/Doanhnghiep_Xaydung.ascx");
                        break;
                    case "dnluutru":
                        _AjaxSetting.AjaxControlID = "RadGridDoanhnghiepLuutru";
                        _AjaxUpdatedControl.ControlID = "RadGridDoanhnghiepLuutru";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelDoanhnghiepLuutru";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManagerPopup.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/Doanhnghiep_Luutru.ascx");
                        break;
                    case "dndautu":
                        _AjaxSetting.AjaxControlID = "RadGridDoanhnghiep_DautuXaydung";
                        _AjaxUpdatedControl.ControlID = "RadGridDoanhnghiep_DautuXaydung";
                        _AjaxUpdatedControl.LoadingPanelID = "RadAjaxLoadingPanelRadGridDoanhnghiep_DautuXaydung";
                        _AjaxSetting.UpdatedControls.Add(_AjaxUpdatedControl);
                        RadAjaxManagerPopup.AjaxSettings.Add(_AjaxSetting);
                        control = LoadControl("module/Doanhnghiep_DautuXaydung.ascx");
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
