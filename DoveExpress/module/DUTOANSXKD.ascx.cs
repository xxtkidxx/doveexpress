using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class module_DUTOANSXKD : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void cmbYear_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            string SelectSQL = "SELECT MIN(NAM) as MINNAM FROM DUTOANTHUCHI WHERE LOAI = 2";
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                if (oDataTable.Rows[0]["MINNAM"] == DBNull.Value)
                {
                    int intYear = DateTime.Now.Year;
                    RadComboBoxItem Item0 = new RadComboBoxItem(intYear.ToString(), intYear.ToString());
                    intYear += 1;
                    RadComboBoxItem Item1 = new RadComboBoxItem(intYear.ToString(), intYear.ToString());
                    cmbYear.Items.Add(Item0);
                    cmbYear.Items.Add(Item1);
                }
                else
                {
                    int intYear = DateTime.Now.Year;
                    for (int i = int.Parse(oDataTable.Rows[0]["MINNAM"].ToString()); i <= intYear + 1; i++)
                    {
                        RadComboBoxItem Item = new RadComboBoxItem(i.ToString(), i.ToString());
                        cmbYear.Items.Add(Item);
                    }
                }
            }
            else
            {

            }
            cmbYear.SelectedValue = DateTime.Now.Year.ToString();
        }
    }
}