using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

public partial class module_Doanhnghiep : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridDoanhNghieps.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridDoanhNghieps.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridDoanhNghieps.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("DoanhNghieps"))
        {
            ITCLIB.Security.Security.ReturnUrl();
        }
        if (Request["index"] != null && Request["value"] != null)
        {
            string index = Request["index"].ToString();
            string Value = Request["value"].ToString();
        }
        if (!IsPostBack)
        {
            rcbParent.Text = "Doanh nghiệp hoạt động trong khu CNC Hòa lạc";
            rcbParent.SelectedValue = "0";
            hfFilter.Value = "0";
        }
        Session["LastUrl"] = Request.Url.ToString();
    }
    protected void btnShowAll_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadGridDoanhNghieps.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridDoanhNghieps.MasterTableView.RenderColumns)
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
        RadGridDoanhNghieps.MasterTableView.Rebind();
    }
    protected bool CheckName(string idParent, string strName)
    {
        string SelectSQL = String.Format("Select DOANHNGHIEP.TENDOANHNGHIEP FROM DOANHNGHIEP WHERE DOANHNGHIEP.TENDOANHNGHIEP = '{0}' and  DOANHNGHIEP.FK_DOANHNGHIEP = {1} AND DOANHNGHIEP.PK_ID <> {2}", strName, idParent, Session["txtID"]);
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    protected bool CheckNameGiaoDich(string idParent, string strName)
    {
        string SelectSQL = String.Format("Select DOANHNGHIEP.TENGIAODICH FROM DOANHNGHIEP WHERE DOANHNGHIEP.TENGIAODICH = '{0}' and  DOANHNGHIEP.FK_DOANHNGHIEP = {1} AND DOANHNGHIEP.PK_ID <> {2}", strName, idParent, Session["txtID"]);
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    protected bool CheckNameEnglish(string idParent, string strName)
    {
        string SelectSQL = String.Format("Select DOANHNGHIEP.TENTIENGANH FROM DOANHNGHIEP WHERE DOANHNGHIEP.TENTIENGANH = '{0}' and  DOANHNGHIEP.FK_DOANHNGHIEP = {1} AND DOANHNGHIEP.PK_ID <> {2}", strName, idParent, Session["txtID"]);
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    protected bool CheckMaDoanhnghiep(string idParent, string strName)
    {
        string SelectSQL = String.Format("Select DOANHNGHIEP.MADOANHNGHIEP FROM DOANHNGHIEP WHERE DOANHNGHIEP.MADOANHNGHIEP = '{0}' and  DOANHNGHIEP.FK_DOANHNGHIEP = {1} AND DOANHNGHIEP.PK_ID <> {2}", strName, idParent, Session["txtID"]);
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    protected bool CheckMaSothue(string idParent, string strName)
    {
        string SelectSQL = String.Format("Select DOANHNGHIEP.MASOTHUE FROM DOANHNGHIEP WHERE DOANHNGHIEP.MASOTHUE = '{0}' and  DOANHNGHIEP.FK_DOANHNGHIEP = {1} AND DOANHNGHIEP.PK_ID <> {2}", strName, idParent, Session["txtID"]);
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    private void DisplayMessage(string text)
    {
        RadGridDoanhNghieps.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridDoanhNghieps_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridDoanhNghieps_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xóa doanh nghiệp. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa doanh nghiệp thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted DoanhNghieps", e.Item.KeyValues);
            //Rebin Chọ lại phần lọc
            RadTreeView treDoanhNghiep = (RadTreeView)rcbParent.Items[0].FindControl("radViewDoangnghiep");
            RadTreeNode NodeSelect = treDoanhNghiep.FindNodeByValue(hfFilter.Value);
            if (NodeSelect != null)
            {
                rcbParent.Text = NodeSelect.Text;
                rcbParent.SelectedValue = NodeSelect.Value;
            }
        }
    }
    protected void RadGridDoanhNghieps_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới doanh nghiệp. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Tạo mới doanh nghiệp thành công!");
            string newID = getmaxid("DOANHNGHIEP");
            if (Session["NEWIDDK"] != null)
            {
                string sqlUpdate = String.Format("Update DOANHNGHIEP_NGANHNGHESXKD set FK_DOANHNGHIEP ={0} where PK_ID IN ({1})", newID, Session["NEWIDDK"]);
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                SelectQuery.ExecuteNonQuery(sqlUpdate);
            }
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted DoanhNghieps", "{PK_ID:\"" + newID + "\"}");
            //Rebind Chọ lại phần lọc
            RadTreeView treDoanhNghiep = (RadTreeView)rcbParent.Items[0].FindControl("radViewDoangnghiep");
            RadTreeNode NodeSelect = treDoanhNghiep.FindNodeByValue(hfFilter.Value);
            if (NodeSelect != null)
            {
                rcbParent.Text = NodeSelect.Text;
                rcbParent.SelectedValue = NodeSelect.Value;
            }
        }
    }
    protected void RadGridDoanhNghieps_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật doanh nghiệp. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Cập nhật doanh nghiệp thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated DoanhNghieps", e.Item.KeyValues);
            //Rebin Chọ lại phần lọc
            RadTreeView treDoanhNghiep = (RadTreeView)rcbParent.Items[0].FindControl("radViewDoangnghiep");
            RadTreeNode NodeSelect = treDoanhNghiep.FindNodeByValue(hfFilter.Value);
            if (NodeSelect != null)
            {
                rcbParent.Text = NodeSelect.Text;
                rcbParent.SelectedValue = NodeSelect.Value;
            }
        }
    }
    protected void RadGridDoanhNghieps_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadGrid grid = (RadGrid)sender;
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            HiddenField txtID = (HiddenField)editItem.FindControl("txtID");
            Session["txtID"] = (txtID.Value != "") ? txtID.Value : "-1";
            HiddenField hfParent = (HiddenField)editItem.FindControl("hfParent");
            RadComboBox cmbDoanhNghiep = (RadComboBox)editItem.FindControl("rcbParent");
            RadTreeView treDoanhNghiep = (RadTreeView)cmbDoanhNghiep.Items[0].FindControl("RadTreViewDir");
            treDoanhNghiep.ExpandAllNodes();
            if (!e.Item.OwnerTableView.IsItemInserted)
            {
                //Khi sửa Bỏ nhánh con từ điểm hiện tại làm gốc
                RadTreeNode NodeFind = treDoanhNghiep.FindNodeByValue(Session["txtID"].ToString());
                if (NodeFind != null)
                {
                    NodeFind.Visible = false;
                }
                //Set giá trị tại doanh nghiệp trực thuộc
                RadTreeNode NodeSelect = treDoanhNghiep.FindNodeByValue(hfParent.Value);
                if (NodeSelect != null)
                {
                    hfParent.Value = NodeSelect.Value;
                    cmbDoanhNghiep.Text = NodeSelect.Text;
                    cmbDoanhNghiep.SelectedValue = NodeSelect.Value;
                }
            }
            else
            {
                //KHi thêm set mặc định giá trị Conbobox doanh nghiệp cha bằng giá trị đang lọc hiện tại
                if (hfFilter.Value != "")
                {
                    RadTreeNode NodeSelect = treDoanhNghiep.FindNodeByValue(hfFilter.Value);
                    if (NodeSelect != null)
                    {
                        hfParent.Value = NodeSelect.Value;
                        cmbDoanhNghiep.Text = NodeSelect.Text;
                        cmbDoanhNghiep.SelectedValue = NodeSelect.Value;
                    }
                }
            }
        }
        if (e.Item is GridDataItem)
        {
            Label lblSTT = (Label)e.Item.FindControl("lblSTT");
            lblSTT.Text = (e.Item.ItemIndex + 1).ToString();
        }
    }
    protected void RadGridDoanhNghieps_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridDoanhNghieps.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridDoanhNghieps.Rebind();
            }
            foreach (GridDataItem item in RadGridDoanhNghieps.SelectedItems)
            {
                if (!ValidateDeleteGroup(item["pk_id"].Text))
                {
                    SetMessage(String.Format("Không thể xóa doanh nghiệp \"{0}\" do có tham chiếu dữ liệu khác.", item["TENDOANHNGHIEP"].Text));
                    RadGridDoanhNghieps.Rebind();
                }
                else
                    hfFilter.Value = item["FK_DOANHNGHIEP"].Text;
            }
        }
        else if (e.CommandName == RadGrid.PerformInsertCommandName)
        {
            GridEditableItem edititem = (GridEditableItem)e.Item;
            HiddenField hfParent = (HiddenField)edititem.FindControl("hfParent");
            RadComboBox cmbDoanhNghiep = (RadComboBox)edititem.FindControl("rcbParent");
            TextBox txtName = (TextBox)edititem.FindControl("txtName");
            if (CheckName(hfParent.Value, txtName.Text))
            {
                e.Canceled = true;
                Label lbtThongbao = (Label)edititem.FindControl("lbtThongbao");
                lbtThongbao.Text = String.Format("Tên phòng ban đã tồn tại trong chuyên mục cha \"{0}\"", cmbDoanhNghiep.SelectedItem.Text);
            }
            else
            {
                hfFilter.Value = hfParent.Value;
                CheckBox chkChiphoi = (CheckBox)edititem.FindControl("chkChiphoi");
                HiddenField hfchiphoi = (HiddenField)edititem.FindControl("hfchiphoi");
                hfchiphoi.Value = chkChiphoi.Checked ? "1" : "0";
            }
        }
        else if (e.CommandName == RadGrid.UpdateCommandName)
        {
            GridEditableItem edititem = (GridEditableItem)e.Item;
            HiddenField hfParent = (HiddenField)edititem.FindControl("hfParent");
            RadComboBox cmbDoanhNghiep = (RadComboBox)edititem.FindControl("rcbParent");
            TextBox txtName = (TextBox)edititem.FindControl("txtName");
            if (CheckName(hfParent.Value, txtName.Text))
            {
                e.Canceled = true;
                Label lbtThongbao = (Label)edititem.FindControl("lbtThongbao");
                lbtThongbao.Text = String.Format("Tên phòng ban đã tồn tại trong chuyên mục cha \"{0}\"", cmbDoanhNghiep.SelectedItem.Text);
            }
            else
            {
                hfFilter.Value = hfParent.Value;
                CheckBox chkChiphoi = (CheckBox)edititem.FindControl("chkChiphoi");
                HiddenField hfchiphoi = (HiddenField)edititem.FindControl("hfchiphoi");
                hfchiphoi.Value = chkChiphoi.Checked ? "1" : "0";
            }
        }
        else if (e.CommandName == RadGrid.CancelCommandName)
        {
            if (Session["NEWIDDK"] != null)
            {
                string sqlDelete = String.Format("DELETE FROM DOANHNGHIEP_NGANHNGHESXKD where PK_ID IN ({0})", Session["NEWIDDK"]);
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                SelectQuery.ExecuteNonQuery(sqlDelete);
            }
        }
    }
    protected string getmaxid(string table)
    {
        int rowcount = 0;
        string SelectSQL = String.Format("SELECT MAX({0}.PK_ID) as MAXS FROM {0}", table);
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
        string SelectSQL1 = "SELECT PK_ID FROM DOANHNGHIEP WHERE FK_DOANHNGHIEP = " + pkID;
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(String.Format("{0}", SelectSQL1));
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

    protected void RadGridDoanhNghieps_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode && !e.Item.OwnerTableView.IsItemInserted)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            //Set giá trị doanh nghiệp cha
            RadComboBox cmbDoanhNghiep = (RadComboBox)editItem.FindControl("rcbParent");
            if (cmbDoanhNghiep != null)
            {
                cmbDoanhNghiep.OnClientDropDownOpened = "OnClientDropDownOpenedHandler";
                cmbDoanhNghiep.OnClientLoad = "OnClientLoadDoanhNghiep";
                cmbDoanhNghiep.Items[0].Text = ITCLIB.Admin.cFunction.getname(editItem["FK_DOANHNGHIEP"].Text, "DOANHNGHIEP");
                cmbDoanhNghiep.SelectedIndex = 0;
            }
            RadComboBox rcbLoaihinh = (RadComboBox)editItem.FindControl("rcbLoaihinh");
            if (rcbLoaihinh != null)
            {
                rcbLoaihinh.OnClientSelectedIndexChanged = "cmbLoaihinhOnClientSelectedIndexChanged";
                rcbLoaihinh.OnClientLoad = "OnClientLoadcmbLoaihinh";
            }
            RadNumericTextBox txtperVNN = (RadNumericTextBox)editItem.FindControl("txtperVNN");
            if (txtperVNN != null) txtperVNN.ClientEvents.OnLoad = "OnClientLoadtxtvonNNTW";
            RadNumericTextBox txtperVDP = (RadNumericTextBox)editItem.FindControl("txtperVDP");
            if (txtperVDP != null) txtperVDP.ClientEvents.OnLoad = "OnClientLoadtxtVonNNDP";
        }
        if (e.Item is GridEditableItem && e.Item.IsInEditMode && e.Item.OwnerTableView.IsItemInserted)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            RadComboBox cmbDoanhNghiep = (RadComboBox)editItem.FindControl("rcbParent");
            cmbDoanhNghiep.OnClientDropDownOpened = "OnClientDropDownOpenedHandler";
            cmbDoanhNghiep.OnClientLoad = "OnClientLoadDoanhNghiep";
            CheckBox chkChiphoi = (CheckBox)editItem.FindControl("chkChiphoi");
            RadComboBox rcbLoaihinh = (RadComboBox)editItem.FindControl("rcbLoaihinh");
            if (rcbLoaihinh != null)
            {
                rcbLoaihinh.OnClientSelectedIndexChanged = "cmbLoaihinhOnClientSelectedIndexChanged";
                rcbLoaihinh.OnClientLoad = "OnClientLoadcmbLoaihinh";
            }
            RadNumericTextBox txtperVNN = (RadNumericTextBox)editItem.FindControl("txtperVNN");
            if (txtperVNN != null) txtperVNN.ClientEvents.OnLoad = "OnClientLoadtxtvonNNTW";
            RadNumericTextBox txtperVDP = (RadNumericTextBox)editItem.FindControl("txtperVDP");
            if (txtperVDP != null) txtperVDP.ClientEvents.OnLoad = "OnClientLoadtxtVonNNDP";
            chkChiphoi.Enabled = false;
            txtperVDP.Enabled = false;
            txtperVNN.Enabled = false;
        }
    }
    protected void lblcap_PreRender(object sender, EventArgs e)
    {
        Label titile = (Label)sender;
        if (hfFilter.Value != "0" && hfFilter.Value != "")
        {
            titile.Text = "Danh sách doanh nghiệp con thuộc:"+ ITCLIB.Admin.cFunction.LoadFieldfromTable(hfFilter.Value, "TENDOANHNGHIEP", "DOANHNGHIEP");
        }
        else { titile.Text = "Quản lý doanh nghiệp"; }
    }
    protected string checkHasParent(string iddoanhnghiep)
    {
        string sqlCheck = "select * from DOANHNGHIEP where FK_DOANHNGHIEP = " + iddoanhnghiep;
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(sqlCheck);
        string result = "";
        if (oDataTable.Rows.Count != 0 && oDataTable.Rows[0]["FK_DOANHNGHIEP"] != null)
        {
            result = oDataTable.Rows[0]["FK_DOANHNGHIEP"].ToString();
        }
        return result;
    }
    protected bool getChiphoi(object ivalue)
    {
        if (ivalue != DBNull.Value)
        {
            if (int.Parse(ivalue.ToString()) == 1)
                return true;
            else return false;
        }
        else return false;
    }
    protected bool SetEnable(object ivalue, string para)
    {
        if (ivalue != DBNull.Value)
        {
            string tenloaihinh = ITCLIB.Admin.cFunction.getname(ivalue.ToString(), "DMLOAIHINHDN");
            if (tenloaihinh == "Cty CP, Cty TNHH có vốn Nhà nước > 50%")
            {
                switch (para)
                {
                    case "1": return true;
                    case "2": return true;
                    case "3": return false;
                    default: return false;
                }
            }
            else if (tenloaihinh == "Công ty TNHH tư nhân, Công ty TNHH có vốn Nhà nước ≤ 50%")
            {
                switch (para)
                {
                    case "1": return true;
                    case "2": return false;
                    case "3": return false;
                    default: return false;
                }
            }
            else if (tenloaihinh == "Công ty cổ phần có vốn Nhà nước ≤ 50%")
            {
                switch (para)
                {
                    case "1": return false;
                    case "2": return false;
                    case "3": return true;
                    default: return false;
                }
            }
            else
            {
                return false;
            }
        }
        else return false;
    }
}