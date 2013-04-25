using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;

public partial class controls_Menu : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Menu.FindItemByValue("Group_Users").Visible = ITCLIB.Security.Security.IsSysAdmin();
        Menu.FindItemByValue("UserCompanys").Visible = ITCLIB.Security.Security.CanViewModule("UserCompanys");
        Menu.FindItemByValue("UserAdmins").Visible = ITCLIB.Security.Security.CanViewModule("UserAdmins");
        Menu.FindItemByValue("User_Log").Visible = ITCLIB.Security.Security.CanViewModule("User_Log");
        Menu.FindItemByValue("ActionLog").Visible = ITCLIB.Security.Security.CanViewModule("ActionLog");
        Menu.FindItemByValue("ErrorLog").Visible = ITCLIB.Security.Security.CanViewModule("ErrorLog");

        Menu.FindItemByValue("User_Pass").Visible = ITCLIB.Security.Security.CanViewModule("User_Pass");
        Menu.FindItemByValue("User_Info").Visible = ITCLIB.Security.Security.CanViewModule("User_Info");

        Menu.FindItemByValue("JobTitles").Visible = ITCLIB.Security.Security.CanViewModule("JobTitles");
        Menu.FindItemByValue("DEPTs").Visible = ITCLIB.Security.Security.CanViewModule("Depts");

        Menu.FindItemByValue("List").Visible = Menu.FindItemByValue("JobTitles").Visible || Menu.FindItemByValue("Vitriduans").Visible || Menu.FindItemByValue("Trangthaiduans").Visible || Menu.FindItemByValue("Trinhdos").Visible || Menu.FindItemByValue("Nganhnghe").Visible;
        Menu.FindItemByValue("System").Visible = Menu.FindItemByValue("Group_Users").Visible || Menu.FindItemByValue("UserAdmins").Visible || Menu.FindItemByValue("UserCompanys").Visible || Menu.FindItemByValue("User_Log").Visible || Menu.FindItemByValue("ActionLog").Visible || Menu.FindItemByValue("ErrorLog").Visible;
        Menu.FindItemByValue("User").Visible = Menu.FindItemByValue("User_Pass").Visible || Menu.FindItemByValue("User_Info").Visible;        
    }
    protected void OnCallbackUpdate(object sender, RadNotificationEventArgs e)
    {
        int newMsgs = 0;
        string SelectNotification = "Select EOF_NOTIFICATION.ref_id, EOF_NOTIFICATION.C_TYPE FROM EOF_NOTIFICATION WHERE EOF_NOTIFICATION.C_STATUS IN (0,2) AND EOF_NOTIFICATION.USER_ID=" + Session["UserID"].ToString();
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectNotification);
        if (oDataTable.Rows.Count != 0)
        {
            int textRecei = 0, textcount = 0, jobcount = 0, jobdivisincount = 0, calendercount = 0, calenderDivisioncount = 0, calenderchaircount = 0, schedConpanycount = 0;
            int[,] check = new int[7, 3] { { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 } }; 
            //0: JOb, 1:Text; 2:Sched, 3 JobDivision; 4 chủ trì lịch, 5 tham gia lịch, 6 Lịch cơ quan mới
            foreach (DataRow oRow in oDataTable.Rows)
            {
                switch (oRow["C_TYPE"].ToString())
                {
                    case "INSERT_JOB":
                        check[0,0] += 1;
                        break;
                    case "UPDATE_JOB":
                        check[0,1] += 1;
                        break;
                    case "DELETE_JOB":
                        check[0,2] += 1;
                        break;
                    case "INSERT_TEXT":
                        check[1,0] += 1;
                        break;
                    case "UPDATE_TEXT":
                        check[1,1] += 1;
                        break;
                    case "DELETE_TEXT":
                        check[1,2] += 1;
                        break;
                    case "INSERT_SCHED":
                        check[2,0] += 1;
                        break;
                    case "UPDATE_SCHED":
                        check[2,1] += 1;
                        break;
                    case "DELETE_SCHED":
                        check[2,2] += 1;
                        break;
                    case "INSERT_JOBDIVISION":
                        check[3, 0] += 1;
                        break;
                    case "UPDATE_JOBDIVISION":
                        check[3, 1] += 1;
                        break;
                    case "DELETE_JOBDIVISION":
                        check[3, 2] += 1;
                        break;
                    case "INSERT_SCHEDCT":
                        check[4, 0] += 1;
                        break;
                    case "UPDATE_SCHEDCT":
                        check[4, 1] += 1;
                        break;
                    case "DELETE_SCHEDCT":
                        check[4, 2] += 1;
                        break;
                    case "INSERT_SCHEDTG":
                        check[5, 0] += 1;
                        break;
                    case "UPDATE_SCHEDTG":
                        check[5, 1] += 1;
                        break;
                    case "DELETE_SCHEDTG":
                        check[5, 2] += 1;
                        break;
                    case "INSERT_COMPANY":
                        check[6, 0] += 1;
                        break;
                    case "UPDATE_COMPANY":
                        check[6, 1] += 1;
                        break;
                    case "DELETE_COMPANY":
                        check[6, 2] += 1;
                        break;
                    case "TEXTRECEI":
                        textRecei += 1;
                        break;
                    default:
                        break;
                } 
            }
            string strJob = "<a id=\"JobNew\" class=\"linkNotification\" href=\"Office.aspx?ctl=Jobs\">-Bạn có";
            string strText = "<a id=\"TextNew\" class=\"linkNotification\" href=\"Office.aspx?ctl=Texts\">-Bạn có";
            string strCalender = "<a id=\"CalenderNew\" class=\"linkNotification\" href=\"Office.aspx?ctl=MyScheds\">-Bạn có";
            string strJobDivision = "<a id=\"JobNew\" class=\"linkNotification\" href=\"Office.aspx?ctl=Jobs\">-Bạn có";
            string strCalenderCT = "<a id=\"CalenderChuTri\" class=\"linkNotification\" href=\"Office.aspx?ctl=CompanyScheds\">-Bạn có";
            string strCalenderTG = "<a id=\"TextNew\" class=\"linkNotification\" href=\"Office.aspx?ctl=CompanyScheds\">-Bạn có";
            string strSchedConpany = "<a id=\"TextNew\" class=\"linkNotification\" href=\"Office.aspx?ctl=CompanyScheds\">-Có";
            string strTextRecei = String.Format("<a id=\"TextRecei\" class=\"linkNotification\" href=\"Office.aspx?ctl=MyTexts&COUNT={0}\">-Bạn có {0} văn bản mới được gủi đến </a><br/>", textRecei);
            int sum = 0;
            for (int i = 0; i < 7; i++)
            {
                sum += check[i, 0] + check[i, 1] + check[i, 2];
                string strContent = "";
                switch (i)
                {
                    case 0:
                        if (check[i, 0] != 0) strContent += "(" + check[i, 0].ToString() + ") công việc mới";
                        if (check[i, 1] != 0) strContent += (strContent != "" ? "," : "") + " (" + check[i, 1].ToString() + ") công việc sửa đổi";
                        if (check[i, 2] != 0) strContent += (strContent != "" ? "," : "") + " (" + check[i, 2].ToString() + ") công việc bị hủy";
                        strJob += strContent;
                        jobcount += check[i, 0] + check[i, 1] + check[i, 2];
                        break;
                    case 1:
                        if (check[i, 0] != 0) strContent += "(" + check[i, 0].ToString() + ") văn bản mới";
                        if (check[i, 1] != 0) strContent += (strContent != "" ? "," : "") + " (" + check[i, 1].ToString() + ") văn bản sửa đổi";
                        if (check[i, 2] != 0) strContent += (strContent != "" ? "," : "") + " (" + check[i, 2].ToString() + ") văn bản bị hủy";
                        strText += strContent;
                        textcount += check[i, 0] + check[i, 1] + check[i, 2];
                        break;
                    case 2:
                        if (check[i, 0] != 0) strContent += "(" + check[i, 0].ToString() + ") lịch mới";
                        if (check[i, 1] != 0) strContent += (strContent != "" ? "," : "") + " (" + check[i, 1].ToString() + ") lịch sửa đổi";
                        if (check[i, 2] != 0) strContent += (strContent != "" ? "," : "") + " (" + check[i, 2].ToString() + ") lịch bị hủy";
                        strCalender += strContent;
                        calendercount += check[i, 0] + check[i, 1] + check[i, 2];
                        break;
                    case 3:
                        if (check[i, 0] != 0) strContent += "(" + check[i, 0].ToString() + ") công việc cần tham gia";
                        if (check[i, 1] != 0) strContent += (strContent != "" ? "," : "") + " (" + check[i, 1].ToString() + ") công việc tham gia";
                        if (check[i, 2] != 0) strContent += (strContent != "" ? "," : "") + " (" + check[i, 2].ToString() + ") công việc bị bủy";
                        strJobDivision += strContent;
                        jobdivisincount += check[i, 0] + check[i, 1] + check[i, 2];
                        break;
                    case 4:
                        if (check[i, 0] != 0) strContent += "(" + check[i, 0].ToString() + ") lịch chủ trì";
                        if (check[i, 1] != 0) strContent += (strContent != "" ? "," : "") + " (" + check[i, 1].ToString() + ") lịch chủ trì sửa đổi";
                        if (check[i, 2] != 0) strContent += (strContent != "" ? "," : "") + " (" + check[i, 2].ToString() + ") lịch chủ trì bị hủy";
                        strCalenderCT += strContent;
                        calenderchaircount += check[i, 0] + check[i, 1] + check[i, 2];
                        break;
                    case 5:
                        if (check[i, 0] != 0) strContent += "(" + check[i, 0].ToString() + ") lịch tham gia";
                        if (check[i, 1] != 0) strContent += (strContent != "" ? ", " : "") + "(" + check[i, 1].ToString() + ") lịch tham gia sửa đổi";
                        if (check[i, 2] != 0) strContent += (strContent != "" ? ", " : "") + "(" + check[i, 2].ToString() + ") lich  tham gia bị hủy";
                        strCalenderTG += strContent;
                        calenderDivisioncount += check[i, 0] + check[i, 1] + check[i, 2];
                        break;
                    case 6:
                        if (check[i, 0] != 0) strContent += "(" + check[i, 0].ToString() + ") lịch công tác mới";
                        if (check[i, 1] != 0) strContent += (strContent != "" ? ", " : "") + "(" + check[i, 1].ToString() + ") lịch công tác sửa đổi";
                        if (check[i, 2] != 0) strContent += (strContent != "" ? ", " : "") + "(" + check[i, 2].ToString() + ") lịch công tác bị hủy";
                        strSchedConpany += strContent;
                        schedConpanycount += check[i, 0] + check[i, 1] + check[i, 2];
                        break;
                }
            }
            strJob += ".</a><br/>";
            strText += ".</a><br/>";
            strCalender += ".</a><br/>";
            strJobDivision += ".</a><br/>";
            strCalenderCT += ".</a><br/>";
            strCalenderTG += ".</a><br/>";
            strSchedConpany += ".</a><br/>";  
            if (jobcount != 0) areThongbao.Text += strJob;
            if (jobdivisincount != 0) areThongbao.Text += strJobDivision;
            if (textcount != 0) areThongbao.Text += strText;
            if (textRecei != 0) areThongbao.Text += strTextRecei;
            if (calendercount != 0) areThongbao.Text += strCalender;
            if (calenderDivisioncount != 0) areThongbao.Text += strCalenderTG;
            if (calenderchaircount != 0) areThongbao.Text += strCalenderCT;
            if (schedConpanycount != 0) areThongbao.Text += strSchedConpany;
            newMsgs = sum + textRecei;
        }
        SendEmail_Notification();
        RadNotificationOffice.Value = newMsgs.ToString();
    }
    protected void btnDownloadTextFile_Click(object sender, EventArgs e)
    {
        string DeleteNotification = "DELETE FROM EOF_NOTIFICATION WHERE EOF_NOTIFICATION.USER_ID=" + Session["UserID"].ToString();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        SelectQuery.ExecuteNonQuery(DeleteNotification);
    }
    protected static string listID = "";
    protected void OnCallbackReminder(object sender, RadNotificationEventArgs e)
    {
        int newMsgs = 0;
        string schedes = "";
        if (Session["IsDeleteReminder"] == null)
        {
            string idUserCurent = Session["UserID"].ToString();
            string SelectNotification = String.Format("SELECT PK_ID, Start, c_reminder, Subject,FK_USER,isNotification, " +
                          " CASE WHEN (c_idchairperson LIKE '%,{0},%' OR c_idchairperson LIKE '%,{0}' OR c_idchairperson LIKE '{0},%') AND (c_idparticipants LIKE '%,{0},%' OR c_idparticipants LIKE '%,{0}' OR c_idparticipants LIKE '{0},%') THEN N'Chủ trì và tham gia' " +
                          " ELSE CASE WHEN (c_idchairperson LIKE '%,{0},%' OR c_idchairperson LIKE '%,{0}' OR c_idchairperson LIKE '{0},%') THEN N'Lịch chủ trì' " +
                          " ELSE CASE WHEN (c_idparticipants LIKE '%,{0},%' OR c_idparticipants LIKE '%,{0}' OR c_idparticipants LIKE '{0},%') THEN N'Lịch tham gia' " +
                          " ELSE CASE WHEN FK_USER = {0} THEN N'Lịch cá nhân' ELSE 'NO' END END END END AS SCHEDTYPE " +
                          " FROM EOF_COMPANY_SCHED AS SCHED_CHUTRI WHERE (isNotification IS NULL) OR (isNotification = 0)", idUserCurent);
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectNotification);
            string reminder = "0";
            if (oDataTable.Rows.Count != 0)
            {
                for (int i = 0; i < oDataTable.Rows.Count; i++)
                {
                    if (oDataTable.Rows[i]["SCHEDTYPE"].ToString() != "NO")
                    {
                        DateTime timeStart = (DateTime)oDataTable.Rows[i]["START"];
                        reminder = oDataTable.Rows[i]["C_REMINDER"] != DBNull.Value ? oDataTable.Rows[i]["C_REMINDER"].ToString() : "0";
                        int timeReminder = getPhutReminder(reminder);
                        if (DateTime.Now.CompareTo(timeStart.AddMinutes(0 - timeReminder)) >= 0 && DateTime.Now.CompareTo(timeStart.AddMinutes(30)) <= 0)
                        {
                            //Sau qua 30p thì không nhắc nhở nữa
                            if (checkTypeReminder(reminder, "Popup"))
                            {
                                if (oDataTable.Rows[i]["isNotification"].ToString() != "1")
                                {
                                    //isNotification == 1 'Đã tắt tính năng nhắc nhở bằng Popup'
                                    newMsgs++;
                                    string ctr = "ListMySched&idSched=" + oDataTable.Rows[i]["PK_ID"].ToString();
                                    if (oDataTable.Rows[i]["FK_USER"].ToString() == "0")
                                    {
                                        ctr = "ListCompanySched&idSched=" + oDataTable.Rows[i]["PK_ID"].ToString();
                                    }
                                    else if (oDataTable.Rows[i]["FK_USER"].ToString() != idUserCurent)
                                    {
                                        ctr = "ListPersonSched&IDPERSON=" + oDataTable.Rows[i]["FK_USER"].ToString();
                                    }
                                    else
                                    {
                                        listID = ITCLIB.Admin.cFunction.GetStringForList(oDataTable.Rows[i]["PK_ID"].ToString(), listID, ',');
                                        ctr = "ListMySched&idSched=" + oDataTable.Rows[i]["PK_ID"].ToString();
                                    }
                                    schedes += String.Format("<a id=\"reminder{0}\" class=\"linkNotification\" href=\"Office.aspx?ctl={1}\">-{2}: {3}. Bắt đầu lúc: {4} </a><br/>", oDataTable.Rows[i]["PK_ID"].ToString(), ctr, oDataTable.Rows[i]["SCHEDTYPE"].ToString(), oDataTable.Rows[i]["Subject"].ToString(), timeStart.ToString());
                                }
                            }
                        }
                    }
                }
            }
        }
        area.Text = schedes;
        SendEmail_Reminder();
        RadNotificationReminder.Value = newMsgs.ToString();
    }
    protected void SendEmail_Reminder()
    {
        string SelectNotification = "Select * FROM EOF_COMPANY_SCHED WHERE (IsSendEmail IS NULL OR isSendEmail = 0)";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectNotification);
        string reminder = "0";
        if (oDataTable.Rows.Count != 0)
        {
            for (int i = 0; i < oDataTable.Rows.Count; i++)
            {
                DateTime timeStart = (DateTime)oDataTable.Rows[i]["START"];
                reminder = oDataTable.Rows[i]["C_REMINDER"].ToString();
                int timeReminder = getPhutReminder(reminder);
                if (DateTime.Now.CompareTo(timeStart.AddMinutes(0 - timeReminder)) >= 0 && DateTime.Now.CompareTo(timeStart.AddMinutes(30)) <= 0)
                {
                    if (checkTypeReminder(reminder, "Email"))
                    {
                        //Gửi Email cho DS tham gia, DS chủ trì và ng có lịch
                        string listthamgia = oDataTable.Rows[i]["c_idparticipants"] != null ? oDataTable.Rows[i]["c_idparticipants"].ToString() : "";
                        string listchutri = oDataTable.Rows[i]["c_idchairperson"] != null ? oDataTable.Rows[i]["c_idchairperson"].ToString() : "";
                        if (listchutri != "")
                        {
                            string[] idUsers = listchutri.Split(',');
                            foreach (string idUser in idUsers)
                            {
                                string strEmail = ITCLIB.Admin.cFunction.LoadFieldfromTable(idUser, "c_email", "USERS");
                                if (strEmail != "")
                                {
                                    string strTitle = String.Format("PHẦN MỀM CLOUD.EOFFICE_NHẮC NHỞ LỊCH CHỦ TRÌ ({0})", strEmail);
                                    string strcontent = " Bạn chủ trì lịch :" + oDataTable.Rows[i]["Subject"].ToString() + ". Bắt đầu từ :" + oDataTable.Rows[i]["Start"].ToString() + " đến " + oDataTable.Rows[i]["Ends"].ToString();
                                    strcontent += oDataTable.Rows[i]["Description"] != DBNull.Value ? "<br/> Địa điểm: " + oDataTable.Rows[i]["Description"].ToString() : "";
                                    ITCLIB.Admin.Email.Send_Email(strEmail, strTitle, strcontent, "QUẢN TRỊ CLOUD.EOFFICE", true);
                                }
                            }
                        }
                        if (listthamgia != "")
                        {
                            string[] idUsers = listthamgia.Split(',');
                            foreach (string idUser in idUsers)
                            {
                                string strEmail = ITCLIB.Admin.cFunction.LoadFieldfromTable(idUser, "c_email", "USERS");
                                if (strEmail != "")
                                {
                                    string strTitle = String.Format("PHẦN MỀM CLOUD.EOFFICE_NHẮC NHỞ LỊCH THAM GIA ({0})", strEmail);
                                    string strcontent = " Bạn tham gia lịch :" + oDataTable.Rows[i]["Subject"].ToString() + ". Bắt đầu từ :" + oDataTable.Rows[i]["Start"].ToString() + " đến " + oDataTable.Rows[i]["Ends"].ToString();
                                    strcontent += oDataTable.Rows[i]["Description"] != DBNull.Value ? "<br/> Địa điểm: " + oDataTable.Rows[i]["Description"].ToString() : "";
                                    ITCLIB.Admin.Email.Send_Email(strEmail, strTitle, strcontent, "QUẢN TRỊ CLOUD.EOFFICE", true);
                                }
                            }
                        }
                        if (oDataTable.Rows[i]["fk_user"].ToString() == "0")
                        {
                            string strEmail = ITCLIB.Admin.cFunction.LoadFieldfromTable(oDataTable.Rows[i]["fk_user"].ToString(), "c_email", "USERS");
                            if (strEmail != "")
                            {
                                string strTitle = String.Format("PHẦN MỀM CLOUD.EOFFICE_NHẮC NHỞ LỊCH CÁ NHÂN ({0})", strEmail);
                                string strcontent = " Bạn có lịch làm việc mới :" + oDataTable.Rows[i]["Subject"].ToString() + ". Bắt đầu từ :" + oDataTable.Rows[i]["Start"].ToString() + " đến " + oDataTable.Rows[i]["Ends"].ToString();
                                strcontent += oDataTable.Rows[i]["Description"] != DBNull.Value ? "<br/> Địa điểm: " + oDataTable.Rows[i]["Description"].ToString() : "";
                                ITCLIB.Admin.Email.Send_Email(strEmail, strTitle, strcontent, "QUẢN TRỊ CLOUD.EOFFICE", true);
                            }
                        }
                        string UpdateReminder = String.Format("UPDATE EOF_COMPANY_SCHED SET isSendEmail = 1 WHERE PK_ID={0}", oDataTable.Rows[i]["PK_ID"].ToString());
                        SelectQuery.ExecuteNonQuery(UpdateReminder);
                    }
                }
            }
        }
    }
    protected void SendEmail_Notification()
    {
        string url = Request.Url.ToString();
        string headerUrl = url.Split('?')[0];
        string strJob = "<a id=\"JobNew\" class=\"linkNotification\" href=\""+headerUrl+"?ctl=Jobs\">Đăng nhập vào hệ thống để xem chi tiết</a><br/>";
        string strCalender = "<a id=\"CalenderNew\" class=\"linkNotification\" href=\"" + headerUrl + "?ctl=MyScheds\">Đăng nhập vào hệ thống để xem chi tiết</a><br/>";
        string strJobDivision = "<a id=\"JobNew\" class=\"linkNotification\" href=\"" + headerUrl + "?ctl=Jobs\">Đăng nhập vào hệ thống để xem chi tiết</a><br/>";
        string strCalenderCT = "<a id=\"CalenderNew\" class=\"linkNotification\" href=\"" + headerUrl + "?ctl=CompanyScheds\">Đăng nhập vào hệ thống để xem chi tiết</a><br/>";
        string strCalenderTG = "<a id=\"TextNew\" class=\"linkNotification\" href=\"" + headerUrl + "?ctl=CompanyScheds\">Đăng nhập vào hệ thống để xem chi tiết</a><br/>";
        string strCompanySched = "<a id=\"ConpanySchedNew\" class=\"linkNotification\" href=\"" + headerUrl + "?ctl=CompanyScheds\">Đăng nhập vào hệ thống để xem chi tiết</a><br/>";

        string strTextRecei = String.Format("<a id=\"TextRecei\" class=\"linkNotification\" href=\"" + headerUrl + "?ctl=MyTexts&COUNT=1\">Đăng nhập vào hệ thống để xem chi tiết</a><br/>");
        string SelectNotification = "Select * FROM EOF_NOTIFICATION WHERE C_STATUS IN (1,2) and IsSendEmail <> 1";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectNotification);
        string listID = "";
        string strTittle = "Thông báo từ CloudOffice";
        string strBody = "";
        if (oDataTable.Rows.Count != 0)
        {
            foreach (DataRow oRow in oDataTable.Rows)
            {
                listID = listID == "" ? oRow["PK_ID"].ToString() : listID + "," + oRow["PK_ID"].ToString();
                string strEmail = ITCLIB.Admin.cFunction.LoadFieldfromTable(oRow["user_id"] != null ? oRow["user_id"].ToString() : "0", "c_email", "USERS");
                if (strEmail != "")
                {
                    switch (oRow["C_TYPE"].ToString())
                    {
                        case "INSERT_JOB":
                            strBody = "Bạn chủ trì công việc mới: <br/>";
                            strBody += strJob;
                            break;
                        case "UPDATE_JOB":
                            strBody = "Công việc bạn chủ trì có thay đổi từ hệ thống: <br/>";
                            strBody += strJob;
                            break;
                        case "DELETE_JOB":
                            strBody = "Công việc bạn chủ trì bị hủy: <br/>";
                            strBody += strJob;
                            break;
                        case "INSERT_SCHED":
                            strBody = "Bạn có lịch mới: <br/>";
                            strBody += strCalender;
                            break;
                        case "UPDATE_SCHED":
                            strBody = "Bạn có lịch thay đổi từ hệ thống : <br/>";
                            strBody += strCalender;
                            break;
                        case "DELETE_SCHED":
                            strBody = "Bạn có lịch bị hủy từ hệ thống : <br/>";
                            strBody += strCalender;
                            break;
                        case "INSERT_JOBDIVISION":
                            strBody = "Bạn được phân công tham gia công việc mới: <br/>";
                            strBody += strJobDivision;
                            break;
                        case "UPDATE_JOBDIVISION":
                            strBody = "Công việc bạn được phân công tham gia có thay đổi: <br/>";
                            strBody += strJobDivision;
                            break;
                        case "DELETE_JOBDIVISION":
                            strBody = "Công việc bạn được phân công tham gia bị hủy: <br/>";
                            strBody += strJobDivision;
                            break;
                        case "INSERT_SCHEDCT":
                            strBody = "Bạn chủ trì lịch mới trong cơ quan: <br/>";
                            strBody += strCalenderCT;
                            break;
                        case "UPDATE_SCHEDCT":
                            strBody = "Lịch bạn chủ trì có thay đổi từ hệ thống: <br/>";
                            strBody += strCalenderCT;
                            break;
                        case "DELETE_SCHEDCT":
                            strBody = "Lịch bạn chủ trì bị hủy từ hệ thốngi: <br/>";
                            strBody += strCalenderCT;
                            break;
                        case "INSERT_SCHEDTG":
                            strBody = "Bạn có tham gia lịch mới trong cơ quan: <br/>";
                            strBody += strCalenderTG;
                            break;
                        case "UPDATE_SCHEDTG":
                            strBody = "Lịch bạn tham gia có thay đổi từ hệ thống: <br/>";
                            strBody += strCalenderTG;
                            break;
                        case "DELETE_SCHEDTG":
                            strBody = "Lịch bạn tham gia bị hủy từ hệ thống: <br/>";
                            strBody += strCalenderTG;
                            break;
                        case "INSERT_COMPANY":
                            strBody = "Đã có lịch công tác mới: <br/>";
                            strBody += strCompanySched;
                            break;
                        case "UPDATE_COMPANY":
                            strBody = "Có lịch công tác sửa đổi: <br/>";
                            strBody += strCompanySched;
                            break;
                        case "DELETE_COMPANY":
                            strBody = "Đã có lịch công tác bị hủy: <br/>";
                            strBody += strCompanySched;
                            break;
                        case "TEXTRECEI":
                            strBody = "Có văn bản gửi tới: <br/>";
                            strBody += strTextRecei;
                            break;
                    }
                    ITCLIB.Admin.Email.Send_Email(strEmail, strTittle, strBody, "", true);
                }
                if (listID != "")
                {
                    string SetIsSendEmailTrue = String.Format("Update EOF_NOTIFICATION Set IsSendEmail =1 WHERE PK_ID in ({0})", listID);
                    SelectQuery.ExecuteNonQuery(SetIsSendEmailTrue);
                }
            }
        }
    }
    protected void btnDeleteReminder_Click(object sender, EventArgs e)
    {
        Session["IsDeleteReminder"] = "TRUE";
        if (listID != "")
        {
            string[] ids = listID.Split(',');
            foreach (string id in ids)
            {
                string UpdateReminder = String.Format("UPDATE EOF_COMPANY_SCHED SET isNotification = 1 WHERE PK_ID={0}", id);
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                SelectQuery.ExecuteNonQuery(UpdateReminder);
            }
        }
    }
    protected static int getPhutReminder(string iReminder)
    {
        if (iReminder != "")
        {
            string[] eles = iReminder.Split(',');
            return Int32.Parse(eles[0]);
        }
        else { return 0;}
    }
    protected static bool checkTypeReminder(string iReminder, string type)
    {
        if (iReminder != "")
        {
            if (iReminder.IndexOf(type) != -1)
             return true; 
            else return false;
        }
        else { return false; }
    }

}