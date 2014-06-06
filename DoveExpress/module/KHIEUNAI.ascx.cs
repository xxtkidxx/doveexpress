using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
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
        RadScriptManager.GetCurrent(Page).Services.Add(new ServiceReference(ResolveUrl("~/MyWebServiceKN.asmx")));
        RadGridKHIEUNAI.SelectedIndexes.Add(0);
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
    protected void RadGridKHIEUNAI_DataBound(object sender, EventArgs e)
    {
        if (RadGridKHIEUNAI.Items.Count > 0)
        {
            GridDataItem selectedItem = RadGridKHIEUNAI.Items[0];
            txtID.Value = selectedItem.GetDataKeyValue("PK_ID").ToString();
            string SelectSQL;
            SelectSQL = "Select KHIEUNAI.* FROM KHIEUNAI WHERE KHIEUNAI.PK_ID =  " + selectedItem.GetDataKeyValue("PK_ID").ToString();
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                txtC_CODE.Text = oDataTable.Rows[0]["C_CODE"].ToString();
                cmbC_TYPE.SelectedValue = oDataTable.Rows[0]["C_TYPE"].ToString();
                radC_DATE.SelectedDate = DateTime.Parse(oDataTable.Rows[0]["C_DATE"].ToString());
                txtC_BILL.Text = oDataTable.Rows[0]["C_BILL"].ToString();
                if (oDataTable.Rows[0]["FK_KHACHHANG"].ToString() != "")
                {
                    cmbMaKhachHang.SelectedValue = oDataTable.Rows[0]["FK_KHACHHANG"].ToString();
                }
                txtC_TENKH.Text = oDataTable.Rows[0]["C_TENKH"].ToString();
                txtC_SDT.Text = oDataTable.Rows[0]["C_SDT"].ToString();
                txtC_NOIDUNG.Text = oDataTable.Rows[0]["C_NOIDUNG"].ToString();
                if (oDataTable.Rows[0]["FK_NGUOITAO"].ToString() != "")
                {
                    cmbFK_NGUOITAO.SelectedValue = oDataTable.Rows[0]["FK_NGUOITAO"].ToString();
                }
                cmbC_STATUS.SelectedValue = oDataTable.Rows[0]["C_STATUS"].ToString();
            }
            else
            {

            }
        }
    }
    protected void RadGridKHIEUNAI_ColumnCreated(object sender, GridColumnCreatedEventArgs e)
    {
        /*if (e.Column.IsBoundToFieldName("BirthDate"))
        {
            ((GridBoundColumn)e.Column).DataFormatString = "{0:MM/dd/yyyy}";
        }
        else if (e.Column.IsBoundToFieldName("Notes"))
        {
            e.Column.Visible = false;
        }*/
    }
    protected void RadGridKHIEUNAI_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "ClearFilterGrid")
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
    }
    protected void CheckMaKN(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        SelectSQL = "Select KHIEUNAI.C_CODE FROM KHIEUNAI WHERE KHIEUNAI.C_CODE = '" + args.Value + "' AND KHIEUNAI.PK_ID <> " + Session["txtID"].ToString();
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
    protected string GetMaxKN()
    {
        string maxbill = "0001";
        string SelectSQL = "SELECT MAX(CAST(C_CODE AS DECIMAL)) as MAXKN FROM KHIEUNAI";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            if (oDataTable.Rows[0]["MAXKN"] != DBNull.Value)
            {
                decimal maxvalue = (decimal)oDataTable.Rows[0]["MAXKN"];
                maxbill = String.Format("{0:0000}", maxvalue + 1);
            }
        }
        return maxbill;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        TextBox1.Text = Session["t"].ToString();
        //ITCLIB.Admin.JavaScript.ShowMessage(Session["t"].ToString(), this);
    }
    protected void btnInitInsert_Click(object sender, System.EventArgs e)
    {
        RadListViewKHIEUNAIGIAIQUYET.ShowInsertItem();
        RadListViewKHIEUNAIGIAIQUYET.FindControl("btnInitInsert").Visible = false;
        
    }
    protected void RadListViewKHIEUNAIGIAIQUYET_ItemCommand(object sender, RadListViewCommandEventArgs e)
    {
        if ((e.CommandName == RadListView.PerformInsertCommandName) || (e.CommandName == RadListView.UpdateCommandName) || (e.CommandName == RadListView.CancelCommandName))
        {
            RadListViewKHIEUNAIGIAIQUYET.InsertItemPosition = RadListViewInsertItemPosition.None;
            RadListViewKHIEUNAIGIAIQUYET.FindControl("btnInitInsert").Visible = true;
        }
    }
    protected void RadListViewKHIEUNAIGIAIQUYET_ItemCreated(object sender, RadListViewItemEventArgs e)
    {
        if (e.Item is RadListViewInsertItem && e.Item.IsInEditMode)
        {
            RadComboBox cmbFK_NGUOIGIAIQUYET = (RadComboBox)e.Item.FindControl("cmbFK_NGUOIGIAIQUYET");
            string checkuser = "SELECT USERS.PK_ID,USERS.FK_GroupUser,USERS.FK_DEPT,USERS.C_LoginName,USERS.C_Password,USERS.C_NAME,USERS.C_Address,USERS.c_Tel,USERS.C_Email,USERS.C_DESC,GROUPUSER.C_NAME AS GROUPUSERNAME FROM USERS INNER JOIN GROUPUSER ON  USERS.FK_GROUPUSER = GROUPUSER.PK_ID WHERE FK_GROUPUSER NOT IN (0,1) AND (FK_VUNGLAMVIEC = N'Tất cả' OR FK_VUNGLAMVIEC = N'" + Session["VUNGLAMVIEC"] + "') AND USERS.PK_ID = " + Session["UserID"];
            //Session["t"] = checkuser;
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(checkuser);
            if (oDataTable.Rows.Count != 0)
            {
                cmbFK_NGUOIGIAIQUYET.SelectedValue = Session["UserID"].ToString();
            }
        }
    }
}