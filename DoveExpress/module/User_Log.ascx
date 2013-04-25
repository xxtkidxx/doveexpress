<%@ Control Language="C#" AutoEventWireup="true" CodeFile="User_Log.ascx.cs" Inherits="Admin_Modules_User_Log" %>

<telerik:RadGrid ID="gvUser_Log" runat="server" Skin="Vista" 
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"  AllowMultiRowSelection ="true"
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="User_LogDataSource" ShowFooter="True" CellSpacing="0" 
    onitemcommand="gvUser_Log_ItemCommand">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
     <GroupingSettings CaseSensitive ="false"  />
    <MasterTableView Name ="MasterTableViewCVFORM" CommandItemDisplay="Top" DataSourceID="User_LogDataSource" DataKeyNames="PK_LOG" ClientDataKeyNames="PK_LOG" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b>Nhật ký đăng nhập</b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:return confirm('Bạn có muốn làm sạch nhật ký hiện tại không?')" Visible ='<%# ITCLIB.Security.Security.CanDeleteModule("User_Log") %>' runat="server" CommandName="ClearAll"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Delete.gif" />Làm sạch</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton4" runat="server" CommandName="RebindGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Refresh.gif" />Làm mới</asp:LinkButton>
                    </div>
        </CommandItemTemplate>
        <Columns>
                <telerik:GridBoundColumn UniqueName="C_LOGINNAME" HeaderText="Tên đăng nhập" DataField="C_LOGINNAME" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" AllowFiltering ="false" >
                </telerik:GridBoundColumn>
               <telerik:GridBoundColumn UniqueName="C_IP" HeaderText="IP" DataField="C_IP" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" AllowFiltering ="false"  >
                </telerik:GridBoundColumn>
                 <telerik:GridDateTimeColumn UniqueName="LogTime" HeaderText="Thời gian đăng nhập" DataField="LogTime"  AllowFiltering ="false" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" DataFormatString ="{0: dd/MM/yyyy hh:mm tt}">
                </telerik:GridDateTimeColumn>             
        </Columns>
        </MasterTableView>
        <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G1"/>
        <ClientSettings>
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<asp:SqlDataSource ID="User_LogDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
   SelectCommand = "SELECT USERS.C_LOGINNAME,USER_LOG.PK_LOG, USER_LOG.C_IP,USER_LOG.LogTime FROM [USER_LOG] LEFT OUTER JOIN [USERS] ON USER_LOG.FK_USER=USERS.PK_ID ORDER BY USER_LOG.PK_LOG DESC" 
   DeleteCommand = "DELETE FROM USER_LOG">
</asp:SqlDataSource>
