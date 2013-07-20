using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;
using System.Globalization;

public partial class module_SOQUYTIENMAT : System.Web.UI.UserControl
{
    public double TONDAUKY = 0;
    public double TONGTHU = 0;
    public double TONGCHI = 0;
    public double TONCUOIKY = 0;
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
        if (Request["index"] != null && Request["value"] != null)
        {
            string index = Request["index"].ToString();
            string Value = Request["value"].ToString();
        }
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
                if (cmbFK_KIHIEUTAIKHOAN.Items.Count != 0)
                {
                    cmbFK_KIHIEUTAIKHOAN.SelectedIndex = 0;
                }
            }
            else
            {
                // edit item
                
            }
        }
        if (e.Item is GridDataItem)
        {
            Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
            if (e.Item.Cells[5].Text == "Thu")
            {
                TONGTHU = TONGTHU + double.Parse(e.Item.Cells[8].Text);
                TONCUOIKY = double.Parse(e.Item.Cells[8].Text) + TONCUOIKY;
            }
            else if (e.Item.Cells[5].Text == "Chi")
            {
                TONGCHI = TONGCHI + double.Parse(e.Item.Cells[8].Text);
                TONCUOIKY = TONCUOIKY - double.Parse(e.Item.Cells[8].Text);
            }
            e.Item.Cells[9].Text = TONCUOIKY.ToString();
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
            
        }
        else if (e.CommandName == RadGrid.UpdateCommandName)
        {
           
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
    protected void Button1_Click(object sender, EventArgs e)
    {
        ITCLIB.Admin.JavaScript.ShowMessage(Session["t"].ToString(), this);
    }
}