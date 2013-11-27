using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class PriceCheck : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void cmbQuanHuyen_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        RadComboBox cmbQuanHuyen = (RadComboBox)sender;
        QUANHUYENDataSource.SelectCommand = LoadFilteredManually(e.Text);
        cmbQuanHuyen.DataBind();
    }
    protected string LoadFilteredManually(string ID)
    {
        string SelectSQL = "";
        if (ID != "")
        {
            SelectSQL = "SELECT * FROM DMQUANHUYEN WHERE FK_TINHTHANH = " + ID + "order by LTRIM(C_NAME)";
        }
        else
        {
            SelectSQL = "SELECT * FROM DMQUANHUYEN order by LTRIM(C_NAME)";
        }
        return SelectSQL;
    }  
}