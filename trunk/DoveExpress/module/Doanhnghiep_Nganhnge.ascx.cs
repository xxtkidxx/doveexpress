using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;

public partial class module_Doanhnghiep_Nganhnge : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridDoanhnghiep_NganhngheDKSXKD.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridDoanhnghiep_NganhngheDKSXKD.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridDoanhnghiep_NganhngheDKSXKD.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
    }

    protected void CheckName(object source, ServerValidateEventArgs args)
    {
        string SelectSQL;
        SelectSQL = "Select DMTRINHDO.C_NAME FROM DMTRINHDO WHERE DMTRINHDO.C_NAME = '" + args.Value + "' AND DMTRINHDO.PK_ID <> " + Session["txtID"].ToString();
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
        RadGridDoanhnghiep_NganhngheDKSXKD.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridDoanhnghiep_NganhngheDKSXKD_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridDoanhnghiep_NganhngheDKSXKD_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xoá. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa thành công!");
        }
    }
    protected void RadGridDoanhnghiep_NganhngheDKSXKD_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới . Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Tạo mới thành công!"); 
        }
    }
    protected void RadGridDoanhnghiep_NganhngheDKSXKD_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Cập nhật thành công!");
        }
    }
    protected void RadGridDoanhnghiep_NganhngheDKSXKD_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridDoanhnghiep_NganhngheDKSXKD.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridDoanhnghiep_NganhngheDKSXKD.Rebind();
            }
            foreach (GridDataItem item in RadGridDoanhnghiep_NganhngheDKSXKD.SelectedItems)
            {
                RadGridDoanhnghiep_NganhngheDKSXKD.Rebind();
            }
        }
        else if (e.CommandName == RadGrid.PerformInsertCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            CheckBox chkStatus = (CheckBox)editItem.FindControl("chkStatus");
            if (chkStatus.Checked)
            {
                string sqlUpdate = "Update DOANHNGHIEP_NGANHNGHESXKD set C_STATUS ='False'";
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                SelectQuery.ExecuteNonQuery(sqlUpdate);
            }
            DoanhNghiep_NganhngheDataSource.InsertParameters["C_STATUS"].DefaultValue = chkStatus.Checked ? "TRUE" : "FALSE";
        }
        else if (e.CommandName == RadGrid.UpdateCommandName)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            CheckBox chkStatus = (CheckBox)editItem.FindControl("chkStatus");
            if (chkStatus.Checked)
            {
                string sqlUpdate = "Update DOANHNGHIEP_NGANHNGHESXKD set C_STATUS ='False'";
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                SelectQuery.ExecuteNonQuery(sqlUpdate);
            }
            DoanhNghiep_NganhngheDataSource.UpdateParameters["C_STATUS"].DefaultValue = chkStatus.Checked ? "TRUE" : "FALSE";
        }

    }
    private int total = 0;
    protected void RadGridDoanhnghiep_NganhngheDKSXKD_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadGrid grid = (RadGrid)sender;
        if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
        {
            GridEditFormItem editItem = (GridEditFormItem)e.Item;
            HiddenField txtID = (HiddenField)editItem.FindControl("txtID");
            Session["txtID"] = (txtID.Value != "") ? txtID.Value : "0";
        }
        if (e.Item is GridDataItem)
        {
            Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            if (lblSTT != null)
                lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
        }
    }
    protected void DoanhNghiep_NganhngheDataSource_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        string NewID = e.Command.Parameters["@NEWIDDK"].Value.ToString();
        string NewIDVON;
        if (Session["NEWIDDK"] != null)
        {
            NewIDVON = Session["NEWIDDK"].ToString();
            Session["NEWIDDK"] = NewIDVON + "," + NewID;
        }
        else
        {
            Session["NEWIDDK"] = NewID;
        }
    }
    protected bool getstauts(object ivalue)
    {
        if (ivalue == DBNull.Value)
            return false;
        else return (bool)ivalue;
    }
}