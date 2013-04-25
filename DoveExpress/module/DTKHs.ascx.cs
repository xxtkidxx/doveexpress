using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class module_DTKHs : System.Web.UI.UserControl
{
    public string TENDONVIDUTOAN = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridDTKH.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridDTKH.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridDTKH.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("DTKHs"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        if (Request.QueryString ["dtID"] != null )
        {
            TENDONVIDUTOAN = ITCLIB.Admin.cFunction.LoadFieldfromTable(Request.QueryString["dtID"],"TENDONVI","DUTOANDONVI");
        }       
        Session["LastUrl"] = Request.Url.ToString();
    }
    protected void btnShowAll_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadGridDTKH.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridDTKH.MasterTableView.RenderColumns)
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
        RadGridDTKH.MasterTableView.Rebind();
    }
    protected void CheckTENDETAI(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        Session["txtID"] = (Session["txtID"].ToString() == "") ? 0 : Session["txtID"];
        SelectSQL = "Select DUTOANDETAI.TENDETAI FROM DUTOANDETAI WHERE DUTOANDETAI.TENDETAI = N'" + args.Value + "' AND DUTOANDETAI.PK_ID <> " + Session["txtID"].ToString();
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
        RadGridDTKH.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridDTKH_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridDTKH_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xoá đề tài, dự án khoa học. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa đề tài, dự án khoa học thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted DTKHs", e.Item.GetDataKeyValue("PK_ID").ToString());
        }
    }
    protected void RadGridDTKH_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới đề tài, dự án khoa học. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Tạo mới đề tài, dự án khoa học thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted DTKHs", (e.Item.FindControl("txtTENDETAI") as TextBox).Text);
        }
    }
    protected void RadGridDTKH_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật đề tài, dự án khoa học. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Cập nhật đề tài, dự án khoa học thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated DTKHs", e.Item.GetDataKeyValue("PK_ID").ToString());
        }
    }
    protected void RadGridDTKH_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridDTKH.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridDTKH.Rebind();
            }
            foreach (GridDataItem item in RadGridDTKH.SelectedItems)
            {
                if (!ValidateDeleteDTKH(item["PK_ID"].Text))
                {
                    SetMessage("Không thể xóa đề tài, dự án khoa học (ID: " + item["PK_ID"].Text + ")");
                    RadGridDTKH.Rebind();
                }
            }
        }
    }
    protected void RadGridDTKH_ItemDataBound(object sender, GridItemEventArgs e)
    {
        GridItem cmdItem = RadGridDTKH.MasterTableView.GetItems(GridItemType.CommandItem)[0];
        Label lblTitle = (Label)cmdItem.FindControl("lblTitle");
        lblTitle.Text = TENDONVIDUTOAN + " - Quản lý đề tài, dự án khoa học";
        if (e.Item is GridDataItem)
        {
            Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
        }
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            TextBox txtID = (TextBox)editItem.FindControl("txtID");
            TextBox txtDONVITHUCHIEN = (TextBox)editItem.FindControl("txtDONVITHUCHIEN");
            Session["txtID"] = txtID.Text;
            txtDONVITHUCHIEN.Text = TENDONVIDUTOAN;
        }
    }
    protected bool ValidateDeleteDTKH(string guID)
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
