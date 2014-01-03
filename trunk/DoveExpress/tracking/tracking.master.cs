using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class tracking_Check : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Control control = new Control();
        control = LoadControl("BillCheck.ascx");
        ContentPlaceHolderCheck.Controls.Add(control);
    }
}
