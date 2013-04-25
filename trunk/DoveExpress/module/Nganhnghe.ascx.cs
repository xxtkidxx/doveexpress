using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;

public partial class module_Nganhnghe : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridNganhnghes.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridNganhnghes.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridNganhnghes.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
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
        RadGridNganhnghes.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridNganhnghes.MasterTableView.RenderColumns)
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
        RadGridNganhnghes.MasterTableView.Rebind();
    }

    protected void CheckCode(object source, ServerValidateEventArgs args)
    {
        string SelectSQL = String.Format("Select DMNGANHNGHEKD.C_CODE FROM DMNGANHNGHEKD WHERE DMNGANHNGHEKD.C_CODE = '{0}' AND DMNGANHNGHEKD.PK_ID <> {1}", args.Value, Session["txtID"]);
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
    protected void CheckLenCode(object source, ServerValidateEventArgs args)
    {
        if (args.Value.Trim().Length >5 )
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
        RadGridNganhnghes.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridNganhnghes_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridNganhnghes_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xóa ngành nghề kinh doanh. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa ngành nghề kinh doanh thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted Nganhnghe", e.Item.KeyValues);
        }
    }
    protected void RadGridNganhnghes_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới ngành nghề kinh doanh. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Tạo mới ngành nghề kinh doanh thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted Nganhnghe", "{PK_ID:\"" + getmaxid("DMNGANHNGHEKD") + "\"}");
        }
    }
    protected void RadGridNganhnghes_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật ngành nghề kinh doanh. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Cập nhật ngành nghề kinh doanh thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated Nganhnghe", e.Item.KeyValues);
        }
    }
    protected void RadGridNganhnghes_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadGrid grid = (RadGrid)sender;
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            HiddenField txtID = (HiddenField)editItem.FindControl("txtID");
            Session["txtID"] = (txtID.Value != "") ? txtID.Value : "0";
        }
        if (e.Item is GridDataItem)
        {
            Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
        }
    }
    protected void RadGridNganhnghes_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridNganhnghes.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridNganhnghes.Rebind();
            }
            foreach (GridDataItem item in RadGridNganhnghes.SelectedItems)
            {
                if (!ValidateDeleteGroup(item["pk_id"].Text))
                {
                    SetMessage(String.Format("Không thể xóa ngành nghề kinh doanh \"{0}\" do có tham chiếu dữ liệu khác.", item["c_name"].Text));
                    RadGridNganhnghes.Rebind();
                }
            }
        }
        else if (e.CommandName == RadGrid.PerformInsertCommandName)
        {
            GridEditableItem edititem = (GridEditableItem)e.Item;
        }

        else if (e.CommandName == RadGrid.UpdateCommandName)
        {
            GridEditableItem edititem = (GridEditableItem)e.Item;
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
    protected bool ValidateDeleteGroup(string pkID)
    {
        int rowcount = 0;
        string SelectSQL1 = String.Format("SELECT PK_ID FROM DOANHNGHIEP WHERE FK_NGANHSXKD_MAIN = {0} OR  FK_NGANHSXKD_1 = {0} OR  FK_NGANHSXKD_2 = {0} OR  FK_NGANHSXKD_3 = {0} OR  FK_NGANHSXKD_4 = {0} OR  FK_NGANHSXKD_5 = {0}", pkID);
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(String.Format("{0}", SelectSQL1));
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
    protected void lblcap_PreRender(object sender, EventArgs e)
    {
        Label titile = (Label)sender;
        if (rcbParent.Text != "Tất cả" && rcbParent.SelectedValue !="")
        {
            titile.Text = "DANH MỤC CHI TIẾT NỘI DUNG NGÀNH, NGHỀ XẾP MÃ NGÀNH "+ rcbParent.Text.ToUpper();
        }
        else { titile.Text = "DANH MỤC CHI TIẾT NỘI DUNG NGÀNH, NGHỀ KINH DOANH"; }
    }
}