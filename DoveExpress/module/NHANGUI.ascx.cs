﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class module_NHANGUI : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridNHANGUI.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridNHANGUI.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridNHANGUI.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("Lists"))
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
        RadGridNHANGUI.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridNHANGUI.MasterTableView.RenderColumns)
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
        RadGridNHANGUI.MasterTableView.Rebind();
    }
    protected void CheckBill(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        SelectSQL = "Select NHANGUI.C_BILL FROM NHANGUI WHERE NHANGUI.C_BILL = '" + args.Value + "' AND NHANGUI.PK_ID <> " + Session["txtID"].ToString();
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
    private void DisplayMessage(string text)
    {
        RadGridNHANGUI.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridNHANGUI_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridNHANGUI_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xóa nhận gửi. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa nhận gửi thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted NHANGUIs", e.Item.KeyValues);
        }
    }
    protected void RadGridNHANGUI_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            //e.ExceptionHandled = true;
            //SetMessage("Không thể tạo mới nhận gửi. Lý do: " + e.Exception.Message);
        }
        else
        {
            //SetMessage("Tạo mới nhận gửi thành công!");
            //ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted NHANGUIs", "{PK_ID:\"" + getmaxid("NHANGUI") + "\"}");
        }
    }
    protected void RadGridNHANGUI_ItemUpdated(object sender, GridUpdatedEventArgs e)
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
    protected void RadGridNHANGUI_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadGrid grid = (RadGrid)sender;
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            HiddenField txtID = (HiddenField)editItem.FindControl("txtID");
            Session["txtID"] = (txtID.Value != "") ? txtID.Value : "0";
        }
        if (e.Item is GridDataItem)
        {
            Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
        }
    }
    protected void RadGridNHANGUI_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridNHANGUI.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridNHANGUI.Rebind();
            }
            foreach (GridDataItem item in RadGridNHANGUI.SelectedItems)
            {
                if (!ValidateDeleteGroup(item["pk_id"].Text))
                {
                    SetMessage("Không thể xóa nhận gửi \"" + item["c_name"].Text + "\" do có tham chiếu dữ liệu khác.");
                    RadGridNHANGUI.Rebind();
                }
            }
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
    protected void cmbQuanHuyen_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        RadComboBox cmbQuanHuyen = (RadComboBox)sender;
        QUANHUYENDataSource.SelectCommand = LoadFilteredManually(e.Text);
        cmbQuanHuyen.DataBind();
    }
    protected string LoadFilteredManually(string ID)
    {
        string SelectSQL = "";
        if (ID != "")
        {
            SelectSQL = "SELECT * FROM DMQUANHUYEN WHERE FK_TINHTHANH = " + ID + "order by C_CODE";
        }
        else
        {
            SelectSQL = "SELECT * FROM DMQUANHUYEN order by C_CODE";
        }
        return SelectSQL;
    }
    protected void UpdateExtGridNhanGui()
    {
        string UpdateSQL = "";
        if (Session["NEWIDDVPT"] != null)
        {
            UpdateSQL += "Update DICHVUPT set FK_NHANGUI = " + Session["IDNHANGUI"].ToString() + " WHERE PK_ID IN (" + Session["NEWIDDVPT"].ToString() + ");";
            Session["NEWIDDVPT"] = null;
        }
        if (UpdateSQL != "")
        {
            ITCLIB.Admin.SQL rs = new ITCLIB.Admin.SQL();
            rs.ExecuteNonQuery(UpdateSQL);
        }
    }
    protected void DeleteExtGridNhanGui()
    {
        string DeleteSQL = "";
        if (Session["NEWIDDVPT"] != null)
        {
            DeleteSQL += "Delete  FROM DICHVUPT WHERE PK_ID IN (" + Session["NEWIDDVPT"] + ");";
            Session["NEWIDDVPT"] = null;
        }
        if (DeleteSQL != "")
        {
            ITCLIB.Admin.SQL rs = new ITCLIB.Admin.SQL();
            rs.ExecuteNonQuery(DeleteSQL);
        }
    }

    protected void NHANGUIDataSource_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            DeleteExtGridNhanGui();
            SetMessage("Không thể tạo mới nhận gửi. Lý do: " + e.Exception.Message);
        }
        else
        {
            Session["IDNHANGUI"] = e.Command.Parameters["@IDNHANGUI"].Value.ToString();
            UpdateExtGridNhanGui();
            SetMessage("Tạo mới nhận gửi thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted NHANGUI", Session["IDNHANGUI"].ToString());
        }
    }
}