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
        if (!ITCLIB.Security.Security.CanViewModule("BAOCAO"))
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
        if (e.CommandName == "ConfirmPayment")
        {
            if (RadGridBAOCAOKHACHHANG.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
            }
            else
            {
                string UpdateSQL = "";
                foreach (GridDataItem item in RadGridBAOCAOKHACHHANG.SelectedItems)
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
            RadGridBAOCAOKHACHHANG.Rebind();
        }
        else if (e.CommandName == "ConfirmUnPayment")
        {
            if (RadGridBAOCAOKHACHHANG.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
            }
            else
            {
                string UpdateSQL = "";
                foreach (GridDataItem item in RadGridBAOCAOKHACHHANG.SelectedItems)
                {
                    UpdateSQL += "UPDATE [NHANGUI] SET [C_DATHU] = " + "0" + ",[C_HINHTHUCTT] = N'Thanh toán sau' WHERE [C_BILL] = '" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "';UPDATE [SOQUYTIENMAT] SET [C_SOTIEN] = " + "0" + " WHERE [C_BILL] = '" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "';";
                }
                ITCLIB.Admin.SQL UpdateQuery = new ITCLIB.Admin.SQL();
                UpdateQuery.ExecuteNonQuery(UpdateSQL);
            }
            SetMessage("Cập nhật tình trạng thanh toán thành công");
            RadGridBAOCAOKHACHHANG.Rebind();
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
            SelectSQL = "SELECT * FROM DMKHACHHANG WHERE FK_NHOMKHACHHANG = " + ID + " OR FK_NHOMKHACHHANGQT = " + ID + " order by C_CODE";
        }
        else
        {
            SelectSQL = "SELECT * FROM DMKHACHHANG order by C_CODE";
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
    protected void cmbMonth_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cmbMonth.SelectedValue = System.DateTime.Now.Month.ToString();
            BAOCAOKHACHHANGDataSource.SelectParameters["MONTH"].DefaultValue = System.DateTime.Now.Month.ToString();
        }
    }
    protected void cmbYear_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string SelectSQL = "SELECT MIN(year(C_NGAY)) as MINNAM FROM NHANGUI";
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
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
                int intYear = DateTime.Now.Year;
                for (int i = int.Parse(oDataTable.Rows[0]["MINNAM"].ToString()); i <= intYear + 1; i++)
                {
                    RadComboBoxItem Item = new RadComboBoxItem(i.ToString(), i.ToString());
                    cmbYear.Items.Add(Item);
                }
            }
            cmbYear.SelectedValue = System.DateTime.Now.Year.ToString();
            BAOCAOKHACHHANGDataSource.SelectParameters["YEAR"].DefaultValue = System.DateTime.Now.Year.ToString();
        }
    }
    protected void RadGridBAOCAOKHACHHANG_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridPagerItem)
        {
            RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
            RadComboBoxItem item = new RadComboBoxItem("100", "100");
            item.Attributes.Add("ownerTableViewId", RadGridBAOCAOKHACHHANG.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("100") == null) cb.Items.Add(item);
            item = new RadComboBoxItem("200", "200");
            item.Attributes.Add("ownerTableViewId", RadGridBAOCAOKHACHHANG.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("200") == null) cb.Items.Add(item);
            item = new RadComboBoxItem("500", "500");
            item.Attributes.Add("ownerTableViewId", RadGridBAOCAOKHACHHANG.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("500") == null) cb.Items.Add(item);
            cb.Items.Sort(new PagerRadComboBoxItemComparer());
            cb.Items.FindItemByValue(RadGridBAOCAOKHACHHANG.PageSize.ToString()).Selected = true;
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