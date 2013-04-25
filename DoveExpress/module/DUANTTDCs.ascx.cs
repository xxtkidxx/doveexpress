using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class module_DUANTTDCs : System.Web.UI.UserControl
{
    public string TENDUAN = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridDUANTTDC.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridDUANTTDC.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridDUANTTDC.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("DUANs"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        if (Request.QueryString["daID"] != null)
        {
            TENDUAN = ITCLIB.Admin.cFunction.LoadFieldfromTable(Request.QueryString["daID"], "TENDUAN", "DUAN");
        }    
        Session["LastUrl"] = Request.Url.ToString();
    }
    protected void btnShowAll_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadGridDUANTTDC.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridDUANTTDC.MasterTableView.RenderColumns)
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
        RadGridDUANTTDC.MasterTableView.Rebind();
    }
    private void DisplayMessage(string text)
    {
        RadGridDUANTTDC.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridDUANTTDC_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridDUANTTDC_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xoá dự án đầu tư phát triển. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa dự án đầu tư phát triển thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted DUANTTDCs", e.Item.GetDataKeyValue("PK_ID").ToString());
        }
    }
    protected void RadGridDUANTTDC_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        if (e.Exception != null)
        {
            //e.ExceptionHandled = true;
            //SetMessage("Không thể tạo mới dự án đầu tư phát triển. Lý do: " + e.Exception.Message);
        }
        else
        {
            //SetMessage("Tạo mới dự án đầu tư phát triển thành công!");
            //ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted DUANTTDCs", (e.Item.FindControl("txtTENDUAN") as TextBox).Text);
        }
    }
    protected void RadGridDUANTTDC_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật dự án đầu tư phát triển. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Cập nhật dự án đầu tư phát triển thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated DUANTTDCs", e.Item.GetDataKeyValue("PK_ID").ToString());
        }
    }
    protected void RadGridDUANTTDC_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridDUANTTDC.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridDUANTTDC.Rebind();
            }
            foreach (GridDataItem item in RadGridDUANTTDC.SelectedItems)
            {
                if (!ValidateDeleteDUANTTDC(item["PK_ID"].Text))
                {
                    SetMessage("Không thể xóa dự án đầu tư phát triển (ID: " + item["PK_ID"].Text + ")");
                    RadGridDUANTTDC.Rebind();
                }
            }
        }
        if (e.CommandName == RadGrid.CancelCommandName)
        {
            DeleteExtGridDADC();
        }
    }
    protected void RadGridDUANTTDC_ItemDataBound(object sender, GridItemEventArgs e)
    {
        GridItem cmdItem = RadGridDUANTTDC.MasterTableView.GetItems(GridItemType.CommandItem)[0];
        Label lblTitle = (Label)cmdItem.FindControl("lblTitle");
        lblTitle.Text = TENDUAN + " - Quản lý điều chỉnh dự án";
        if (e.Item is GridDataItem)
        {
            Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
        }
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            RadComboBox cmbDoanhNghiep = (RadComboBox)editItem.FindControl("rcbParent");
            cmbDoanhNghiep.OnClientDropDownOpened = "OnClientDropDownOpenedHandler";
            cmbDoanhNghiep.OnClientLoad = "OnClientLoadDoanhNghiep";
            TextBox txtID = (TextBox)editItem.FindControl("txtID");
            Session["txtID"] = txtID.Text;
            TextBox txtTENDUAN = (TextBox)editItem.FindControl("txtTENDUAN");
            txtTENDUAN.Text = TENDUAN;
            HiddenField hfParent = (HiddenField)editItem.FindControl("hfParent");
            RadTreeView treDoanhNghiep = (RadTreeView)cmbDoanhNghiep.Items[0].FindControl("RadTreViewDir");
            treDoanhNghiep.ExpandAllNodes();
            RadTreeNode nodeselect = (RadTreeNode)treDoanhNghiep.FindNodeByValue(hfParent.Value);
            if (nodeselect != null)
            {
                cmbDoanhNghiep.Text = nodeselect.Text;
                cmbDoanhNghiep.SelectedValue = nodeselect.Value;
            }
        }
    }
    protected bool ValidateDeleteDUANTTDC(string guID)
    {
        /*if (guID == "0" || guID == "1")
        {
            return false;
        }
        else
        {
            string SelectSQL = "SELECT DUAN.PK_ID FROM DUAN WHERE DUAN.FK_User = " + guID;
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
    protected void UpdateExtGridDADC()
    {
        string UpdateSQL = "";
        if (Session["NEWIDDCVON"] != null)
        {
            UpdateSQL += "Update DUANDIEUCHINHVON set FK_DUAN = " + Session["IDDADC"].ToString() + " WHERE PK_ID IN (" + Session["NEWIDDCVON"].ToString() + ");";
            Session["NEWIDDCVON"] = null;
        }
        if (UpdateSQL != "")
        {
            ITCLIB.Admin.SQL rs = new ITCLIB.Admin.SQL();
            rs.ExecuteNonQuery(UpdateSQL);
        }
    }
    protected void DeleteExtGridDADC()
    {
        string DeleteSQL = "";
        if (Session["NEWIDDCVON"] != null)
        {
            DeleteSQL += "Delete  FROM DUANDIEUCHINHVON WHERE PK_ID IN (" + Session["NEWIDDCVON"] + ");";
            Session["NEWIDDCVON"] = null;
        }
        if (DeleteSQL != "")
        {
            ITCLIB.Admin.SQL rs = new ITCLIB.Admin.SQL();
            rs.ExecuteNonQuery(DeleteSQL);
        }
    }
    protected void DUANTTDCsDataSource_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            DeleteExtGridDADC();
            SetMessage("Không thể tạo mới điều chỉnh dự án. Lý do: " + e.Exception.Message);
        }
        else
        {
            Session["IDDADC"] = e.Command.Parameters["@IDDADC"].Value.ToString();
            UpdateExtGridDADC();
            SetMessage("Tạo mới điều chỉnh dự án thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted DUANs DC", Session["IDDADC"].ToString());
        }
    }
}
