using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;
using Telerik.Web.UI;

public partial class Admin_ActionLog : System.Web.UI.UserControl
{
    public string Error = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!ITCLIB.Security.Security.IsSysAdmin())
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        RadFileExplorerActionLog.Configuration.SearchPatterns = new string[] { "*.txt" };
        //RadFileExplorerActionLog.Configuration.ContentProviderTypeName = ;
        RadFileExplorerActionLog.Configuration.ViewPaths = new string[] { "~/Log" + "/ActionLog/" };
        //RadFileExplorerActionLog.Configuration.UploadPaths = new string[] {  };
        //RadFileExplorerActionLog.Configuration.DeletePaths = new string[] {  };
        RadFileExplorerActionLog.WindowManager.Behavior = WindowBehaviors.Maximize | WindowBehaviors.Minimize | WindowBehaviors.Close | WindowBehaviors.Move | WindowBehaviors.Resize;
        Session["LastUrl"] = Request.Url.ToString();
    }
}
