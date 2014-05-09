using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using System.Globalization;
using System.Xml;

public partial class ext_PriceCheckQT : System.Web.UI.UserControl
{
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
            return Session["FK_KHACHHANGQT"] as string;
        }
        set
        {
            Session["FK_KHACHHANGQT"] = value;
        }
    }
    private string FK_DICHVU
    {
        get
        {
            return Session["FK_DICHVUQT"] as string;
        }
        set
        {
            Session["FK_DICHVUQT"] = value;
        }
    }
    private string FK_MABANGCUOC
    {
        get
        {
            return Session["FK_MABANGCUOCQT"] as string;
        }
        set
        {
            Session["FK_MABANGCUOCQT"] = value;
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
            return Session["FK_MAVUNGQT"] as string;
        }
        set
        {
            Session["FK_MAVUNGQT"] = value;
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
            return int.Parse(Session["C_KHOILUONGQT"].ToString());
        }
        set
        {
            Session["C_KHOILUONGQT"] = value;
        }
    }
    private decimal PPXD
    {
        get
        {
            return decimal.Parse(Session["PPXDQT"].ToString());
        }
        set
        {
            Session["PPXDQT"] = value;
        }
    }
    private decimal CUOCCHINH
    {
        get
        {
            return decimal.Parse(Session["CUOCCHINHQT"].ToString());
        }
        set
        {
            Session["CUOCCHINHQT"] = value;
        }
    }
    private decimal CUOCCHINHTL
    {
        get
        {
            return decimal.Parse(Session["CUOCCHINHTLQT"].ToString());
        }
        set
        {
            Session["CUOCCHINHTLQT"] = value;
        }
    }
    private string FK_DICHVUDOITAC
    {
        get
        {
            return Session["FK_DICHVUDOITACQT"] as string;
        }
        set
        {
            Session["FK_DICHVUDOITACQT"] = value;
        }
    }
    private DataTable ctcDataTable
    {
        get
        {
            return Session["ctcDataTableQT"] as DataTable;
        }
        set
        {
            Session["ctcDataTableQT"] = value;
        }
    }
    private DataTable ctcDataTable1
    {
        get
        {
            return Session["ctcDataTable1QT"] as DataTable;
        }
        set
        {
            Session["ctcDataTable1QT"] = value;
        }
    }
    private int C_KHOILUONGLK
    {
        get
        {
            return int.Parse(Session["C_KHOILUONGLKQT"].ToString());
        }
        set
        {
            Session["C_KHOILUONGLKQT"] = value;
        }
    }
    private decimal GIACUOCLK
    {
        get
        {
            return decimal.Parse(Session["GIACUOCLKQT"].ToString());
        }
        set
        {
            Session["GIACUOCLKQT"] = value;
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
    string Alarm = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ClearSession();
        }
        RadAjaxManager ajaxManager = RadAjaxManager.GetCurrent(Page);
        ajaxManager.AjaxRequest += new RadAjaxControl.AjaxRequestDelegate(RadScriptManager_AjaxRequestNG);
        ajaxManager.ClientEvents.OnResponseEnd = "onResponseEndNG";
    }
    protected void RadScriptManager_AjaxRequestNG(object sender, AjaxRequestEventArgs e)
    {
        Session["VUNGLAMVIEC"] = cmbVungLamViec.SelectedValue;
        txtC_TYGIA.Text = GetTyGia();
        string[] arrayvalue = e.Argument.Split(';');
        LoadKhachHang();
        string SelectSQL;
        SelectSQL = "Select DMKHACHHANG.FK_NHOMKHACHHANGQT,DMKHACHHANG.C_NAME,DMKHACHHANG.C_TEL FROM DMKHACHHANG WHERE DMKHACHHANG.C_CODE ='" + FK_KHACHHANG + "'";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            FK_NHOMKHACHHANGQT = oDataTable.Rows[0]["FK_NHOMKHACHHANGQT"].ToString();
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
                Alarm = "msg,-,Nhóm khách hàng này không nằm trong bảng cước nào trong khu vực làm việc " + Session["VUNGLAMVIEC"].ToString();
            }
        }
        else
        {
            FK_NHOMKHACHHANGQT = "";
            Alarm = "msg,-,Mã khách hàng này không nằm trong nhóm khách hàng nào";
        }
        if (arrayvalue[0] == "cmbQuocGia")
        {
            FK_QUOCGIA = arrayvalue[1];
            if (FK_DICHVU != "")
            {
                string SelectSQL2;
                SelectSQL2 = "Select DMMAVUNG.PK_ID FROM DMMAVUNG WHERE FK_MASANPHAM=" + FK_DICHVU + " AND C_TYPE = 2 AND ((DMMAVUNG.C_DESC ='" + FK_QUOCGIA + "') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUOCGIA + ",%') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUOCGIA + "') OR (DMMAVUNG.C_DESC LIKE '" + FK_QUOCGIA + ",%')) AND (DMMAVUNG.FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"].ToString() + "')";
                DataTable oDataTable2 = new DataTable();
                ITCLIB.Admin.SQL SelectQuery2 = new ITCLIB.Admin.SQL();
                oDataTable2 = SelectQuery2.query_data(SelectSQL2);
                if (oDataTable2.Rows.Count != 0)
                {
                    FK_MAVUNG = oDataTable2.Rows[0]["PK_ID"].ToString();
                }
                else
                {
                    FK_MAVUNG = "";
                    Alarm = "msg,-,Quốc gia này không nằm trong vùng tính cước nào";
                }
            }
        }
        else if (arrayvalue[0] == "cmbSanPham")
        {
            FK_DICHVU = arrayvalue[1];
            string SelectSQL3;
            SelectSQL3 = "Select DMPPXDDT.C_PPXD FROM DMPPXDDT WHERE DMPPXDDT.FK_MASANPHAM =" + FK_DICHVU + " AND FK_DOITAC = " + FK_MABANGCUOC;
            DataTable oDataTable3 = new DataTable();
            ITCLIB.Admin.SQL SelectQuery3 = new ITCLIB.Admin.SQL();
            oDataTable3 = SelectQuery3.query_data(SelectSQL3);
            if (oDataTable3.Rows.Count != 0)
            {
                if (oDataTable3.Rows[0]["C_PPXD"] != DBNull.Value)
                {
                    PPXD = decimal.Parse(oDataTable3.Rows[0]["C_PPXD"].ToString());
                }
                else
                {
                    PPXD = 0;
                }
            }
            if (FK_QUOCGIA != "")
            {
                string SelectSQL4;
                SelectSQL4 = "Select DMMAVUNG.PK_ID FROM DMMAVUNG WHERE FK_MASANPHAM=" + FK_DICHVU + " AND C_TYPE = 2 AND ((DMMAVUNG.C_DESC ='" + FK_QUOCGIA + "') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUOCGIA + ",%') OR (DMMAVUNG.C_DESC LIKE '%," + FK_QUOCGIA + "') OR (DMMAVUNG.C_DESC LIKE '" + FK_QUOCGIA + ",%')) AND (DMMAVUNG.FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"].ToString() + "')";
                DataTable oDataTable4 = new DataTable();
                ITCLIB.Admin.SQL SelectQuery4 = new ITCLIB.Admin.SQL();
                oDataTable4 = SelectQuery4.query_data(SelectSQL4);
                if (oDataTable4.Rows.Count != 0)
                {
                    FK_MAVUNG = oDataTable4.Rows[0]["PK_ID"].ToString();
                }
                else
                {
                    FK_MAVUNG = "";
                    Alarm = "msg,-,Quốc gia này không nằm trong vùng tính cước nào";
                }
            }
        }
        else if (arrayvalue[0] == "txtC_KHOILUONG")
        {
            C_KHOILUONG = int.Parse(arrayvalue[1]);
        }
        if (C_KHOILUONG != 0)
        {
            if ((FK_MABANGCUOC != "") && (FK_MAVUNG != ""))
            {
                GiaCuocChinh();
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
            string script = "";
            if (isTAILIEU)
            {
                script = string.Format("var result = '{0}'", FK_KHACHHANG + ",-," + PPXD + ",-," + CUOCCHINHTL); //+ ",-," + FK_MABANGCUOC + ",-," + FK_MAVUNG + ",-," + FK_MAVUNGDT + ",-," + FK_DOITAC);
            }
            else
            {
                script = string.Format("var result = '{0}'", FK_KHACHHANG + ",-," + PPXD + ",-," + CUOCCHINH); //+ ",-," + FK_MABANGCUOC + ",-," + FK_MAVUNG + ",-," + FK_MAVUNGDT + ",-," + FK_DOITAC);
            }
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
        }
    }
    protected void LoadKhachHang()
    {
        string SelectSQL = "SELECT C_VALUE FROM DMCAUHINHVALUE WHERE FK_CAUHINH = 2 AND FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"] + "'";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            FK_KHACHHANG = oDataTable.Rows[0]["C_VALUE"].ToString();
        }
        else
        {
            FK_KHACHHANG = "";
        }
    }
    protected void cmbVungLamViec_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cmbVungLamViec.SelectedValue = "Hà Nội";
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
    }
    protected void ClearSession()
    {
        FK_NHOMKHACHHANGQT = "";
        FK_KHACHHANG = "";
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
        ctcDataTable = new DataTable();
        ctcDataTable1 = new DataTable();
        C_KHOILUONGLK = 0;
        GIACUOCLK = 0;
        GIACUOCLKTL = 0;
        isTAILIEU = false;
        Alarm = "";
        txtC_TYGIA.Text = GetTyGia();
        txtPPXD.Text = (txtPPXD.Text == "") ? "0" : txtPPXD.Text;
        txtC_GIATRIHANGHOA.Text = (txtC_GIATRIHANGHOA.Text == "") ? "0" : txtC_GIATRIHANGHOA.Text;
        txtC_KHOILUONG.Text = (txtC_KHOILUONG.Text == "") ? "0" : txtC_KHOILUONG.Text;
        txtC_GIACUOC.Text = (txtC_GIACUOC.Text == "") ? "0" : txtC_GIACUOC.Text;
        txtC_DONGGOI.Text = (txtC_DONGGOI.Text == "") ? "0" : txtC_DONGGOI.Text;
        txtC_KHAIGIA.Text = (txtC_KHAIGIA.Text == "") ? "0" : txtC_KHAIGIA.Text;
        txtC_COD.Text = (txtC_COD.Text == "") ? "0" : txtC_COD.Text;
        txtC_BAOPHAT.Text = (txtC_BAOPHAT.Text == "") ? "0" : txtC_BAOPHAT.Text;
        txtC_HENGIO.Text = (txtC_HENGIO.Text == "") ? "0" : txtC_HENGIO.Text;
        txtC_TIENHANG.Text = (txtC_TIENHANG.Text == "") ? "0" : txtC_TIENHANG.Text;
        txtC_TIENHANGVAT.Text = (txtC_TIENHANGVAT.Text == "") ? "0" : txtC_TIENHANGVAT.Text;
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
}