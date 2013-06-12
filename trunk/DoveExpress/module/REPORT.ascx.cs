using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using CrystalDecisions.CrystalReports.Engine;

public partial class Reports_Report_CPDT : System.Web.UI.UserControl
{
    ITCLIB.Admin.SQL ac = new ITCLIB.Admin.SQL();
    ReportDocument rd = new ReportDocument();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!ITCLIB.Security.Security.CanPrintModule("REPORT"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        /*if (Request.QueryString["TYPE"] != null)
        {
            crvReport.ToolPanelView = CrystalDecisions.Web.ToolPanelViewType.None;
            string strtype = Request.QueryString["TYPE"].ToString().Trim();
            if (strtype == "DONVI")//Phục lục 1
                getbaocao_Donvi();
            else if (strtype == "LAODONG")//Phục lục 2
                getbaocao_Laodong();
            else if (strtype == "THUNHAP")//Phục lục 3
                getbaocao_Thunhap();
            else if (strtype == "HDDUAN") //Phục lục 4 HĐ dự án
                getbaocao_hdduan();
            else if (strtype == "GOPVON") //Phục lục 5 Góp vốn
                getbaocao_Gopvon();
            else if (strtype == "CNTT" || strtype == "BVMT" || strtype == "TAINAN") //Phục lục 7
                getbaocao_cntt_bvmt_tnld();
            else if (strtype == "DAUTU" || strtype == "DAOTAO") //Phục lục 6
                getbaocao_dautu_daotao();
            else if (strtype == "XAYDUNG") //Phục lục 8
                getbaocao_Xaydung();
            else if (strtype == "LUUTRU") //Phục lục 9
                getbaocao_Luutru();
            else if (strtype == "NHAHANG" || strtype == "DICHVU") //Phục lục 10
                getbaocao_Nhahang_dichvu();          
         
        }*/
    }

    protected string getName(object name, string level, object header)
    {
        if (level == "1")
        {
            return String.Format("{0} {1}", header.ToString().Replace("&nbsp;", " "), name);
        }
        return String.Format("{0} {1}", header.ToString().Replace("&nbsp;", " "), name);
    }

