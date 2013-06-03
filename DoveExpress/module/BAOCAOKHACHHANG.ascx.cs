using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;
using System.Globalization;
using Telerik.Web.UI.GridExcelBuilder;

public partial class module_BAOCAOKHACHHANG : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridBAOCAOKHACHHANG.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridBAOCAOKHACHHANG.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridBAOCAOKHACHHANG.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("Lists"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        if (Request["index"] != null && Request["value"] != null)
        {
            string index = Request["index"].ToString();
            string Value = Request["value"].ToString();
        }
        Session["LastUrl"] = Request.Url.ToString();
    }
    protected void btnShowAll_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadGridBAOCAOKHACHHANG.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridBAOCAOKHACHHANG.MasterTableView.RenderColumns)
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
        RadGridBAOCAOKHACHHANG.MasterTableView.Rebind();
    }
    private void DisplayMessage(string text)
    {
        RadGridBAOCAOKHACHHANG.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridBAOCAOKHACHHANG_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridBAOCAOKHACHHANG_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "PrintGrid")
        {
        }
    }
    protected void RadGridBAOCAOKHACHHANG_ExcelMLExportRowCreated(object sender, Telerik.Web.UI.GridExcelBuilder.GridExportExcelMLRowCreatedArgs e)
    {
        if (e.Worksheet.Table.Rows.Count == RadGridBAOCAOKHACHHANG.Items.Count + 1)
        {
            RowElement row = new RowElement();
            GridFooterItem footer = (sender as RadGrid).MasterTableView.GetItems(GridItemType.Footer)[0] as GridFooterItem;
            foreach (GridColumn column in (sender as RadGrid).MasterTableView.Columns)
            {
                CellElement cell = new CellElement();
                string cellText = footer[column.UniqueName].Text;
                cell.Data.DataItem = cellText == "&nbsp;" ? "" : cellText;
                row.Cells.Add(cell);
            }
            e.Worksheet.Table.Rows.Add(row);
        }
    }
    protected void RadGridBAOCAOKHACHHANG_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            //Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            //lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
        }
    }
    protected void cmbKhachHang_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        KHACHHANGDataSource.SelectCommand = LoadFilteredManually(e.Text);
        cmbKhachHang.DataBind();
    }
    protected string LoadFilteredManually(string ID)
    {
        string SelectSQL = "";
        if (ID != "")
        {
            SelectSQL = "SELECT * FROM DMKHACHHANG WHERE FK_NHOMKHACHHANG = " + ID + "order by C_NAME";
        }
        else
        {
            SelectSQL = "SELECT * FROM DMKHACHHANG order by C_NAME";
        }
        return SelectSQL;
    }
    protected void cmbNhomKhachHang_PreRender(object sender, EventArgs e)
    {
        /*if (!IsPostBack)
        {
            if (cmbNhomKhachHang.Items.Count != 0)
            {
                cmbNhomKhachHang.SelectedIndex = 0;
                KHACHHANGDataSource.SelectCommand = LoadFilteredManually(cmbNhomKhachHang.SelectedValue);
                cmbKhachHang.DataBind();
                if (cmbKhachHang.Items.Count != 0)
                {
                    cmbKhachHang.SelectedIndex = 0;
                }
            }
        }*/
    }
}