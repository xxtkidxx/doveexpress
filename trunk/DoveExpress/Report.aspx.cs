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
            if (strtype == "INBILLFULL") //In bill full
            {
                InBillFull();
            }
        }  
    }
    //In bill full
    protected void InBillFull()
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
                reportSource.Parameters.Add("C_KHAC", oDataTable.Rows[0]["C_KHAC"] != DBNull.Value ? oDataTable.Rows[0]["C_KHAC"].ToString() : "");        
                reportSource.Parameters.Add("C_TIENHANG", oDataTable.Rows[0]["C_TIENHANG"] != DBNull.Value ? oDataTable.Rows[0]["C_TIENHANG"].ToString() : "");
                reportSource.Parameters.Add("C_VAT", oDataTable.Rows[0]["C_VAT"] != DBNull.Value ? oDataTable.Rows[0]["C_VAT"].ToString() : "");
                reportSource.Parameters.Add("C_TIENHANGVAT", oDataTable.Rows[0]["C_TIENHANGVAT"] != DBNull.Value ? oDataTable.Rows[0]["C_TIENHANGVAT"].ToString() : "");                
            }
            
        }
    }
}