    protected void Report_Unload(object sender, EventArgs e)
    {
        rd.Close();
        rd.Dispose();
    }
   /* //Phụ lục 1: Thông tin đơn vị báo cáo
    protected void getbaocao_Donvi()
    {
        rd.Load(Server.MapPath("Reports\\rp_duancpdt_phuluc1.rpt"));
        string sqldonvi = String.Format("SELECT DISTINCT DOANHNGHIEP_NHADAUTU.PK_ID, DOANHNGHIEP_NHADAUTU.FK_PARENT, DOANHNGHIEP_NHADAUTU.C_TYPE, DOANHNGHIEP_NHADAUTU.C_LOAIHINHDN, DOANHNGHIEP_NHADAUTU.C_MASOTHUE, DOANHNGHIEP_NHADAUTU.C_NAME, DOANHNGHIEP_NHADAUTU.C_ENAME, DOANHNGHIEP_NHADAUTU.C_TNAME, DOANHNGHIEP_NHADAUTU.C_ADRESS, DOANHNGHIEP_NHADAUTU.C_SOGIAYPHEP, DOANHNGHIEP_NHADAUTU.C_DIENTHOAI, DOANHNGHIEP_NHADAUTU.C_FAX, DOANHNGHIEP_NHADAUTU.C_SOGPKD, DOANHNGHIEP_NHADAUTU.C_DNEMAIL, DOANHNGHIEP_NHADAUTU.C_DNWEBSITE, DUANCPDT.C_CNDT, DUANCPDT.C_NGAYCAP, DMHTDAUTU.C_NAME AS NAMEHINHTHUC, DMLINHVUCDAUTU.C_NAME AS NAMELINHVUC, DMVITRIDUAN.C_NAME AS NAMEVITRI FROM DUANCPDT_VALUE INNER JOIN DUANCPDT ON DUANCPDT_VALUE.FK_DUANCPDT = DUANCPDT.PK_ID INNER JOIN DOANHNGHIEP_NHADAUTU ON DUANCPDT_VALUE.FK_DONVI = DOANHNGHIEP_NHADAUTU.PK_ID LEFT OUTER JOIN DMHTDAUTU ON DUANCPDT.C_HINHTHUCDAUTU = DMHTDAUTU.PK_ID LEFT OUTER JOIN DMLINHVUCDAUTU ON DUANCPDT.C_LINHVUCHOATDONG = DMLINHVUCDAUTU.PK_ID LEFT OUTER JOIN DMVITRIDUAN ON DUANCPDT.C_VITRI = DMVITRIDUAN.PK_ID WHERE (DUANCPDT_VALUE.FK_DUANCPDT = {0}) AND (DOANHNGHIEP_NHADAUTU.PK_ID = {1})", Request.QueryString["IDDACPDT"], Request.QueryString["DONVI"]);
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
        }
        crvReport.ReportSource = rd;
        crvReport.DataBind();
    }
    //Phụ lục 2: Thông tin lao động
    protected void getbaocao_Laodong()
    {
        string sqlselect = String.Format("SELECT DUANCPDT_TIEUCHI.C_CODE, DUANCPDT_TIEUCHI.C_NAME, DUANCPDT_TIEUCHI.C_UNIT, DUANCPDT_VALUE.VALUE1, DUANCPDT_VALUE.VALUE2, DUANCPDT_VALUE.VALUE3, DUANCPDT_VALUE.VALUE4," +
           " DUANCPDT_VALUE.VALUE5, DUANCPDT_VALUE.VALUE6, DUANCPDT_VALUE.VALUE7, DUANCPDT_VALUE.VALUE8, DUANCPDT_VALUE.VALUE9, DUANCPDT_VALUE.VALUE10, DUANCPDT_VALUE.VALUE11" +
           " ,DUANCPDT_TIEUCHI.C_LEVEL, DUANCPDT_TIEUCHI.C_HEADER, DUANCPDT_VALUE.FK_DONVI, DUANCPDT_VALUE.C_MONTH, DUANCPDT_VALUE.C_YEAR" +
           " FROM DUANCPDT_TIEUCHI INNER JOIN DUANCPDT_VALUE ON DUANCPDT_TIEUCHI.PK_ID = DUANCPDT_VALUE.FK_TIEUCHI ");
        sqlselect += String.Format(" WHERE (DUANCPDT_VALUE.FK_DUANCPDT = {0}) AND DUANCPDT_VALUE.C_MONTH ={1} AND C_YEAR ={2} AND (DUANCPDT_TIEUCHI.C_TYPE = '{3}') AND (DUANCPDT_VALUE.FK_DONVI ={4}) order by DUANCPDT_TIEUCHI.C_ORDER", Request.QueryString["IDDACPDT"], Request.QueryString["M"], Request.QueryString["Y"], "LAODONG", Request.QueryString["DONVI"]);
        DataSet_rp_CPDT ds = new DataSet_rp_CPDT();
        SqlDataAdapter adt = ac.getAdt(sqlselect);
        //Lấy dữ liệu tại bảng DACPDT_REPORT
        adt.Fill(ds, "DACPDT_REPORT");
        DataTable odata = ds.Tables["DACPDT_REPORT"];
        foreach (DataRow rs in odata.Rows)
        {
            rs["C_NAME"] = getName(rs["C_NAME"], rs["C_LEVEL"].ToString(), rs["C_HEADER"]);
        }
        rd.Load(Server.MapPath("Reports\\rp_duancpdt_phuluc2.rpt"));
        rd.SetDataSource(ds);
        rd.SetParameterValue("DONVI", " " + ITCLIB.Admin.cFunction.getname(odata.Rows[0]["FK_DONVI"].ToString(), "DOANHNGHIEP_NHADAUTU"));
        rd.SetParameterValue("TINHDEN", "Tháng " + odata.Rows[0]["C_MONTH"].ToString() + "/" + odata.Rows[0]["C_YEAR"].ToString());
        BaocaoDACPDT.ReportSource = rd;
        BaocaoDACPDT.DataBind();
    }
    //Phụ lục 3: Thu nhập lao động
    protected void getbaocao_Thunhap()
    {
        string sqlselect = String.Format("SELECT DUANCPDT_TIEUCHI.C_CODE, DUANCPDT_TIEUCHI.C_NAME, DUANCPDT_TIEUCHI.C_UNIT, DUANCPDT_VALUE.VALUE1, DUANCPDT_VALUE.VALUE2, DUANCPDT_VALUE.VALUE3, DUANCPDT_VALUE.VALUE4," +
          " DUANCPDT_VALUE.VALUE5, DUANCPDT_VALUE.VALUE6, DUANCPDT_VALUE.VALUE7, DUANCPDT_VALUE.VALUE8, DUANCPDT_VALUE.VALUE9, DUANCPDT_VALUE.VALUE10, DUANCPDT_VALUE.VALUE11" +
          " ,DUANCPDT_TIEUCHI.C_LEVEL, DUANCPDT_TIEUCHI.C_HEADER, DUANCPDT_VALUE.FK_DONVI, DUANCPDT_VALUE.C_MONTH, DUANCPDT_VALUE.C_YEAR" +
          " FROM DUANCPDT_TIEUCHI INNER JOIN DUANCPDT_VALUE ON DUANCPDT_TIEUCHI.PK_ID = DUANCPDT_VALUE.FK_TIEUCHI ");
        sqlselect += String.Format(" WHERE (DUANCPDT_VALUE.FK_DUANCPDT = {0}) AND DUANCPDT_VALUE.C_MONTH ={1} AND C_YEAR ={2} AND (DUANCPDT_TIEUCHI.C_TYPE = '{3}') AND (DUANCPDT_VALUE.FK_DONVI ={4}) order by DUANCPDT_TIEUCHI.C_ORDER", Request.QueryString["IDDACPDT"], Request.QueryString["M"], Request.QueryString["Y"], "THUNHAP", Request.QueryString["DONVI"]);
        DataSet_rp_CPDT ds = new DataSet_rp_CPDT();
        SqlDataAdapter adt = ac.getAdt(sqlselect);
        adt.Fill(ds, "THUNHAP_REPORT");
        DataTable odata = ds.Tables["THUNHAP_REPORT"];
        foreach (DataRow rs in odata.Rows)
        {
            rs["C_NAME"] = getName(rs["C_NAME"], rs["C_LEVEL"].ToString(), rs["C_HEADER"]);
        }
        rd.Load(Server.MapPath("Reports\\rp_duancpdt_phuluc3.rpt"));
        rd.SetDataSource(ds);
        rd.SetParameterValue("YEAR", odata.Rows[0]["C_YEAR"].ToString());
        BaocaoDACPDT.ReportSource = rd;
        BaocaoDACPDT.DataBind();
    }
    //Phụ lục 4: TÌnh hình hoạt động dự án
    protected void getbaocao_hdduan()
    {
        //Hoạt động dự án
        string sqlselecthdduan = String.Format("SELECT DUANCPDT_TIEUCHI.C_CODE, DUANCPDT_TIEUCHI.C_NAME, DUANCPDT_TIEUCHI.C_UNIT, " +
           " CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE1) AS VALUE1, CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE2) AS VALUE2, CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE3) AS VALUE3,  CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE4) AS VALUE4, DUANCPDT_VALUE.VALUE5, DUANCPDT_VALUE.VALUE6, DUANCPDT_VALUE.VALUE7, DUANCPDT_VALUE.VALUE8, DUANCPDT_VALUE.VALUE9, DUANCPDT_VALUE.VALUE10, DUANCPDT_VALUE.VALUE11" +
           " ,DUANCPDT_TIEUCHI.C_LEVEL, DUANCPDT_TIEUCHI.C_HEADER, DUANCPDT_VALUE.FK_DONVI, DUANCPDT_VALUE.C_MONTH, DUANCPDT_VALUE.C_YEAR" +
           " FROM DUANCPDT_TIEUCHI INNER JOIN DUANCPDT_VALUE ON DUANCPDT_TIEUCHI.PK_ID = DUANCPDT_VALUE.FK_TIEUCHI ");
        //Table1 
        string sqlselecthdduantb1 = sqlselecthdduan + String.Format(" WHERE (DUANCPDT_VALUE.FK_DUANCPDT = {0}) AND DUANCPDT_VALUE.C_MONTH ={1} AND C_YEAR ={2} AND (DUANCPDT_TIEUCHI.C_TYPE = '{3}') AND (DUANCPDT_VALUE.FK_DONVI ={4}) AND DUANCPDT_TIEUCHI.C_TABLE =1 AND DUANCPDT_TIEUCHI.pk_id <> 168 order by DUANCPDT_TIEUCHI.C_ORDER", Request.QueryString["IDDACPDT"], Request.QueryString["M"], Request.QueryString["Y"], "HDDUAN", Request.QueryString["DONVI"]);
        DataSet_rp_CPDT ds = new DataSet_rp_CPDT();
        SqlDataAdapter adt = ac.getAdt(sqlselecthdduantb1);
        adt.Fill(ds, "HDDUAN1_REPORT");
        DataTable odata = ds.Tables["HDDUAN1_REPORT"];
        foreach (DataRow rs in odata.Rows)
        {
            rs["C_NAME"] = getName(rs["C_NAME"], rs["C_LEVEL"].ToString(), rs["C_HEADER"]);
        }
        //table 2
        string sqlselecthdduantb2 = sqlselecthdduan + String.Format(" WHERE (DUANCPDT_VALUE.FK_DUANCPDT = {0}) AND DUANCPDT_VALUE.C_MONTH ={1} AND C_YEAR ={2} AND (DUANCPDT_TIEUCHI.C_TYPE = '{3}') AND (DUANCPDT_VALUE.FK_DONVI ={4}) AND DUANCPDT_TIEUCHI.C_TABLE =2 AND DUANCPDT_TIEUCHI.pk_id <> 183  order by DUANCPDT_TIEUCHI.C_ORDER", Request.QueryString["IDDACPDT"], Request.QueryString["M"], Request.QueryString["Y"], "HDDUAN", Request.QueryString["DONVI"]);
        SqlDataAdapter adttb2 = ac.getAdt(sqlselecthdduantb2);
        adttb2.Fill(ds, "HDDUAN2_REPORT");
        DataTable odatadichvu = ds.Tables["HDDUAN2_REPORT"];
        foreach (DataRow rs in odatadichvu.Rows)
        {
            rs["C_NAME"] = getName(rs["C_NAME"], rs["C_LEVEL"].ToString(), rs["C_HEADER"]);
        }

        rd.Load(Server.MapPath("Reports\\rp_duancpdt_phuluc4.rpt"));
        rd.SetDataSource(ds);
        BaocaoDACPDT.ReportSource = rd;
        BaocaoDACPDT.DataBind();
    }
    //Phụ lục 5: Tình hình góp vốn dự án
    protected void getbaocao_Gopvon()
    {
        //Góp vốn
        string sqlselectgopvon = String.Format("SELECT DUANCPDT_TIEUCHI.C_CODE, DUANCPDT_TIEUCHI.C_NAME, DUANCPDT_TIEUCHI.C_UNIT, " +
           " CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE1) AS VALUE1, CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE2) AS VALUE2, CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE3) AS VALUE3,  CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE4) AS VALUE4, DUANCPDT_VALUE.VALUE5, DUANCPDT_VALUE.VALUE6, DUANCPDT_VALUE.VALUE7, DUANCPDT_VALUE.VALUE8, DUANCPDT_VALUE.VALUE9, DUANCPDT_VALUE.VALUE10, DUANCPDT_VALUE.VALUE11" +
           " ,DUANCPDT_TIEUCHI.C_LEVEL, DUANCPDT_TIEUCHI.C_HEADER, DUANCPDT_VALUE.FK_DONVI, DUANCPDT_VALUE.C_MONTH, DUANCPDT_VALUE.C_YEAR" +
           " FROM DUANCPDT_TIEUCHI INNER JOIN DUANCPDT_VALUE ON DUANCPDT_TIEUCHI.PK_ID = DUANCPDT_VALUE.FK_TIEUCHI ");
        //Table1 
        string sqlselectgopvontb1 = sqlselectgopvon + String.Format(" WHERE (DUANCPDT_VALUE.FK_DUANCPDT = {0}) AND DUANCPDT_VALUE.C_MONTH ={1} AND C_YEAR ={2} AND (DUANCPDT_TIEUCHI.C_TYPE = '{3}') AND (DUANCPDT_VALUE.FK_DONVI ={4}) AND DUANCPDT_TIEUCHI.C_TABLE =1 AND DUANCPDT_TIEUCHI.C_CODE IS NOT NULL order by DUANCPDT_TIEUCHI.C_ORDER", Request.QueryString["IDDACPDT"], Request.QueryString["M"], Request.QueryString["Y"], "GOPVON", Request.QueryString["DONVI"]);
        DataSet_rp_CPDT ds = new DataSet_rp_CPDT();
        SqlDataAdapter adt = ac.getAdt(sqlselectgopvontb1);
        adt.Fill(ds, "GOPVON1_REPORT");
        DataTable odata = ds.Tables["GOPVON1_REPORT"];
        foreach (DataRow rs in odata.Rows)
        {
            rs["C_NAME"] = getName(rs["C_NAME"], rs["C_LEVEL"].ToString(), rs["C_HEADER"]);
        }
        //table 2
        string sqlselectgopvontb2 = sqlselectgopvon + String.Format(" WHERE (DUANCPDT_VALUE.FK_DUANCPDT = {0}) AND DUANCPDT_VALUE.C_MONTH ={1} AND C_YEAR ={2} AND (DUANCPDT_TIEUCHI.C_TYPE = '{3}') AND (DUANCPDT_VALUE.FK_DONVI ={4}) AND DUANCPDT_TIEUCHI.C_TABLE =2 AND DUANCPDT_TIEUCHI.pk_id <> 147  order by DUANCPDT_TIEUCHI.C_ORDER", Request.QueryString["IDDACPDT"], Request.QueryString["M"], Request.QueryString["Y"], "GOPVON", Request.QueryString["DONVI"]);
        SqlDataAdapter adttb2 = ac.getAdt(sqlselectgopvontb2);
        adttb2.Fill(ds, "GOPVON2_REPORT");
        DataTable odatadichvu = ds.Tables["GOPVON2_REPORT"];
        foreach (DataRow rs in odatadichvu.Rows)
        {
            rs["C_NAME"] = getName(rs["C_NAME"], rs["C_LEVEL"].ToString(), rs["C_HEADER"]);
        }

        rd.Load(Server.MapPath("Reports\\rp_duancpdt_phuluc5.rpt"));
        rd.SetDataSource(ds);
        BaocaoDACPDT.ReportSource = rd;
        BaocaoDACPDT.DataBind();
    }
    //Phụ lục 6: Tình hình đầu tư và đào tạo nghề
    protected void getbaocao_dautu_daotao()
    {
        //Xuất theo phục lục 6 DTXD + DAOTAo
        string sqlselect = String.Format("SELECT DUANCPDT_TIEUCHI.C_CODE, DUANCPDT_TIEUCHI.C_NAME, DUANCPDT_TIEUCHI.C_UNIT, DUANCPDT_VALUE.VALUE1, DUANCPDT_VALUE.VALUE2, DUANCPDT_VALUE.VALUE3, DUANCPDT_VALUE.VALUE4," +
           " DUANCPDT_VALUE.VALUE5, DUANCPDT_VALUE.VALUE6, DUANCPDT_VALUE.VALUE7, DUANCPDT_VALUE.VALUE8, DUANCPDT_VALUE.VALUE9, DUANCPDT_VALUE.VALUE10, DUANCPDT_VALUE.VALUE11" +
           " ,DUANCPDT_TIEUCHI.C_LEVEL, DUANCPDT_TIEUCHI.C_HEADER, DUANCPDT_VALUE.FK_DONVI, DUANCPDT_VALUE.C_MONTH, DUANCPDT_VALUE.C_YEAR,DUANCPDT_VALUE.FK_TIEUCHI" +
           " FROM DUANCPDT_TIEUCHI INNER JOIN DUANCPDT_VALUE ON DUANCPDT_TIEUCHI.PK_ID = DUANCPDT_VALUE.FK_TIEUCHI ");
        DataSet_rp_CPDT ds = new DataSet_rp_CPDT();
        //Dautu
        // DUANCPDT_VALUE.VALUE1, DUANCPDT_VALUE.VALUE2, DUANCPDT_VALUE.VALUE3,DUANCPDT_VALUE.VALUE4, DUANCPDT_VALUE.VALUE5, CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE6) AS VALUE6, CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE7) AS VALUE7,CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE8) AS VALUE8, DUANCPDT_VALUE.VALUE9,
        string sqldautu = sqlselect + String.Format(" WHERE (DUANCPDT_VALUE.FK_DUANCPDT = {0}) AND DUANCPDT_VALUE.C_MONTH ={1} AND C_YEAR ={2} AND (DUANCPDT_TIEUCHI.C_TYPE = '{3}') AND (DUANCPDT_VALUE.FK_DONVI ={4}) order by DUANCPDT_TIEUCHI.C_ORDER", Request.QueryString["IDDACPDT"], Request.QueryString["M"], Request.QueryString["Y"], "DAUTUXAYDUNG", Request.QueryString["DONVI"]);
        SqlDataAdapter adtdautu = ac.getAdt(sqldautu);
        adtdautu.Fill(ds, "DAUTU_REPORT");
        DataTable odatadautu = ds.Tables["DAUTU_REPORT"];
        string stryear = "";
        foreach (DataRow rs in odatadautu.Rows)
        {
            rs["C_NAME"] = getName(rs["C_NAME"], rs["C_LEVEL"].ToString(), rs["C_HEADER"]);
            if (stryear == "") stryear = rs["C_YEAR"] != DBNull.Value ? rs["C_YEAR"].ToString() : "";
        }
        //DAotao
        string sqlDaotao = sqlselect + String.Format(" WHERE (DUANCPDT_VALUE.FK_DUANCPDT = {0}) AND DUANCPDT_VALUE.C_MONTH ={1} AND C_YEAR ={2} AND DUANCPDT_TIEUCHI.C_CODE IS NOT NULL AND (DUANCPDT_TIEUCHI.C_TYPE = '{3}') AND (DUANCPDT_VALUE.FK_DONVI ={4}) order by DUANCPDT_TIEUCHI.C_ORDER", Request.QueryString["IDDACPDT"], Request.QueryString["M"], Request.QueryString["Y"], "DAOTAO", Request.QueryString["DONVI"]);
        SqlDataAdapter adtdaotao = ac.getAdt(sqlDaotao);
        adtdaotao.Fill(ds, "DAOTAO_REPORT");
        DataTable odatadaotao = ds.Tables["DAOTAO_REPORT"];
        foreach (DataRow rs in odatadaotao.Rows)
        {
            rs["C_NAME"] = getName(rs["C_NAME"], rs["C_LEVEL"].ToString(), rs["C_HEADER"]);
        }
        //
        rd.Load(Server.MapPath("Reports\\rp_duancpdt_phuluc6.rpt"));
        rd.SetDataSource(ds);
        rd.SetParameterValue("ACTYEAR", stryear, "rp_pl6_daotaonghe.rpt");
        BaocaoDACPDT.ReportSource = rd;
        BaocaoDACPDT.DataBind();
    }
    //Phụ lục 7: Tinhf hình ứng dựng CNTT _ BVMT và tai nạn lao động
    protected void getbaocao_cntt_bvmt_tnld()
    {
        //Xuất theo phục lục 7 CNTT + TNLD + BVMT
        string sqlselect = String.Format("SELECT DUANCPDT_TIEUCHI.C_CODE, DUANCPDT_TIEUCHI.C_NAME, DUANCPDT_TIEUCHI.C_UNIT, DUANCPDT_VALUE.VALUE1, DUANCPDT_VALUE.VALUE2, DUANCPDT_VALUE.VALUE3, DUANCPDT_VALUE.VALUE4," +
           " DUANCPDT_VALUE.VALUE5, DUANCPDT_VALUE.VALUE6, DUANCPDT_VALUE.VALUE7, DUANCPDT_VALUE.VALUE8, DUANCPDT_VALUE.VALUE9, DUANCPDT_VALUE.VALUE10, DUANCPDT_VALUE.VALUE11" +
           " ,DUANCPDT_TIEUCHI.C_LEVEL, DUANCPDT_TIEUCHI.C_HEADER, DUANCPDT_VALUE.FK_DONVI, DUANCPDT_VALUE.C_MONTH, DUANCPDT_VALUE.C_YEAR,DUANCPDT_VALUE.FK_TIEUCHI" +
           " FROM DUANCPDT_TIEUCHI INNER JOIN DUANCPDT_VALUE ON DUANCPDT_TIEUCHI.PK_ID = DUANCPDT_VALUE.FK_TIEUCHI ");
        DataSet_rp_CPDT ds = new DataSet_rp_CPDT();
        //CNTT
        string sqlcntt = sqlselect + String.Format(" WHERE (DUANCPDT_VALUE.FK_DUANCPDT = {0}) AND DUANCPDT_VALUE.C_MONTH ={1} AND C_YEAR ={2} AND (DUANCPDT_TIEUCHI.C_TYPE = '{3}') AND (DUANCPDT_VALUE.FK_DONVI ={4}) order by DUANCPDT_TIEUCHI.C_ORDER", Request.QueryString["IDDACPDT"], Request.QueryString["M"], Request.QueryString["Y"], "CNTT", Request.QueryString["DONVI"]);
        SqlDataAdapter adt = ac.getAdt(sqlcntt);
        adt.Fill(ds, "CNTT_REPORT");
        DataTable odatacntt = ds.Tables["CNTT_REPORT"];
        bool strlan = false, strnet = false, strweb = false, strsan = false;
        decimal numlan = 0, numnet = 0, sumcom = 0, sumtien = 0;
        string website = "", diachigiadich ="";
        foreach (DataRow rs in odatacntt.Rows)
        {
            rs["C_NAME"] = getName(rs["C_NAME"], rs["C_LEVEL"].ToString(), rs["C_HEADER"]);
            if (rs["FK_TIEUCHI"].ToString() == "61")
            {
                if (rs["VALUE1"] != DBNull.Value)
                    if (rs["VALUE1"].ToString() == "1") strlan = true;
            }
            else if (rs["FK_TIEUCHI"].ToString() == "63")
            {
                if (rs["VALUE1"] != DBNull.Value)
                    if (rs["VALUE1"].ToString() == "1") strnet = true;
            }
            else if (rs["FK_TIEUCHI"].ToString() == "65")
            {
                if (rs["VALUE1"] != DBNull.Value)
                    if (rs["VALUE1"].ToString() == "1") strweb = true;
            }
            else if (rs["FK_TIEUCHI"].ToString() == "67")
            {
                if (rs["VALUE1"] != DBNull.Value)
                    if (rs["VALUE1"].ToString() == "1") strsan = true;
            }
            else if (rs["FK_TIEUCHI"].ToString() == "60")
                sumcom = rs["VALUE2"] != DBNull.Value ? decimal.Parse(rs["VALUE2"].ToString()) : 0;
            else if (rs["FK_TIEUCHI"].ToString() == "62")
                numlan = rs["VALUE2"] != DBNull.Value ? decimal.Parse(rs["VALUE2"].ToString()) : 0;
            else if (rs["FK_TIEUCHI"].ToString() == "64")
                numnet = rs["VALUE2"] != DBNull.Value ? decimal.Parse(rs["VALUE2"].ToString()) : 0;
            else if (rs["FK_TIEUCHI"].ToString() == "66")
            {
                if (rs["VALUE3"] != DBNull.Value)
                    website = rs["VALUE3"].ToString();
            }
            else if (rs["FK_TIEUCHI"].ToString() == "68")
            {
                if (rs["VALUE3"] != DBNull.Value)
                    diachigiadich = rs["VALUE3"].ToString();
            }
            else if (rs["FK_TIEUCHI"].ToString() == "69")
                sumtien = rs["VALUE2"] != DBNull.Value ? decimal.Parse(rs["VALUE2"].ToString()) : 0;
        }
        //Tai nạn lao động //Do
        string sqlTainan = String.Format("SELECT DUANCPDT_TIEUCHI.C_CODE, DUANCPDT_TIEUCHI.C_NAME, DUANCPDT_TIEUCHI.C_UNIT, CONVERT(Decimal(12, 0), DUANCPDT_VALUE.VALUE2) AS VALUE1 " +
           " ,DUANCPDT_TIEUCHI.C_LEVEL, DUANCPDT_TIEUCHI.C_HEADER, DUANCPDT_VALUE.FK_DONVI, DUANCPDT_VALUE.C_MONTH, DUANCPDT_VALUE.C_YEAR,DUANCPDT_VALUE.FK_TIEUCHI" +
           " FROM DUANCPDT_TIEUCHI INNER JOIN DUANCPDT_VALUE ON DUANCPDT_TIEUCHI.PK_ID = DUANCPDT_VALUE.FK_TIEUCHI ");
        sqlTainan += String.Format(" WHERE (DUANCPDT_VALUE.FK_DUANCPDT = {0}) AND DUANCPDT_VALUE.C_MONTH ={1} AND C_YEAR ={2} AND DUANCPDT_TIEUCHI.C_CODE IS NOT NULL AND (DUANCPDT_TIEUCHI.C_TYPE = '{3}') AND (DUANCPDT_VALUE.FK_DONVI ={4}) order by DUANCPDT_TIEUCHI.C_ORDER", Request.QueryString["IDDACPDT"], Request.QueryString["M"], Request.QueryString["Y"], "TAINAN", Request.QueryString["DONVI"]);
        SqlDataAdapter adttainan = ac.getAdt(sqlTainan);
        adttainan.Fill(ds, "TAINAN_REPORT");
        DataTable odatatainan = ds.Tables["TAINAN_REPORT"];
        foreach (DataRow rs in odatatainan.Rows)
        {
            rs["C_NAME"] = getName(rs["C_NAME"], rs["C_LEVEL"].ToString(), rs["C_HEADER"]);
        }
        //BVMT
        string sqlbvmt = sqlselect + String.Format(" WHERE (DUANCPDT_VALUE.FK_DUANCPDT = {0}) AND DUANCPDT_VALUE.C_MONTH ={1} AND C_YEAR ={2} AND (DUANCPDT_TIEUCHI.C_TYPE = '{3}') AND (DUANCPDT_TIEUCHI.PK_ID IN (137,138,139)) AND (DUANCPDT_VALUE.FK_DONVI ={4}) order by DUANCPDT_TIEUCHI.C_ORDER", Request.QueryString["IDDACPDT"], Request.QueryString["M"], Request.QueryString["Y"], "BVMT", Request.QueryString["DONVI"]);
        SqlDataAdapter adtbvmt = ac.getAdt(sqlbvmt);
        adtbvmt.Fill(ds, "BVMT_REPORT");
        DataTable odatabvmt = ds.Tables["BVMT_REPORT"];
        foreach (DataRow rs in odatabvmt.Rows)
        {
            rs["C_NAME"] = getName(rs["C_NAME"], rs["C_LEVEL"].ToString(), rs["C_HEADER"]);           
        }
        //
        rd.Load(Server.MapPath("Reports\\rp_duancpdt_phuluc7.rpt"));
        rd.SetDataSource(ds);
        //CNTT
        rd.SetParameterValue("TXT22", strlan ? "" : "X", "rp_cntt.rpt");
        rd.SetParameterValue("TXT21", !strlan ? "" : "X", "rp_cntt.rpt");
        rd.SetParameterValue("TXT32", strnet ? "" : "X", "rp_cntt.rpt");
        rd.SetParameterValue("TXT31", !strnet ? "" : "X", "rp_cntt.rpt");
        rd.SetParameterValue("TXT42", strweb ? "" : "X", "rp_cntt.rpt");
        rd.SetParameterValue("TXT41", !strweb ? "" : "X", "rp_cntt.rpt");
        rd.SetParameterValue("TXT52", strsan ? "" : "X", "rp_cntt.rpt");
        rd.SetParameterValue("TXT51", !strsan ? "" : "X", "rp_cntt.rpt");
        rd.SetParameterValue("NUMCOM", sumcom , "rp_cntt.rpt");
        rd.SetParameterValue("NUMCOMLAN", numlan , "rp_cntt.rpt");
        rd.SetParameterValue("NUMCOMNET", numnet, "rp_cntt.rpt");
        rd.SetParameterValue("WEBSITE", website, "rp_cntt.rpt");
        rd.SetParameterValue("ADDRESS", diachigiadich, "rp_cntt.rpt");
        rd.SetParameterValue("SUMVALUE", sumtien, "rp_cntt.rpt");
        //BVMT
        decimal ivalue1 = 0, ivalue2 = 0, ivalue3 = 0;
        string sqlgetvalue = "SELECT DUANCPDT_VALUE.VALUE1 FROM DUANCPDT_VALUE ";
        string sqlbvmtgetvalue = sqlgetvalue + String.Format(" WHERE (DUANCPDT_VALUE.FK_DUANCPDT = {0}) AND DUANCPDT_VALUE.C_MONTH ={1} AND C_YEAR ={2} AND (DUANCPDT_VALUE.FK_TIEUCHI IN (133,134,135)) AND (DUANCPDT_VALUE.FK_DONVI ={3}) order by DUANCPDT_VALUE.FK_TIEUCHI", Request.QueryString["IDDACPDT"], Request.QueryString["M"], Request.QueryString["Y"], Request.QueryString["DONVI"]);
        DataTable odatagetvalue = ac.query_data(sqlbvmtgetvalue);
        if (odatagetvalue.Rows.Count > 0)
        {
            ivalue1 = odatagetvalue.Rows[0]["VALUE1"] != DBNull.Value ? decimal.Parse(odatagetvalue.Rows[0]["VALUE1"].ToString()) : 0;
            ivalue2 = odatagetvalue.Rows[1]["VALUE1"] != DBNull.Value ? decimal.Parse(odatagetvalue.Rows[1]["VALUE1"].ToString()) : 0;
            ivalue3 = odatagetvalue.Rows[2]["VALUE1"] != DBNull.Value ? decimal.Parse(odatagetvalue.Rows[2]["VALUE1"].ToString()) : 0;
        }
        rd.SetParameterValue("GTTHIETBI",ivalue1, "rp_bvmt.rpt");
        rd.SetParameterValue("CHIPHIBAOVE", ivalue2, "rp_bvmt.rpt");
        rd.SetParameterValue("CHIPHIXAYLAP", ivalue3, "rp_bvmt.rpt");
        BaocaoDACPDT.ReportSource = rd;
        BaocaoDACPDT.DataBind();
    }
    //Phụ lục 8: Tình hình xây dựng
    protected void getbaocao_Xaydung()
    {
        //Lưu trú
        string sqlselectxaydung = String.Format("SELECT DUANCPDT_TIEUCHI.C_CODE, DUANCPDT_TIEUCHI.C_NAME, DUANCPDT_TIEUCHI.C_UNIT, " +
           " CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE1) AS VALUE1, CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE2) AS VALUE2, CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE3) AS VALUE3,  CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE4) AS VALUE4, CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE5) AS VALUE5, CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE6) AS VALUE6, "+
           " CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE7) AS VALUE7, CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE8) AS VALUE8, CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE9) AS VALUE9, DUANCPDT_VALUE.VALUE10, DUANCPDT_VALUE.VALUE11" +
           " ,DUANCPDT_TIEUCHI.C_LEVEL, DUANCPDT_TIEUCHI.C_HEADER, DUANCPDT_VALUE.FK_DONVI, DUANCPDT_VALUE.C_MONTH, DUANCPDT_VALUE.C_YEAR" +
           " FROM DUANCPDT_TIEUCHI INNER JOIN DUANCPDT_VALUE ON DUANCPDT_TIEUCHI.PK_ID = DUANCPDT_VALUE.FK_TIEUCHI ");

        //Table1 
        string sqlselectxaydung1 = sqlselectxaydung + String.Format(" WHERE (DUANCPDT_VALUE.FK_DUANCPDT = {0}) AND DUANCPDT_VALUE.C_MONTH ={1} AND C_YEAR ={2} AND (DUANCPDT_TIEUCHI.C_TYPE = '{3}') AND (DUANCPDT_VALUE.FK_DONVI ={4}) AND DUANCPDT_TIEUCHI.C_TABLE =1 AND DUANCPDT_TIEUCHI.C_CODE IS NOT NULL order by DUANCPDT_TIEUCHI.C_ORDER", Request.QueryString["IDDACPDT"], Request.QueryString["M"], Request.QueryString["Y"], "XAYDUNG", Request.QueryString["DONVI"]);
        DataSet_rp_CPDT ds = new DataSet_rp_CPDT();
        SqlDataAdapter adt = ac.getAdt(sqlselectxaydung1);
        adt.Fill(ds, "XAYDUNG1_REPORT");
        DataTable odata = ds.Tables["XAYDUNG1_REPORT"];
        foreach (DataRow rs in odata.Rows)
        {
            rs["C_NAME"] = getName(rs["C_NAME"], rs["C_LEVEL"].ToString(), rs["C_HEADER"]);
        }
        //table 2
        string sqlselectxaydung2 = sqlselectxaydung + String.Format(" WHERE (DUANCPDT_VALUE.FK_DUANCPDT = {0}) AND DUANCPDT_VALUE.C_MONTH ={1} AND C_YEAR ={2} AND (DUANCPDT_TIEUCHI.C_TYPE = '{3}') AND (DUANCPDT_VALUE.FK_DONVI ={4}) AND DUANCPDT_TIEUCHI.C_TABLE =2 AND DUANCPDT_TIEUCHI.C_CODE IS NOT NULL order by DUANCPDT_TIEUCHI.C_ORDER", Request.QueryString["IDDACPDT"], Request.QueryString["M"], Request.QueryString["Y"], "XAYDUNG", Request.QueryString["DONVI"]);
        SqlDataAdapter adttb2 = ac.getAdt(sqlselectxaydung2);
        adttb2.Fill(ds, "XAYDUNG2_REPORT");
        DataTable odatatb2 = ds.Tables["XAYDUNG2_REPORT"];
        foreach (DataRow rs in odatatb2.Rows)
        {
            rs["C_NAME"] = getName(rs["C_NAME"], rs["C_LEVEL"].ToString(), rs["C_HEADER"]);
        }
        //table 3
        string sqlselectxaydung3 = sqlselectxaydung + String.Format(" WHERE (DUANCPDT_VALUE.FK_DUANCPDT = {0}) AND DUANCPDT_VALUE.C_MONTH ={1} AND C_YEAR ={2} AND (DUANCPDT_TIEUCHI.C_TYPE = '{3}') AND (DUANCPDT_VALUE.FK_DONVI ={4}) AND DUANCPDT_TIEUCHI.C_TABLE =3 AND DUANCPDT_TIEUCHI.C_CODE IS NOT NULL order by DUANCPDT_TIEUCHI.C_ORDER", Request.QueryString["IDDACPDT"], Request.QueryString["M"], Request.QueryString["Y"], "XAYDUNG", Request.QueryString["DONVI"]);
        SqlDataAdapter adttb3 = ac.getAdt(sqlselectxaydung3);
        adttb3.Fill(ds, "XAYDUNG3_REPORT");
        DataTable odatatb3 = ds.Tables["XAYDUNG3_REPORT"];
        foreach (DataRow rs in odatatb3.Rows)
        {
            rs["C_NAME"] = getName(rs["C_NAME"], rs["C_LEVEL"].ToString(), rs["C_HEADER"]);
        }
        rd.Load(Server.MapPath("Reports\\rp_duancpdt_phuluc8.rpt"));
        rd.SetDataSource(ds);
        BaocaoDACPDT.ReportSource = rd;
        BaocaoDACPDT.DataBind();
    }
    //Phụ lục 9: Tifh hình lưu trú
    protected void getbaocao_Luutru()
    {
        //Lưu trú
        string sqlselectlutru = String.Format("SELECT DUANCPDT_TIEUCHI.C_CODE, DUANCPDT_TIEUCHI.C_NAME, DUANCPDT_TIEUCHI.C_UNIT, " +
           " CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE1) AS VALUE1, CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE2) AS VALUE2, CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE3) AS VALUE3,  CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE4) AS VALUE4, CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE5) AS VALUE5, CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE6) AS VALUE6, " +
           " CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE7) AS VALUE7, CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE8) AS VALUE8, DUANCPDT_VALUE.VALUE9, DUANCPDT_VALUE.VALUE10, DUANCPDT_VALUE.VALUE11" +
           " ,DUANCPDT_TIEUCHI.C_LEVEL, DUANCPDT_TIEUCHI.C_HEADER, DUANCPDT_VALUE.FK_DONVI, DUANCPDT_VALUE.C_MONTH, DUANCPDT_VALUE.C_YEAR" +
           " FROM DUANCPDT_TIEUCHI INNER JOIN DUANCPDT_VALUE ON DUANCPDT_TIEUCHI.PK_ID = DUANCPDT_VALUE.FK_TIEUCHI ");

        //Table1 
        string sqlselectlutrutb1 = sqlselectlutru + String.Format(" WHERE (DUANCPDT_VALUE.FK_DUANCPDT = {0}) AND DUANCPDT_VALUE.C_MONTH ={1} AND C_YEAR ={2} AND (DUANCPDT_TIEUCHI.C_TYPE = '{3}') AND (DUANCPDT_VALUE.FK_DONVI ={4}) AND DUANCPDT_TIEUCHI.C_TABLE =1 AND DUANCPDT_TIEUCHI.PK_ID <>76 order by DUANCPDT_TIEUCHI.C_ORDER", Request.QueryString["IDDACPDT"], Request.QueryString["M"], Request.QueryString["Y"], "LUUTRU", Request.QueryString["DONVI"]);
        DataSet_rp_CPDT ds = new DataSet_rp_CPDT();
        SqlDataAdapter adt = ac.getAdt(sqlselectlutrutb1);
        adt.Fill(ds, "LUUTRU1_REPORT");
        DataTable odata = ds.Tables["LUUTRU1_REPORT"];
        foreach (DataRow rs in odata.Rows)
        {
            rs["C_NAME"] = getName(rs["C_NAME"], rs["C_LEVEL"].ToString(), rs["C_HEADER"]);
        }
        //table 2
        string sqlselectlutrutb2 = sqlselectlutru + String.Format(" WHERE (DUANCPDT_VALUE.FK_DUANCPDT = {0}) AND DUANCPDT_VALUE.C_MONTH ={1} AND C_YEAR ={2} AND (DUANCPDT_TIEUCHI.C_TYPE = '{3}') AND (DUANCPDT_VALUE.FK_DONVI ={4}) AND DUANCPDT_TIEUCHI.C_TABLE =2 AND DUANCPDT_TIEUCHI.C_CODE IS NOT NULL order by DUANCPDT_TIEUCHI.C_ORDER", Request.QueryString["IDDACPDT"], Request.QueryString["M"], Request.QueryString["Y"], "LUUTRU", Request.QueryString["DONVI"]);
        SqlDataAdapter adttb2 = ac.getAdt(sqlselectlutrutb2);
        adttb2.Fill(ds, "LUUTRU2_REPORT");
        DataTable odatadichvu = ds.Tables["LUUTRU2_REPORT"];
        foreach (DataRow rs in odatadichvu.Rows)
        {
            rs["C_NAME"] = getName(rs["C_NAME"], rs["C_LEVEL"].ToString(), rs["C_HEADER"]);
        }

        rd.Load(Server.MapPath("Reports\\rp_duancpdt_phuluc9.rpt"));
        rd.SetDataSource(ds);
        BaocaoDACPDT.ReportSource = rd;
        BaocaoDACPDT.DataBind();
    }
    //Phụ lục 10: Hoạt động nhà hàng và các dịch vụ khác
    protected void getbaocao_Nhahang_dichvu()
    {
        //Nhà hàng
        string sqlselectNhahag = String.Format("SELECT DUANCPDT_TIEUCHI.C_CODE, DUANCPDT_TIEUCHI.C_NAME, DUANCPDT_TIEUCHI.C_UNIT, " +
           " CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE1) AS VALUE1, DUANCPDT_VALUE.VALUE2, DUANCPDT_VALUE.VALUE3, DUANCPDT_VALUE.VALUE4, DUANCPDT_VALUE.VALUE5, DUANCPDT_VALUE.VALUE6, DUANCPDT_VALUE.VALUE7, DUANCPDT_VALUE.VALUE8, DUANCPDT_VALUE.VALUE9, DUANCPDT_VALUE.VALUE10, DUANCPDT_VALUE.VALUE11" +
           " ,DUANCPDT_TIEUCHI.C_LEVEL, DUANCPDT_TIEUCHI.C_HEADER, DUANCPDT_VALUE.FK_DONVI, DUANCPDT_VALUE.C_MONTH, DUANCPDT_VALUE.C_YEAR" +
           " FROM DUANCPDT_TIEUCHI INNER JOIN DUANCPDT_VALUE ON DUANCPDT_TIEUCHI.PK_ID = DUANCPDT_VALUE.FK_TIEUCHI ");
        sqlselectNhahag += String.Format(" WHERE (DUANCPDT_VALUE.FK_DUANCPDT = {0}) AND DUANCPDT_VALUE.C_MONTH ={1} AND C_YEAR ={2} AND (DUANCPDT_TIEUCHI.C_TYPE = '{3}') AND (DUANCPDT_VALUE.FK_DONVI ={4}) order by DUANCPDT_TIEUCHI.C_ORDER", Request.QueryString["IDDACPDT"], Request.QueryString["M"], Request.QueryString["Y"], "NHAHANG", Request.QueryString["DONVI"]);
        DataSet_rp_CPDT ds = new DataSet_rp_CPDT();
        SqlDataAdapter adt = ac.getAdt(sqlselectNhahag);
        //Lấy dữ liệu tại bảng DACPDT_REPORT
        adt.Fill(ds, "NHAHANG_REPORT");
        DataTable odata = ds.Tables["NHAHANG_REPORT"];
        foreach (DataRow rs in odata.Rows)
        {
            rs["C_NAME"] = getName(rs["C_NAME"], rs["C_LEVEL"].ToString(), rs["C_HEADER"]);
        }
        //Dịch vụ
        string sqlselectdichvu = String.Format("SELECT DUANCPDT_TIEUCHI.C_CODE, DUANCPDT_TIEUCHI.C_NAME, DUANCPDT_TIEUCHI.C_UNIT, " +
          " CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE1) AS VALUE1, CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE2) AS VALUE2, CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE3) AS VALUE3,  CONVERT(Decimal(15, 0), DUANCPDT_VALUE.VALUE4) AS VALUE4, DUANCPDT_VALUE.VALUE5, DUANCPDT_VALUE.VALUE6, DUANCPDT_VALUE.VALUE7, DUANCPDT_VALUE.VALUE8, DUANCPDT_VALUE.VALUE9, DUANCPDT_VALUE.VALUE10, DUANCPDT_VALUE.VALUE11" +
          " ,DUANCPDT_TIEUCHI.C_LEVEL, DUANCPDT_TIEUCHI.C_HEADER, DUANCPDT_VALUE.FK_DONVI, DUANCPDT_VALUE.C_MONTH, DUANCPDT_VALUE.C_YEAR" +
          " FROM DUANCPDT_TIEUCHI INNER JOIN DUANCPDT_VALUE ON DUANCPDT_TIEUCHI.PK_ID = DUANCPDT_VALUE.FK_TIEUCHI ");
        sqlselectdichvu += String.Format(" WHERE (DUANCPDT_VALUE.FK_DUANCPDT = {0}) AND DUANCPDT_VALUE.C_MONTH ={1} AND C_YEAR ={2} AND (DUANCPDT_TIEUCHI.C_TYPE = '{3}') AND (DUANCPDT_VALUE.FK_DONVI ={4}) order by DUANCPDT_TIEUCHI.C_ORDER", Request.QueryString["IDDACPDT"], Request.QueryString["M"], Request.QueryString["Y"], "DICHVU", Request.QueryString["DONVI"]);
        SqlDataAdapter adtdichvu = ac.getAdt(sqlselectdichvu);
        //Lấy dữ liệu tại bảng DACPDT_REPORT
        adtdichvu.Fill(ds, "DICHVU_REPORT");
        DataTable odatadichvu = ds.Tables["DICHVU_REPORT"];
        foreach (DataRow rs in odatadichvu.Rows)
        {
            rs["C_NAME"] = getName(rs["C_NAME"], rs["C_LEVEL"].ToString(), rs["C_HEADER"]);
        }

        rd.Load(Server.MapPath("Reports\\rp_duancpdt_phuluc10.rpt"));
        rd.SetDataSource(ds);
        BaocaoDACPDT.ReportSource = rd;
        BaocaoDACPDT.DataBind();
    }*/
}