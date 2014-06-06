using ITCLIB.BAOGIA;
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
public class MyWebServiceBG : System.Web.Services.WebService
{

    BAOGIAList baogiaList = null;
    public MyWebServiceBG()
    {
        baogiaList = new BAOGIAList();

        if (HttpContext.Current.Session["MyDataBAOGIA"] == null)
        {
            HttpContext.Current.Session["MyDataBAOGIA"] = baogiaList;
        }
    }

    [WebMethod(EnableSession = true)]
    public BAOGIAList UpdateBAOGIAByBAOGIA(BAOGIA baogia)
    {
        BAOGIA baogiaToUpdate = GetBAOGIAByPK_ID(baogia.PK_ID);

        BAOGIAList list = (BAOGIAList)HttpContext.Current.Session["MyDataBAOGIA"];
        bool CheckInsert = false;
        if (baogiaToUpdate == null)
        {
            CheckInsert = true;
            baogiaToUpdate = new BAOGIA();
        }
        baogiaToUpdate.C_CODE = baogia.C_CODE;
        baogiaToUpdate.C_DATE = baogia.C_DATE;
        baogiaToUpdate.FK_KHACHHANG = baogia.FK_KHACHHANG;
        baogiaToUpdate.C_TENKH = baogia.C_TENKH;
        baogiaToUpdate.C_SDT = baogia.C_SDT;
        baogiaToUpdate.C_NOIDUNG = baogia.C_NOIDUNG;
        baogiaToUpdate.FK_NGUOITAO = baogia.FK_NGUOITAO;
        baogiaToUpdate.C_STATUS = baogia.C_STATUS;
        string UpdateSQL = "";
        ITCLIB.Admin.SQL UpdateQuery = new ITCLIB.Admin.SQL();
        if (CheckInsert)
        {
            UpdateSQL = "INSERT INTO [BAOGIA] ([C_CODE], [C_DATE], [FK_KHACHHANG], [C_TENKH], [C_SDT], [C_NOIDUNG], [FK_NGUOITAO], [C_STATUS]) VALUES ('" + baogia.C_CODE + "', '" + String.Format("{0:yyyy-MM-dd hh:mm:ss tt}", baogia.C_DATE.ToUniversalTime().AddHours(7)) + "', N'" + baogia.FK_KHACHHANG + "', N'" + baogia.C_TENKH + "', N'" + baogia.C_SDT + "', N'" + baogia.C_NOIDUNG + "', N'" + baogia.FK_NGUOITAO + "', N'" + baogia.C_STATUS + "');SELECT @@IDENTITY";
            //Session["t"] = UpdateSQL;
            baogiaToUpdate.PK_ID = int.Parse(UpdateQuery.ExecuteScalar(UpdateSQL).ToString());
            list.Add(baogiaToUpdate);
        }
        else
        {
            UpdateSQL = "UPDATE [BAOGIA] SET [C_CODE] = '" + baogia.C_CODE + "', [C_DATE] = '" + String.Format("{0:yyyy-MM-dd hh:mm:ss tt}", baogia.C_DATE.ToUniversalTime().AddHours(7)) + "', [FK_KHACHHANG] = N'" + baogia.FK_KHACHHANG + "', [C_TENKH] = N'" + baogia.C_TENKH + "', [C_SDT] = N'" + baogia.C_SDT + "', [C_NOIDUNG] = N'" + baogia.C_NOIDUNG + "', [FK_NGUOITAO] = N'" + baogia.FK_NGUOITAO + "', [C_STATUS] = N'" + baogia.C_STATUS + "' WHERE [PK_ID] = " + baogia.PK_ID;
            //Session["t"] = UpdateSQL;
            UpdateQuery.ExecuteNonQuery(UpdateSQL);
        }
        HttpContext.Current.Session["MyDataBAOGIA"] = list;
        return list;
    }

    [WebMethod(EnableSession = true)]
    public BAOGIAList DeleteBAOGIAByPK_ID(int PK_ID)
    {
        BAOGIA baogiaToDelete = GetBAOGIAByPK_ID(PK_ID);
        BAOGIAList list = (BAOGIAList)HttpContext.Current.Session["MyDataBAOGIA"];
        list.Remove(baogiaToDelete);
        HttpContext.Current.Session["MyDataBAOGIA"] = list;
        string DeleteSQL = "DELETE FROM BAOGIA WHERE PK_ID = " + PK_ID + ";DELETE FROM BAOGIAGIAIQUYET WHERE FK_BAOGIA = " + PK_ID;
        ITCLIB.Admin.SQL DeleteQuery = new ITCLIB.Admin.SQL();
        DeleteQuery.ExecuteNonQuery(DeleteSQL);
        return list;
    }


    [WebMethod(EnableSession = true)]
    public BAOGIA GetBAOGIAByPK_ID(int PK_ID)
    {
        BAOGIAList list = (BAOGIAList)HttpContext.Current.Session["MyDataBAOGIA"];
        return list.GetBAOGIAByPK_ID(PK_ID);
    }
    [WebMethod]
    public string GetServerTime()
    {
        string serverTime =
        String.Format("The current time is {0}.", DateTime.Now);
        return serverTime;
    }

}
