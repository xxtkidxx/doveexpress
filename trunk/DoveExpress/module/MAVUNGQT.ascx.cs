using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class module_MAVUNGQT : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridMAVUNGQT.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridMAVUNGQT.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridMAVUNGQT.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
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
        if (!IsPostBack)
        {
            Session["ValueFilter"] = 0;
        }
    }
    protected void btnShowAll_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadGridMAVUNGQT.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridMAVUNGQT.MasterTableView.RenderColumns)
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
        RadGridMAVUNGQT.MasterTableView.Rebind();
    }
    protected void CheckCode(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        SelectSQL = "Select DMMAVUNG.C_CODE FROM DMMAVUNG WHERE DMMAVUNG.C_CODE = '" + args.Value + "' AND DMMAVUNG.PK_ID <> " + Session["txtID"].ToString();
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
    protected void CheckName(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        SelectSQL = "Select DMMAVUNG.C_NAME FROM DMMAVUNG WHERE DMMAVUNG.C_NAME = '" + args.Value + "' AND DMMAVUNG.PK_ID <> " + Session["txtID"].ToString();
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
        RadGridMAVUNGQT.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridMAVUNGQT_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridMAVUNGQT_ItemDeleted(object sender, GridDeletedEventArgs e)
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
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted MAVUNGQTs", e.Item.KeyValues);
        }
    }
    protected void RadGridMAVUNGQT_ItemInserted(object sender, GridInsertedEventArgs e)
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
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted MAVUNGQTs", "{PK_ID:\"" + getmaxid("DMMAVUNG") + "\"}");
        }
    }
    protected void RadGridMAVUNGQT_ItemUpdated(object sender, GridUpdatedEventArgs e)
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
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated MAVUNGQTs", e.Item.KeyValues);
        }
    }
    protected void RadGridMAVUNGQT_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadGrid grid = (RadGrid)sender;
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            HiddenField txtID = (HiddenField)editItem.FindControl("txtID");
            Session["txtID"] = (txtID.Value != "") ? txtID.Value : "0";
            RadListBox RadListBoxQuocGiaRef = (RadListBox)editItem.FindControl("RadListBoxQuocGiaRef");
            HiddenField txtC_DESC = (HiddenField)editItem.FindControl("txtC_DESC");
            setItenforListBoxSelect(RadListBoxQuocGiaRef, txtC_DESC.Value);
            RadComboBox cmbSanPham = (RadComboBox)editItem.FindControl("cmbSanPham");
            cmbSanPham.SelectedIndex = 0;
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
            string selectSQl = String.Format("Select C_CODE, C_NAME from DMQUOCGIA WHERE C_CODE in ({0})", ivalueconvert);
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
    protected void RadGridMAVUNGQT_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridMAVUNGQT.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridMAVUNGQT.Rebind();
            }
            foreach (GridDataItem item in RadGridMAVUNGQT.SelectedItems)
            {
                if (!ValidateDeleteGroup(item["pk_id"].Text))
                {
                    SetMessage("Không thể xóa vùng tính cước \"" + item["c_name"].Text + "\" do có tham chiếu dữ liệu khác.");
                    RadGridMAVUNGQT.Rebind();
                }
            }
        }
        else if (e.CommandName == RadGrid.PerformInsertCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            RadListBox RadListBoxQuocGiaRef = (RadListBox)editItem.FindControl("RadListBoxQuocGiaRef");
            if (getStringSelect(RadListBoxQuocGiaRef) != "")
            {
                MAVUNGQTDataSource.InsertParameters["C_DESC"].DefaultValue = getStringSelect(RadListBoxQuocGiaRef);
            }
        }
        else if (e.CommandName == RadGrid.UpdateCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            RadListBox RadListBoxQuocGiaRef = (RadListBox)editItem.FindControl("RadListBoxQuocGiaRef");
            if (getStringSelect(RadListBoxQuocGiaRef) != "")
            {
                MAVUNGQTDataSource.UpdateParameters["C_DESC"].DefaultValue = getStringSelect(RadListBoxQuocGiaRef);
            }
        }
    }
    protected static string getStringSelect(RadListBox control)
    {
        string result = "";
        if (control.Items.Count !=0)
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
        string SelectSQL = String.Format("SELECT DMCHITIETCUOC.PK_ID FROM from DMCHITIETCUOC where FK_MAVUNG= {0}", pkID);
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
}