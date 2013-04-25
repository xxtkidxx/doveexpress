using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class module_Doanhnghiep_Loaihinh : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridLoaiHinhDN.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridLoaiHinhDN.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridLoaiHinhDN.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
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
        RadGridLoaiHinhDN.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridLoaiHinhDN.MasterTableView.RenderColumns)
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
        RadGridLoaiHinhDN.MasterTableView.Rebind();
    }
    protected void CheckName(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        SelectSQL = "Select DMLOAIHINHDN.C_NAME FROM DMLOAIHINHDN WHERE DMLOAIHINHDN.C_NAME = '" + args.Value + "' AND DMLOAIHINHDN.PK_ID <> " + Session["txtID"].ToString();
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
        RadGridLoaiHinhDN.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridLoaiHinhDN_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridLoaiHinhDN_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xóa loại hình doanh nghiệp. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa loại hình doanh nghiệp thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted LoaiHinhDNs", e.Item.KeyValues);
        }
    }
    protected void RadGridLoaiHinhDN_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới loại hình doanh nghiệp. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Tạo mới loại hình doanh nghiệp thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted LoaiHinhDNs", "{PK_ID:\"" + getmaxid("DMLOAIHINHDN") + "\"}");
        }
    }
    protected void RadGridLoaiHinhDN_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật loại hình doanh nghiệp. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Cập nhật loại hình doanh nghiệp thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated LoaiHinhDNs", e.Item.KeyValues);
        }
    }
    protected void RadGridLoaiHinhDN_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadGrid grid = (RadGrid)sender;
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            HiddenField txtID = (HiddenField)editItem.FindControl("txtID");
            Session["txtID"] = (txtID.Value != "") ? txtID.Value : "0";
            RadioButtonList txtStatus = (RadioButtonList)editItem.FindControl("txtStatus");
            txtStatus.SelectedValue = "1";
        }
        if (e.Item is GridDataItem)
        {
            Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
        }
    }
    protected void RadGridLoaiHinhDN_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridLoaiHinhDN.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridLoaiHinhDN.Rebind();
            }
            foreach (GridDataItem item in RadGridLoaiHinhDN.SelectedItems)
            {
                if (!ValidateDeleteGroup(item["PK_ID"].Text))
                {
                    SetMessage("Không thể xóa loại hình doanh nghiệp \"" + item["C_NAME"].Text + "\" do có tham chiếu dữ liệu khác.");
                    RadGridLoaiHinhDN.Rebind();
                }
            }
        }
        else if (e.CommandName == RadGrid.PerformInsertCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            TextBox txtName = (TextBox)editItem.FindControl("txtName");
            if (txtName.Text.Trim() == "Cty CP, Cty TNHH có vốn Nhà nước > 50%")
            {
                LoaiHinhDNDataSource.InsertParameters["C_TYPE"].DefaultValue = "1";
            }
            else if (txtName.Text.Trim() == "Công ty TNHH tư nhân, Công ty TNHH có vốn Nhà nước ≤ 50%")
            {
                LoaiHinhDNDataSource.InsertParameters["C_TYPE"].DefaultValue = "2";
            }
            else if (txtName.Text.Trim() == "Công ty cổ phần có vốn Nhà nước ≤ 50%")
            {
                LoaiHinhDNDataSource.InsertParameters["C_TYPE"].DefaultValue = "3";
            }
            else
                LoaiHinhDNDataSource.InsertParameters["C_TYPE"].DefaultValue = "0";
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
        string SelectSQL = "SELECT DOANHNGHIEP.PK_ID FROM DOANHNGHIEP WHERE DOANHNGHIEP.LOAIHINHDN = " + pkID;
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        rowcount = oDataTable.Rows.Count;
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