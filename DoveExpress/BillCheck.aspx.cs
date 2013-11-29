using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class BillCheck : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void imgSearch_Click(object sender, ImageClickEventArgs e)
    {
        if (txtBILL.Text.Trim() != "")
        {
            string SelectSQL = "SELECT NHANGUI.*,DMMASANPHAM.C_NAME as DICHVUNAME FROM NHANGUI LEFT OUTER JOIN DMMASANPHAM ON NHANGUI.FK_MASANPHAM = DMMASANPHAM.PK_ID WHERE C_BILL = " + txtBILL.Text.Trim();
            DataTable oDataTable = new DataTable();
            ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
            oDataTable = SelectQuery.query_data(SelectSQL);
            if (oDataTable.Rows.Count != 0)
            {
                lblDichvu.Text = oDataTable.Rows[0]["DICHVUNAME"].ToString();
                lblNguoigui.Text = oDataTable.Rows[0]["C_TENKH"].ToString();
                lblNgaygui.Text = String.Format("{0:dd/MM/yyyy}", DateTime.Parse(oDataTable.Rows[0]["C_NGAY"].ToString()));
                lblNguoinhan.Text = oDataTable.Rows[0]["C_NGUOINHAN"].ToString();
                lblDiachinhan.Text = oDataTable.Rows[0]["C_DIACHINHAN"].ToString();
                if (oDataTable.Rows[0]["C_NGAYGIOPHAT"] != DBNull.Value)
                {
                    lblNgaynhan.Text = String.Format("{0:dd/MM/yyyy hh:mm:ss tt}", DateTime.Parse(oDataTable.Rows[0]["C_NGAYGIOPHAT"].ToString()));
                }
                else
                {
                    lblNgaynhan.Text = "-";
                }
                if (oDataTable.Rows[0]["C_TYPE"] == "2")
                {
                    lblQuanhuyen.Text = "Quốc gia";
                    lblQuanhuyenValue.Text = ITCLIB.Admin.cFunction.LoadQuocGiaName(oDataTable.Rows[0]["FK_QUOCGIA"].ToString());
                }
                else
                {
                    lblQuanhuyenValue.Text = ITCLIB.Admin.cFunction.LoadTinhThanhName(oDataTable.Rows[0]["FK_QUANHUYEN"].ToString()) + " / " + ITCLIB.Admin.cFunction.LoadQuanHuyenName(oDataTable.Rows[0]["FK_QUANHUYEN"].ToString());
                }
                if (oDataTable.Rows[0]["FK_TRANGTHAI"].ToString() != "")
                {
                    lblC_STATUS.Text = oDataTable.Rows[0]["FK_TRANGTHAI"].ToString();
                }
                else
                {
                    lblC_STATUS.Text = "Đang chờ xử lý";
                }
            }
            else
            {
                RadAjaxManager.Alert("Không tồn tại BILL " + txtBILL.Text.Trim() + " trong dữ liệu DoveExpress");
            }
        }
        else
        {
            RadAjaxManager.Alert("Hãy nhập BILL để kiểm tra trạng thái");
        }
    }
}