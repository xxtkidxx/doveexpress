using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class Modules_UserCompanys : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridUserCompany.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridUserCompany.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridUserCompany.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("UserCompanys"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        Session["LastUrl"] = Request.Url.ToString();
    }
    protected void btnShowAll_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadGridUserCompany.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridUserCompany.MasterTableView.RenderColumns)
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
        RadGridUserCompany.MasterTableView.Rebind();
    }
    protected void CheckCompany(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        Session["txtID"] = (Session["txtID"].ToString() == "") ? 0 : Session["txtID"];
        SelectSQL = "Select USERS.FK_COMPANY FROM USERS WHERE USERS.FK_COMPANY = '" + args.Value + "' AND USERS.PK_ID <> " + Session["txtID"].ToString();
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
    protected void CheckLoginName(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        Session["txtID"] = (Session["txtID"].ToString() == "") ? 0 : Session["txtID"];
        SelectSQL = "Select USERS.C_LOGINNAME FROM USERS WHERE USERS.C_LOGINNAME = N'" + args.Value + "' AND USERS.PK_ID <> " + Session["txtID"].ToString();
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
        RadGridUserCompany.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridUserCompany_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridUserCompany_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể người dùng. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa người dùng thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted UserCompanys", e.Item.GetDataKeyValue("PK_ID").ToString());
        }
    }
    protected void RadGridUserCompany_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới người dùng. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Tạo mới người dùng thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted UserCompanys", (e.Item.FindControl("txtLoginName") as TextBox).Text);
        }
    }
    protected void RadGridUserCompany_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật người dùng. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Cập nhật người dùng thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated UserCompanys", e.Item.GetDataKeyValue("PK_ID").ToString());
        }
    }
    protected void RadGridUserCompany_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridUserCompany.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridUserCompany.Rebind();
            }
            foreach (GridDataItem item in RadGridUserCompany.SelectedItems)
            {
                if (!ValidateDeleteUserCompany(item["PK_ID"].Text))
                {
                    SetMessage("Không thể xóa người dùng (ID: " + item["PK_ID"].Text + ")");
                    RadGridUserCompany.Rebind();
                }
            }
        }
        else if (e.CommandName == RadGrid.UpdateCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            TextBox txtPassword = (TextBox)editItem.FindControl("txtPassword");
            if (txtPassword.Text.Trim() != "")
            {
                string encryptpass = ITCLIB.Security.Security.Encrypt(txtPassword.Text.Trim());
                UserCompanysDataSource.UpdateParameters["C_Password"].DefaultValue = encryptpass;
            }
        }
        else if (e.CommandName == RadGrid.PerformInsertCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            TextBox txtPassword = (TextBox)editItem.FindControl("txtPassword");
            if (txtPassword.Text.Trim() != "")
            {
                string encryptpass = ITCLIB.Security.Security.Encrypt(txtPassword.Text.Trim());
                UserCompanysDataSource.InsertParameters["C_Password"].DefaultValue = encryptpass;
            }
        }
    }
    protected void RadGridUserCompany_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
        }
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            RadComboBox cmbDoanhNghiep = (RadComboBox)editItem.FindControl("rcbParent");
            cmbDoanhNghiep.OnClientDropDownOpened = "OnClientDropDownOpenedHandler";
            cmbDoanhNghiep.OnClientLoad = "OnClientLoadDoanhNghiep";
            TextBox txtID = (TextBox)editItem.FindControl("txtID");
            Session["txtID"] = txtID.Text;
            HiddenField hfParent = (HiddenField)editItem.FindControl("hfParent");
            RadTreeView treDoanhNghiep = (RadTreeView)cmbDoanhNghiep.Items[0].FindControl("RadTreViewDir");
            treDoanhNghiep.ExpandAllNodes();
            RadTreeNode nodeselect = (RadTreeNode)treDoanhNghiep.FindNodeByValue(hfParent.Value);
            if (nodeselect != null)
            {
                cmbDoanhNghiep.Text = nodeselect.Text;
                cmbDoanhNghiep.SelectedValue = nodeselect.Value;
            }
            if (e.Item is GridEditFormInsertItem || e.Item is GridDataInsertItem)
            {
                // insert item
            }
            else
            {
                // edit item
                cmbDoanhNghiep.Enabled = false;
            }            
        }
    }
    protected bool ValidateDeleteUserCompany(string guID)
    {
        /*if (guID == "0" || guID == "1")
        {
            return false;
        }
        else
        {
            string SelectSQL = "SELECT USERS.PK_ID FROM USERS WHERE USERS.FK_User = " + guID;
            DataTable oDataTable = new DataTable();
            ITC.Admin.SQL SelectQuery = new ITC.Admin.SQL();
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
