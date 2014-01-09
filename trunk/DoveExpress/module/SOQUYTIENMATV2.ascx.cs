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
/*SELECT a.PK_ID,a.SOCHUNGTU,a.C_NGAY,a.C_TYPE,a.FK_KIHIEUTAIKHOAN,a.KIHIEUTAIKHOANNAME,a.C_DESC,a.C_SOTIEN,
    (CASE WHEN a.C_TYPE = N'Tồn cuối kỳ' THEN a.C_SOTIEN ELSE (Select sum(C_SOTIENFIX) from (SELECT (ROW_NUMBER() OVER(ORDER BY [SOQUYTIENMAT].C_ORDER ASC, [SOQUYTIENMAT].C_NGAY ASC, [SOQUYTIENMAT].PK_ID ASC) + 9999) AS SOCHUNGTU,(CASE WHEN C_TYPE=N'THU' THEN C_SOTIEN WHEN C_TYPE=N'CHI' THEN -C_SOTIEN ELSE (SELECT C_SOTIEN FROM SOQUYTIENMAT WHERE ([SOQUYTIENMAT].[FK_VUNGLAMVIEC] = N'Hà Nội' AND month([SOQUYTIENMAT].[C_NGAY]) = (CASE WHEN @MONTH = '1' THEN '12' ELSE @MONTH - 1 END) AND year([SOQUYTIENMAT].[C_NGAY]) = (CASE WHEN @MONTH = 1 THEN  @YEAR - 1 ELSE @YEAR END) AND [SOQUYTIENMAT].[C_TYPE] = N'Tồn cuối kỳ')) END) AS C_SOTIENFIX FROM [SOQUYTIENMAT] WHERE ([SOQUYTIENMAT].[FK_VUNGLAMVIEC] = N'Hà Nội' AND (day([SOQUYTIENMAT].[C_NGAY]) = @DAY OR @DAY = 0) AND month([SOQUYTIENMAT].[C_NGAY]) = @MONTH AND year([SOQUYTIENMAT].[C_NGAY]) = @YEAR AND [SOQUYTIENMAT].[C_SOTIEN] > 0) OR ([SOQUYTIENMAT].[C_TYPE] = N'Tồn đầu kỳ')) b where b.SOCHUNGTU <= a.SOCHUNGTU) END)
    as C_TON 
    from (SELECT (ROW_NUMBER() OVER(ORDER BY [SOQUYTIENMAT].C_ORDER ASC, [SOQUYTIENMAT].C_NGAY ASC, [SOQUYTIENMAT].PK_ID ASC) + 9999) AS SOCHUNGTU,[SOQUYTIENMAT].[PK_ID], [SOQUYTIENMAT].[C_NGAY], [SOQUYTIENMAT].[C_TYPE], [SOQUYTIENMAT].[FK_KIHIEUTAIKHOAN], [SOQUYTIENMAT].[C_DESC], CASE WHEN [SOQUYTIENMAT].C_TYPE = N'Tồn đầu kỳ' THEN (SELECT C_SOTIEN FROM SOQUYTIENMAT WHERE ([SOQUYTIENMAT].[FK_VUNGLAMVIEC] = N'Hà Nội' AND month([SOQUYTIENMAT].[C_NGAY]) = (CASE WHEN @MONTH = 1 THEN '12' ELSE @MONTH - 1 END) AND year([SOQUYTIENMAT].[C_NGAY]) = (CASE WHEN @MONTH = 1 THEN @YEAR - 1 ELSE @YEAR END) AND [SOQUYTIENMAT].[C_TYPE] = N'Tồn cuối kỳ')) ELSE [SOQUYTIENMAT].C_SOTIEN END as C_SOTIEN,(CASE WHEN C_TYPE=N'THU' THEN C_SOTIEN WHEN C_TYPE=N'CHI' THEN -C_SOTIEN ELSE NULL END) AS C_SOTIENFIX,[SOQUYTIENMAT].[C_ORDER],DMKIHIEUTAIKHOAN.C_NAME as KIHIEUTAIKHOANNAME FROM [SOQUYTIENMAT] LEFT OUTER JOIN DMKIHIEUTAIKHOAN ON SOQUYTIENMAT.FK_KIHIEUTAIKHOAN=DMKIHIEUTAIKHOAN.C_CODE WHERE ([SOQUYTIENMAT].[FK_VUNGLAMVIEC] = N'Hà Nội' AND (day([SOQUYTIENMAT].[C_NGAY]) = @DAY OR @DAY = 0) AND month([SOQUYTIENMAT].[C_NGAY]) = @MONTH AND year([SOQUYTIENMAT].[C_NGAY]) = @YEAR AND [SOQUYTIENMAT].[C_SOTIEN] > 0) OR ([SOQUYTIENMAT].[C_TYPE] = N'Tồn đầu kỳ')) a*/
