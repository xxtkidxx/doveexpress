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
        /*Menu.FindItemByValue("Group_Users").Visible = ITCLIB.Security.Security.IsSysAdmin();
        Menu.FindItemByValue("UserCompanys").Visible = ITCLIB.Security.Security.CanViewModule("UserCompanys");
        Menu.FindItemByValue("UserAdmins").Visible = ITCLIB.Security.Security.CanViewModule("UserAdmins");
        Menu.FindItemByValue("User_Log").Visible = ITCLIB.Security.Security.CanViewModule("User_Log");
        Menu.FindItemByValue("ActionLog").Visible = ITCLIB.Security.Security.CanViewModule("ActionLog");
        Menu.FindItemByValue("ErrorLog").Visible = ITCLIB.Security.Security.CanViewModule("ErrorLog");

        Menu.FindItemByValue("User_Pass").Visible = ITCLIB.Security.Security.CanViewModule("User_Pass");
        Menu.FindItemByValue("User_Info").Visible = ITCLIB.Security.Security.CanViewModule("User_Info");

        Menu.FindItemByValue("JobTitles").Visible = ITCLIB.Security.Security.CanViewModule("JobTitles");
        Menu.FindItemByValue("DEPTs").Visible = ITCLIB.Security.Security.CanViewModule("Depts");

        Menu.FindItemByValue("List").Visible = Menu.FindItemByValue("JobTitles").Visible || Menu.FindItemByValue("Vitriduans").Visible || Menu.FindItemByValue("Trangthaiduans").Visible || Menu.FindItemByValue("Trinhdos").Visible || Menu.FindItemByValue("Nganhnghe").Visible;
        Menu.FindItemByValue("System").Visible = Menu.FindItemByValue("Group_Users").Visible || Menu.FindItemByValue("UserAdmins").Visible || Menu.FindItemByValue("UserCompanys").Visible || Menu.FindItemByValue("User_Log").Visible || Menu.FindItemByValue("ActionLog").Visible || Menu.FindItemByValue("ErrorLog").Visible;
        Menu.FindItemByValue("User").Visible = Menu.FindItemByValue("User_Pass").Visible || Menu.FindItemByValue("User_Info").Visible;*/      
    }
}