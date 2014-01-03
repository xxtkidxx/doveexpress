using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class tinhcuocquocte : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Control control = new Control();
        if (Request.QueryString["ctl"] != null)
        {
            switch ((string)Request.QueryString["ctl"].ToLower())
            {
                case "pricecheckqt":
                    control = LoadControl("PriceCheckQT.ascx");
                    break;                
            }
        }
        else
        {

        }
        ContentPlaceHolderCheck.Controls.Add(control);
    }
}
