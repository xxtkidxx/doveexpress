using ITCLIB.KHIEUNAI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

/// <summary>
/// Summary description for MyWebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class MyWebServiceKN : System.Web.Services.WebService {

    KHIEUNAIList khieunaiList = null;
    public MyWebServiceKN()
    {
        khieunaiList = new KHIEUNAIList();

        if (HttpContext.Current.Session["MyDataKHIEUNAI"] == null)
        {
           HttpContext.Current.Session["MyDataKHIEUNAI"] = khieunaiList;
        }
    }

    [WebMethod(EnableSession = true)]
    public KHIEUNAIList UpdateKHIEUNAIByKHIEUNAI(KHIEUNAI khieunai)
    {
        KHIEUNAI khieunaiToUpdate = GetKHIEUNAIByPK_ID(khieunai.PK_ID);

        KHIEUNAIList list = (KHIEUNAIList)HttpContext.Current.Session["MyDataKHIEUNAI"];
        bool CheckInsert = false;
        if (khieunaiToUpdate == null)
        {
            CheckInsert = true;
            khieunaiToUpdate = new KHIEUNAI();           
        }
        khieunaiToUpdate.C_CODE = khieunai.C_CODE;
        khieunaiToUpdate.C_TYPE = khieunai.C_TYPE;
        khieunaiToUpdate.C_DATE = khieunai.C_DATE;
        khieunaiToUpdate.C_BILL = khieunai.C_BILL;
        khieunaiToUpdate.FK_KHACHHANG = khieunai.FK_KHACHHANG;
        khieunaiToUpdate.C_TENKH = khieunai.C_TENKH;
        khieunaiToUpdate.C_SDT = khieunai.C_SDT;
        khieunaiToUpdate.C_NOIDUNG = khieunai.C_NOIDUNG;
        khieunaiToUpdate.FK_NGUOITAO = khieunai.FK_NGUOITAO;
        khieunaiToUpdate.C_STATUS = khieunai.C_STATUS;      
        string UpdateSQL = "";
        ITCLIB.Admin.SQL UpdateQuery = new ITCLIB.Admin.SQL();
        if (CheckInsert)
        {
            UpdateSQL = "INSERT INTO [KHIEUNAI] ([C_CODE], [C_TYPE], [C_DATE], [C_BILL], [FK_KHACHHANG], [C_TENKH], [C_SDT], [C_NOIDUNG], [FK_NGUOITAO], [C_STATUS]) VALUES ('" + khieunai.C_CODE + "', N'" + khieunai.C_TYPE + "','" + String.Format("{0:yyyy-MM-dd hh:mm:ss tt}", khieunai.C_DATE.ToUniversalTime().AddHours(7)) + "', N'" + khieunai.C_BILL + "', " + (khieunai.FK_KHACHHANG == "0" ? "NULL" : "N'" + khieunai.FK_KHACHHANG + "'") + ", N'" + khieunai.C_TENKH + "', N'" + khieunai.C_SDT + "', N'" + khieunai.C_NOIDUNG + "', " + (khieunai.FK_NGUOITAO == 0 ? "NULL" : khieunai.FK_NGUOITAO.ToString()) + ", N'" + khieunai.C_STATUS + "');SELECT @@IDENTITY";
            //Session["t"] = UpdateSQL;
            khieunaiToUpdate.PK_ID = int.Parse(UpdateQuery.ExecuteScalar(UpdateSQL).ToString());           
            list.Add(khieunaiToUpdate);
        }
        else
        {
            UpdateSQL = "UPDATE [KHIEUNAI] SET [C_CODE] = '" + khieunai.C_CODE + "', [C_TYPE] = N'" + khieunai.C_TYPE + "', [C_DATE] = '" + String.Format("{0:yyyy-MM-dd hh:mm:ss tt}", khieunai.C_DATE.ToUniversalTime().AddHours(7)) + "', [C_BILL] = N'" + khieunai.C_BILL + "', [FK_KHACHHANG] = " + (khieunai.FK_KHACHHANG == "0" ? "NULL" : "N'" + khieunai.FK_KHACHHANG + "'") + ", [C_TENKH] = N'" + khieunai.C_TENKH + "', [C_SDT] = N'" + khieunai.C_SDT + "', [C_NOIDUNG] = N'" + khieunai.C_NOIDUNG + "', [FK_NGUOITAO] = " + (khieunai.FK_NGUOITAO == 0 ? "NULL" : khieunai.FK_NGUOITAO.ToString()) + ", [C_STATUS] = N'" + khieunai.C_STATUS + "' WHERE [PK_ID] = " + khieunai.PK_ID;
            //Session["t"] = UpdateSQL;
            UpdateQuery.ExecuteNonQuery(UpdateSQL);
        }
        HttpContext.Current.Session["MyDataKHIEUNAI"] = list;      
        return list;
    }

    [WebMethod(EnableSession = true)]
    public KHIEUNAIList DeleteKHIEUNAIByPK_ID(int PK_ID)
    {
        KHIEUNAI khieunaiToDelete = GetKHIEUNAIByPK_ID(PK_ID);
        KHIEUNAIList list = (KHIEUNAIList)HttpContext.Current.Session["MyDataKHIEUNAI"];
        list.Remove(khieunaiToDelete);
        HttpContext.Current.Session["MyDataKHIEUNAI"] = list;
        string DeleteSQL = "DELETE FROM KHIEUNAI WHERE PK_ID = " + PK_ID + ";DELETE FROM KHIEUNAIGIAIQUYET WHERE FK_KHIEUNAI = " + PK_ID;
        ITCLIB.Admin.SQL DeleteQuery = new ITCLIB.Admin.SQL();
        DeleteQuery.ExecuteNonQuery(DeleteSQL);
        return list;
    }


    [WebMethod(EnableSession = true)]
    public KHIEUNAI GetKHIEUNAIByPK_ID(int PK_ID)
    {
        KHIEUNAIList list = (KHIEUNAIList)HttpContext.Current.Session["MyDataKHIEUNAI"];
        return list.GetKHIEUNAIByPK_ID(PK_ID);
    }
    [WebMethod]
    public string GetServerTime()
    {
        string serverTime =
        String.Format("The current time is {0}.", DateTime.Now);
        return serverTime;
    }
    
}
