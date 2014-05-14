using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;

public partial class controls_Menu : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Danh mục riêng
        Menu.FindItemByValue("PHANQUYEN").Visible = ITCLIB.Security.Security.IsSysAdmin();
        Menu.FindItemByValue("PHONGBAN").Visible = ITCLIB.Security.Security.CanViewModule("PHONGBAN");
        Menu.FindItemByValue("NHANVIEN").Visible = ITCLIB.Security.Security.CanViewModule("NHANVIEN");
        Menu.FindItemByValue("User_Log").Visible = ITCLIB.Security.Security.IsSysAdmin();
        Menu.FindItemByValue("ActionLog").Visible = ITCLIB.Security.Security.IsSysAdmin();
        Menu.FindItemByValue("ErrorLog").Visible = ITCLIB.Security.Security.IsSysAdmin();
        Menu.FindItemByValue("Config").Visible = ITCLIB.Security.Security.IsSysAdmin();
        Menu.FindItemByValue("DANHMUCRIENG").Visible = ITCLIB.Security.Security.IsSysAdmin() || ITCLIB.Security.Security.CanViewModule("PHONGBAN") || ITCLIB.Security.Security.CanViewModule("NHANVIEN");
        //Danh mục chung
        Menu.FindItemByValue("VUNGDIALY").Visible = ITCLIB.Security.Security.CanViewModule("VUNGDIALY");
        Menu.FindItemByValue("NHOMKHACHHANG").Visible = ITCLIB.Security.Security.CanViewModule("KHACHHANG");
        Menu.FindItemByValue("KHACHHANG").Visible = ITCLIB.Security.Security.CanViewModule("KHACHHANG");
        Menu.FindItemByValue("CUOCTRONGNUOC").Visible = ITCLIB.Security.Security.CanViewModule("BANGCUOC");
        Menu.FindItemByValue("CUOCQUOCTE").Visible = ITCLIB.Security.Security.CanViewModule("BANGCUOC");
        Menu.FindItemByValue("DOITACMENU").Visible = ITCLIB.Security.Security.CanViewModule("DOITAC");
        Menu.FindItemByValue("MASANPHAM").Visible = ITCLIB.Security.Security.IsSysAdmin();
        Menu.FindItemByValue("TRANGTHAIBILL").Visible = ITCLIB.Security.Security.IsSysAdmin();

        Menu.FindItemByValue("NHANGUI").Visible = ITCLIB.Security.Security.CanViewModule("NHANGUI");
        Menu.FindItemByValue("NHANGUIQT").Visible = ITCLIB.Security.Security.CanViewModule("NHANGUI");
        Menu.FindItemByValue("NHANGUIPH").Visible = ITCLIB.Security.Security.CanViewModule("NHANGUIPH");

        Menu.FindItemByValue("NHANGUIMENU").Visible = ITCLIB.Security.Security.CanViewModule("NHANGUI") || ITCLIB.Security.Security.CanViewModule("NHANGUIPH");
        Menu.FindItemByValue("BAOCAO").Visible = ITCLIB.Security.Security.CanViewModule("BAOCAO");
        Menu.FindItemByValue("TAICHINH").Visible = ITCLIB.Security.Security.CanViewModule("TAICHINH");
        Menu.FindItemByValue("KHIEUNAI").Visible = ITCLIB.Security.Security.CanViewModule("KHIEUNAI");
        Menu.FindItemByValue("BAOGIA").Visible = ITCLIB.Security.Security.CanViewModule("BAOGIA"); 
    }
}