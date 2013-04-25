using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class module_DUANTHVDT : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridDUANTHVDT.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridDUANTHVDT.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridDUANTHVDT.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("DUANs"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        if (Request["index"] != null && Request["value"] != null)
        {
            string index = Request["index"].ToString();
            string Value = Request["value"].ToString();
        }
        if (Request.QueryString["daID"] != null)
        {
            if (!IsPostBack)
            {
                cmbYear.SelectedValue = DateTime.Now.Year.ToString();
                string SelectSQL;
                SelectSQL = "Select DUAN.TENDUAN,DUAN.MADUAN,CONVERT(VARCHAR,SUM(TONGTIEN),16) AS TONGTIEN FROM DUAN LEFT OUTER JOIN  DUANVON ON DUAN.PK_ID = DUANVON.FK_DUAN WHERE FK_DUAN =" + Request.QueryString["daID"] + " GROUP BY DUAN.TENDUAN,DUAN.MADUAN";
                DataTable oDataTable = new DataTable();
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                oDataTable = SelectQuery.query_data(SelectSQL);
                if (oDataTable.Rows.Count != 0)
                {
                    lblTENDUAN.Text = oDataTable.Rows[0]["TENDUAN"].ToString();
                    lblMADUAN.Text = oDataTable.Rows[0]["MADUAN"].ToString();
                    lblTONGDAUTU.Text = oDataTable.Rows[0]["TONGTIEN"].ToString() + " Triệu đồng";
                    lblTONGDUTOAN.Text = "";
                }
                else
                {

                }
            }
        }
        else ITCLIB.Admin.JavaScript.RunScript("CancelEdit()", this);
        Session["LastUrl"] = Request.Url.ToString();
    }
    protected void btnShowAll_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadGridDUANTHVDT.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridDUANTHVDT.MasterTableView.RenderColumns)
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
        RadGridDUANTHVDT.MasterTableView.Rebind();
    }

    private void DisplayMessage(string text)
    {
        RadGridDUANTHVDT.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridDUANTHVDT_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridDUANTHVDT_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            ITCLIB.Admin.SQL ac = new ITCLIB.Admin.SQL();
            if (cmbYear.SelectedValue == null)
            {
                SetMessage("Không có bản ghi được chọn!");
            }
            else
            {
                string YearSelect = cmbYear.SelectedValue;
                string sqlTest = String.Format("DELETE FROM DUANVON_VALUE where FK_DUAN={0} AND (FK_TIEUCHI IN (SELECT PK_ID FROM DUANVON_TIEUCHI WHERE (C_TYPE = 'VONDAUTU'))) AND (DUANVON_VALUE.C_DATE = '{1}')", Request.QueryString["daID"], YearSelect);
                if (ac.ExecuteNonQuery(sqlTest) > 0)
                {
                    SetMessage("Xóa báo cáo lao động doanh nghiệp thành công!");
                    ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted DUANTHVDTs", String.Format("FK_DUAN={0} và DATE {1}", Request.QueryString["daID"], YearSelect));
                    RadGridDUANTHVDT.Rebind();
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
            int YearSelect = DateTime.Now.Year;
            if (cmbYear.SelectedValue != null)
            {
                YearSelect = int.Parse(cmbYear.SelectedValue);
            }
            else
            {
                cmbYear.SelectedValue = YearSelect.ToString();
            }
            //Kiểm tra có báo cáo thống kê ngày chọn chưa
            string sqlTest = String.Format("select DUANVON_VALUE.* FROM DUANVON_VALUE inner join  DUANVON_TIEUCHI on  DUANVON_TIEUCHI.PK_ID =DUANVON_VALUE.FK_TIEUCHI where DUANVON_VALUE.FK_DUAN={0} AND  DUANVON_TIEUCHI.C_TYPE ='VONDAUTU' AND (DUANVON_VALUE.C_DATE = '{1}')", Request.QueryString["daID"], YearSelect);
            DataTable odataTest = ac.query_data(sqlTest);
            if (odataTest.Rows.Count <= 0)
            {
                //Tự động tạo các thống kê trong ngày chọn
                string sqlTieuchi = "SELECT PK_ID FROM DUANVON_TIEUCHI where C_TYPE ='VONDAUTU'";
                DataTable odata = ac.query_data(sqlTieuchi);
                string sqlInssert = "";
                foreach (DataRow ors in odata.Rows)
                {
                    sqlInssert += String.Format("; Insert into DUANVON_VALUE(FK_DUAN, C_DATE, FK_TIEUCHI) VALUES ({0}, '{1}', {2})", Request.QueryString["daID"], YearSelect, ors["PK_ID"]);
                }
                if (sqlInssert != "")
                {
                    if (ac.ExecuteNonQuery(sqlInssert) > 0)
                    {
                        SetMessage("Tạo thành công!");
                        ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Insert DUANTHVDTs", String.Format("FK_DUAN={0} và DATE {1}", Request.QueryString["daID"], YearSelect));
                        RadGridDUANTHVDT.Rebind();
                    }
                    else
                    {
                        SetMessage("Tạo không thành công!");
                    }
                }
            }
            else
            {
                SetMessage("Đã có báo cáo năm đang chọn: " + YearSelect);
            }
        }
    }

    protected void lblCap_PreRender(object sender, EventArgs e)
    {
        Label titile = (Label)sender;
        if (Request.QueryString["daID"] != null)
        {
            string strdisplay = "TÌNH HÌNH THỰC HIỆN VỐN ĐẦU TƯ";
            titile.Text = strdisplay;
        }
        else { ITCLIB.Admin.JavaScript.RunScript("CancelEdit()", this); }
    }

    protected void RadGridDUANTHVDT_PreRender(object sender, EventArgs e)
    {
        foreach (GridItem item in RadGridDUANTHVDT.MasterTableView.Items)
        {
            if (item is GridEditableItem)
            {
                GridEditableItem editableItem = item as GridDataItem;
                editableItem.Edit = true;
            }
        }
        RadGridDUANTHVDT.Rebind();
    }
    protected void RadGridDUANTHVDT_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        if (e.AffectedRows > 0)
        {
            int YearSelect = int.Parse(cmbYear.SelectedValue);
            SetMessage("Cập nhật tình hình thực hiện vốn đầu tư thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Update DUANTHVDTs", String.Format("FK_DUAN={0} và DATE {1}", Request.QueryString["daID"], YearSelect));
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
    protected void cmbYear_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            string SelectSQL = "SELECT MIN(C_DATE) as MINNAM FROM DUANVON_VALUE";
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                if (oDataTable.Rows[0]["MINNAM"] == DBNull.Value)
                {
                    int intYear = DateTime.Now.Year;
                    RadComboBoxItem Item0 = new RadComboBoxItem(intYear.ToString(), intYear.ToString());
                    intYear += 1;
                    RadComboBoxItem Item1 = new RadComboBoxItem(intYear.ToString(), intYear.ToString());
                    cmbYear.Items.Add(Item0);
                    cmbYear.Items.Add(Item1);
                }
                else
                {
                    int intYear = DateTime.Now.Year;
                    for (int i = int.Parse(oDataTable.Rows[0]["MINNAM"].ToString()); i <= intYear + 1; i++)
                    {
                        RadComboBoxItem Item = new RadComboBoxItem(i.ToString(), i.ToString());
                        cmbYear.Items.Add(Item);
                    }
                }
            }
            else
            {

            }
            cmbYear.SelectedValue = DateTime.Now.Year.ToString();
        }
    }
    protected void RadGridDUANTHVDT_ItemCreated(object sender, GridItemEventArgs e)
    {
        
    }
    protected void RadGridDUANTHVDT_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editedItem = e.Item as GridEditableItem;
            RadNumericTextBox txtVALUE1 = (RadNumericTextBox)editedItem.FindControl("txtVALUE1");
            Label lblC_CODE = (Label)editedItem.FindControl("lblC_CODE");
            txtVALUE1.ClientEvents.OnLoad = "OnClientLoadRadNumericTextBox" + lblC_CODE.Text;
            txtVALUE1.ClientEvents.OnValueChanged = "OnValueChangedRadNumericTextBox" + lblC_CODE.Text;
        }
    }
}