using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;
using System.Globalization;

public partial class module_NHANGUI : System.Web.UI.UserControl
{
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
    private decimal C_KHOILUONG
    {
        get
        {
            return decimal.Parse(Session["C_KHOILUONG"].ToString());
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
    private decimal C_KHOILUONGLK
    {
        get
        {
            return decimal.Parse(Session["C_KHOILUONGLK"].ToString());
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
    string Alarm = "";
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
        RadAutoCompleteBox radautoC_MAKH = (RadAutoCompleteBox)editableItem.FindControl("radautoC_MAKH");
        RadAutoCompleteBox radautoC_TENKH = (RadAutoCompleteBox)editableItem.FindControl("radautoC_TENKH");
        RadNumericTextBox txtC_KHOILUONG = (RadNumericTextBox)editableItem.FindControl("txtC_KHOILUONG");
        C_KHOILUONG = (txtC_KHOILUONG.Text != "") ? int.Parse(txtC_KHOILUONG.Text) : 0;
        string[] arrayvalue = e.Argument.Split(';');
        if (arrayvalue[0] == "cmbNhomKhachHang")
        {
            /*KHACHHANGDataSource.SelectCommand = "SELECT DMKHACHHANG.* FROM DMKHACHHANG WHERE FK_NHOMKHACHHANG =" + arrayvalue[1];
            radautoC_MAKH.DataBind();
            radautoC_TENKH.DataBind();*/
            string SelectSQL;
            SelectSQL = "Select DMMABANGCUOC.PK_ID FROM DMMABANGCUOC WHERE (DMMABANGCUOC.C_VALUE ='" + arrayvalue[1] + "') OR (DMMABANGCUOC.C_VALUE LIKE '%," + arrayvalue[1] + ",%') OR (DMMABANGCUOC.C_VALUE LIKE '%," + arrayvalue[1] + "') OR (DMMABANGCUOC.C_VALUE LIKE '" + arrayvalue[1] + ",%')";
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                FK_MABANGCUOC = oDataTable.Rows[0]["PK_ID"].ToString();
            }
            else
            {
                Alarm = "Nhóm khách hàng này không nằm trong bảng cước nào";
            }
        }
        else if (arrayvalue[0] == "cmbQuanHuyen")
        {
            FK_QUANHUYEN = arrayvalue[1];
            if (FK_DICHVU != "")
            {
                string SelectSQL;
                SelectSQL = "Select DMMAVUNG.PK_ID FROM DMMAVUNG WHERE FK_MASANPHAM=" + FK_DICHVU + " AND C_TYPE = 1 AND ((DMMAVUNG.C_DESC ='" + FK_QUANHUYEN + "') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUANHUYEN + ",%') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUANHUYEN + "') OR (DMMAVUNG.C_DESC LIKE '" + FK_QUANHUYEN + ",%'))";
                DataTable oDataTable = new DataTable();
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                oDataTable = SelectQuery.query_data(SelectSQL);
                if (oDataTable.Rows.Count != 0)
                {
                    FK_MAVUNG = oDataTable.Rows[0]["PK_ID"].ToString();
                }
                else
                {
                    Alarm = "Quận huyện này không nằm trong vùng tính cước nào";
                }
            }
        }
        else if (arrayvalue[0] == "cmbSanPham")
        {
            FK_DICHVU = arrayvalue[1];
            string SelectSQL1;
            SelectSQL1 = "Select DMMASANPHAM.C_PPXD FROM DMMASANPHAM WHERE DMMASANPHAM.PK_ID = " + arrayvalue[1] + "";
            DataTable oDataTable1 = new DataTable();
            ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
            oDataTable1 = SelectQuery1.query_data(SelectSQL1);
            if (oDataTable1.Rows.Count != 0)
            {
                if (oDataTable1.Rows[0]["C_PPXD"] != DBNull.Value)
                {
                    PPXD = decimal.Parse(oDataTable1.Rows[0]["C_PPXD"].ToString());
                }
            }
            if (FK_QUANHUYEN != "")
            {
                string SelectSQL;
                SelectSQL = "Select DMMAVUNG.PK_ID FROM DMMAVUNG WHERE FK_MASANPHAM=" + FK_DICHVU + " AND C_TYPE = 1 AND ((DMMAVUNG.C_DESC ='" + FK_QUANHUYEN + "') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUANHUYEN + ",%') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUANHUYEN + "') OR (DMMAVUNG.C_DESC LIKE '" + FK_QUANHUYEN + ",%'))";
                DataTable oDataTable = new DataTable();
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                oDataTable = SelectQuery.query_data(SelectSQL);
                if (oDataTable.Rows.Count != 0)
                {
                    FK_MAVUNG = oDataTable.Rows[0]["PK_ID"].ToString();
                }
                else
                {
                    //FK_MAVUNG = "0";
                    Alarm = "Quận huyện này không nằm trong vùng tính cước nào";
                }
            }
        }
        else if (arrayvalue[0] == "txtC_KHOILUONG")
        {
            C_KHOILUONG =  int.Parse(arrayvalue[1]); 
        }
        if ((FK_MABANGCUOC != "") && (FK_MAVUNG != ""))
        {
            string SelectSQL1;
            SelectSQL1 = "Select DMCHITIETCUOC.PK_ID,DMCHITIETCUOC.C_KHOILUONG,DMCHITIETCUOC.C_CUOCPHI,DMCHITIETCUOC.C_TYPE FROM DMCHITIETCUOC WHERE FK_MABANGCUOC = " + FK_MABANGCUOC + " AND FK_MAVUNG = " + FK_MAVUNG + " AND C_TYPE <> 1 ORDER BY C_KHOILUONG";
            Session["test"] = SelectSQL1;
            ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
            ctcDataTable = SelectQuery1.query_data(SelectSQL1);
            string SelectSQL2;
            SelectSQL2 = "Select DMCHITIETCUOC.PK_ID,DMCHITIETCUOC.C_KHOILUONG,DMCHITIETCUOC.C_CUOCPHI,DMCHITIETCUOC.C_TYPE FROM DMCHITIETCUOC WHERE FK_MABANGCUOC = " + FK_MABANGCUOC + " AND FK_MAVUNG = " + FK_MAVUNG + " AND C_TYPE = 1 ORDER BY C_KHOILUONG";
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery2 = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery2.query_data(SelectSQL2);
            if (oDataTable.Rows.Count != 0)
            {
                C_KHOILUONGLK = decimal.Parse(oDataTable.Rows[0]["C_KHOILUONG"].ToString(), NumberStyles.Currency);
                GIACUOCLK = decimal.Parse(oDataTable.Rows[0]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
            }

        }
        if (C_KHOILUONG != 0)
        {
            if (ctcDataTable.Rows.Count !=0)
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
                        }
                        else
                        {
                            if (C_KHOILUONG <= int.Parse(ctcDataTable.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG <= int.Parse(ctcDataTable.Rows[i - 1]["C_KHOILUONG"].ToString()))
                            {
                                CUOCCHINH = decimal.Parse(ctcDataTable.Rows[i]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                check = false;
                            }
                            else if (C_KHOILUONG >= int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count -1]["C_KHOILUONG"].ToString()))
                            {
                                if (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) % C_KHOILUONGLK) == 0)
                                {
                                    CUOCCHINH = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) * GIACUOCLK;
                                }else{
                                    CUOCCHINH = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) + 1) * GIACUOCLK;
                                }
                                check = false;
                            }
                        }
                    }
                }
            }
            //CUOCCHINH = CUOCCHINH + ((CUOCCHINH * PPXD) / 100);
        }
        if (Alarm != "")
        {
            string script = string.Format("var result = '{0}'", Alarm);
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
        }
        else
        {
            string script = string.Format("var result = '{0}'",PPXD + "," + CUOCCHINH + "," + FK_DOITAC + "," + GIADOITAC);
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
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
            SetMessage("Tạo mới nhận gửi thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted NHANGUIs", "{PK_ID:\"" + getmaxid("NHANGUI") + "\"}");
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
            RadDatePicker radNgaynhangui = (RadDatePicker)editItem.FindControl("radNgaynhangui");
            HiddenField txtID = (HiddenField)editItem.FindControl("txtID");
            Session["txtID"] = (txtID.Value != "") ? txtID.Value : "0";
            HiddenField hfTinhThanh = (HiddenField)editItem.FindControl("hfTinhThanh");
            HiddenField hfQuanHuyen = (HiddenField)editItem.FindControl("hfQuanHuyen");
            QUANHUYENDataSource.SelectCommand = LoadFilteredManually(hfQuanHuyen.Value);
            RadComboBox cmbTinhThanh = (RadComboBox)editItem.FindControl("cmbTinhThanh");
            RadComboBox cmbQuanHuyen = (RadComboBox)editItem.FindControl("cmbQuanHuyen");
            cmbTinhThanh.SelectedValue = hfTinhThanh.Value;
            QUANHUYENDataSource.SelectCommand = LoadFilteredManually(hfTinhThanh.Value);
            cmbQuanHuyen.DataBind();
            cmbQuanHuyen.SelectedValue = hfQuanHuyen.Value;
            RadNumericTextBox txtPPXD = (RadNumericTextBox)editItem.FindControl("txtPPXD");
            RadTextBox txtCODE = (RadTextBox)editItem.FindControl("txtCODE");
            RadAutoCompleteBox radautoC_MAKH = (RadAutoCompleteBox)editItem.FindControl("radautoC_MAKH");
            RadAutoCompleteBox radautoC_TENKH = (RadAutoCompleteBox)editItem.FindControl("radautoC_TENKH");
            RadNumericTextBox txtC_KHOILUONG = (RadNumericTextBox)editItem.FindControl("txtC_KHOILUONG");
            RadComboBox cmbNhomKhachHang = (RadComboBox)editItem.FindControl("cmbNhomKhachHang ");
            RadComboBox cmbSanPham = (RadComboBox)editItem.FindControl("cmbSanPham");
            RadNumericTextBox txtC_GIACUOC = (RadNumericTextBox)editItem.FindControl("txtC_GIACUOC");
            RadNumericTextBox txtC_DONGGOI = (RadNumericTextBox)editItem.FindControl("txtC_DONGGOI");
            RadNumericTextBox txtC_KHAIGIA = (RadNumericTextBox)editItem.FindControl("txtC_KHAIGIA");
            RadNumericTextBox txtC_COD = (RadNumericTextBox)editItem.FindControl("txtC_COD");
            RadNumericTextBox txtC_KHAC = (RadNumericTextBox)editItem.FindControl("txtC_KHAC");
            RadNumericTextBox txtC_TIENHANG = (RadNumericTextBox)editItem.FindControl("txtC_TIENHANG");
            RadNumericTextBox txtC_DATHU = (RadNumericTextBox)editItem.FindControl("txtC_DATHU");
            RadNumericTextBox txtC_CONLAI = (RadNumericTextBox)editItem.FindControl("txtC_CONLAI");
            if (e.Item is GridEditFormInsertItem || e.Item is GridDataInsertItem)
            {
                // insert item
                radNgaynhangui.SelectedDate = System.DateTime.Now;
                txtCODE.Text = GetMaxBill();

            }
            else
            {
                // edit item
                txtC_CONLAI.Text = (decimal.Parse(txtC_TIENHANG.Text) - decimal.Parse(txtC_DATHU.Text)).ToString();
                string SelectSQL1;
                SelectSQL1 = "Select DMMASANPHAM.C_PPXD FROM DMMASANPHAM WHERE DMMASANPHAM.PK_ID = " + cmbSanPham.SelectedValue + "";
                DataTable oDataTable1 = new DataTable();
                ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
                oDataTable1 = SelectQuery1.query_data(SelectSQL1);
                if (oDataTable1.Rows.Count != 0)
                {
                    if (oDataTable1.Rows[0]["C_PPXD"] != DBNull.Value)
                    {
                        txtPPXD.Text = oDataTable1.Rows[0]["C_PPXD"].ToString();
                    }
                }
                FK_DICHVU = cmbSanPham.SelectedValue;
                FK_QUANHUYEN = hfQuanHuyen.Value;
                string FK_NHOMKHACHHANG = "1";//(cmbNhomKhachHang.SelectedIndex.ToString() != "Chọn nhóm") ? cmbNhomKhachHang.SelectedValue : " ";
                string SelectSQL2;
                SelectSQL2 = "Select DMMABANGCUOC.PK_ID FROM DMMABANGCUOC WHERE (DMMABANGCUOC.C_VALUE ='" + FK_NHOMKHACHHANG + "') OR (DMMABANGCUOC.C_VALUE LIKE '%," + FK_NHOMKHACHHANG + ",%') OR (DMMABANGCUOC.C_VALUE LIKE '%," + FK_NHOMKHACHHANG + "') OR (DMMABANGCUOC.C_VALUE LIKE '" + FK_NHOMKHACHHANG + ",%')";
                DataTable oDataTable2 = new DataTable();
                ITCLIB.Admin.SQL SelectQuery2 = new ITCLIB.Admin.SQL();
                oDataTable2 = SelectQuery2.query_data(SelectSQL2);
                if (oDataTable2.Rows.Count != 0)
                {
                    FK_MABANGCUOC = oDataTable2.Rows[0]["PK_ID"].ToString();
                }
                else
                {
                    FK_MABANGCUOC = "0";
                }               
                string SelectSQL3;
                SelectSQL3 = "Select DMMAVUNG.PK_ID FROM DMMAVUNG WHERE FK_MASANPHAM=" + FK_DICHVU + " AND C_TYPE = 1 AND ((DMMAVUNG.C_DESC ='" + FK_QUANHUYEN + "') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUANHUYEN + ",%') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUANHUYEN + "') OR (DMMAVUNG.C_DESC LIKE '" + FK_QUANHUYEN + ",%'))";
                DataTable oDataTable3 = new DataTable();
                ITCLIB.Admin.SQL SelectQuery3 = new ITCLIB.Admin.SQL();
                oDataTable3 = SelectQuery3.query_data(SelectSQL3);
                if (oDataTable3.Rows.Count != 0)
                {
                    FK_MAVUNG = oDataTable3.Rows[0]["PK_ID"].ToString();
                }
                else
                {
                    FK_MAVUNG = "0";
                }
                C_KHOILUONG = decimal.Parse(txtC_KHOILUONG.Text);
                PPXD = decimal.Parse(txtPPXD.Text);
                CUOCCHINH = decimal.Parse(txtC_GIACUOC.Text);
                FK_DOITAC = "";
                GIADOITAC = 0;
                ctcDataTable = new DataTable();
                C_KHOILUONGLK = 0;
                GIACUOCLK = 0;                            
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
        string SelectSQL = "SELECT MAX(CAST(C_BILL AS Int)) as MAXBILL FROM NHANGUI";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);

        if (oDataTable.Rows[0]["MAXBILL"] != DBNull.Value)
        {
            int maxvalue = (int)oDataTable.Rows[0]["MAXBILL"];
            maxbill = String.Format("{0:00000000}", maxvalue + 1);   
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
                if (!ValidateDeleteGroup(item["pk_id"].Text))
                {
                    SetMessage("Không thể xóa nhận gửi \"" + item["c_name"].Text + "\" do có tham chiếu dữ liệu khác.");
                    RadGridNHANGUI.Rebind();
                }
            }
        }
        else if (e.CommandName == RadGrid.PerformInsertCommandName)
        {                
        }
        else if (e.CommandName == RadGrid.UpdateCommandName)
        {
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
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Write(Session["test"].ToString());
        ITCLIB.Admin.JavaScript.ShowMessage(Session["test"].ToString(), this);
    }
}