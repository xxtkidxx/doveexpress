using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;

public partial class module_QUANHUYEN : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridQUANHUYEN.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridQUANHUYEN.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridQUANHUYEN.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("VUNGDIALY"))
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
        RadGridQUANHUYEN.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridQUANHUYEN.MasterTableView.RenderColumns)
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
        RadGridQUANHUYEN.MasterTableView.Rebind();
    }
    protected void CheckCode(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        SelectSQL = "Select DMQUANHUYEN.C_CODE FROM DMQUANHUYEN WHERE DMQUANHUYEN.C_CODE = '" + args.Value + "' AND DMQUANHUYEN.PK_ID <> " + Session["txtID"].ToString();
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
        RadGridQUANHUYEN.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridQUANHUYEN_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridQUANHUYEN_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xóa quận huyện. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa quận huyện thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted QUANHUYEN", e.Item.KeyValues);
        }
    }
    protected void RadGridQUANHUYEN_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới quận huyện. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Tạo mới quận huyện thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted QUANHUYEN", "{PK_ID:\"" + getmaxid("DMPHONGBAN") + "\"}");
        }
    }
    protected void RadGridQUANHUYEN_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật quận huyện. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Cập nhật quận huyện thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated QUANHUYEN", e.Item.KeyValues);
        }
    }
    protected void RadGridQUANHUYEN_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadGrid grid = (RadGrid)sender;
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            HiddenField txtID = (HiddenField)editItem.FindControl("txtID");
            DropDownList ddlTINHTHANH = (DropDownList)editItem.FindControl("ddlTINHTHANH");
            Session["txtID"] = (txtID.Value != "") ? txtID.Value : "0";
            if (e.Item.OwnerTableView.IsItemInserted)
            {
                if (Session["ttID"] != null)
                {
                    ddlTINHTHANH.SelectedValue = Session["ttID"].ToString();
                }
            }
            else
            {

            }
        }
        if (e.Item is GridDataItem)
        {
            Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
        }
    }
    protected void RadGridQUANHUYEN_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridQUANHUYEN.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridQUANHUYEN.Rebind();
            }
            foreach (GridDataItem item in RadGridQUANHUYEN.SelectedItems)
            {
                if (!ValidateDelete(item["pk_id"].Text))
                {
                    SetMessage(String.Format("Không thể xóa quận huyện \"{0}\" do có tham chiếu dữ liệu khác.", item["c_name"].Text));
                    RadGridQUANHUYEN.Rebind();
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
        string SelectSQL = String.Format("SELECT MAX({0}.PK_ID) as MAXS FROM {0}", table);
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
    protected bool ValidateDelete(string pkID)
    {
        /*Ưint rowcount = 0;
        string SelectSQL1 = "SELECT PK_ID FROM USERS WHERE USERS.FK_PHONGBAN = " + pkID;
        string SelectSQL2 = "SELECT PK_ID FROM DMPHONGBAN WHERE DMPHONGBAN.c_parent = " + pkID;
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(String.Format("{0} UNION {1}", SelectSQL1, SelectSQL2));
        rowcount = oDataTable.Rows.Count;
        if (rowcount != 0)
        {
            return false;
        }
        else*/
        //{
        return true;
        //}
    }
    protected void RadGridQUANHUYEN_ItemCreated(object sender, GridItemEventArgs e)
    {
    }
    protected void RadGridQUANHUYEN_PreRender(object sender, EventArgs e)
    {

    }
    protected void lblcap_PreRender(object sender, EventArgs e)
    {
        Label titile = (Label)sender;
        if (Session["ttID"] != null)
        {
            titile.Text = ITCLIB.Admin.cFunction.getname(Session["ttID"].ToString(), "DMTINHTHANH");
        }
        else { titile.Text = ""; }
    }
    protected void RadPanelBarListTINHTHANH_ItemDataBound(object sender, RadPanelBarEventArgs e)
    {
        RadPanelItem item = (RadPanelItem)e.Item;
        item.ImageUrl = "../images/folder-closed.gif";
        item.SelectedImageUrl = "../images/folder_open.png";
    }
    protected void RadPanelBarListTINHTHANH_ItemClick(object sender, RadPanelBarEventArgs e)
    {
        Session["ttID"] = RadPanelBarListTINHTHANH.SelectedItem.Value;
        RadGridQUANHUYEN.DataBind();
    }
    protected void RadPanelBarListTINHTHANH_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["ttID"] = 0;
            RadPanelItem item = (RadPanelItem)RadPanelBarListTINHTHANH.FindItemByValue("0");
            if (item != null)
            {
                item.Expanded = true;
                item.Selected = true;
            }
        }
    }
}