﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class module_DutoanNSNNs : System.Web.UI.UserControl
{
    public string TENDONVIDUTOAN = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridNSNN.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridNSNN.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridNSNN.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("DUTOANSXKDs"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        if (Request.QueryString["dtID"] != null)
        {
            TENDONVIDUTOAN = ITCLIB.Admin.cFunction.LoadFieldfromTable(Request.QueryString["dtID"], "TENDONVI", "DUTOANDONVI");
        }
        Session["LastUrl"] = Request.Url.ToString();
    }
    private void DisplayMessage(string text)
    {
        RadGridNSNN.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridNSNN_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridNSNN_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xoá dự toán nộp ngân sách nhà nước. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa dự toán nộp ngân sách nhà nước thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted NSNNs", e.Item.GetDataKeyValue("PK_ID").ToString());
        }
    }
    protected void RadGridNSNN_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới dự toán nộp ngân sách nhà nước. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Tạo mới dự toán nộp ngân sách nhà nước thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted NSNNs", TENDONVIDUTOAN);
        }
    }
    protected void RadGridNSNN_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật dự toán nộp ngân sách nhà nước. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Cập nhật dự toán nộp ngân sách nhà nước thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated NSNNs", e.Item.GetDataKeyValue("PK_ID").ToString());
        }
    }
    protected void RadGridNSNN_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridNSNN.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridNSNN.Rebind();
            }
            foreach (GridDataItem item in RadGridNSNN.SelectedItems)
            {
                if (!ValidateDeleteNSNN(item["PK_ID"].Text))
                {
                    SetMessage("Không thể xóa dự toán nộp ngân sách nhà nước (ID: " + item["PK_ID"].Text + ")");
                    RadGridNSNN.Rebind();
                }
            }
        }
    }
    private int total = 0;
    protected void RadGridNSNN_ItemDataBound(object sender, GridItemEventArgs e)
    {

        GridItem cmdItem = RadGridNSNN.MasterTableView.GetItems(GridItemType.CommandItem)[0];
        Label lblTitle = (Label)cmdItem.FindControl("lblTitle");
        lblTitle.Text = TENDONVIDUTOAN + " - Quản lý dự toán nộp ngân sách nhà nước";
        if (e.Item is GridDataItem && !e.Item.IsInEditMode)
        {
            Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
            Label lblTONGTIEN = (Label)e.Item.FindControl("lblTONGTIEN");
            int introw = int.Parse(lblTONGTIEN.Text.Substring(0, lblTONGTIEN.Text.Length - 3).Trim());
            total = total + introw;
        }
        if (e.Item is GridFooterItem)
        {
            GridFooterItem footerItem = (GridFooterItem)e.Item;
            footerItem["TONGTIEN"].Text = "Tổng tiền: " + total.ToString() + " VNĐ";
        }
    }
    protected bool ValidateDeleteNSNN(string guID)
    {
        /*if (guID == "0" || guID == "1")
        {
            return false;
        }
        else
        {
            string SelectSQL = "SELECT DUTOANDETAI.PK_ID FROM DUTOANDETAI WHERE DUTOANDETAI.FK_User = " + guID;
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }*/
        return true;
    }
}
