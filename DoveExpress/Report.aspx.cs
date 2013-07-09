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

public partial class Report : System.Web.UI.Page
{
    //http://forums.asp.net/t/1796745.aspx/1
    //www.codeproject.com/Tips/376300/Custom-Print-Functionality-for-Microsoft-Report-Vi?msg=4479672#xx4479672xx
    ITCLIB.Admin.SQL ac = new ITCLIB.Admin.SQL();
    //ReportDocument rd = new ReportDocument();
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
    protected void Report_Unload(object sender, EventArgs e)
    {
        //rd.Close();
        //rd.Dispose();
    }
    //In bill full
    protected void InBillFull()
    {
        //rd.Load(Server.MapPath("Report\\INBILLFULL.rpt"));
        /*string sqldonvi = String.Format("SELECT DISTINCT DOANHNGHIEP_NHADAUTU.PK_ID, DOANHNGHIEP_NHADAUTU.FK_PARENT, DOANHNGHIEP_NHADAUTU.C_TYPE, DOANHNGHIEP_NHADAUTU.C_LOAIHINHDN, DOANHNGHIEP_NHADAUTU.C_MASOTHUE, DOANHNGHIEP_NHADAUTU.C_NAME, DOANHNGHIEP_NHADAUTU.C_ENAME, DOANHNGHIEP_NHADAUTU.C_TNAME, DOANHNGHIEP_NHADAUTU.C_ADRESS, DOANHNGHIEP_NHADAUTU.C_SOGIAYPHEP, DOANHNGHIEP_NHADAUTU.C_DIENTHOAI, DOANHNGHIEP_NHADAUTU.C_FAX, DOANHNGHIEP_NHADAUTU.C_SOGPKD, DOANHNGHIEP_NHADAUTU.C_DNEMAIL, DOANHNGHIEP_NHADAUTU.C_DNWEBSITE, DUANCPDT.C_CNDT, DUANCPDT.C_NGAYCAP, DMHTDAUTU.C_NAME AS NAMEHINHTHUC, DMLINHVUCDAUTU.C_NAME AS NAMELINHVUC, DMVITRIDUAN.C_NAME AS NAMEVITRI FROM DUANCPDT_VALUE INNER JOIN DUANCPDT ON DUANCPDT_VALUE.FK_DUANCPDT = DUANCPDT.PK_ID INNER JOIN DOANHNGHIEP_NHADAUTU ON DUANCPDT_VALUE.FK_DONVI = DOANHNGHIEP_NHADAUTU.PK_ID LEFT OUTER JOIN DMHTDAUTU ON DUANCPDT.C_HINHTHUCDAUTU = DMHTDAUTU.PK_ID LEFT OUTER JOIN DMLINHVUCDAUTU ON DUANCPDT.C_LINHVUCHOATDONG = DMLINHVUCDAUTU.PK_ID LEFT OUTER JOIN DMVITRIDUAN ON DUANCPDT.C_VITRI = DMVITRIDUAN.PK_ID WHERE (DUANCPDT_VALUE.FK_DUANCPDT = {0}) AND (DOANHNGHIEP_NHADAUTU.PK_ID = {1})", Request.QueryString["IDDACPDT"], Request.QueryString["DONVI"]);
        DataTable odatadonvi = ac.query_data(sqldonvi);
        if (odatadonvi.Rows.Count > 0)
        {
            rd.SetParameterValue("C_CODE", odatadonvi.Rows[0]["C_CNDT"] != DBNull.Value ? odatadonvi.Rows[0]["C_CNDT"].ToString() : "");
            rd.SetParameterValue("C_NAME", odatadonvi.Rows[0]["C_NAME"] != DBNull.Value ? odatadonvi.Rows[0]["C_NAME"].ToString() : "");
            rd.SetParameterValue("C_TNAME", odatadonvi.Rows[0]["C_TNAME"] != DBNull.Value ? odatadonvi.Rows[0]["C_TNAME"].ToString() : "");
            rd.SetParameterValue("C_ENAME", odatadonvi.Rows[0]["C_ENAME"] != DBNull.Value ? odatadonvi.Rows[0]["C_ENAME"].ToString() : "");
            rd.SetParameterValue("C_ADDRESS", odatadonvi.Rows[0]["C_ADRESS"] != DBNull.Value ? odatadonvi.Rows[0]["C_ADRESS"].ToString() : "");
            rd.SetParameterValue("C_DIENTHOAI", odatadonvi.Rows[0]["C_DIENTHOAI"] != DBNull.Value ? odatadonvi.Rows[0]["C_DIENTHOAI"].ToString() : "");
            rd.SetParameterValue("C_FAX", odatadonvi.Rows[0]["C_FAX"] != DBNull.Value ? odatadonvi.Rows[0]["C_FAX"].ToString() : "");
            rd.SetParameterValue("C_EMAIL", odatadonvi.Rows[0]["C_DNEMAIL"] != DBNull.Value ? odatadonvi.Rows[0]["C_DNEMAIL"].ToString() : "");
            rd.SetParameterValue("C_WEBSITE", odatadonvi.Rows[0]["C_DNWEBSITE"] != DBNull.Value ? odatadonvi.Rows[0]["C_DNWEBSITE"].ToString() : "");
            rd.SetParameterValue("C_SOCNDT", odatadonvi.Rows[0]["C_CNDT"] != DBNull.Value ? odatadonvi.Rows[0]["C_CNDT"].ToString() : "");
            rd.SetParameterValue("C_MASOTHUE", odatadonvi.Rows[0]["C_MASOTHUE"] != DBNull.Value ? odatadonvi.Rows[0]["C_MASOTHUE"].ToString() : "");
            rd.SetParameterValue("NAMEHINHTHUC", odatadonvi.Rows[0]["NAMEHINHTHUC"] != DBNull.Value ? odatadonvi.Rows[0]["NAMEHINHTHUC"].ToString() : "");
            rd.SetParameterValue("NAMELINHVUC", odatadonvi.Rows[0]["NAMELINHVUC"] != DBNull.Value ? odatadonvi.Rows[0]["NAMELINHVUC"].ToString() : "");
            rd.SetParameterValue("NAMEVITRI", odatadonvi.Rows[0]["NAMEVITRI"] != DBNull.Value ? odatadonvi.Rows[0]["NAMEVITRI"].ToString() : "");
            rd.SetParameterValue("TONGTSCD", odatadonvi.Rows[0]["PK_ID"] != DBNull.Value ? odatadonvi.Rows[0]["PK_ID"].ToString() : "");
            rd.SetParameterValue("TONGTSLD", odatadonvi.Rows[0]["PK_ID"] != DBNull.Value ? odatadonvi.Rows[0]["PK_ID"].ToString() : "");
        }
        else
        {
            foreach (Parameter para in rd.ParameterFields)
            {
                rd.SetParameterValue(para.Name, "");
            }
        }*/
        //crvReport.ReportSource = rd;
        //crvReport.DataBind();
    }
    protected void btnPrint_Click(object sender, EventArgs e)
    {
        Warning[] warnings;
        string[] streamids;
        string mimeType;
        string encoding;
        string extension;

        byte[] bytes = ReportViewer1.LocalReport.Render("PDF", null, out mimeType,
                       out encoding, out extension, out streamids, out warnings);

        FileStream fs = new FileStream(HttpContext.Current.Server.MapPath("output.pdf"),
        FileMode.Create);
        fs.Write(bytes, 0, bytes.Length);
        fs.Close();

        //Open existing PDF
        Document document = new Document(PageSize.LETTER);
        PdfReader reader = new PdfReader(HttpContext.Current.Server.MapPath("output.pdf"));
        //Getting a instance of new PDF writer
        PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(
           HttpContext.Current.Server.MapPath("Print.pdf"), FileMode.Create));
        document.Open();
        PdfContentByte cb = writer.DirectContent;

        int i = 0;
        int p = 0;
        int n = reader.NumberOfPages;
        Rectangle psize = reader.GetPageSize(1);

        float width = psize.Width;
        float height = psize.Height;

        //Add Page to new document
        while (i < n)
        {
            document.NewPage();
            p++;
            i++;

            PdfImportedPage page1 = writer.GetImportedPage(reader, i);
            cb.AddTemplate(page1, 0, 0);
        }
        //Attach javascript to the document
        PdfAction jAction = PdfAction.JavaScript("this.print(true);\r", writer);
        writer.AddJavaScript(jAction);
        document.Close();

        //Attach pdf to the iframe
        frmPrint.Attributes["src"] = "Print.pdf";
    }
}