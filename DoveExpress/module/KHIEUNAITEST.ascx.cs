using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class module_KHIEUNAITEST : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        RadScriptManager.GetCurrent(Page).Services.Add(new ServiceReference(ResolveUrl("~/MyWebService.asmx")));
        RadGridKHIEUNAI.SelectedIndexes.Add(0);
    }

    protected void btnShowAll_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadGridKHIEUNAI.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridKHIEUNAI.MasterTableView.RenderColumns)
        {
            if (column is GridBoundColumn)
            {
                GridBoundColumn boundColumn = column as GridBoundColumn;
                boundColumn.CurrentFilterValue = string.Empty;
            }
            if (column is GridTemplateColumn)
            {
                GridTemplateColumn boundColumn = column as GridTemplateColumn;
                boundColumn.CurrentFilterValue = string.Empty;
            }
        }
        RadGridKHIEUNAI.MasterTableView.Rebind();
    }
    protected void RadGridKHIEUNAI_DataBound(object sender, EventArgs e)
    {
        GridDataItem selectedItem = RadGridKHIEUNAI.Items[0];

        txtID.Value = selectedItem["PK_ID"].Text;
        txtC_CODE.Text = selectedItem["C_CODE"].Text;
        /*    LastName.Text = selectedItem["LastName"].Text;
         Title.Text = selectedItem["Title"].Text;
 
         TitleOfCourtesy.FindItemByText(selectedItem["TitleOfCourtesy"].Text).Selected = true;
         BirthDate.SelectedDate = DateTime.Parse(selectedItem["BirthDate"].Text);
 
         Notes.Content = selectedItem["Notes"].Text;*/
    }

    protected void RadGridKHIEUNAI_ColumnCreated(object sender, GridColumnCreatedEventArgs e)
    {
        /*if (e.Column.IsBoundToFieldName("BirthDate"))
        {
            ((GridBoundColumn)e.Column).DataFormatString = "{0:MM/dd/yyyy}";
        }
        else if (e.Column.IsBoundToFieldName("Notes"))
        {
            e.Column.Visible = false;
        }*/
    }
    protected void CheckMaKN(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        SelectSQL = "Select KHIEUNAI.C_CODE FROM KHIEUNAI WHERE KHIEUNAI.C_BILL = '" + args.Value + "' AND KHIEUNAI.PK_ID <> " + Session["txtID"].ToString();
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            args.IsValid = false;
        }
        else
        {
            args.IsValid = true;
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        TextBox1.Text = Session["t"].ToString();
        //ITCLIB.Admin.JavaScript.ShowMessage(Session["t"].ToString(), this);
    }
}