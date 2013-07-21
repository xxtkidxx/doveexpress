﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;
using System.Globalization;
using Telerik.Web.UI.GridExcelBuilder;

public partial class module_SOQUYTIENMAT : System.Web.UI.UserControl
{
    private double TONDAUKY
    {
        get
        {
            return double.Parse(Session["TONDAUKY"].ToString());
        }
        set
        {
            Session["TONDAUKY"] = value;
        }
    }
    private double TONGTHU
    {
        get
        {
            return double.Parse(Session["TONGTHU"].ToString());
        }
        set
        {
            Session["TONGTHU"] = value;
        }
    }
    private double TONGCHI
    {
        get
        {
            return double.Parse(Session["TONGCHI"].ToString());
        }
        set
        {
            Session["TONGCHI"] = value;
        }
    }
    private double TONCUOIKY
    {
        get
        {
            return double.Parse(Session["TONCUOIKY"].ToString());
        }
        set
        {
            Session["TONCUOIKY"] = value;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridSOQUYTIENMAT.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridSOQUYTIENMAT.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridSOQUYTIENMAT.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("Lists"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        TONCUOIKY = 0;
        TONGCHI = 0;
        TONGTHU = 0;
        TONDAUKY = 0;
        Session["LastUrl"] = Request.Url.ToString();
    }
    protected void btnShowAll_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadGridSOQUYTIENMAT.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridSOQUYTIENMAT.MasterTableView.RenderColumns)
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
        RadGridSOQUYTIENMAT.MasterTableView.Rebind();
    }
    private void DisplayMessage(string text)
    {
        RadGridSOQUYTIENMAT.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridSOQUYTIENMAT_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
        txtTONDAU.Text = TONDAUKY.ToString();
        txtTONGTHU.Text = TONGTHU.ToString();
        txtTONGCHI.Text = TONGCHI.ToString();
        txtTONCUOI.Text = TONCUOIKY.ToString();
    }
    protected void RadGridSOQUYTIENMAT_ItemDeleted(object sender, GridDeletedEventArgs e)
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
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted SOQUYTIENMATs", e.Item.KeyValues);
        }
    }
    protected void RadGridSOQUYTIENMAT_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới sổ quỹ tiền mặt. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Tạo mới sổ quỹ tiền mặt thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted SOQUYTIENMATs", "{PK_ID:\"" + getmaxid("SOQUYTIENMAT") + "\"}");
        }
    }
    protected void RadGridSOQUYTIENMAT_ItemUpdated(object sender, GridUpdatedEventArgs e)
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
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated SOQUYTIENMATs", e.Item.KeyValues);
        }
    }
    bool isExport = false;
    protected void RadGridSOQUYTIENMAT_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadGrid grid = (RadGrid)sender;
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            RadDatePicker radNgaySOQUYTIENMAT = (RadDatePicker)editItem.FindControl("radNgaySOQUYTIENMAT");
            RadComboBox cmbC_TYPE = (RadComboBox)editItem.FindControl("cmbC_TYPE");
            RadComboBox cmbFK_KIHIEUTAIKHOAN = (RadComboBox)editItem.FindControl("cmbFK_KIHIEUTAIKHOAN"); 
            if (e.Item is GridEditFormInsertItem || e.Item is GridDataInsertItem)
            {
                // insert item
                radNgaySOQUYTIENMAT.SelectedDate = System.DateTime.Now;
                cmbC_TYPE.SelectedIndex = 0;
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
            lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
            if (e.Item.Cells[5].Text == "Thu")
            {
                TONGTHU = TONGTHU + double.Parse(txtC_SOTIEN.Text);
                TONCUOIKY = double.Parse(txtC_SOTIEN.Text) + TONCUOIKY;
                txtC_TON.Text = TONCUOIKY.ToString();
            }
            else if (e.Item.Cells[5].Text == "Chi")
            {
                TONGCHI = TONGCHI + double.Parse(txtC_SOTIEN.Text);
                TONCUOIKY = TONCUOIKY - double.Parse(txtC_SOTIEN.Text);
                txtC_TON.Text = TONCUOIKY.ToString();
            }
            else if (e.Item.Cells[5].Text == "Tồn đầu kì")
            {
                TONDAUKY = double.Parse(txtC_SOTIEN.Text);
                txtC_TON.Text = TONDAUKY.ToString();
                TONCUOIKY = TONDAUKY;
                e.Item.BackColor = System.Drawing.Color.Red;
                e.Item.ForeColor = System.Drawing.Color.White;
            }
            else if (e.Item.Cells[5].Text == "Tồn cuối kỳ")
            {
                TONCUOIKY = double.Parse(txtC_SOTIEN.Text);
                txtC_TON.Text = TONDAUKY.ToString();
                e.Item.BackColor = System.Drawing.Color.Red;
                e.Item.ForeColor = System.Drawing.Color.White;
            }
            Session["t"] = TONCUOIKY;
        }
    }
    protected void RadGridSOQUYTIENMAT_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridSOQUYTIENMAT.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridSOQUYTIENMAT.Rebind();
            }
            foreach (GridDataItem item in RadGridSOQUYTIENMAT.SelectedItems)
            {
                if (!ValidateDeleteGroup(item["pk_id"].Text))
                {
                    SetMessage("Không thể xóa \"" + item["c_name"].Text + "\" do có tham chiếu dữ liệu khác.");
                    RadGridSOQUYTIENMAT.Rebind();
                }
            }
        }
        else if (e.CommandName == RadGrid.PerformInsertCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            RadComboBox cmbC_TYPE = (RadComboBox)editItem.FindControl("cmbC_TYPE");
            if (cmbC_TYPE.SelectedIndex == 2)
            {
                SOQUYTIENMATDataSource.InsertParameters["FK_KIHIEUTAIKHOAN"].DefaultValue = "0";
                SOQUYTIENMATDataSource.InsertParameters["C_ORDER"].DefaultValue = "0";
            }
            else if (cmbC_TYPE.SelectedIndex == 3)
            {
                SOQUYTIENMATDataSource.InsertParameters["FK_KIHIEUTAIKHOAN"].DefaultValue = "0";
                SOQUYTIENMATDataSource.InsertParameters["C_ORDER"].DefaultValue = "2";
            }
            else
            {
                SOQUYTIENMATDataSource.InsertParameters["C_ORDER"].DefaultValue = "1";
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
    protected void cmbMonth_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cmbMonth.SelectedValue = System.DateTime.Now.Month.ToString();
            SOQUYTIENMATDataSource.SelectParameters["MONTH"].DefaultValue = System.DateTime.Now.Month.ToString();
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
            SOQUYTIENMATDataSource.SelectParameters["YEAR"].DefaultValue = System.DateTime.Now.Year.ToString();
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        ITCLIB.Admin.JavaScript.ShowMessage(Session["t"].ToString(), this);
    }
    protected void RadGridSOQUYTIENMAT_ExcelMLExportRowCreated(object sender, Telerik.Web.UI.GridExcelBuilder.GridExportExcelMLRowCreatedArgs e)
    {
        if (e.RowType == GridExportExcelMLRowType.HeaderRow)
        {
            RadGridSOQUYTIENMAT.Rebind();  //workaround to get the template column's content
            //create new column element and a header cell
            e.Worksheet.Table.Columns.Add(new ColumnElement());
            CellElement cell = new CellElement();
            //correct the autofilter
            e.Worksheet.AutoFilter.Range = String.Format("R{0}C{1}:R{0}C{2}", 1, 1, e.Worksheet.Table.Columns.Count + 1);
            //populate the header cell
            cell.Data.DataItem = (RadGridSOQUYTIENMAT.MasterTableView.GetItems(GridItemType.Header)[0] as GridHeaderItem)["C_TON"].Text.Trim();
            e.Row.Cells.Add(cell);
        }

        if (e.RowType == GridExportExcelMLRowType.DataRow)
        {
            //create cell for the current row
            CellElement cell = new CellElement();
            int currentRow = e.Worksheet.Table.Rows.IndexOf(e.Row) - 1;
            //populate the data cell
            RadNumericTextBox txtC_TON = (RadNumericTextBox)RadGridSOQUYTIENMAT.MasterTableView.Items[currentRow].FindControl("txtC_TON");
            RadNumericTextBox txtC_SOTIEN = (RadNumericTextBox)RadGridSOQUYTIENMAT.MasterTableView.Items[currentRow].FindControl("txtC_SOTIEN");
            if (RadGridSOQUYTIENMAT.MasterTableView.Items[currentRow].Cells[5].Text == "Thu")
            {
                TONGTHU = TONGTHU + double.Parse(txtC_SOTIEN.Text);
                TONCUOIKY = double.Parse(txtC_SOTIEN.Text) + TONCUOIKY;
                cell.Data.DataItem = TONCUOIKY.ToString();
            }
            else if (RadGridSOQUYTIENMAT.MasterTableView.Items[currentRow].Cells[5].Text == "Chi")
            {
                TONGCHI = TONGCHI + double.Parse(txtC_SOTIEN.Text);
                TONCUOIKY = TONCUOIKY - double.Parse(txtC_SOTIEN.Text);
                cell.Data.DataItem = TONCUOIKY.ToString();
            }
            else if (RadGridSOQUYTIENMAT.MasterTableView.Items[currentRow].Cells[5].Text == "Tồn đầu kì")
            {
                TONDAUKY = double.Parse(txtC_SOTIEN.Text);
                cell.Data.DataItem = TONDAUKY.ToString();
                TONCUOIKY = TONDAUKY;
            }
            else if (RadGridSOQUYTIENMAT.MasterTableView.Items[currentRow].Cells[5].Text == "Tồn cuối kỳ")
            {
                TONCUOIKY = double.Parse(txtC_SOTIEN.Text);
                cell.Data.DataItem = TONDAUKY.ToString();                
            }
            e.Row.Cells.Add(cell);
        }
    }
}