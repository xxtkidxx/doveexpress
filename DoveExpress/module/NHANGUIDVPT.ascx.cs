using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class module_NHANGUIDVPT : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridNHANGUIDVPT.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridNHANGUIDVPT.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridNHANGUIDVPT.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
    }
    private void DisplayMessage(string text)
    {
        RadGridNHANGUIDVPT.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridNHANGUIDVPT_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            //DisplayMessage(gridMessage);
        }
    }
    protected void RadGridNHANGUIDVPT_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xoá dịch vụ. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa dịch vụ thành công!");
        }
    }
    protected void RadGridNHANGUIDVPT_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới dịch vụ. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Tạo mới dịch vụ thành công!");
        }
    }
    protected void RadGridNHANGUIDVPT_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật dịch vụ. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Cập nhật dịch vụ thành công!");
        }
    }
    protected void RadGridNHANGUIDVPT_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridNHANGUIDVPT.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridNHANGUIDVPT.Rebind();
            }
            foreach (GridDataItem item in RadGridNHANGUIDVPT.SelectedItems)
            {
                if (!ValidateDeleteNHANGUIDVPT(item["PK_ID"].Text))
                {
                    SetMessage("Không thể xóa dịch vụ (ID: " + item["PK_ID"].Text + ")");
                    RadGridNHANGUIDVPT.Rebind();
                }
            }
        }
    }
    private double total = 0;
    protected void RadGridNHANGUIDVPT_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && !e.Item.IsInEditMode)
        {
            RadNumericTextBox txtC_GIATIEN = (RadNumericTextBox)e.Item.FindControl("txtC_GIATIEN");
            if (txtC_GIATIEN.DbValue != null) total += double.Parse(txtC_GIATIEN.DbValue.ToString());

        }
        if (e.Item is GridFooterItem)
        {
            GridFooterItem footerItem = (GridFooterItem)e.Item;
            RadNumericTextBox lblTongtien = footerItem["C_GIATIEN"].FindControl("lblTongtien") as RadNumericTextBox;
            lblTongtien.DbValue = Double.Parse(total.ToString());
            Session["DVPT"] = Double.Parse(total.ToString());
        }
    }
    protected bool ValidateDeleteNHANGUIDVPT(string guID)
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
    protected void NHANGUIDVPTsDataSource_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        string NewID = e.Command.Parameters["@NEWIDDVPT"].Value.ToString();
        string NEWIDDVPT;
        if (Session["NEWIDDVPT"] != null)
        {
            NEWIDDVPT = Session["NEWIDDVPT"].ToString();
            Session["NEWIDDVPT"] = NEWIDDVPT + "," + NewID;
        }
        else
        {
            Session["NEWIDDVPT"] = NewID;
        }
    }
}