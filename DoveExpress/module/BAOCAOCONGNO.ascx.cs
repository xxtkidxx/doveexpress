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
using System.Collections;

public partial class module_BAOCAOCONGNO : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridBAOCAOCONGNO.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridBAOCAOCONGNO.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridBAOCAOCONGNO.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("BAOCAO"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        if (Request["index"] != null && Request["value"] != null)
        {
            string index = Request["index"].ToString();
            string Value = Request["value"].ToString();
        }
        radTuNgay.SelectedDate = DateTime.Now;
        radDenNgay.SelectedDate = DateTime.Now.AddDays(1);
        Session["LastUrl"] = Request.Url.ToString();
    }
    protected void btnShowAll_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadGridBAOCAOCONGNO.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridBAOCAOCONGNO.MasterTableView.RenderColumns)
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
        RadGridBAOCAOCONGNO.MasterTableView.Rebind();
    }
    private void DisplayMessage(string text)
    {
        RadGridBAOCAOCONGNO.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridBAOCAOCONGNO_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridBAOCAOCONGNO_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "ConfirmPayment")
        {
            if (RadGridBAOCAOCONGNO.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
            }
            else
            {
                string UpdateSQL = "";
                foreach (GridDataItem item in RadGridBAOCAOCONGNO.SelectedItems)
                {
                    UpdateSQL += "UPDATE [NHANGUI] SET [C_DATHU] = CASE WHEN (SELECT C_TYPE FROM NHANGUI WHERE C_BILL ='" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "') = 1 THEN C_TIENHANGVAT ELSE C_TIENHANGVAT * C_TYGIA END,[C_HINHTHUCTT] = N'Đã thanh toán' WHERE [C_BILL] = '" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "';IF (NOT EXISTS(SELECT C_BILL FROM SOQUYTIENMAT WHERE C_BILL = '" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "'))" +
                    " BEGIN" +
                    " INSERT INTO [SOQUYTIENMAT] ([C_NGAY], [C_TYPE], [FK_KIHIEUTAIKHOAN], [C_DESC], [C_SOTIEN], [C_BILL],[C_TON],[C_ORDER],[FK_VUNGLAMVIEC]) VALUES ('" + String.Format("{0:yyyy-MM-dd hh:mm:ss tt}", System.DateTime.Now.ToUniversalTime().AddHours(7)) + "',N'Thu',NULL, N'Bill ' + '" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "',CASE WHEN (SELECT C_TYPE FROM NHANGUI WHERE C_BILL ='" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "') = 1 THEN (SELECT C_TIENHANGVAT FROM NHANGUI WHERE C_BILL ='" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "') ELSE (SELECT C_TIENHANGVAT * C_TYGIA FROM NHANGUI WHERE C_BILL ='" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "') END,'" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "',0,1,N'" + Session["VUNGLAMVIEC"].ToString() + "')" +
                    " END" +
                    " ELSE" +
                    " BEGIN" +
                    " UPDATE [SOQUYTIENMAT] SET [C_NGAY] = '" + String.Format("{0:yyyy-MM-dd hh:mm:ss tt}", System.DateTime.Now.ToUniversalTime().AddHours(7)) + "',[C_SOTIEN] = CASE WHEN (SELECT C_TYPE FROM NHANGUI WHERE C_BILL ='" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "') = 1 THEN (SELECT C_TIENHANGVAT FROM NHANGUI WHERE C_BILL ='" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "') ELSE (SELECT C_TIENHANGVAT * C_TYGIA FROM NHANGUI WHERE C_BILL ='" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "') END WHERE [C_BILL] = '" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "'" +
                    " END;"; 
                }
                ITCLIB.Admin.SQL UpdateQuery = new ITCLIB.Admin.SQL();
                UpdateQuery.ExecuteNonQuery(UpdateSQL);
            }           
            SetMessage("Cập nhật tình trạng thanh toán thành công");
            RadGridBAOCAOCONGNO.Rebind();
        }
        else if (e.CommandName == "ConfirmUnPayment")
        {
            if (RadGridBAOCAOCONGNO.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
            }
            else
            {
                string UpdateSQL = "";
                foreach (GridDataItem item in RadGridBAOCAOCONGNO.SelectedItems)
                {
                    UpdateSQL += "UPDATE [NHANGUI] SET [C_DATHU] = " + "0" + ",[C_HINHTHUCTT] = N'Thanh toán sau' WHERE [C_BILL] = '" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "';UPDATE [SOQUYTIENMAT] SET [C_SOTIEN] = " + "0" + " WHERE [C_BILL] = '" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "';";
                }
                ITCLIB.Admin.SQL UpdateQuery = new ITCLIB.Admin.SQL();
                UpdateQuery.ExecuteNonQuery(UpdateSQL);
            }
            SetMessage("Cập nhật tình trạng thanh toán thành công");
            RadGridBAOCAOCONGNO.Rebind();
        }
    }
    protected void RadGridBAOCAOCONGNO_ExcelMLExportRowCreated(object sender, Telerik.Web.UI.GridExcelBuilder.GridExportExcelMLRowCreatedArgs e)
    {
        if (e.Worksheet.Table.Rows.Count == RadGridBAOCAOCONGNO.Items.Count + 1)
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
    protected void RadGridBAOCAOCONGNO_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            //Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            //lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
        }
    }
    protected void RadGridBAOCAOCONGNO_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridPagerItem)
        {
            RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
            RadComboBoxItem item = new RadComboBoxItem("100", "100");
            item.Attributes.Add("ownerTableViewId", RadGridBAOCAOCONGNO.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("100") == null) cb.Items.Add(item);
            item = new RadComboBoxItem("200", "200");
            item.Attributes.Add("ownerTableViewId", RadGridBAOCAOCONGNO.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("200") == null) cb.Items.Add(item);
            item = new RadComboBoxItem("500", "500");
            item.Attributes.Add("ownerTableViewId", RadGridBAOCAOCONGNO.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("500") == null) cb.Items.Add(item);
            cb.Items.Sort(new PagerRadComboBoxItemComparer());
            cb.Items.FindItemByValue(RadGridBAOCAOCONGNO.PageSize.ToString()).Selected = true;
        }
    }
    public class PagerRadComboBoxItemComparer : IComparer<RadComboBoxItem>, IComparer
    {
        public int Compare(RadComboBoxItem x, RadComboBoxItem y)
        {

            int rValue = 0;
            int lValue = 0;

            if (Int32.TryParse(x.Value, out lValue) && Int32.TryParse(y.Value, out rValue))
            {
                return lValue.CompareTo(rValue);
            }
            else
            {
                return x.Value.CompareTo(y.Value);
            }
        }
        public int Compare(object x, object y)
        {
            return Compare((RadComboBoxItem)x, (RadComboBoxItem)y);
        }
    }
}