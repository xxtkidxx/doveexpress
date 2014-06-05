using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class module_KHIEUNAI : System.Web.UI.UserControl
{
    #region Biến toàn cục
    private string C_BILL
    {
        get
        {
            return Session["C_BILL"] as string;
        }
        set
        {
            Session["C_BILL"] = value;
        }
    }
    private string FK_KHACHHANG
    {
        get
        {
            return Session["FK_KHACHHANG"] as string;
        }
        set
        {
            Session["FK_KHACHHANG"] = value;
        }
    }
    private string TENKH
    {
        get
        {
            return Session["TENKH"] as string;
        }
        set
        {
            Session["TENKH"] = value;
        }
    }
    private string DIENTHOAIKH
    {
        get
        {
            return Session["DIENTHOAIKH"] as string;
        }
        set
        {
            Session["DIENTHOAIKH"] = value;
        }
    } 
    #endregion
    string Alarm = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridKHIEUNAI.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridKHIEUNAI.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridKHIEUNAI.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("KHIEUNAI"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        if (Request["index"] != null && Request["value"] != null)
        {
            string index = Request["index"].ToString();
            string Value = Request["value"].ToString();
        }
        Session["LastUrl"] = Request.Url.ToString();
        RadAjaxManager ajaxManager = RadAjaxManager.GetCurrent(Page);
        ajaxManager.AjaxRequest += new RadAjaxControl.AjaxRequestDelegate(RadScriptManager_AjaxRequestKN);
        ajaxManager.ClientEvents.OnResponseEnd = "onResponseEndKN";
    }
    protected void RadScriptManager_AjaxRequestKN(object sender, AjaxRequestEventArgs e)
    {
        string[] arrayvalue = e.Argument.Split(';');
        if ((arrayvalue[0] == "cmbMaKhachHang") && (FK_KHACHHANG != arrayvalue[1]))
        {
            FK_KHACHHANG = arrayvalue[1];
            string SelectSQL;
            SelectSQL = "Select DMKHACHHANG.FK_NHOMKHACHHANG,DMKHACHHANG.C_NAME,DMKHACHHANG.C_TEL FROM DMKHACHHANG WHERE DMKHACHHANG.C_CODE ='" + FK_KHACHHANG + "'";
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                TENKH = oDataTable.Rows[0]["C_NAME"].ToString();
                DIENTHOAIKH = oDataTable.Rows[0]["C_TEL"].ToString();                
            }
            else
            {
            }
        }
        if (arrayvalue[0] == "cmbC_TYPE" || arrayvalue[0] == "txtC_BILL")
        {
            C_BILL = arrayvalue[1];
            if (C_BILL != "")
            {
                string SelectSQL;
                SelectSQL = "Select NHANGUI.C_BILL,NHANGUI.FK_KHACHHANG,NHANGUI.C_TENKH,NHANGUI.C_TELGUI FROM NHANGUI WHERE NHANGUI.C_BILL ='" + C_BILL + "'";
                DataTable oDataTable = new DataTable();
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                oDataTable = SelectQuery.query_data(SelectSQL);
                if (oDataTable.Rows.Count != 0)
                {
                    FK_KHACHHANG = oDataTable.Rows[0]["FK_KHACHHANG"].ToString();
                    TENKH = oDataTable.Rows[0]["C_TENKH"].ToString();
                    DIENTHOAIKH = oDataTable.Rows[0]["C_TELGUI"].ToString();
                }
                else
                {
                }
            }
        }
        //Session["t"] = FK_KHACHHANG + "-" + TENKH + "-" + DIENTHOAIKH + "-" + PPXD + "-" + CUOCCHINH + "-" + GIADOITAC + "-" + FK_MABANGCUOC + "-" + FK_MAVUNG;
        if (Alarm != "")
        {
            string script = string.Format("var result = '{0}'", Alarm);
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
        }
        else
        {
            string script = string.Format("var result = '{0}'", FK_KHACHHANG + ",-," + TENKH + ",-," + DIENTHOAIKH);
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "result", script, true);
        }
    }
    protected void btnShowAll_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadGridKHIEUNAI.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridKHIEUNAI.MasterTableView.RenderColumns)
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
        RadGridKHIEUNAI.MasterTableView.Rebind();
    }
    private void DisplayMessage(string text)
    {
        RadGridKHIEUNAI.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridKHIEUNAI_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridKHIEUNAI_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xóa khiếu nại. Lý do: " + e.Exception.Message);
        }
        else
        {
            ClearSession();
            SetMessage("Xóa khiếu nại thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted KHIEUNAIs", e.Item.KeyValues);
        }
    }
    protected void RadGridKHIEUNAI_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới khiếu nại. Lý do: " + e.Exception.Message);
        }
        else
        {
            ClearSession();
            SetMessage("Tạo mới khiếu nại thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted KHIEUNAIs", "{PK_ID:\"" + getmaxid("DMKHIEUNAI") + "\"}");
        }
    }
    protected void RadGridKHIEUNAI_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật khiếu nại. Lý do: " + e.Exception.Message);
        }
        else
        {
            ClearSession();
            SetMessage("Cập nhật khiếu nại thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated KHIEUNAIs", e.Item.KeyValues);
        }
    }
    protected string GetMaxKN()
    {
        string maxbill = "0001";
        string SelectSQL = "SELECT MAX(CAST(C_CODE AS DECIMAL)) as MAXKN FROM KHIEUNAI";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);

        if (oDataTable.Rows[0]["MAXKN"] != DBNull.Value)
        {
            decimal maxvalue = (decimal)oDataTable.Rows[0]["MAXKN"];
            maxbill = String.Format("{0:0000}", maxvalue + 1);
        }
        return maxbill;
    }
    protected void RadGridKHIEUNAI_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadGrid grid = (RadGrid)sender;
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            HiddenField txtID = (HiddenField)editItem.FindControl("txtID");
            Session["txtID"] = (txtID.Value != "") ? txtID.Value : "0";
            RadTextBox txtC_CODE = (RadTextBox)editItem.FindControl("txtC_CODE");
            RadDateTimePicker radC_DATE = (RadDateTimePicker)editItem.FindControl("radC_DATE");
            RadComboBox cmbC_STATUS = (RadComboBox)editItem.FindControl("cmbC_STATUS");
            if (e.Item is GridEditFormInsertItem || e.Item is GridDataInsertItem)
            {
                // insert item
                ClearSession();
                cmbC_STATUS.SelectedIndex = 0;
                radC_DATE.SelectedDate = System.DateTime.Now;
                txtC_CODE.Text = GetMaxKN();
                
            }
            else
            {
            }
        }
        if (e.Item is GridDataItem)
        {
            Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
        }
    }
    protected void RadGridKHIEUNAI_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridKHIEUNAI.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridKHIEUNAI.Rebind();
            }
            foreach (GridDataItem item in RadGridKHIEUNAI.SelectedItems)
            {
                if (!ValidateDeleteGroup(item["pk_id"].Text))
                {
                    SetMessage("Không thể xóa khiếu nại \"" + item["c_name"].Text + "\" do có tham chiếu dữ liệu khác.");
                    RadGridKHIEUNAI.Rebind();
                }
            }
        }
        else if (e.CommandName == RadGrid.CancelAllCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            ClearSession();
        }
        else if (e.CommandName == RadGrid.CancelCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            ClearSession();
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
    protected bool ValidateDeleteGroup(string pkID)
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
    protected void RadGridKHIEUNAI_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;            
        }
    }
    protected void CheckMaKN(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        SelectSQL = "Select KHIEUNAI.C_CODE FROM KHIEUNAI WHERE KHIEUNAI.C_BILL = '" + args.Value + "' AND KHIEUNAI.PK_ID <> " + Session["txtID"].ToString();
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            args.IsValid = false;
        }
        else
        {
            args.IsValid = true;
        }
    }
    protected void ClearSession()
    {
        C_BILL = "";
        FK_KHACHHANG = "";
        TENKH = "";
        DIENTHOAIKH = "";        
        Alarm = "";        
    }
}