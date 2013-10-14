using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class module_MABANGCUOCQT : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridMABANGCUOCQT.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridMABANGCUOCQT.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridMABANGCUOCQT.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
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
        RadGridMABANGCUOCQT.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridMABANGCUOCQT.MasterTableView.RenderColumns)
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
        RadGridMABANGCUOCQT.MasterTableView.Rebind();
    }
    protected void CheckCode(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        SelectSQL = "Select DMMABANGCUOCQT.C_CODE FROM DMMABANGCUOCQT WHERE DMMABANGCUOCQT.C_CODE = '" + args.Value + "' AND DMMABANGCUOCQT.PK_ID <> " + Session["txtID"].ToString() + " AND DMMABANGCUOCQT.FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"].ToString() + "'";
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
    private void DisplayMessage(string text)
    {
        RadGridMABANGCUOCQT.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridMABANGCUOCQT_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridMABANGCUOCQT_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xóa mã bảng cước. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa mã bảng cước thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted MABANGCUOCQTs", e.Item.KeyValues);
        }
    }
    protected void RadGridMABANGCUOCQT_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới mã bảng cước. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Tạo mới mã bảng cước thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted MABANGCUOCQTs", "{PK_ID:\"" + getmaxid("DMMABANGCUOCQT") + "\"}");
        }
    }
    protected void RadGridMABANGCUOCQT_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật mã bảng cước. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Cập nhật mã bảng cước thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated MABANGCUOCQTs", e.Item.KeyValues);
        }
    }
    protected void RadGridMABANGCUOCQT_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadGrid grid = (RadGrid)sender;
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            HiddenField txtID = (HiddenField)editItem.FindControl("txtID");
            Session["txtID"] = (txtID.Value != "") ? txtID.Value : "0";
            RadListBox RadListBoxNhomKhachHangRef = (RadListBox)editItem.FindControl("RadListBoxNhomKhachHangRef");
            HiddenField txtC_VALUE = (HiddenField)editItem.FindControl("txtC_VALUE");
            RadNumericTextBox txtC_VALUE1 = (RadNumericTextBox)editItem.FindControl("txtC_VALUE1");
            RadNumericTextBox txtC_VALUE2 = (RadNumericTextBox)editItem.FindControl("txtC_VALUE2");
            setItenforListBoxSelect(RadListBoxNhomKhachHangRef, txtC_VALUE.Value);
            if (e.Item is GridEditFormInsertItem || e.Item is GridDataInsertItem)
            {
                // insert item
                txtC_VALUE1.Text = "0";
                txtC_VALUE2.Text = "0";
            }
        }
        if (e.Item is GridDataItem)
        {
            Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
        }
    }
    protected static void setItenforListBoxSelect(RadListBox control, string ivalue)
    {
        if (ivalue != "")
        {
            string selectSQl = String.Format("Select PK_ID, C_NAME from DMNHOMKHACHHANG WHERE PK_ID in ({0})", ivalue);
            ITCLIB.Admin.SQL sqlAC = new ITCLIB.Admin.SQL();
            DataTable odata = sqlAC.query_data(selectSQl);
            foreach (DataRow orow in odata.Rows)
            {
                if (control.FindItemByValue(orow["PK_ID"].ToString()) == null)
                {
                    RadListBoxItem item = new RadListBoxItem();
                    item.Value = orow["PK_ID"] != null ? orow["PK_ID"].ToString() : "";
                    item.Text = orow["C_NAME"] != null ? orow["C_NAME"].ToString() : "";
                    control.Items.Add(item);
                }
            }
        }
    }
    protected void RadGridMABANGCUOCQT_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridMABANGCUOCQT.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridMABANGCUOCQT.Rebind();
            }
            foreach (GridDataItem item in RadGridMABANGCUOCQT.SelectedItems)
            {
                if (!ValidateDeleteGroup(item["pk_id"].Text))
                {
                    SetMessage("Không thể xóa mã bảng cước \"" + item["c_name"].Text + "\" do có tham chiếu dữ liệu khác.");
                    RadGridMABANGCUOCQT.Rebind();
                }
            }
        }
        else if (e.CommandName == RadGrid.PerformInsertCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            RadListBox RadListBoxNhomKhachHangRef = (RadListBox)editItem.FindControl("RadListBoxNhomKhachHangRef");
            if (getStringSelect(RadListBoxNhomKhachHangRef) != "")
            {
                MABANGCUOCQTDataSource.InsertParameters["C_VALUE"].DefaultValue = getStringSelect(RadListBoxNhomKhachHangRef);
            }
        }
        else if (e.CommandName == RadGrid.UpdateCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            RadListBox RadListBoxNhomKhachHangRef = (RadListBox)editItem.FindControl("RadListBoxNhomKhachHangRef");
            if (getStringSelect(RadListBoxNhomKhachHangRef) != "")
            {
                MABANGCUOCQTDataSource.UpdateParameters["C_VALUE"].DefaultValue = getStringSelect(RadListBoxNhomKhachHangRef);
            }
        }
    }
    protected static string getStringSelect(RadListBox control)
    {
        string result = "";
        if (control.Items.Count != 0)
        {
            foreach (RadListBoxItem item in control.Items)
            {
                result = ITCLIB.Admin.cFunction.GetStringForList(item.Value, result, ',');
            }
        }
        return result;
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
}