using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class module_KHACHHANG : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridKHACHHANG.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridKHACHHANG.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridKHACHHANG.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("KHACHHANG"))
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
        RadGridKHACHHANG.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridKHACHHANG.MasterTableView.RenderColumns)
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
        RadGridKHACHHANG.MasterTableView.Rebind();
    }
    protected void CheckCode(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        SelectSQL = "Select DMKHACHHANG.C_CODE FROM DMKHACHHANG WHERE DMKHACHHANG.C_CODE = '" + args.Value + "' AND DMKHACHHANG.PK_ID <> " + Session["txtID"].ToString();
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
        SelectSQL = "Select DMKHACHHANG.C_NAME FROM DMKHACHHANG WHERE DMKHACHHANG.C_NAME = '" + args.Value + "' AND DMKHACHHANG.PK_ID <> " + Session["txtID"].ToString();
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
        RadGridKHACHHANG.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridKHACHHANG_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridKHACHHANG_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xóa khách hàng. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa khách hàng thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted KHACHHANGs", e.Item.KeyValues);
        }
    }
    protected void RadGridKHACHHANG_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới khách hàng. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Tạo mới khách hàng thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted KHACHHANGs", "{PK_ID:\"" + getmaxid("DMKHACHHANG") + "\"}");
        }
    }
    protected void RadGridKHACHHANG_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật khách hàng. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Cập nhật khách hàng thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated KHACHHANGs", e.Item.KeyValues);
        }
    }
    protected void RadGridKHACHHANG_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadGrid grid = (RadGrid)sender;
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            HiddenField txtID = (HiddenField)editItem.FindControl("txtID");
            Session["txtID"] = (txtID.Value != "") ? txtID.Value : "0";
            HiddenField hfQuocGia = (HiddenField)editItem.FindControl("hfQuocGia");
            HiddenField hfTinhThanh = (HiddenField)editItem.FindControl("hfTinhThanh");
            HiddenField hfQuanHuyen = (HiddenField)editItem.FindControl("hfQuanHuyen");
            QUANHUYENDataSource.SelectCommand = LoadFilteredQuanHuyenManually(hfQuanHuyen.Value);
            RadComboBox cmbQuocGia = (RadComboBox)editItem.FindControl("cmbQuocGia");
            RadComboBox cmbTinhThanh = (RadComboBox)editItem.FindControl("cmbTinhThanh");
            RadComboBox cmbQuanHuyen = (RadComboBox)editItem.FindControl("cmbQuanHuyen");            
            cmbQuocGia.DataBind();
            cmbQuocGia.SelectedValue = hfQuocGia.Value;
            TINHTHANHDataSource.SelectCommand = LoadFilteredTinhThanhManually(hfQuocGia.Value);
            cmbTinhThanh.DataBind();
            cmbTinhThanh.SelectedValue = hfTinhThanh.Value;
            QUANHUYENDataSource.SelectCommand = LoadFilteredQuanHuyenManually(hfTinhThanh.Value);
            cmbQuanHuyen.DataBind();
            cmbQuanHuyen.SelectedValue = hfQuanHuyen.Value;
            if (e.Item is GridEditFormInsertItem || e.Item is GridDataInsertItem)
            {
                // insert item
                RadComboBox cmbFK_NHOMKHACHHANG = (RadComboBox)editItem.FindControl("cmbFK_NHOMKHACHHANG");
                cmbFK_NHOMKHACHHANG.SelectedIndex = 0;
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
    protected void RadGridKHACHHANG_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridKHACHHANG.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridKHACHHANG.Rebind();
            }
            foreach (GridDataItem item in RadGridKHACHHANG.SelectedItems)
            {
                if (!ValidateDeleteGroup(item["pk_id"].Text))
                {
                    SetMessage("Không thể xóa khách hàng \"" + item["c_name"].Text + "\" do có tham chiếu dữ liệu khác.");
                    RadGridKHACHHANG.Rebind();
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
    protected void RadGridKHACHHANG_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            RadComboBox cmbQuocGia = (RadComboBox)editItem.FindControl("cmbQuocGia");
            cmbQuocGia.OnClientSelectedIndexChanged = "cmbQuocGiaClientSelectedIndexChangedHandler";
            RadComboBox cmbTinhThanh = (RadComboBox)editItem.FindControl("cmbTinhThanh");
            cmbTinhThanh.OnClientLoad = "OnClientLoadTinhThanh";
            cmbTinhThanh.OnClientItemsRequested = "ItemsLoadedTinhThanh";
            cmbTinhThanh.OnClientSelectedIndexChanged = "cmbTinhThanhClientSelectedIndexChangedHandler";
            cmbTinhThanh.ItemsRequested += new RadComboBoxItemsRequestedEventHandler(cmbTinhThanh_ItemsRequested);
            RadComboBox cmbQuanHuyen = (RadComboBox)editItem.FindControl("cmbQuanHuyen");
            cmbQuanHuyen.OnClientLoad = "OnClientLoadQuanHuyen";
            cmbQuanHuyen.OnClientItemsRequested = "ItemsLoadedQuanHuyen";
            cmbQuanHuyen.OnClientSelectedIndexChanged = "cmbQuanHuyenClientSelectedIndexChangedHandler";
            cmbQuanHuyen.ItemsRequested += new RadComboBoxItemsRequestedEventHandler(cmbQuanHuyen_ItemsRequested);
        }
    }
    protected void cmbTinhThanh_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        RadComboBox cmbTinhThanh = (RadComboBox)sender;
        TINHTHANHDataSource.SelectCommand = LoadFilteredTinhThanhManually(e.Text);
        cmbTinhThanh.DataBind();
    }
    protected void cmbQuanHuyen_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        RadComboBox cmbQuanHuyen = (RadComboBox)sender;
        QUANHUYENDataSource.SelectCommand = LoadFilteredQuanHuyenManually(e.Text);
        cmbQuanHuyen.DataBind();
    }
    protected string LoadFilteredTinhThanhManually(string ID)
    {
        string SelectSQL = "";
        if (ID != "")
        {
            SelectSQL = "SELECT * FROM DMTINHTHANH WHERE FK_QUOCGIA = " + ID + "order by C_NAME";
        }
        else
        {
            SelectSQL = "SELECT * FROM DMTINHTHANH order by C_NAME";
        }
        return SelectSQL;
    }
    protected string LoadFilteredQuanHuyenManually(string ID)
    {
        string SelectSQL = "";
        if (ID != "")
        {
            SelectSQL = "SELECT * FROM DMQUANHUYEN WHERE FK_TINHTHANH = " + ID + " order by C_NAME";
        }
        else
        {
            SelectSQL = "SELECT * FROM DMQUANHUYEN order by C_NAME";
        }
        return SelectSQL;
    }
}