public partial class module_SOQUYTIENMATV2 : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridSOQUYTIENMATV2.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridSOQUYTIENMATV2.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridSOQUYTIENMATV2.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
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
        RadGridSOQUYTIENMATV2.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridSOQUYTIENMATV2.MasterTableView.RenderColumns)
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
        RadGridSOQUYTIENMATV2.MasterTableView.Rebind();
    }
    private void DisplayMessage(string text)
    {
        RadGridSOQUYTIENMATV2.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridSOQUYTIENMATV2_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
        LoadTaiChinh();
    }
    protected void RadGridSOQUYTIENMATV2_ItemDeleted(object sender, GridDeletedEventArgs e)
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
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted SOQUYTIENMATV2s", e.Item.KeyValues);
        }
    }
    protected void RadGridSOQUYTIENMATV2_ItemInserted(object sender, GridInsertedEventArgs e)
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
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted SOQUYTIENMATV2s", "{PK_ID:\"" + getmaxid("SOQUYTIENMATV2") + "\"}");
        }
    }
    protected void RadGridSOQUYTIENMATV2_ItemUpdated(object sender, GridUpdatedEventArgs e)
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
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated SOQUYTIENMATV2s", e.Item.KeyValues);
        }
    }
    bool isExport = false;
    protected void RadGridSOQUYTIENMATV2_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadGrid grid = (RadGrid)sender;
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            RadDatePicker radNgaySOQUYTIENMATV2 = (RadDatePicker)editItem.FindControl("radNgaySOQUYTIENMATV2");
            RadComboBox cmbC_TYPE = (RadComboBox)editItem.FindControl("cmbC_TYPE");
            RadComboBox cmbFK_KIHIEUTAIKHOAN = (RadComboBox)editItem.FindControl("cmbFK_KIHIEUTAIKHOAN");
            if (e.Item is GridEditFormInsertItem || e.Item is GridDataInsertItem)
            {
                // insert item
                radNgaySOQUYTIENMATV2.SelectedDate = System.DateTime.Now;
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
            if (e.Item.Cells[5].Text == "Thu")
            {

            }
            else if (e.Item.Cells[5].Text == "Chi")
            {

            }
            else if (e.Item.Cells[5].Text == "Tồn đầu kỳ")
            {
                e.Item.BackColor = System.Drawing.Color.Red;
                e.Item.ForeColor = System.Drawing.Color.White;
                lblSTT.Text = "";
            }
            else if (e.Item.Cells[5].Text == "Tồn cuối kỳ")
            {
                e.Item.BackColor = System.Drawing.Color.Red;
                e.Item.ForeColor = System.Drawing.Color.White;
                lblSTT.Text = "";
            }
        }
    }
    protected void RadGridSOQUYTIENMATV2_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridSOQUYTIENMATV2.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridSOQUYTIENMATV2.Rebind();
            }
            foreach (GridDataItem item in RadGridSOQUYTIENMATV2.SelectedItems)
            {
                if (!ValidateDeleteGroup(item["pk_id"].Text))
                {
                    SetMessage("Không thể xóa \"" + item["c_name"].Text + "\" do có tham chiếu dữ liệu khác.");
                    RadGridSOQUYTIENMATV2.Rebind();
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
                SOQUYTIENMATV2DataSource.InsertParameters["C_ORDER"].DefaultValue = "2";
            }
            else
            {
                SOQUYTIENMATV2DataSource.InsertParameters["C_ORDER"].DefaultValue = "1";
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
            SOQUYTIENMATV2DataSource.SelectParameters["DAY"].DefaultValue = "0";
        }
    }
    protected void cmbMonth_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cmbMonth.SelectedValue = System.DateTime.Now.Month.ToString();
            SOQUYTIENMATV2DataSource.SelectParameters["MONTH"].DefaultValue = System.DateTime.Now.Month.ToString();
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
            SOQUYTIENMATV2DataSource.SelectParameters["YEAR"].DefaultValue = System.DateTime.Now.Year.ToString();
        }
    }

    protected void RadGridSOQUYTIENMATV2_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridPagerItem)
        {
            RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
            RadComboBoxItem item = new RadComboBoxItem("100", "100");
            item.Attributes.Add("ownerTableViewId", RadGridSOQUYTIENMATV2.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("100") == null) cb.Items.Add(item);
            item = new RadComboBoxItem("200", "200");
            item.Attributes.Add("ownerTableViewId", RadGridSOQUYTIENMATV2.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("200") == null) cb.Items.Add(item);
            item = new RadComboBoxItem("500", "500");
            item.Attributes.Add("ownerTableViewId", RadGridSOQUYTIENMATV2.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("500") == null) cb.Items.Add(item);
            item = new RadComboBoxItem("1000", "1000");
            item.Attributes.Add("ownerTableViewId", RadGridSOQUYTIENMATV2.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("1000") == null) cb.Items.Add(item);
            item = new RadComboBoxItem("2000", "2000");
            item.Attributes.Add("ownerTableViewId", RadGridSOQUYTIENMATV2.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("2000") == null) cb.Items.Add(item);
            item = new RadComboBoxItem("5000", "5000");
            item.Attributes.Add("ownerTableViewId", RadGridSOQUYTIENMATV2.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("5000") == null) cb.Items.Add(item);
            cb.Items.Sort(new PagerRadComboBoxItemComparer());
            cb.Items.FindItemByValue(RadGridSOQUYTIENMATV2.PageSize.ToString()).Selected = true;
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
        SelectSQL = "SELECT SUM ([SOQUYTIENMAT].[C_SOTIEN]) as TONGTHU FROM [SOQUYTIENMAT] WHERE [SOQUYTIENMAT].[FK_VUNGLAMVIEC] = N'" + Session["VUNGLAMVIEC"] + "' AND month([SOQUYTIENMAT].[C_NGAY]) =" + cmbMonth.SelectedValue + " AND year([SOQUYTIENMAT].[C_NGAY]) =" + cmbYear.SelectedValue + " AND [SOQUYTIENMAT].[C_TYPE] = N'Thu'";
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
        SelectSQL = "SELECT SUM ([SOQUYTIENMAT].[C_SOTIEN]) as TONGCHI FROM [SOQUYTIENMAT] WHERE [SOQUYTIENMAT].[FK_VUNGLAMVIEC] = N'" + Session["VUNGLAMVIEC"] + "' AND month([SOQUYTIENMAT].[C_NGAY]) =" + cmbMonth.SelectedValue + " AND year([SOQUYTIENMAT].[C_NGAY]) =" + cmbYear.SelectedValue + " AND [SOQUYTIENMAT].[C_TYPE] = N'Chi'";
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

}