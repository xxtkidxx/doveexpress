﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;
using System.Globalization;

public partial class module_NHANGUIQT : System.Web.UI.UserControl
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
    string Alarm = "";
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
        foreach (GridEditFormItem item in RadGridNHANGUIQT.MasterTableView.GetItems(GridItemType.EditFormItem))
        {
            if (item.IsInEditMode)
            {
                editableItem = (GridEditableItem)item;
            }
        }
        RadNumericTextBox txtPPXD = (RadNumericTextBox)editableItem.FindControl("txtPPXD");
        RadNumericTextBox txtCODE = (RadNumericTextBox)editableItem.FindControl("txtCODE");
        RadAutoCompleteBox radautoC_MAKH = (RadAutoCompleteBox)editableItem.FindControl("radautoC_MAKH");
        RadAutoCompleteBox radautoC_TENKH = (RadAutoCompleteBox)editableItem.FindControl("radautoC_TENKH");
        RadNumericTextBox txtC_KHOILUONG = (RadNumericTextBox)editableItem.FindControl("txtC_KHOILUONG");
        string[] arrayvalue = e.Argument.Split(';');
        if (arrayvalue[0] == "cmbMaKhachHang")
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
        }
        else if (arrayvalue[0] == "cmbQuocGia")
        {
            FK_QUOCGIA = arrayvalue[1];
            if (FK_DICHVU != "")
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
        }
        else if (arrayvalue[0] == "cmbSanPham")
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
        }
        else if (arrayvalue[0] == "txtC_KHOILUONG")
        {
            C_KHOILUONG = int.Parse(arrayvalue[1]);
        }
        else if (arrayvalue[0] == "cmbFK_DOITAC")
        {
            FK_DOITAC = arrayvalue[1];
        }
        if ((FK_MABANGCUOC != "") && (FK_MAVUNG != ""))
        {
            string SelectSQL1;
            SelectSQL1 = "Select DMCHITIETCUOCDT.PK_ID,DMCHITIETCUOCDT.C_KHOILUONG,DMCHITIETCUOCDT.C_CUOCPHI,DMCHITIETCUOCDT.C_TYPE FROM DMCHITIETCUOCDT WHERE C_LOAITIEN = N'USD' AND FK_DOITAC = " + FK_MABANGCUOC + " AND FK_MAVUNG = " + FK_MAVUNG + " AND C_TYPE <> 1 AND C_TYPE1 <> 1 ORDER BY C_KHOILUONG  ASC";
            ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
            ctcDataTable = SelectQuery1.query_data(SelectSQL1);
            string SelectSQL2;
            SelectSQL2 = "Select DMCHITIETCUOCDT.PK_ID,DMCHITIETCUOCDT.C_KHOILUONG,DMCHITIETCUOCDT.C_CUOCPHI,DMCHITIETCUOCDT.C_TYPE FROM DMCHITIETCUOCDT WHERE C_LOAITIEN = N'USD' AND FK_DOITAC = " + FK_MABANGCUOC + " AND FK_MAVUNG = " + FK_MAVUNG + " AND C_TYPE = 1 AND C_TYPE1 <> 1 ORDER BY C_KHOILUONG";
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery2 = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery2.query_data(SelectSQL2);
            if (oDataTable.Rows.Count != 0)
            {
                C_KHOILUONGLK = int.Parse(oDataTable.Rows[0]["C_KHOILUONG"].ToString(), NumberStyles.Currency);
                GIACUOCLK = decimal.Parse(oDataTable.Rows[0]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
            }
            string SelectSQL3;
            SelectSQL3 = "Select DMCHITIETCUOCDT.PK_ID,DMCHITIETCUOCDT.C_KHOILUONG,DMCHITIETCUOCDT.C_CUOCPHI,DMCHITIETCUOCDT.C_TYPE FROM DMCHITIETCUOCDT WHERE C_LOAITIEN = N'USD' AND FK_DOITAC = " + FK_MABANGCUOC + " AND FK_MAVUNG = " + FK_MAVUNG + " AND C_TYPE1 = 1 ORDER BY C_KHOILUONG  ASC";
            ITCLIB.Admin.SQL SelectQuery3 = new ITCLIB.Admin.SQL();
            ctcDataTable1 = SelectQuery3.query_data(SelectSQL3);

        }
        if (C_KHOILUONG != 0)
        {
            // Có tính theo kg
            if (ctcDataTable1.Rows.Count != 0)
            {
                if (C_KHOILUONG <= int.Parse(ctcDataTable1.Rows[0]["C_KHOILUONG"].ToString()))
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
                                    }
                                }
                                else
                                {
                                    if (C_KHOILUONG <= int.Parse(ctcDataTable.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG >= int.Parse(ctcDataTable.Rows[i - 1]["C_KHOILUONG"].ToString()))
                                    {
                                        CUOCCHINH = decimal.Parse(ctcDataTable.Rows[i]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                        CUOCCHINH = CUOCCHINH + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                        check = false;
                                    }
                                    else if (C_KHOILUONG > int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString()))
                                    {
                                        if (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) % C_KHOILUONGLK) == 0)
                                        {
                                            CUOCCHINH = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) * GIACUOCLK;
                                            CUOCCHINH = CUOCCHINH + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                        }
                                        else
                                        {
                                            CUOCCHINH = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) + 1) * GIACUOCLK;
                                            CUOCCHINH = CUOCCHINH + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                        }
                                        check = false;
                                    }
                                }
                            }
                        }
                    }

                }
                else
                {
                    //Theo KG
                    if (ctcDataTable1.Rows.Count == 1)
                    {
                        CUOCCHINH = decimal.Parse(ctcDataTable.Rows[0]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                        CUOCCHINH = CUOCCHINH + (CUOCCHINH * C_VALUE2)/100;
                    }
                    else
                    {
                        bool check1 = true;
                        for (int i = 0; i < ctcDataTable1.Rows.Count; i++)
                        {
                            if (check1)
                            {
                                if (C_KHOILUONG <= int.Parse(ctcDataTable1.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG >= int.Parse(ctcDataTable1.Rows[i - 1]["C_KHOILUONG"].ToString()))
                                {
                                    CUOCCHINH = decimal.Parse(ctcDataTable1.Rows[i]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                    CUOCCHINH = CUOCCHINH + (CUOCCHINH * C_VALUE2) / 100;
                                    check1 = false;
                                }
                                else if (C_KHOILUONG > int.Parse(ctcDataTable1.Rows[ctcDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString()))
                                {
                                    CUOCCHINH = decimal.Parse(ctcDataTable1.Rows[ctcDataTable1.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                    CUOCCHINH = CUOCCHINH + (CUOCCHINH * C_VALUE2) / 100;
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
                                }
                            }
                            else
                            {
                                if (C_KHOILUONG <= int.Parse(ctcDataTable.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG >= int.Parse(ctcDataTable.Rows[i - 1]["C_KHOILUONG"].ToString()))
                                {
                                    CUOCCHINH = decimal.Parse(ctcDataTable.Rows[i]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                    CUOCCHINH = CUOCCHINH + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                    check = false;
                                }
                                else if (C_KHOILUONG > int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString()))
                                {
                                    if (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) % C_KHOILUONGLK) == 0)
                                    {
                                        CUOCCHINH = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) * GIACUOCLK;
                                        CUOCCHINH = CUOCCHINH + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                    }
                                    else
                                    {
                                        CUOCCHINH = decimal.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(ctcDataTable.Rows[ctcDataTable.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLK) + 1) * GIACUOCLK;
                                        CUOCCHINH = CUOCCHINH + ((decimal)C_KHOILUONG / 1000) + C_VALUE1;
                                    }
                                    check = false;
                                }
                            }
                        }
                    }
                }
            }
            //CUOCCHINH = (Math.Round((CUOCCHINH + ((CUOCCHINH * PPXD) / 100)) / 1000)) * 1000;
            if (FK_DOITAC != "")
            {
                int C_KHOILUONGLKDT = 0;
                decimal GIACUOCLKDT = 0;
                string SelectSQL1;
                SelectSQL1 = "Select DMCHITIETCUOCDT.PK_ID,DMCHITIETCUOCDT.C_KHOILUONG,DMCHITIETCUOCDT.C_CUOCPHI,DMCHITIETCUOCDT.C_TYPE FROM DMCHITIETCUOCDT WHERE C_LOAITIEN = N'USD' AND FK_DOITAC = " + FK_DOITAC + " AND FK_MAVUNG = " + FK_MAVUNG + " AND C_TYPE <> 1 AND C_TYPE1 <> 1 ORDER BY C_KHOILUONG  ASC";
                ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
                DataTable oDataTable1 = new DataTable();
                oDataTable1 = SelectQuery1.query_data(SelectSQL1);
                string SelectSQL2;
                SelectSQL2 = "Select DMCHITIETCUOCDT.PK_ID,DMCHITIETCUOCDT.C_KHOILUONG,DMCHITIETCUOCDT.C_CUOCPHI,DMCHITIETCUOCDT.C_TYPE FROM DMCHITIETCUOCDT WHERE C_LOAITIEN = N'USD' AND FK_DOITAC = " + FK_DOITAC + " AND FK_MAVUNG = " + FK_MAVUNG + " AND C_TYPE = 1 AND C_TYPE1 <> 1 ORDER BY C_KHOILUONG  ASC";
                DataTable oDataTable2 = new DataTable();
                ITCLIB.Admin.SQL SelectQuery2 = new ITCLIB.Admin.SQL();
                oDataTable2 = SelectQuery2.query_data(SelectSQL2);
                if (oDataTable2.Rows.Count != 0)
                {
                    C_KHOILUONGLKDT = int.Parse(oDataTable2.Rows[0]["C_KHOILUONG"].ToString(), NumberStyles.Currency);
                    GIACUOCLKDT = decimal.Parse(oDataTable2.Rows[0]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                }
                string SelectSQL3;
                SelectSQL3 = "Select DMCHITIETCUOCDT.PK_ID,DMCHITIETCUOCDT.C_KHOILUONG,DMCHITIETCUOCDT.C_CUOCPHI,DMCHITIETCUOCDT.C_TYPE FROM DMCHITIETCUOCDT WHERE C_LOAITIEN = N'USD' AND FK_DOITAC = " + FK_DOITAC + " AND FK_MAVUNG = " + FK_MAVUNG + " AND C_TYPE1 = 1 ORDER BY C_KHOILUONG  ASC";
                ITCLIB.Admin.SQL SelectQuery3 = new ITCLIB.Admin.SQL();
                DataTable oDataTable3 = new DataTable();
                oDataTable3 = SelectQuery3.query_data(SelectSQL3);
                if (oDataTable3.Rows.Count != 0)
                {
                    if (C_KHOILUONG <= int.Parse(oDataTable3.Rows[0]["C_KHOILUONG"].ToString()))
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
                                        if (C_KHOILUONG <= int.Parse(oDataTable1.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG >= int.Parse(oDataTable1.Rows[i - 1]["C_KHOILUONG"].ToString()))
                                        {
                                            GIADOITAC = decimal.Parse(oDataTable1.Rows[i]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                            check = false;
                                        }
                                        else if (C_KHOILUONG > int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString()))
                                        {
                                            if (((C_KHOILUONG - int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString())) % C_KHOILUONGLKDT) == 0)
                                            {
                                                GIADOITAC = decimal.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLKDT) * GIACUOCLKDT;
                                            }
                                            else
                                            {
                                                GIADOITAC = decimal.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLKDT) + 1) * GIACUOCLKDT;
                                            }
                                            check = false;
                                        }
                                    }
                                }
                            }
                        }

                    }
                    else
                    {
                        if (oDataTable3.Rows.Count == 1)
                        {
                            GIADOITAC = decimal.Parse(oDataTable1.Rows[0]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                        }
                        else
                        {
                            bool check1 = true;
                            for (int i = 0; i < oDataTable3.Rows.Count; i++)
                            {
                                if (check1)
                                {
                                    if (C_KHOILUONG <= int.Parse(oDataTable3.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG >= int.Parse(oDataTable3.Rows[i - 1]["C_KHOILUONG"].ToString()))
                                    {
                                        GIADOITAC = decimal.Parse(oDataTable3.Rows[i]["C_CUOCPHI"].ToString(), NumberStyles.Currency) * C_KHOILUONG / 1000;
                                        check1 = false;
                                    }
                                    else if (C_KHOILUONG > int.Parse(oDataTable3.Rows[oDataTable3.Rows.Count - 1]["C_KHOILUONG"].ToString()))
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
                                    if (C_KHOILUONG <= int.Parse(oDataTable1.Rows[i]["C_KHOILUONG"].ToString()) && C_KHOILUONG >= int.Parse(oDataTable1.Rows[i - 1]["C_KHOILUONG"].ToString()))
                                    {
                                        GIADOITAC = decimal.Parse(oDataTable1.Rows[i]["C_CUOCPHI"].ToString(), NumberStyles.Currency);
                                        check = false;
                                    }
                                    else if (C_KHOILUONG > int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString()))
                                    {
                                        if (((C_KHOILUONG - int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString())) % C_KHOILUONGLKDT) == 0)
                                        {
                                            GIADOITAC = decimal.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + ((C_KHOILUONG - int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLKDT) * GIACUOCLKDT;
                                        }
                                        else
                                        {
                                            GIADOITAC = decimal.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_CUOCPHI"].ToString(), NumberStyles.Currency) + (((C_KHOILUONG - int.Parse(oDataTable1.Rows[oDataTable1.Rows.Count - 1]["C_KHOILUONG"].ToString())) / C_KHOILUONGLKDT) + 1) * GIACUOCLKDT;
                                        }
                                        check = false;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        if (Alarm != "")
        {
            string script = string.Format("var result = '{0}'", Alarm);
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
        }
        else
        {
            string script = string.Format("var result = '{0}'", FK_KHACHHANG + ",-," + TENKH + ",-," + DIENTHOAIKH + ",-," + PPXD + ",-," + CUOCCHINH + ",-," + GIADOITAC + ",-," + FK_MABANGCUOC + ",-," + FK_MAVUNG);
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
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
            ClearSession();
            SetMessage("Tạo mới nhận gửi thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted NHANGUIQTs", "{PK_ID:\"" + getmaxid("NHANGUI") + "\"}");
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
            RadDatePicker radNgaynhangui = (RadDatePicker)editItem.FindControl("radNgaynhangui");
            RadTextBox txtC_TENKH = (RadTextBox)editItem.FindControl("txtC_TENKH");
            RadTextBox txtC_TELGUI = (RadTextBox)editItem.FindControl("txtC_TELGUI");
            HiddenField txtID = (HiddenField)editItem.FindControl("txtID");
            Session["txtID"] = (txtID.Value != "") ? txtID.Value : "0";
            RadComboBox cmbQuocGia = (RadComboBox)editItem.FindControl("cmbQuocGia");
            RadComboBox cmbC_TAILIEU = (RadComboBox)editItem.FindControl("cmbC_TAILIEU");
            RadNumericTextBox txtPPXD = (RadNumericTextBox)editItem.FindControl("txtPPXD");
            txtPPXD.Text = (txtPPXD.Text == "") ? "0" : txtPPXD.Text;
            RadNumericTextBox txtCODE = (RadNumericTextBox)editItem.FindControl("txtCODE");
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
            RadNumericTextBox txtC_VAT = (RadNumericTextBox)editItem.FindControl("txtC_VAT");
            txtC_VAT.Text = (txtC_VAT.Text == "") ? "0" : txtC_VAT.Text;
            RadNumericTextBox txtC_TIENHANGVAT = (RadNumericTextBox)editItem.FindControl("txtC_TIENHANGVAT");
            txtC_TIENHANGVAT.Text = (txtC_TIENHANGVAT.Text == "") ? "0" : txtC_TIENHANGVAT.Text;
            RadNumericTextBox txtC_DATHU = (RadNumericTextBox)editItem.FindControl("txtC_DATHU");
            txtC_DATHU.Text = (txtC_DATHU.Text == "") ? "0" : txtC_DATHU.Text;
            RadNumericTextBox txtC_CONLAI = (RadNumericTextBox)editItem.FindControl("txtC_CONLAI");
            txtC_CONLAI.Text = (txtC_CONLAI.Text == "") ? "0" : txtC_CONLAI.Text;
            RadNumericTextBox txtC_GIADOITAC = (RadNumericTextBox)editItem.FindControl("txtC_GIADOITAC");
            txtC_GIADOITAC.Text = (txtC_GIADOITAC.Text == "") ? "0" : txtC_GIADOITAC.Text;
            if (e.Item is GridEditFormInsertItem || e.Item is GridDataInsertItem)
            {
                // insert item
                radNgaynhangui.SelectedDate = System.DateTime.Now;
                cmbC_TAILIEU.SelectedIndex = 1;
                txtCODE.Text = GetMaxBill();
                ClearSession();
            }
            else
            {
                // edit item                
                txtC_CONLAI.Text = (((txtC_TIENHANGVAT.Text == "") ? 0 : decimal.Parse(txtC_TIENHANGVAT.Text)) - ((txtC_DATHU.Text == "") ? 0 : decimal.Parse(txtC_DATHU.Text))).ToString();
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
                C_KHOILUONG = (txtC_KHOILUONG.Text != "") ? int.Parse(txtC_KHOILUONG.Text) : 0;
                CUOCCHINH = (txtC_GIACUOC.Text == "") ? 0 : decimal.Parse(txtC_GIACUOC.Text);
                GIADOITAC = (txtC_GIADOITAC.Text == "") ? 0 : decimal.Parse(txtC_GIADOITAC.Text);
                ctcDataTable = new DataTable();
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
        string SelectSQL = "SELECT MAX(CAST(C_BILL AS BIGINT)) as MAXBILL FROM NHANGUI";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            if (oDataTable.Rows[0]["MAXBILL"] != DBNull.Value)
            {
                Int64 maxvalue = (Int64)oDataTable.Rows[0]["MAXBILL"];
                maxbill = String.Format("{0:00000000}", maxvalue + 1);
            }
        }
        return maxbill;
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
                if (!ValidateDeleteGroup(item["pk_id"].Text))
                {
                    SetMessage("Không thể xóa nhận gửi \"" + item["c_name"].Text + "\" do có tham chiếu dữ liệu khác.");
                    RadGridNHANGUIQT.Rebind();
                }
            }
        }
        else if (e.CommandName == RadGrid.PerformInsertCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;            
        }
        else if (e.CommandName == RadGrid.UpdateCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;          
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
        C_KHOILUONG = 0;
        PPXD = 0;
        CUOCCHINH = 0;
        FK_DOITAC = "";
        GIADOITAC = 0;
        ctcDataTable = new DataTable();
        ctcDataTable1 = new DataTable();
        C_KHOILUONGLK = 0;
        GIACUOCLK = 0;
        Alarm = "";
    }
}