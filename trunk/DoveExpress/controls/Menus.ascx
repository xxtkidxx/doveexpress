<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Menus.ascx.cs" Inherits="controls_Menu" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Namespace="ITCLIB.Security" TagPrefix="Office" %>
<telerik:RadCodeBlock ID="RadCodeBlockMenu" runat="server">
    <script type="text/javascript">
        function Logout() {
            if (confirm("Bạn chắc chắn muốn thoát phần mềm?")) {
                var url = "Default.aspx?ctl=logout";
                $(location).attr('href', url);
            }
        }
    </script>
</telerik:RadCodeBlock>
<telerik:RadMenu ID="Menu" runat="server" Skin="Office2010Black" CssClass="cssMenuNgang"
    Width="99.9%" Style="position: absolute; z-index: 1">
    <CollapseAnimation Type="Linear" />
    <DefaultGroupSettings OffsetX="2" OffsetY="2" />
    <Items>
        <telerik:RadMenuItem runat="server" ImageUrl="~/images/home.png" NavigateUrl="../Default.aspx"
            Value="Home" Font-Size="Small">
        </telerik:RadMenuItem>
        <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Danh mục chung" Value="DANHMUCCHUNG">
            <Items>
                <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Vùng địa lý" Value="VUNGDIALY">
                    <Items>
                        <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=QUANHUYEN"
                            Text="Quận, huyện" Value="QUANHUYEN">
                        </telerik:RadMenuItem>
                        <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=TINHTHANH"
                            Text="Tỉnh thành" Value="TINHTHANH">
                        </telerik:RadMenuItem>
                        <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=QUOCGIA"
                            Text="Quốc gia" Value="QUOCGIA">
                        </telerik:RadMenuItem>
                        <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=KHUVUC"
                            Text="Khu vực" Value="KHUVUC" Visible="false">
                        </telerik:RadMenuItem>
                    </Items>
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Khách hàng" Value="KHACHHANGMENU">
                    <Items>
                        <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=NHOMKHACHHANG"
                            Text="Nhóm khách hàng" Value="NHOMKHACHHANG">
                        </telerik:RadMenuItem>
                        <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=KHACHHANG"
                            Text="Khách hàng" Value="KHACHHANG">
                        </telerik:RadMenuItem>
                        <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Cước trong nước" Value="CUOCTRONGNUOC">
                            <Items>
                                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=MABANGCUOC"
                                    Text="Mã bảng cước (khách hàng)" Value="MABANGCUOC">
                                </telerik:RadMenuItem>
                                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=MAVUNG"
                                    Text="Vùng tính cước (Khách hàng)" Value="MAVUNG">
                                </telerik:RadMenuItem>
                                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=CHITIETCUOC"
                                    Text="Chi tiết cước (khách hàng)" Value="CHITIETCUOC">
                                </telerik:RadMenuItem>
                            </Items>
                        </telerik:RadMenuItem>
                        <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Cước quốc tế" Value="CUOCQUOCTE">
                            <Items>
                                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=MABANGCUOCQT"
                                    Text="Mã bảng cước quốc tế (khách hàng)" Value="MABANGCUOCQT">
                                </telerik:RadMenuItem>
                                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=MAVUNGQT"
                                    Text="Vùng tính cước quốc tế (Khách hàng)" Value="MAVUNGQT">
                                </telerik:RadMenuItem>
                            </Items>
                        </telerik:RadMenuItem>
                    </Items>
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Đối tác" Value="DOITACMENU">
                    <Items>
                        <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=DOITAC"
                            Text="Đối tác" Value="DOITAC">
                        </telerik:RadMenuItem>
                        <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=MAVUNGDT"
                            Text="Vùng tính cước (đối tác)" Value="MAVUNGDT">
                        </telerik:RadMenuItem>
                        <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=MAVUNGQTDT"
                            Text="Vùng tính cước quốc tế (đối tác)" Value="MAVUNGDT">
                        </telerik:RadMenuItem>
                        <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=CHITIETCUOCDT"
                            Text="Chi tiết cước đối tác" Value="CHITIETCUOCDT">
                        </telerik:RadMenuItem>
                    </Items>
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=MASANPHAM"
                    Text="Mã dịch vụ" Value="MASANPHAM">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=TRANGTHAIBILL"
                    Text="Trạng thái Bill" Value="TRANGTHAIBILL">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=TYGIA"
                    Text="Tỷ giá" Value="TYGIA">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenuItem>
        <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Danh mục riêng" Value="DANHMUCRIENG">
            <Items>
                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=PHONGBAN"
                    Text="Phòng ban" Value="PHONGBAN">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=User"
                    Text="Nhân viên" Value="NHANVIEN">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=GroupUser"
                    Text="Phân quyền" Value="PHANQUYEN">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" NavigateUrl="../Default.aspx?ctl=ActionLog" Text="Nhật ký sử dụng"
                    Value="ActionLog" Font-Size="Small">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" NavigateUrl="../Default.aspx?ctl=ErrorLog" Text="Nhật ký lỗi"
                    Value="ErrorLog" Font-Size="Small">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" NavigateUrl="../Default.aspx?ctl=User_Log" Text="Nhật ký đăng nhập"
                    Value="User_Log" Font-Size="Small">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" NavigateUrl="../Default.aspx?ctl=Config" Text="Cấu hình hệ thống"
                    Value="Config" Font-Size="Small">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenuItem>
        <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Nhận gửi"
            Value="NHANGUIMENU">
            <Items>
                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=NHANGUI"
                    Text="Nhận gửi trong nước" Value="NHANGUI">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=NHANGUIQT"
                    Text="Nhận gửi quốc tế" Value="NHANGUIQT">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=NHANGUIPH"
                    Text="Thông tin phát hàng" Value="NHANGUIPH">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenuItem>
        <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Báo cáo" Value="BAOCAO">
            <Items>
                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=BAOCAONGAY"
                    Text="Doanh thu theo ngày" Value="BAOCAONGAY">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=BAOCAOKHACHHANG"
                    Text="Doanh thu theo khách hàng" Value="BAOCAOKHACHHANG">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=BAOCAONVKD"
                    Text="Doanh thu theo nhân viên kinh doanh" Value="BAOCAONVKD">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=BAOCAOTTTT"
                    Text="Tình trạng thanh toán" Value="BAOCAOTTTT">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=BAOCAOCONGNO"
                    Text="Quản lý công nợ" Value="BAOCAOCONGNO">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=BAOCAODOITAC"
                    Text="Doanh thu theo đối tác" Value="BAOCAODOITAC">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Báo cáo giao nhận" Value="BAOCAOGIAONHANMENU">
                    <Items>
                        <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=BAOCAONHANHANG"
                            Text="Báo cáo nhận hàng" Value="BAOCAONHANHANG">
                        </telerik:RadMenuItem>
                        <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=BAOCAOPHATHANG"
                            Text="Báo cáo phát hàng" Value="BAOCAOPHATHANG">
                        </telerik:RadMenuItem>
                    </Items>
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Báo cáo tổng hợp" Value="BAOCAOTONGHOPMENU">
                    <Items>
                        <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=BAOCAOTONGHOP"
                            Text="Báo cáo tổng hợp trong nước" Value="BAOCAOTONGHOP">
                        </telerik:RadMenuItem>
                        <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=BAOCAOTONGHOPQT"
                            Text="Báo cáo tổng hợp quốc tế" Value="BAOCAOTONGHOPQT">
                        </telerik:RadMenuItem>
                    </Items>
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenuItem>
        <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Tài chỉnh" Value="TAICHINH">
            <Items>
                <telerik:RadMenuItem runat="server" Visible="false" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=SOQUYTIENMAT"
                    Text="Sổ quỹ tiền mặt" Value="SOQUYTIENMAT">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Visible="false" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=SOQUYTIENMATV2"
                    Text="Sổ quỹ tiền mặt (Vesion 2)" Value="SOQUYTIENMATV2">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=SOQUYTIENMATV3"
                    Text="Sổ quỹ tiền mặt (Phân trang)" Value="SOQUYTIENMATV3">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Visible="false" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=BAOCAOTAICHINH"
                    Text="Báo cáo tài chính nội bộ" Value="BAOCAOTAICHINH">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=KIHIEUTAIKHOAN"
                    Text="Kí hiệu các tài khoản" Value="KIHIEUTAIKHOAN">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenuItem>
        <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=KHIEUNAI" Text="Khiếu nại" Value="KHIEUNAI">
        </telerik:RadMenuItem>
        <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=BAOGIA" Text="Báo giá" Value="BAOGIA">
        </telerik:RadMenuItem>
        <telerik:RadMenuItem runat="server" Text="Cá nhân" Font-Size="Small" Value="User">
            <Items>
                <telerik:RadMenuItem runat="server" NavigateUrl="../Default.aspx?ctl=User_Pass" Text="Thay đổi mật khẩu"
                    Value="User_Pass" Font-Size="Small">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" NavigateUrl="../Default.aspx?ctl=User_Info" Text="Thay đổi thông tin"
                    Value="User_Info" Font-Size="Small">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenuItem>
        <telerik:RadMenuItem runat="server" NavigateUrl="javascript:Logout()" Text="Thoát"
            Font-Size="Small">
        </telerik:RadMenuItem>
    </Items>
</telerik:RadMenu>
