using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (ITCLIB.Security.Security.IsLogedIn())
        {
            Response.Redirect("Default.aspx", true);
        }
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        Page.Validate();

        if (Page.IsValid)
        {
            if (CheckValidate(ITCLIB.Admin.cFunction.KillCharsFix(txtUser.Text.Trim()), ITCLIB.Admin.cFunction.KillCharsFix(txtPass.Text.Trim())))
            {
                ITCLIB.ActionLog.ActionLog.WriteLog(txtUser.Text.Trim(), "Login", "Thành công");
                LogUser();
                if (Session["LastUrl"] == null)
                {
                    Response.Redirect("Default.aspx", true);
                }
                else
                {
                    Response.Redirect(Session["LastUrl"].ToString(), true);
                }
            }
            else
            {
                ITCLIB.Admin.JavaScript.ShowMessage("Tên đăng nhập hoặc mật khẩu không đúng", this);
            }
        }
    }
    protected void lbtnForgotPass_Click(object sender, EventArgs e)
    {
        if (pnForgotPass.Visible)
        {
            pnForgotPass.Visible = false;
        }
        else
        {
            pnForgotPass.Visible = true;
        }
    }
    protected string Login_Name;
    protected string Email;
    protected void btnForgotPass_Click(object sender, EventArgs e)
    {       
        Email = txtEmail.Text;
        StringBuilder builder = new StringBuilder();
        builder.Append(ITCLIB.Admin.CreateRandom.RandomString(4, true));
        builder.Append(ITCLIB.Admin.CreateRandom.RandomNumber(1000, 9999));
        builder.Append(ITCLIB.Admin.CreateRandom.RandomString(2, false));
        string NewPassword = builder.ToString();
        string encryptpass = ITCLIB.Security.Security.Encrypt(NewPassword);
        //Response.Write("<br>Thông tin tài khoản của bạn là:" + "<br>Tên đăng nhập: " + Login_Name + "<br>Mật khẩu: " + NewPassword);
        string UpdateSQL = "UPDATE USERS SET C_PASSWORD ='" + encryptpass + "' WHERE C_LOGINNAME ='" + Login_Name + "'";
        ITCLIB.Admin.SQL UpdateQuery = new ITCLIB.Admin.SQL();
        int result = UpdateQuery.ExecuteNonQuery(UpdateSQL);
        if (result != 0)
        {
            ITCLIB.Admin.Email.Send_Email(Email, "Email lấy lại mật khẩu", "Thông tin tài khoản của bạn là:" + "\r\nTên đăng nhập(Login name): " + Login_Name + "\r\nMật khẩu(Password): " + NewPassword);
            ITCLIB.Admin.JavaScript.ShowMessage("Mật khẩu đã được gửi tới Email của bạn", this);
        }
    }
    private ITCLIB.Security.User sUser = new ITCLIB.Security.User();
    protected bool CheckValidate(string user, string pass)
    {
        string encryptpass = ITCLIB.Security.Security.Encrypt(pass);
        string SelectSQL = "Select USERS.PK_ID,USERS.FK_GROUPUSER,USERS.C_NAME,GROUPUSER.C_TYPE FROM USERS INNER JOIN GROUPUSER ON USERS.FK_GROUPUSER = GROUPUSER.PK_ID WHERE USERS.C_LOGINNAME = '" + user + "' AND USERS.C_PASSWORD = '" + encryptpass + "'";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        Session["VUNGLAMVIEC"] = cmbVungLamViec.SelectedValue;
        ITCLIB.Security.Security.Config();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            DataRow oRow = oDataTable.Rows[0];
            sUser.UsertypeID = (int)oRow["FK_GROUPUSER"];
            sUser.Userid = (int)oDataTable.Rows[0]["PK_ID"];
            sUser.LoginName = user;
            sUser.UserName = oDataTable.Rows[0]["C_NAME"].ToString();
            //Session.Timeout = 5;
            Session["User"] = sUser;
            Session["UserID"] = (int)oDataTable.Rows[0]["PK_ID"];
            Session["GroupUser"] = (int)oDataTable.Rows[0]["FK_GROUPUSER"];
            return true;
        }
        else
        {
            return false;
        }

    }
    protected void CheckEmail(object source, ServerValidateEventArgs args)
    {
        string SelectSQL = "Select USERS.C_LOGINNAME FROM USERS WHERE USERS.C_EMAIL = '" + txtEmail.Text + "' AND USERS.C_LOGINNAME = '" + txtUser.Text + "'";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count == 0)
        {
            args.IsValid = false;
        }
        else
        {
            Login_Name = oDataTable.Rows[0]["C_LOGINNAME"].ToString();
            args.IsValid = true;
        }
    }
    protected void LogUser()
    {
        string strIP;
        strIP = Request.ServerVariables["REMOTE_ADDR"];
        string InsertSQL = "INSERT INTO USER_LOG (FK_USER, C_IP, LOGTIME) VALUES (" + sUser.Userid + ",'" + strIP + "','" + String.Format("{0:yyyy-MM-dd hh:mm:ss tt}", System.DateTime.Now.ToUniversalTime().AddHours(7)) + "')";
        ITCLIB.Admin.SQL InsertQuery = new ITCLIB.Admin.SQL();
        InsertQuery.ExecuteNonQuery(InsertSQL);
    }
    protected void cmbVungLamViec_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //cmbVungLamViec.SelectedValue = "Hà Nội";
        }
    }
    protected void CheckVungLamViec(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        SelectSQL = "Select USERS.FK_VUNGLAMVIEC FROM USERS WHERE USERS.C_LOGINNAME = N'" + txtUser.Text.Trim() + "'";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        //Session["t"] = args.Value;
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            if (oDataTable.Rows[0]["FK_VUNGLAMVIEC"].ToString() == "Tất cả")
            {
                args.IsValid = true;
            }
            else if (oDataTable.Rows[0]["FK_VUNGLAMVIEC"].ToString() == cmbVungLamViec.SelectedValue)
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }
        else
        {
            args.IsValid = false;
        }
    }

}