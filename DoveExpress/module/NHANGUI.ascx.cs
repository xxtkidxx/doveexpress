using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;
using System.Globalization;
using System.Collections;
using Excel;

public partial class module_NHANGUI : System.Web.UI.UserControl
{
    #region Biến toàn cục
    private string FK_NHOMKHACHHANG
    {
        get
        {
            return Session["FK_NHOMKHACHHANG"] as string;
        }
        set
        {
            Session["FK_NHOMKHACHHANG"] = value;
        }
    }
    private string FK_KHACHHANG
    {
        get
        {
            return Session["FK_KHACHHANG"] as string;
        }
        set
        {
            Session["FK_KHACHHANG"] = value;
        }
    }
    private string TENKH
    {
        get
        {
            return Session["TENKH"] as string;
        }
        set
        {
            Session["TENKH"] = value;
        }
    }
    private string DIENTHOAIKH
    {
        get
        {
            return Session["DIENTHOAIKH"] as string;
        }
        set
        {
            Session["DIENTHOAIKH"] = value;
        }
    }
    private string FK_DICHVU
    {
        get
        {
            return Session["FK_DICHVU"] as string;
        }
        set
        {
            Session["FK_DICHVU"] = value;
        }
    }
    private string FK_MABANGCUOC
    {
        get
        {
            return Session["FK_MABANGCUOC"] as string;
        }
        set
        {
            Session["FK_MABANGCUOC"] = value;
        }
    }
    private string FK_QUANHUYEN
    {
        get
        {
            return Session["FK_QUANHUYEN"] as string;
        }
        set
        {
            Session["FK_QUANHUYEN"] = value;
        }
    }
    private string FK_MAVUNG
    {
        get
        {
            return Session["FK_MAVUNG"] as string;
        }
        set
        {
            Session["FK_MAVUNG"] = value;
        }
    }
    private string FK_MAVUNGDT
    {
        get
        {
            return Session["FK_MAVUNGDT"] as string;
        }
        set
        {
            Session["FK_MAVUNGDT"] = value;
        }
    }
    private int C_KHOILUONG
    {
        get
        {
            return int.Parse(Session["C_KHOILUONG"].ToString());
        }
        set
        {
            Session["C_KHOILUONG"] = value;
        }
    }
    private decimal PPXD
    {
        get
        {
            return decimal.Parse(Session["PPXD"].ToString());
        }
        set
        {
            Session["PPXD"] = value;
        }
    }
    private decimal CUOCCHINH
    {
        get
        {
            return decimal.Parse(Session["CUOCCHINH"].ToString());
        }
        set
        {
            Session["CUOCCHINH"] = value;
        }
    }
    private string FK_DOITAC
    {
        get
        {
            return Session["FK_DOITAC"] as string;
        }
        set
        {
            Session["FK_DOITAC"] = value;
        }
    }
    private decimal GIADOITAC
    {
        get
        {
            return decimal.Parse(Session["GIADOITAC"].ToString());
        }
        set
        {
            Session["GIADOITAC"] = value;
        }
    }
    private DataTable ctcDataTable
    {
        get
        {
            return Session["ctcDataTable"] as DataTable;
        }
        set
        {
            Session["ctcDataTable"] = value;
        }
    }
    private DataTable ctcDataTable1
    {
        get
        {
            return Session["ctcDataTable1"] as DataTable;
        }
        set
        {
            Session["ctcDataTable1"] = value;
        }
    }
    private int C_KHOILUONGLK
    {
        get
        {
            return int.Parse(Session["C_KHOILUONGLK"].ToString());
        }
        set
        {
            Session["C_KHOILUONGLK"] = value;
        }
    }
    private decimal GIACUOCLK
    {
        get
        {
            return decimal.Parse(Session["GIACUOCLK"].ToString());
        }
        set
        {
            Session["GIACUOCLK"] = value;
        }
    }
    private decimal BAOPHATX
    {
        get
        {
            return decimal.Parse(Session["BAOPHATX"].ToString());
        }
        set
        {
            Session["BAOPHATX"] = value;
        }
    }
    private decimal BAOPHATY
    {
        get
        {
            return decimal.Parse(Session["BAOPHATY"].ToString());
        }
        set
        {
            Session["BAOPHATY"] = value;
        }
    }
    private decimal KHAIGIAX
    {
        get
        {
            return decimal.Parse(Session["KHAIGIAX"].ToString());
        }
        set
        {
            Session["KHAIGIAX"] = value;
        }
    }
    private decimal KHAIGIAY
    {
        get
        {
            return decimal.Parse(Session["KHAIGIAY"].ToString());
        }
        set
        {
            Session["KHAIGIAY"] = value;
        }
    }
    private decimal DONGGOIX
    {
        get
        {
            return decimal.Parse(Session["DONGGOIX"].ToString());
        }
        set
        {
            Session["DONGGOIX"] = value;
        }
    }
    private decimal DONGGOIY
    {
        get
        {
            return decimal.Parse(Session["DONGGOIY"].ToString());
        }
        set
        {
            Session["DONGGOIY"] = value;
        }
    }
    private decimal HENGIOX
    {
        get
        {
            return decimal.Parse(Session["HENGIOX"].ToString());
        }
        set
        {
            Session["HENGIOX"] = value;
        }
    }
    private decimal HENGIOY
    {
        get
        {
            return decimal.Parse(Session["HENGIOY"].ToString());
        }
        set
        {
            Session["HENGIOY"] = value;
        }
    }
    private decimal CODX
    {
        get
        {
            return decimal.Parse(Session["CODX"].ToString());
        }
        set
        {
            Session["CODX"] = value;
        }
    }
    private decimal CODY
    {
        get
        {
            return decimal.Parse(Session["CODY"].ToString());
        }
        set
        {
            Session["CODY"] = value;
        }
    }
    private decimal VAT
    {
        get
        {
            return decimal.Parse(Session["VAT"].ToString());
        }
        set
        {
            Session["VAT"] = value;
        }
    }
    #endregion
    string Alarm = "";
    bool isCuocchinh = false;
    bool isCuocdoitac = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridNHANGUI.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridNHANGUI.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridNHANGUI.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("NHANGUI"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        btnAddExcell.Visible = ITCLIB.Security.Security.CanAddModule("NHANGUI");
        if (Request["index"] != null && Request["value"] != null)
        {
            string index = Request["index"].ToString();
            string Value = Request["value"].ToString();
        }
        Session["LastUrl"] = Request.Url.ToString();
        RadAjaxManager ajaxManager = RadAjaxManager.GetCurrent(Page);
        ajaxManager.AjaxRequest += new RadAjaxControl.AjaxRequestDelegate(RadScriptManager_AjaxRequestNG);
        ajaxManager.ClientEvents.OnResponseEnd = "onResponseEndNG";
    }
    protected void RadScriptManager_AjaxRequestNG(object sender, AjaxRequestEventArgs e)
    {
        GridEditableItem editableItem = null;
        foreach (GridEditFormItem item in RadGridNHANGUI.MasterTableView.GetItems(GridItemType.EditFormItem))
        {
            if (item.IsInEditMode)
            {
                editableItem = (GridEditableItem)item;
            }
        }
        RadNumericTextBox txtPPXD = (RadNumericTextBox)editableItem.FindControl("txtPPXD");
        RadTextBox txtCODE = (RadTextBox)editableItem.FindControl("txtCODE");
        RadNumericTextBox txtC_KHOILUONG = (RadNumericTextBox)editableItem.FindControl("txtC_KHOILUONG");
        string[] arrayvalue = e.Argument.Split(';');
        if ((arrayvalue[0] == "cmbMaKhachHang") && (FK_KHACHHANG != arrayvalue[1]))
        {
            FK_KHACHHANG = arrayvalue[1];
            string SelectSQL;
            SelectSQL = "Select DMKHACHHANG.FK_NHOMKHACHHANG,DMKHACHHANG.C_NAME,DMKHACHHANG.C_TEL FROM DMKHACHHANG WHERE DMKHACHHANG.C_CODE ='" + FK_KHACHHANG + "'";
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                FK_NHOMKHACHHANG = oDataTable.Rows[0]["FK_NHOMKHACHHANG"].ToString();
                TENKH = oDataTable.Rows[0]["C_NAME"].ToString();
                DIENTHOAIKH = oDataTable.Rows[0]["C_TEL"].ToString();
                string SelectSQL1;
                SelectSQL1 = "Select DMMABANGCUOC.PK_ID FROM DMMABANGCUOC WHERE ((DMMABANGCUOC.C_VALUE ='" + FK_NHOMKHACHHANG + "') OR (DMMABANGCUOC.C_VALUE LIKE '%," + FK_NHOMKHACHHANG + ",%') OR (DMMABANGCUOC.C_VALUE LIKE '%," + FK_NHOMKHACHHANG + "') OR (DMMABANGCUOC.C_VALUE LIKE '" + FK_NHOMKHACHHANG + ",%')) AND (DMMABANGCUOC.FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"].ToString() + "')";
                DataTable oDataTable1 = new DataTable();
                ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
                oDataTable1 = SelectQuery1.query_data(SelectSQL1);
                if (oDataTable1.Rows.Count != 0)
                {
                    FK_MABANGCUOC = oDataTable1.Rows[0]["PK_ID"].ToString();
                    if (FK_DICHVU != "")
                    {
                        LoadDVPT();
                    }
                }
                else
                {
                    FK_MABANGCUOC = "";
                    Alarm = "msg,-,Nhóm khách hàng này không nằm trong bảng cước nào trong khu vực làm việc " + Session["VUNGLAMVIEC"].ToString() + ",-," + TENKH + ",-," + DIENTHOAIKH;
                }
            }
            else
            {
                FK_NHOMKHACHHANG = "";
                TENKH = "";
                DIENTHOAIKH = "";
                Alarm = "msg,-,Mã khách hàng này không nằm trong nhóm khách hàng nào";
            }
            isCuocchinh = true;
        }
        else if ((arrayvalue[0] == "cmbQuanHuyen") && (FK_QUANHUYEN != arrayvalue[1]))
        {
            FK_QUANHUYEN = arrayvalue[1];
            if (FK_DICHVU != "")
            {
                LoadMaVung();
                if (FK_DOITAC != "")
                {
                    LoadMaVungDT();
                }
            }
            isCuocchinh = true;
        }
        else if ((arrayvalue[0] == "cmbSanPham") && (FK_DICHVU != arrayvalue[1]))
        {
            FK_DICHVU = arrayvalue[1];
            if (FK_MABANGCUOC != "")
            {
                LoadDVPT();
            }
            if (FK_QUANHUYEN != "")
            {
                LoadMaVung();
                if (FK_DOITAC != "")
                {
                    LoadMaVungDT();
                }
            }
            isCuocchinh = true;
        }
        else if ((arrayvalue[0] == "txtC_KHOILUONG") && (C_KHOILUONG != int.Parse(arrayvalue[1])))
        {
            C_KHOILUONG = int.Parse(arrayvalue[1]);
            isCuocchinh = true;
            isCuocdoitac = true;
        }
        else if ((arrayvalue[0] == "cmbFK_DOITAC") && (FK_DOITAC != arrayvalue[1]))
        {
            FK_DOITAC = arrayvalue[1];
            if (FK_QUANHUYEN != "" && FK_DICHVU != "")
            {
                LoadMaVungDT();
            }            
        }
        if (C_KHOILUONG != 0)
        {
            if ((FK_MABANGCUOC != "") && (FK_MAVUNG != "") && (isCuocchinh))
            {
                GiaCuocChinh();
            }
            //CUOCCHINH = (Math.Round((CUOCCHINH + ((CUOCCHINH * PPXD) / 100)) / 1000)) * 1000;
            if ((FK_MAVUNGDT != "") && (isCuocdoitac))
            {
                GiaCuocDoiTac();
            }
        }
        //Session["t"] = FK_KHACHHANG + "-" + TENKH + "-" + DIENTHOAIKH + "-" + PPXD + "-" + CUOCCHINH + "-" + GIADOITAC + "-" + FK_MABANGCUOC + "-" + FK_MAVUNG;
        if (Alarm != "")
        {
            string script = string.Format("var result = '{0}'", Alarm);
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
        }
        else
        {
            string script = string.Format("var result = '{0}'", FK_KHACHHANG + ",-," + TENKH + ",-," + DIENTHOAIKH + ",-," + PPXD + ",-," + CUOCCHINH + ",-," + GIADOITAC + ",-," + FK_MABANGCUOC + ",-," + FK_MAVUNG + ",-," + VAT + ",-," + DONGGOIX + ",-," + DONGGOIY + ",-," + KHAIGIAX + ",-," + KHAIGIAY + ",-," + BAOPHATX + ",-," + BAOPHATY + ",-," + HENGIOX + ",-," + HENGIOY + ",-," + CODX + ",-," + CODY);
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
        }
    }
    protected void LoadDVPT()
    {
        string SelectSQL = "Select DMDICHVUPHUTROI.C_VALUE,DMDICHVUPHUTROI.C_VALUE1,DMDICHVUPHUTROI.C_TYPE FROM DMDICHVUPHUTROI WHERE DMDICHVUPHUTROI.FK_MASANPHAM =" + FK_DICHVU + " AND FK_MABANGCUOC = " + FK_MABANGCUOC;
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            for (int i = 0; i <= oDataTable.Rows.Count - 1; i++)
            {
                if (oDataTable.Rows[i]["C_TYPE"].ToString() == "PPXD")
                {
                    PPXD = (oDataTable.Rows[i]["C_VALUE"] == DBNull.Value) ? 0 : decimal.Parse(oDataTable.Rows[i]["C_VALUE"].ToString());
                }
                else if (oDataTable.Rows[i]["C_TYPE"].ToString() == "VAT")
                {
                    VAT = (oDataTable.Rows[i]["C_VALUE"] == DBNull.Value) ? 0 : decimal.Parse(oDataTable.Rows[i]["C_VALUE"].ToString());
                }
                else if (oDataTable.Rows[i]["C_TYPE"].ToString() == "DONGGOI")
                {
                    DONGGOIX = (oDataTable.Rows[i]["C_VALUE"] == DBNull.Value) ? 0 : decimal.Parse(oDataTable.Rows[i]["C_VALUE"].ToString());
                    DONGGOIY = (oDataTable.Rows[i]["C_VALUE1"] == DBNull.Value) ? 0 : decimal.Parse(oDataTable.Rows[i]["C_VALUE1"].ToString());
                }
                else if (oDataTable.Rows[i]["C_TYPE"].ToString() == "KHAIGIA")
                {
                    KHAIGIAX = (oDataTable.Rows[i]["C_VALUE"] == DBNull.Value) ? 0 : decimal.Parse(oDataTable.Rows[i]["C_VALUE"].ToString());
                    KHAIGIAY = (oDataTable.Rows[i]["C_VALUE1"] == DBNull.Value) ? 0 : decimal.Parse(oDataTable.Rows[i]["C_VALUE1"].ToString());
                }
                else if (oDataTable.Rows[i]["C_TYPE"].ToString() == "BAOPHAT")
                {
                    BAOPHATX = (oDataTable.Rows[i]["C_VALUE"] == DBNull.Value) ? 0 : decimal.Parse(oDataTable.Rows[i]["C_VALUE"].ToString());
                    BAOPHATY = (oDataTable.Rows[i]["C_VALUE1"] == DBNull.Value) ? 0 : decimal.Parse(oDataTable.Rows[i]["C_VALUE1"].ToString());
                }
                else if (oDataTable.Rows[i]["C_TYPE"].ToString() == "HENGIO")
                {
                    HENGIOX = (oDataTable.Rows[i]["C_VALUE"] == DBNull.Value) ? 0 : decimal.Parse(oDataTable.Rows[i]["C_VALUE"].ToString());
                    HENGIOY = (oDataTable.Rows[i]["C_VALUE1"] == DBNull.Value) ? 0 : decimal.Parse(oDataTable.Rows[i]["C_VALUE1"].ToString());
                }
            }
        }
    }
    protected void LoadCOD()
    {
        string SelectSQL = "Select DMDICHVUPHUTROI.C_VALUE,DMDICHVUPHUTROI.C_VALUE1,DMDICHVUPHUTROI.C_TYPE FROM DMDICHVUPHUTROI WHERE FK_MABANGCUOC = " + FK_MABANGCUOC + " AND FK_MAVUNG = " + FK_MAVUNG;
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            for (int i = 0; i <= oDataTable.Rows.Count - 1; i++)
            {
                if (oDataTable.Rows[i]["C_TYPE"].ToString() == "COD")
                {
                    CODX = (oDataTable.Rows[i]["C_VALUE"] == DBNull.Value) ? 0 : decimal.Parse(oDataTable.Rows[i]["C_VALUE"].ToString());
                    CODY = (oDataTable.Rows[i]["C_VALUE1"] == DBNull.Value) ? 0 : decimal.Parse(oDataTable.Rows[i]["C_VALUE1"].ToString());
                }
            }
        }
    }
    protected void LoadMaVung()
    {
        string SelectSQL;
        SelectSQL = "Select DMMAVUNG.PK_ID FROM DMMAVUNG WHERE FK_MASANPHAM=" + FK_DICHVU + " AND C_TYPE = 1 AND FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"] + "' AND ((DMMAVUNG.C_DESC ='" + FK_QUANHUYEN + "') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUANHUYEN + ",%') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUANHUYEN + "') OR (DMMAVUNG.C_DESC LIKE '" + FK_QUANHUYEN + ",%'))";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            FK_MAVUNG = oDataTable.Rows[0]["PK_ID"].ToString();
            if (FK_MABANGCUOC != "")
            {
                LoadCOD();
            }
        }
        else
        {
            FK_MAVUNG = "";
            Alarm = "msg,-,Quận huyện này không nằm trong vùng tính cước nào";
        }
    }
    protected void LoadMaVungDT()
    {
        isCuocdoitac = true;
        string SelectSQL;
        SelectSQL = "Select DMMAVUNGDT.PK_ID FROM DMMAVUNGDT WHERE FK_MASANPHAM=" + FK_DICHVU + " AND FK_DOITAC = " + FK_DOITAC + " AND C_TYPE = 1 AND FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"] + "' AND ((DMMAVUNGDT.C_DESC ='" + FK_QUANHUYEN + "') OR (DMMAVUNGDT.C_DESC LIKE '%," + FK_QUANHUYEN + ",%') OR (DMMAVUNGDT.C_DESC LIKE '%," + FK_QUANHUYEN + "') OR (DMMAVUNGDT.C_DESC LIKE '" + FK_QUANHUYEN + ",%'))";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            FK_MAVUNGDT = oDataTable.Rows[0]["PK_ID"].ToString();
        }
        else
        {
            FK_MAVUNGDT = "";
        }
    }
    protected void btnShowAll_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadGridNHANGUI.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridNHANGUI.MasterTableView.RenderColumns)
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
        RadGridNHANGUI.MasterTableView.Rebind();
    }
    protected void CheckBill(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        SelectSQL = "Select NHANGUI.C_BILL FROM NHANGUI WHERE NHANGUI.C_BILL = '" + args.Value + "' AND NHANGUI.PK_ID <> " + Session["txtID"].ToString();
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
        RadGridNHANGUI.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridNHANGUI_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridNHANGUI_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xóa nhận gửi. Lý do: " + e.Exception.Message);
        }
        else
        {
            ClearSession();
            SetMessage("Xóa nhận gửi thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted NHANGUIs", e.Item.KeyValues);
        }
    }
    protected void RadGridNHANGUI_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới nhận gửi. Lý do: " + e.Exception.Message);
        }
        else
        {
            if (Session["SaveAddNew"] == "True")
            {
                e.KeepInInsertMode = true;
            }
            ClearSession();
            SetMessage("Tạo mới nhận gửi thành công!");
            Session["MAXID"] = getmaxid("NHANGUI");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted NHANGUIs", "{PK_ID:\"" + Session["MAXID"].ToString() + "\"}");
        }
    }
    protected void RadGridNHANGUI_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật nhận gửi. Lý do: " + e.Exception.Message);
        }
        else
        {
            ClearSession();
            SetMessage("Cập nhật nhận gửi thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated NHANGUIs", e.Item.KeyValues);
        }
    }
    protected void RadGridNHANGUI_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadGrid grid = (RadGrid)sender;
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            RadDateTimePicker radNgaynhangui = (RadDateTimePicker)editItem.FindControl("radNgaynhangui");
            RadDateTimePicker radC_NGAYGIONHAN = (RadDateTimePicker)editItem.FindControl("radC_NGAYGIONHAN");
            RadTextBox txtC_TENKH = (RadTextBox)editItem.FindControl("txtC_TENKH");
            RadTextBox txtC_TELGUI = (RadTextBox)editItem.FindControl("txtC_TELGUI");
            HiddenField txtID = (HiddenField)editItem.FindControl("txtID");
            Session["txtID"] = (txtID.Value != "") ? txtID.Value : "0";
            HiddenField hfTinhThanh = (HiddenField)editItem.FindControl("hfTinhThanh");
            HiddenField hfQuanHuyen = (HiddenField)editItem.FindControl("hfQuanHuyen");
            QUANHUYENDataSource.SelectCommand = LoadFilteredManually(hfQuanHuyen.Value);
            RadComboBox cmbTinhThanh = (RadComboBox)editItem.FindControl("cmbTinhThanh");
            RadComboBox cmbQuanHuyen = (RadComboBox)editItem.FindControl("cmbQuanHuyen");
            if (hfTinhThanh.Value != "" && hfQuanHuyen.Value != "")
            {
                cmbTinhThanh.SelectedValue = hfTinhThanh.Value;
                QUANHUYENDataSource.SelectCommand = LoadFilteredManually(hfTinhThanh.Value);
                cmbQuanHuyen.DataBind();
                cmbQuanHuyen.SelectedValue = hfQuanHuyen.Value;
            }
            RadNumericTextBox txtPPXD = (RadNumericTextBox)editItem.FindControl("txtPPXD");
            txtPPXD.Text = (txtPPXD.Text == "") ? "0" : txtPPXD.Text;
            RadTextBox txtCODE = (RadTextBox)editItem.FindControl("txtCODE");
            RadNumericTextBox txtC_GIATRIHANGHOA = (RadNumericTextBox)editItem.FindControl("txtC_GIATRIHANGHOA");
            txtC_GIATRIHANGHOA.Text = (txtC_GIATRIHANGHOA.Text == "") ? "0" : txtC_GIATRIHANGHOA.Text;
            RadNumericTextBox txtC_KHOILUONGTHUC = (RadNumericTextBox)editItem.FindControl("txtC_KHOILUONGTHUC");
            txtC_KHOILUONGTHUC.Text = (txtC_KHOILUONGTHUC.Text == "") ? "0" : txtC_KHOILUONGTHUC.Text;
            RadNumericTextBox txtC_KHOILUONGQD = (RadNumericTextBox)editItem.FindControl("txtC_KHOILUONGQD");
            txtC_KHOILUONGQD.Text = (txtC_KHOILUONGQD.Text == "") ? "0" : txtC_KHOILUONGQD.Text;
            RadNumericTextBox txtC_KHOILUONG = (RadNumericTextBox)editItem.FindControl("txtC_KHOILUONG");
            txtC_KHOILUONG.Text = (txtC_KHOILUONG.Text == "") ? "0" : txtC_KHOILUONG.Text;
            RadComboBox cmbMaKhachHang = (RadComboBox)editItem.FindControl("cmbMaKhachHang");
            RadComboBox cmbSanPham = (RadComboBox)editItem.FindControl("cmbSanPham");
            RadNumericTextBox txtC_GIACUOC = (RadNumericTextBox)editItem.FindControl("txtC_GIACUOC");
            txtC_GIACUOC.Text = (txtC_GIACUOC.Text == "") ? "0" : txtC_GIACUOC.Text;
            RadNumericTextBox txtC_DONGGOI = (RadNumericTextBox)editItem.FindControl("txtC_DONGGOI");
            txtC_DONGGOI.Text = (txtC_DONGGOI.Text == "") ? "0" : txtC_DONGGOI.Text;
            RadNumericTextBox txtC_KHAIGIA = (RadNumericTextBox)editItem.FindControl("txtC_KHAIGIA");
            txtC_KHAIGIA.Text = (txtC_KHAIGIA.Text == "") ? "0" : txtC_KHAIGIA.Text;
            RadNumericTextBox txtC_COD = (RadNumericTextBox)editItem.FindControl("txtC_COD");
            txtC_COD.Text = (txtC_COD.Text == "") ? "0" : txtC_COD.Text;
            RadNumericTextBox txtC_BAOPHAT = (RadNumericTextBox)editItem.FindControl("txtC_BAOPHAT");
            txtC_BAOPHAT.Text = (txtC_BAOPHAT.Text == "") ? "0" : txtC_BAOPHAT.Text;
            RadNumericTextBox txtC_HENGIO = (RadNumericTextBox)editItem.FindControl("txtC_HENGIO");
            txtC_HENGIO.Text = (txtC_HENGIO.Text == "") ? "0" : txtC_HENGIO.Text;
            RadNumericTextBox txtC_TIENHANG = (RadNumericTextBox)editItem.FindControl("txtC_TIENHANG");
            txtC_TIENHANG.Text = (txtC_TIENHANG.Text == "") ? "0" : txtC_TIENHANG.Text;
            RadNumericTextBox txtC_VAT = (RadNumericTextBox)editItem.FindControl("txtC_VAT");
            txtC_VAT.Text = (txtC_VAT.Text == "") ? "0" : txtC_VAT.Text;
            RadNumericTextBox txtC_TIENHANGVAT = (RadNumericTextBox)editItem.FindControl("txtC_TIENHANGVAT");
            txtC_TIENHANGVAT.Text = (txtC_TIENHANGVAT.Text == "") ? "0" : txtC_TIENHANGVAT.Text;
            RadNumericTextBox txtC_DATHU = (RadNumericTextBox)editItem.FindControl("txtC_DATHU");
            txtC_DATHU.Text = (txtC_DATHU.Text == "") ? "0" : txtC_DATHU.Text;
            RadNumericTextBox txtC_CONLAI = (RadNumericTextBox)editItem.FindControl("txtC_CONLAI");
            txtC_CONLAI.Text = (txtC_CONLAI.Text == "") ? "0" : txtC_CONLAI.Text;
            RadComboBox cmbFK_DOITAC = (RadComboBox)editItem.FindControl("cmbFK_DOITAC");
            RadComboBox cmbFK_USERADD = (RadComboBox)editItem.FindControl("cmbFK_USERADD");
            RadNumericTextBox txtC_GIADOITAC = (RadNumericTextBox)editItem.FindControl("txtC_GIADOITAC");
            txtC_GIADOITAC.Text = (txtC_GIADOITAC.Text == "") ? "0" : txtC_GIADOITAC.Text;
            if (e.Item is GridEditFormInsertItem || e.Item is GridDataInsertItem)
            {
                // insert item
                radNgaynhangui.SelectedDate = System.DateTime.Now;
                radC_NGAYGIONHAN.SelectedDate = System.DateTime.Now.Date;
                txtCODE.Text = GetMaxBill();
                cmbFK_USERADD.SelectedValue = Session["UserID"].ToString();
                if (Session["SaveAddNew"] == "True")
                {
                    if (Session["MAXID"].ToString() != "")
                    {
                        string SQLSELECT = String.Format("SELECT NHANGUI.*  FROM NHANGUI WHERE NHANGUI.PK_ID = {0}", Session["MAXID"].ToString());
                        ITCLIB.Admin.SQL QR = new ITCLIB.Admin.SQL();
                        DataTable oDataTableNew = QR.query_data(SQLSELECT);
                        if (oDataTableNew.Rows.Count > 0)
                        {
                            cmbSanPham.SelectedValue = oDataTableNew.Rows[0]["FK_MASANPHAM"].ToString();
                            cmbMaKhachHang.SelectedValue = oDataTableNew.Rows[0]["FK_KHACHHANG"].ToString();
                            txtC_TENKH.Text = oDataTableNew.Rows[0]["C_TENKH"].ToString();
                            txtC_TELGUI.Text = oDataTableNew.Rows[0]["C_TELGUI"].ToString();
                            cmbTinhThanh.SelectedValue = ITCLIB.Admin.cFunction.LoadIDTinhThanhCode(oDataTableNew.Rows[0]["FK_QUANHUYEN"].ToString());
                            QUANHUYENDataSource.SelectCommand = LoadFilteredManually(ITCLIB.Admin.cFunction.LoadIDTinhThanhCode(oDataTableNew.Rows[0]["FK_QUANHUYEN"].ToString()));
                            cmbQuanHuyen.DataBind();
                            cmbQuanHuyen.SelectedValue = oDataTableNew.Rows[0]["FK_QUANHUYEN"].ToString();
                            txtC_KHOILUONG.Text = oDataTableNew.Rows[0]["C_KHOILUONG"].ToString();
                            txtC_GIACUOC.Text = oDataTableNew.Rows[0]["C_GIACUOC"].ToString();
                            cmbFK_DOITAC.SelectedValue = oDataTableNew.Rows[0]["FK_DOITAC"].ToString();
                            txtC_GIADOITAC.Text = oDataTableNew.Rows[0]["C_GIADOITAC"].ToString();
                            RadTextBox txtC_NGUOINHAN = (RadTextBox)editItem.FindControl("txtC_NGUOINHAN");
                            txtC_NGUOINHAN.Text = oDataTableNew.Rows[0]["C_NGUOINHAN"].ToString();
                            RadTextBox txtC_DIACHINHAN = (RadTextBox)editItem.FindControl("txtC_DIACHINHAN");
                            txtC_DIACHINHAN.Text = oDataTableNew.Rows[0]["C_DIACHINHAN"].ToString();
                            RadTextBox txtC_TELNHAN = (RadTextBox)editItem.FindControl("txtC_TELNHAN");
                            txtC_TELNHAN.Text = oDataTableNew.Rows[0]["C_TELNHAN"].ToString();
                            RadTextBox txtC_NOIDUNG = (RadTextBox)editItem.FindControl("txtC_NOIDUNG");
                            txtC_NOIDUNG.Text = oDataTableNew.Rows[0]["C_NOIDUNG"].ToString();
                            RadNumericTextBox txtC_SOKIEN = (RadNumericTextBox)editItem.FindControl("txtC_SOKIEN");
                            txtC_SOKIEN.Text = oDataTableNew.Rows[0]["C_SOKIEN"].ToString();
                            txtC_GIATRIHANGHOA.Text = oDataTableNew.Rows[0]["C_GIATRIHANGHOA"].ToString();
                            txtC_KHOILUONGTHUC.Text = oDataTableNew.Rows[0]["C_KHOILUONGTHUC"].ToString();
                            txtC_KHOILUONGQD.Text = oDataTableNew.Rows[0]["C_KHOILUONGQD"].ToString();
                            txtPPXD.Text = oDataTableNew.Rows[0]["C_PPXD"].ToString();
                            txtC_DONGGOI.Text = oDataTableNew.Rows[0]["C_DONGGOI"].ToString();
                            txtC_KHAIGIA.Text = oDataTableNew.Rows[0]["C_KHAIGIA"].ToString();
                            txtC_COD.Text = oDataTableNew.Rows[0]["C_COD"].ToString();
                            txtC_BAOPHAT.Text = oDataTableNew.Rows[0]["C_BAOPHAT"].ToString();
                            txtC_HENGIO.Text = oDataTableNew.Rows[0]["C_HENGIO"].ToString();
                            txtC_TIENHANG.Text = oDataTableNew.Rows[0]["C_TIENHANG"].ToString();
                            txtC_VAT.Text = oDataTableNew.Rows[0]["C_VAT"].ToString();
                            txtC_TIENHANGVAT.Text = oDataTableNew.Rows[0]["C_TIENHANGVAT"].ToString();
                            RadComboBox cmbC_HINHTHUCTT = (RadComboBox)editItem.FindControl("cmbC_HINHTHUCTT");
                            if (oDataTableNew.Rows[0]["C_HINHTHUCTT"].ToString() != "")
                            {
                                cmbC_HINHTHUCTT.SelectedValue = oDataTableNew.Rows[0]["C_HINHTHUCTT"].ToString();
                            }
                            txtC_DATHU.Text = oDataTableNew.Rows[0]["C_DATHU"].ToString();
                            txtC_CONLAI.Text = txtC_CONLAI.Text = (((txtC_TIENHANGVAT.Text == "") ? 0 : decimal.Parse(txtC_TIENHANGVAT.Text)) - ((txtC_DATHU.Text == "") ? 0 : decimal.Parse(txtC_DATHU.Text))).ToString();
                            RadComboBox cmbFK_NHANVIENNHAN = (RadComboBox)editItem.FindControl("cmbFK_NHANVIENNHAN");
                            if (oDataTableNew.Rows[0]["FK_NHANVIENNHAN"].ToString() != "")
                            {
                                cmbFK_NHANVIENNHAN.SelectedValue = oDataTableNew.Rows[0]["FK_NHANVIENNHAN"].ToString();
                            }

                            FK_DICHVU = oDataTableNew.Rows[0]["FK_MASANPHAM"].ToString();
                            FK_QUANHUYEN = oDataTableNew.Rows[0]["FK_QUANHUYEN"].ToString();
                            FK_KHACHHANG = oDataTableNew.Rows[0]["FK_KHACHHANG"].ToString();
                            TENKH = oDataTableNew.Rows[0]["C_TENKH"].ToString();
                            DIENTHOAIKH = oDataTableNew.Rows[0]["C_TELGUI"].ToString();
                            string SelectSQL;
                            SelectSQL = "Select DMKHACHHANG.FK_NHOMKHACHHANG,DMKHACHHANG.C_NAME,DMKHACHHANG.C_TEL FROM DMKHACHHANG WHERE DMKHACHHANG.C_CODE ='" + FK_KHACHHANG + "'";
                            DataTable oDataTable = new DataTable();
                            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                            oDataTable = SelectQuery.query_data(SelectSQL);
                            if (oDataTable.Rows.Count != 0)
                            {
                                FK_NHOMKHACHHANG = oDataTable.Rows[0]["FK_NHOMKHACHHANG"].ToString();
                                string SelectSQL2;
                                SelectSQL2 = "Select DMMABANGCUOC.PK_ID FROM DMMABANGCUOC WHERE ((DMMABANGCUOC.C_VALUE ='" + FK_NHOMKHACHHANG + "') OR (DMMABANGCUOC.C_VALUE LIKE '%," + FK_NHOMKHACHHANG + ",%') OR (DMMABANGCUOC.C_VALUE LIKE '%," + FK_NHOMKHACHHANG + "') OR (DMMABANGCUOC.C_VALUE LIKE '" + FK_NHOMKHACHHANG + ",%')) AND (DMMABANGCUOC.FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"].ToString() + "')";
                                DataTable oDataTable2 = new DataTable();
                                ITCLIB.Admin.SQL SelectQuery2 = new ITCLIB.Admin.SQL();
                                oDataTable2 = SelectQuery2.query_data(SelectSQL2);
                                if (oDataTable2.Rows.Count != 0)
                                {
                                    FK_MABANGCUOC = oDataTable2.Rows[0]["PK_ID"].ToString();
                                }
                                else
                                {
                                    FK_MABANGCUOC = "";
                                }
                            }
                            else
                            {
                                FK_NHOMKHACHHANG = "";
                                FK_MABANGCUOC = "";
                            }
                            string SelectSQL3;
                            SelectSQL3 = "Select DMMAVUNG.PK_ID FROM DMMAVUNG WHERE FK_MASANPHAM=" + FK_DICHVU + " AND FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"] + "' AND C_TYPE = 1 AND ((DMMAVUNG.C_DESC ='" + FK_QUANHUYEN + "') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUANHUYEN + ",%') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUANHUYEN + "') OR (DMMAVUNG.C_DESC LIKE '" + FK_QUANHUYEN + ",%')) AND (DMMAVUNG.FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"].ToString() + "')";
                            DataTable oDataTable3 = new DataTable();
                            ITCLIB.Admin.SQL SelectQuery3 = new ITCLIB.Admin.SQL();
                            oDataTable3 = SelectQuery3.query_data(SelectSQL3);
                            if (oDataTable3.Rows.Count != 0)
                            {
                                FK_MAVUNG = oDataTable3.Rows[0]["PK_ID"].ToString();
                            }
                            else
                            {
                                FK_MAVUNG = "";
                            }
                            PPXD = 0;
                            LoadDVPT();
                            C_KHOILUONG = int.Parse(oDataTableNew.Rows[0]["C_KHOILUONG"].ToString());
                            CUOCCHINH = decimal.Parse(oDataTableNew.Rows[0]["C_GIACUOC"].ToString());
                            FK_DOITAC = oDataTableNew.Rows[0]["FK_DOITAC"].ToString();
                            GIADOITAC = decimal.Parse(oDataTableNew.Rows[0]["C_GIADOITAC"].ToString());
                        }
                    }
                }
                else
                {
                    ClearSession();
                }
                Session["SaveAddNew"] = "False";
            }
            else
            {
                // edit item
                txtC_CONLAI.Text = (((txtC_TIENHANGVAT.Text == "") ? 0 : decimal.Parse(txtC_TIENHANGVAT.Text)) - ((txtC_DATHU.Text == "") ? 0 : decimal.Parse(txtC_DATHU.Text))).ToString();
                FK_DICHVU = cmbSanPham.SelectedValue;
                FK_QUANHUYEN = hfQuanHuyen.Value;
                FK_KHACHHANG = cmbMaKhachHang.SelectedValue;
                TENKH = txtC_TENKH.Text;
                DIENTHOAIKH = txtC_TELGUI.Text;
                string SelectSQL;
                SelectSQL = "Select DMKHACHHANG.FK_NHOMKHACHHANG,DMKHACHHANG.C_NAME,DMKHACHHANG.C_TEL FROM DMKHACHHANG WHERE DMKHACHHANG.C_CODE ='" + FK_KHACHHANG + "'";
                DataTable oDataTable = new DataTable();
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                oDataTable = SelectQuery.query_data(SelectSQL);
                if (oDataTable.Rows.Count != 0)
                {
                    FK_NHOMKHACHHANG = oDataTable.Rows[0]["FK_NHOMKHACHHANG"].ToString();
                    string SelectSQL2;
                    SelectSQL2 = "Select DMMABANGCUOC.PK_ID FROM DMMABANGCUOC WHERE ((DMMABANGCUOC.C_VALUE ='" + FK_NHOMKHACHHANG + "') OR (DMMABANGCUOC.C_VALUE LIKE '%," + FK_NHOMKHACHHANG + ",%') OR (DMMABANGCUOC.C_VALUE LIKE '%," + FK_NHOMKHACHHANG + "') OR (DMMABANGCUOC.C_VALUE LIKE '" + FK_NHOMKHACHHANG + ",%')) AND (DMMABANGCUOC.FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"].ToString() + "')";
                    DataTable oDataTable2 = new DataTable();
                    ITCLIB.Admin.SQL SelectQuery2 = new ITCLIB.Admin.SQL();
                    oDataTable2 = SelectQuery2.query_data(SelectSQL2);
                    if (oDataTable2.Rows.Count != 0)
                    {
                        FK_MABANGCUOC = oDataTable2.Rows[0]["PK_ID"].ToString();
                    }
                    else
                    {
                        FK_MABANGCUOC = "";
                    }
                }
                else
                {
                    FK_NHOMKHACHHANG = "";
                    FK_MABANGCUOC = "";
                }
                string SelectSQL3;
                SelectSQL3 = "Select DMMAVUNG.PK_ID FROM DMMAVUNG WHERE FK_MASANPHAM=" + FK_DICHVU + " AND FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"] + "' AND C_TYPE = 1 AND ((DMMAVUNG.C_DESC ='" + FK_QUANHUYEN + "') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUANHUYEN + ",%') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUANHUYEN + "') OR (DMMAVUNG.C_DESC LIKE '" + FK_QUANHUYEN + ",%')) AND (DMMAVUNG.FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"].ToString() + "')";
                DataTable oDataTable3 = new DataTable();
                ITCLIB.Admin.SQL SelectQuery3 = new ITCLIB.Admin.SQL();
                oDataTable3 = SelectQuery3.query_data(SelectSQL3);
                if (oDataTable3.Rows.Count != 0)
                {
                    FK_MAVUNG = oDataTable3.Rows[0]["PK_ID"].ToString();
                }
                else
                {
                    FK_MAVUNG = "";
                }
                PPXD = 0;
                string SelectSQL4;
                SelectSQL4 = "Select DMDICHVUPHUTROI.C_VALUE FROM DMDICHVUPHUTROI WHERE DMDICHVUPHUTROI.FK_MASANPHAM =" + FK_DICHVU + " AND DMDICHVUPHUTROI.FK_MABANGCUOC = " + FK_MABANGCUOC + " AND C_TYPE = N'PPXD'";
                DataTable oDataTable4 = new DataTable();
                ITCLIB.Admin.SQL SelectQuery4 = new ITCLIB.Admin.SQL();
                oDataTable4 = SelectQuery4.query_data(SelectSQL4);
                if (oDataTable4.Rows.Count != 0)
                {
                    if (oDataTable4.Rows[0]["C_VALUE"] != DBNull.Value)
                    {
                        PPXD = decimal.Parse(oDataTable4.Rows[0]["C_VALUE"].ToString());
                    }
                }
                C_KHOILUONG = (txtC_KHOILUONG.Text != "") ? int.Parse(txtC_KHOILUONG.Text) : 0;
                CUOCCHINH = (txtC_GIACUOC.Text == "") ? 0 : decimal.Parse(txtC_GIACUOC.Text);
                FK_DOITAC = cmbFK_DOITAC.SelectedValue;
                GIADOITAC = (txtC_GIADOITAC.Text == "") ? 0 : decimal.Parse(txtC_GIADOITAC.Text);
            }
        }
        if (e.Item is GridDataItem)
        {
            /*Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            lblSTT.Text = (e.Item.ItemIndex + 1).ToString();*/
        }
    }
    protected string GetMaxBill()
    {
        string maxbill = "00000001";
        string SelectSQL = "SELECT MAX(CAST(C_BILL AS DECIMAL)) as MAXBILL FROM NHANGUI";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);

        if (oDataTable.Rows[0]["MAXBILL"] != DBNull.Value)
        {
            decimal maxvalue = (decimal)oDataTable.Rows[0]["MAXBILL"];
            maxbill = String.Format("{0:0000000}", maxvalue + 1);
        }
        return maxbill;
    }
    protected void RadGridNHANGUI_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridNHANGUI.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridNHANGUI.Rebind();
            }
            foreach (GridDataItem item in RadGridNHANGUI.SelectedItems)
            {
                if (!ValidateDeleteGroup(item["C_BILLFIX"].Text.Replace("BC", "").Trim()))
                {
                    SetMessage("Không thể xóa nhận gửi \"" + item["c_name"].Text + "\" do có tham chiếu dữ liệu khác.");
                    RadGridNHANGUI.Rebind();
                }
            }
        }
        else if (e.CommandName == RadGrid.PerformInsertCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            NHANGUIDataSource.InsertParameters["FK_TRANGTHAI"].DefaultValue = "False";
        }
        else if (e.CommandName == RadGrid.UpdateCommandName)
        {
        }
        else if (e.CommandName == RadGrid.CancelAllCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            ClearSession();
        }
        else if (e.CommandName == RadGrid.CancelCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            ClearSession();
        }
        else if (e.CommandName == "ConfirmPayment")
        {
            string UpdateSQL = "";
            if (RadGridNHANGUI.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
            }
            else
            {

                foreach (GridDataItem item in RadGridNHANGUI.SelectedItems)
                {
                    string TIENHANG = (item["C_TIENHANGVAT"].Text.Trim() == "") ? "0" : item["C_TIENHANGVAT"].Text.Trim();
                    TIENHANG = TIENHANG.Replace(" ", "");
                    //UpdateSQL += "UPDATE [NHANGUI] SET [C_DATHU] = " + TIENHANG + ",[C_HINHTHUCTT] = N'Đã thanh toán' WHERE [C_BILL] = '" + (item["C_BILL"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "';UPDATE [SOQUYTIENMAT] SET [C_NGAY] = '" + String.Format("{0:yyyy-MM-dd hh:mm:ss tt}", System.DateTime.Now.ToUniversalTime().AddHours(7)) + "',[C_SOTIEN] = " + TIENHANG + " WHERE [C_BILL] = '" + (item["C_BILL"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "';";
                    UpdateSQL += "UPDATE [NHANGUI] SET [C_DATHU] = " + TIENHANG + ",[C_HINHTHUCTT] = N'Đã thanh toán' WHERE [C_BILL] = '" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "';IF (NOT EXISTS(SELECT C_BILL FROM SOQUYTIENMAT WHERE C_BILL = '" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "'))" +
                    " BEGIN" +
                    " INSERT INTO [SOQUYTIENMAT] ([C_NGAY], [C_TYPE], [FK_KIHIEUTAIKHOAN], [C_DESC], [C_SOTIEN], [C_BILL],[C_TON],[C_ORDER],[FK_VUNGLAMVIEC]) VALUES ('" + String.Format("{0:yyyy-MM-dd hh:mm:ss tt}", System.DateTime.Now.ToUniversalTime().AddHours(7)) + "',N'Thu',NULL, N'Bill ' + '" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "'," + TIENHANG + ",'" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "',0,1,N'" + Session["VUNGLAMVIEC"].ToString() + "')" +
                    " END" +
                    " ELSE" +
                    " BEGIN" +
                    " UPDATE [SOQUYTIENMAT] SET [C_NGAY] = '" + String.Format("{0:yyyy-MM-dd hh:mm:ss tt}", System.DateTime.Now.ToUniversalTime().AddHours(7)) + "',[C_SOTIEN] = " + TIENHANG + " WHERE [C_BILL] = '" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "'" +
                    " END;";
                }
                ITCLIB.Admin.SQL UpdateQuery = new ITCLIB.Admin.SQL();
                //Response.Write(UpdateSQL);
                UpdateQuery.ExecuteNonQuery(UpdateSQL);
            }
            SetMessage("Cập nhật tình trạng thanh toán thành công");
            RadGridNHANGUI.Rebind();
        }
        else if (e.CommandName == "ConfirmUnPayment")
        {
            if (RadGridNHANGUI.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
            }
            else
            {
                string UpdateSQL = "";
                foreach (GridDataItem item in RadGridNHANGUI.SelectedItems)
                {
                    string TIENHANG = (item["C_TIENHANGVAT"].Text.Trim() == "") ? "0" : item["C_TIENHANGVAT"].Text.Trim();
                    TIENHANG = TIENHANG.Replace(" ", "");
                    UpdateSQL += "UPDATE [NHANGUI] SET [C_DATHU] = " + "0" + ",[C_HINHTHUCTT] = N'Thanh toán sau' WHERE [C_BILL] = '" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "';UPDATE [SOQUYTIENMAT] SET [C_SOTIEN] = " + "0" + " WHERE [C_BILL] = '" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "';";
                }
                ITCLIB.Admin.SQL UpdateQuery = new ITCLIB.Admin.SQL();
                UpdateQuery.ExecuteNonQuery(UpdateSQL);
            }
            SetMessage("Cập nhật tình trạng thanh toán thành công");
            RadGridNHANGUI.Rebind();
        }
        else if (e.CommandName == "ClearFilterGrid")
        {
            RadGridNHANGUI.MasterTableView.FilterExpression = string.Empty;

            foreach (GridColumn column in RadGridNHANGUI.MasterTableView.RenderColumns)
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
            RadGridNHANGUI.MasterTableView.Rebind();
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
    protected bool ValidateDeleteGroup(string C_BILL)
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
    protected void cmbQuanHuyen_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        RadComboBox cmbQuanHuyen = (RadComboBox)sender;
        QUANHUYENDataSource.SelectCommand = LoadFilteredManually(e.Text);
        cmbQuanHuyen.DataBind();
    }
    protected string LoadFilteredManually(string ID)
    {
        string SelectSQL = "";
        if (ID != "")
        {
            SelectSQL = "SELECT * FROM DMQUANHUYEN WHERE FK_TINHTHANH = " + ID + "order by LTRIM(C_NAME)";
        }
        else
        {
            SelectSQL = "SELECT * FROM DMQUANHUYEN order by LTRIM(C_NAME)";
        }
        return SelectSQL;
    }
    protected void GiaCuocChinh()
    {
        string SelectSQL1;
        SelectSQL1 = "Select DMCHITIETCUOC.PK_ID,DMCHITIETCUOC.C_KHOILUONG,DMCHITIETCUOC.C_CUOCPHI,DMCHITIETCUOC.C_TYPE FROM DMCHITIETCUOC WHERE C_LOAITIEN = N'VND' AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND FK_MAVUNG = " + FK_MAVUNG + " AND C_TYPE <> 1 AND C_TYPE1 <> 1 ORDER BY C_KHOILUONG  ASC";
        ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
        ctcDataTable = SelectQuery1.query_data(SelectSQL1);
        string SelectSQL2;
        SelectSQL2 = "Select DMCHITIETCUOC.PK_ID,DMCHITIETCUOC.C_KHOILUONG,DMCHITIETCUOC.C_CUOCPHI,DMCHITIETCUOC.C_TYPE FROM DMCHITIETCUOC WHERE C_LOAITIEN = N'VND' AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND FK_MAVUNG = " + FK_MAVUNG + " AND C_TYPE = 1 AND C_TYPE1 <> 1 ORDER BY C_KHOILUONG";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery2 = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery2.query_data(SelectSQL2);
        if (oDataTable.Rows.Count != 0)
        {
            C_KHOILUONGLK = int.Parse(oDataTable.Rows[0]["C_KHOILUONG"].ToString(), NumberStyles.Currency);
            GIACUOCLK = decimal.Parse(oDataTable.Rows[0]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
        }
        else
        {
            C_KHOILUONGLK = 0;
            GIACUOCLK = 0;
        }
        string SelectSQL3;
        SelectSQL3 = "Select DMCHITIETCUOC.PK_ID,DMCHITIETCUOC.C_KHOILUONG,DMCHITIETCUOC.C_CUOCPHI,DMCHITIETCUOC.C_TYPE FROM DMCHITIETCUOC WHERE C_LOAITIEN = N'VND' AND FK_MABANGCUOC = " + FK_MABANGCUOC + " AND FK_MAVUNG = " + FK_MAVUNG + " AND C_TYPE1 = 1 ORDER BY C_KHOILUONG  ASC";
        ITCLIB.Admin.SQL SelectQuery3 = new ITCLIB.Admin.SQL();
        ctcDataTable1 = SelectQuery3.query_data(SelectSQL3);
        if (ctcDataTable1.Rows.Count != 0)
        {
            if (C_KHOILUONG < int.Parse(ctcDataTable1.Rows[0]["C_KHOILUONG"].ToString()))
            {
                if (ctcDataTable.Rows.Count != 0)
                {

                    bool check = true;
                    for (int i = 0; i < ctcDataTable.Rows.Count; i++)
                    {
                        if (check)
                        {
                            if (i == 0)
                            {
                                if (C_KHOILUONG <= int.Parse(ctcDataTable.Rows[0]["C_KHOILUONG"].ToString()))
                                {
                                    CUOCCHINH = decimal.Parse(ctcDataTable.Rows[0]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                }
                                if (C_KHOILUONG > int.Parse(ctcDataTable.Rows[0]["C_KHOILUONG"].ToString()) && ctcDataTable.Rows.Count == 1 && C_KHOILUONGLK != 0 && GIACUOCLK != 0)
                                {
                                    if (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) % C_KHOILUONGLK) == 0)
                                    {
                                        CUOCCHINH = decimal.Parse(ctcDataTable.Rows[0]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(ctcDataTable.Rows[0]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) * GIACUOCLK;
                                    }
                                    else
                                    {
                                        CUOCCHINH = decimal.Parse(ctcDataTable.Rows[0]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[0]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) + 1) * GIACUOCLK;
                                    }
                                }
                            }
                            else
                            {
                                if (C_KHOILUONG <= int.Parse(ctcDataTable.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG > int.Parse(ctcDataTable.Rows[i - 1]["C_KHOILUONG"].ToString()))
                                {
                                    CUOCCHINH = decimal.Parse(ctcDataTable.Rows[i]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                    check = false;
                                }
                                else if (C_KHOILUONG > int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString()))
                                {
                                    if (C_KHOILUONGLK != 0)
                                    {
                                        if (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) % C_KHOILUONGLK) == 0)
                                        {
                                            CUOCCHINH = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) * GIACUOCLK;
                                        }
                                        else
                                        {
                                            CUOCCHINH = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) + 1) * GIACUOCLK;
                                        }
                                    }
                                    else
                                    {
                                        CUOCCHINH = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                    }
                                    check = false;
                                }
                            }
                        }
                    }
                }
                else
                {
                    bool check1 = true;
                    for (int i = 0; i < ctcDataTable1.Rows.Count; i++)
                    {
                        if (check1)
                        {
                            if (i == 0)
                            {
                                CUOCCHINH = decimal.Parse(ctcDataTable1.Rows[0]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                            }
                            else
                            {
                                if (C_KHOILUONG < int.Parse(ctcDataTable1.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG >= int.Parse(ctcDataTable1.Rows[i - 1]["C_KHOILUONG"].ToString()))
                                {
                                    CUOCCHINH = decimal.Parse(ctcDataTable1.Rows[i - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                    check1 = false;
                                }
                                else if (C_KHOILUONG >= int.Parse(ctcDataTable1.Rows[ctcDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString()))
                                {
                                    CUOCCHINH = decimal.Parse(ctcDataTable1.Rows[ctcDataTable1.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                    check1 = false;
                                }
                            }

                        }
                    }
                }

            }
            else
            {
                bool check1 = true;
                for (int i = 0; i < ctcDataTable1.Rows.Count; i++)
                {
                    if (check1)
                    {
                        if (i == 0)
                        {
                            CUOCCHINH = decimal.Parse(ctcDataTable1.Rows[0]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                        }
                        else
                        {
                            if (C_KHOILUONG < int.Parse(ctcDataTable1.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG >= int.Parse(ctcDataTable1.Rows[i - 1]["C_KHOILUONG"].ToString()))
                            {
                                CUOCCHINH = decimal.Parse(ctcDataTable1.Rows[i - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                check1 = false;
                            }
                            else if (C_KHOILUONG >= int.Parse(ctcDataTable1.Rows[ctcDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString()))
                            {
                                CUOCCHINH = decimal.Parse(ctcDataTable1.Rows[ctcDataTable1.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                check1 = false;
                            }
                        }

                    }
                }
            }
        }
        else
        {
            if (ctcDataTable.Rows.Count != 0)
            {

                bool check = true;
                for (int i = 0; i < ctcDataTable.Rows.Count; i++)
                {
                    if (check)
                    {
                        if (i == 0)
                        {
                            if (C_KHOILUONG <= int.Parse(ctcDataTable.Rows[0]["C_KHOILUONG"].ToString()))
                            {
                                CUOCCHINH = decimal.Parse(ctcDataTable.Rows[0]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                            }
                            if (C_KHOILUONG > int.Parse(ctcDataTable.Rows[0]["C_KHOILUONG"].ToString()) && ctcDataTable.Rows.Count == 1 && C_KHOILUONGLK != 0 && GIACUOCLK != 0)
                            {
                                if (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) % C_KHOILUONGLK) == 0)
                                {
                                    CUOCCHINH = decimal.Parse(ctcDataTable.Rows[0]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(ctcDataTable.Rows[0]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) * GIACUOCLK;
                                }
                                else
                                {
                                    CUOCCHINH = decimal.Parse(ctcDataTable.Rows[0]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[0]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) + 1) * GIACUOCLK;
                                }
                            }

                        }
                        else
                        {
                            if (C_KHOILUONG <= int.Parse(ctcDataTable.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG > int.Parse(ctcDataTable.Rows[i - 1]["C_KHOILUONG"].ToString()))
                            {
                                CUOCCHINH = decimal.Parse(ctcDataTable.Rows[i]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                check = false;
                            }
                            else if (C_KHOILUONG > int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString()))
                            {
                                if (C_KHOILUONGLK != 0)
                                {
                                    if (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) % C_KHOILUONGLK) == 0)
                                    {
                                        CUOCCHINH = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) * GIACUOCLK;
                                    }
                                    else
                                    {
                                        CUOCCHINH = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) + 1) * GIACUOCLK;
                                    }
                                }
                                else
                                {
                                    CUOCCHINH = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                }
                                check = false;
                            }
                        }
                    }
                }
            }
        }
    }
    protected void GiaCuocDoiTac()
    {
        int C_KHOILUONGLKDT = 0;
        decimal GIACUOCLKDT = 0;
        string SelectSQL1;
        SelectSQL1 = "Select DMCHITIETCUOCDT.PK_ID,DMCHITIETCUOCDT.C_KHOILUONG,DMCHITIETCUOCDT.C_CUOCPHI,DMCHITIETCUOCDT.C_TYPE FROM DMCHITIETCUOCDT WHERE C_LOAITIEN = N'VND' AND FK_MAVUNG = " + FK_MAVUNGDT + " AND C_TYPE <> 1 AND C_TYPE1 <> 1 ORDER BY C_KHOILUONG  ASC";
        ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
        DataTable oDataTable1 = new DataTable();
        oDataTable1 = SelectQuery1.query_data(SelectSQL1);
        string SelectSQL2;
        SelectSQL2 = "Select DMCHITIETCUOCDT.PK_ID,DMCHITIETCUOCDT.C_KHOILUONG,DMCHITIETCUOCDT.C_CUOCPHI,DMCHITIETCUOCDT.C_TYPE FROM DMCHITIETCUOCDT WHERE C_LOAITIEN = N'VND' AND FK_MAVUNG = " + FK_MAVUNGDT + " AND C_TYPE = 1 AND C_TYPE1 <> 1 ORDER BY C_KHOILUONG  ASC";
        DataTable oDataTable2 = new DataTable();
        ITCLIB.Admin.SQL SelectQuery2 = new ITCLIB.Admin.SQL();
        oDataTable2 = SelectQuery2.query_data(SelectSQL2);
        if (oDataTable2.Rows.Count != 0)
        {
            C_KHOILUONGLKDT = int.Parse(oDataTable2.Rows[0]["C_KHOILUONG"].ToString(), NumberStyles.Currency);
            GIACUOCLKDT = decimal.Parse(oDataTable2.Rows[0]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
        }
        else
        {
            C_KHOILUONGLKDT = 0;
            GIACUOCLKDT = 0;
        }
        string SelectSQL3;
        SelectSQL3 = "Select DMCHITIETCUOCDT.PK_ID,DMCHITIETCUOCDT.C_KHOILUONG,DMCHITIETCUOCDT.C_CUOCPHI,DMCHITIETCUOCDT.C_TYPE FROM DMCHITIETCUOCDT WHERE C_LOAITIEN = N'VND' AND FK_MAVUNG = " + FK_MAVUNG + " AND C_TYPE1 = 1 ORDER BY C_KHOILUONG  ASC";
        ITCLIB.Admin.SQL SelectQuery3 = new ITCLIB.Admin.SQL();
        DataTable oDataTable3 = new DataTable();
        oDataTable3 = SelectQuery3.query_data(SelectSQL3);
        if (oDataTable3.Rows.Count != 0)
        {
            if (C_KHOILUONG < int.Parse(oDataTable3.Rows[0]["C_KHOILUONG"].ToString()))
            {
                if (oDataTable1.Rows.Count != 0)
                {
                    bool check = true;
                    for (int i = 0; i < oDataTable1.Rows.Count; i++)
                    {
                        if (check)
                        {
                            if (i == 0)
                            {
                                if (C_KHOILUONG <= int.Parse(oDataTable1.Rows[0]["C_KHOILUONG"].ToString()))
                                {
                                    GIADOITAC = decimal.Parse(oDataTable1.Rows[0]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                }
                            }
                            else
                            {
                                if (C_KHOILUONG <= int.Parse(oDataTable1.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG > int.Parse(oDataTable1.Rows[i - 1]["C_KHOILUONG"].ToString()))
                                {
                                    GIADOITAC = decimal.Parse(oDataTable1.Rows[i]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                    check = false;
                                }
                                else if (C_KHOILUONG > int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString()))
                                {
                                    if (C_KHOILUONGLKDT != 0)
                                    {
                                        if (((C_KHOILUONG - int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString())) % C_KHOILUONGLKDT) == 0)
                                        {
                                            GIADOITAC = decimal.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLKDT) * GIACUOCLKDT;
                                        }
                                        else
                                        {
                                            GIADOITAC = decimal.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLKDT) + 1) * GIACUOCLKDT;
                                        }
                                    }
                                    else
                                    {
                                        GIADOITAC = decimal.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                    }
                                    check = false;
                                }
                            }
                        }
                    }
                }
                else
                {
                    bool check1 = true;
                    for (int i = 0; i < oDataTable3.Rows.Count; i++)
                    {
                        if (check1)
                        {
                            if (i == 0)
                            {
                                GIADOITAC = decimal.Parse(oDataTable1.Rows[0]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                            }
                            else
                            {
                                if (C_KHOILUONG < int.Parse(oDataTable3.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG >= int.Parse(oDataTable3.Rows[i - 1]["C_KHOILUONG"].ToString()))
                                {
                                    GIADOITAC = decimal.Parse(oDataTable3.Rows[i - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                    check1 = false;
                                }
                                else if (C_KHOILUONG >= int.Parse(oDataTable3.Rows[oDataTable3.Rows.Count - 1]["C_KHOILUONG"].ToString()))
                                {
                                    GIADOITAC = decimal.Parse(oDataTable3.Rows[oDataTable3.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                    check1 = false;
                                }
                            }
                        }
                    }
                }

            }
            else
            {
                bool check1 = true;
                for (int i = 0; i < oDataTable3.Rows.Count; i++)
                {
                    if (check1)
                    {
                        if (i == 0)
                        {
                            GIADOITAC = decimal.Parse(oDataTable1.Rows[0]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                        }
                        else
                        {
                            if (C_KHOILUONG < int.Parse(oDataTable3.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG >= int.Parse(oDataTable3.Rows[i - 1]["C_KHOILUONG"].ToString()))
                            {
                                GIADOITAC = decimal.Parse(oDataTable3.Rows[i - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                check1 = false;
                            }
                            else if (C_KHOILUONG >= int.Parse(oDataTable3.Rows[oDataTable3.Rows.Count - 1]["C_KHOILUONG"].ToString()))
                            {
                                GIADOITAC = decimal.Parse(oDataTable3.Rows[oDataTable3.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                check1 = false;
                            }
                        }
                    }
                }
            }
        }
        else
        {
            if (oDataTable1.Rows.Count != 0)
            {

                bool check = true;
                for (int i = 0; i < oDataTable1.Rows.Count; i++)
                {
                    if (check)
                    {
                        if (i == 0)
                        {
                            if (C_KHOILUONG <= int.Parse(oDataTable1.Rows[0]["C_KHOILUONG"].ToString()))
                            {
                                GIADOITAC = decimal.Parse(oDataTable1.Rows[0]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                            }
                        }
                        else
                        {
                            if (C_KHOILUONG <= int.Parse(oDataTable1.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG > int.Parse(oDataTable1.Rows[i - 1]["C_KHOILUONG"].ToString()))
                            {
                                GIADOITAC = decimal.Parse(oDataTable1.Rows[i]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                check = false;
                            }
                            else if (C_KHOILUONG > int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString()))
                            {
                                if (C_KHOILUONGLKDT != 0)
                                {
                                    if (((C_KHOILUONG - int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString())) % C_KHOILUONGLKDT) == 0)
                                    {
                                        GIADOITAC = decimal.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLKDT) * GIACUOCLKDT;
                                    }
                                    else
                                    {
                                        GIADOITAC = decimal.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLKDT) + 1) * GIACUOCLKDT;
                                    }
                                }
                                else
                                {
                                    GIADOITAC = decimal.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                }
                                check = false;
                            }
                        }
                    }
                }
            }
        }
    }
    protected void ClearSession()
    {
        FK_NHOMKHACHHANG = "";
        FK_KHACHHANG = "";
        TENKH = "";
        DIENTHOAIKH = "";
        FK_DICHVU = "";
        FK_MABANGCUOC = "";
        FK_QUANHUYEN = "";
        FK_MAVUNG = "";
        FK_MAVUNGDT = "";
        C_KHOILUONG = 0;
        PPXD = 0;
        VAT = 0;
        CUOCCHINH = 0;
        FK_DOITAC = "";
        GIADOITAC = 0;
        ctcDataTable = new DataTable();
        ctcDataTable1 = new DataTable();
        C_KHOILUONGLK = 0;
        GIACUOCLK = 0;
        Alarm = "";
        Session["MAXID"] = "";
        DONGGOIX = 0;
        DONGGOIY = 0;
        KHAIGIAX = 0;
        KHAIGIAY = 0;
        HENGIOX = 0;
        HENGIOY = 0;
        BAOPHATX = 0;
        BAOPHATY = 0;
        CODX = 0;
        CODY = 0;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //TextBox1.Text = Session["t"].ToString();
        //ITCLIB.Admin.JavaScript.ShowMessage(Session["t"].ToString(), this);
    }
    protected void txtBillNhanh_TextChanged(object sender, EventArgs e)
    {
        if (txtBillNhanh.Text.Trim() != "")
        {
            string InsertSQL;
            if (CheckBillQuick(txtBillNhanh.Text.Trim()))
            {
                if (cmbDoiTac.SelectedIndex > -1)
                {
                    InsertSQL = "INSERT INTO [NHANGUI] ([C_NGAY], [C_BILL], [C_NGAYGIONHAN], [FK_DOITAC], [C_TYPE], [FK_VUNGLAMVIEC]) VALUES ('" + System.DateTime.Now + "','" + txtBillNhanh.Text + "','" + System.DateTime.Now.Date + "'," + cmbDoiTac.SelectedValue + ", 1,N'" + Session["VUNGLAMVIEC"].ToString() + "');INSERT INTO [SOQUYTIENMAT] ([C_NGAY], [C_TYPE], [FK_KIHIEUTAIKHOAN], [C_DESC], [C_SOTIEN], [C_BILL],[C_TON],[C_ORDER],[FK_VUNGLAMVIEC]) VALUES ('" + System.DateTime.Now + "',N'Thu',NULL, N'Bill ' + '" + txtBillNhanh.Text + "',0 ,'" + txtBillNhanh.Text + "',0,1,N'" + Session["VUNGLAMVIEC"].ToString() + "');INSERT INTO TRACKING (C_BILL, C_DATE, FK_TRANGTHAI) SELECT '" + txtBillNhanh.Text + "', '" + System.DateTime.Now.Date + "', N'F' UNION ALL SELECT '" + txtBillNhanh.Text + "', '" + System.DateTime.Now + "',N'G_" + Session["VUNGLAMVIEC"].ToString() + "'";
                }
                else
                {
                    InsertSQL = "INSERT INTO [NHANGUI] ([C_NGAY], [C_BILL], [C_NGAYGIONHAN], [C_TYPE], [FK_VUNGLAMVIEC]) VALUES ('" + System.DateTime.Now + "','" + txtBillNhanh.Text + "','" + System.DateTime.Now.Date + "', 1,N'" + Session["VUNGLAMVIEC"].ToString() + "');INSERT INTO [SOQUYTIENMAT] ([C_NGAY], [C_TYPE], [FK_KIHIEUTAIKHOAN], [C_DESC], [C_SOTIEN], [C_BILL],[C_TON],[C_ORDER],[FK_VUNGLAMVIEC]) VALUES ('" + System.DateTime.Now + "',N'Thu',NULL, N'Bill ' + '" + txtBillNhanh.Text + "',0 ,'" + txtBillNhanh.Text + "',0,1,N'" + Session["VUNGLAMVIEC"].ToString() + "');INSERT INTO TRACKING (C_BILL, C_DATE, FK_TRANGTHAI) SELECT '" + txtBillNhanh.Text + "', '" + System.DateTime.Now.Date + "', N'F' UNION ALL SELECT '" + txtBillNhanh.Text + "', '" + System.DateTime.Now + "',N'G_" + Session["VUNGLAMVIEC"].ToString() + "'";
                }
                ITCLIB.Admin.SQL InsertQuery = new ITCLIB.Admin.SQL();
                InsertQuery.ExecuteNonQuery(InsertSQL);
            }
            else
            {
                SetMessage("Bill đã có trong cơ sở dữ liệu");
            }
            txtBillNhanh.Text = "";
            txtBillNhanh.Focus();
            RadGridNHANGUI.Rebind();
        }
    }
    protected bool CheckBillQuick(string C_BILL)
    {
        string SelectSQL;
        SelectSQL = "Select NHANGUI.C_BILL FROM NHANGUI WHERE NHANGUI.C_BILL = '" + C_BILL + "'";
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
    }
    protected void RadGridNHANGUI_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridPagerItem)
        {
            RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
            RadComboBoxItem item = new RadComboBoxItem("100", "100");
            item.Attributes.Add("ownerTableViewId", RadGridNHANGUI.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("100") == null) cb.Items.Add(item);
            item = new RadComboBoxItem("200", "200");
            item.Attributes.Add("ownerTableViewId", RadGridNHANGUI.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("200") == null) cb.Items.Add(item);
            item = new RadComboBoxItem("500", "500");
            item.Attributes.Add("ownerTableViewId", RadGridNHANGUI.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("500") == null) cb.Items.Add(item);
            cb.Items.Sort(new PagerRadComboBoxItemComparer());
            cb.Items.FindItemByValue(RadGridNHANGUI.PageSize.ToString()).Selected = true;
        }
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            //LinkButton btnSave = (LinkButton)e.Item.FindControl("btnSave");
            LinkButton btnSaveAddNew = (LinkButton)e.Item.FindControl("btnSaveAddNew");
            btnSaveAddNew.Click += new EventHandler(btnSaveAddNew_Click);
            //btnSave.Click += new EventHandler(btnSave_Click);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Session["SaveAddNew"] = "False";
    }
    protected void btnSaveAddNew_Click(object sender, EventArgs e)
    {
        Session["SaveAddNew"] = "True";
    }
    public class PagerRadComboBoxItemComparer : IComparer<RadComboBoxItem>, IComparer
    {
        public int Compare(RadComboBoxItem x, RadComboBoxItem y)
        {

            int rValue = 0;
            int lValue = 0;

            if (Int32.TryParse(x.Value, out lValue) && Int32.TryParse(y.Value, out rValue))
            {
                return lValue.CompareTo(rValue);
            }
            else
            {
                return x.Value.CompareTo(y.Value);
            }
        }
        public int Compare(object x, object y)
        {
            return Compare((RadComboBoxItem)x, (RadComboBoxItem)y);
        }
    }
    protected void btnImport_Click(object sender, EventArgs e)
    {
        //lblMessage.Text = RadAsyncUploadImport.TemporaryFolder + RadAsyncUploadImport.UploadedFiles[0].FileName;
        if (RadAsyncUploadImport.UploadedFiles.Count != 0)
        {
            System.IO.Stream stream = RadAsyncUploadImport.UploadedFiles[0].InputStream;
            IExcelDataReader excelReader;
            if (RadAsyncUploadImport.UploadedFiles[0].GetExtension() == ".xls")
            {
                excelReader = ExcelReaderFactory.CreateBinaryReader(stream);
            }
            else
            {
                excelReader = ExcelReaderFactory.CreateOpenXmlReader(stream);
            }

            //excelReader.IsFirstRowAsColumnNames = true;
            DataSet result = excelReader.AsDataSet();
            excelReader.Close();
            excelReader.Close();
            DataTable oDataTable = new DataTable();
            oDataTable = result.Tables[0];
            if (oDataTable.Rows.Count != 0)
            {
                string BillFilter = "";
                string CheckSQL = "";
                for (int i = 0; i < oDataTable.Rows.Count; i++)
                {
                    if (i == 0)
                    {
                        BillFilter = "'" + oDataTable.Rows[i][0].ToString().Trim() + "'";
                        CheckSQL = "SELECT (CASE WHEN EXISTS (SELECT C_BILL FROM NHANGUI WHERE C_TYPE = 1 AND FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"].ToString() + "' AND C_BILL='" + oDataTable.Rows[i][0].ToString().Trim() + "') THEN 'True' ELSE '" + oDataTable.Rows[i][0].ToString().Trim() + "' END) as C_BILL";
                    }
                    else
                    {
                        BillFilter += ",'" + oDataTable.Rows[i][0].ToString().Trim() + "'";
                        CheckSQL += " UNION ALL " + "SELECT (CASE WHEN EXISTS (SELECT C_BILL FROM NHANGUI WHERE C_TYPE = 1 AND FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"].ToString() + "' AND C_BILL='" + oDataTable.Rows[i][0].ToString().Trim() + "') THEN 'True' ELSE '" + oDataTable.Rows[i][0].ToString().Trim() + "' END) as C_BILL";
                    }
                }
                RadGridNHANGUI.MasterTableView.FilterExpression = "([C_BILL] IN (" + BillFilter + "))";
                RadGridNHANGUI.Rebind();
                string CheckResult = "";
                DataTable oDataTableCheck = new DataTable();
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                oDataTableCheck = SelectQuery.query_data(CheckSQL);
                if (oDataTableCheck.Rows.Count != 0)
                {
                    for (int i = 0; i < oDataTableCheck.Rows.Count; i++)
                    {
                        if (oDataTableCheck.Rows[i]["C_BILL"].ToString() != "True")
                        {
                            if (CheckResult == "")
                            {
                                CheckResult = oDataTableCheck.Rows[i]["C_BILL"].ToString();
                            }
                            else
                            {
                                CheckResult += "," + oDataTableCheck.Rows[i]["C_BILL"].ToString();
                            }
                        }
                    }
                }
                lblMessage.Text = "Các Bill: " + CheckResult + " không có trong cơ sở dữ liệu";
            }
        }
        else
        {
            //lblMessage.Text = "Hãy chọn file Excel để lọc dữ liệu";
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        RadGridNHANGUI.MasterTableView.FilterExpression = string.Empty;
        lblMessage.Text = "";
        RadGridNHANGUI.Rebind();
    }
    protected void btnAddExcell_Click(object sender, EventArgs e)
    {
        if (RadAsyncUploadAddExcel.UploadedFiles.Count != 0)
        {
            System.IO.Stream stream = RadAsyncUploadAddExcel.UploadedFiles[0].InputStream;
            IExcelDataReader excelReader;
            if (RadAsyncUploadAddExcel.UploadedFiles[0].GetExtension() == ".xls")
            {
                excelReader = ExcelReaderFactory.CreateBinaryReader(stream);
            }
            else
            {
                excelReader = ExcelReaderFactory.CreateOpenXmlReader(stream);
            }
            excelReader.IsFirstRowAsColumnNames = true;
            DataSet result = excelReader.AsDataSet();
            excelReader.Close();
            excelReader.Close();
            DataTable oDataTable = new DataTable();
            oDataTable = result.Tables[0];
            if (oDataTable.Rows.Count >= 2)
            {
                bool check = true;
                int BillCount = 0;
                string insertSQL = "";
                string HasBillString = "";
                for (int i = 0; i < oDataTable.Rows.Count; i++)
                {
                    string C_BILL = oDataTable.Rows[i][1].ToString().Trim();
                    if (C_BILL != "")
                    {
                        try
                        {
                            int C_KHOILUONG = int.Parse((oDataTable.Rows[i][2].ToString().Trim() == "" ? "0" : oDataTable.Rows[i][2].ToString().Trim()));
                            //string C_TINHTHANH = ITCLIB.Admin.cFunction.LoadIDTinhThanhName(oDataTable.Rows[i][3].ToString().Trim());
                            string C_HINHTHUCTT;
                            decimal C_TIENHANGVAT = 0;
                            if (oDataTable.Rows[i][4].ToString().Trim() != "")
                            {
                                C_HINHTHUCTT = "N'Thanh toán đầu nhận'";
                                C_TIENHANGVAT = decimal.Parse((oDataTable.Rows[i][4].ToString().Trim() == "" ? "0" : oDataTable.Rows[i][4].ToString().Trim()));
                            }
                            else
                            {
                                C_HINHTHUCTT = "NULL";
                                C_TIENHANGVAT = 0;
                            }
                            decimal C_TIENTHUHO = decimal.Parse((oDataTable.Rows[i][5].ToString().Trim() == "" ? "0" : oDataTable.Rows[i][5].ToString().Trim()));
                            //var formats = new[] { "d/MM/yyyy", "dd/M/yyyy", "dd/MM/yyyy", "d/M/yyyy hh:mm:ss tt", "d/MM/yyyy hh:mm:ss tt", "dd/M/yyyy hh:mm:ss tt", "dd/MM/yyyy hh:mm:ss tt"};
                            DateTime C_NGAY = Convert.ToDateTime(oDataTable.Rows[i][6].ToString().Trim());
                            //DateTime C_NGAY = DateTime.ParseExact(oDataTable.Rows[i][6].ToString().Trim(), formats, System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.AssumeLocal);
                            DateTime C_NGAYGIONHAN = C_NGAY;
                            string FK_DOITAC = ITCLIB.Admin.cFunction.LoadIDDoiTacName(oDataTable.Rows[i][7].ToString().Trim());
                            string C_DIENGIAIDOITAC = oDataTable.Rows[i][8].ToString().Trim();
                            decimal C_GIADOITAC = decimal.Parse((oDataTable.Rows[i][9].ToString().Trim() == "" ? "0" : oDataTable.Rows[i][9].ToString().Trim()));
                            if (CheckBillQuick(C_BILL))
                            {
                                insertSQL += "INSERT INTO [NHANGUI] ([C_NGAY], [C_BILL], [C_TIENTHUHO], [C_KHOILUONG], [C_HINHTHUCTT], [C_TIENHANGVAT], [C_NGAYGIONHAN], [FK_DOITAC], [C_GIADOITAC], [C_DIENGIAIDOITAC], [C_TYPE], [FK_VUNGLAMVIEC], [FK_USERADD]) VALUES ('" + String.Format("{0:yyyy-MM-dd hh:mm:ss tt}", C_NGAY) + "', '" + C_BILL + "', " + C_TIENTHUHO + ", " + C_KHOILUONG + ", " + C_HINHTHUCTT + ", " + C_TIENHANGVAT + ", '" + String.Format("{0:yyyy-MM-dd hh:mm:ss tt}", C_NGAYGIONHAN) + "', " + FK_DOITAC + ", " + C_GIADOITAC + ", N'" + C_DIENGIAIDOITAC + "' , 1, N'" + Session["VUNGLAMVIEC"] + "', " + Session["UserID"] + ");INSERT INTO [SOQUYTIENMAT] ([C_NGAY], [C_TYPE], [FK_KIHIEUTAIKHOAN], [C_DESC], [C_SOTIEN], [C_BILL],[C_TON],[C_ORDER],[FK_VUNGLAMVIEC]) VALUES ('" + String.Format("{0:yyyy-MM-dd hh:mm:ss tt}", C_NGAY) + "',N'Thu',NULL, N'Bill ' + '" + C_BILL + "', 0, '" + C_BILL + "', 0, 1, N'" + Session["VUNGLAMVIEC"] + "');INSERT INTO TRACKING (C_BILL, C_DATE, FK_TRANGTHAI) SELECT '" + C_BILL + "', '" + String.Format("{0:yyyy-MM-dd hh:mm:ss tt}", C_NGAYGIONHAN) + "', N'F' UNION ALL SELECT '" + C_BILL + "', '" + String.Format("{0:yyyy-MM-dd hh:mm:ss tt}", C_NGAY) + "',N'G_' + N'" + Session["VUNGLAMVIEC"] + "';";
                                BillCount += 1;
                            }
                            else
                            {
                                HasBillString += C_BILL + " ";
                            }
                        }
                        catch (FormatException format1)
                        {
                            lblMessageAddExcell.Text = "Dữ liệu tại dòng thứ " + (i + 1) + " không đúng định dạng." + format1.Message + oDataTable.Rows[i][6].ToString().Trim();
                            check = false;
                            break;
                        }
                        catch (ArgumentNullException format2)
                        {
                            lblMessageAddExcell.Text = "không có dữ liệu tại dòng thứ " + (i + 1) + "." + format2.Message;
                            check = false;
                            break;
                        }
                        finally
                        {

                        }
                    }
                }
                if (check)
                {
                    ITCLIB.Admin.SQL InsertQuery = new ITCLIB.Admin.SQL();
                    //lblMessageAddExcell.Text = insertSQL;
                    if (InsertQuery.ExecuteNonQuery(insertSQL) != 0)
                    {
                        lblMessageAddExcell.Text = "Thêm mới thành công " + BillCount + " Bill" + (HasBillString == "" ? "" : ". BILL " + HasBillString + "đã tồn tại trong cơ sở dữ liệu");
                        RadGridNHANGUI.Rebind();
                    }
                    else
                    {
                        lblMessageAddExcell.Text = "Lỗi Import vào CSDL";
                    }
                }
            }
            else
            {
                lblMessageAddExcell.Text = "File Excell không có dữ liệu";
            }
        }
        else
        {
            //lblMessageAddExcell.Text = "Hãy chọn file Excel để thêm dữ liệu";
        }
    }
}