using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class Modules_UserAdmins : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridUserAdmin.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridUserAdmin.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridUserAdmin.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("NHANVIEN"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        Session["LastUrl"] = Request.Url.ToString();
    }
    protected void btnShowAll_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadGridUserAdmin.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridUserAdmin.MasterTableView.RenderColumns)
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
        RadGridUserAdmin.MasterTableView.Rebind();
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
        RadGridUserAdmin.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridUserAdmin_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridUserAdmin_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xoá người dùng. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa người dùng thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted UserAdmins", e.Item.GetDataKeyValue("PK_ID").ToString());
        }
    }
    protected void RadGridUserAdmin_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới người dùng. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Tạo mới người dùng thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted UserAdmins", (e.Item.FindControl("txtLoginName") as TextBox).Text);
        }
    }
    protected void RadGridUserAdmin_ItemUpdated(object sender, GridUpdatedEventArgs e)
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
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated UserAdmins", e.Item.GetDataKeyValue("PK_ID").ToString());
        }
    }
    protected void RadGridUserAdmin_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridUserAdmin.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridUserAdmin.Rebind();
            }
            foreach (GridDataItem item in RadGridUserAdmin.SelectedItems)
            {
                if (!ValidateDeleteUserAdmin(item["PK_ID"].Text))
                {
                    SetMessage("Không thể xóa người dùng (ID: " + item["PK_ID"].Text + ")");
                    RadGridUserAdmin.Rebind();
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
                UserAdminsDataSource.UpdateParameters["C_Password"].DefaultValue = encryptpass;
            }
            RadTreeView tvDept = (RadTreeView)editItem.FindControl("tvDept");
            string raddrivervalue = "";
            IList<RadTreeNode> nodeCollection = tvDept.CheckedNodes;
            foreach (RadTreeNode node in nodeCollection)
            {
                if (raddrivervalue == "")
                {
                    raddrivervalue += node.Value;
                }
                else
                {
                    raddrivervalue += "," + node.Value;
                }
            }
            UserAdminsDataSource.UpdateParameters["FK_DEPT"].DefaultValue = raddrivervalue;
        }
        else if (e.CommandName == RadGrid.PerformInsertCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            TextBox txtPassword = (TextBox)editItem.FindControl("txtPassword");
            if (txtPassword.Text.Trim() != "")
            {
                string encryptpass = ITCLIB.Security.Security.Encrypt(txtPassword.Text.Trim());
                UserAdminsDataSource.InsertParameters["C_Password"].DefaultValue = encryptpass;
            }
            RadTreeView tvDept = (RadTreeView)editItem.FindControl("tvDept");
            string raddrivervalue = "";
            IList<RadTreeNode> nodeCollection = tvDept.CheckedNodes;
            foreach (RadTreeNode node in nodeCollection)
            {
                if (raddrivervalue == "")
                {
                    raddrivervalue += node.Value;
                }
                else
                {
                    raddrivervalue += "," + node.Value;
                }
            }
            UserAdminsDataSource.InsertParameters["FK_DEPT"].DefaultValue = raddrivervalue;
        }
    }
    protected void RadGridUserAdmin_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
        }
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            TextBox txtID = (TextBox)editItem.FindControl("txtID");
            Session["txtID"] = txtID.Text;
            HiddenField hfFK_DEPT = (HiddenField)editItem.FindControl("hfFK_DEPT");
            RadTreeView tvDept = (RadTreeView)editItem.FindControl("tvDept");
            tvDept.ExpandAllNodes();
            string drivervalue = hfFK_DEPT.Value;
            if (drivervalue != "")
            {
                string[] drivers = drivervalue.Split(',');
                foreach (string driver in drivers)
                {
                    if (tvDept.FindNodeByValue(driver) != null)
                    {
                        tvDept.FindNodeByValue(driver).Checked = true;
                    }
                }
            }
            if (e.Item is GridEditFormInsertItem || e.Item is GridDataInsertItem)
            {
                // insert item
                RadComboBox cmbVungLamViec = (RadComboBox)editItem.FindControl("cmbVungLamViec");
                cmbVungLamViec.SelectedIndex = 0;
            }
        }
    }
    protected bool ValidateDeleteUserAdmin(string guID)
    {
        /*if (guID == "0" || guID == "1")
        {
            return false;
        }
        else
        {
            string SelectSQL = "SELECT USERS.PK_ID FROM USERS WHERE USERS.FK_User = " + guID;
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
