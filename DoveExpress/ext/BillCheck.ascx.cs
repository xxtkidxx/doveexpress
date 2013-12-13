using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;

public partial class ext_BillCheck : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void imgSearch_Click(object sender, ImageClickEventArgs e)
    {
        RadAjaxManager ajaxManager = RadAjaxManager.GetCurrent(Page);
        if (txtBILL.Text.Trim() != "")
        {            
            string SelectSQL = "SELECT NHANGUI.*,DMMASANPHAM.C_NAME as DICHVUNAME FROM NHANGUI LEFT OUTER JOIN DMMASANPHAM ON NHANGUI.FK_MASANPHAM = DMMASANPHAM.PK_ID WHERE C_BILL = " + txtBILL.Text.Trim();
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                lblDichvu.Text = (oDataTable.Rows[0]["DICHVUNAME"].ToString() == "") ? "-" : oDataTable.Rows[0]["DICHVUNAME"].ToString();
                lblNguoigui.Text = (oDataTable.Rows[0]["C_TENKH"].ToString() == "") ? "-" : oDataTable.Rows[0]["C_TENKH"].ToString();
                lblNgaygui.Text = String.Format("{0:dd/MM/yyyy}", DateTime.Parse(oDataTable.Rows[0]["C_NGAY"].ToString()));
                lblNguoinhan.Text = (oDataTable.Rows[0]["C_NGUOINHAN"].ToString() == "") ? "-" : oDataTable.Rows[0]["C_NGUOINHAN"].ToString();
                lblDiachinhan.Text = (oDataTable.Rows[0]["C_DIACHINHAN"].ToString() == "") ? "-" : oDataTable.Rows[0]["C_DIACHINHAN"].ToString();
                if (oDataTable.Rows[0]["C_NGAYGIOPHAT"] != DBNull.Value)
                {
                    lblNgaynhan.Text = String.Format("{0:dd/MM/yyyy hh:mm:ss tt}", DateTime.Parse(oDataTable.Rows[0]["C_NGAYGIOPHAT"].ToString()));
                }
                else
                {
                    lblNgaynhan.Text = "-";
                }
                if (oDataTable.Rows[0]["C_TYPE"].ToString() == "2")
                {
                    lblQuanhuyen.Text = "Quốc gia";
                    lblQuanhuyenValue.Text = ITCLIB.Admin.cFunction.LoadQuocGiaName(oDataTable.Rows[0]["FK_QUOCGIA"].ToString());
                }
                else
                {
                    lblQuanhuyenValue.Text = ITCLIB.Admin.cFunction.LoadTinhThanhName(oDataTable.Rows[0]["FK_QUANHUYEN"].ToString()) + " / " + ITCLIB.Admin.cFunction.LoadQuanHuyenName(oDataTable.Rows[0]["FK_QUANHUYEN"].ToString());
                }
                LoadGrid();
            }
            else
            {
                ajaxManager.Alert("Không tồn tại BILL " + txtBILL.Text.Trim() + " trong dữ liệu DoveExpress");
            }
        }
        else
        {
            ajaxManager.Alert("Hãy nhập BILL để kiểm tra trạng thái");
        }
    }
    protected void LoadGrid()
    {
        ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
        DataTable oDataTable = new DataTable();
        string SelectString = "SELECT [TRACKING].[PK_ID], [TRACKING].[C_BILL], [TRACKING].[C_DATE], [TRACKING].[FK_TRANGTHAI], [TRACKING].[C_DESC], [DMTRANGTHAI].[C_NAME] as TRANGTHAINAME FROM [TRACKING] LEFT OUTER JOIN [DMTRANGTHAI] ON [TRACKING].[FK_TRANGTHAI] = [DMTRANGTHAI].[C_CODE] WHERE [C_BILL] = '" + txtBILL.Text.Trim() + "' ORDER BY [C_DATE] ASC";
        //Response.Write(SelectString);       
        oDataTable = SelectQuery1.query_data(SelectString);
        if (oDataTable.Rows[oDataTable.Rows.Count - 1]["TRANGTHAINAME"].ToString() != "")
        {
            lblC_STATUS.Text = oDataTable.Rows[oDataTable.Rows.Count - 1]["TRANGTHAINAME"].ToString();
        }
        else
        {
            lblC_STATUS.Text = "Đang chờ xử lý";
        }
        RadGridBILLCHECK.DataSource = oDataTable;
        RadGridBILLCHECK.Rebind();
    }
}