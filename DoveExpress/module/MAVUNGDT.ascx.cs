using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class module_MAVUNGDT : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridMAVUNGDT.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridMAVUNGDT.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridMAVUNGDT.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("BANGCUOC"))
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
        RadGridMAVUNGDT.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridMAVUNGDT.MasterTableView.RenderColumns)
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
        RadGridMAVUNGDT.MasterTableView.Rebind();
    }
    private void DisplayMessage(string text)
    {
        RadGridMAVUNGDT.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridMAVUNGDT_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridMAVUNGDT_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xóa vùng tính cước. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa vùng tính cước thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted MAVUNGDTs", e.Item.KeyValues);
        }
    }
    protected void RadGridMAVUNGDT_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới vùng tính cước. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Tạo mới vùng tính cước thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted MAVUNGDTs", "{PK_ID:\"" + getmaxid("DMMAVUNGDT") + "\"}");
        }
    }
    protected void RadGridMAVUNGDT_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật vùng tính cước. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Cập nhật vùng tính cước thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated MAVUNGDTs", e.Item.KeyValues);
        }
    }
    protected void RadGridMAVUNGDT_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadGrid grid = (RadGrid)sender;
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            HiddenField txtID = (HiddenField)editItem.FindControl("txtID");
            Session["txtID"] = (txtID.Value != "") ? txtID.Value : "0";
            RadListBox RadListBoxQuanHuyenRef = (RadListBox)editItem.FindControl("RadListBoxQuanHuyenRef");
            HiddenField txtC_DESC = (HiddenField)editItem.FindControl("txtC_DESC");
            setItenforListBoxSelect(RadListBoxQuanHuyenRef, txtC_DESC.Value);
            if (e.Item is GridEditFormInsertItem || e.Item is GridDataInsertItem)
            {
                RadComboBox cmbDoiTacEdit = (RadComboBox)editItem.FindControl("cmbDoiTacEdit");
                cmbDoiTacEdit.SelectedValue = cmbDoiTac.SelectedValue;
            }
        }
        if (e.Item is GridDataItem)
        {
            Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
        }
    }
    protected static void setItenforListBoxSelect(RadListBox control, string ivalue)
    {
        if (ivalue != "")
        {
            string[] temp;
            temp = ivalue.Split(',');
            string ivalueconvert = "";
            for (int i = 0; i < temp.Length; i++)
            {
                if (i == 0)
                {
                    ivalueconvert += "N'" + temp[i] + "'";
                }
                else
                {
                    ivalueconvert += ",N'" + temp[i] + "'";
                }
            }
            string selectSQl = String.Format("Select C_CODE, C_NAME from DMQUANHUYEN WHERE C_CODE in ({0})", ivalueconvert);
            ITCLIB.Admin.SQL sqlAC = new ITCLIB.Admin.SQL();
            DataTable odata = sqlAC.query_data(selectSQl);
            foreach (DataRow orow in odata.Rows)
            {
                if (control.FindItemByValue(orow["C_CODE"].ToString()) == null)
                {
                    RadListBoxItem item = new RadListBoxItem();
                    item.Value = orow["C_CODE"] != null ? orow["C_CODE"].ToString() : "";
                    item.Text = orow["C_NAME"] != null ? orow["C_NAME"].ToString() : "";
                    control.Items.Add(item);
                }
            }
        }
    }
    protected void RadGridMAVUNGDT_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridMAVUNGDT.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridMAVUNGDT.Rebind();
            }
            foreach (GridDataItem item in RadGridMAVUNGDT.SelectedItems)
            {
                if (!ValidateDeleteGroup(item["pk_id"].Text))
                {
                    SetMessage("Không thể xóa vùng tính cước \"" + item["c_name"].Text + "\" do có tham chiếu dữ liệu khác.");
                    RadGridMAVUNGDT.Rebind();
                }
            }
        }
        else if (e.CommandName == RadGrid.PerformInsertCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            RadListBox RadListBoxQuanHuyenRef = (RadListBox)editItem.FindControl("RadListBoxQuanHuyenRef");
            if (getStringSelect(RadListBoxQuanHuyenRef) != "")
            {
                MAVUNGDTDataSource.InsertParameters["C_DESC"].DefaultValue = getStringSelect(RadListBoxQuanHuyenRef);
            }
        }
        else if (e.CommandName == RadGrid.UpdateCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            RadListBox RadListBoxQuanHuyenRef = (RadListBox)editItem.FindControl("RadListBoxQuanHuyenRef");
            if (getStringSelect(RadListBoxQuanHuyenRef) != "")
            {
                MAVUNGDTDataSource.UpdateParameters["C_DESC"].DefaultValue = getStringSelect(RadListBoxQuanHuyenRef);
            }
        }
    }
    protected static string getStringSelect(RadListBox control)
    {
        string result = "";
        if (control.Items.Count != 0)
        {
            foreach (RadListBoxItem item in control.Items)
            {
                result = ITCLIB.Admin.cFunction.GetStringForList(item.Value, result, ',');
            }
        }
        return result;
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
        string SelectSQL = String.Format("SELECT DMCHITIETCUOCDT.PK_ID FROM from DMCHITIETCUOCDT where FK_MAVUNG= {0}", pkID);
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        rowcount = oDataTable.Rows.Count;
        if (rowcount != 0)
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    protected void RadPanelBarLoadTextfromDept_ItemClick(object sender, RadPanelBarEventArgs e)
    {
        Session["ValueFilter"] = e.Item.Value;
    }
    protected void cmbDoiTac_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cmbDoiTac.Items.Insert(0, new RadComboBoxItem("Tất cả", "0"));
            cmbDoiTac.SelectedIndex = 0;
        }
    }
}