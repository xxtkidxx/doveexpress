using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;
using System.Globalization;
using System.Collections;
using System.Data.OleDb;
using Excel;

public partial class module_NHANGUIPH : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridNHANGUIPH.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridNHANGUIPH.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridNHANGUIPH.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("NHANGUIPH"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        if (Request["index"] != null && Request["value"] != null)
        {
            string index = Request["index"].ToString();
            string Value = Request["value"].ToString();
        }
        Session["LastUrl"] = Request.Url.ToString();
    }
    protected void btnShowAll_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadGridNHANGUIPH.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridNHANGUIPH.MasterTableView.RenderColumns)
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
        RadGridNHANGUIPH.MasterTableView.Rebind();
    }
    private void DisplayMessage(string text)
    {
        RadGridNHANGUIPH.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridNHANGUIPH_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridNHANGUIPH_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật nhận gửi. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Cập nhật nhận gửi thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated NHANGUIs", e.Item.KeyValues);
        }
    }
    protected void RadGridNHANGUIPH_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadGrid grid = (RadGrid)sender;
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            HiddenField txtID = (HiddenField)editItem.FindControl("txtID");
            Session["txtID"] = (txtID.Value != "") ? txtID.Value : "0";           
            if (e.Item is GridEditFormInsertItem || e.Item is GridDataInsertItem)
            {
                // insert item
            }
            else
            {
                // edit item
                RadDateTimePicker radC_NGAYGIOPHAT = (RadDateTimePicker)editItem.FindControl("radC_NGAYGIOPHAT");
                //radC_NGAYGIOPHAT.SelectedDate = System.DateTime.Now;
            }
        }
        if (e.Item is GridDataItem)
        {
            Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
        }
    }
    protected string GetMaxBill()
    {
        string maxbill = "00000001";
        string SelectSQL = "SELECT MAX(CAST(C_BILL AS BIGINT)) as MAXBILL FROM NHANGUI";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);

        if (oDataTable.Rows[0]["MAXBILL"] != DBNull.Value)
        {
            Int64 maxvalue = (Int64)oDataTable.Rows[0]["MAXBILL"];
            maxbill = String.Format("{0:00000000}", maxvalue + 1);
        }
        return maxbill;
    }
    protected void RadGridNHANGUIPH_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridNHANGUIPH.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridNHANGUIPH.Rebind();
            }
            foreach (GridDataItem item in RadGridNHANGUIPH.SelectedItems)
            {
                if (!ValidateDeleteGroup(item["C_BILL"].Text))
                {
                    SetMessage("Không thể xóa nhận gửi \"" + item["c_name"].Text + "\" do có tham chiếu dữ liệu khác.");
                    RadGridNHANGUIPH.Rebind();
                }
            }
        }
        else if (e.CommandName == RadGrid.PerformInsertCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
        }
        else if (e.CommandName == RadGrid.UpdateCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            CheckBox chkFK_TRANGTHAI = (CheckBox)editItem.FindControl("chkFK_TRANGTHAI");
            NHANGUIPHDataSource.UpdateParameters["FK_TRANGTHAI"].DefaultValue = chkFK_TRANGTHAI.Checked.ToString();
        }
        else if (e.CommandName == RadGrid.CancelAllCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;

        }
        else if (e.CommandName == RadGrid.CancelCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;

        }
        else if (e.CommandName == "ConfirmPayment")
        {
            string UpdateSQL = "";
            if (RadGridNHANGUIPH.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
            }
            else
            {

                foreach (GridDataItem item in RadGridNHANGUIPH.SelectedItems)
                {
                    string TIENHANG = (item["C_TIENHANGVAT"].Text.Trim() == "") ? "0" : item["C_TIENHANGVAT"].Text.Trim();
                    TIENHANG = TIENHANG.Replace(" ", "");
                    UpdateSQL += "UPDATE [NHANGUI] SET [C_DATHU] = " + TIENHANG + ",[C_HINHTHUCTT] = N'Đã thanh toán' WHERE [C_BILL] = '" + (item["C_BILL"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "';UPDATE [SOQUYTIENMAT] SET [C_NGAY] = '" + String.Format("{0:yyyy-MM-dd hh:mm:ss tt}", System.DateTime.Now.ToUniversalTime().AddHours(7)) + "',[C_SOTIEN] = " + TIENHANG + " WHERE [C_BILL] = '" + (item["C_BILL"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "';";
                }
                ITCLIB.Admin.SQL UpdateQuery = new ITCLIB.Admin.SQL();
                UpdateQuery.ExecuteNonQuery(UpdateSQL);
            }
            SetMessage("Cập nhật tình trạng thanh toán thành công");
            RadGridNHANGUIPH.Rebind();
        }
        else if (e.CommandName == "ConfirmUnPayment")
        {
            if (RadGridNHANGUIPH.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
            }
            else
            {
                string UpdateSQL = "";
                foreach (GridDataItem item in RadGridNHANGUIPH.SelectedItems)
                {
                    string TIENHANG = (item["C_TIENHANGVAT"].Text.Trim() == "") ? "0" : item["C_TIENHANGVAT"].Text.Trim();
                    TIENHANG = TIENHANG.Replace(" ", "");
                    UpdateSQL += "UPDATE [NHANGUI] SET [C_DATHU] = " + "0" + ",[C_HINHTHUCTT] = N'Thanh toán sau' WHERE [C_BILL] = '" + (item["C_BILL"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "';UPDATE [SOQUYTIENMAT] SET [C_SOTIEN] = " + "0" + " WHERE [C_BILL] = '" + (item["C_BILL"].FindControl("lblC_BILL") as Label).Text.Replace("BC", "").Trim() + "';";
                }
                ITCLIB.Admin.SQL UpdateQuery = new ITCLIB.Admin.SQL();
                UpdateQuery.ExecuteNonQuery(UpdateSQL);
            }
            SetMessage("Cập nhật tình trạng thanh toán thành công");
            RadGridNHANGUIPH.Rebind();
        }
    }
    protected string getmaxid(string table)
    {
        int rowcount = 0;
        string SelectSQL = "SELECT MAX(" + table + ".PK_ID) as MAXS FROM " + table;
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        rowcount = oDataTable.Rows.Count;
        if (rowcount != 0)
        {
            return oDataTable.Rows[0]["MAXS"].ToString();
        }
        else
        {
            return "1";
        }
    }
    protected bool ValidateDeleteGroup(string C_BILL)
    {
        int rowcount = 0;
        //string SelectSQL = "SELECT EOF_JOB.PK_ID FROM EOF_JOB WHERE EOF_JOB.fk_jobstatus = " + pkID;
        //DataTable oDataTable = new DataTable();
        //ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        //oDataTable = SelectQuery.query_data(SelectSQL);
        //rowcount = oDataTable.Rows.Count;
        if (rowcount != 0)
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //TextBox1.Text = Session["t"].ToString();
        //ITCLIB.Admin.JavaScript.ShowMessage(Session["t"].ToString(), this);
    }
    protected void cmbDoiTac_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cmbDoiTac.SelectedIndex = 0;
        }
    }

    public string GetStatusBill(string C_BILL)
    {
        string result = "";
        string SelectSQL = "SELECT TOP 1 DMTRANGTHAI.C_NAME FROM TRACKING LEFT OUTER JOIN DMTRANGTHAI ON TRACKING.FK_TRANGTHAI = DMTRANGTHAI.C_CODE WHERE TRACKING.C_BILL = N'" + C_BILL + "' ORDER BY TRACKING.C_DATE DESC";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            result = oDataTable.Rows[0]["C_NAME"].ToString();
        }
        else
        {
            result ="";
        }
        return result;
    }
    protected void RadGridNHANGUIPH_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridPagerItem)
        {
            RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
            RadComboBoxItem item = new RadComboBoxItem("100", "100");
            item.Attributes.Add("ownerTableViewId", RadGridNHANGUIPH.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("100") == null) cb.Items.Add(item);
            item = new RadComboBoxItem("200", "200");
            item.Attributes.Add("ownerTableViewId", RadGridNHANGUIPH.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("200") == null) cb.Items.Add(item);
            item = new RadComboBoxItem("500", "500");
            item.Attributes.Add("ownerTableViewId", RadGridNHANGUIPH.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("500") == null) cb.Items.Add(item);
            cb.Items.Sort(new PagerRadComboBoxItemComparer());
            cb.Items.FindItemByValue(RadGridNHANGUIPH.PageSize.ToString()).Selected = true;
        }
    }
    public class PagerRadComboBoxItemComparer : IComparer<RadComboBoxItem>, IComparer
    {
        public int Compare(RadComboBoxItem x, RadComboBoxItem y)
        {

            int rValue = 0;
            int lValue = 0;

            if (Int32.TryParse(x.Value, out lValue) && Int32.TryParse(y.Value, out rValue))
            {
                return lValue.CompareTo(rValue);
            }
            else
            {
                return x.Value.CompareTo(y.Value);
            }
        }
        public int Compare(object x, object y)
        {
            return Compare((RadComboBoxItem)x, (RadComboBoxItem)y);
        }
    }
    protected void btnImport_Click(object sender, EventArgs e)
    {
        //lblMessage.Text = RadAsyncUploadExcel.TemporaryFolder + RadAsyncUploadExcel.UploadedFiles[0].FileName;
        if (RadAsyncUploadExcel.UploadedFiles.Count != 0)
        {
            System.IO.Stream stream = RadAsyncUploadExcel.UploadedFiles[0].InputStream;
            IExcelDataReader excelReader;
            if (RadAsyncUploadExcel.UploadedFiles[0].GetExtension() == ".xls")
            {
                excelReader = ExcelReaderFactory.CreateBinaryReader(stream);
            }
            else
            {
                excelReader = ExcelReaderFactory.CreateOpenXmlReader(stream);
            }

            //excelReader.IsFirstRowAsColumnNames = true;
            DataSet result = excelReader.AsDataSet();
            excelReader.Close();
            excelReader.Close();
            DataTable oDataTable = new DataTable();
            oDataTable = result.Tables[0];
            if (oDataTable.Rows.Count != 0)
            {
                string BillFilter = "";
                string CheckSQL = "";
                for (int i = 0; i < oDataTable.Rows.Count; i++)
                {
                    if (i == 0)
                    {
                        BillFilter = "'" + oDataTable.Rows[i][0].ToString().Trim() + "'";
                        CheckSQL = "SELECT (CASE WHEN EXISTS (SELECT C_BILL FROM NHANGUI WHERE C_BILL='" + oDataTable.Rows[i][0].ToString().Trim() + "') THEN 'True' ELSE '" + oDataTable.Rows[i][0].ToString().Trim() + "' END) as C_BILL";
                    }
                    else
                    {
                        BillFilter += ",'" + oDataTable.Rows[i][0].ToString().Trim() + "'";
                        CheckSQL += " UNION ALL " + "SELECT (CASE WHEN EXISTS (SELECT C_BILL FROM NHANGUI WHERE C_BILL='" + oDataTable.Rows[i][0].ToString().Trim() + "') THEN 'True' ELSE '" + oDataTable.Rows[i][0].ToString().Trim() + "' END) as C_BILL";
                    }
                }
                RadGridNHANGUIPH.MasterTableView.FilterExpression = "([C_BILL] IN (" + BillFilter + "))";
                RadGridNHANGUIPH.Rebind();
                string CheckResult = "";
                DataTable oDataTableCheck = new DataTable();
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                oDataTableCheck = SelectQuery.query_data(CheckSQL);
                if (oDataTableCheck.Rows.Count != 0)
                {
                    for (int i = 0; i < oDataTableCheck.Rows.Count; i++)
                    {
                        if (oDataTableCheck.Rows[i]["C_BILL"].ToString() != "True")
                        {
                            if (CheckResult == "")
                            {
                                CheckResult = oDataTableCheck.Rows[i]["C_BILL"].ToString();
                            }
                            else
                            {
                                CheckResult += "," + oDataTableCheck.Rows[i]["C_BILL"].ToString();
                            }
                        }
                    }
                }
                lblMessage.Text = "Các Bill: " + CheckResult + " không có trong cơ sở dữ liệu";
            }          
        }
        else
        {
            lblMessage.Text = "Hãy chọn file Excel để lọc dữ liệu";
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        RadGridNHANGUIPH.MasterTableView.FilterExpression = string.Empty;
        lblMessage.Text = "";
        RadGridNHANGUIPH.Rebind();
    }
}