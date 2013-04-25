using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class module_DUANs : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridDUAN.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridDUAN.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridDUAN.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("DUANs"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        Session["LastUrl"] = Request.Url.ToString();
    }
    protected void btnShowAll_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadGridDUAN.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridDUAN.MasterTableView.RenderColumns)
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
        RadGridDUAN.MasterTableView.Rebind();
    }
    protected void CheckTENDUAN(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        Session["txtID"] = (Session["txtID"].ToString() == "") ? 0 : Session["txtID"];
        SelectSQL = "Select DUAN.TENDUAN FROM DUAN WHERE DUAN.TENDUAN = N'" + args.Value + "' AND DUAN.PK_ID <> " + Session["txtID"].ToString();
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
    protected void CheckMADUAN(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        Session["txtID"] = (Session["txtID"].ToString() == "") ? 0 : Session["txtID"];
        SelectSQL = "Select DUAN.MADUAN FROM DUAN WHERE DUAN.MADUAN = N'" + args.Value + "' AND DUAN.PK_ID <> " + Session["txtID"].ToString();
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
        RadGridDUAN.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridDUAN_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridDUAN_ItemDeleted(object sender, GridDeletedEventArgs e)
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
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted DUANs", e.Item.GetDataKeyValue("PK_ID").ToString());
        }
    }
    protected void RadGridDUAN_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        if (e.Exception != null)
        {
            //e.ExceptionHandled = true;
            //SetMessage("Không thể tạo mới dự án đầu tư phát triển. Lý do: " + e.Exception.Message);
        }
        else
        {
            //SetMessage("Tạo mới dự án đầu tư phát triển thành công!");
            //ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted DUANs", (e.Item.FindControl("txtTENDUAN") as TextBox).Text);
        }
    }
    protected void RadGridDUAN_ItemUpdated(object sender, GridUpdatedEventArgs e)
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
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated DUANs", e.Item.GetDataKeyValue("PK_ID").ToString());
        }
    }
    protected void RadGridDUAN_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridDUAN.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridDUAN.Rebind();
            }
            foreach (GridDataItem item in RadGridDUAN.SelectedItems)
            {
                if (!ValidateDeleteDUAN(item["PK_ID"].Text))
                {
                    SetMessage("Không thể xóa dự án đầu tư phát triển (ID: " + item["PK_ID"].Text + ")");
                    RadGridDUAN.Rebind();
                }
            }
        }
        if (e.CommandName == RadGrid.CancelCommandName)
        {
            DeleteExtGridDA();
        }
    }
    protected void RadGridDUAN_ItemDataBound(object sender, GridItemEventArgs e)
    {
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
    protected bool ValidateDeleteDUAN(string guID)
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
    protected void RadGridDUAN_ItemCreated(object sender, GridItemEventArgs e)
    {

    }
    protected void UpdateExtGridDA()
    {
        string UpdateSQL = "";
        if (Session["NEWIDVON"] != null)
        {
            UpdateSQL += "Update DUANVON set FK_DUAN = " + Session["IDDA"].ToString() + " WHERE PK_ID IN (" + Session["NEWIDVON"].ToString() + ");";
            Session["NEWIDVON"] = null;
        }       
        if (UpdateSQL != "")
        {
            ITCLIB.Admin.SQL rs = new ITCLIB.Admin.SQL();
            rs.ExecuteNonQuery(UpdateSQL);
        }
    }
    protected void DeleteExtGridDA()
    {
        string DeleteSQL = "";
        if (Session["NEWIDVON"] != null)
        {
            DeleteSQL += "Delete  FROM DUANVON WHERE PK_ID IN (" + Session["NEWIDVON"] + ");";
            Session["NEWIDVON"] = null;
        }        
        if (DeleteSQL != "")
        {
            ITCLIB.Admin.SQL rs = new ITCLIB.Admin.SQL();
            rs.ExecuteNonQuery(DeleteSQL);
        }
    }

    protected void DUANsDataSource_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            DeleteExtGridDA();
            SetMessage("Không thể tạo mới dự án. Lý do: " + e.Exception.Message);
        }
        else
        {
            Session["IDDA"] = e.Command.Parameters["@IDDA"].Value.ToString();
            UpdateExtGridDA();
            SetMessage("Tạo mới dự án thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted DUANs", Session["IDDA"].ToString());
        }
    }
}
