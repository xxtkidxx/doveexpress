<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TYGIA.ascx.cs" Inherits="module_TYGIA" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxProxyTYGIA" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGridTYGIA">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridTYGIA" LoadingPanelID="RadAjaxLoadingPanelTYGIA" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadCodeBlock ID="RadCodeBlockTYGIA" runat="server">
<script type="text/javascript">

</script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelTYGIA" runat="server" />
    <div>
        <asp:GridView ID="gridViewTyGia" runat="server">
        </asp:GridView>
    </div>
<telerik:RadGrid ID="RadGridTYGIA" runat="server" Skin="Vista" 
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False" ShowFooter="True" CellSpacing="0" 
    onitemdatabound="RadGridTYGIA_ItemDataBound">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
     <GroupingSettings CaseSensitive ="false"  />
    <MasterTableView Name="MasterTableViewTYGIA" CommandItemDisplay="Top" DataKeyNames="CurrencyCode" ClientDataKeyNames="CurrencyCode" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b>Tỷ giá Vietcombank - Thời gian cập nhật: <asp:Label ID="lblTime" ForeColor ="Red" runat="server"></asp:Label></b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton4" runat="server" CommandName="RebindGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Refresh.gif" />Làm mới</asp:LinkButton>
                    </div>
                    <div style="padding: 5px 5px;float:right;width:auto">
                        <asp:LinkButton ID="ExportToPdfButton" runat="server" CommandName="ExportToPdf"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/pdf.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToWordButton" runat="server" CommandName="ExportToWord"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/word.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToExcelButton" runat="server" CommandName="ExportToExcel"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/excel.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToCsvButton" runat="server" CommandName="ExportToCsv"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/csv.gif" /></asp:LinkButton>&nbsp;&nbsp;
                    </div>
        </CommandItemTemplate>
        <Columns>                
               <telerik:GridBoundColumn UniqueName="CurrencyCode" HeaderText="Mã ngoại tệ" DataField="CurrencyCode" AllowFiltering ="false" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="CurrencyName" HeaderText="Tên ngoại tệ" DataField="CurrencyName" AllowFiltering ="false"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="Buy" HeaderText="Mua tiền mặt" DataField="Buy" AllowFiltering ="false"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="Transfer" HeaderText="Mua chuyển khoản" DataField="Transfer" AllowFiltering ="false"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="Sell" HeaderText="Bán" DataField="Sell" AllowFiltering ="false"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
        </Columns>
        </MasterTableView>
        <ClientSettings>
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
