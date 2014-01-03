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
                lblMaKhachHang.Text = (oDataTable.Rows[0]["FK_KHACHHANG"].ToString() == "") ? "-" : oDataTable.Rows[0]["FK_KHACHHANG"].ToString();
                lblNgaygui.Text = String.Format("{0:dd/MM/yyyy}", DateTime.Parse(oDataTable.Rows[0]["C_NGAY"].ToString()));
                lblDiachinhan.Text = (oDataTable.Rows[0]["C_DIACHINHAN"].ToString() == "") ? "-" : oDataTable.Rows[0]["C_DIACHINHAN"].ToString();
                if (oDataTable.Rows[0]["C_TYPE"].ToString() == "2")
                {
                    lblQuanhuyen.Text = "Quốc gia:";
                    lblQuanhuyenValue.Text = ITCLIB.Admin.cFunction.LoadQuocGiaName(oDataTable.Rows[0]["FK_QUOCGIA"].ToString());
                }
                else
                {
                    lblQuanhuyen.Text = "Tỉnh thành/Quận huyện:";
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
        string SelectString = "SELECT [TRACKING].[C_DATE], [TRACKING].[C_DESC], [DMTRANGTHAI].[C_NAME] as TRANGTHAINAME FROM [TRACKING] LEFT OUTER JOIN [DMTRANGTHAI] ON [TRACKING].[FK_TRANGTHAI] = [DMTRANGTHAI].[C_CODE] WHERE [C_BILL] = '" + txtBILL.Text.Trim() + "' UNION ALL SELECT NHANGUI.C_NGAYGIOPHAT as C_DATE,(N'Người nhận:' + NHANGUI.C_NGUOIKYNHAN + N';Bộ phận:' + NHANGUI.C_BOPHAN) as C_DESC, N'Đã ký nhận' as TRANGTHAINAME FROM NHANGUI WHERE NHANGUI.C_BILL = '" + txtBILL.Text.Trim() + "' AND NHANGUI.FK_TRANGTHAI = N'True' ORDER BY [C_DATE] ASC";
        //Response.Write(SelectString);       
        oDataTable = SelectQuery1.query_data(SelectString);
        if (oDataTable.Rows.Count != 0)
        {
            lblC_STATUS.Text = oDataTable.Rows[oDataTable.Rows.Count - 1]["TRANGTHAINAME"].ToString() + " " +  oDataTable.Rows[oDataTable.Rows.Count - 1]["C_DESC"].ToString();           
        }
        else
        {
            lblC_STATUS.Text = "Đang chờ xử lý";
        }
        RadGridBILLCHECK.DataSource = oDataTable;
        RadGridBILLCHECK.Rebind();
    }
}