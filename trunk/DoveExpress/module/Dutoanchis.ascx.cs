using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class module_Dutoanchis : System.Web.UI.UserControl
{
    public string TENDONVIDUTOAN = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridCHI.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridCHI.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridCHI.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("Dutoanchis"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
         if (Request.QueryString ["dtID"] != null )
        {
            TENDONVIDUTOAN = ITCLIB.Admin.cFunction.LoadFieldfromTable(Request.QueryString["dtID"],"TENDONVI","DUTOANDONVI");
        }       
        Session["LastUrl"] = Request.Url.ToString();
    }
    private void DisplayMessage(string text)
    {
        RadGridCHI.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridCHI_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridCHI_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xoá dự toán chi. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa dự toán chi thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted Chis", e.Item.GetDataKeyValue("PK_ID").ToString());
        }
    }
    protected void RadGridCHI_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới dự toán chi. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Tạo mới dự toán chi thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted Chis", TENDONVIDUTOAN);
        }
    }
    protected void RadGridCHI_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật dự toán chi. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Cập nhật dự toán chi thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated Chis", e.Item.GetDataKeyValue("PK_ID").ToString());
        }
    }
    protected void RadGridCHI_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridCHI.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridCHI.Rebind();
            }
            foreach (GridDataItem item in RadGridCHI.SelectedItems)
            {
                if (!ValidateDeleteChi(item["PK_ID"].Text))
                {
                    SetMessage("Không thể xóa dự toán chi (ID: " + item["PK_ID"].Text + ")");
                    RadGridCHI.Rebind();
                }
            }
        }
    }
    private int total = 0;
    protected void RadGridCHI_ItemDataBound(object sender, GridItemEventArgs e)
    {
       
        GridItem cmdItem = RadGridCHI.MasterTableView.GetItems(GridItemType.CommandItem)[0];
        Label lblTitle = (Label)cmdItem.FindControl("lblTitle");
        lblTitle.Text = TENDONVIDUTOAN + " - Quản lý dự toán chi";
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
    protected bool ValidateDeleteChi(string guID)
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
