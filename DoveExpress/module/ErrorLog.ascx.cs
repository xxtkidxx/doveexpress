using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;
using Telerik.Web.UI;

public partial class Admin_ErrorLog : System.Web.UI.UserControl
{
    public string Error ="";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!ITCLIB.Security.Security.IsSysAdmin())
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        RadFileExplorerErrorLog.Configuration.SearchPatterns = new string[] { "*.txt" };
        //RadFileExplorerErrorLog.Configuration.ContentProviderTypeName = ;
        RadFileExplorerErrorLog.Configuration.ViewPaths = new string[] { "~/Log/ErrorLog" };
        //RadFileExplorerErrorLog.Configuration.UploadPaths = new string[] {  };
        //RadFileExplorerErrorLog.Configuration.DeletePaths = new string[] {  };
        RadFileExplorerErrorLog.WindowManager.Behavior = WindowBehaviors.Maximize | WindowBehaviors.Minimize | WindowBehaviors.Close | WindowBehaviors.Move | WindowBehaviors.Resize;
        Session["LastUrl"] = Request.Url.ToString();
    }   
}
