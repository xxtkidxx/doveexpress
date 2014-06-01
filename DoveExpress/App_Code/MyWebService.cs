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
public class MyWebService : System.Web.Services.WebService {

    KHIEUNAIList khieunaiList = null;

    public MyWebService()
    {
        khieunaiList = new KHIEUNAIList();

        if (HttpContext.Current.Session["MyData"] == null)
        {
            HttpContext.Current.Session["MyData"] = khieunaiList;
        }
    }

    [WebMethod(EnableSession = true)]
    public KHIEUNAIList UpdateKHIEUNAIByKHIEUNAI(KHIEUNAI khieunai)
    {
        KHIEUNAI khieunaiToUpdate = GetKHIEUNAIByPK_ID(khieunai.PK_ID);

        KHIEUNAIList list = (KHIEUNAIList)HttpContext.Current.Session["MyData"];

        if (khieunaiToUpdate == null)
        {
            khieunaiToUpdate = new KHIEUNAI();
            khieunaiToUpdate.PK_ID = khieunai.PK_ID;

            list.Add(khieunaiToUpdate);
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

        HttpContext.Current.Session["MyData"] = list;

        return list;
    }

    [WebMethod(EnableSession = true)]
    public KHIEUNAIList DeleteKHIEUNAIByPK_ID(int PK_ID)
    {
        KHIEUNAI khieunaiToDelete = GetKHIEUNAIByPK_ID(PK_ID);

        KHIEUNAIList list = (KHIEUNAIList)HttpContext.Current.Session["MyData"];
        list.Remove(khieunaiToDelete);

        HttpContext.Current.Session["MyData"] = list;

        return list;
    }


    [WebMethod(EnableSession = true)]
    public KHIEUNAI GetKHIEUNAIByPK_ID(int PK_ID)
    {
        HttpContext.Current.Session["t"] = "123";
        KHIEUNAIList list = (KHIEUNAIList)HttpContext.Current.Session["MyData"];

        return list.GetKHIEUNAIByPK_ID(PK_ID);
    }
    
}
