using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class module_CHITIETCUOC : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridCHITIETCUOC.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridCHITIETCUOC.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridCHITIETCUOC.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("DANHMUCCHUNG"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        if (!IsPostBack)
        {
        }
        //ITCLIB.Admin.JavaScript.RunScript("CancelEdit()", this);
        Session["LastUrl"] = Request.Url.ToString();
    }
    private void DisplayMessage(string text)
    {
        RadGridCHITIETCUOC.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridCHITIETCUOC_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridCHITIETCUOC_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridCHITIETCUOC.SelectedIndexes.Count == 0)
            {
                DisplayMessage("Không có bản ghi được chọn!");
                RadGridCHITIETCUOC.Rebind();
            }
        }
        else if (e.CommandName == RadGrid.PerformInsertCommandName)
        {
            if ("TableViewCHITIETCUOC".Equals(e.Item.OwnerTableView.Name))
            {
                GridDataItem parentItem = (GridDataItem)e.Item.OwnerTableView.ParentItem;
                CHITIETCUOCDataSource.InsertParameters["FK_MAVUNG"].DefaultValue = parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["PK_ID"].ToString();
            }
        }
        else if (e.CommandName == RadGrid.UpdateCommandName)
        {
            
        }
        else if (e.CommandName == RadGrid.ExpandCollapseCommandName)
        {

        }
    }
    protected void RadGridCHITIETCUOC_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        if ("MasterTableViewMAVUNG".Equals(e.Item.OwnerTableView.Name))
        {
            if (e.Exception != null)
            {
                e.KeepInEditMode = true;
                e.ExceptionHandled = true;
                DisplayMessage("Không thể cập nhật vùng tính cước. Lý do: " + e.Exception.Message);
            }
            else
            {
                DisplayMessage("Cập nhật vùng tính cước thành công!");
                ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated MABANGCUOC", e.Item.KeyValues);
            }
        }
        else if ("TableViewCHITIETCUOC".Equals(e.Item.OwnerTableView.Name))
        {
            if (e.AffectedRows > 0)
            {
                SetMessage("Cập nhật bảng cước thành công!");
                ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Update CHITIETCUOCs", e.Item.KeyValues);
            }
            else
            {
                SetMessage("Cập nhật không thành công!");
            }
        }        
    }
    protected void RadGridCHITIETCUOC_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if ("MasterTableViewMAVUNG".Equals(e.Item.OwnerTableView.Name))
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                DisplayMessage("Không thể xoá vùng tính cước. Lý do: " + e.Exception.Message);
            }
            else
            {
                MAVUNGDeleteing(e.Item["PK_ID"].Text);
                DisplayMessage("Xoá vùng tính cước thành công!");
                ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted MABANGCUOC", "{PK_ID:\"" + e.Item.KeyValues);
            }
        }
        else if ("TableViewCHITIETCUOC".Equals(e.Item.OwnerTableView.Name))
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                SetMessage("Không thể xóa bảng cước. Lý do: " + e.Exception.Message);
            }
            else
            {
                SetMessage("Xóa bảng cước thành công!");
                ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted CHITIETCUOC", e.Item.KeyValues);
            }
        }      
    }
    protected void MAVUNGDeleteing(string pkID)
    {
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL acess = new ITCLIB.Admin.SQL();
        string sqldeleteItem = String.Format("Delete from DMCHITIETCUOC where FK_MAVUNG= {0}", pkID);
        acess.ExecuteNonQuery(sqldeleteItem);
    }
    protected void RadGridCHITIETCUOC_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if ("MasterTableViewMAVUNG".Equals(e.Item.OwnerTableView.Name))
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                DisplayMessage("Không thể thêm vùng tính cước. Lý do: " + e.Exception.Message);
            }
            else
            {
                DisplayMessage("Thêm vùng tính cước thành công!");
                ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted MABANGCUOC", "{PK_ID:\"" + getmaxid("MABANGCUOC") + "\"}");
            }
        }
        else if ("TableViewCHITIETCUOC".Equals(e.Item.OwnerTableView.Name))
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                SetMessage("Không thể tạo mới bảng cước. Lý do: " + e.Exception.Message);
            }
            else
            {
                SetMessage("Tạo mới bảng cước thành công!");
                ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted KHACHHANGs", "{PK_ID:\"" + getmaxid("DMBANGCUOC") + "\"}");
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
    protected void RadGridCHITIETCUOC_ItemCreated(object sender, GridItemEventArgs e)
    {

    }
    protected void RadGridCHITIETCUOC_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "MasterTableViewMAVUNG")
        {
            Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
        }
    }
    protected void cmbMaBangCuoc_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (cmbMaBangCuoc.Items.Count != 0)
            {
                string SelectSQL = "SELECT PK_ID FROM DMMABANGCUOC WHERE C_DEFAULT = 1";
                DataTable oDataTable = new DataTable();
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                oDataTable = SelectQuery.query_data(SelectSQL);
                if (oDataTable.Rows.Count != 0)
                {
                    cmbMaBangCuoc.SelectedValue = oDataTable.Rows[0]["PK_ID"].ToString();
                }
                else
                {
                    cmbMaBangCuoc.SelectedIndex = 0;
                }
                
            }
        }        
    }
    protected void cmbSanPham_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (cmbSanPham.Items.Count != 0)
            {
                //cmbSanPham.SelectedIndex = 0;
            }
        }       
    }
    protected void cmbLoaiTien_PreRender(object sender, EventArgs e)
    {
        if (cmbLoaiTien.Items.Count != 0)
        {
            cmbLoaiTien.SelectedIndex = 0;
        }
    }
}