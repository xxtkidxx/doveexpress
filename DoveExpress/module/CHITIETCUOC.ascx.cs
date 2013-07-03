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
        RadAjaxManager ajaxManager = RadAjaxManager.GetCurrent(Page);
        ajaxManager.AjaxRequest += new RadAjaxControl.AjaxRequestDelegate(RadScriptManager_AjaxRequestCTC);
        ajaxManager.ClientEvents.OnResponseEnd = "onResponseEndCTC";
        Session["LastUrl"] = Request.Url.ToString();
    }
    protected void RadScriptManager_AjaxRequestCTC(object sender, AjaxRequestEventArgs e)
    {
        string[] arrayvalue = e.Argument.Split(',');
        if (arrayvalue[0] == "SelectedCTC")
        {
            UpdateDefault(arrayvalue[1], arrayvalue[2]);
            string script = string.Format("var result = '{0}'", "SelectedCTC," + arrayvalue[2]);
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);           
        }
        else if (arrayvalue[0] == "PPXDVALUE")
        {
            string FK_MASANPHAM = cmbSanPham.SelectedValue;
            string FK_MABANGCUOC = cmbMaBangCuoc.SelectedValue;
            string SelectSQL;
            string PPXD;
            SelectSQL = "Select DMPPXD.C_PPXD FROM DMPPXD WHERE DMPPXD.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_MABANGCUOC = " + FK_MABANGCUOC;
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                PPXD = oDataTable.Rows[0]["C_PPXD"].ToString();
            }
            else
            {
                PPXD = "0";
            }
            string script = string.Format("var result = '{0}'", "PPXDVALUE," + PPXD);
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);     
        }
    }
    protected void UpdateDefault(string ID,string FK_MAVUNG)
    {
        ITCLIB.Admin.SQL rs = new ITCLIB.Admin.SQL();
        string Querry = "Update DMCHITIETCUOC set C_TYPE = 1 WHERE PK_ID =" + ID + ";Update DMCHITIETCUOC set C_TYPE = 0 WHERE PK_ID <>" + ID + " AND FK_MAVUNG = " + FK_MAVUNG + " AND FK_MABANGCUOC=" + cmbMaBangCuoc.SelectedValue + " AND FK_MASANPHAM=" + cmbSanPham.SelectedValue + " AND C_LOAITIEN ='" + cmbLoaiTien.SelectedValue +"'";
        rs.ExecuteNonQuery(Querry);
    }
    protected bool getstatus(object status)
    {
        if (status == DBNull.Value)
        { return false; }
        else
        {
            int test = (int)status;
            if (test == 1)
            { return true; }
            else { return false; }
        }
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
                ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated MAVUNG", e.Item.KeyValues);
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
                ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted MAVUNG", "{PK_ID:\"" + e.Item.KeyValues);
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
                ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted MAVUNG", "{PK_ID:\"" + getmaxid("DMMAVUNG") + "\"}");
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
                ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted CHITIETCUOC", "{PK_ID:\"" + getmaxid("DMCHITIETCUOC") + "\"}");
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
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string FK_MASANPHAM = cmbSanPham.SelectedValue;
        string FK_MABANGCUOC = cmbMaBangCuoc.SelectedValue;
        decimal C_PPXD = (txtC_PPXD.Text != "") ? decimal.Parse(txtC_PPXD.Text) : 0;
        string SQL;
        string SelectSQL;
        if (FK_MASANPHAM != "" && FK_MABANGCUOC != "")
        {
            SelectSQL = "Select DMPPXD.C_PPXD FROM DMPPXD WHERE DMPPXD.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_MABANGCUOC = " + FK_MABANGCUOC;
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                SQL = "Update DMPPXD set C_PPXD = " + C_PPXD + " WHERE DMPPXD.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_MABANGCUOC = " + FK_MABANGCUOC;
            }
            else
            {
                SQL = "Insert into DMPPXD (FK_MASANPHAM,FK_MABANGCUOC,C_PPXD) VALUES (" + FK_MASANPHAM + "," + FK_MABANGCUOC + "," + C_PPXD + ")";
            }
            SelectQuery.ExecuteNonQuery(SQL);
        }
    }
}