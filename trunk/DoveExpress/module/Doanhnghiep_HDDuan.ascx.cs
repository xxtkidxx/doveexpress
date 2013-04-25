using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;

public partial class module_Doanhnghiep_HDDuan : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridDoanhnghiepHDDuan.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridDoanhnghiepHDDuan.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridDoanhnghiepHDDuan.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
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
        if (Request.QueryString["IDDN"] == null)
            ITCLIB.Admin.JavaScript.RunScript("CancelEdit()", this);
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
        RadGridDoanhnghiepHDDuan.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridDoanhnghiepHDDuan.MasterTableView.RenderColumns)
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
        RadGridDoanhnghiepHDDuan.MasterTableView.Rebind();
    }

    private void DisplayMessage(string text)
    {
        RadGridDoanhnghiepHDDuan.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridDoanhnghiepHDDuan_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridDoanhnghiepHDDuan_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            ITCLIB.Admin.SQL ac = new ITCLIB.Admin.SQL();
            if (radDatareport.DbSelectedDate == null)
            {
                SetMessage("Không có bản ghi được chọn!");
            }
            else
            {
                DateTime dateSelect = (DateTime)radDatareport.DbSelectedDate;
                string sqlTest = String.Format("DELETE FROM DOANHNGHIEP_VALUE where FK_DOANHNGHIEP={0} AND (FK_TIEUCHI IN (SELECT PK_ID  FROM   DOANHNGHIEP_TIEUCHI WHERE (C_TYPE = 'HDDUAN'))) AND (CONVERT(NVARCHAR(8), DOANHNGHIEP_VALUE.C_DATE, 112) = '{1}')", Request.QueryString["IDDN"], dateSelect.Year.ToString() + (dateSelect.Month > 9 ? dateSelect.Month.ToString() : "0" + dateSelect.Month.ToString()) + (dateSelect.Day > 9 ? dateSelect.Day.ToString() : "0" + dateSelect.Day.ToString()));
                if (ac.ExecuteNonQuery(sqlTest) > 0)
                {
                    SetMessage("Xóa tình hình hoạt động của dự án thành công!");
                    ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted DoanhnghiepHDDuans", String.Format("FK_DOANHNGHIEP={0} và DATE {1}", Request.QueryString["IDDN"], dateSelect.ToShortDateString()));
                    RadGridDoanhnghiepHDDuan.Rebind();
                }
                else
                {
                    SetMessage("Xóa không thành thành công!");
                }
            }
        }
        else if (e.CommandName == RadGrid.PerformInsertCommandName)
        {
        }
        else if (e.CommandName == "InsertCode")
        {
            ITCLIB.Admin.SQL ac = new ITCLIB.Admin.SQL();
            DateTime dateSelect = DateTime.Now;
            if (radDatareport.SelectedDate != null)
            {
                dateSelect = (DateTime)radDatareport.DbSelectedDate;
            }
            else
            {
                radDatareport.SelectedDate = DateTime.Now;
            }
            //Kiểm tra có báo cáo thống kê ngày chọn chưa
            string sqlTest = String.Format("select DOANHNGHIEP_VALUE.* FROM DOANHNGHIEP_VALUE inner join DOANHNGHIEP_TIEUCHI on DOANHNGHIEP_TIEUCHI.PK_ID =DOANHNGHIEP_VALUE.FK_TIEUCHI where DOANHNGHIEP_VALUE.FK_DOANHNGHIEP={0} AND DOANHNGHIEP_TIEUCHI.C_TYPE ='HDDUAN' AND (CONVERT(NVARCHAR(8), DOANHNGHIEP_VALUE.C_DATE, 112) = '{1}')", Request.QueryString["IDDN"], dateSelect.Year.ToString() + (dateSelect.Month > 9 ? dateSelect.Month.ToString() : "0" + dateSelect.Month.ToString()) + (dateSelect.Day > 9 ? dateSelect.Day.ToString() : "0" + dateSelect.Day.ToString()));
            DataTable odataTest = ac.query_data(sqlTest);
            if (odataTest.Rows.Count <= 0)
            {
                //Tự động tạo các thống kê trong ngày chọn
                string sqlTieuchi = "SELECT PK_ID FROM DOANHNGHIEP_TIEUCHI where C_TYPE ='HDDUAN'";
                DataTable odata = ac.query_data(sqlTieuchi);
                string sqlInssert = "";
                foreach (DataRow ors in odata.Rows)
                {
                    sqlInssert += String.Format("; Insert into DOANHNGHIEP_VALUE(FK_DOANHNGHIEP, C_DATE, FK_TIEUCHI) VALUES ({0}, '{1}', {2})", Request.QueryString["IDDN"], dateSelect, ors["PK_ID"]);
                }
                if (sqlInssert != "")
                {
                    if (ac.ExecuteNonQuery(sqlInssert) > 0)
                    {
                        SetMessage("Tạo thành công!");
                        ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Insert DoanhnghiepHDDuans", String.Format("FK_DOANHNGHIEP={0} và DATE {1}", Request.QueryString["IDDN"], dateSelect.ToShortDateString()));
                        RadGridDoanhnghiepHDDuan.Rebind();
                    }
                    else
                    {
                        SetMessage("Tạo không thành công!");
                    }
                }
            }
            else
            {
                SetMessage("Đã có báo cáo ngày đang chọn: " + dateSelect.ToShortDateString());
            }
        }
    }

    protected void lblCap_PreRender(object sender, EventArgs e)
    {
        Label titile = (Label)sender;
        if (Request.QueryString["IDDN"] != null)
        {
            string strdisplay = "TÌNH HÌNH HOẠT ĐỘNG CỦA DỰ ÁN: " + ITCLIB.Admin.cFunction.LoadFieldfromTable(Request.QueryString["IDDN"].ToString(), "TENDOANHNGHIEP", "DOANHNGHIEP").ToUpper();
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

    protected void RadGridDoanhnghiepHDDuan_PreRender(object sender, EventArgs e)
    {
        foreach (GridItem item in RadGridDoanhnghiepHDDuan.MasterTableView.Items)
        {
            if (item is GridEditableItem)
            {
                GridEditableItem editableItem = item as GridDataItem;
                editableItem.Edit = true;
            }
        }
        RadGridDoanhnghiepHDDuan.Rebind();
    }
    protected void RadGridDoanhnghiepHDDuan_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        if (e.AffectedRows > 0)
        {
            DateTime dateSelect = (DateTime)radDatareport.DbSelectedDate;
            string codeitem = e.Item.GetDataKeyValue("C_CODE").ToString().Trim();
            int table = int.Parse(e.Item.GetDataKeyValue("C_TABLE").ToString().Trim());
            string idate = dateSelect.Year.ToString() + (dateSelect.Month > 9 ? dateSelect.Month.ToString() : "0" + dateSelect.Month.ToString()) + (dateSelect.Day > 9 ? dateSelect.Day.ToString() : "0" + dateSelect.Day.ToString());
            if (table == 1)
            {
                if (codeitem == "04")
                {
                    int valuetong1 = ITCLIB.Admin.cFunction.getValueFromCodeandType("HDDUAN", "01", Request.QueryString["IDDN"], idate, "VALUE1", table) - ITCLIB.Admin.cFunction.getValueFromCodeandType("HDDUAN", "02", Request.QueryString["IDDN"], idate, "VALUE1", table);
                    ITCLIB.Admin.cFunction.UpdateValueTong("HDDUAN", codeitem, Request.QueryString["IDDN"], idate, valuetong1, "VALUE1", table);
                }
                else if (codeitem == "08")
                {
                    ITCLIB.Admin.cFunction.UpdateValueTong("HDDUAN", "08", Request.QueryString["IDDN"], idate, 0, "VALUE1", table);
                }
                else if (codeitem == "09" || codeitem == "10" || codeitem == "11")
                {
                    //Update tổng cả 4 cột
                    int valuetong1 = ITCLIB.Admin.cFunction.getValueFromCodeandType("HDDUAN", "08", Request.QueryString["IDDN"], idate, "VALUE1", table) + ITCLIB.Admin.cFunction.getValueFromCodeandType("HDDUAN", codeitem, Request.QueryString["IDDN"], idate, "VALUE1", table);
                    ITCLIB.Admin.cFunction.UpdateValueTong("HDDUAN", "08", Request.QueryString["IDDN"], idate, valuetong1, "VALUE1", table);
                }
            }
            else if (table == 2)
            {
                if (codeitem == "01")
                {
                    ITCLIB.Admin.cFunction.UpdateValueTong("HDDUAN", "01", Request.QueryString["IDDN"], idate, 0, "VALUE2", table);
                    ITCLIB.Admin.cFunction.UpdateValueTong("HDDUAN", "01", Request.QueryString["IDDN"], idate, 0, "VALUE3", table);
                    ITCLIB.Admin.cFunction.UpdateValueTong("HDDUAN", "01", Request.QueryString["IDDN"], idate, 0, "VALUE4", table);
                }
                else if (codeitem == "02" || codeitem == "03" || codeitem == "04" || codeitem == "05" || codeitem == "06" || codeitem == "07")
                {
                    //Update tổng cả 3 cột : 7,8,9
                    int valuetong1 = ITCLIB.Admin.cFunction.getValueFromCodeandType("HDDUAN", "01", Request.QueryString["IDDN"], idate, "VALUE2", table) + ITCLIB.Admin.cFunction.getValueFromCodeandType("HDDUAN", codeitem, Request.QueryString["IDDN"], idate, "VALUE2", table);
                    ITCLIB.Admin.cFunction.UpdateValueTong("HDDUAN", "01", Request.QueryString["IDDN"], idate, valuetong1, "VALUE2", table);
                    int valuetong2 = ITCLIB.Admin.cFunction.getValueFromCodeandType("HDDUAN", "01", Request.QueryString["IDDN"], idate, "VALUE3", table) + ITCLIB.Admin.cFunction.getValueFromCodeandType("HDDUAN", codeitem, Request.QueryString["IDDN"], idate, "VALUE3", table);
                    ITCLIB.Admin.cFunction.UpdateValueTong("HDDUAN", "01", Request.QueryString["IDDN"], idate, valuetong2, "VALUE3", table);
                    int valuetong3 = ITCLIB.Admin.cFunction.getValueFromCodeandType("HDDUAN", "01", Request.QueryString["IDDN"], idate, "VALUE4", table) + ITCLIB.Admin.cFunction.getValueFromCodeandType("HDDUAN", codeitem, Request.QueryString["IDDN"], idate, "VALUE4", table);
                    ITCLIB.Admin.cFunction.UpdateValueTong("HDDUAN", "01", Request.QueryString["IDDN"], idate, valuetong3, "VALUE4", table);
                }
            }
            SetMessage("Cập nhật tình hình hoạt động của dự án thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Update DoanhnghiepHDDuans", String.Format("FK_DOANHNGHIEP={0} và DATE {1}", Request.QueryString["IDDN"], dateSelect.ToShortDateString()));
        }
        else
        {
            SetMessage("Cập nhật không thành công!");
        }
    }
    protected string getName(object name, string level, object header)
    {
        if (level == "1")
        {
            return String.Format("<b>{0} {1}</b>", header, name);
        }
        return String.Format("{0} {1}", header, name);
    }
    protected void RadGridDoanhnghiepHDDuan_ItemDataBound(object sender, GridItemEventArgs e)
    {
        int index = e.Item.ItemIndex;
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = e.Item as GridEditableItem;
            RadNumericTextBox txtVALUE1 = editItem.FindControl("txtVALUE1") as RadNumericTextBox;
            RadNumericTextBox txtVALUE2 = editItem.FindControl("txtVALUE2") as RadNumericTextBox;
            RadNumericTextBox txtVALUE3 = editItem.FindControl("txtVALUE3") as RadNumericTextBox;
            RadNumericTextBox txtVALUE4 = editItem.FindControl("txtVALUE4") as RadNumericTextBox;
            Panel panelheader_b2 = editItem.FindControl("panelheader_b2") as Panel;
            Panel panelheader_b1 = editItem.FindControl("panelheader_b1") as Panel;
            HiddenField hfLevel = editItem.FindControl("hfLevel") as HiddenField;
            HiddenField fhTable = editItem.FindControl("fhTable") as HiddenField;
            UserControl nganhkinhte = editItem.FindControl("nganhkinhte") as UserControl;
            if (fhTable.Value == "1")
            {
                txtVALUE1.Visible = (index == 0 || index == 7) ? false : true; txtVALUE2.Visible = false; txtVALUE3.Visible = false; txtVALUE4.Visible = false; panelheader_b2.Visible = false;
                nganhkinhte.Visible = (index != 7) ? false : true;
                panelheader_b1.Visible=(index != 0) ? false : true;
            }
            else if (fhTable.Value == "2" && hfLevel.Value == "1")
            {
                panelheader_b1.Visible = false;
                nganhkinhte.Visible = false;
                txtVALUE1.Visible = false; txtVALUE2.Visible = false; panelheader_b2.Visible = true; txtVALUE3.Visible = false; txtVALUE4.Visible = false;
            }
            else if (fhTable.Value == "2" && hfLevel.Value != "1")
            {
                panelheader_b1.Visible = false;
                nganhkinhte.Visible = false;
                txtVALUE1.Visible = false; txtVALUE2.Visible = true; panelheader_b2.Visible = false; txtVALUE3.Visible = true; txtVALUE4.Visible = true;
            }
        }
    }
    protected void radDatareport_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        Response.Redirect(String.Format("Popup.aspx?ctl=dnhdduan&IDDN={0}&dateselect={1}", Request.QueryString["IDDN"], getdateselect((DateTime)radDatareport.DbSelectedDate)));
    }

    private string getdateselect(DateTime dateSelect)
    {
        return dateSelect.Year.ToString() + (dateSelect.Month > 9 ? dateSelect.Month.ToString() : "0" + dateSelect.Month.ToString()) + (dateSelect.Day > 9 ? dateSelect.Day.ToString() : "0" + dateSelect.Day.ToString());
    }
}