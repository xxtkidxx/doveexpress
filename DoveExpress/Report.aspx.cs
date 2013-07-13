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
            /*ReportViewer1.ProcessingMode = ProcessingMode.Local;
            LocalReport localReport = ReportViewer1.LocalReport;
            ReportViewer1.LocalReport.ReportPath = "Report/ReportBill.rdlc";
            ReportParameter C_BILL = new ReportParameter("C_BILL", oDataTable.Rows[0]["C_BILL"] != DBNull.Value ? oDataTable.Rows[0]["C_BILL"].ToString() : "");
            if (!IsPostBack)
            {
                ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { C_BILL });
            }*/
        }
        if (!IsPostBack)
        {
            InstanceReportSource reportSource = new InstanceReportSource();
            reportSource.ReportDocument = new Bill();
            this.ReportViewer1.ReportSource = reportSource;
        }
    }
}