using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class module_Donvidutoan : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridDonvidutoan.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridDonvidutoan.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridDonvidutoan.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("Donvidutoans"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        Session["LastUrl"] = Request.Url.ToString();
    }
    protected void btnShowAll_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadGridDonvidutoan.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridDonvidutoan.MasterTableView.RenderColumns)
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
        RadGridDonvidutoan.MasterTableView.Rebind();
    }
    protected void CheckTENDONVI(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        Session["txtID"] = (Session["txtID"].ToString() == "") ? 0 : Session["txtID"];
        SelectSQL = "Select DUTOANDETAI.TENDONVI FROM DUTOANDETAI WHERE DUTOANDETAI.TENDONVI = N'" + args.Value + "' AND DUTOANDETAI.PK_ID <> " + Session["txtID"].ToString();
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
        RadGridDonvidutoan.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridDonvidutoan_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridDonvidutoan_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xoá đơn vị dự toán. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa đơn vị dự toán thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted Donvidutoans", e.Item.GetDataKeyValue("PK_ID").ToString());
        }
    }
    protected void RadGridDonvidutoan_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới đơn vị dự toán. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Tạo mới đơn vị dự toán thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted Donvidutoans", (e.Item.FindControl("txtTENDONVI") as RadTextBox).Text);
        }
    }
    protected void RadGridDonvidutoan_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật đơn vị dự toán. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Cập nhật đơn vị dự toán thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated Donvidutoans", e.Item.GetDataKeyValue("PK_ID").ToString());
        }
    }
    protected void RadGridDonvidutoan_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridDonvidutoan.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridDonvidutoan.Rebind();
            }
            foreach (GridDataItem item in RadGridDonvidutoan.SelectedItems)
            {
                if (!ValidateDeleteDonvidutoan(item["PK_ID"].Text))
                {
                    SetMessage("Không thể xóa đơn vị dự toán (ID: " + item["PK_ID"].Text + ")");
                    RadGridDonvidutoan.Rebind();
                }
            }
        }
    }
    protected void RadGridDonvidutoan_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
        }
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            TextBox txtID = (TextBox)editItem.FindControl("txtID");
            Session["txtID"] = txtID.Text;
        }
    }
    protected bool ValidateDeleteDonvidutoan(string guID)
    {
        /*if (guID == "0" || guID == "1")
        {
            return false;
        }
        else
        {
            string SelectSQL = "SELECT DUTOANDETAI.PK_ID FROM DUTOANDETAI WHERE DUTOANDETAI.FK_User = " + guID;
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }*/
        return true;
    }
}
