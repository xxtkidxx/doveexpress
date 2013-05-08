using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class company_GroupUsers : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridGroupUser.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridGroupUser.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridGroupUser.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.IsSysAdmin())
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        if (Request["index"] != null && Request["value"] != null)
        {
            string index = Request["index"].ToString();
            string Value = Request["value"].ToString();
        } 
    }
    protected void btnShowAll_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadGridGroupUser.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridGroupUser.MasterTableView.RenderColumns)
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
        RadGridGroupUser.MasterTableView.Rebind();
    }
    protected void CheckID(object source, ServerValidateEventArgs args)
    {
        if (Session["txtID"].ToString() == "")
        {
            string SelectSQL = "Select GROUPUSER.PK_ID FROM GROUPUSER WHERE GROUPUSER.PK_ID = '" + args.Value + "'";
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
        else
        {
            args.IsValid = true;
        }
    }
    protected void CheckName(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        SelectSQL = "Select GROUPUSER.C_NAME FROM GROUPUSER WHERE GROUPUSER.C_NAME = '" + args.Value + "' AND GROUPUSER.PK_ID <> " + Session["txtID"].ToString();
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
        RadGridGroupUser.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridGroupUser_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridGroupUser_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xóa nhóm người dùng. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa nhóm người dùng thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted GroupUsers", e.Item.GetDataKeyValue("PK_ID").ToString());
        }
    }
    protected void RadGridGroupUser_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới nhóm người dùng. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Tạo mới nhóm người dùng thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted GroupUsers", (e.Item.FindControl("txtID") as RadTextBox).Text);
        }
    }
    protected void RadGridGroupUser_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật nhóm người dùng. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Cập nhật nhóm người dùng thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated GroupUsers", e.Item.GetDataKeyValue("PK_ID").ToString());
        }
    }
    protected void RadGridGroupUser_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            RadTextBox txtID = (RadTextBox)editItem.FindControl("txtID");
            Session["txtID"] = txtID.Text;
        } 
    }
    protected void RadGridGroupUser_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridGroupUser.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridGroupUser.Rebind();
            }
            foreach (GridDataItem item in RadGridGroupUser.SelectedItems)
            {
                if (!ValidateDeleteGroup(item["PK_ID"].Text))
                {
                    SetMessage("Không thể xóa nhóm \"" + item["GroupUserName"].Text + "\" do nhóm có chứa người dùng.");
                    RadGridGroupUser.Rebind();        
                }                
            }       
        }
    }
    protected bool ValidateDeleteGroup(string guID)
    {
        if (guID == "0" || guID == "1")
        {
            return false;
        }
        else
        {
            string SelectSQL = "SELECT USERS.PK_ID FROM USERS WHERE USERS.FK_GROUPUSER = " + guID;
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                return false;
            }
            else
            {
                Group_Deleteing(guID);
                return true;
            }
        }
    }
    protected void Group_Deleteing(string FK_GROUPUSER)
    {
        string sqldelete = "Delete from GROUPUSER_MODULE where FK_GROUPUSER =" + FK_GROUPUSER;
        ITCLIB.Admin.SQL acess = new ITCLIB.Admin.SQL();
        acess.ExecuteNonQuery(sqldelete);
    }
}
