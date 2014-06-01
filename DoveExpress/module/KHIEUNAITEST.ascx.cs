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
        txtID.Value = selectedItem.GetDataKeyValue("PK_ID").ToString();
        string SelectSQL;
        SelectSQL = "Select KHIEUNAI.* FROM KHIEUNAI WHERE KHIEUNAI.PK_ID =  " + selectedItem.GetDataKeyValue("PK_ID").ToString();
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            txtC_CODE.Text = oDataTable.Rows[0]["C_CODE"].ToString();
            cmbC_TYPE.SelectedValue = oDataTable.Rows[0]["C_TYPE"].ToString();
            radC_DATE.SelectedDate = DateTime.Parse(oDataTable.Rows[0]["C_DATE"].ToString());
            txtC_BILL.Text = oDataTable.Rows[0]["C_BILL"].ToString();
            cmbMaKhachHang.SelectedValue = oDataTable.Rows[0]["FK_KHACHHANG"].ToString();
            txtC_TENKH.Text = oDataTable.Rows[0]["C_TENKH"].ToString();
            txtC_SDT.Text = oDataTable.Rows[0]["C_SDT"].ToString();
            txtC_NOIDUNG.Text = oDataTable.Rows[0]["C_NOIDUNG"].ToString();
            cmbFK_NGUOITAO.SelectedValue = oDataTable.Rows[0]["FK_NGUOITAO"].ToString();
            cmbC_STATUS.SelectedValue = oDataTable.Rows[0]["C_STATUS"].ToString();
        }
        else
        {
            
        }
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