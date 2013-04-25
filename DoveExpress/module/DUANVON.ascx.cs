using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class module_DUANVON : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridDUANVON.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridDUANVON.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridDUANVON.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
    }   
    private void DisplayMessage(string text)
    {
        RadGridDUANVON.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridDUANVON_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            //DisplayMessage(gridMessage);
        }
    }
    protected void RadGridDUANVON_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xoá vốn dự án. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa vốn dự án thành công!");
        }
    }
    protected void RadGridDUANVON_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới vốn dự án. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Tạo mới vốn dự án thành công!");
        }
    }
    protected void RadGridDUANVON_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật vốn dự án. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Cập nhật vốn dự án thành công!");
        }
    }
    protected void RadGridDUANVON_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridDUANVON.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridDUANVON.Rebind();
            }
            foreach (GridDataItem item in RadGridDUANVON.SelectedItems)
            {
                if (!ValidateDeleteDUANVON(item["PK_ID"].Text))
                {
                    SetMessage("Không thể xóa vốn dự án (ID: " + item["PK_ID"].Text + ")");
                    RadGridDUANVON.Rebind();
                }
            }
        }
    }
    private int total = 0;
    protected void RadGridDUANVON_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && !e.Item.IsInEditMode)
        {
            Label lblTONGTIEN = (Label)e.Item.FindControl("lblTONGTIEN");
            if (lblTONGTIEN.Text.Length > 3)
            {
                int introw = int.Parse(lblTONGTIEN.Text.Substring(0, lblTONGTIEN.Text.Length - 3).Trim());
                total = total + introw;
            }
        }
        if (e.Item is GridFooterItem)
        {
            GridFooterItem footerItem = (GridFooterItem)e.Item;
            footerItem["TONGTIEN"].Text = "Tổng tiền: " + total.ToString() + " VNĐ";
        }
    }
    protected bool ValidateDeleteDUANVON(string guID)
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
    protected void DUANVONsDataSource_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        string NewID = e.Command.Parameters["@NEWIDVON"].Value.ToString();
        string NewIDVON;
        if (Session["NEWIDVON"] != null)
        {
            NewIDVON = Session["NEWIDVON"].ToString();
            Session["NEWIDVON"] = NewIDVON + "," + NewID;
        }
        else
        {
            Session["NEWIDVON"] = NewID;
        }
    }
}
