<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Menus.ascx.cs" Inherits="controls_Menu" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<%@ Register namespace="ITCLIB.Security" tagprefix="Office" %>
<telerik:RadCodeBlock ID="RadCodeBlockMenu" runat="server">
<script type="text/javascript">
        function OnClientUpdated(sender, args) {
            var message = "";
            var newMsgs = sender.get_value();
            if (newMsgs != 0) {
                sender.show();
            }
            else {
                message += " Không có thông báo!";
            }
            logEvent(message);
        }

        function OnClientShowing(sender, args) {
//            var notification = sender;
//            if (sender.calculateOffset == false) return;
//            var widthS = screen.width;
//            var heigts = screen.height;       
//            sender.set_offsetY(heigts - notification.get_height());
//            sender.set_offsetX(widthS - notification.get_width());
//            sender.calculateOffset = false;
        }   
</script>
</telerik:RadCodeBlock>
<telerik:RadMenu ID="Menu" Runat="server" Skin="Office2010Black" CssClass ="cssMenuNgang" Width="100%"  style="position:absolute;z-index: 1">
    <CollapseAnimation Type="Linear" />
    <DefaultGroupSettings OffsetX="2" OffsetY="2" />
    <Items>
      <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Danh mục chung" Value="DANHMUCCHUNG" ImageUrl="~/images/home.png">
        <Items>
             <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Vùng địa lý" Value="VUNGDIALY">
                 <Items>
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Quận, huyện" Value="QUANHUYEN">
                    </telerik:RadMenuItem>
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Tỉnh thành" Value="TINHTHANH">
                    </telerik:RadMenuItem>
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=QUOCGIA" Text="Quốc gia" Value="QUOCGIA">
                    </telerik:RadMenuItem> 
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=KHUVUC" Text="Khu vực" Value="KHUVUC">
                    </telerik:RadMenuItem> 
                 </Items>
            </telerik:RadMenuItem> 
            <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Mã bảng cước" Value="MABANGCUOC">                 
            </telerik:RadMenuItem> 
            <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Sản phẩm" Value="SANPHAM">
                 <Items>
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Mã sản phẩm" Value="MASANPHAM">
                    </telerik:RadMenuItem>
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Vùng sản phẩm" Value="VUNGSANPHAM">
                    </telerik:RadMenuItem>
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Cước sản phẩm" Value="CUOCSANPHAM">
                    </telerik:RadMenuItem> 
                 </Items>
            </telerik:RadMenuItem>
            <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Dịch vụ" Value="DICHVU">
                 <Items>
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Mã dịch vụ" Value="MADICHVU">
                    </telerik:RadMenuItem>
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Vùng dịch vụ" Value="VUNGDICHVU">
                    </telerik:RadMenuItem>
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Cước dịch vụ" Value="CUOCDICHVU">
                    </telerik:RadMenuItem> 
                 </Items>
            </telerik:RadMenuItem>
            <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Tỷ giá" Value="TYGIA">                 
            </telerik:RadMenuItem> 
        </Items>
     </telerik:RadMenuItem> 
    <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Danh mục riêng" Value="DANHMUCRIENG">
        <Items>
             <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Đơn vị" Value="DONVI">
             </telerik:RadMenuItem> 
             <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Phòng ban" Value="PHONGBAN">
             </telerik:RadMenuItem>
             <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Nhân viên" Value="NHANVIEN">
             </telerik:RadMenuItem>
             <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Phân quyền" Value="PHANQUYEN">
             </telerik:RadMenuItem>
             <telerik:RadMenuItem runat="server" NavigateUrl="../Default.aspx?ctl=ActionLog" Text="Nhật ký sử dụng" Value="ActionLog" Font-Size="Small">
             </telerik:RadMenuItem>
             <telerik:RadMenuItem runat="server" NavigateUrl="../Default.aspx?ctl=ErrorLog" Text="Nhật ký lỗi" Value="ErrorLog" Font-Size="Small">
             </telerik:RadMenuItem>
             <telerik:RadMenuItem runat="server" NavigateUrl="../Default.aspx?ctl=User_Log" Text="Nhật ký đăng nhập" Value="User_Log" Font-Size="Small">
             </telerik:RadMenuItem>
        </Items>
    </telerik:RadMenuItem>
    <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Khách hàng, đối tác" Value="KHACHHANGDOITAC">
        <Items>
            <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Nhóm khách hàng" Value="NHOMKHACHHANG">
            </telerik:RadMenuItem> 
            <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Khách hàng" Value="KHACHHANG">
            </telerik:RadMenuItem>
            <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Đối tác" Value="DOITAC">
            </telerik:RadMenuItem>
        </Items>           
    </telerik:RadMenuItem>
    <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Nhận gửi" Value="NHANGUI">                 
    </telerik:RadMenuItem>
    <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Báo cáo" Value="BAOCAO">   
     <Items>
            <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Doanh thu theo ngày" Value="BAOCAONGAY">
            </telerik:RadMenuItem> 
            <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Doanh thu theo khách hàng" Value="BAOCAOKHACHHANG">
            </telerik:RadMenuItem>
            <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Theo nhân viên kinh doanh" Value="BAOCAONVKD">
            </telerik:RadMenuItem>
            <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Quản lý công nợ" Value="BAOCAOCONGNO">
            </telerik:RadMenuItem>
            <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Quản lý thanh toán" Value="BAOCAOTHANHTOAN">
            </telerik:RadMenuItem>
        </Items>                     
    </telerik:RadMenuItem>
    <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Tài chỉnh" Value="TAICHINH">                 
    </telerik:RadMenuItem>  
    <telerik:RadMenuItem runat="server" Text="Cá nhân" Font-Size="Small" Value="User">
            <Items>
                <telerik:RadMenuItem runat="server" NavigateUrl="../Default.aspx?ctl=User_Pass" Text="Thay đổi mật khẩu" Value="User_Pass" Font-Size="Small">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" NavigateUrl="../Default.aspx?ctl=User_Info" Text="Thay đổi thông tin" Value="User_Info" Font-Size="Small">
                </telerik:RadMenuItem>
            </Items>
    </telerik:RadMenuItem>        
    <telerik:RadMenuItem runat="server" NavigateUrl="../Default.aspx?ctl=Logout" Text="Thoát" Font-Size="Small">
    </telerik:RadMenuItem>
    </Items>
</telerik:RadMenu>