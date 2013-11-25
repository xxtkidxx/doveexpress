using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;

public partial class module_QUOCGIA : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridQUOCGIA.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridQUOCGIA.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridQUOCGIA.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
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
        RadGridQUOCGIA.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridQUOCGIA.MasterTableView.RenderColumns)
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
        RadGridQUOCGIA.MasterTableView.Rebind();
    }
    protected void CheckCode(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        SelectSQL = "Select DMQUOCGIA.C_CODE FROM DMQUOCGIA WHERE DMQUOCGIA.C_CODE = '" + args.Value + "' AND DMQUOCGIA.PK_ID <> " + Session["txtID"].ToString();
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
        string SelectSQL = String.Format("Select DMQUOCGIA.C_NAME FROM DMQUOCGIA WHERE DMQUOCGIA.C_NAME = '{0}' AND DMQUOCGIA.PK_ID <> {1}", args.Value, Session["txtID"].ToString());
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
        RadGridQUOCGIA.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridQUOCGIA_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridQUOCGIA_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xóa quốc gia. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa quốc gia thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted QUOCGIA", e.Item.KeyValues);
        }
    }
    protected void RadGridQUOCGIA_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới quốc gia. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Tạo mới quốc gia thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted QUOCGIA", "{PK_ID:\"" + getmaxid("DMPHONGBAN") + "\"}");
        }
    }
    protected void RadGridQUOCGIA_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật quốc gia. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Cập nhật quốc gia thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated QUOCGIA", e.Item.KeyValues);
        }
    }
    protected void RadGridQUOCGIA_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadGrid grid = (RadGrid)sender;
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            HiddenField txtID = (HiddenField)editItem.FindControl("txtID");
            DropDownList ddlKhuvuc = (DropDownList)editItem.FindControl("ddlKhuvuc");
            Session["txtID"] = (txtID.Value != "") ? txtID.Value : "0";            
            if (e.Item.OwnerTableView.IsItemInserted)
            {
                if (Session["kvID"] != null)
                {
                    ddlKhuvuc.SelectedValue = Session["kvID"].ToString();
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
    protected void RadGridQUOCGIA_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridQUOCGIA.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridQUOCGIA.Rebind();
            }
            foreach (GridDataItem item in RadGridQUOCGIA.SelectedItems)
            {
                if (!ValidateDelete(item["pk_id"].Text))
                {
                    SetMessage(String.Format("Không thể xóa quốc gia \"{0}\" do có tham chiếu dữ liệu khác.", item["c_name"].Text));
                    RadGridQUOCGIA.Rebind();
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
    protected void RadGridQUOCGIA_ItemCreated(object sender, GridItemEventArgs e)
    {
    }
    protected void RadGridQUOCGIA_PreRender(object sender, EventArgs e)
    {

    }
    protected void lblcap_PreRender(object sender, EventArgs e)
    {
        Label titile = (Label)sender;
        if (Session["kvID"] != null)
        {
            titile.Text = ITCLIB.Admin.cFunction.getname(Session["kvID"].ToString(), "DMKHUVUC");
        }
        else { titile.Text = ""; }
    }
    protected void RadPanelBarListKHUVUC_ItemDataBound(object sender, RadPanelBarEventArgs e)
    {
        RadPanelItem item = (RadPanelItem)e.Item;
        item.ImageUrl = "../images/folder-closed.gif";
        item.SelectedImageUrl = "../images/folder_open.png";
    }
    protected void RadPanelBarListKHUVUC_ItemClick(object sender, RadPanelBarEventArgs e)
    {
        Session["kvID"] = RadPanelBarListKHUVUC.SelectedItem.Value;
        RadGridQUOCGIA.DataBind();
    }
    protected void RadPanelBarListKHUVUC_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["kvID"] = 0;
            RadPanelItem item = (RadPanelItem)RadPanelBarListKHUVUC.FindItemByValue("0");
            if (item != null)
            {
                item.Expanded = true;
                item.Selected = true;
            }
        }
    }
}