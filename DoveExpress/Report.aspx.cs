using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;
using System.Globalization;
using iTextSharp.text.pdf;
using iTextSharp.text;
using System.IO;
using Microsoft.Reporting.WebForms;
using System.Drawing.Printing;
using Telerik.Reporting;
using ReportLib.Bill;

public partial class Report : System.Web.UI.Page
{    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!ITCLIB.Security.Security.CanPrintModule("REPORT"))
        {
            //ITCLIB.Security.Security.ReturnUrl();
        }
        if (Request.QueryString["TYPE"] != null)
        {
            //crvReport.ToolPanelView = CrystalDecisions.Web.ToolPanelViewType.None;
            string strtype = Request.QueryString["TYPE"].ToString().Trim();
            if (strtype == "INBILL") //In bill full
            {
                InBill();
            }
            else if (strtype == "INBILLQT")
            {
                InBillQT();
            }
        }  
    }
    //In bill full
    protected void InBill()
    {
        string SQLSELECT = String.Format("SELECT NHANGUI.*  FROM NHANGUI WHERE NHANGUI.PK_ID = {0}", Request.QueryString["ID"]);
        ITCLIB.Admin.SQL QR = new ITCLIB.Admin.SQL();
        DataTable oDataTable = QR.query_data(SQLSELECT);
        if (oDataTable.Rows.Count > 0)
        {
            //Telerik.Reporting.ReportParameter C_BILL = new Telerik.Reporting.ReportParameter("C_BILL", Telerik.Reporting.ReportParameterType.String, oDataTable.Rows[0]["C_BILL"] != DBNull.Value ? oDataTable.Rows[0]["C_BILL"].ToString() : "");
           
            if (!IsPostBack)
            {
                InstanceReportSource reportSource = new InstanceReportSource();
                reportSource.ReportDocument = new Bill();              
                this.ReportViewer1.ReportSource = reportSource;
                reportSource.Parameters.Add("C_BILL", oDataTable.Rows[0]["C_BILL"] != DBNull.Value ? oDataTable.Rows[0]["C_BILL"].ToString() : "");
                reportSource.Parameters.Add("C_TENKH", oDataTable.Rows[0]["C_TENKH"] != DBNull.Value ? oDataTable.Rows[0]["C_TENKH"].ToString() : "");
                reportSource.Parameters.Add("C_TELGUI", oDataTable.Rows[0]["C_TELGUI"] != DBNull.Value ? oDataTable.Rows[0]["C_TELGUI"].ToString() : "");
                reportSource.Parameters.Add("C_NGUOINHAN", oDataTable.Rows[0]["C_NGUOINHAN"] != DBNull.Value ? oDataTable.Rows[0]["C_NGUOINHAN"].ToString() : "");
                reportSource.Parameters.Add("C_DIACHINHAN", oDataTable.Rows[0]["C_DIACHINHAN"] != DBNull.Value ? oDataTable.Rows[0]["C_DIACHINHAN"].ToString() : "");
                reportSource.Parameters.Add("C_TELNHAN", oDataTable.Rows[0]["C_TELNHAN"] != DBNull.Value ? oDataTable.Rows[0]["C_TELNHAN"].ToString() : "");
                reportSource.Parameters.Add("C_NOIDUNG", oDataTable.Rows[0]["C_NOIDUNG"] != DBNull.Value ? oDataTable.Rows[0]["C_NOIDUNG"].ToString() : "");
                reportSource.Parameters.Add("C_KHOILUONG", oDataTable.Rows[0]["C_KHOILUONG"] != DBNull.Value ? oDataTable.Rows[0]["C_KHOILUONG"].ToString() : "");
                reportSource.Parameters.Add("C_GIACUOC", oDataTable.Rows[0]["C_GIACUOC"] != DBNull.Value ? oDataTable.Rows[0]["C_GIACUOC"].ToString() : "");
                reportSource.Parameters.Add("C_DONGGOI", oDataTable.Rows[0]["C_DONGGOI"] != DBNull.Value ? oDataTable.Rows[0]["C_DONGGOI"].ToString() : "");
                reportSource.Parameters.Add("C_KHAIGIA", oDataTable.Rows[0]["C_KHAIGIA"] != DBNull.Value ? oDataTable.Rows[0]["C_KHAIGIA"].ToString() : "");
                reportSource.Parameters.Add("C_COD", oDataTable.Rows[0]["C_COD"] != DBNull.Value ? oDataTable.Rows[0]["C_COD"].ToString() : "");
                reportSource.Parameters.Add("C_BAOPHAT", oDataTable.Rows[0]["C_BAOPHAT"] != DBNull.Value ? oDataTable.Rows[0]["C_BAOPHAT"].ToString() : "");
                reportSource.Parameters.Add("C_HENGIO", oDataTable.Rows[0]["C_HENGIO"] != DBNull.Value ? oDataTable.Rows[0]["C_HENGIO"].ToString() : "");        
                reportSource.Parameters.Add("C_TIENHANG", oDataTable.Rows[0]["C_TIENHANG"] != DBNull.Value ? oDataTable.Rows[0]["C_TIENHANG"].ToString() : "");
                reportSource.Parameters.Add("C_VAT", oDataTable.Rows[0]["C_VAT"] != DBNull.Value ? oDataTable.Rows[0]["C_VAT"].ToString() : "");
                reportSource.Parameters.Add("C_TIENHANGVAT", oDataTable.Rows[0]["C_TIENHANGVAT"] != DBNull.Value ? oDataTable.Rows[0]["C_TIENHANGVAT"].ToString() : "");
                reportSource.Parameters.Add("DATHU", oDataTable.Rows[0]["C_DATHU"] != DBNull.Value ? oDataTable.Rows[0]["C_DATHU"].ToString() : "");
                reportSource.Parameters.Add("CONLAI", oDataTable.Rows[0]["C_TIENHANGVAT"] != DBNull.Value && oDataTable.Rows[0]["C_DATHU"] != DBNull.Value ? (double.Parse(oDataTable.Rows[0]["C_TIENHANGVAT"].ToString()) - double.Parse(oDataTable.Rows[0]["C_DATHU"].ToString())).ToString() : "");
                reportSource.Parameters.Add("TINHTHANHGUI", Session["VUNGLAMVIEC"]);
                reportSource.Parameters.Add("QUANHUYENNHAN", oDataTable.Rows[0]["FK_QUANHUYEN"] != DBNull.Value ? ITCLIB.Admin.cFunction.LoadQuanHuyenName(oDataTable.Rows[0]["FK_QUANHUYEN"].ToString()) : "");
                reportSource.Parameters.Add("TINHTHANHNHAN", oDataTable.Rows[0]["FK_QUANHUYEN"] != DBNull.Value ? ITCLIB.Admin.cFunction.LoadFieldfromTable(ITCLIB.Admin.cFunction.LoadIDTinhThanhCode(oDataTable.Rows[0]["FK_QUANHUYEN"].ToString()), "C_NAME", "DMTINHTHANH") : "");
                string DICHVUCODE = ITCLIB.Admin.cFunction.LoadFieldfromTable(oDataTable.Rows[0]["FK_MASANPHAM"].ToString(), "C_CODE", "DMMASANPHAM");
                if (DICHVUCODE == "CPN")
                {
                    reportSource.Parameters.Add("CPN", true);
                    reportSource.Parameters.Add("DUONGBO", false);
                    reportSource.Parameters.Add("QUOCTE", false);
                    reportSource.Parameters.Add("HOATOC", false);
                    reportSource.Parameters.Add("DVKHAC", false);
                }
                else if (DICHVUCODE == "DB")
                {
                    reportSource.Parameters.Add("CPN", false);
                    reportSource.Parameters.Add("DUONGBO", true);
                    reportSource.Parameters.Add("QUOCTE", false);
                    reportSource.Parameters.Add("HOATOC", false);
                    reportSource.Parameters.Add("DVKHAC", false);
                }
                else if (DICHVUCODE == "QT")
                {
                    reportSource.Parameters.Add("CPN", false);
                    reportSource.Parameters.Add("DUONGBO", false);
                    reportSource.Parameters.Add("QUOCTE", true);
                    reportSource.Parameters.Add("HOATOC", false);
                    reportSource.Parameters.Add("DVKHAC", false);
                }
                else if (DICHVUCODE == "HT")
                {
                    reportSource.Parameters.Add("CPN", false);
                    reportSource.Parameters.Add("DUONGBO", false);
                    reportSource.Parameters.Add("QUOCTE", false);
                    reportSource.Parameters.Add("HOATOC", true);
                    reportSource.Parameters.Add("DVKHAC", false);
                }
                else
                {
                    reportSource.Parameters.Add("CPN", false);
                    reportSource.Parameters.Add("DUONGBO", false);
                    reportSource.Parameters.Add("QUOCTE", false);
                    reportSource.Parameters.Add("HOATOC", false);
                    reportSource.Parameters.Add("DVKHAC", false);
                }
                reportSource.Parameters.Add("NHANVIENNHAN", oDataTable.Rows[0]["FK_NHANVIENNHAN"] != DBNull.Value ? ITCLIB.Admin.cFunction.LoadUserName(oDataTable.Rows[0]["FK_NHANVIENNHAN"].ToString()) : "");
                reportSource.Parameters.Add("NHANVIENPHAT", oDataTable.Rows[0]["FK_NHANVIENPHAT"] != DBNull.Value ? ITCLIB.Admin.cFunction.LoadUserName(oDataTable.Rows[0]["FK_NHANVIENPHAT"].ToString()) : "");
                reportSource.Parameters.Add("C_NGAYGIOPHAT", oDataTable.Rows[0]["C_NGAYGIOPHAT"] != DBNull.Value ? String.Format("{0:dd/MM/yyyy hh:mm:ss tt}", DateTime.Parse(oDataTable.Rows[0]["C_NGAYGIOPHAT"].ToString())) : "");

            }
            
        }
    }
    protected void InBillQT()
    {
        string SQLSELECT = String.Format("SELECT NHANGUI.*  FROM NHANGUI WHERE NHANGUI.PK_ID = {0}", Request.QueryString["ID"]);
        ITCLIB.Admin.SQL QR = new ITCLIB.Admin.SQL();
        DataTable oDataTable = QR.query_data(SQLSELECT);
        if (oDataTable.Rows.Count > 0)
        {
            //Telerik.Reporting.ReportParameter C_BILL = new Telerik.Reporting.ReportParameter("C_BILL", Telerik.Reporting.ReportParameterType.String, oDataTable.Rows[0]["C_BILL"] != DBNull.Value ? oDataTable.Rows[0]["C_BILL"].ToString() : "");

            if (!IsPostBack)
            {
                InstanceReportSource reportSource = new InstanceReportSource();
                reportSource.ReportDocument = new BillQT();
                this.ReportViewer1.ReportSource = reportSource;
                reportSource.Parameters.Add("C_BILL", oDataTable.Rows[0]["C_BILL"] != DBNull.Value ? oDataTable.Rows[0]["C_BILL"].ToString() : "");
                reportSource.Parameters.Add("C_TENKH", oDataTable.Rows[0]["C_TENKH"] != DBNull.Value ? oDataTable.Rows[0]["C_TENKH"].ToString() : "");
                reportSource.Parameters.Add("C_TELGUI", oDataTable.Rows[0]["C_TELGUI"] != DBNull.Value ? oDataTable.Rows[0]["C_TELGUI"].ToString() : "");
                reportSource.Parameters.Add("C_NGUOINHAN", oDataTable.Rows[0]["C_NGUOINHAN"] != DBNull.Value ? oDataTable.Rows[0]["C_NGUOINHAN"].ToString() : "");
                reportSource.Parameters.Add("C_DIACHINHAN", oDataTable.Rows[0]["C_DIACHINHAN"] != DBNull.Value ? oDataTable.Rows[0]["C_DIACHINHAN"].ToString() : "");
                reportSource.Parameters.Add("C_TELNHAN", oDataTable.Rows[0]["C_TELNHAN"] != DBNull.Value ? oDataTable.Rows[0]["C_TELNHAN"].ToString() : "");
                reportSource.Parameters.Add("C_NOIDUNG", oDataTable.Rows[0]["C_NOIDUNG"] != DBNull.Value ? oDataTable.Rows[0]["C_NOIDUNG"].ToString() : "");
                reportSource.Parameters.Add("C_KHOILUONG", oDataTable.Rows[0]["C_KHOILUONG"] != DBNull.Value ? oDataTable.Rows[0]["C_KHOILUONG"].ToString() : "");
                reportSource.Parameters.Add("C_GIACUOC", oDataTable.Rows[0]["C_GIACUOC"] != DBNull.Value ? oDataTable.Rows[0]["C_GIACUOC"].ToString() : "");
                reportSource.Parameters.Add("C_DONGGOI", oDataTable.Rows[0]["C_DONGGOI"] != DBNull.Value ? oDataTable.Rows[0]["C_DONGGOI"].ToString() : "");
                reportSource.Parameters.Add("C_KHAIGIA", oDataTable.Rows[0]["C_KHAIGIA"] != DBNull.Value ? oDataTable.Rows[0]["C_KHAIGIA"].ToString() : "");
                reportSource.Parameters.Add("C_COD", oDataTable.Rows[0]["C_COD"] != DBNull.Value ? oDataTable.Rows[0]["C_COD"].ToString() : "");
                reportSource.Parameters.Add("C_BAOPHAT", oDataTable.Rows[0]["C_BAOPHAT"] != DBNull.Value ? oDataTable.Rows[0]["C_BAOPHAT"].ToString() : "");
                reportSource.Parameters.Add("C_HENGIO", oDataTable.Rows[0]["C_HENGIO"] != DBNull.Value ? oDataTable.Rows[0]["C_HENGIO"].ToString() : "");   
                reportSource.Parameters.Add("C_TIENHANG", oDataTable.Rows[0]["C_TIENHANG"] != DBNull.Value ? oDataTable.Rows[0]["C_TIENHANG"].ToString() : "");
                reportSource.Parameters.Add("C_VAT", oDataTable.Rows[0]["C_VAT"] != DBNull.Value ? oDataTable.Rows[0]["C_VAT"].ToString() : "");
                reportSource.Parameters.Add("C_TIENHANGVAT", oDataTable.Rows[0]["C_TIENHANGVAT"] != DBNull.Value ? oDataTable.Rows[0]["C_TIENHANGVAT"].ToString() : "");
                reportSource.Parameters.Add("DATHU", oDataTable.Rows[0]["C_DATHU"] != DBNull.Value ? oDataTable.Rows[0]["C_DATHU"].ToString() : "");
                reportSource.Parameters.Add("CONLAI", oDataTable.Rows[0]["C_TIENHANGVAT"] != DBNull.Value && oDataTable.Rows[0]["C_DATHU"] != DBNull.Value ? (double.Parse(oDataTable.Rows[0]["C_TIENHANGVAT"].ToString()) - double.Parse(oDataTable.Rows[0]["C_DATHU"].ToString())).ToString() : "");
                reportSource.Parameters.Add("TINHTHANHGUI", Session["VUNGLAMVIEC"]);
                reportSource.Parameters.Add("QUOCGIANHAN", oDataTable.Rows[0]["FK_QUOCGIA"] != DBNull.Value ? ITCLIB.Admin.cFunction.LoadQuocGiaName(oDataTable.Rows[0]["FK_QUOCGIA"].ToString()) : "");
                string DICHVUCODE = ITCLIB.Admin.cFunction.LoadFieldfromTable(oDataTable.Rows[0]["FK_MASANPHAM"].ToString(), "C_CODE", "DMMASANPHAM");
                if (DICHVUCODE == "CPN")
                {
                    reportSource.Parameters.Add("CPN", true);
                    reportSource.Parameters.Add("DUONGBO", false);
                    reportSource.Parameters.Add("QUOCTE", false);
                    reportSource.Parameters.Add("HOATOC", false);
                    reportSource.Parameters.Add("DVKHAC", false);
                }
                else if (DICHVUCODE == "DB")
                {
                    reportSource.Parameters.Add("CPN", false);
                    reportSource.Parameters.Add("DUONGBO", true);
                    reportSource.Parameters.Add("QUOCTE", false);
                    reportSource.Parameters.Add("HOATOC", false);
                    reportSource.Parameters.Add("DVKHAC", false);
                }
                else if (DICHVUCODE == "QT")
                {
                    reportSource.Parameters.Add("CPN", false);
                    reportSource.Parameters.Add("DUONGBO", false);
                    reportSource.Parameters.Add("QUOCTE", true);
                    reportSource.Parameters.Add("HOATOC", false);
                    reportSource.Parameters.Add("DVKHAC", false);
                }
                else if (DICHVUCODE == "HT")
                {
                    reportSource.Parameters.Add("CPN", false);
                    reportSource.Parameters.Add("DUONGBO", false);
                    reportSource.Parameters.Add("QUOCTE", false);
                    reportSource.Parameters.Add("HOATOC", true);
                    reportSource.Parameters.Add("DVKHAC", false);
                }
                else
                {
                    reportSource.Parameters.Add("CPN", false);
                    reportSource.Parameters.Add("DUONGBO", false);
                    reportSource.Parameters.Add("QUOCTE", false);
                    reportSource.Parameters.Add("HOATOC", false);
                    reportSource.Parameters.Add("DVKHAC", false);
                }
                reportSource.Parameters.Add("NHANVIENNHAN", oDataTable.Rows[0]["FK_NHANVIENNHAN"] != DBNull.Value ? ITCLIB.Admin.cFunction.LoadUserName(oDataTable.Rows[0]["FK_NHANVIENNHAN"].ToString()) : "");
                reportSource.Parameters.Add("NHANVIENPHAT", oDataTable.Rows[0]["FK_NHANVIENPHAT"] != DBNull.Value ? ITCLIB.Admin.cFunction.LoadUserName(oDataTable.Rows[0]["FK_NHANVIENPHAT"].ToString()) : "");
                reportSource.Parameters.Add("C_NGAYGIOPHAT", oDataTable.Rows[0]["C_NGAYGIOPHAT"] != DBNull.Value ? String.Format("{0:dd/MM/yyyy hh:mm:ss tt}", DateTime.Parse(oDataTable.Rows[0]["C_NGAYGIOPHAT"].ToString())) : "");

            }

        }
    }
}