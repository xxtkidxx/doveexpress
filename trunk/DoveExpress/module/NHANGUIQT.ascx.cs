using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;
using System.Globalization;
using System.Xml;
using System.Collections;
using Excel;

public partial class module_NHANGUIQT : System.Web.UI.UserControl
{
    #region Biến toàn cục
    private string FK_NHOMKHACHHANGQT
    {
        get
        {
            return Session["FK_NHOMKHACHHANGQT"] as string;
        }
        set
        {
            Session["FK_NHOMKHACHHANGQT"] = value;
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
    private decimal C_VALUE1
    {
        get
        {
            return decimal.Parse(Session["C_VALUE1"].ToString());
        }
        set
        {
            Session["C_VALUE1"] = value;
        }
    }
    private decimal C_VALUE2
    {
        get
        {
            return decimal.Parse(Session["C_VALUE2"].ToString());
        }
        set
        {
            Session["C_VALUE2"] = value;
        }
    }
    private string FK_QUOCGIA
    {
        get
        {
            return Session["FK_QUOCGIA"] as string;
        }
        set
        {
            Session["FK_QUOCGIA"] = value;
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
    private decimal CUOCCHINHTL
    {
        get
        {
            return decimal.Parse(Session["CUOCCHINHTL"].ToString());
        }
        set
        {
            Session["CUOCCHINHTL"] = value;
        }
    }
    private string FK_DICHVUDOITAC
    {
        get
        {
            return Session["FK_DICHVUDOITAC"] as string;
        }
        set
        {
            Session["FK_DICHVUDOITAC"] = value;
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
    private decimal GIADOITACTL
    {
        get
        {
            return decimal.Parse(Session["GIADOITACTL"].ToString());
        }
        set
        {
            Session["GIADOITACTL"] = value;
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
    private decimal GIACUOCLKTL
    {
        get
        {
            return decimal.Parse(Session["GIACUOCLKTL"].ToString());
        }
        set
        {
            Session["GIACUOCLKTL"] = value;
        }
    }
    private bool isTAILIEU
    {
        get
        {
            return bool.Parse(Session["isTAILIEU"].ToString());
        }
        set
        {
            Session["isTAILIEU"] = value;
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
                RadGridNHANGUIQT.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridNHANGUIQT.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridNHANGUIQT.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("NHANGUI"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
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
        foreach (GridEditFormItem item in RadGridNHANGUIQT.MasterTableView.GetItems(GridItemType.EditFormItem))
        {
            if (item.IsInEditMode)
            {
                editableItem = (GridEditableItem)item;
            }
        }
        RadNumericTextBox txtPPXD = (RadNumericTextBox)editableItem.FindControl("txtPPXD");
        RadTextBox txtCODE = (RadTextBox)editableItem.FindControl("txtCODE");
        RadAutoCompleteBox radautoC_MAKH = (RadAutoCompleteBox)editableItem.FindControl("radautoC_MAKH");
        RadAutoCompleteBox radautoC_TENKH = (RadAutoCompleteBox)editableItem.FindControl("radautoC_TENKH");
        RadNumericTextBox txtC_KHOILUONG = (RadNumericTextBox)editableItem.FindControl("txtC_KHOILUONG");
        string[] arrayvalue = e.Argument.Split(';');
        if ((arrayvalue[0] == "cmbMaKhachHang") && (FK_KHACHHANG != arrayvalue[1]))
        {
            FK_KHACHHANG = arrayvalue[1];
            string SelectSQL;
            SelectSQL = "Select DMKHACHHANG.FK_NHOMKHACHHANGQT,DMKHACHHANG.C_NAME,DMKHACHHANG.C_TEL FROM DMKHACHHANG WHERE DMKHACHHANG.C_CODE ='" + FK_KHACHHANG + "'";
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                FK_NHOMKHACHHANGQT = oDataTable.Rows[0]["FK_NHOMKHACHHANGQT"].ToString();
                TENKH = oDataTable.Rows[0]["C_NAME"].ToString();
                DIENTHOAIKH = oDataTable.Rows[0]["C_TEL"].ToString();
                string SelectSQL1;
                SelectSQL1 = "Select DMMABANGCUOCQT.FK_DOITAC,DMMABANGCUOCQT.C_VALUE1,DMMABANGCUOCQT.C_VALUE2 FROM DMMABANGCUOCQT WHERE ((DMMABANGCUOCQT.C_VALUE ='" + FK_NHOMKHACHHANGQT + "') OR (DMMABANGCUOCQT.C_VALUE LIKE '%," + FK_NHOMKHACHHANGQT + ",%') OR (DMMABANGCUOCQT.C_VALUE LIKE '%," + FK_NHOMKHACHHANGQT + "') OR (DMMABANGCUOCQT.C_VALUE LIKE '" + FK_NHOMKHACHHANGQT + ",%')) AND (DMMABANGCUOCQT.FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"].ToString() + "')";
                DataTable oDataTable1 = new DataTable();
                ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
                oDataTable1 = SelectQuery1.query_data(SelectSQL1);
                if (oDataTable1.Rows.Count != 0)
                {
                    FK_MABANGCUOC = oDataTable1.Rows[0]["FK_DOITAC"].ToString();
                    C_VALUE1 = decimal.Parse(oDataTable1.Rows[0]["C_VALUE1"].ToString());
                    C_VALUE2 = decimal.Parse(oDataTable1.Rows[0]["C_VALUE2"].ToString());
                }
                else
                {
                    FK_MABANGCUOC = "";
                    C_VALUE1 = 0;
                    C_VALUE2 = 0;
                    Alarm = "msg,-,Nhóm khách hàng này không nằm trong bảng cước nào trong khu vực làm việc " + Session["VUNGLAMVIEC"].ToString() + ",-," + TENKH + ",-," + DIENTHOAIKH;
                }
            }
            else
            {
                FK_NHOMKHACHHANGQT = "";
                TENKH = "";
                DIENTHOAIKH = "";
                Alarm = "msg,-,Mã khách hàng này không nằm trong nhóm khách hàng nào";
            }
            isCuocchinh = true;
        }
        else if ((arrayvalue[0] == "cmbQuocGia") && (FK_QUOCGIA != arrayvalue[1]))
        {
            FK_QUOCGIA = arrayvalue[1];
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
            string SelectSQL1;
            SelectSQL1 = "Select DMPPXDDT.C_PPXD FROM DMPPXDDT WHERE DMPPXDDT.FK_MASANPHAM =" + FK_DICHVU + " AND FK_DOITAC = " + FK_MABANGCUOC;
            DataTable oDataTable1 = new DataTable();
            ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
            oDataTable1 = SelectQuery1.query_data(SelectSQL1);
            if (oDataTable1.Rows.Count != 0)
            {
                if (oDataTable1.Rows[0]["C_PPXD"] != DBNull.Value)
                {
                    PPXD = decimal.Parse(oDataTable1.Rows[0]["C_PPXD"].ToString());
                }
                else
                {
                    PPXD = 0;
                }
            }
            if (FK_QUOCGIA != "")
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
        }
        else if ((arrayvalue[0] == "cmbFK_DOITAC") && (FK_DOITAC != arrayvalue[1]))
        {
            FK_DOITAC = arrayvalue[1];
            if (FK_QUOCGIA != "" && FK_DICHVU != "")
            {
                LoadMaVungDT();
            }
        }
        else if ((arrayvalue[0] == "cmbFK_DICHVUDOITAC") && (FK_DICHVUDOITAC != arrayvalue[1]))
        {
            FK_DICHVUDOITAC = arrayvalue[1];
            isCuocdoitac = true;
        }
        else if (arrayvalue[0] == "cmbC_TAILIEU")
        {
            if (arrayvalue[1] == "Tài liệu")
            {
                isTAILIEU = true;
            }
            else
            {
                isTAILIEU = false;
            }
            if (CUOCCHINH == 0 || CUOCCHINHTL == 0)
            {
                isCuocchinh = true;
            }
            if (GIADOITAC == 0 || GIADOITACTL == 0)
            {
                isCuocdoitac = true;
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
        if (Alarm != "")
        {
            string script = string.Format("var result = '{0}'", Alarm);
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
        }
        else
        {
            string script = "";
            if (isTAILIEU)
            {
                script = string.Format("var result = '{0}'", FK_KHACHHANG + ",-," + TENKH + ",-," + DIENTHOAIKH + ",-," + PPXD + ",-," + CUOCCHINHTL + ",-," + GIADOITACTL + ",-," + FK_MABANGCUOC + ",-," + FK_MAVUNG + ",-," + FK_MAVUNGDT + ",-," + FK_DOITAC);
            }
            else
            {
                script = string.Format("var result = '{0}'", FK_KHACHHANG + ",-," + TENKH + ",-," + DIENTHOAIKH + ",-," + PPXD + ",-," + CUOCCHINH + ",-," + GIADOITAC + ",-," + FK_MABANGCUOC + ",-," + FK_MAVUNG + ",-," + FK_MAVUNGDT + ",-," + FK_DOITAC);
            }
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
        }
    }
    protected void LoadMaVung()
    {
        string SelectSQL;
        SelectSQL = "Select DMMAVUNG.PK_ID FROM DMMAVUNG WHERE FK_MASANPHAM=" + FK_DICHVU + " AND C_TYPE = 2 AND ((DMMAVUNG.C_DESC ='" + FK_QUOCGIA + "') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUOCGIA + ",%') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUOCGIA + "') OR (DMMAVUNG.C_DESC LIKE '" + FK_QUOCGIA + ",%')) AND (DMMAVUNG.FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"].ToString() + "')";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            FK_MAVUNG = oDataTable.Rows[0]["PK_ID"].ToString();
        }
        else
        {
            FK_MAVUNG = "";
            Alarm = "msg,-,Quốc gia này không nằm trong vùng tính cước nào";
        }
    }
    protected void LoadMaVungDT()
    {
        isCuocdoitac = true;
        if (FK_DICHVUDOITAC == "")
        {
            FK_DICHVUDOITAC = FK_DICHVU;
        }
        string SelectSQL;
        SelectSQL = "Select DMMAVUNGDT.PK_ID FROM DMMAVUNGDT WHERE FK_MASANPHAM = " + FK_DICHVUDOITAC + " AND FK_DOITAC = " + FK_DOITAC + " AND C_TYPE = 2 AND ((DMMAVUNGDT.C_DESC = '" + FK_QUOCGIA + "') OR (DMMAVUNGDT.C_DESC LIKE '%," + FK_QUOCGIA + ",%') OR (DMMAVUNGDT.C_DESC LIKE '%," + FK_QUOCGIA + "') OR (DMMAVUNGDT.C_DESC LIKE '" + FK_QUOCGIA + ",%')) AND (DMMAVUNGDT.FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"].ToString() + "')";
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
        RadGridNHANGUIQT.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridNHANGUIQT.MasterTableView.RenderColumns)
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
        RadGridNHANGUIQT.MasterTableView.Rebind();
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
        RadGridNHANGUIQT.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridNHANGUIQT_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridNHANGUIQT_ItemDeleted(object sender, GridDeletedEventArgs e)
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
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted NHANGUIQTs", e.Item.KeyValues);
        }
    }
    protected void RadGridNHANGUIQT_ItemInserted(object sender, GridInsertedEventArgs e)
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
            Session["MAXIDQT"] = getmaxid("NHANGUI");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted NHANGUIQTs", "{PK_ID:\"" + Session["MAXIDQT"].ToString() + "\"}");
        }
    }
    protected void RadGridNHANGUIQT_ItemUpdated(object sender, GridUpdatedEventArgs e)
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
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated NHANGUIQTs", e.Item.KeyValues);
        }
    }
    protected void RadGridNHANGUIQT_ItemDataBound(object sender, GridItemEventArgs e)
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
            RadComboBox cmbQuocGia = (RadComboBox)editItem.FindControl("cmbQuocGia");
            RadComboBox cmbC_TAILIEU = (RadComboBox)editItem.FindControl("cmbC_TAILIEU");
            RadNumericTextBox txtPPXD = (RadNumericTextBox)editItem.FindControl("txtPPXD");
            txtPPXD.Text = (txtPPXD.Text == "") ? "0" : txtPPXD.Text;
            RadTextBox txtCODE = (RadTextBox)editItem.FindControl("txtCODE");
            RadNumericTextBox txtC_TYGIA = (RadNumericTextBox)editItem.FindControl("txtC_TYGIA");
            txtC_TYGIA.Text = (txtC_TYGIA.Text == "") ? "0" : txtC_TYGIA.Text;
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
            RadNumericTextBox txtC_HUNTRUNG = (RadNumericTextBox)editItem.FindControl("txtC_HUNTRUNG");
            txtC_HUNTRUNG.Text = (txtC_HUNTRUNG.Text == "") ? "0" : txtC_HUNTRUNG.Text;
            RadNumericTextBox txtC_HAIQUAN = (RadNumericTextBox)editItem.FindControl("txtC_HAIQUAN");
            txtC_HAIQUAN.Text = (txtC_HAIQUAN.Text == "") ? "0" : txtC_HAIQUAN.Text;
            RadNumericTextBox txtC_HENGIO = (RadNumericTextBox)editItem.FindControl("txtC_HENGIO");
            txtC_HENGIO.Text = (txtC_HENGIO.Text == "") ? "0" : txtC_HENGIO.Text;
            RadNumericTextBox txtC_TIENHANG = (RadNumericTextBox)editItem.FindControl("txtC_TIENHANG");
            txtC_TIENHANG.Text = (txtC_TIENHANG.Text == "") ? "0" : txtC_TIENHANG.Text;
            RadNumericTextBox txtC_VAT = (RadNumericTextBox)editItem.FindControl("txtC_VAT");
            txtC_VAT.Text = (txtC_VAT.Text == "") ? "0" : txtC_VAT.Text;
            RadNumericTextBox txtC_TIENHANGVAT = (RadNumericTextBox)editItem.FindControl("txtC_TIENHANGVAT");
            txtC_TIENHANGVAT.Text = (txtC_TIENHANGVAT.Text == "") ? "0" : txtC_TIENHANGVAT.Text;
            RadNumericTextBox txtC_TIENHANGVATVND = (RadNumericTextBox)editItem.FindControl("txtC_TIENHANGVATVND");
            txtC_TIENHANGVATVND.Text = (txtC_TIENHANGVATVND.Text == "") ? "0" : txtC_TIENHANGVATVND.Text;
            RadNumericTextBox txtC_DATHU = (RadNumericTextBox)editItem.FindControl("txtC_DATHU");
            txtC_DATHU.Text = (txtC_DATHU.Text == "") ? "0" : txtC_DATHU.Text;
            RadNumericTextBox txtC_CONLAI = (RadNumericTextBox)editItem.FindControl("txtC_CONLAI");
            txtC_CONLAI.Text = (txtC_CONLAI.Text == "") ? "0" : txtC_CONLAI.Text;
            RadNumericTextBox txtC_GIADOITAC = (RadNumericTextBox)editItem.FindControl("txtC_GIADOITAC");
            txtC_GIADOITAC.Text = (txtC_GIADOITAC.Text == "") ? "0" : txtC_GIADOITAC.Text;
            RadNumericTextBox txtC_PHUPHIDOITAC = (RadNumericTextBox)editItem.FindControl("txtC_PHUPHIDOITAC");
            txtC_PHUPHIDOITAC.Text = (txtC_PHUPHIDOITAC.Text == "") ? "0" : txtC_PHUPHIDOITAC.Text;
            RadNumericTextBox txtC_LOINHUAN = (RadNumericTextBox)editItem.FindControl("txtC_LOINHUAN");
            txtC_LOINHUAN.Text = (txtC_LOINHUAN.Text == "") ? "0" : txtC_LOINHUAN.Text;
            RadNumericTextBox txtC_LOINHUANVND = (RadNumericTextBox)editItem.FindControl("txtC_LOINHUANVND");
            txtC_LOINHUANVND.Text = (txtC_LOINHUANVND.Text == "") ? "0" : txtC_LOINHUANVND.Text;
            RadComboBox cmbFK_DOITAC = (RadComboBox)editItem.FindControl("cmbFK_DOITAC");
            RadComboBox cmbFK_DICHVUDOITAC = (RadComboBox)editItem.FindControl("cmbFK_DICHVUDOITAC");
            RadComboBox cmbFK_USERADD = (RadComboBox)editItem.FindControl("cmbFK_USERADD");
            if (e.Item is GridEditFormInsertItem || e.Item is GridDataInsertItem)
            {
                // insert item
                radNgaynhangui.SelectedDate = System.DateTime.Now;
                radC_NGAYGIONHAN.SelectedDate = System.DateTime.Now.Date;
                cmbFK_USERADD.SelectedValue = Session["UserID"].ToString();
                cmbC_TAILIEU.SelectedIndex = 1;
                txtCODE.Text = GetMaxBill();
                txtC_TYGIA.Text = GetTyGia();
                if (Session["SaveAddNew"] == "True")
                {
                    if (Session["MAXIDQT"].ToString() != "")
                    {
                        string SQLSELECT = String.Format("SELECT NHANGUI.*  FROM NHANGUI WHERE NHANGUI.PK_ID = {0}", Session["MAXIDQT"].ToString());
                        ITCLIB.Admin.SQL QR = new ITCLIB.Admin.SQL();
                        DataTable oDataTableNew = QR.query_data(SQLSELECT);
                        if (oDataTableNew.Rows.Count > 0)
                        {
                            cmbSanPham.SelectedValue = oDataTableNew.Rows[0]["FK_MASANPHAM"].ToString();
                            cmbMaKhachHang.SelectedValue = oDataTableNew.Rows[0]["FK_KHACHHANG"].ToString();
                            txtC_TENKH.Text = oDataTableNew.Rows[0]["C_TENKH"].ToString();
                            txtC_TELGUI.Text = oDataTableNew.Rows[0]["C_TELGUI"].ToString();
                            txtC_KHOILUONG.Text = oDataTableNew.Rows[0]["C_KHOILUONG"].ToString();
                            cmbQuocGia.SelectedValue = oDataTableNew.Rows[0]["FK_QUOCGIA"].ToString();
                            txtC_GIACUOC.Text = oDataTableNew.Rows[0]["C_GIACUOC"].ToString();
                            cmbFK_DOITAC.SelectedValue = oDataTableNew.Rows[0]["FK_DOITAC"].ToString();
                            txtC_GIADOITAC.Text = oDataTableNew.Rows[0]["C_GIADOITAC"].ToString();
                            RadTextBox txtC_LIENHE = (RadTextBox)editItem.FindControl("txtC_LIENHE");
                            txtC_LIENHE.Text = oDataTableNew.Rows[0]["C_LIENHE"].ToString();
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
                            txtC_HUNTRUNG.Text = oDataTableNew.Rows[0]["C_HUNTRUNG"].ToString();
                            txtC_HAIQUAN.Text = oDataTableNew.Rows[0]["C_HAIQUAN"].ToString();
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
                            FK_QUOCGIA = oDataTableNew.Rows[0]["FK_QUOCGIA"].ToString();
                            string FK_KHACHHANG = oDataTableNew.Rows[0]["FK_KHACHHANG"].ToString();
                            string SelectSQL;
                            SelectSQL = "Select DMKHACHHANG.FK_NHOMKHACHHANGQT,DMKHACHHANG.C_NAME,DMKHACHHANG.C_TEL FROM DMKHACHHANG WHERE DMKHACHHANG.C_CODE ='" + FK_KHACHHANG + "'";
                            DataTable oDataTable = new DataTable();
                            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                            oDataTable = SelectQuery.query_data(SelectSQL);
                            if (oDataTable.Rows.Count != 0)
                            {
                                FK_NHOMKHACHHANGQT = oDataTable.Rows[0]["FK_NHOMKHACHHANGQT"].ToString();
                                TENKH = oDataTable.Rows[0]["C_NAME"].ToString();
                                DIENTHOAIKH = oDataTable.Rows[0]["C_TEL"].ToString();
                                string SelectSQL1;
                                SelectSQL1 = "Select DMMABANGCUOCQT.FK_DOITAC,DMMABANGCUOCQT.C_VALUE1,DMMABANGCUOCQT.C_VALUE2 FROM DMMABANGCUOCQT WHERE ((DMMABANGCUOCQT.C_VALUE ='" + FK_NHOMKHACHHANGQT + "') OR (DMMABANGCUOCQT.C_VALUE LIKE '%," + FK_NHOMKHACHHANGQT + ",%') OR (DMMABANGCUOCQT.C_VALUE LIKE '%," + FK_NHOMKHACHHANGQT + "') OR (DMMABANGCUOCQT.C_VALUE LIKE '" + FK_NHOMKHACHHANGQT + ",%')) AND (DMMABANGCUOCQT.FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"].ToString() + "')";
                                DataTable oDataTable1 = new DataTable();
                                ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
                                oDataTable1 = SelectQuery1.query_data(SelectSQL1);
                                if (oDataTable1.Rows.Count != 0)
                                {
                                    FK_MABANGCUOC = oDataTable1.Rows[0]["FK_DOITAC"].ToString();
                                    C_VALUE1 = decimal.Parse(oDataTable1.Rows[0]["C_VALUE1"].ToString());
                                    C_VALUE2 = decimal.Parse(oDataTable1.Rows[0]["C_VALUE2"].ToString());
                                }
                                else
                                {
                                    FK_MABANGCUOC = "";
                                    C_VALUE1 = 0;
                                    C_VALUE2 = 0;
                                }
                            }
                            else
                            {
                                FK_NHOMKHACHHANGQT = "";
                                TENKH = "";
                                DIENTHOAIKH = "";
                            }
                            string SelectSQL3;
                            SelectSQL3 = "Select DMMAVUNG.PK_ID FROM DMMAVUNG WHERE FK_MASANPHAM=" + FK_DICHVU + " AND C_TYPE = 2 AND ((DMMAVUNG.C_DESC ='" + FK_QUOCGIA + "') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUOCGIA + ",%') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUOCGIA + "') OR (DMMAVUNG.C_DESC LIKE '" + FK_QUOCGIA + ",%')) AND (DMMAVUNG.FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"].ToString() + "')";
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
                            SelectSQL4 = "Select DMPPXDDT.C_PPXD FROM DMPPXDDT WHERE DMPPXDDT.FK_MASANPHAM =" + FK_DICHVU + " AND FK_DOITAC = " + FK_MABANGCUOC;
                            DataTable oDataTable4 = new DataTable();
                            ITCLIB.Admin.SQL SelectQuery4 = new ITCLIB.Admin.SQL();
                            oDataTable4 = SelectQuery4.query_data(SelectSQL4);
                            if (oDataTable4.Rows.Count != 0)
                            {
                                if (oDataTable4.Rows[0]["C_PPXD"] != DBNull.Value)
                                {
                                    PPXD = decimal.Parse(oDataTable4.Rows[0]["C_PPXD"].ToString());
                                }
                            }
                            C_KHOILUONG = int.Parse(oDataTableNew.Rows[0]["C_KHOILUONG"].ToString());
                            //CUOCCHINH = decimal.Parse(oDataTableNew.Rows[0]["C_GIACUOC"].ToString());
                            FK_DOITAC = oDataTableNew.Rows[0]["FK_DOITAC"].ToString();
                            //GIADOITAC = decimal.Parse(oDataTableNew.Rows[0]["C_GIADOITAC"].ToString());
                            FK_DICHVUDOITAC = oDataTableNew.Rows[0]["FK_DICHVUDOITAC"].ToString();
                            txtC_LOINHUANVND.Text = ((decimal.Parse(oDataTableNew.Rows[0]["C_TIENHANGVAT"].ToString()) - decimal.Parse(oDataTableNew.Rows[0]["C_GIADOITAC"].ToString()) - decimal.Parse(oDataTableNew.Rows[0]["C_PHUPHIDOITAC"].ToString())) * decimal.Parse(oDataTableNew.Rows[0]["C_TYGIA"].ToString())).ToString();
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
                txtC_TIENHANGVATVND.Text = (decimal.Parse(txtC_TIENHANGVAT.Text) * decimal.Parse(txtC_TYGIA.Text)).ToString();
                txtC_CONLAI.Text = (decimal.Parse(txtC_TIENHANGVAT.Text) * decimal.Parse(txtC_TYGIA.Text) - decimal.Parse(txtC_DATHU.Text)).ToString();
                FK_DICHVU = cmbSanPham.SelectedValue;
                FK_QUOCGIA = cmbQuocGia.SelectedValue;
                string FK_KHACHHANG = cmbMaKhachHang.SelectedValue;
                string SelectSQL;
                SelectSQL = "Select DMKHACHHANG.FK_NHOMKHACHHANGQT,DMKHACHHANG.C_NAME,DMKHACHHANG.C_TEL FROM DMKHACHHANG WHERE DMKHACHHANG.C_CODE ='" + FK_KHACHHANG + "'";
                DataTable oDataTable = new DataTable();
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                oDataTable = SelectQuery.query_data(SelectSQL);
                if (oDataTable.Rows.Count != 0)
                {
                    FK_NHOMKHACHHANGQT = oDataTable.Rows[0]["FK_NHOMKHACHHANGQT"].ToString();
                    TENKH = oDataTable.Rows[0]["C_NAME"].ToString();
                    DIENTHOAIKH = oDataTable.Rows[0]["C_TEL"].ToString();
                    string SelectSQL1;
                    SelectSQL1 = "Select DMMABANGCUOCQT.FK_DOITAC,DMMABANGCUOCQT.C_VALUE1,DMMABANGCUOCQT.C_VALUE2 FROM DMMABANGCUOCQT WHERE ((DMMABANGCUOCQT.C_VALUE ='" + FK_NHOMKHACHHANGQT + "') OR (DMMABANGCUOCQT.C_VALUE LIKE '%," + FK_NHOMKHACHHANGQT + ",%') OR (DMMABANGCUOCQT.C_VALUE LIKE '%," + FK_NHOMKHACHHANGQT + "') OR (DMMABANGCUOCQT.C_VALUE LIKE '" + FK_NHOMKHACHHANGQT + ",%')) AND (DMMABANGCUOCQT.FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"].ToString() + "')";
                    DataTable oDataTable1 = new DataTable();
                    ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
                    oDataTable1 = SelectQuery1.query_data(SelectSQL1);
                    if (oDataTable1.Rows.Count != 0)
                    {
                        FK_MABANGCUOC = oDataTable1.Rows[0]["FK_DOITAC"].ToString();
                        C_VALUE1 = decimal.Parse(oDataTable1.Rows[0]["C_VALUE1"].ToString());
                        C_VALUE2 = decimal.Parse(oDataTable1.Rows[0]["C_VALUE2"].ToString());
                    }
                    else
                    {
                        FK_MABANGCUOC = "";
                        C_VALUE1 = 0;
                        C_VALUE2 = 0;
                    }
                }
                else
                {
                    FK_NHOMKHACHHANGQT = "";
                    TENKH = "";
                    DIENTHOAIKH = "";
                }
                string SelectSQL3;
                SelectSQL3 = "Select DMMAVUNG.PK_ID FROM DMMAVUNG WHERE FK_MASANPHAM=" + FK_DICHVU + " AND C_TYPE = 2 AND ((DMMAVUNG.C_DESC ='" + FK_QUOCGIA + "') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUOCGIA + ",%') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUOCGIA + "') OR (DMMAVUNG.C_DESC LIKE '" + FK_QUOCGIA + ",%')) AND (DMMAVUNG.FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"].ToString() + "')";
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
                SelectSQL4 = "Select DMPPXDDT.C_PPXD FROM DMPPXDDT WHERE DMPPXDDT.FK_MASANPHAM =" + FK_DICHVU + " AND FK_DOITAC = " + FK_MABANGCUOC;
                DataTable oDataTable4 = new DataTable();
                ITCLIB.Admin.SQL SelectQuery4 = new ITCLIB.Admin.SQL();
                oDataTable4 = SelectQuery4.query_data(SelectSQL4);
                if (oDataTable4.Rows.Count != 0)
                {
                    if (oDataTable4.Rows[0]["C_PPXD"] != DBNull.Value)
                    {
                        PPXD = decimal.Parse(oDataTable4.Rows[0]["C_PPXD"].ToString());
                    }
                }
                C_KHOILUONG = int.Parse(txtC_KHOILUONG.Text);
                //CUOCCHINH = decimal.Parse(txtC_GIACUOC.Text);
                //GIADOITAC = decimal.Parse(txtC_GIADOITAC.Text);
                FK_DOITAC = cmbFK_DOITAC.SelectedValue;
                FK_DICHVUDOITAC = cmbFK_DICHVUDOITAC.SelectedValue;
                txtC_LOINHUANVND.Text = (decimal.Parse(txtC_LOINHUAN.Text) * decimal.Parse(txtC_TYGIA.Text)).ToString();
            }
        }
        if (e.Item is GridDataItem)
        {
            Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
        }
    }
    protected string GetMaxBill()
    {
        string maxbill = "00000001";
        string SelectSQL = "SELECT MAX(CAST(C_BILL AS DECIMAL)) as MAXBILL FROM NHANGUI";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            if (oDataTable.Rows[0]["MAXBILL"] != DBNull.Value)
            {
                decimal maxvalue = (decimal)oDataTable.Rows[0]["MAXBILL"];
                maxbill = String.Format("{0:0000000}", maxvalue + 1);
            }
        }
        return maxbill;
    }
    protected string GetTyGia()
    {
        float TyGia = 0;
        try
        {
            XmlDocument xmlDocument = new XmlDocument();
            String xmlSourceUrl = "http://www.vietcombank.com.vn/ExchangeRates/ExrateXML.aspx";
            xmlDocument.Load(xmlSourceUrl);
            XmlNodeList TimeList = xmlDocument.GetElementsByTagName("DateTime");
            XmlNodeList nodeList = xmlDocument.GetElementsByTagName("Exrate");
            if (nodeList != null && nodeList.Count > 0)
            {
                foreach (XmlNode xmlNode in nodeList)
                {
                    TyGia = float.Parse(xmlNode.Attributes["Sell"].InnerText);
                }
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
        return TyGia.ToString();
    }
    protected void RadGridNHANGUIQT_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridNHANGUIQT.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridNHANGUIQT.Rebind();
            }
            foreach (GridDataItem item in RadGridNHANGUIQT.SelectedItems)
            {
                if (!ValidateDeleteGroup(item["C_BILLFIX"].Text.Replace("BC", "").Trim()))
                {
                    SetMessage("Không thể xóa nhận gửi \"" + item["c_name"].Text + "\" do có tham chiếu dữ liệu khác.");
                    RadGridNHANGUIQT.Rebind();
                }
            }
        }
        else if (e.CommandName == RadGrid.PerformInsertCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            CheckBox chkFK_TRANGTHAI = (CheckBox)editItem.FindControl("chkFK_TRANGTHAI");
            NHANGUIQTDataSource.InsertParameters["FK_TRANGTHAI"].DefaultValue = chkFK_TRANGTHAI.Checked.ToString();
        }
        else if (e.CommandName == RadGrid.UpdateCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            CheckBox chkFK_TRANGTHAI = (CheckBox)editItem.FindControl("chkFK_TRANGTHAI");
            NHANGUIQTDataSource.UpdateParameters["FK_TRANGTHAI"].DefaultValue = chkFK_TRANGTHAI.Checked.ToString();
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
            if (RadGridNHANGUIQT.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
            }
            else
            {
                string UpdateSQL = "";
                foreach (GridDataItem item in RadGridNHANGUIQT.SelectedItems)
                {
                    string TIENHANGDATHU = (item["C_DATHU"].Text.Trim() == "VNĐ") ? "0" : item["C_DATHU"].Text.Trim();
                    TIENHANGDATHU = TIENHANGDATHU.Replace(" ", "");
                    TIENHANGDATHU = TIENHANGDATHU.Replace("VNĐ", "");
                    //string TIENHANGCONLAI = (item["C_CONLAI"].Text.Trim() == "VNĐ") ? "0" : item["C_CONLAI"].Text.Trim();
                    HiddenField txtC_CONLAI = (HiddenField)item.FindControl("txtC_CONLAI");
                    string TIENHANGCONLAI = (txtC_CONLAI.Value.Trim() == "") ? "0" : txtC_CONLAI.Value.Trim();
                    TIENHANGCONLAI = TIENHANGCONLAI.Replace(" ", "");
                    //TIENHANGCONLAI = TIENHANGCONLAI.Replace("VNĐ", "");
                    string TIENHANG = (decimal.Parse(TIENHANGDATHU) + decimal.Parse(TIENHANGCONLAI)).ToString();
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
                UpdateQuery.ExecuteNonQuery(UpdateSQL);
            }
            SetMessage("Cập nhật tình trạng thanh toán thành công");
            RadGridNHANGUIQT.Rebind();
        }
        else if (e.CommandName == "ConfirmUnPayment")
        {
            if (RadGridNHANGUIQT.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
            }
            else
            {
                string UpdateSQL = "";
                foreach (GridDataItem item in RadGridNHANGUIQT.SelectedItems)
                {
                    string TIENHANGDATHU = (item["C_DATHU"].Text.Trim() == "VNĐ") ? "0" : item["C_DATHU"].Text.Trim();
                    TIENHANGDATHU = TIENHANGDATHU.Replace(" ", "");
                    TIENHANGDATHU = TIENHANGDATHU.Replace("VNĐ", "");
                    //string TIENHANGCONLAI = (item["C_CONLAI"].Text.Trim() == "VNĐ") ? "0" : item["C_CONLAI"].Text.Trim();
                    HiddenField txtC_CONLAI = (HiddenField)item.FindControl("txtC_CONLAI");
                    string TIENHANGCONLAI = (txtC_CONLAI.Value.Trim() == "") ? "0" : txtC_CONLAI.Value.Trim();
                    TIENHANGCONLAI = TIENHANGCONLAI.Replace(" ", "");
                    //TIENHANGCONLAI = TIENHANGCONLAI.Replace("VNĐ", "");
                    string TIENHANG = (decimal.Parse(TIENHANGDATHU) + decimal.Parse(TIENHANGCONLAI)).ToString();
                    UpdateSQL += "UPDATE [NHANGUI] SET [C_DATHU] = " + "0" + ",[C_HINHTHUCTT] = N'Thanh toán sau' WHERE [C_BILL] = '" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "';UPDATE [SOQUYTIENMAT] SET [C_SOTIEN] = " + "0" + " WHERE [C_BILL] = '" + (item["C_BILLFIX"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "';";
                }
                ITCLIB.Admin.SQL UpdateQuery = new ITCLIB.Admin.SQL();
                UpdateQuery.ExecuteNonQuery(UpdateSQL);
            }
            SetMessage("Cập nhật tình trạng thanh toán thành công");
            RadGridNHANGUIQT.Rebind();
        }
        else if (e.CommandName == "ClearFilterGrid")
        {
            RadGridNHANGUIQT.MasterTableView.FilterExpression = string.Empty;

            foreach (GridColumn column in RadGridNHANGUIQT.MasterTableView.RenderColumns)
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
            RadGridNHANGUIQT.MasterTableView.Rebind();
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
    protected void GiaCuocChinh()
    {
        string SelectSQL1;
        SelectSQL1 = "Select DMCHITIETCUOCDT.PK_ID,DMCHITIETCUOCDT.C_KHOILUONG,DMCHITIETCUOCDT.C_CUOCPHI,DMCHITIETCUOCDT.C_CUOCPHITL,DMCHITIETCUOCDT.C_TYPE FROM DMCHITIETCUOCDT WHERE C_LOAITIEN = N'USD' AND FK_DOITAC = " + FK_MABANGCUOC + " AND FK_MAVUNG = " + FK_MAVUNG + " AND C_TYPE <> 1 AND C_TYPE1 <> 1 ORDER BY C_KHOILUONG  ASC";
        ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
        ctcDataTable = SelectQuery1.query_data(SelectSQL1);
        string SelectSQL2;
        SelectSQL2 = "Select DMCHITIETCUOCDT.PK_ID,DMCHITIETCUOCDT.C_KHOILUONG,DMCHITIETCUOCDT.C_CUOCPHI,DMCHITIETCUOCDT.C_CUOCPHITL,DMCHITIETCUOCDT.C_TYPE FROM DMCHITIETCUOCDT WHERE C_LOAITIEN = N'USD' AND FK_DOITAC = " + FK_MABANGCUOC + " AND FK_MAVUNG = " + FK_MAVUNG + " AND C_TYPE = 1 AND C_TYPE1 <> 1 ORDER BY C_KHOILUONG";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery2 = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery2.query_data(SelectSQL2);
        if (oDataTable.Rows.Count != 0)
        {
            C_KHOILUONGLK = int.Parse(oDataTable.Rows[0]["C_KHOILUONG"].ToString(), NumberStyles.Currency);
            GIACUOCLK = decimal.Parse(oDataTable.Rows[0]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
            GIACUOCLKTL = decimal.Parse(oDataTable.Rows[0]["C_CUOCPHITL"].ToString(), NumberStyles.Currency);
        }
        else
        {
            C_KHOILUONGLK = 0;
            GIACUOCLK = 0;
            GIACUOCLKTL = 0;
        }
        string SelectSQL3;
        SelectSQL3 = "Select DMCHITIETCUOCDT.PK_ID,DMCHITIETCUOCDT.C_KHOILUONG,DMCHITIETCUOCDT.C_CUOCPHI,DMCHITIETCUOCDT.C_CUOCPHITL,DMCHITIETCUOCDT.C_TYPE FROM DMCHITIETCUOCDT WHERE C_LOAITIEN = N'USD' AND FK_DOITAC = " + FK_MABANGCUOC + " AND FK_MAVUNG = " + FK_MAVUNG + " AND C_TYPE1 = 1 ORDER BY C_KHOILUONG  ASC";
        ITCLIB.Admin.SQL SelectQuery3 = new ITCLIB.Admin.SQL();
        ctcDataTable1 = SelectQuery3.query_data(SelectSQL3);
        // Có tính theo kg
        if (ctcDataTable1.Rows.Count != 0)
        {
            if (C_KHOILUONG < int.Parse(ctcDataTable1.Rows[0]["C_KHOILUONG"].ToString()))
            {
                //Theo luỹ kế
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
                                    CUOCCHINH = CUOCCHINH + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;

                                    CUOCCHINHTL = decimal.Parse(ctcDataTable.Rows[0]["C_CUOCPHITL"].ToString(), NumberStyles.Currency);
                                    CUOCCHINHTL = CUOCCHINHTL + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;

                                }
                                if (C_KHOILUONG > int.Parse(ctcDataTable.Rows[0]["C_KHOILUONG"].ToString()) && ctcDataTable.Rows.Count == 1 && C_KHOILUONGLK != 0 && GIACUOCLK != 0)
                                {
                                    if (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) % C_KHOILUONGLK) == 0)
                                    {
                                        CUOCCHINH = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) * GIACUOCLK;
                                        CUOCCHINH = CUOCCHINH + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                        CUOCCHINHTL = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) * GIACUOCLKTL;
                                        CUOCCHINHTL = CUOCCHINHTL + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                    }
                                    else
                                    {
                                        CUOCCHINH = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) + 1) * GIACUOCLK;
                                        CUOCCHINH = CUOCCHINH + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                        CUOCCHINHTL = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) + 1) * GIACUOCLKTL;
                                        CUOCCHINHTL = CUOCCHINHTL + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                    }
                                }
                            }
                            else
                            {
                                if (C_KHOILUONG <= int.Parse(ctcDataTable.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG > int.Parse(ctcDataTable.Rows[i - 1]["C_KHOILUONG"].ToString()))
                                {
                                    CUOCCHINH = decimal.Parse(ctcDataTable.Rows[i]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                    CUOCCHINH = CUOCCHINH + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                    CUOCCHINHTL = decimal.Parse(ctcDataTable.Rows[i]["C_CUOCPHITL"].ToString(), NumberStyles.Currency);
                                    CUOCCHINHTL = CUOCCHINHTL + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                    check = false;
                                }
                                else if (C_KHOILUONG > int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString()))
                                {
                                    if (C_KHOILUONGLK != 0)
                                    {
                                        if (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) % C_KHOILUONGLK) == 0)
                                        {
                                            CUOCCHINH = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) * GIACUOCLK;
                                            CUOCCHINH = CUOCCHINH + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                            CUOCCHINHTL = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) * GIACUOCLKTL;
                                            CUOCCHINHTL = CUOCCHINHTL + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                        }
                                        else
                                        {
                                            CUOCCHINH = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) + 1) * GIACUOCLK;
                                            CUOCCHINH = CUOCCHINH + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                            CUOCCHINHTL = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) + 1) * GIACUOCLKTL;
                                            CUOCCHINHTL = CUOCCHINHTL + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                        }
                                    }
                                    else
                                    {
                                        CUOCCHINH = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                        CUOCCHINH = CUOCCHINH + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                        CUOCCHINHTL = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency);
                                        CUOCCHINHTL = CUOCCHINHTL + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
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
                                CUOCCHINH = CUOCCHINH + (CUOCCHINH * C_VALUE2) / 100;
                            }
                            else
                            {
                                if (C_KHOILUONG < int.Parse(ctcDataTable1.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG >= int.Parse(ctcDataTable1.Rows[i - 1]["C_KHOILUONG"].ToString()))
                                {
                                    CUOCCHINH = decimal.Parse(ctcDataTable1.Rows[i - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                    CUOCCHINH = CUOCCHINH + (CUOCCHINH * C_VALUE2) / 100;
                                    CUOCCHINHTL = decimal.Parse(ctcDataTable1.Rows[i - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                    CUOCCHINHTL = CUOCCHINHTL + (CUOCCHINHTL * C_VALUE2) / 100;
                                    check1 = false;
                                }
                                else if (C_KHOILUONG >= int.Parse(ctcDataTable1.Rows[ctcDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString()))
                                {
                                    CUOCCHINH = decimal.Parse(ctcDataTable1.Rows[ctcDataTable1.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                    CUOCCHINH = CUOCCHINH + (CUOCCHINH * C_VALUE2) / 100;
                                    CUOCCHINHTL = decimal.Parse(ctcDataTable1.Rows[ctcDataTable1.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                    CUOCCHINHTL = CUOCCHINHTL + (CUOCCHINHTL * C_VALUE2) / 100;
                                    check1 = false;
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                //Theo KG
                bool check1 = true;
                for (int i = 0; i < ctcDataTable1.Rows.Count; i++)
                {
                    if (check1)
                    {
                        if (i == 0)
                        {
                            CUOCCHINH = decimal.Parse(ctcDataTable1.Rows[0]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                            CUOCCHINH = CUOCCHINH + (CUOCCHINH * C_VALUE2) / 100;
                        }
                        else
                        {
                            if (C_KHOILUONG < int.Parse(ctcDataTable1.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG >= int.Parse(ctcDataTable1.Rows[i - 1]["C_KHOILUONG"].ToString()))
                            {
                                CUOCCHINH = decimal.Parse(ctcDataTable1.Rows[i - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                CUOCCHINH = CUOCCHINH + (CUOCCHINH * C_VALUE2) / 100;
                                CUOCCHINHTL = decimal.Parse(ctcDataTable1.Rows[i - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                CUOCCHINHTL = CUOCCHINHTL + (CUOCCHINHTL * C_VALUE2) / 100;
                                check1 = false;
                            }
                            else if (C_KHOILUONG >= int.Parse(ctcDataTable1.Rows[ctcDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString()))
                            {
                                CUOCCHINH = decimal.Parse(ctcDataTable1.Rows[ctcDataTable1.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                CUOCCHINH = CUOCCHINH + (CUOCCHINH * C_VALUE2) / 100;
                                CUOCCHINHTL = decimal.Parse(ctcDataTable1.Rows[ctcDataTable1.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                CUOCCHINHTL = CUOCCHINHTL + (CUOCCHINHTL * C_VALUE2) / 100;
                                check1 = false;
                            }
                        }
                    }
                }
            }
        }
        else
        {
            // Không có tính theo kg chỉ luỹ kế
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
                                CUOCCHINH = CUOCCHINH + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;

                                CUOCCHINHTL = decimal.Parse(ctcDataTable.Rows[0]["C_CUOCPHITL"].ToString(), NumberStyles.Currency);
                                CUOCCHINHTL = CUOCCHINHTL + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;

                            }
                            if (C_KHOILUONG > int.Parse(ctcDataTable.Rows[0]["C_KHOILUONG"].ToString()) && ctcDataTable.Rows.Count == 1 && C_KHOILUONGLK != 0 && GIACUOCLK != 0)
                            {
                                if (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) % C_KHOILUONGLK) == 0)
                                {
                                    CUOCCHINH = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) * GIACUOCLK;
                                    CUOCCHINH = CUOCCHINH + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                    CUOCCHINHTL = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) * GIACUOCLKTL;
                                    CUOCCHINHTL = CUOCCHINHTL + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                }
                                else
                                {
                                    CUOCCHINH = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) + 1) * GIACUOCLK;
                                    CUOCCHINH = CUOCCHINH + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                    CUOCCHINHTL = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) + 1) * GIACUOCLKTL;
                                    CUOCCHINHTL = CUOCCHINHTL + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                }
                            }
                        }
                        else
                        {
                            if (C_KHOILUONG <= int.Parse(ctcDataTable.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG > int.Parse(ctcDataTable.Rows[i - 1]["C_KHOILUONG"].ToString()))
                            {
                                CUOCCHINH = decimal.Parse(ctcDataTable.Rows[i]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                CUOCCHINH = CUOCCHINH + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                CUOCCHINHTL = decimal.Parse(ctcDataTable.Rows[i]["C_CUOCPHITL"].ToString(), NumberStyles.Currency);
                                CUOCCHINHTL = CUOCCHINHTL + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                check = false;
                            }
                            else if (C_KHOILUONG > int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString()))
                            {
                                if (C_KHOILUONGLK != 0)
                                {
                                    if (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) % C_KHOILUONGLK) == 0)
                                    {
                                        CUOCCHINH = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) * GIACUOCLK;
                                        CUOCCHINH = CUOCCHINH + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                        CUOCCHINHTL = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) * GIACUOCLKTL;
                                        CUOCCHINHTL = CUOCCHINHTL + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                    }
                                    else
                                    {
                                        CUOCCHINH = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) + 1) * GIACUOCLK;
                                        CUOCCHINH = CUOCCHINH + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                        CUOCCHINHTL = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) + 1) * GIACUOCLKTL;
                                        CUOCCHINHTL = CUOCCHINHTL + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                    }
                                }
                                else
                                {
                                    CUOCCHINH = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                    CUOCCHINH = CUOCCHINH + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                    CUOCCHINHTL = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency);
                                    CUOCCHINHTL = CUOCCHINHTL + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                }
                                check = false;
                            }
                        }
                    }
                }
            }
        }
        isCuocchinh = false;
    }
    protected void GiaCuocDoiTac()
    {
        int C_KHOILUONGLKDT = 0;
        decimal GIACUOCLKDT = 0;
        decimal GIACUOCLKDTTL = 0;
        GIADOITAC = 0;
        GIADOITACTL = 0;
        decimal PPXDDT = 0;
        string SelectSQL4;
        SelectSQL4 = "Select DMPPXDDT.C_PPXD FROM DMPPXDDT WHERE DMPPXDDT.FK_MASANPHAM =" + FK_DICHVUDOITAC + " AND FK_DOITAC = " + FK_DOITAC;
        DataTable oDataTable4 = new DataTable();
        ITCLIB.Admin.SQL SelectQuery4 = new ITCLIB.Admin.SQL();
        oDataTable4 = SelectQuery4.query_data(SelectSQL4);
        if (oDataTable4.Rows.Count != 0)
        {
            if (oDataTable4.Rows[0]["C_PPXD"] != DBNull.Value)
            {
                PPXDDT = decimal.Parse(oDataTable4.Rows[0]["C_PPXD"].ToString());
            }
        }
        string SelectSQL1;
        SelectSQL1 = "Select DMCHITIETCUOCDT.PK_ID,DMCHITIETCUOCDT.C_KHOILUONG,DMCHITIETCUOCDT.C_CUOCPHI,DMCHITIETCUOCDT.C_CUOCPHITL,DMCHITIETCUOCDT.C_TYPE FROM DMCHITIETCUOCDT WHERE C_LOAITIEN = N'USD' AND FK_MAVUNG = " + FK_MAVUNGDT + " AND C_TYPE <> 1 AND C_TYPE1 <> 1 ORDER BY C_KHOILUONG  ASC";
        ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
        DataTable oDataTable1 = new DataTable();
        oDataTable1 = SelectQuery1.query_data(SelectSQL1);
        string SelectSQL2;
        SelectSQL2 = "Select DMCHITIETCUOCDT.PK_ID,DMCHITIETCUOCDT.C_KHOILUONG,DMCHITIETCUOCDT.C_CUOCPHI,DMCHITIETCUOCDT.C_CUOCPHITL,DMCHITIETCUOCDT.C_TYPE FROM DMCHITIETCUOCDT WHERE C_LOAITIEN = N'USD' AND FK_MAVUNG = " + FK_MAVUNGDT + " AND C_TYPE = 1 AND C_TYPE1 <> 1 ORDER BY C_KHOILUONG  ASC";
        DataTable oDataTable2 = new DataTable();
        ITCLIB.Admin.SQL SelectQuery2 = new ITCLIB.Admin.SQL();
        oDataTable2 = SelectQuery2.query_data(SelectSQL2);
        if (oDataTable2.Rows.Count != 0)
        {
            C_KHOILUONGLKDT = int.Parse(oDataTable2.Rows[0]["C_KHOILUONG"].ToString(), NumberStyles.Currency);
            GIACUOCLKDT = decimal.Parse(oDataTable2.Rows[0]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
            GIACUOCLKDTTL = decimal.Parse(oDataTable2.Rows[0]["C_CUOCPHITL"].ToString(), NumberStyles.Currency);
        }
        else
        {
            C_KHOILUONGLKDT = 0;
            GIACUOCLKDT = 0;
            GIACUOCLKDTTL = 0;
        }
        string SelectSQL3;
        SelectSQL3 = "Select DMCHITIETCUOCDT.PK_ID,DMCHITIETCUOCDT.C_KHOILUONG,DMCHITIETCUOCDT.C_CUOCPHI,DMCHITIETCUOCDT.C_CUOCPHITL,DMCHITIETCUOCDT.C_TYPE FROM DMCHITIETCUOCDT WHERE C_LOAITIEN = N'USD' AND FK_MAVUNG = " + FK_MAVUNGDT + " AND C_TYPE1 = 1 ORDER BY C_KHOILUONG  ASC";
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
                                    GIADOITACTL = decimal.Parse(oDataTable1.Rows[0]["C_CUOCPHITL"].ToString(), NumberStyles.Currency);
                                }
                            }
                            else
                            {
                                if (C_KHOILUONG <= int.Parse(oDataTable1.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG > int.Parse(oDataTable1.Rows[i - 1]["C_KHOILUONG"].ToString()))
                                {
                                    GIADOITAC = decimal.Parse(oDataTable1.Rows[i]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                    GIADOITACTL = decimal.Parse(oDataTable1.Rows[i]["C_CUOCPHITL"].ToString(), NumberStyles.Currency);
                                    check = false;
                                }
                                else if (C_KHOILUONG > int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString()))
                                {
                                    if (C_KHOILUONGLKDT != 0)
                                    {
                                        if (((C_KHOILUONG - int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString())) % C_KHOILUONGLKDT) == 0)
                                        {
                                            GIADOITAC = decimal.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLKDT) * GIACUOCLKDT;
                                            GIADOITACTL = decimal.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLKDT) * GIACUOCLKDTTL;
                                        }
                                        else
                                        {
                                            GIADOITAC = decimal.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLKDT) + 1) * GIACUOCLKDT;
                                            GIADOITACTL = decimal.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLKDT) + 1) * GIACUOCLKDTTL;
                                        }
                                    }
                                    else
                                    {
                                        GIADOITAC = decimal.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                        GIADOITACTL = decimal.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency);
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
                                GIADOITACTL = decimal.Parse(oDataTable1.Rows[0]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                            }
                            else
                            {
                                if (C_KHOILUONG < int.Parse(oDataTable3.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG >= int.Parse(oDataTable3.Rows[i - 1]["C_KHOILUONG"].ToString()))
                                {
                                    GIADOITAC = decimal.Parse(oDataTable3.Rows[i - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                    GIADOITACTL = decimal.Parse(oDataTable3.Rows[i - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                    check1 = false;
                                }
                                else if (C_KHOILUONG >= int.Parse(oDataTable3.Rows[oDataTable3.Rows.Count - 1]["C_KHOILUONG"].ToString()))
                                {
                                    GIADOITAC = decimal.Parse(oDataTable3.Rows[oDataTable3.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                    GIADOITACTL = decimal.Parse(oDataTable3.Rows[oDataTable3.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
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
                            GIADOITACTL = decimal.Parse(oDataTable1.Rows[0]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                        }
                        else
                        {
                            if (C_KHOILUONG < int.Parse(oDataTable3.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG >= int.Parse(oDataTable3.Rows[i - 1]["C_KHOILUONG"].ToString()))
                            {
                                GIADOITAC = decimal.Parse(oDataTable3.Rows[i - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                GIADOITACTL = decimal.Parse(oDataTable3.Rows[i - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                check1 = false;
                            }
                            else if (C_KHOILUONG >= int.Parse(oDataTable3.Rows[oDataTable3.Rows.Count - 1]["C_KHOILUONG"].ToString()))
                            {
                                GIADOITAC = decimal.Parse(oDataTable3.Rows[oDataTable3.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                GIADOITACTL = decimal.Parse(oDataTable3.Rows[oDataTable3.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
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
                                GIADOITACTL = decimal.Parse(oDataTable1.Rows[0]["C_CUOCPHITL"].ToString(), NumberStyles.Currency);
                            }
                        }
                        else
                        {
                            if (C_KHOILUONG <= int.Parse(oDataTable1.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG > int.Parse(oDataTable1.Rows[i - 1]["C_KHOILUONG"].ToString()))
                            {
                                GIADOITAC = decimal.Parse(oDataTable1.Rows[i]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                GIADOITACTL = decimal.Parse(oDataTable1.Rows[i]["C_CUOCPHITL"].ToString(), NumberStyles.Currency);
                                check = false;
                            }
                            else if (C_KHOILUONG > int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString()))
                            {
                                if (C_KHOILUONGLKDT != 0)
                                {
                                    if (((C_KHOILUONG - int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString())) % C_KHOILUONGLKDT) == 0)
                                    {
                                        GIADOITAC = decimal.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLKDT) * GIACUOCLKDT;
                                        GIADOITACTL = decimal.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLKDT) * GIACUOCLKDTTL;
                                    }
                                    else
                                    {
                                        GIADOITAC = decimal.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLKDT) + 1) * GIACUOCLKDT;
                                        GIADOITACTL = decimal.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLKDT) + 1) * GIACUOCLKDTTL;
                                    }
                                }
                                else
                                {
                                    GIADOITAC = decimal.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                    GIADOITACTL = decimal.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_CUOCPHITL"].ToString(), NumberStyles.Currency);
                                }
                                check = false;
                            }
                        }
                    }
                }
            }
        }
        isCuocdoitac = false;
    }
    protected void ClearSession()
    {
        FK_NHOMKHACHHANGQT = "";
        FK_KHACHHANG = "";
        TENKH = "";
        DIENTHOAIKH = "";
        FK_DICHVU = "";
        FK_MABANGCUOC = "";
        C_VALUE1 = 0;
        C_VALUE2 = 0;
        FK_QUOCGIA = "";
        FK_MAVUNG = "";
        FK_MAVUNGDT = "";
        C_KHOILUONG = 0;
        PPXD = 0;
        CUOCCHINH = 0;
        CUOCCHINHTL = 0;
        FK_DICHVUDOITAC = "";
        FK_DOITAC = "";
        GIADOITAC = 0;
        GIADOITACTL = 0;
        ctcDataTable = new DataTable();
        ctcDataTable1 = new DataTable();
        C_KHOILUONGLK = 0;
        GIACUOCLK = 0;
        GIACUOCLKTL = 0;
        isTAILIEU = false;
        Alarm = "";
        Session["MAXIDQT"] = "";
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
                    InsertSQL = "INSERT INTO [NHANGUI] ([C_NGAY], [C_BILL], [C_NGAYGIONHAN], [C_TYGIA], [FK_DOITAC], [C_TYPE],[FK_VUNGLAMVIEC]) VALUES ('" + System.DateTime.Now + "','" + txtBillNhanh.Text + "','" + System.DateTime.Now.Date + "'," + GetTyGia() + "," + cmbDoiTac.SelectedValue + ", 2,N'" + Session["VUNGLAMVIEC"].ToString() + "');INSERT INTO [SOQUYTIENMAT] ([C_NGAY], [C_TYPE], [FK_KIHIEUTAIKHOAN], [C_DESC], [C_SOTIEN], [C_BILL],[C_TON],[C_ORDER],[FK_VUNGLAMVIEC]) VALUES ('" + System.DateTime.Now + "',N'Thu',NULL, N'Bill ' + '" + txtBillNhanh.Text + "',0 ,'" + txtBillNhanh.Text + "',0,1,N'" + Session["VUNGLAMVIEC"].ToString() + "');INSERT INTO TRACKING (C_BILL, C_DATE, FK_TRANGTHAI) SELECT '" + txtBillNhanh.Text + "', '" + System.DateTime.Now.Date + "', N'F' UNION ALL SELECT '" + txtBillNhanh.Text + "', '" + System.DateTime.Now + "',N'G_" + Session["VUNGLAMVIEC"].ToString() + "'";
                }
                else
                {
                    InsertSQL = "INSERT INTO [NHANGUI] ([C_NGAY], [C_BILL], [C_NGAYGIONHAN], [C_TYGIA], [C_TYPE],[FK_VUNGLAMVIEC]) VALUES ('" + System.DateTime.Now + "','" + txtBillNhanh.Text + "','" + System.DateTime.Now.Date + "'," + GetTyGia() + ", 2,N'" + Session["VUNGLAMVIEC"].ToString() + "');INSERT INTO [SOQUYTIENMAT] ([C_NGAY], [C_TYPE], [FK_KIHIEUTAIKHOAN], [C_DESC], [C_SOTIEN], [C_BILL],[C_TON],[C_ORDER],[FK_VUNGLAMVIEC]) VALUES ('" + System.DateTime.Now + "',N'Thu',NULL, N'Bill ' + '" + txtBillNhanh.Text + "',0 ,'" + txtBillNhanh.Text + "',0,1,N'" + Session["VUNGLAMVIEC"].ToString() + "');INSERT INTO TRACKING (C_BILL, C_DATE, FK_TRANGTHAI) SELECT '" + txtBillNhanh.Text + "', '" + System.DateTime.Now.Date + "', N'F' UNION ALL SELECT '" + txtBillNhanh.Text + "', '" + System.DateTime.Now + "',N'G_" + Session["VUNGLAMVIEC"].ToString() + "'";
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
            RadGridNHANGUIQT.Rebind();
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
    protected void RadGridNHANGUIQT_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridPagerItem)
        {
            RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
            RadComboBoxItem item = new RadComboBoxItem("100", "100");
            item.Attributes.Add("ownerTableViewId", RadGridNHANGUIQT.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("100") == null) cb.Items.Add(item);
            item = new RadComboBoxItem("200", "200");
            item.Attributes.Add("ownerTableViewId", RadGridNHANGUIQT.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("200") == null) cb.Items.Add(item);
            item = new RadComboBoxItem("500", "500");
            item.Attributes.Add("ownerTableViewId", RadGridNHANGUIQT.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("500") == null) cb.Items.Add(item);
            cb.Items.Sort(new PagerRadComboBoxItemComparer());
            cb.Items.FindItemByValue(RadGridNHANGUIQT.PageSize.ToString()).Selected = true;
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
        //lblMessage.Text = RadAsyncUploadExcel.TemporaryFolder + RadAsyncUploadExcel.UploadedFiles[0].FileName;
        if (RadAsyncUploadExcel.UploadedFiles.Count != 0)
        {
            System.IO.Stream stream = RadAsyncUploadExcel.UploadedFiles[0].InputStream;
            IExcelDataReader excelReader;
            if (RadAsyncUploadExcel.UploadedFiles[0].GetExtension() == ".xls")
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
                        CheckSQL = "SELECT (CASE WHEN EXISTS (SELECT C_BILL FROM NHANGUI WHERE C_TYPE = 2 AND FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"].ToString() + "' AND C_BILL='" + oDataTable.Rows[i][0].ToString().Trim() + "') THEN 'True' ELSE '" + oDataTable.Rows[i][0].ToString().Trim() + "' END) as C_BILL";
                    }
                    else
                    {
                        BillFilter += ",'" + oDataTable.Rows[i][0].ToString().Trim() + "'";
                        CheckSQL += " UNION ALL " + "SELECT (CASE WHEN EXISTS (SELECT C_BILL FROM NHANGUI WHERE C_TYPE = 2 AND FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"].ToString() + "' AND C_BILL='" + oDataTable.Rows[i][0].ToString().Trim() + "') THEN 'True' ELSE '" + oDataTable.Rows[i][0].ToString().Trim() + "' END) as C_BILL";
                    }
                }
                RadGridNHANGUIQT.MasterTableView.FilterExpression = "([C_BILL] IN (" + BillFilter + "))";
                RadGridNHANGUIQT.Rebind();
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
        RadGridNHANGUIQT.MasterTableView.FilterExpression = string.Empty;
        lblMessage.Text = "";
        RadGridNHANGUIQT.Rebind();
    }
}