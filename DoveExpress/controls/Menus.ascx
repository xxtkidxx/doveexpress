﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Menus.ascx.cs" Inherits="controls_Menu" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<%@ Register namespace="ITCLIB.Security" tagprefix="Office" %>
<telerik:RadCodeBlock ID="RadCodeBlockMenu" runat="server">
<script type="text/javascript">
 
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
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=QUANHUYEN" Text="Quận, huyện" Value="QUANHUYEN">
                    </telerik:RadMenuItem>
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=TINHTHANH" Text="Tỉnh thành" Value="TINHTHANH">
                    </telerik:RadMenuItem>
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=QUOCGIA" Text="Quốc gia" Value="QUOCGIA">
                    </telerik:RadMenuItem> 
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=KHUVUC" Text="Khu vực" Value="KHUVUC">
                    </telerik:RadMenuItem> 
                 </Items>
            </telerik:RadMenuItem> 
            <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Khách hàng" Value="KHACHHANGMENU">
                 <Items>
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=NHOMKHACHHANG" Text="Nhóm khách hàng" Value="NHOMKHACHHANG">
                    </telerik:RadMenuItem> 
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=KHACHHANG" Text="Khách hàng" Value="KHACHHANG">
                    </telerik:RadMenuItem>
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=MABANGCUOC" Text="Mã bảng cước (khách hàng)" Value="MABANGCUOC">                 
                    </telerik:RadMenuItem>                    
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=MAVUNG" Text="Vùng tính cước (Khách hàng)" Value="MAVUNG">
                    </telerik:RadMenuItem>
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=MAVUNGQT" Text="Vùng tính cước quốc tế (Khách hàng)" Value="MAVUNGQT">
                    </telerik:RadMenuItem>
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=CHITIETCUOC" Text="Chi tiết cước khách hàng" Value="CHITIETCUOC">
                    </telerik:RadMenuItem> 
                 </Items>
            </telerik:RadMenuItem>
            <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Đối tác" Value="DOITACMENU">
                 <Items>
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=DOITAC" Text="Đối tác" Value="DOITAC">
                    </telerik:RadMenuItem>                
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=MAVUNGDT" Visible="false" Text="Vùng tính cước (đối tác)" Value="MAVUNGDT">
                    </telerik:RadMenuItem>
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=MAVUNGQTDT" Visible="false" Text="Vùng tính cước quốc tế (đối tác)" Value="MAVUNGDT">
                    </telerik:RadMenuItem>
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=CHITIETCUOCDT" Text="Chi tiết cước đối tác" Value="CHITIETCUOCDT">
                    </telerik:RadMenuItem> 
                 </Items>
            </telerik:RadMenuItem>
            <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=MASANPHAM" Text="Mã dịch vụ" Value="MASANPHAM">
            </telerik:RadMenuItem>
            <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=TYGIA" Text="Tỷ giá" Value="TYGIA">                 
            </telerik:RadMenuItem> 
        </Items>
     </telerik:RadMenuItem> 
    <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Danh mục riêng" Value="DANHMUCRIENG">
        <Items>
             <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=PHONGBAN" Text="Phòng ban" Value="PHONGBAN">
             </telerik:RadMenuItem>
             <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=User" Text="Nhân viên" Value="NHANVIEN">
             </telerik:RadMenuItem>
             <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=GroupUser" Text="Phân quyền" Value="PHANQUYEN">
             </telerik:RadMenuItem>
             <telerik:RadMenuItem runat="server" NavigateUrl="../Default.aspx?ctl=ActionLog" Text="Nhật ký sử dụng" Value="ActionLog" Font-Size="Small">
             </telerik:RadMenuItem>
             <telerik:RadMenuItem runat="server" NavigateUrl="../Default.aspx?ctl=ErrorLog" Text="Nhật ký lỗi" Value="ErrorLog" Font-Size="Small">
             </telerik:RadMenuItem>
             <telerik:RadMenuItem runat="server" NavigateUrl="../Default.aspx?ctl=User_Log" Text="Nhật ký đăng nhập" Value="User_Log" Font-Size="Small">
             </telerik:RadMenuItem>
        </Items>
    </telerik:RadMenuItem>
    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Nhận gửi" Value="NHANGUIMENU">  
        <Items>
             <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=NHANGUI" Text="Nhận gửi trong nước" Value="NHANGUI">
             </telerik:RadMenuItem>
             <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=NHANGUIQT" Text="Nhận gửi quốc tế" Value="NHANGUIQT">
             </telerik:RadMenuItem>
        </Items>               
    </telerik:RadMenuItem>
    <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Báo cáo" Value="BAOCAO">   
        <Items>
            <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=BAOCAONGAY" Text="Doanh thu theo ngày" Value="BAOCAONGAY">
            </telerik:RadMenuItem> 
            <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=BAOCAOKHACHHANG" Text="Doanh thu theo khách hàng" Value="BAOCAOKHACHHANG">
            </telerik:RadMenuItem>
            <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=BAOCAONVKD" Text="Doanh thu theo nhân viên kinh doanh" Value="BAOCAONVKD">
            </telerik:RadMenuItem>
            <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="" Text="Quản lý công nợ" Value="BAOCAOCONGNO">
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