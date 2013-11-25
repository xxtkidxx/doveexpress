using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;

public partial class Depts : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sBrowserType = Request.Browser.Type;
        switch (sBrowserType)
        {
            case "IE6":
                RadGridDefts.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            case "IE7":
                RadGridDefts.MasterTableView.EditFormSettings.PopUpSettings.Modal = false;
                break;
            default:
                RadGridDefts.MasterTableView.EditFormSettings.PopUpSettings.Modal = true;
                break;
        }
        if (!ITCLIB.Security.Security.CanViewModule("PHONGBAN"))
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
    protected bool LoadRootDept()
    {
        string SelectSQL = String.Format("Select DMPHONGBAN.PK_ID FROM DMPHONGBAN WHERE DMPHONGBAN.C_PARENT IS NULL");
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            return true;
        }
        else
        {
            string DOANHNGHIEPNAME = "";
                if (Session["DOANHNGHIEP"].ToString() == "0")
                {
                    DOANHNGHIEPNAME = "Chuyển phát nhanh Bồ Câu - Dove Express";
                }else
                {
                    DOANHNGHIEPNAME = ITCLIB.Admin.cFunction.LoadFieldfromTable(Session["DOANHNGHIEP"].ToString(),"TENDOANHNGHIEP","DOANHNGHIEP");
                }
                string InsertSQL = String.Format("INSERT INTO DMPHONGBAN (C_PARENT,C_NAME) VALUES ({0},N'{1}')","NULL", DOANHNGHIEPNAME);
            ITCLIB.Admin.SQL InsertQuery = new ITCLIB.Admin.SQL();
            InsertQuery.ExecuteNonQuery(InsertSQL);
            RadPanelBarListDept.DataBind();
            return false;
        }
    }
    protected void btnShowAll_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadGridDefts.MasterTableView.FilterExpression = string.Empty;
        foreach (GridColumn column in RadGridDefts.MasterTableView.RenderColumns)
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
        RadGridDefts.MasterTableView.Rebind();
    }
    protected bool CheckName(string idParent, string strName)
    {
        string SelectSQL = String.Format("Select DMPHONGBAN.C_NAME FROM DMPHONGBAN WHERE DMPHONGBAN.C_NAME = '{0}' and  DMPHONGBAN.c_parent = {1} AND DMPHONGBAN.PK_ID <> {2}", strName, idParent, Session["txtID"]);
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(SelectSQL);
        if (oDataTable.Rows.Count != 0)
        {
            return true ;
        }
        else
        {
            return false;
        }
    }
    private void DisplayMessage(string text)
    {
        RadGridDefts.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
    }
    private void SetMessage(string message)
    {
        gridMessage = message;
    }
    private string gridMessage = null;
    protected void RadGridDefts_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(gridMessage))
        {
            DisplayMessage(gridMessage);
        }
    }
    protected void RadGridDefts_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể xóa phòng ban, bộ phận. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Xóa phòng ban, bộ phận thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Deleted DeptOffices", e.Item.KeyValues);
            RadPanelBarListDept.DataBind();
        }
    }
    protected void RadGridDefts_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            SetMessage("Không thể tạo mới phòng ban, bộ phận. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Tạo mới phòng ban, bộ phận thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Inserted DeptOffices", "{PK_ID:\"" + getmaxid("DMPHONGBAN") + "\"}");
            RadPanelBarListDept.DataBind();
        }
    }
    protected void RadGridDefts_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            SetMessage("Không thể cập nhật phòng ban, bộ phận. Lý do: " + e.Exception.Message);
        }
        else
        {
            SetMessage("Cập nhật phòng ban, bộ phận thành công!");
            ITCLIB.ActionLog.ActionLog.WriteLog(Session["UserID"].ToString(), "Updated DeptOffices", e.Item.KeyValues);
            RadPanelBarListDept.DataBind();
        }
    }
    protected void RadGridDefts_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadGrid grid = (RadGrid)sender;
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            HiddenField txtID = (HiddenField)editItem.FindControl("txtID");
            Session["txtID"] = (txtID.Value !="" )?  txtID.Value : "0";
            HiddenField hfID = (HiddenField)editItem.FindControl("hfID");            
            RadComboBox cmbDept = (RadComboBox)editItem.FindControl("rcbParent");
            RadTreeView treDept = (RadTreeView)cmbDept.Items[0].FindControl("RaTreViewDir");
            treDept.ExpandAllNodes();
            if (!e.Item.OwnerTableView.IsItemInserted)
            {
                Session["paID"] = hfID.Value; 
                RadTreeNode NodeFind = treDept.FindNodeByValue(Session["txtID"].ToString());
                if (NodeFind != null)
                {
                    NodeFind.Visible = false;
                }
            }
            else
            {
                if (Session["paID"] != null)
                {
                    RadTreeNode NodeSelect = treDept.FindNodeByValue(Session["paID"].ToString());
                    if (NodeSelect != null)
                    {
                        hfID.Value = NodeSelect.Value;
                        cmbDept.Text = NodeSelect.Text;
                        cmbDept.SelectedValue = NodeSelect.Value;
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
    protected void RadGridDefts_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "DeleteSelected")
        {
            if (RadGridDefts.SelectedIndexes.Count == 0)
            {
                SetMessage("Không có bản ghi được chọn!");
                RadGridDefts.Rebind();
            }
            foreach (GridDataItem item in RadGridDefts.SelectedItems)
            {
                if (!ValidateDeleteGroup(item["pk_id"].Text))
                {
                    SetMessage(String.Format("Không thể xóa phòng ban, bộ phận \"{0}\" do có tham chiếu dữ liệu khác.", item["c_name"].Text));
                    RadGridDefts.Rebind();
                }
            }
        }
        else if (e.CommandName == RadGrid.PerformInsertCommandName)
        {
            GridEditableItem edititem = (GridEditableItem)e.Item;
            HiddenField hfParent = (HiddenField)edititem.FindControl("hfID");
            RadComboBox cmbDept = (RadComboBox)edititem.FindControl("rcbParent");
            TextBox txtName = (TextBox)edititem.FindControl("txtName");
            if (CheckName(hfParent.Value, txtName.Text))
            { 
                e.Canceled = true;
                Label lbtThongbao = (Label)edititem.FindControl("lbtThongbao");
                lbtThongbao.Text = String.Format("Tên phòng ban đã tồn tại trong chuyên mục cha \"{0}\"", cmbDept.SelectedItem.Text);
            }
            else
            {
                Session["paID"] = hfParent.Value;                
            }
        }

        else if (e.CommandName == RadGrid.UpdateCommandName)
        {
            GridEditableItem edititem = (GridEditableItem)e.Item;
            HiddenField hfParent = (HiddenField)edititem.FindControl("hfID");
            RadComboBox cmbDept = (RadComboBox)edititem.FindControl("rcbParent");
            TextBox txtName = (TextBox)edititem.FindControl("txtName");
            if (CheckName(hfParent.Value, txtName.Text))
            {
                e.Canceled = true;
                Label lbtThongbao = (Label)edititem.FindControl("lbtThongbao");
                lbtThongbao.Text = String.Format("Tên phòng ban đã tồn tại trong chuyên mục cha \"{0}\"", cmbDept.SelectedItem.Text);
            }
            else
            {
                Session["paID"] = hfParent.Value;
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
        string SelectSQL1 = "SELECT PK_ID FROM USERS WHERE USERS.FK_PHONGBAN = " + pkID;
        string SelectSQL2 = "SELECT PK_ID FROM DMPHONGBAN WHERE DMPHONGBAN.c_parent = " + pkID;
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(String.Format("{0} UNION {1}", SelectSQL1, SelectSQL2));
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
    protected void RadGridDefts_ItemCreated(object sender, GridItemEventArgs e)
    {
        LoadRootDept();
        if (e.Item is GridEditableItem && e.Item.IsInEditMode && !e.Item.OwnerTableView.IsItemInserted)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            RadComboBox cmbDept = (RadComboBox)editItem.FindControl("rcbParent");
            cmbDept.OnClientDropDownOpened = "OnClientDropDownOpenedHandler";
            cmbDept.OnClientLoad = "OnClientLoadDEPT";
            cmbDept.Items[0].Text = ITCLIB.Admin.cFunction.getname(editItem["c_parent"].Text, "DMPHONGBAN");
            cmbDept.SelectedIndex = 0;
        }
        if (e.Item is GridEditableItem && e.Item.IsInEditMode && e.Item.OwnerTableView.IsItemInserted)
        {
            GridEditableItem editItem = (GridEditableItem)e.Item;
            RadComboBox cmbDept = (RadComboBox)editItem.FindControl("rcbParent");
            cmbDept.OnClientDropDownOpened = "OnClientDropDownOpenedHandler";
            cmbDept.OnClientLoad = "OnClientLoadDEPT";
        }
    }
    protected void RadGridDefts_PreRender(object sender, EventArgs e)
    {

    }
    protected void lblcap_PreRender(object sender, EventArgs e)
    {
        Label titile = (Label)sender;
        if (Session["paID"] != null)
        {
            titile.Text = ITCLIB.Admin.cFunction.getname(Session["paID"].ToString(), "DMPHONGBAN");
        }
        else { titile.Text = ""; }
    }
    protected void RadPanelBarListText_ItemDataBound(object sender, RadPanelBarEventArgs e)
    {
        RadPanelItem item = (RadPanelItem)e.Item;
        if (item.Text != "Đơn vị nội bộ")
        {
            item.ImageUrl = "../images/folder-closed.gif";
            item.SelectedImageUrl = "../images/folder_open.png";
        }
    }
    protected void RadPanelBarListDept_ItemClick(object sender, RadPanelBarEventArgs e)
    {
        Session["paID"] = RadPanelBarListDept.SelectedItem.Value;
        RadGridDefts.DataBind();
    }
    protected void RadPanelBarListDept_PreRender(object sender, EventArgs e)
    {
        if (Session["paID"] != null)
        {
            RadPanelItem item = (RadPanelItem)RadPanelBarListDept.FindItemByValue(Session["paID"].ToString());            
            string idDEPT = Session["paID"].ToString();
            while (checkHasParent(idDEPT)!="")
            {
                idDEPT = checkHasParent(idDEPT);
                RadPanelItem itemParent = (RadPanelItem)RadPanelBarListDept.FindItemByValue(idDEPT);
                if (itemParent != null) itemParent.Expanded = true;
            }
            if (item != null)
            {
                item.Expanded = true;
                item.Selected = true;
            }
        }
        else
        {
            if (!IsPostBack)
            {
                RadPanelItem item = (RadPanelItem)RadPanelBarListDept.Items[0];
                if (item != null)
                {
                    Session["paID"] = item.Value;
                    item.Expanded = true;
                    item.Selected = true;
                }
            }
        }
    }
    protected string checkHasParent(string iddep)
    {
        string sqlCheck = "select * from DMPHONGBAN where PK_ID = " + iddep;
        DataTable oDataTable = new DataTable();
        ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
        oDataTable = SelectQuery.query_data(sqlCheck);
        string result="";
        if (oDataTable.Rows.Count != 0 && oDataTable.Rows[0]["c_parent"] != null)
        {
            result = oDataTable.Rows[0]["c_parent"].ToString();
        }
        return result;
    } 
}