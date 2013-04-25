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
      <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Quản lý Doanh nghiệp" Value="List" ImageUrl="~/images/home.png">
        <Items>
            <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=DoanhNghieps" Text="Quản lý doanh nghiệp" Value="DoanhNghiep">
            </telerik:RadMenuItem> 
        </Items>
     </telerik:RadMenuItem> 
    <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Vốn đầu tư phát triển" Value="VDTPT">
        <Items>
             <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=DUANs" Text="Thông tin dự án đầu tư phát triển" Value="DUANs">
             </telerik:RadMenuItem> 
        </Items>
    </telerik:RadMenuItem>   
    <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Vốn hành chính sự nghiệp" Val
    ue="VHCSN">
        <Items>
             <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=DONVIDUTOANs" Text="Đơn vị dự toán" Value="DONVIDUTOANs">
             </telerik:RadMenuItem> 
        </Items>
    </telerik:RadMenuItem> 
    <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Cấp phép đầu tư" Value="CPDT">
        <Items>
        </Items>
    </telerik:RadMenuItem>      
    <telerik:RadMenuItem runat="server" Text="Quản trị hệ thống" Font-Size="Small" Value="List">
            <Items>
                <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Danh mục" Value="List">
                 <Items>
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=JobTitles" Text="Chức danh" Value="JobTitles">
                    </telerik:RadMenuItem> 
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=Vitriduans" Text="Vị trí dự án" Value="Vitriduans">
                    </telerik:RadMenuItem> 
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=Trangthaiduans" Text="Trạng thái dự án" Value="Trangthaiduans">
                    </telerik:RadMenuItem> 
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=Trinhdos" Text="Trình độ" Value="Trinhdos">
                    </telerik:RadMenuItem>
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=Nguonkinhphis" Text="Nguồn kinh phí" Value="Nguonkinhphis">
                    </telerik:RadMenuItem>    
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=Nguonvons" Text="Nguồn vốn" Value="Nguonvons">
                    </telerik:RadMenuItem>                      
                </Items>
                </telerik:RadMenuItem> 
               <telerik:RadMenuItem runat="server" Font-Size="Small" Text="Doanh nghiệp" Value="List">
                 <Items>
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=DNTypes" Text="Loại hình doanh nghiệp" Value="DNTypes">
                    </telerik:RadMenuItem> 
                    <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=Nganhnghe" Text="Ngành nghề kinh doanh" Value="Nganhnghe">
                    </telerik:RadMenuItem> 
                </Items>
                </telerik:RadMenuItem>          
                <telerik:RadMenuItem runat="server" Font-Size="Small" NavigateUrl="../Default.aspx?ctl=DEPTs" Text="Phòng ban, bộ phận" Value="DEPTs">
                </telerik:RadMenuItem>                          
            </Items>
    </telerik:RadMenuItem>        
    <telerik:RadMenuItem runat="server" Text="Hệ thống phân quyền" Font-Size="Small" Value="System">
            <Items>
                <telerik:RadMenuItem runat="server" NavigateUrl="../Default.aspx?ctl=Group_Users" Text="Quản lý nhóm người dùng" Value="Group_Users" Font-Size="Small">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" NavigateUrl="../Default.aspx?ctl=UserAdmins" Text="Quản lý người dùng ban quản lý" Value="UserAdmins" Font-Size="Small">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" NavigateUrl="../Default.aspx?ctl=UserCompanys" Text="Quản lý người dùng công ty" Value="UserCompanys" Font-Size="Small">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" NavigateUrl="../Default.aspx?ctl=ActionLog" Text="Nhật ký sử dụng" Value="ActionLog" Font-Size="Small">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" NavigateUrl="../Default.aspx?ctl=ErrorLog" Text="Nhật ký lỗi" Value="ErrorLog" Font-Size="Small">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" NavigateUrl="../Default.aspx?ctl=User_Log" Text="Nhật ký đăng nhập" Value="User_Log" Font-Size="Small">
                </telerik:RadMenuItem>
            </Items>
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
<telerik:RadNotification ID="RadNotificationOffice" runat="server" LoadContentOn="TimeInterval" Skin="Vista"
        Width="300" Animation="Fade" EnableRoundedCorners="true" EnableShadow="true" 
        OnClientUpdated="OnClientUpdated" Title="Thông báo" OffsetX="-5" OffsetY="20"
        TitleIcon="Images/img_info161.png" UpdateInterval="3000" OnCallbackUpdate="OnCallbackUpdate" AutoCloseDelay="0" 
        Position="TopRight" ShowCloseButton="true" Enabled="False">
        <ContentTemplate>
        <div style="margin: 5px 5px 5px 5px;">                    
            <div style=" padding-top:5px; padding-right:5px; width:40px; float :left;">
                <img id="img" src="Images/img_info32.png" alt="" />
            </div>
            <div style="padding-top:5px; padding-right:5px; width:210px; float:right; line-height:20px;">
                <asp:Literal ID="areThongbao" runat="server" ></asp:Literal>
                <asp:LinkButton CssClass ="linkNotification" ID="btnDelete" runat="server" onClick="btnDownloadTextFile_Click" style="padding: 5px 5px;float:right">Xóa</asp:LinkButton>                    
            </div>
        </div>            
       </ContentTemplate>
 </telerik:RadNotification> 
 <telerik:RadNotification ID="RadNotificationReminder" runat="server" LoadContentOn="TimeInterval" Skin="Vista"
        Width="300" Animation="Fade" EnableRoundedCorners="true" EnableShadow="true" 
        OnClientUpdated="OnClientUpdated" Title="Nhắc nhở lịch " OffsetX="-5" OffsetY="550" 
        TitleIcon="Images/img_reminder16.png" UpdateInterval="3000" OnClientShowing ="OnClientShowing" 
        OnCallbackUpdate="OnCallbackReminder" AutoCloseDelay="2000" Position="TopRight" ShowCloseButton="true" Enabled="False">
        <ContentTemplate>
        <div style="margin: 5px 0px 5px 5px;">                    
            <div style=" padding-top:5px; padding-right:10px; padding-bottom:10px; width:40px; float :left;">
                <img id="img1" src="Images/img_reminder32.png" alt="" />
            </div>
            <div style="padding-top:5px; padding-left:10px; padding-right:5px; width:210px; float:right; line-height:20px;">
                 <asp:Literal ID="area" runat="server" ></asp:Literal>
                <asp:LinkButton CssClass ="linkNotification" ID="LinkButton1" runat="server" onClick="btnDeleteReminder_Click" style="padding: 5px 5px;float:right">Tắt nhắc nhở</asp:LinkButton>                    
            </div>
        </div>            
       </ContentTemplate>
</telerik:RadNotification> 
