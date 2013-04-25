using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;

public partial class module_Doangnghiep_Xaydung : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridDoanhnghiepXaydung.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridDoanhnghiepXaydung.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridDoanhnghiepXaydung.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
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
            if (!IsPostBack)
                radDatareport.DbSelectedDate = DateTime.Now;
        }
        else ITCLIB.Admin.JavaScript.RunScript("CancelEdit()", this);
        Session["LastUrl"] = Request.Url.ToString();
    }
    protected void btnShowAll_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadGridDoanhnghiepXaydung.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridDoanhnghiepXaydung.MasterTableView.RenderColumns)
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
        RadGridDoanhnghiepXaydung.MasterTableView.Rebind();
    }

    private void DisplayMessage(string text)
    {
        RadGridDoanhnghiepXaydung.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridDoanhnghiepXaydung_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridDoanhnghiepXaydung_ItemCommand(object sender, GridCommandEventArgs e)
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
                string sqlTest = String.Format("DELETE FROM DOANHNGHIEP_VALUE where FK_DOANHNGHIEP={0} AND (FK_TIEUCHI IN (SELECT PK_ID  FROM   DOANHNGHIEP_TIEUCHI WHERE (C_TYPE = 'XAYDUNG'))) AND (CONVERT(NVARCHAR(8), DOANHNGHIEP_VALUE.C_DATE, 112) = '{1}')", Request.QueryString["IDDN"], dateSelect.Year.ToString() + (dateSelect.Month > 9 ? dateSelect.Month.ToString() : "0" + dateSelect.Month.ToString()) + (dateSelect.Day > 9 ? dateSelect.Day.ToString() : "0" + dateSelect.Day.ToString()));
                if (ac.ExecuteNonQuery(sqlTest) > 0)
                {
                    SetMessage("Xóa tình hình xây dựng của doanh nghiệp thành công!");
                    ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted DoanhnghiepXaydungs", String.Format("FK_DOANHNGHIEP={0} và DATE {1}", Request.QueryString["IDDN"], dateSelect.ToShortDateString()));
                    RadGridDoanhnghiepXaydung.Rebind();
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
            string sqlTest = String.Format("select DOANHNGHIEP_VALUE.* FROM DOANHNGHIEP_VALUE inner join DOANHNGHIEP_TIEUCHI on DOANHNGHIEP_TIEUCHI.PK_ID =DOANHNGHIEP_VALUE.FK_TIEUCHI where DOANHNGHIEP_VALUE.FK_DOANHNGHIEP={0} AND DOANHNGHIEP_TIEUCHI.C_TYPE ='XAYDUNG' AND (CONVERT(NVARCHAR(8), DOANHNGHIEP_VALUE.C_DATE, 112) = '{1}')", Request.QueryString["IDDN"], dateSelect.Year.ToString() + (dateSelect.Month > 9 ? dateSelect.Month.ToString() : "0" + dateSelect.Month.ToString()) + (dateSelect.Day > 9 ? dateSelect.Day.ToString() : "0" + dateSelect.Day.ToString()));
            DataTable odataTest = ac.query_data(sqlTest);
            if (odataTest.Rows.Count <= 0)
            {
                //Tự động tạo các thống kê trong ngày chọn
                string sqlTieuchi = "SELECT PK_ID FROM DOANHNGHIEP_TIEUCHI where C_TYPE ='XAYDUNG'";
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
                        ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Insert DoanhnghiepXaydungs", String.Format("FK_DOANHNGHIEP={0} và DATE {1}", Request.QueryString["IDDN"], dateSelect.ToShortDateString()));
                        RadGridDoanhnghiepXaydung.Rebind();
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
            string strdisplay = "TÌNH HÌNH XÂY DỰNG CỦA ĐƠN VỊ BÁO CÁO: " + ITCLIB.Admin.cFunction.LoadFieldfromTable(Request.QueryString["IDDN"].ToString(), "TENDOANHNGHIEP", "DOANHNGHIEP").ToUpper();
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

    protected void RadGridDoanhnghiepXaydung_PreRender(object sender, EventArgs e)
    {
        foreach (GridItem item in RadGridDoanhnghiepXaydung.MasterTableView.Items)
        {
            if (item is GridEditableItem)
            {
                GridEditableItem editableItem = item as GridDataItem;
                editableItem.Edit = true;
            }
        }
        RadGridDoanhnghiepXaydung.Rebind();
    }
    protected void RadGridDoanhnghiepXaydung_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        if (e.AffectedRows > 0)
        {
            DateTime dateSelect = (DateTime)radDatareport.DbSelectedDate;
            string codeitem = e.Item.GetDataKeyValue("C_CODE").ToString().Trim();
            int table = int.Parse(e.Item.GetDataKeyValue("C_TABLE").ToString().Trim());
            string idate = dateSelect.Year.ToString() + (dateSelect.Month > 9 ? dateSelect.Month.ToString() : "0" + dateSelect.Month.ToString()) + (dateSelect.Day > 9 ? dateSelect.Day.ToString() : "0" + dateSelect.Day.ToString());
            if (table == 1)
            {
                if (codeitem == "03")
                {
                    ITCLIB.Admin.cFunction.UpdateValueTong("XAYDUNG", "03", Request.QueryString["IDDN"], idate, 0, "VALUE1", table);
                }
                else if (codeitem == "04" || codeitem == "05" || codeitem == "06" || codeitem == "07" || codeitem == "08")
                {
                    //Update tổng cả 4 cột
                    int valuetong1 = ITCLIB.Admin.cFunction.getValueFromCodeandType("XAYDUNG", "03", Request.QueryString["IDDN"], idate, "VALUE1", table) + ITCLIB.Admin.cFunction.getValueFromCodeandType("XAYDUNG", codeitem, Request.QueryString["IDDN"], idate, "VALUE1", table);
                    ITCLIB.Admin.cFunction.UpdateValueTong("XAYDUNG", "03", Request.QueryString["IDDN"], idate, valuetong1, "VALUE1", table);
                }
            }
            else if (table == 3)
            {
                if (codeitem == "01")
                {
                    ITCLIB.Admin.cFunction.UpdateValueTong("XAYDUNG", "01", Request.QueryString["IDDN"], idate, 0, "VALUE7", table);
                    ITCLIB.Admin.cFunction.UpdateValueTong("XAYDUNG", "01", Request.QueryString["IDDN"], idate, 0, "VALUE8", table);
                    ITCLIB.Admin.cFunction.UpdateValueTong("XAYDUNG", "01", Request.QueryString["IDDN"], idate, 0, "VALUE9", table);
                }
                else if (codeitem == "02" || codeitem == "03" || codeitem == "04" || codeitem == "05" || codeitem == "06" || codeitem == "07" || codeitem == "08" || codeitem == "09" || codeitem == "10" || codeitem == "11" || codeitem == "12")
                {
                    //Update tổng cả 3 cột : 7,8,9
                    int valuetong1 = ITCLIB.Admin.cFunction.getValueFromCodeandType("XAYDUNG", "01", Request.QueryString["IDDN"], idate, "VALUE7", table) + ITCLIB.Admin.cFunction.getValueFromCodeandType("XAYDUNG", codeitem, Request.QueryString["IDDN"], idate, "VALUE7", table);
                    ITCLIB.Admin.cFunction.UpdateValueTong("XAYDUNG", "01", Request.QueryString["IDDN"], idate, valuetong1, "VALUE7", table);
                    int valuetong2 = ITCLIB.Admin.cFunction.getValueFromCodeandType("XAYDUNG", "01", Request.QueryString["IDDN"], idate, "VALUE8", table) + ITCLIB.Admin.cFunction.getValueFromCodeandType("XAYDUNG", codeitem, Request.QueryString["IDDN"], idate, "VALUE8", table);
                    ITCLIB.Admin.cFunction.UpdateValueTong("XAYDUNG", "01", Request.QueryString["IDDN"], idate, valuetong2, "VALUE8", table);
                    int valuetong3 = ITCLIB.Admin.cFunction.getValueFromCodeandType("XAYDUNG", "01", Request.QueryString["IDDN"], idate, "VALUE9", table) + ITCLIB.Admin.cFunction.getValueFromCodeandType("XAYDUNG", codeitem, Request.QueryString["IDDN"], idate, "VALUE9", table);
                    ITCLIB.Admin.cFunction.UpdateValueTong("XAYDUNG", "01", Request.QueryString["IDDN"], idate, valuetong3, "VALUE9", table);
                }
            }
            SetMessage("Cập nhật tình hình xây dựng thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Update DoanhnghiepXaydungs", String.Format("FK_DOANHNGHIEP={0} và DATE {1}", Request.QueryString["IDDN"], dateSelect.ToShortDateString()));
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
    protected void RadGridDoanhnghiepXaydung_ItemDataBound(object sender, GridItemEventArgs e)
    {
        int index = e.Item.ItemIndex;
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = e.Item as GridEditableItem;
            RadNumericTextBox txtVALUE1 = editItem.FindControl("txtVALUE1") as RadNumericTextBox;
            RadNumericTextBox txtVALUE2 = editItem.FindControl("txtVALUE2") as RadNumericTextBox;
            RadNumericTextBox txtVALUE3 = editItem.FindControl("txtVALUE3") as RadNumericTextBox;
            RadNumericTextBox txtVALUE4 = editItem.FindControl("txtVALUE4") as RadNumericTextBox;
            RadNumericTextBox txtVALUE5 = editItem.FindControl("txtVALUE5") as RadNumericTextBox;
            RadNumericTextBox txtVALUE6 = editItem.FindControl("txtVALUE6") as RadNumericTextBox;
            RadNumericTextBox txtVALUE7 = editItem.FindControl("txtVALUE7") as RadNumericTextBox;
            RadNumericTextBox txtVALUE8 = editItem.FindControl("txtVALUE8") as RadNumericTextBox;
            RadNumericTextBox txtVALUE9 = editItem.FindControl("txtVALUE9") as RadNumericTextBox;
            Panel panelheader_b2 = editItem.FindControl("panelheader_b2") as Panel;
            Panel panelheader_b3 = editItem.FindControl("panelheader_b3") as Panel;
            Panel paneltxt = editItem.FindControl("paneltxt") as Panel;
            HiddenField hfLevel = editItem.FindControl("hfLevel") as HiddenField;
            HiddenField fhTable = editItem.FindControl("fhTable") as HiddenField;
            if (fhTable.Value == "1")
            {
                txtVALUE1.Visible = index == 0 ? false : true; txtVALUE7.Visible = false; txtVALUE2.Visible = false;//Cột 1
                txtVALUE3.Visible = false; txtVALUE8.Visible = false; //cột 2
                txtVALUE4.Visible = false; txtVALUE9.Visible = false; //cột 3                    
                panelheader_b2.Visible = false; panelheader_b3.Visible = false; paneltxt.Visible = false;
            }
            else if (fhTable.Value == "2")
            {
                txtVALUE1.Visible = false; txtVALUE2.Visible = index == 10 ? false : true; txtVALUE7.Visible = false;//Cột 1
                txtVALUE3.Visible = index == 10 ? false : true; txtVALUE8.Visible = false; //cột 2
                txtVALUE4.Visible = index == 10 ? false : true; txtVALUE9.Visible = false; //cột 3
                panelheader_b2.Visible = index == 10 ? true : false; panelheader_b3.Visible = false; paneltxt.Visible = index == 10 ? false : true;
            }
            else if (fhTable.Value == "3")
            {
                txtVALUE1.Visible = false; txtVALUE2.Visible = false; txtVALUE7.Visible = index == 15 ? false : true;//Cột 1                 
                txtVALUE3.Visible = false; txtVALUE8.Visible = index == 15 ? false : true; ; //cột 2
                txtVALUE4.Visible = false; txtVALUE9.Visible = index == 15 ? false : true; ; //cột 3
                panelheader_b2.Visible = false; panelheader_b3.Visible = index == 15 ? true : false; paneltxt.Visible = false;
            }
        }
    }
}