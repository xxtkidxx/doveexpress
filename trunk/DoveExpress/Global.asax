<%@ Application Language="C#" %>

<script runat="server">
    void Application_Start(object sender, EventArgs e) 
    {
        // Code that runs on application startup

    }   
   
    protected void Application_EndRequest(Object sender, EventArgs e) 
    {
      string authCookie = FormsAuthentication.FormsCookieName;
      foreach (string sCookie in Response.Cookies) 
      {
        if (sCookie.Equals(authCookie))
        { 
          // Force HttpOnly to be added to the cookie header
          Response.Cookies[sCookie].Path += ";HttpOnly";
        }
      }
    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs
       Exception objErr = Server.GetLastError().GetBaseException();
        // Log the error
       ITCLIB.ErrorLog.ErrorLog.WriteError(objErr.Message.ToString());   

    }
    void Session_Start(object sender, EventArgs e) 
    {
        /*long VisitCount;
        // Code that runs when a new session is started
        string SelectString = "SELECT C_VALUE FROM T_SETTING WHERE C_CODE = 'VISIT' AND FK_LANG = '0'";
        ITC.Admin.SQL SelectQuery = new ITC.Admin.SQL();
        System.Data.DataTable oDataTable;
        oDataTable = SelectQuery.query_data(SelectString);
        if (oDataTable.Rows.Count != 0)
        {
            VisitCount = long.Parse(oDataTable.Rows[0]["C_VALUE"].ToString());
        }
        else
        {
            VisitCount = 0;
        }
        VisitCount++;
        // khóa website
        Application.Lock();

        // gán biến Application count_visit
        Application["VisitCount"] = VisitCount;

        // Mở khóa website
        Application.UnLock();

        // Lưu dử liệu vào file  count_visit.txt
        string UpdateString = "UPDATE T_SETTING SET C_VALUE = " + VisitCount + " WHERE C_CODE = 'VISIT' AND FK_LANG = '0'";
        ITC.Admin.SQL UpdateQuery = new ITC.Admin.SQL();
        UpdateQuery.ExecuteNonQuery(UpdateString);*/
    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
</script>
