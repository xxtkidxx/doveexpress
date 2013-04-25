using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class module_Doanhnghiep_DautuXaydung : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridDoanhnghiep_DautuXaydung.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridDoanhnghiep_DautuXaydung.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridDoanhnghiep_DautuXaydung.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("DoanhNghieps"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        if (Request["index"] != null && Request["value"] != null)
        {
            string index = Request["index"].ToString();
            string Value = Request["value"].ToString();
        }
        if (Request.QueryString["IDDN"] != null)
        {            
        }
        else ITCLIB.Admin.JavaScript.RunScript("CancelEdit()", this);
        if (Request.QueryString["dateselect"] != null)
        {
            string dateselect = Request.QueryString["dateselect"].ToString();
            radDatareport.DbSelectedDate = DateTime.Parse(dateselect.Substring(4, 2) + "/" + dateselect.Substring(6, 2) + "/" + dateselect.Substring(0, 4) + " 12:00 AM");
        }
        else
        {
            if (!IsPostBack)
                radDatareport.DbSelectedDate = DateTime.Now;
        }
        Session["LastUrl"] = Request.Url.ToString();
    }
    protected void btnShowAll_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadGridDoanhnghiep_DautuXaydung.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridDoanhnghiep_DautuXaydung.MasterTableView.RenderColumns)
        {
            if (column is GridBoundColumn)
            {
                GridBoundColumn boundColumn = column as GridBoundColumn;
                boundColumn.CurrentFilterValue = string.Empty;
            }
            if (column is GridTemplateColumn)
            {
                GridTemplateColumn boundColumn = column as GridTemplateColumn;
                boundColumn.CurrentFilterValue = string.Empty;
            }
        }
        RadGridDoanhnghiep_DautuXaydung.MasterTableView.Rebind();
    }

    private void DisplayMessage(string text)
    {
        RadGridDoanhnghiep_DautuXaydung.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridDoanhnghiep_DautuXaydung_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }

    protected void RadGridDoanhnghiep_DautuXaydung_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            ITCLIB.Admin.SQL ac = new ITCLIB.Admin.SQL();
            if (radDatareport.DbSelectedDate == null )
            {
                SetMessage("Không có bản ghi được chọn!");
            }
            else
            {
                DateTime dateSelect = (DateTime)radDatareport.DbSelectedDate;
                string sqlTest = String.Format("DELETE FROM DOANHNGHIEP_VALUE where FK_DOANHNGHIEP={0} AND (FK_TIEUCHI IN (SELECT PK_ID  FROM   DOANHNGHIEP_TIEUCHI WHERE (C_TYPE = 'DAUTUXAYDUNG'))) AND (CONVERT(NVARCHAR(8), DOANHNGHIEP_VALUE.C_DATE, 112) = '{1}')", Request.QueryString["IDDN"], dateSelect.Year.ToString() + (dateSelect.Month > 9 ? dateSelect.Month.ToString() : "0" + dateSelect.Month.ToString()) + (dateSelect.Day > 9 ? dateSelect.Day.ToString() : "0" + dateSelect.Day.ToString()));
                if (ac.ExecuteNonQuery(sqlTest) > 0)
                {
                    SetMessage("Xóa tình hình đầu tư xây dựng doanh nghiệp thành công!");
                    ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted Doanhnghiep_DautuXaydungs", String.Format("FK_DOANHNGHIEP={0} và DATE {1}", Request.QueryString["IDDN"], dateSelect.ToShortDateString()));
                    RadGridDoanhnghiep_DautuXaydung.Rebind();
                }
                else
                {
                    SetMessage("Xóa không thành thành công!");
                }                
            }
        }
        else if (e.CommandName == "InsertChange")
        {
            DateTime dateSelect = DateTime.Now;
            if (radDatareport.SelectedDate != null)
            {
                dateSelect = (DateTime)radDatareport.DbSelectedDate;
            }
            if (Session["NEWIDDK"] != null)
            {
                SetMessage("Lưu thông tin thành công!");
                ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Doanhnghiep_DautuXaydungs", String.Format("FK_DOANHNGHIEP={0} và DATE {1}", Request.QueryString["IDDN"], dateSelect.ToShortDateString()));
                Session["NEWIDDK"] = null;
                RadGridDoanhnghiep_DautuXaydung.Rebind();
            }
        }
        else if (e.CommandName == "CancelChange")
        {
            ITCLIB.Admin.SQL ac = new ITCLIB.Admin.SQL();
            if (Session["NEWIDDK"] != null)
            {
                string sqlTest = String.Format("Delete from DOANHNGHIEP_VALUE where PK_ID IN ({0})", Session["NEWIDDK"]);
                if (ac.ExecuteNonQuery(sqlTest) > 0)
                {
                    Session["NEWIDDK"] = null;
                    RadGridDoanhnghiep_DautuXaydung.Rebind();
                }
            }
        }
        else if (e.CommandName == "InsertCode")
        {
            ITCLIB.Admin.SQL ac = new ITCLIB.Admin.SQL();
            string strDate = getdateselect(DateTime.Now);
            if (Request.QueryString["dateselect"] != null)
            {
                strDate = Request.QueryString["dateselect"].ToString();
            }
            //Kiểm tra có báo cáo thống kê ngày chọn chưa
            string sqlTest = String.Format("select DOANHNGHIEP_VALUE.* FROM DOANHNGHIEP_VALUE where DOANHNGHIEP_VALUE.FK_TIEUCHI IN (195,196) AND DOANHNGHIEP_VALUE.FK_DOANHNGHIEP={0} AND (CONVERT(NVARCHAR(8), DOANHNGHIEP_VALUE.C_DATE, 112) = '{1}')", Request.QueryString["IDDN"], strDate);
            DataTable odataTest = ac.query_data(sqlTest);
            if (odataTest.Rows.Count <= 0)
            {
                //Tự động tạo các thống kê trong ngày chọn
                string sqlTieuchi = "SELECT PK_ID FROM DOANHNGHIEP_TIEUCHI where C_TYPE ='DAUTUXAYDUNG'";
                DataTable odata = ac.query_data(sqlTieuchi);
                string sqlInssert = "";
                foreach (DataRow ors in odata.Rows)
                {
                    sqlInssert += String.Format("; Insert into DOANHNGHIEP_VALUE(FK_DOANHNGHIEP, C_DATE, FK_TIEUCHI) VALUES ({0}, '{1}', {2})", Request.QueryString["IDDN"], radDatareport.DbSelectedDate.ToString(), ors["PK_ID"]);
                }
                if (sqlInssert != "")
                {
                    if (ac.ExecuteNonQuery(sqlInssert) > 0)
                    {
                        SetMessage("Tạo thành công!");
                        ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Insert Doanhnghiep_DautuXaydungs", String.Format("FK_DOANHNGHIEP={0} và DATE {1}", Request.QueryString["IDDN"], radDatareport.DbSelectedDate.ToString()));
                        RadGridDoanhnghiep_DautuXaydung.Rebind();
                    }
                    else
                    {
                        SetMessage("Tạo không thành công!");
                    }
                }
            }
            else
            {
                SetMessage("Đã có báo cáo ngày đang chọn: " + radDatareport.DbSelectedDate.ToString());
            }
        }
    }

    protected void lblCap_PreRender(object sender, EventArgs e)
    {
        Label titile = (Label)sender;
        if (Request.QueryString ["IDDN"] != null )
        {
            string strdisplay = "TÌNH HÌNH ĐẦU TƯ XÂY DỰNG CỦA ĐƠN VỊ BÁO CÁO: " + ITCLIB.Admin.cFunction.LoadFieldfromTable(Request.QueryString["IDDN"].ToString(), "TENDOANHNGHIEP", "DOANHNGHIEP").ToUpper() ;
            DateTime dateSelect = DateTime.Now;
            if (radDatareport.SelectedDate != null)
            {
                dateSelect = (DateTime)radDatareport.DbSelectedDate;
            }
            else
            {
                radDatareport.SelectedDate = DateTime.Now;
            }
            strdisplay += String.Format(" (Dữ liệu báo cáo tạo ngày: {0})", dateSelect.ToString("dd/MM/yyyy"));
            titile.Text = strdisplay;
        }
        else { ITCLIB.Admin.JavaScript.RunScript("CancelEdit()", this); }
    }

    protected void RadGridDoanhnghiep_DautuXaydung_PreRender(object sender, EventArgs e)
    {
        //foreach (GridItem item in RadGridDoanhnghiep_DautuXaydung.MasterTableView.Items)
        //{
        //    if (item is GridEditableItem)
        //    {
        //        GridEditableItem editableItem = item as GridDataItem;
        //        editableItem.Edit = true;
        //    }
        //}
        //RadGridDoanhnghiep_DautuXaydung.Rebind();
    }
    protected void RadGridDoanhnghiep_DautuXaydung_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        if (e.AffectedRows > 0)
        {
            DateTime dateSelect = (DateTime)radDatareport.DbSelectedDate;
            SetMessage("Cập nhật tình hình đầu tư xây dựng doanh nghiệp thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Update Doanhnghiep_DautuXaydungs", String.Format("FK_DOANHNGHIEP={0} và DATE {1}", Request.QueryString["IDDN"], dateSelect.ToShortDateString()));
        }
        else
        {
            SetMessage("Cập nhật không thành công!");
        }
    }
    protected string getName(object name, string level, object header)
    {
        if(level =="1")
        {
            return String.Format("<b>{0} {1}</b>", header, name);
        }
        return String.Format("{0} {1}", header, name);
    }
    protected void RadGridDoanhnghiep_DautuXaydung_ItemDataBound(object sender, GridItemEventArgs e)
    {
        int index = e.Item.ItemIndex;
        if (e.Item is GridDataItem)
        {
            GridDataItem item = e.Item as GridDataItem;
            HiddenField hfLevel = item.FindControl("hfLevel") as HiddenField;
            UserControl ucmuasam = item.FindControl("ucmuasam") as UserControl;
            UserControl uccongtrinh = item.FindControl("uccongtrinh") as UserControl;
            Panel  paneltable = item.FindControl("paneltable") as Panel;
            if (index == 0)
            {
                uccongtrinh.Visible = true;
                ucmuasam.Visible = false;
                paneltable.Visible = true;
            }
            else
            {
                uccongtrinh.Visible = false;
                ucmuasam.Visible = true;
                paneltable.Visible = false;
            }
        }
    }
    private string getdateselect(DateTime dateSelect)
    {
        return dateSelect.Year.ToString() + (dateSelect.Month > 9 ? dateSelect.Month.ToString() : "0" + dateSelect.Month.ToString()) + (dateSelect.Day > 9 ? dateSelect.Day.ToString() : "0" + dateSelect.Day.ToString());
    }

    protected void radDatareport_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        Response.Redirect(String.Format("Popup.aspx?ctl=dndautu&IDDN={0}&dateselect={1}", Request.QueryString["IDDN"], getdateselect((DateTime)radDatareport.DbSelectedDate)));
    }
}