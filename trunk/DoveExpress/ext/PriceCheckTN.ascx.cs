using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class ext_PriceCheckTN : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        RadAjaxManager ajaxManager = RadAjaxManager.GetCurrent(Page);
        ajaxManager.AjaxRequest += new RadAjaxControl.AjaxRequestDelegate(RadScriptManager_AjaxRequestNG);
        ajaxManager.ClientEvents.OnResponseEnd = "onResponseEndNG";
    }
    protected void RadScriptManager_AjaxRequestNG(object sender, AjaxRequestEventArgs e)
    {
        /*GridEditableItem editableItem = null;
        foreach (GridEditFormItem item in RadGridNHANGUI.MasterTableView.GetItems(GridItemType.EditFormItem))
        {
            if (item.IsInEditMode)
            {
                editableItem = (GridEditableItem)item;
            }
        }
        RadNumericTextBox txtPPXD = (RadNumericTextBox)editableItem.FindControl("txtPPXD");
        RadNumericTextBox txtCODE = (RadNumericTextBox)editableItem.FindControl("txtCODE");
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
                string SelectSQL;
                SelectSQL = "Select DMMAVUNG.PK_ID FROM DMMAVUNG WHERE FK_MASANPHAM=" + FK_DICHVU + " AND C_TYPE = 1 AND ((DMMAVUNG.C_DESC ='" + FK_QUANHUYEN + "') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUANHUYEN + ",%') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUANHUYEN + "') OR (DMMAVUNG.C_DESC LIKE '" + FK_QUANHUYEN + ",%')) AND (DMMAVUNG.FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"].ToString() + "')";
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
                    Alarm = "msg,-,Quận huyện này không nằm trong vùng tính cước nào";
                }
            }
            isCuocchinh = true;
        }
        else if ((arrayvalue[0] == "cmbSanPham") && (FK_DICHVU != arrayvalue[1]))
        {
            FK_DICHVU = arrayvalue[1];
            string SelectSQL1;
            SelectSQL1 = "Select DMPPXD.C_PPXD FROM DMPPXD WHERE DMPPXD.FK_MASANPHAM =" + FK_DICHVU + " AND FK_MABANGCUOC = " + FK_MABANGCUOC;
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
            if (FK_QUANHUYEN != "")
            {
                string SelectSQL;
                SelectSQL = "Select DMMAVUNG.PK_ID FROM DMMAVUNG WHERE FK_MASANPHAM=" + FK_DICHVU + " AND C_TYPE = 1 AND FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"] + "' AND ((DMMAVUNG.C_DESC ='" + FK_QUANHUYEN + "') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUANHUYEN + ",%') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUANHUYEN + "') OR (DMMAVUNG.C_DESC LIKE '" + FK_QUANHUYEN + ",%')) AND (DMMAVUNG.FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"].ToString() + "')";
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
                    Alarm = "msg,-,Quận huyện này không nằm trong vùng tính cước nào";
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
            isCuocdoitac = true;
        }
        if (C_KHOILUONG != 0)
        {
            if ((FK_MABANGCUOC != "") && (FK_MAVUNG != "") && (isCuocchinh))
            {
                GiaCuocChinh();
            }
            //CUOCCHINH = (Math.Round((CUOCCHINH + ((CUOCCHINH * PPXD) / 100)) / 1000)) * 1000;
            if ((FK_DOITAC != "") && (isCuocdoitac))
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
            string script = string.Format("var result = '{0}'", FK_KHACHHANG + ",-," + TENKH + ",-," + DIENTHOAIKH + ",-," + PPXD + ",-," + CUOCCHINH + ",-," + GIADOITAC + ",-," + FK_MABANGCUOC + ",-," + FK_MAVUNG);
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
        }*/
        string script = "12";
        ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
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
}