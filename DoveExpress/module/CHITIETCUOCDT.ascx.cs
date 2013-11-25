using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class module_CHITIETCUOCDT : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridCHITIETCUOCDT.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridCHITIETCUOCDT.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridCHITIETCUOCDT.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("BANGCUOC"))
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
            UpdateDefault(arrayvalue[1], arrayvalue[2], arrayvalue[3]);
            string script = string.Format("var result = '{0}'", "SelectedCTC-,-" + arrayvalue[2]);
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
        }
        else if (arrayvalue[0] == "SelectedCTC1")
        {
            UpdateDefault1(arrayvalue[1], arrayvalue[2], arrayvalue[3]);
            string script = string.Format("var result = '{0}'", "SelectedCTC1-,-" + arrayvalue[2]);
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
        }
        else if (arrayvalue[0] == "PPXDVALUE")
        {
            string FK_MASANPHAM = cmbSanPham.SelectedValue;
            string FK_DOITAC = cmbDoiTac.SelectedValue;
            string SelectSQL;
            string PPXD;
            SelectSQL = "Select DMPPXDDT.C_PPXD FROM DMPPXDDT WHERE DMPPXDDT.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_DOITAC = " + FK_DOITAC;
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
            string LOAITIEN = "0";
            if (arrayvalue[1] == "1")
            {
                string SelectSQL1;
                SelectSQL1 = "Select DMMASANPHAM.C_TYPE FROM DMMASANPHAM WHERE DMMASANPHAM.PK_ID =" + FK_MASANPHAM;
                DataTable oDataTable1 = new DataTable();
                ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
                oDataTable1 = SelectQuery1.query_data(SelectSQL1);
                if (oDataTable1.Rows.Count != 0)
                {
                    LOAITIEN = oDataTable1.Rows[0]["C_TYPE"].ToString();
                }               
            }
            string script = string.Format("var result = '{0}'", "PPXDVALUE-,-" + PPXD + "-,-" + LOAITIEN);
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
        }
    }
    protected void UpdateDefault(string ID, string FK_MAVUNG, string C_TYPE)
    {
        ITCLIB.Admin.SQL rs = new ITCLIB.Admin.SQL();
        string Querry = "";
        if (C_TYPE == "1")
        {
            Querry = "Update DMCHITIETCUOCDT set C_TYPE = 0 WHERE PK_ID =" + ID + ";Update DMCHITIETCUOCDT set C_TYPE = 0 WHERE PK_ID <>" + ID + " AND FK_MAVUNG = " + FK_MAVUNG + " AND FK_DOITAC =" + cmbDoiTac.SelectedValue + " AND FK_MASANPHAM=" + cmbSanPham.SelectedValue + " AND C_LOAITIEN ='" + cmbLoaiTien.SelectedValue + "'";
        }
        else if (C_TYPE == "0")
        {
            Querry = "Update DMCHITIETCUOCDT set C_TYPE = 1 WHERE PK_ID =" + ID + ";Update DMCHITIETCUOCDT set C_TYPE = 0 WHERE PK_ID <>" + ID + " AND FK_MAVUNG = " + FK_MAVUNG + " AND FK_DOITAC =" + cmbDoiTac.SelectedValue + " AND FK_MASANPHAM=" + cmbSanPham.SelectedValue + " AND C_LOAITIEN ='" + cmbLoaiTien.SelectedValue + "'";
        }
        rs.ExecuteNonQuery(Querry);
    }
    protected void UpdateDefault1(string ID, string FK_MAVUNG, string C_TYPE1)
    {
        ITCLIB.Admin.SQL rs = new ITCLIB.Admin.SQL();
        string Querry = "";
        if (C_TYPE1 == "1")
        {
            Querry = "Update DMCHITIETCUOCDT set C_TYPE1 = 0 WHERE PK_ID =" + ID;
        }
        else if (C_TYPE1 == "0")
        {
            Querry = "Update DMCHITIETCUOCDT set C_TYPE1 = 1 WHERE PK_ID =" + ID;
        }
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
        RadGridCHITIETCUOCDT.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridCHITIETCUOCDT_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridCHITIETCUOCDT_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridCHITIETCUOCDT.SelectedIndexes.Count == 0)
            {
                DisplayMessage("Không có bản ghi được chọn!");
                RadGridCHITIETCUOCDT.Rebind();
            }
        }
        else if (e.CommandName == RadGrid.PerformInsertCommandName)
        {
            if ("TableViewCHITIETCUOCDT".Equals(e.Item.OwnerTableView.Name))
            {
                GridDataItem parentItem = (GridDataItem)e.Item.OwnerTableView.ParentItem;
                CHITIETCUOCDTDataSource.InsertParameters["FK_MAVUNG"].DefaultValue = parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["PK_ID"].ToString();
            }
        }
        else if (e.CommandName == RadGrid.UpdateCommandName)
        {

        }
        else if (e.CommandName == RadGrid.ExpandCollapseCommandName)
        {

        }
    }
    protected void RadGridCHITIETCUOCDT_ItemUpdated(object sender, GridUpdatedEventArgs e)
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
        else if ("TableViewCHITIETCUOCDT".Equals(e.Item.OwnerTableView.Name))
        {
            if (e.AffectedRows > 0)
            {
                SetMessage("Cập nhật bảng cước thành công!");
                ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Update CHITIETCUOCDTs", e.Item.KeyValues);
            }
            else
            {
                SetMessage("Cập nhật không thành công!");
            }
        }
    }
    protected void RadGridCHITIETCUOCDT_ItemDeleted(object sender, GridDeletedEventArgs e)
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
        else if ("TableViewCHITIETCUOCDT".Equals(e.Item.OwnerTableView.Name))
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                SetMessage("Không thể xóa bảng cước. Lý do: " + e.Exception.Message);
            }
            else
            {
                SetMessage("Xóa bảng cước thành công!");
                ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted CHITIETCUOCDT", e.Item.KeyValues);
            }
        }
    }
    protected void MAVUNGDeleteing(string pkID)
    {
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL acess = new ITCLIB.Admin.SQL();
        string sqldeleteItem = String.Format("Delete from DMCHITIETCUOCDT where FK_MAVUNG= {0}", pkID);
        acess.ExecuteNonQuery(sqldeleteItem);
    }
    protected void RadGridCHITIETCUOCDT_ItemInserted(object sender, GridInsertedEventArgs e)
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
        else if ("TableViewCHITIETCUOCDT".Equals(e.Item.OwnerTableView.Name))
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                SetMessage("Không thể tạo mới bảng cước. Lý do: " + e.Exception.Message);
            }
            else
            {
                SetMessage("Tạo mới bảng cước thành công!");
                ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted CHITIETCUOCDT", "{PK_ID:\"" + getmaxid("DMCHITIETCUOCDT") + "\"}");
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
    protected void RadGridCHITIETCUOCDT_ItemCreated(object sender, GridItemEventArgs e)
    {

    }
    protected void RadGridCHITIETCUOCDT_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "MasterTableViewMAVUNG")
        {
            Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
        }
    }
    protected void cmbDoiTac_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (cmbDoiTac.Items.Count != 0)
            {
                string SelectSQL = "SELECT PK_ID FROM DMDoiTac WHERE C_DEFAULT = 1";
                DataTable oDataTable = new DataTable();
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                oDataTable = SelectQuery.query_data(SelectSQL);
                if (oDataTable.Rows.Count != 0)
                {
                    cmbDoiTac.SelectedValue = oDataTable.Rows[0]["PK_ID"].ToString();
                }
                else
                {
                    cmbDoiTac.SelectedIndex = 0;
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
        string FK_DOITAC = cmbDoiTac.SelectedValue;
        decimal C_PPXD = (txtC_PPXD.Text != "") ? decimal.Parse(txtC_PPXD.Text) : 0;
        string SQL;
        string SelectSQL;
        if (FK_MASANPHAM != "" && FK_DOITAC != "")
        {
            SelectSQL = "Select DMPPXDDT.C_PPXD FROM DMPPXDDT WHERE DMPPXDDT.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_DOITAC = " + FK_DOITAC;
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                SQL = "Update DMPPXDDT set C_PPXD = " + C_PPXD + " WHERE DMPPXDDT.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_DOITAC = " + FK_DOITAC;
            }
            else
            {
                SQL = "Insert into DMPPXDDT (FK_MASANPHAM,FK_DOITAC,C_PPXD) VALUES (" + FK_MASANPHAM + "," + FK_DOITAC + "," + C_PPXD + ")";
            }
            SelectQuery.ExecuteNonQuery(SQL);
        }
    }
}