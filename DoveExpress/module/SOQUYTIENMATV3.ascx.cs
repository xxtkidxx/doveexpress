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
/* select a.PK_ID,a.SOCHUNGTU,a.C_NGAY,a.C_TYPE,a.KIHIEUTAIKHOANNAME,a.C_DESC,a.C_SOTIEN,
(Select sum(C_SOTIENFIX) from (SELECT (ROW_NUMBER() OVER(ORDER BY [SOQUYTIENMAT].C_ORDER ASC, [SOQUYTIENMAT].C_NGAY ASC, [SOQUYTIENMAT].PK_ID ASC) + 9999) AS SOCHUNGTU,(CASE WHEN C_TYPE=N'THU' THEN C_SOTIEN WHEN C_TYPE=N'CHI' THEN -C_SOTIEN ELSE (SELECT C_SOTIEN FROM SOQUYTIENMAT WHERE ([SOQUYTIENMAT].[FK_VUNGLAMVIEC] = N'Hà Nội' AND month([SOQUYTIENMAT].[C_NGAY]) = '11' AND year([SOQUYTIENMAT].[C_NGAY]) = '2013' AND [SOQUYTIENMAT].[C_TYPE] = N'Tồn cuối kỳ')) END) AS C_SOTIENFIX FROM [SOQUYTIENMAT] WHERE ([SOQUYTIENMAT].[FK_VUNGLAMVIEC] = N'Hà Nội' AND month([SOQUYTIENMAT].[C_NGAY]) = '12' AND year([SOQUYTIENMAT].[C_NGAY]) = '2013' AND [SOQUYTIENMAT].[C_SOTIEN] > 0) OR ([SOQUYTIENMAT].[C_TYPE] = N'Tồn đầu kỳ')) b where b.SOCHUNGTU <= a.SOCHUNGTU) as C_TON 
from (SELECT (ROW_NUMBER() OVER(ORDER BY [SOQUYTIENMAT].C_ORDER ASC, [SOQUYTIENMAT].C_NGAY ASC, [SOQUYTIENMAT].PK_ID ASC) + 9999) AS SOCHUNGTU,[SOQUYTIENMAT].[PK_ID], [SOQUYTIENMAT].[C_NGAY], [SOQUYTIENMAT].[C_TYPE], [SOQUYTIENMAT].[FK_KIHIEUTAIKHOAN], [SOQUYTIENMAT].[C_DESC], CASE WHEN [SOQUYTIENMAT].C_TYPE = N'Tồn đầu kỳ' THEN (SELECT C_SOTIEN FROM SOQUYTIENMAT WHERE ([SOQUYTIENMAT].[FK_VUNGLAMVIEC] = N'Hà Nội' AND month([SOQUYTIENMAT].[C_NGAY]) = '11' AND year([SOQUYTIENMAT].[C_NGAY]) = '2013' AND [SOQUYTIENMAT].[C_TYPE] = N'Tồn cuối kỳ')) ELSE [SOQUYTIENMAT].C_SOTIEN END as C_SOTIEN,(CASE WHEN C_TYPE=N'THU' THEN C_SOTIEN WHEN C_TYPE=N'CHI' THEN -C_SOTIEN ELSE NULL END) AS C_SOTIENFIX,
[SOQUYTIENMAT].[C_ORDER],DMKIHIEUTAIKHOAN.C_NAME as KIHIEUTAIKHOANNAME FROM [SOQUYTIENMAT] LEFT OUTER JOIN DMKIHIEUTAIKHOAN ON SOQUYTIENMAT.FK_KIHIEUTAIKHOAN=DMKIHIEUTAIKHOAN.C_CODE  WHERE ([SOQUYTIENMAT].[FK_VUNGLAMVIEC] = N'Hà Nội' AND month([SOQUYTIENMAT].[C_NGAY]) = '12' AND year([SOQUYTIENMAT].[C_NGAY]) = '2013' AND [SOQUYTIENMAT].[C_SOTIEN] > 0) OR ([SOQUYTIENMAT].[C_TYPE] = N'Tồn đầu kỳ')) a*/
public partial class module_SOQUYTIENMATV3 : System.Web.UI.UserControl
{
    private decimal TONDAU
    {
        get
        {
            return decimal.Parse(Session["TONDAU"].ToString());
        }
        set
        {
            Session["TONDAU"] = value;
        }
    }
    private decimal TONSAU
    {
        get
        {
            return decimal.Parse(Session["TONSAU"].ToString());
        }
        set
        {
            Session["TONSAU"] = value;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridSOQUYTIENMATV3.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridSOQUYTIENMATV3.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridSOQUYTIENMATV3.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("TAICHINH"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        Session["SQTMC_TYPE"] = "";
        Session["SQTMFK_KIHIEUTAIKHOAN"] = "";
        Session["SQTMC_DESC"] = "";
        Session["SQTMC_SOTIEN"] = "";
    }
    protected void btnShowAll_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadGridSOQUYTIENMATV3.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridSOQUYTIENMATV3.MasterTableView.RenderColumns)
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
        RadGridSOQUYTIENMATV3.MasterTableView.Rebind();
    }
    private void DisplayMessage(string text)
    {
        RadGridSOQUYTIENMATV3.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridSOQUYTIENMATV3_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
        LoadTaiChinh();
        if (cmbDay.SelectedValue != "0" || cmbTaiKhoan.SelectedValue != "0")
        {
            txtTONDAU.Text = "";
            txtTONCUOI.Text = "";
            txtTONTHUCTE.Text = "";
        }
    }
    protected void RadGridSOQUYTIENMATV3_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xóa sổ quỹ tiền mặt. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa sổ quỹ tiền mặt thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted SOQUYTIENMATV3s", e.Item.KeyValues);
        }
    }
    protected void RadGridSOQUYTIENMATV3_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới sổ quỹ tiền mặt. Lý do: " + e.Exception.Message);
        }
        else
        {
            if (Session["SaveAddNew"] == "True")
            {
                e.KeepInInsertMode = true;
            }
            else
            {

            }
            SetMessage("Tạo mới sổ quỹ tiền mặt thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted SOQUYTIENMATV3s", "{PK_ID:\"" + getmaxid("SOQUYTIENMATV3") + "\"}");
        }
    }
    protected void RadGridSOQUYTIENMATV3_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật sổ quỹ tiền mặt. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Cập nhật sổ quỹ tiền mặt thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated SOQUYTIENMATV3s", e.Item.KeyValues);
        }
    }
    bool isExport = false;
    protected void RadGridSOQUYTIENMATV3_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadGrid grid = (RadGrid)sender;
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            RadDatePicker radNgaySOQUYTIENMATV3 = (RadDatePicker)editItem.FindControl("radNgaySOQUYTIENMATV3");
            RadComboBox cmbC_TYPE = (RadComboBox)editItem.FindControl("cmbC_TYPE");
            RadComboBox cmbFK_KIHIEUTAIKHOAN = (RadComboBox)editItem.FindControl("cmbFK_KIHIEUTAIKHOAN");
            if (e.Item is GridEditFormInsertItem || e.Item is GridDataInsertItem)
            {
                // insert item
                radNgaySOQUYTIENMATV3.SelectedDate = System.DateTime.Now;
                cmbC_TYPE.SelectedIndex = 0;
                if (Session["SaveAddNew"] == "True")
                {
                    if (Session["SQTMC_TYPE"].ToString() != "")
                    {
                        cmbC_TYPE.SelectedValue = Session["SQTMC_TYPE"].ToString();
                    }
                    if (Session["SQTMFK_KIHIEUTAIKHOAN"].ToString() != "")
                    {
                        cmbFK_KIHIEUTAIKHOAN.SelectedValue = Session["SQTMFK_KIHIEUTAIKHOAN"].ToString();
                    }
                    RadTextBox txtC_DESC = (RadTextBox)e.Item.FindControl("txtC_DESC");
                    txtC_DESC.Text = Session["SQTMC_DESC"].ToString();
                    RadNumericTextBox txtC_SOTIEN = (RadNumericTextBox)e.Item.FindControl("txtC_SOTIEN");
                    txtC_SOTIEN.Text = (Session["SQTMC_SOTIEN"].ToString() == "") ? "0" : Session["SQTMC_SOTIEN"].ToString();
                }
                else
                {

                }
                Session["SaveAddNew"] = "False";
            }
            else
            {
                // edit item

            }
        }
        if (e.Item is GridDataItem && !isExport)
        {
            Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            RadNumericTextBox txtC_SOTIEN = (RadNumericTextBox)e.Item.FindControl("txtC_SOTIEN");
            RadNumericTextBox txtC_TON = (RadNumericTextBox)e.Item.FindControl("txtC_TON");
            //lblSTT.Text = (e.Item.ItemIndex + 10000).ToString();
            if (e.Item.ItemIndex == 0)
            {
                LoadTonDau(e.Item.Cells[5].Text, e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["PK_ID"].ToString());
                if (e.Item.Cells[5].Text == "Tồn đầu kỳ")
                {
                    txtC_SOTIEN.Text = TONDAU.ToString();
                    txtC_TON.Text = TONDAU.ToString();
                    TONSAU = TONDAU;
                    e.Item.BackColor = System.Drawing.Color.Red;
                    e.Item.ForeColor = System.Drawing.Color.White;
                    lblSTT.Text = "";
                }
                else
                {
                    txtC_TON.Text = TONDAU.ToString();
                    TONSAU = TONDAU;
                }
            }
            else
            {
                if (e.Item.Cells[5].Text == "Thu")
                {
                    TONSAU = decimal.Parse(txtC_SOTIEN.Text) + TONSAU;
                    txtC_TON.Text = TONSAU.ToString();
                }
                else if (e.Item.Cells[5].Text == "Chi")
                {
                    TONSAU = TONSAU - decimal.Parse(txtC_SOTIEN.Text);
                    txtC_TON.Text = TONSAU.ToString();
                }

                else if (e.Item.Cells[5].Text == "Tồn cuối kỳ")
                {
                    txtC_TON.Text = txtC_SOTIEN.Text;
                    e.Item.BackColor = System.Drawing.Color.Red;
                    e.Item.ForeColor = System.Drawing.Color.White;
                    lblSTT.Text = "";
                }
            }
        }
    }
    protected void RadGridSOQUYTIENMATV3_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridSOQUYTIENMATV3.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridSOQUYTIENMATV3.Rebind();
            }
            foreach (GridDataItem item in RadGridSOQUYTIENMATV3.SelectedItems)
            {
                if (!ValidateDeleteGroup(item["pk_id"].Text))
                {
                    SetMessage("Không thể xóa \"" + item["c_name"].Text + "\" do có tham chiếu dữ liệu khác.");
                    RadGridSOQUYTIENMATV3.Rebind();
                }
                else if (item["C_TYPE"].Text == "Tồn đầu kỳ")
                {
                    SetMessage("Không thể xóa bản ghi tồn đầu kỳ");
                    RadGridSOQUYTIENMATV3.Rebind();
                }
            }
        }
        else if (e.CommandName == RadGrid.PerformInsertCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            RadComboBox cmbC_TYPE = (RadComboBox)editItem.FindControl("cmbC_TYPE");
            RadComboBox cmbFK_KIHIEUTAIKHOAN = (RadComboBox)editItem.FindControl("cmbFK_KIHIEUTAIKHOAN");
            Session["SQTMC_TYPE"] = cmbC_TYPE.SelectedValue;
            Session["SQTMFK_KIHIEUTAIKHOAN"] = cmbFK_KIHIEUTAIKHOAN.SelectedValue;
            RadTextBox txtC_DESC = (RadTextBox)e.Item.FindControl("txtC_DESC");
            Session["SQTMC_DESC"] = txtC_DESC.Text;
            RadNumericTextBox txtC_SOTIEN = (RadNumericTextBox)e.Item.FindControl("txtC_SOTIEN");
            Session["SQTMC_SOTIEN"] = txtC_SOTIEN.Text;
            if (cmbC_TYPE.SelectedIndex == 2)
            {
                SOQUYTIENMATV3DataSource.InsertParameters["C_ORDER"].DefaultValue = "2";
            }
            else
            {
                SOQUYTIENMATV3DataSource.InsertParameters["C_ORDER"].DefaultValue = "1";
            }
        }
        else if (e.CommandName == RadGrid.UpdateCommandName)
        {

        }
        else if (e.CommandName == RadGrid.ExportToCsvCommandName)
        {
            isExport = true;
        }
        else if (e.CommandName == RadGrid.ExportToExcelCommandName)
        {
            isExport = true;
        }
        else if (e.CommandName == RadGrid.ExportToPdfCommandName)
        {
            isExport = true;
        }
        else if (e.CommandName == RadGrid.ExportToWordCommandName)
        {
            isExport = true;
        }
    }
    protected string getmaxid(string table)
    {
        int rowcount = 0;
        string SelectSQL = "SELECT MAX(" + table + ".PK_ID) as MAXS FROM " + table;
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        rowcount = oDataTable.Rows.Count;
        if (rowcount != 0)
        {
            return oDataTable.Rows[0]["MAXS"].ToString();
        }
        else
        {
            return "1";
        }
    }
    protected bool ValidateDeleteGroup(string pkID)
    {
        int rowcount = 0;
        //string SelectSQL = "SELECT EOF_JOB.PK_ID FROM EOF_JOB WHERE EOF_JOB.fk_jobstatus = " + pkID;
        //DataTable oDataTable = new DataTable();
        //ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        //oDataTable = SelectQuery.query_data(SelectSQL);
        //rowcount = oDataTable.Rows.Count;
        if (rowcount != 0)
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    protected void cmbDay_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cmbDay.SelectedValue = "0";
            SOQUYTIENMATV3DataSource.SelectParameters["DAY"].DefaultValue = "0";
        }
    }
    protected void cmbMonth_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cmbMonth.SelectedValue = System.DateTime.Now.Month.ToString();
            SOQUYTIENMATV3DataSource.SelectParameters["MONTH"].DefaultValue = System.DateTime.Now.Month.ToString();
        }
    }
    protected void cmbTaiKhoan_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cmbTaiKhoan.SelectedValue = "0";
            SOQUYTIENMATV3DataSource.SelectParameters["FK_KIHIEUTAIKHOAN"].DefaultValue = "0";
        }
    }
    protected void cmbYear_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string SelectSQL = "SELECT MIN(year(C_NGAY)) as MINNAM FROM SOQUYTIENMAT";
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
            SOQUYTIENMATV3DataSource.SelectParameters["YEAR"].DefaultValue = System.DateTime.Now.Year.ToString();
        }
    }
    protected void RadGridSOQUYTIENMATV3_ExcelMLExportRowCreated(object sender, Telerik.Web.UI.GridExcelBuilder.GridExportExcelMLRowCreatedArgs e)
    {
        if (e.RowType == GridExportExcelMLRowType.HeaderRow)
        {
            RadGridSOQUYTIENMATV3.Rebind();  //workaround to get the template column's content
            //create new column element and a header cell
            e.Worksheet.Table.Columns.Add(new ColumnElement());
            CellElement cell = new CellElement();
            //correct the autofilter
            e.Worksheet.AutoFilter.Range = String.Format("R{0}C{1}:R{0}C{2}", 1, 1, e.Worksheet.Table.Columns.Count + 1);
            //populate the header cell
            cell.Data.DataItem = (RadGridSOQUYTIENMATV3.MasterTableView.GetItems(GridItemType.Header)[0] as GridHeaderItem)["C_TON"].Text.Trim();
            e.Row.Cells.Add(cell);
        }

        if (e.RowType == GridExportExcelMLRowType.DataRow)
        {
            //create cell for the current row
            CellElement cell = new CellElement();
            int currentRow = e.Worksheet.Table.Rows.IndexOf(e.Row) - 1;
            //populate the data cell
            RadNumericTextBox txtC_TON = (RadNumericTextBox)RadGridSOQUYTIENMATV3.MasterTableView.Items[currentRow].FindControl("txtC_TON");
            RadNumericTextBox txtC_SOTIEN = (RadNumericTextBox)RadGridSOQUYTIENMATV3.MasterTableView.Items[currentRow].FindControl("txtC_SOTIEN");
            if (RadGridSOQUYTIENMATV3.MasterTableView.Items[currentRow].Cells[5].Text == "Thu")
            {
                TONSAU = decimal.Parse(txtC_SOTIEN.Text) + TONSAU;
                cell.Data.DataItem = TONSAU.ToString();
            }
            else if (RadGridSOQUYTIENMATV3.MasterTableView.Items[currentRow].Cells[5].Text == "Chi")
            {
                TONSAU = TONSAU - decimal.Parse(txtC_SOTIEN.Text);
                cell.Data.DataItem = TONSAU.ToString();
            }
            else if (RadGridSOQUYTIENMATV3.MasterTableView.Items[currentRow].Cells[5].Text == "Tồn đầu kỳ")
            {
                cell.Data.DataItem = TONDAU.ToString();
                TONSAU = TONDAU;
            }
            else if (RadGridSOQUYTIENMATV3.MasterTableView.Items[currentRow].Cells[5].Text == "Tồn cuối kỳ")
            {
                cell.Data.DataItem = txtC_SOTIEN.Text;
            }
            e.Row.Cells.Add(cell);
        }
    }
    protected void LoadTaiChinh()
    {
        string THANGTRUOC = "";
        string NAMTRUOC = "";
        if (cmbMonth.SelectedValue == "1")
        {
            THANGTRUOC = "12";
            NAMTRUOC = (int.Parse(cmbYear.SelectedValue) - 1).ToString();
        }
        else
        {
            THANGTRUOC = (int.Parse(cmbMonth.SelectedValue) - 1).ToString();
            NAMTRUOC = int.Parse(cmbYear.SelectedValue).ToString();
        }
        string SelectSQL = "SELECT [SOQUYTIENMAT].[C_SOTIEN] FROM [SOQUYTIENMAT] WHERE [SOQUYTIENMAT].[FK_VUNGLAMVIEC] = N'" + Session["VUNGLAMVIEC"] + "' AND month([SOQUYTIENMAT].[C_NGAY]) =" + THANGTRUOC + " AND year([SOQUYTIENMAT].[C_NGAY]) =" + NAMTRUOC + " AND [SOQUYTIENMAT].[C_TYPE] = N'Tồn cuối kỳ'";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            if (oDataTable.Rows[0]["C_SOTIEN"] == DBNull.Value)
            {
                txtTONDAU.Text = "0";
            }
            else
            {
                txtTONDAU.Text = oDataTable.Rows[0]["C_SOTIEN"].ToString();
            }
        }
        else
        {
            txtTONDAU.Text = "0";
        }
        SelectSQL = "SELECT SUM ([SOQUYTIENMAT].[C_SOTIEN]) as TONGTHU FROM [SOQUYTIENMAT] WHERE [SOQUYTIENMAT].[FK_VUNGLAMVIEC] = N'" + Session["VUNGLAMVIEC"] + "' AND (day([SOQUYTIENMAT].[C_NGAY]) = " + cmbDay.SelectedValue + " OR " + cmbDay.SelectedValue + " = 0) AND month([SOQUYTIENMAT].[C_NGAY]) =" + cmbMonth.SelectedValue + " AND year([SOQUYTIENMAT].[C_NGAY]) =" + cmbYear.SelectedValue + " AND [SOQUYTIENMAT].[C_TYPE] = N'Thu' AND ([SOQUYTIENMAT].[FK_KIHIEUTAIKHOAN] = " + cmbTaiKhoan.SelectedValue + " OR " + cmbTaiKhoan.SelectedValue + " = 0)";
        oDataTable = new DataTable();
        SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            if (oDataTable.Rows[0]["TONGTHU"] == DBNull.Value)
            {
                txtTONGTHU.Text = "0";
            }
            else
            {
                txtTONGTHU.Text = oDataTable.Rows[0]["TONGTHU"].ToString();
            }
        }
        else
        {
            txtTONGTHU.Text = "0";
        }
        SelectSQL = "SELECT SUM ([SOQUYTIENMAT].[C_SOTIEN]) as TONGCHI FROM [SOQUYTIENMAT] WHERE [SOQUYTIENMAT].[FK_VUNGLAMVIEC] = N'" + Session["VUNGLAMVIEC"] + "' AND (day([SOQUYTIENMAT].[C_NGAY]) = " + cmbDay.SelectedValue + " OR " + cmbDay.SelectedValue + " = 0) AND month([SOQUYTIENMAT].[C_NGAY]) =" + cmbMonth.SelectedValue + " AND year([SOQUYTIENMAT].[C_NGAY]) =" + cmbYear.SelectedValue + " AND [SOQUYTIENMAT].[C_TYPE] = N'Chi' AND ([SOQUYTIENMAT].[FK_KIHIEUTAIKHOAN] = " + cmbTaiKhoan.SelectedValue + " OR " + cmbTaiKhoan.SelectedValue + " = 0)";
        oDataTable = new DataTable();
        SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            if (oDataTable.Rows[0]["TONGCHI"] == DBNull.Value)
            {
                txtTONGCHI.Text = "0";
            }
            else
            {
                txtTONGCHI.Text = oDataTable.Rows[0]["TONGCHI"].ToString();
            }
        }
        else
        {
            txtTONGCHI.Text = "0";
        }
        txtTONCUOI.Text = (Decimal.Parse(txtTONDAU.Text) + Decimal.Parse(txtTONGTHU.Text) - Decimal.Parse(txtTONGCHI.Text)).ToString();
        SelectSQL = "SELECT [SOQUYTIENMAT].[C_SOTIEN] FROM [SOQUYTIENMAT] WHERE [SOQUYTIENMAT].[FK_VUNGLAMVIEC] = N'" + Session["VUNGLAMVIEC"] + "' AND month([SOQUYTIENMAT].[C_NGAY]) =" + cmbMonth.SelectedValue + " AND year([SOQUYTIENMAT].[C_NGAY]) =" + cmbYear.SelectedValue + " AND [SOQUYTIENMAT].[C_TYPE] = N'Tồn cuối kỳ'";
        oDataTable = new DataTable();
        SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            if (oDataTable.Rows[0]["C_SOTIEN"] == DBNull.Value)
            {
                txtTONTHUCTE.Text = "0";
            }
            else
            {
                txtTONTHUCTE.Text = oDataTable.Rows[0]["C_SOTIEN"].ToString();
            }
        }
        else
        {
            txtTONTHUCTE.Text = txtTONCUOI.Text;
        }
    }
    protected void LoadTonDau(string CellValue,string PK_ID)
    {
        TONDAU = 0;
        TONSAU = 0;
        string THANGTRUOC = "";
        string NAMTRUOC = "";
        if (cmbMonth.SelectedValue == "1")
        {
            THANGTRUOC = "12";
            NAMTRUOC = (int.Parse(cmbYear.SelectedValue) - 1).ToString();
        }
        else
        {
            THANGTRUOC = (int.Parse(cmbMonth.SelectedValue) - 1).ToString();
            NAMTRUOC = int.Parse(cmbYear.SelectedValue).ToString();
        }
        if (CellValue == "Tồn đầu kỳ")
        {
            string SelectSQL = "SELECT [SOQUYTIENMAT].[PK_ID], [SOQUYTIENMAT].[C_NGAY], [SOQUYTIENMAT].[C_TYPE], [SOQUYTIENMAT].[C_DESC], [SOQUYTIENMAT].[C_SOTIEN] FROM [SOQUYTIENMAT] WHERE [SOQUYTIENMAT].[FK_VUNGLAMVIEC] = N'" + Session["VUNGLAMVIEC"] + "' AND month([SOQUYTIENMAT].[C_NGAY]) =" + THANGTRUOC + " AND year([SOQUYTIENMAT].[C_NGAY]) =" + NAMTRUOC + " AND [SOQUYTIENMAT].[C_TYPE] = N'Tồn cuối kỳ'";
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                if (oDataTable.Rows[0]["C_SOTIEN"] == DBNull.Value)
                {
                    TONDAU = 0;
                }
                else
                {
                    TONDAU = decimal.Parse(oDataTable.Rows[0]["C_SOTIEN"].ToString());
                }
            }
            else
            {
                TONDAU = 0;
            }
        }
        else
        {
            string SelectSQLROWNUMBER = "SELECT SOCHUNGTU FROM (SELECT (ROW_NUMBER() OVER(ORDER BY [SOQUYTIENMAT].C_ORDER ASC, [SOQUYTIENMAT].C_NGAY ASC, [SOQUYTIENMAT].PK_ID ASC) + 9999) AS SOCHUNGTU, [SOQUYTIENMAT].PK_ID FROM [SOQUYTIENMAT] WHERE ([SOQUYTIENMAT].[FK_VUNGLAMVIEC] = N'" + Session["VUNGLAMVIEC"] + "' AND (day([SOQUYTIENMAT].[C_NGAY]) = " + cmbDay.SelectedValue + " OR " + cmbDay.SelectedValue + " = 0) AND month([SOQUYTIENMAT].[C_NGAY]) = " + cmbMonth.SelectedValue + " AND year([SOQUYTIENMAT].[C_NGAY]) = " + cmbYear.SelectedValue + " AND [SOQUYTIENMAT].[C_SOTIEN] > 0 AND ([SOQUYTIENMAT].[FK_KIHIEUTAIKHOAN] = " + cmbTaiKhoan.SelectedValue + " OR " + cmbTaiKhoan.SelectedValue + " = 0)) OR ([SOQUYTIENMAT].[C_TYPE] = N'Tồn đầu kỳ')) a WHERE a.PK_ID = " + PK_ID;           
            DataTable oDataTableROWNUMBER = new DataTable();
            ITCLIB.Admin.SQL SelectQueryROWNUMBER = new ITCLIB.Admin.SQL();
            oDataTableROWNUMBER = SelectQueryROWNUMBER.query_data(SelectSQLROWNUMBER);
            if (oDataTableROWNUMBER.Rows.Count != 0)
            {
                string ROWNUMBER = oDataTableROWNUMBER.Rows[0]["SOCHUNGTU"].ToString();
                string SelectSQL = "SELECT sum(C_SOTIENFIX) as TONDAU FROM (SELECT (ROW_NUMBER() OVER(ORDER BY [SOQUYTIENMAT].C_ORDER ASC, [SOQUYTIENMAT].C_NGAY ASC, [SOQUYTIENMAT].PK_ID ASC) + 9999) AS SOCHUNGTU, (CASE WHEN C_TYPE=N'THU' THEN C_SOTIEN WHEN C_TYPE=N'CHI' THEN -C_SOTIEN ELSE (SELECT C_SOTIEN FROM SOQUYTIENMAT WHERE ([SOQUYTIENMAT].[FK_VUNGLAMVIEC] = N'" + Session["VUNGLAMVIEC"] + "' AND month([SOQUYTIENMAT].[C_NGAY]) = " + THANGTRUOC + " AND year([SOQUYTIENMAT].[C_NGAY]) = " + NAMTRUOC + " AND [SOQUYTIENMAT].[C_TYPE] = N'Tồn cuối kỳ')) END) AS C_SOTIENFIX FROM [SOQUYTIENMAT] WHERE ([SOQUYTIENMAT].[FK_VUNGLAMVIEC] = N'" + Session["VUNGLAMVIEC"] + "' AND (day([SOQUYTIENMAT].[C_NGAY]) = " + cmbDay.SelectedValue + " OR " + cmbDay.SelectedValue + " = 0) AND month([SOQUYTIENMAT].[C_NGAY]) = " + cmbMonth.SelectedValue + " AND year([SOQUYTIENMAT].[C_NGAY]) = " + cmbYear.SelectedValue + " AND [SOQUYTIENMAT].[C_SOTIEN] > 0 AND ([SOQUYTIENMAT].[FK_KIHIEUTAIKHOAN] = " + cmbTaiKhoan.SelectedValue + " OR " + cmbTaiKhoan.SelectedValue + " = 0)) OR ([SOQUYTIENMAT].[C_TYPE] = N'Tồn đầu kỳ')) a WHERE a.SOCHUNGTU < = " + ROWNUMBER;
                Session["t"] = SelectSQL;
                DataTable oDataTable = new DataTable();
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                oDataTable = SelectQuery.query_data(SelectSQL);
                if (oDataTable.Rows.Count != 0)
                {
                    TONDAU = decimal.Parse(oDataTable.Rows[0]["TONDAU"].ToString());
                }
            }
        }
    }
    protected void RadGridSOQUYTIENMATV3_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridPagerItem)
        {
            RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
            RadComboBoxItem item = new RadComboBoxItem("100", "100");
            item.Attributes.Add("ownerTableViewId", RadGridSOQUYTIENMATV3.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("100") == null) cb.Items.Add(item);
            item = new RadComboBoxItem("200", "200");
            item.Attributes.Add("ownerTableViewId", RadGridSOQUYTIENMATV3.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("200") == null) cb.Items.Add(item);
            item = new RadComboBoxItem("500", "500");
            item.Attributes.Add("ownerTableViewId", RadGridSOQUYTIENMATV3.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("500") == null) cb.Items.Add(item);
            item = new RadComboBoxItem("1000", "1000");
            item.Attributes.Add("ownerTableViewId", RadGridSOQUYTIENMATV3.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("1000") == null) cb.Items.Add(item);
            item = new RadComboBoxItem("2000", "2000");
            item.Attributes.Add("ownerTableViewId", RadGridSOQUYTIENMATV3.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("2000") == null) cb.Items.Add(item);
            item = new RadComboBoxItem("5000", "5000");
            item.Attributes.Add("ownerTableViewId", RadGridSOQUYTIENMATV3.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("5000") == null) cb.Items.Add(item);
            cb.Items.Sort(new PagerRadComboBoxItemComparer());
            cb.Items.FindItemByValue(RadGridSOQUYTIENMATV3.PageSize.ToString()).Selected = true;
        }
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            //LinkButton btnSave = (LinkButton)e.Item.FindControl("btnSave");
            LinkButton btnSaveAddNew = (LinkButton)e.Item.FindControl("btnSaveAddNew");
            btnSaveAddNew.Click += new EventHandler(btnSaveAddNew_Click);
            //btnSave.Click += new EventHandler(btnSave_Click);
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
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Session["SaveAddNew"] = "False";
    }
    protected void btnSaveAddNew_Click(object sender, EventArgs e)
    {
        Session["SaveAddNew"] = "True";
    }
    protected void CheckTonCuoiKy(object source, ServerValidateEventArgs args)
    {
        if (args.Value == "Tồn cuối kỳ")
        {
            string SelectSQL = "SELECT [SOQUYTIENMAT].[C_SOTIEN] FROM [SOQUYTIENMAT] WHERE [SOQUYTIENMAT].[FK_VUNGLAMVIEC] = N'" + Session["VUNGLAMVIEC"] + "' AND month([SOQUYTIENMAT].[C_NGAY]) =" + cmbMonth.SelectedValue + " AND year([SOQUYTIENMAT].[C_NGAY]) =" + cmbYear.SelectedValue + " AND [SOQUYTIENMAT].[C_TYPE] = N'Tồn cuối kỳ'";
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