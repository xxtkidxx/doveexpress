using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;

public partial class module_TINHTHANH : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridTINHTHANH.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridTINHTHANH.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridTINHTHANH.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
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
        RadGridTINHTHANH.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridTINHTHANH.MasterTableView.RenderColumns)
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
        RadGridTINHTHANH.MasterTableView.Rebind();
    }
    protected void CheckCode(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        SelectSQL = "Select DMTINHTHANH.C_CODE FROM DMTINHTHANH WHERE DMTINHTHANH.C_CODE = '" + args.Value + "' AND DMTINHTHANH.PK_ID <> " + Session["txtID"].ToString();
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
        RadGridTINHTHANH.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridTINHTHANH_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridTINHTHANH_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xóa tỉnh thành. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa tỉnh thành thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted TINHTHANH", e.Item.KeyValues);
        }
    }
    protected void RadGridTINHTHANH_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới tỉnh thành. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Tạo mới tỉnh thành thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted TINHTHANH", "{PK_ID:\"" + getmaxid("DMPHONGBAN") + "\"}");
        }
    }
    protected void RadGridTINHTHANH_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật tỉnh thành. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Cập nhật tỉnh thành thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated TINHTHANH", e.Item.KeyValues);
        }
    }
    protected void RadGridTINHTHANH_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadGrid grid = (RadGrid)sender;
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            HiddenField txtID = (HiddenField)editItem.FindControl("txtID");
            DropDownList ddlQUOCGIA = (DropDownList)editItem.FindControl("ddlQUOCGIA");
            Session["txtID"] = (txtID.Value != "") ? txtID.Value : "0";
            if (e.Item.OwnerTableView.IsItemInserted)
            {
                if (Session["qgid"] != null)
                {
                    ddlQUOCGIA.SelectedValue = Session["qgid"].ToString();
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
    protected void RadGridTINHTHANH_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridTINHTHANH.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridTINHTHANH.Rebind();
            }
            foreach (GridDataItem item in RadGridTINHTHANH.SelectedItems)
            {
                if (!ValidateDelete(item["pk_id"].Text))
                {
                    SetMessage(String.Format("Không thể xóa tỉnh thành \"{0}\" do có tham chiếu dữ liệu khác.", item["c_name"].Text));
                    RadGridTINHTHANH.Rebind();
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
    protected void RadGridTINHTHANH_ItemCreated(object sender, GridItemEventArgs e)
    {
    }
    protected void RadGridTINHTHANH_PreRender(object sender, EventArgs e)
    {

    }
    protected void lblcap_PreRender(object sender, EventArgs e)
    {
        Label titile = (Label)sender;
        if (Session["qgid"] != null)
        {
            titile.Text = ITCLIB.Admin.cFunction.getname(Session["qgid"].ToString(), "DMQUOCGIA");
        }
        else { titile.Text = ""; }
    }
    protected void RadPanelBarListQUOCGIA_ItemDataBound(object sender, RadPanelBarEventArgs e)
    {
        RadPanelItem item = (RadPanelItem)e.Item;
        item.ImageUrl = "../images/folder-closed.gif";
        item.SelectedImageUrl = "../images/folder_open.png";
    }
    protected void RadPanelBarListQUOCGIA_ItemClick(object sender, RadPanelBarEventArgs e)
    {
        Session["qgid"] = RadPanelBarListQUOCGIA.SelectedItem.Value;
        RadGridTINHTHANH.DataBind();
    }
    protected void RadPanelBarListQUOCGIA_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            RadPanelItem item = (RadPanelItem)RadPanelBarListQUOCGIA.Items[0];
            if (item != null)
            {
                Session["qgid"] = item.Value;
                item.Expanded = true;
                item.Selected = true;
            }
        }
    }
}