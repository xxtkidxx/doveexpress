using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;

public partial class module_Doanhnghiep_Luutru : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridDoanhnghiepLuutru.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridDoanhnghiepLuutru.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridDoanhnghiepLuutru.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
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
        RadGridDoanhnghiepLuutru.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridDoanhnghiepLuutru.MasterTableView.RenderColumns)
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
        RadGridDoanhnghiepLuutru.MasterTableView.Rebind();
    }

    private void DisplayMessage(string text)
    {
        RadGridDoanhnghiepLuutru.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridDoanhnghiepLuutru_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridDoanhnghiepLuutru_ItemCommand(object sender, GridCommandEventArgs e)
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
                string sqlTest = String.Format("DELETE FROM DOANHNGHIEP_VALUE where FK_DOANHNGHIEP={0} AND (FK_TIEUCHI IN (SELECT PK_ID  FROM   DOANHNGHIEP_TIEUCHI WHERE (C_TYPE = 'LUUTRU'))) AND (CONVERT(NVARCHAR(8), DOANHNGHIEP_VALUE.C_DATE, 112) = '{1}')", Request.QueryString["IDDN"], dateSelect.Year.ToString() + (dateSelect.Month > 9 ? dateSelect.Month.ToString() : "0" + dateSelect.Month.ToString()) + (dateSelect.Day > 9 ? dateSelect.Day.ToString() : "0" + dateSelect.Day.ToString()));
                if (ac.ExecuteNonQuery(sqlTest) > 0)
                {
                    SetMessage("Xóa hoạt động lưu trú của doanh nghiệp thành công!");
                    ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted DoanhnghiepLuutrus", String.Format("FK_DOANHNGHIEP={0} và DATE {1}", Request.QueryString["IDDN"], dateSelect.ToShortDateString()));
                    RadGridDoanhnghiepLuutru.Rebind();
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
            string sqlTest = String.Format("select DOANHNGHIEP_VALUE.* FROM DOANHNGHIEP_VALUE inner join DOANHNGHIEP_TIEUCHI on DOANHNGHIEP_TIEUCHI.PK_ID =DOANHNGHIEP_VALUE.FK_TIEUCHI where DOANHNGHIEP_VALUE.FK_DOANHNGHIEP={0} AND DOANHNGHIEP_TIEUCHI.C_TYPE ='LUUTRU' AND (CONVERT(NVARCHAR(8), DOANHNGHIEP_VALUE.C_DATE, 112) = '{1}')", Request.QueryString["IDDN"], dateSelect.Year.ToString() + (dateSelect.Month > 9 ? dateSelect.Month.ToString() : "0" + dateSelect.Month.ToString()) + (dateSelect.Day > 9 ? dateSelect.Day.ToString() : "0" + dateSelect.Day.ToString()));
            DataTable odataTest = ac.query_data(sqlTest);
            if (odataTest.Rows.Count <= 0)
            {
                //Tự động tạo các thống kê trong ngày chọn
                string sqlTieuchi = "SELECT PK_ID FROM DOANHNGHIEP_TIEUCHI where C_TYPE ='LUUTRU'";
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
                        ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Insert DoanhnghiepLuutrus", String.Format("FK_DOANHNGHIEP={0} và DATE {1}", Request.QueryString["IDDN"], dateSelect.ToShortDateString()));
                        RadGridDoanhnghiepLuutru.Rebind();
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
            string strdisplay = "HOẠT ĐỘNG LƯU TRÚ CỦA ĐƠN VỊ BÁO CÁO: " + ITCLIB.Admin.cFunction.LoadFieldfromTable(Request.QueryString["IDDN"].ToString(), "TENDOANHNGHIEP", "DOANHNGHIEP").ToUpper();
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

    protected void RadGridDoanhnghiepLuutru_PreRender(object sender, EventArgs e)
    {
        foreach (GridItem item in RadGridDoanhnghiepLuutru.MasterTableView.Items)
        {
            if (item is GridEditableItem)
            {
                GridEditableItem editableItem = item as GridDataItem;
                editableItem.Edit = true;
            }
        }
        RadGridDoanhnghiepLuutru.Rebind();
    }
    protected void RadGridDoanhnghiepLuutru_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        if (e.AffectedRows > 0)
        {
            DateTime dateSelect = (DateTime)radDatareport.DbSelectedDate;
            SetMessage("Cập nhật hoạt động lưu trú của doanh nghiệp thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Update DoanhnghiepLuutrus", String.Format("FK_DOANHNGHIEP={0} và DATE {1}", Request.QueryString["IDDN"], dateSelect.ToShortDateString()));
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
    protected void RadGridDoanhnghiepLuutru_ItemDataBound(object sender, GridItemEventArgs e)
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
            Label lblVALUE2 = editItem.FindControl("lblVALUE2") as Label;
            Panel panelheader = editItem.FindControl("panelheader") as Panel;
            Panel paneltxt = editItem.FindControl("paneltxt") as Panel;
            switch (index)
            {
                case 0: 
                    txtVALUE1.Visible = false; txtVALUE3.Visible = false ; txtVALUE2.Visible = false;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = false;
                    break;
                case 1: txtVALUE1.Visible = true; txtVALUE3.Visible = false; txtVALUE2.Visible = false;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = false;
                    break;
                case 2: txtVALUE1.Visible = false; txtVALUE3.Visible = false; txtVALUE2.Visible = false;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = false;
                    break;
                case 3: txtVALUE1.Visible = true; txtVALUE3.Visible = false; txtVALUE2.Visible = false;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = false;
                    break;
                case 4: txtVALUE1.Visible = true; txtVALUE3.Visible = false; txtVALUE2.Visible = false;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = false;
                    break;
                case 5: txtVALUE1.Visible = true; txtVALUE3.Visible = false; txtVALUE2.Visible = false;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = false;
                    break;
                case 6: txtVALUE1.Visible = true; txtVALUE3.Visible = false; txtVALUE2.Visible = false;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = false;
                    break;
                case 7: txtVALUE1.Visible = false ; txtVALUE3.Visible = false; txtVALUE2.Visible = false;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = false;
                    break;
                case 8: txtVALUE1.Visible = true; txtVALUE3.Visible = false; txtVALUE2.Visible = false;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = false;
                    break;
                case 9: txtVALUE1.Visible = true; txtVALUE3.Visible = false; txtVALUE2.Visible = false;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = false;
                    break;
                case 10: txtVALUE1.Visible = true; txtVALUE3.Visible = false; txtVALUE2.Visible = false;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = false;
                    break;
                case 11: txtVALUE1.Visible = true; txtVALUE3.Visible = false; txtVALUE2.Visible = false;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = false;
                    break;
                case 12: txtVALUE1.Visible = true; txtVALUE3.Visible = false; txtVALUE2.Visible = false;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = false;
                    break;
                case 13: txtVALUE1.Visible = true; txtVALUE3.Visible = false; txtVALUE2.Visible = false;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = false;
                    break;
                case 14: txtVALUE1.Visible = false; txtVALUE3.Visible = false; txtVALUE2.Visible = false;
                    lblVALUE2.Visible = panelheader.Visible = true; paneltxt.Visible = false;
                    break;
                case 15: txtVALUE1.Visible = false; txtVALUE3.Visible = true; txtVALUE2.Visible = true ;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = true;
                    break;
                case 16: txtVALUE1.Visible = false; txtVALUE3.Visible = true; txtVALUE2.Visible = true;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = true;
                    break;
                case 17: txtVALUE1.Visible = false; txtVALUE3.Visible = true; txtVALUE2.Visible = true;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = true;
                    break;
                case 18: txtVALUE1.Visible = false; txtVALUE3.Visible = true; txtVALUE2.Visible = true;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = true;
                    break;
                case 19: txtVALUE1.Visible = false; txtVALUE3.Visible = true; txtVALUE2.Visible = true;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = true;
                    break;
                case 20: txtVALUE1.Visible = false; txtVALUE3.Visible = true; txtVALUE2.Visible = true;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = true;
                    break;
                case 21: txtVALUE1.Visible = false; txtVALUE3.Visible = true; txtVALUE2.Visible = true;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = true;
                    break;
                case 22: txtVALUE1.Visible = false; txtVALUE3.Visible = true; txtVALUE2.Visible = true;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = true;
                    break;
                case 23: txtVALUE1.Visible = false; txtVALUE3.Visible = true; txtVALUE2.Visible = true;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = true;
                    break;
                case 24: txtVALUE1.Visible = false; txtVALUE3.Visible = true; txtVALUE2.Visible = true;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = true;
                    break;
                case 25: txtVALUE1.Visible = false; txtVALUE3.Visible = true; txtVALUE2.Visible = true;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = true;
                    break;
                case 26: txtVALUE1.Visible = false; txtVALUE3.Visible = true; txtVALUE2.Visible = true;
                    lblVALUE2.Visible = panelheader.Visible = false; paneltxt.Visible = true;
                    break;
            }
        }
    }
}