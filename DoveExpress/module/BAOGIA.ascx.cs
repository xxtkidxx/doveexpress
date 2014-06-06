using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class module_BAOGIA : System.Web.UI.UserControl
{
    #region Biến toàn cục
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
                RadGridBAOGIA.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridBAOGIA.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridBAOGIA.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("BAOGIA"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        if (Request["index"] != null && Request["value"] != null)
        {
            string index = Request["index"].ToString();
            string Value = Request["value"].ToString();
        }
        Session["LastUrl"] = Request.Url.ToString();
        RadScriptManager.GetCurrent(Page).Services.Add(new ServiceReference(ResolveUrl("~/MyWebServiceBG.asmx")));
        RadGridBAOGIA.SelectedIndexes.Add(0);
        RadAjaxManager ajaxManager = RadAjaxManager.GetCurrent(Page);
        ajaxManager.AjaxRequest += new RadAjaxControl.AjaxRequestDelegate(RadScriptManager_AjaxRequestBG);
        ajaxManager.ClientEvents.OnResponseEnd = "onResponseEndBG";
    }
    protected void RadScriptManager_AjaxRequestBG(object sender, AjaxRequestEventArgs e)
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
    protected void RadGridBAOGIA_DataBound(object sender, EventArgs e)
    {
        if (RadGridBAOGIA.Items.Count > 0)
        {
            GridDataItem selectedItem = RadGridBAOGIA.Items[0];
            txtID.Value = selectedItem.GetDataKeyValue("PK_ID").ToString();
            string SelectSQL;
            SelectSQL = "Select BAOGIA.* FROM BAOGIA WHERE BAOGIA.PK_ID =  " + selectedItem.GetDataKeyValue("PK_ID").ToString();
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                txtC_CODE.Text = oDataTable.Rows[0]["C_CODE"].ToString();
                radC_DATE.SelectedDate = DateTime.Parse(oDataTable.Rows[0]["C_DATE"].ToString());
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
    protected void RadGridBAOGIA_ColumnCreated(object sender, GridColumnCreatedEventArgs e)
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
    protected void RadGridBAOGIA_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "ClearFilterGrid")
        {
            RadGridBAOGIA.MasterTableView.FilterExpression = string.Empty;

            foreach (GridColumn column in RadGridBAOGIA.MasterTableView.RenderColumns)
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
            RadGridBAOGIA.MasterTableView.Rebind();
        }
    }
    protected void CheckMaBG(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        SelectSQL = "Select BAOGIA.C_CODE FROM BAOGIA WHERE BAOGIA.C_CODE = '" + args.Value + "' AND BAOGIA.PK_ID <> " + Session["txtID"].ToString();
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
    protected string GetMaxBG()
    {
        string maxbill = "0001";
        string SelectSQL = "SELECT MAX(CAST(C_CODE AS DECIMAL)) as MAXBG FROM BAOGIA";
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            if (oDataTable.Rows[0]["MAXBG"] != DBNull.Value)
            {
                decimal maxvalue = (decimal)oDataTable.Rows[0]["MAXBG"];
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
        RadListViewBAOGIAGIAIQUYET.ShowInsertItem();
        RadListViewBAOGIAGIAIQUYET.FindControl("btnInitInsert").Visible = false;

    }
    protected void RadListViewBAOGIAGIAIQUYET_ItemCommand(object sender, RadListViewCommandEventArgs e)
    {
        if ((e.CommandName == RadListView.PerformInsertCommandName) || (e.CommandName == RadListView.UpdateCommandName) || (e.CommandName == RadListView.CancelCommandName))
        {
            RadListViewBAOGIAGIAIQUYET.InsertItemPosition = RadListViewInsertItemPosition.None;
            RadListViewBAOGIAGIAIQUYET.FindControl("btnInitInsert").Visible = true;
        }
    }
    protected void RadListViewBAOGIAGIAIQUYET_ItemCreated(object sender, RadListViewItemEventArgs e)
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