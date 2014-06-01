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
            string script = string.Format("var result = '{0}'", "SelectedCTC,-," + arrayvalue[2]);
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
        }
        else if (arrayvalue[0] == "SelectedCTC1")
        {
            UpdateDefault1(arrayvalue[1], arrayvalue[2], arrayvalue[3]);
            string script = string.Format("var result = '{0}'", "SelectedCTC1,-," + arrayvalue[2]);
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
        }
        else if (arrayvalue[0] == "PTVALUE")
        {
            string FK_MASANPHAM = cmbSanPham.SelectedValue;
            string FK_MABANGCUOC = cmbMaBangCuoc.SelectedValue;
            string SelectSQL;
            string PPXD = "0";
            string VAT = "0";
            string DONGGOIX = "0"; string DONGGOIY = "0";
            string KHAIGIAX = "0"; string KHAIGIAY = "0";
            string BAOPHATX = "0"; string BAOPHATY = "0";
            string HENGIOX = "0"; string HENGIOY = "0";
            string HAIQUANX = "0"; string HAIQUANY = "0";
            string HUNTRUNGX = "0"; string HUNTRUNGY = "0";
            SelectSQL = "Select DMDICHVUPHUTROI.C_VALUE,DMDICHVUPHUTROI.C_VALUE1,DMDICHVUPHUTROI.C_TYPE FROM DMDICHVUPHUTROI WHERE DMDICHVUPHUTROI.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_MABANGCUOC = " + FK_MABANGCUOC;
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                for (int i = 0; i <= oDataTable.Rows.Count - 1; i++)
                {
                    if (oDataTable.Rows[i]["C_TYPE"].ToString() == "PPXD")
                    {
                        PPXD = oDataTable.Rows[i]["C_VALUE"].ToString();
                    }
                    else if (oDataTable.Rows[i]["C_TYPE"].ToString() == "VAT")
                    {
                        VAT = oDataTable.Rows[i]["C_VALUE"].ToString();
                    }
                    else if (oDataTable.Rows[i]["C_TYPE"].ToString() == "DONGGOI")
                    {
                        DONGGOIX = oDataTable.Rows[i]["C_VALUE"].ToString();
                        DONGGOIY = oDataTable.Rows[i]["C_VALUE1"].ToString();
                    }
                    else if (oDataTable.Rows[i]["C_TYPE"].ToString() == "KHAIGIA")
                    {
                        KHAIGIAX = oDataTable.Rows[i]["C_VALUE"].ToString();
                        KHAIGIAY = oDataTable.Rows[i]["C_VALUE1"].ToString();
                    }
                    else if (oDataTable.Rows[i]["C_TYPE"].ToString() == "BAOPHAT")
                    {
                        BAOPHATX = oDataTable.Rows[i]["C_VALUE"].ToString();
                        BAOPHATY = oDataTable.Rows[i]["C_VALUE1"].ToString();
                    }
                    else if (oDataTable.Rows[i]["C_TYPE"].ToString() == "HENGIO")
                    {
                        HENGIOX = oDataTable.Rows[i]["C_VALUE"].ToString();
                        HENGIOY = oDataTable.Rows[i]["C_VALUE1"].ToString();
                    }
                    else if (oDataTable.Rows[i]["C_TYPE"].ToString() == "HAIQUAN")
                    {
                        HAIQUANX = oDataTable.Rows[i]["C_VALUE"].ToString();
                        HAIQUANY = oDataTable.Rows[i]["C_VALUE1"].ToString();
                    }
                    else if (oDataTable.Rows[i]["C_TYPE"].ToString() == "HUNTRUNG")
                    {
                        HUNTRUNGX = oDataTable.Rows[i]["C_VALUE"].ToString();
                        HUNTRUNGY = oDataTable.Rows[i]["C_VALUE1"].ToString();
                    }
                }
            }
            string script = string.Format("var result = '{0}'", "PTVALUE,-," + PPXD + ",-," + VAT + ",-," + DONGGOIX + ",-," + DONGGOIY + ",-," + KHAIGIAX + ",-," + KHAIGIAY + ",-," + BAOPHATX + ",-," + BAOPHATY + ",-," + HENGIOX + ",-," + HENGIOY + ",-," + HAIQUANX + ",-," + HAIQUANY + ",-," + HUNTRUNGX + ",-," + HUNTRUNGY);
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
        }
    }
    protected void UpdateDefault(string ID, string FK_MAVUNG, string C_TYPE)
    {
        ITCLIB.Admin.SQL rs = new ITCLIB.Admin.SQL();
        string Querry = "";
        if (C_TYPE == "1")
        {
            Querry = "Update DMCHITIETCUOC set C_TYPE = 0 WHERE PK_ID =" + ID + ";Update DMCHITIETCUOC set C_TYPE = 0 WHERE PK_ID <>" + ID + " AND FK_MAVUNG = " + FK_MAVUNG + " AND FK_MABANGCUOC=" + cmbMaBangCuoc.SelectedValue + " AND FK_MASANPHAM=" + cmbSanPham.SelectedValue + " AND C_LOAITIEN ='" + cmbLoaiTien.SelectedValue + "'";
        }
        else if (C_TYPE == "0")
        {
            Querry = "Update DMCHITIETCUOC set C_TYPE = 1 WHERE PK_ID =" + ID + ";Update DMCHITIETCUOC set C_TYPE = 0 WHERE PK_ID <>" + ID + " AND FK_MAVUNG = " + FK_MAVUNG + " AND FK_MABANGCUOC=" + cmbMaBangCuoc.SelectedValue + " AND FK_MASANPHAM=" + cmbSanPham.SelectedValue + " AND C_LOAITIEN ='" + cmbLoaiTien.SelectedValue + "'";
        }
        rs.ExecuteNonQuery(Querry);
    }
    protected void UpdateDefault1(string ID, string FK_MAVUNG, string C_TYPE1)
    {
        ITCLIB.Admin.SQL rs = new ITCLIB.Admin.SQL();
        string Querry = "";
        if (C_TYPE1 == "1")
        {
            Querry = "Update DMCHITIETCUOC set C_TYPE1 = 0 WHERE PK_ID =" + ID;
        }
        else if (C_TYPE1 == "0")
        {
            Querry = "Update DMCHITIETCUOC set C_TYPE1 = 1 WHERE PK_ID =" + ID;
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
        else if (e.CommandName == RadGrid.UpdateEditedCommandName)
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
                string FK_MABANGCUOC = cmbMaBangCuoc.SelectedValue;
                if (e.Item is GridEditableItem && e.Item.IsInEditMode)
                {
                    GridEditableItem editItem = e.Item as GridEditableItem;
                    RadNumericTextBox txtC_CODX = (RadNumericTextBox)editItem.FindControl("txtC_CODX");
                    RadNumericTextBox txtC_CODY = (RadNumericTextBox)editItem.FindControl("txtC_CODY");
                    decimal C_CODX = (txtC_CODX.Text != "") ? decimal.Parse(txtC_CODX.Text) : 0;
                    decimal C_CODY = (txtC_CODY.Text != "") ? decimal.Parse(txtC_CODY.Text) : 0;
                    string SelectSQL;
                    string SQL;
                    if (FK_MABANGCUOC != "")
                    {
                        SelectSQL = "Select DMDICHVUPHUTROI.C_VALUE FROM DMDICHVUPHUTROI WHERE DMDICHVUPHUTROI.FK_MAVUNG =" + editItem.GetDataKeyValue("PK_ID").ToString() + " AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND C_TYPE = N'COD'";
                        //Session["t"] = SelectSQL;
                        DataTable oDataTable = new DataTable();
                        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                        oDataTable = SelectQuery.query_data(SelectSQL);
                        if (oDataTable.Rows.Count != 0)
                        {
                            SQL = "Update DMDICHVUPHUTROI set C_VALUE = " + C_CODX + ",C_VALUE1 = " + C_CODY + " WHERE DMDICHVUPHUTROI.FK_MAVUNG =" + editItem.GetDataKeyValue("PK_ID").ToString() + " AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND C_TYPE = N'COD';";
                        }
                        else
                        {
                            SQL = "Insert into DMDICHVUPHUTROI (FK_MAVUNG,FK_MABANGCUOC,C_VALUE,C_VALUE1,C_TYPE) VALUES (" + editItem.GetDataKeyValue("PK_ID").ToString() + "," + FK_MABANGCUOC + "," + C_CODX + "," + C_CODY + ",N'COD');";
                        }
                        SelectQuery.ExecuteNonQuery(SQL);
                    }
                }
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
        string SelectSQL = "";
        SelectSQL += SavePPXD() + SaveVAT() + SaveDONGGOI() + SaveKHAIGIA() + SaveBAOPHAT() + SaveHENGIO() + SaveHAIQUAN() + SaveHUNTRUNG();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        SelectQuery.ExecuteNonQuery(SelectSQL);
    }
    protected string LoadCODX(string FK_MAVUNG)
    {
        string FK_MABANGCUOC = cmbMaBangCuoc.SelectedValue;
        string result = "0";
        string SelectSQL;
        if (FK_MABANGCUOC != "")
        {
            SelectSQL = "Select DMDICHVUPHUTROI.C_VALUE FROM DMDICHVUPHUTROI WHERE DMDICHVUPHUTROI.FK_MAVUNG =" + FK_MAVUNG + " AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND C_TYPE = N'COD'";
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                result = oDataTable.Rows[0]["C_VALUE"].ToString();
            }
        }
        return result;
    }
    protected string LoadCODY(string FK_MAVUNG)
    {
        string FK_MABANGCUOC = cmbMaBangCuoc.SelectedValue;
        string result = "0";
        string SelectSQL;
        if (FK_MABANGCUOC != "")
        {
            SelectSQL = "Select DMDICHVUPHUTROI.C_VALUE1 FROM DMDICHVUPHUTROI WHERE DMDICHVUPHUTROI.FK_MAVUNG =" + FK_MAVUNG + " AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND C_TYPE = N'COD'";
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                result = oDataTable.Rows[0]["C_VALUE1"].ToString();
            }
        }
        return result;
    }
    protected string SavePPXD()
    {
        string FK_MASANPHAM = cmbSanPham.SelectedValue;
        string FK_MABANGCUOC = cmbMaBangCuoc.SelectedValue;
        decimal C_PPXD = (txtC_PPXD.Text != "") ? decimal.Parse(txtC_PPXD.Text) : 0;
        string SQL = "";
        string SelectSQL;
        if (FK_MASANPHAM != "" && FK_MABANGCUOC != "")
        {
            SelectSQL = "Select DMDICHVUPHUTROI.C_VALUE FROM DMDICHVUPHUTROI WHERE DMDICHVUPHUTROI.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND C_TYPE = N'PPXD'";
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                SQL = "Update DMDICHVUPHUTROI set C_VALUE = " + C_PPXD + " WHERE DMDICHVUPHUTROI.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND C_TYPE = N'PPXD';";
            }
            else
            {
                SQL = "Insert into DMDICHVUPHUTROI (FK_MASANPHAM,FK_MABANGCUOC,C_VALUE,C_TYPE) VALUES (" + FK_MASANPHAM + "," + FK_MABANGCUOC + "," + C_PPXD + ",N'PPXD');";
            }
        }
        return SQL;

    }
    protected string SaveVAT()
    {
        string FK_MASANPHAM = cmbSanPham.SelectedValue;
        string FK_MABANGCUOC = cmbMaBangCuoc.SelectedValue;
        decimal C_VAT = (txtC_VAT.Text != "") ? decimal.Parse(txtC_VAT.Text) : 0;
        string SQL = "";
        string SelectSQL;
        if (FK_MASANPHAM != "" && FK_MABANGCUOC != "")
        {
            SelectSQL = "Select DMDICHVUPHUTROI.C_VALUE FROM DMDICHVUPHUTROI WHERE DMDICHVUPHUTROI.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND C_TYPE = N'VAT'";
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                SQL = "Update DMDICHVUPHUTROI set C_VALUE = " + C_VAT + " WHERE DMDICHVUPHUTROI.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND C_TYPE = N'VAT';";
            }
            else
            {
                SQL = "Insert into DMDICHVUPHUTROI (FK_MASANPHAM,FK_MABANGCUOC,C_VALUE,C_TYPE) VALUES (" + FK_MASANPHAM + "," + FK_MABANGCUOC + "," + C_VAT + ",N'VAT');";
            }
        }
        return SQL;
    }
    protected string SaveDONGGOI()
    {
        string FK_MASANPHAM = cmbSanPham.SelectedValue;
        string FK_MABANGCUOC = cmbMaBangCuoc.SelectedValue;
        decimal C_DONGGOIX = (txtC_DONGGOIX.Text != "") ? decimal.Parse(txtC_DONGGOIX.Text) : 0;
        decimal C_DONGGOIY = (txtC_DONGGOIY.Text != "") ? decimal.Parse(txtC_DONGGOIY.Text) : 0;
        string SQL = "";
        string SelectSQL;
        if (FK_MASANPHAM != "" && FK_MABANGCUOC != "")
        {
            SelectSQL = "Select DMDICHVUPHUTROI.C_VALUE FROM DMDICHVUPHUTROI WHERE DMDICHVUPHUTROI.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND C_TYPE = N'DONGGOI'";
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                SQL = "Update DMDICHVUPHUTROI set C_VALUE = " + C_DONGGOIX + ",C_VALUE1 = " + C_DONGGOIY + " WHERE DMDICHVUPHUTROI.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND C_TYPE = N'DONGGOI';";
            }
            else
            {
                SQL = "Insert into DMDICHVUPHUTROI (FK_MASANPHAM,FK_MABANGCUOC,C_VALUE,C_VALUE1,C_TYPE) VALUES (" + FK_MASANPHAM + "," + FK_MABANGCUOC + "," + C_DONGGOIX + "," + C_DONGGOIY + ",N'DONGGOI');";
            }
        }
        return SQL;
    }
    protected string SaveKHAIGIA()
    {
        string FK_MASANPHAM = cmbSanPham.SelectedValue;
        string FK_MABANGCUOC = cmbMaBangCuoc.SelectedValue;
        decimal C_KHAIGIAX = (txtC_KHAIGIAX.Text != "") ? decimal.Parse(txtC_KHAIGIAX.Text) : 0;
        decimal C_KHAIGIAY = (txtC_KHAIGIAY.Text != "") ? decimal.Parse(txtC_KHAIGIAY.Text) : 0;
        string SQL = "";
        string SelectSQL;
        if (FK_MASANPHAM != "" && FK_MABANGCUOC != "")
        {
            SelectSQL = "Select DMDICHVUPHUTROI.C_VALUE FROM DMDICHVUPHUTROI WHERE DMDICHVUPHUTROI.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND C_TYPE = N'KHAIGIA'";
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                SQL = "Update DMDICHVUPHUTROI set C_VALUE = " + C_KHAIGIAX + ",C_VALUE1 = " + C_KHAIGIAY + " WHERE DMDICHVUPHUTROI.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND C_TYPE = N'KHAIGIA';";
            }
            else
            {
                SQL = "Insert into DMDICHVUPHUTROI (FK_MASANPHAM,FK_MABANGCUOC,C_VALUE,C_VALUE1,C_TYPE) VALUES (" + FK_MASANPHAM + "," + FK_MABANGCUOC + "," + C_KHAIGIAX + "," + C_KHAIGIAY + ",N'KHAIGIA');";
            }
        }
        return SQL;
    }
    protected string SaveBAOPHAT()
    {
        string FK_MASANPHAM = cmbSanPham.SelectedValue;
        string FK_MABANGCUOC = cmbMaBangCuoc.SelectedValue;
        decimal C_BAOPHATX = (txtC_BAOPHATX.Text != "") ? decimal.Parse(txtC_BAOPHATX.Text) : 0;
        decimal C_BAOPHATY = (txtC_BAOPHATY.Text != "") ? decimal.Parse(txtC_BAOPHATY.Text) : 0;
        string SQL = "";
        string SelectSQL;
        if (FK_MASANPHAM != "" && FK_MABANGCUOC != "")
        {
            SelectSQL = "Select DMDICHVUPHUTROI.C_VALUE FROM DMDICHVUPHUTROI WHERE DMDICHVUPHUTROI.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND C_TYPE = N'BAOPHAT'";
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                SQL = "Update DMDICHVUPHUTROI set C_VALUE = " + C_BAOPHATX + ",C_VALUE1 = " + C_BAOPHATY + " WHERE DMDICHVUPHUTROI.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND C_TYPE = N'BAOPHAT';";
            }
            else
            {
                SQL = "Insert into DMDICHVUPHUTROI (FK_MASANPHAM,FK_MABANGCUOC,C_VALUE,C_VALUE1,C_TYPE) VALUES (" + FK_MASANPHAM + "," + FK_MABANGCUOC + "," + C_BAOPHATX + "," + C_BAOPHATY + ",N'BAOPHAT');";
            }
        }
        return SQL;
    }
    protected string SaveHENGIO()
    {
        string FK_MASANPHAM = cmbSanPham.SelectedValue;
        string FK_MABANGCUOC = cmbMaBangCuoc.SelectedValue;
        decimal C_HENGIOX = (txtC_HENGIOX.Text != "") ? decimal.Parse(txtC_HENGIOX.Text) : 0;
        decimal C_HENGIOY = (txtC_HENGIOY.Text != "") ? decimal.Parse(txtC_HENGIOY.Text) : 0;
        string SQL = "";
        string SelectSQL;
        if (FK_MASANPHAM != "" && FK_MABANGCUOC != "")
        {
            SelectSQL = "Select DMDICHVUPHUTROI.C_VALUE FROM DMDICHVUPHUTROI WHERE DMDICHVUPHUTROI.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND C_TYPE = N'HENGIO'";
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                SQL = "Update DMDICHVUPHUTROI set C_VALUE = " + C_HENGIOX + ",C_VALUE1 = " + C_HENGIOY + " WHERE DMDICHVUPHUTROI.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND C_TYPE = N'HENGIO';";
            }
            else
            {
                SQL = "Insert into DMDICHVUPHUTROI (FK_MASANPHAM,FK_MABANGCUOC,C_VALUE,C_VALUE1,C_TYPE) VALUES (" + FK_MASANPHAM + "," + FK_MABANGCUOC + "," + C_HENGIOX + "," + C_HENGIOY + ",N'HENGIO');";
            }
        }
        return SQL;
    }
    protected string SaveHAIQUAN()
    {
        string FK_MASANPHAM = cmbSanPham.SelectedValue;
        string FK_MABANGCUOC = cmbMaBangCuoc.SelectedValue;
        decimal C_HAIQUANX = (txtC_HAIQUANX.Text != "") ? decimal.Parse(txtC_HAIQUANX.Text) : 0;
        decimal C_HAIQUANY = (txtC_HAIQUANY.Text != "") ? decimal.Parse(txtC_HAIQUANY.Text) : 0;
        string SQL = "";
        string SelectSQL;
        if (FK_MASANPHAM != "" && FK_MABANGCUOC != "")
        {
            SelectSQL = "Select DMDICHVUPHUTROI.C_VALUE FROM DMDICHVUPHUTROI WHERE DMDICHVUPHUTROI.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND C_TYPE = N'HAIQUAN'";
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                SQL = "Update DMDICHVUPHUTROI set C_VALUE = " + C_HAIQUANX + ",C_VALUE1 = " + C_HAIQUANY + " WHERE DMDICHVUPHUTROI.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND C_TYPE = N'HAIQUAN';";
            }
            else
            {
                SQL = "Insert into DMDICHVUPHUTROI (FK_MASANPHAM,FK_MABANGCUOC,C_VALUE,C_VALUE1,C_TYPE) VALUES (" + FK_MASANPHAM + "," + FK_MABANGCUOC + "," + C_HAIQUANX + "," + C_HAIQUANY + ",N'HAIQUAN');";
            }
        }
        return SQL;
    }
    protected string SaveHUNTRUNG()
    {
        string FK_MASANPHAM = cmbSanPham.SelectedValue;
        string FK_MABANGCUOC = cmbMaBangCuoc.SelectedValue;
        decimal C_HUNTRUNGX = (txtC_HUNTRUNGX.Text != "") ? decimal.Parse(txtC_HUNTRUNGX.Text) : 0;
        decimal C_HUNTRUNGY = (txtC_HUNTRUNGY.Text != "") ? decimal.Parse(txtC_HUNTRUNGY.Text) : 0;
        string SQL = "";
        string SelectSQL;
        if (FK_MASANPHAM != "" && FK_MABANGCUOC != "")
        {
            SelectSQL = "Select DMDICHVUPHUTROI.C_VALUE FROM DMDICHVUPHUTROI WHERE DMDICHVUPHUTROI.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND C_TYPE = N'HUNTRUNG'";
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                SQL = "Update DMDICHVUPHUTROI set C_VALUE = " + C_HUNTRUNGX + ",C_VALUE1 = " + C_HUNTRUNGY + " WHERE DMDICHVUPHUTROI.FK_MASANPHAM =" + FK_MASANPHAM + " AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND C_TYPE = N'HUNTRUNG';";
            }
            else
            {
                SQL = "Insert into DMDICHVUPHUTROI (FK_MASANPHAM,FK_MABANGCUOC,C_VALUE,C_VALUE1,C_TYPE) VALUES (" + FK_MASANPHAM + "," + FK_MABANGCUOC + "," + C_HUNTRUNGX + "," + C_HUNTRUNGY + ",N'HUNTRUNG');";
            }
        }
        return SQL;
    }
}