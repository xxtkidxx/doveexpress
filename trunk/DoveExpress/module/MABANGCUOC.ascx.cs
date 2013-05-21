using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class module_MABANGCUOC : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridMABANGCUOC.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridMABANGCUOC.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridMABANGCUOC.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
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
        RadAjaxManager ajaxManager = RadAjaxManager.GetCurrent(Page);
        ajaxManager.AjaxRequest += new RadAjaxControl.AjaxRequestDelegate(RadScriptManager_AjaxRequestMBC);
        ajaxManager.ClientEvents.OnResponseEnd = "onResponseEndMBC";
        Session["LastUrl"] = Request.Url.ToString();
    }
    protected void RadScriptManager_AjaxRequestMBC(object sender, AjaxRequestEventArgs e)
    {
        string[] arrayvalue = e.Argument.Split(';');
        if (arrayvalue[0] == "SelectedMBC")
        {
            string script = string.Format("var result = '{0}'", arrayvalue[1]);
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
            UpdateDefault(arrayvalue[1]);
        }
    }
    protected void UpdateDefault(string ID)
    {
        ITCLIB.Admin.SQL rs = new ITCLIB.Admin.SQL();
        string Querry = "Update DMMABANGCUOC set C_DEFAULT = 1 WHERE PK_ID =" + ID + ";Update DMMABANGCUOC set C_DEFAULT = 0 WHERE PK_ID <>" + ID;
        rs.ExecuteNonQuery(Querry);
    }
    protected bool getstatus(object status)
    {
        if (status == DBNull.Value)
        { return false; }
        else
        {
            int test = (int)status;
            if (test == 1)
            { return true; }
            else { return false; }
        }
    }
    protected void btnShowAll_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadGridMABANGCUOC.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridMABANGCUOC.MasterTableView.RenderColumns)
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
        RadGridMABANGCUOC.MasterTableView.Rebind();
    }
    protected void CheckCode(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        SelectSQL = "Select DMMABANGCUOC.C_CODE FROM DMMABANGCUOC WHERE DMMABANGCUOC.C_CODE = '" + args.Value + "' AND DMMABANGCUOC.PK_ID <> " + Session["txtID"].ToString();
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
    protected void CheckName(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        SelectSQL = "Select DMMABANGCUOC.C_NAME FROM DMMABANGCUOC WHERE DMMABANGCUOC.C_NAME = '" + args.Value + "' AND DMMABANGCUOC.PK_ID <> " + Session["txtID"].ToString();
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
        RadGridMABANGCUOC.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridMABANGCUOC_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridMABANGCUOC_ItemDeleted(object sender, GridDeletedEventArgs e)
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
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted MABANGCUOCs", e.Item.KeyValues);
        }
    }
    protected void RadGridMABANGCUOC_ItemInserted(object sender, GridInsertedEventArgs e)
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
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted MABANGCUOCs", "{PK_ID:\"" + getmaxid("DMMABANGCUOC") + "\"}");
        }
    }
    protected void RadGridMABANGCUOC_ItemUpdated(object sender, GridUpdatedEventArgs e)
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
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated MABANGCUOCs", e.Item.KeyValues);
        }
    }
    protected void RadGridMABANGCUOC_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadGrid grid = (RadGrid)sender;
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            HiddenField txtID = (HiddenField)editItem.FindControl("txtID");
            Session["txtID"] = (txtID.Value != "") ? txtID.Value : "0";
            if (e.Item is GridEditFormInsertItem || e.Item is GridDataInsertItem)
            {
                // insert item
                RadioButtonList txtStatus = (RadioButtonList)editItem.FindControl("txtStatus");
                txtStatus.SelectedValue = "0";
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
        }
    }
    protected void RadGridMABANGCUOC_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridMABANGCUOC.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridMABANGCUOC.Rebind();
            }
            foreach (GridDataItem item in RadGridMABANGCUOC.SelectedItems)
            {
                if (!ValidateDeleteGroup(item["pk_id"].Text))
                {
                    SetMessage("Không thể xóa mã bảng cước \"" + item["c_name"].Text + "\" do có tham chiếu dữ liệu khác.");
                    RadGridMABANGCUOC.Rebind();
                }
            }
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
}