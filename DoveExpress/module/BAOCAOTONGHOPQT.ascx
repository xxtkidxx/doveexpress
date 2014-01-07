<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BAOCAOTONGHOPQT.ascx.cs"
    Inherits="module_BAOCAOTONGHOPQT" %>
<%@ Register TagPrefix="uc1" Namespace="ITCLIB.Admin" %>
<telerik:RadCodeBlock ID="RadCodeBlockBAOCAOTONGHOPQT" runat="server">
    <script type="text/javascript">
        var registeredElementsNG = [];
        function GetRegisteredServerElementNG(serverID) {
            var clientID = "";
            for (var i = 0; i < registeredElementsNG.length; i++) {
                clientID = registeredElementsNG[i];
                if (clientID.indexOf(serverID) >= 0)
                    break;
            }
            return $get(clientID);
        }
        function GetGridServerElementNG(serverID, tagName) {
            if (!tagName)
                tagName = "*";

            var grid = $get("<%=RadGridBAOCAOTONGHOPQT.ClientID %>");
            var elements = grid.getElementsByTagName(tagName);
            for (var i = 0; i < elements.length; i++) {
                var element = elements[i];
                if (element.id.indexOf(serverID) >= 0)
                    return element;
            }
        }
    </script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelBAOCAOTONGHOPQT"
    runat="server" />
<telerik:RadGrid ID="RadGridBAOCAOTONGHOPQT" runat="server" Skin="Vista" AllowPaging="True"
    PageSize="20" AllowSorting="True" AllowFilteringByColumn="True" GridLines="None"
    ShowStatusBar="True" AutoGenerateColumns="False" OnItemCommand="RadGridBAOCAOTONGHOPQT_ItemCommand"
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" AllowAutomaticInserts="True"
    AllowAutomaticUpdates="True" DataSourceID="BAOCAOTONGHOPQTDataSource" ShowFooter="True"
    OnDataBound="RadGridBAOCAOTONGHOPQT_DataBound" CellSpacing="0" OnExcelMLExportRowCreated="RadGridBAOCAOTONGHOPQT_ExcelMLExportRowCreated"
    OnItemDataBound="RadGridBAOCAOTONGHOPQT_ItemDataBound" OnItemCreated="RadGridBAOCAOTONGHOPQT_ItemCreated">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp"
        NextPageToolTip="Trang tiếp" PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau"
        PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true"
        OpenInNewWindow="true" Excel-Format="Biff">
    </ExportSettings>
    <GroupingSettings CaseSensitive="false" />
    <MasterTableView Name="MasterTableViewBAOCAOTONGHOPQT" CommandItemDisplay="Top" DataSourceID="BAOCAOTONGHOPQTDataSource"
        DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
            <div style="padding: 5px 5px; float: left; width: auto">
                <b>Báo cáo tổng hợp theo ngày</b>&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:LinkButton ID="lbPrint" runat="server" Visible="false" CommandName="PrintGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/approval.gif" />In</asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:LinkButton ID="lblRefesh" runat="server" CommandName="RebindGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Refresh.gif" />Làm mới</asp:LinkButton>
            </div>
            <div style="padding: 5px 5px; float: right; width: auto">
                <asp:LinkButton ID="ExportToPdfButton" runat="server" CommandName="ExportToPdf"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/pdf.gif" /></asp:LinkButton>&nbsp;&nbsp;
                <asp:LinkButton ID="ExportToWordButton" runat="server" CommandName="ExportToWord"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/word.gif" /></asp:LinkButton>&nbsp;&nbsp;
                <asp:LinkButton ID="ExportToExcelButton" runat="server" CommandName="ExportToExcel"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/excel.gif" /></asp:LinkButton>&nbsp;&nbsp;
                <asp:LinkButton ID="ExportToCsvButton" runat="server" CommandName="ExportToCsv"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/csv.gif" /></asp:LinkButton>&nbsp;&nbsp;
            </div>
        </CommandItemTemplate>
        <Columns>
            <telerik:GridBoundColumn UniqueName="C_NGAY" HeaderText="Ngày" DataField="C_NGAY"
                HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                ShowFilterIcon="true" FilterControlWidth="75%" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy}">
            </telerik:GridBoundColumn>
            <telerik:GridTemplateColumn UniqueName="C_BILLFIX" HeaderText="Số Bill" DataField="C_BILLFIX"
                HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%"
                SortExpression="C_BILLFIX">
                <ItemTemplate>
                    <%# String.Format("{0}", Eval("C_BILLFIX").ToString())%>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridBoundColumn UniqueName="FK_KHACHHANG" HeaderText="Mã khách hàng" DataField="FK_KHACHHANG"
                HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_TENKH" HeaderText="Tên khách hàng" DataField="C_TENKH"
                HeaderStyle-Width="110px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_NGUOINHAN" HeaderText="Người nhận" DataField="C_NGUOINHAN"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_TELNHAN" HeaderText="Điện thoại người nhận"
                DataField="C_TELNHAN" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_DIACHINHAN" HeaderText="Địa chỉ nhận" DataField="C_DIACHINHAN"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="QUOCGIANAME" HeaderText="Quốc gia" DataField="QUOCGIANAME"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_NOIDUNG" HeaderText="Nội dung" DataField="C_NOIDUNG"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_SOKIEN" HeaderText="Số kiện" DataField="C_SOKIEN"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_GIATRIHANGHOA" HeaderText="Giá trị hàng hoá"
                DataField="C_GIATRIHANGHOA" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_KHOILUONG" HeaderText="Khối lượng" DataField="C_KHOILUONG"
                HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" FilterControlWidth="75%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="SANPHAMNAME" HeaderText="Dịch vụ" DataField="SANPHAMNAME"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_PPXD" HeaderText="PPXD" DataField="C_PPXD"
                HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" FilterControlWidth="75%" DataType="System.Decimal"
                DataFormatString="{0:### ### ###}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_GIACUOC" HeaderText="Cước chính" DataField="C_GIACUOC"
                HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%"
                DataType="System.Decimal" DataFormatString="{0:### ###.## USD}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_DONGGOI" HeaderText="Đóng gói" DataField="C_DONGGOI"
                HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" FilterControlWidth="75%" DataType="System.Decimal"
                DataFormatString="{0:### ### ###}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_KHAIGIA" HeaderText="Khai giá" DataField="C_KHAIGIA"
                HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" FilterControlWidth="75%" DataType="System.Decimal"
                DataFormatString="{0:### ### ###}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_COD" HeaderText="Hun trùng" DataField="C_COD" HeaderStyle-Width="100px"
                HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains"
                FilterControlWidth="75%" DataType="System.Decimal" DataFormatString="{0:### ### ###}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_BAOPHAT" HeaderText="Hải quan" DataField="C_BAOPHAT"
                HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" FilterControlWidth="75%" DataType="System.Decimal"
                DataFormatString="{0:### ### ###}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_HENGIO" HeaderText="Hẹn giờ" DataField="C_HENGIO"
                HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" FilterControlWidth="75%" DataType="System.Decimal"
                DataFormatString="{0:### ### ###}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_TIENHANG" HeaderText="Tiền hàng" DataField="C_TIENHANG"
                HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" FilterControlWidth="75%" DataType="System.Decimal"
                DataFormatString="{0:### ###.## USD}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_VAT" HeaderText="VAT" DataField="C_VAT" HeaderStyle-Width="130px"
                HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains"
                FilterControlWidth="75%" DataType="System.Decimal" DataFormatString="{0:### ###.## USD}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_TIENHANGVAT" HeaderText="Tổng cước (VAT)"
                DataField="C_TIENHANGVAT" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="true"
                FilterControlWidth="75%" DataType="System.Decimal" DataFormatString="{0:### ###.## USD}">
            </telerik:GridBoundColumn>
             <telerik:GridBoundColumn UniqueName="C_TYGIA" HeaderText="Tỷ giá"
                DataField="C_TYGIA" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="true"
                FilterControlWidth="75%" DataType="System.Decimal" DataFormatString="{0:### ### ### VNĐ}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_HINHTHUCTT" HeaderText="HTTT" DataField="C_HINHTHUCTT"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_DATHU" HeaderText="Đã thu" DataField="C_DATHU"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="true" FilterControlWidth="75%"
                DataType="System.Decimal" DataFormatString="{0:### ### ### VNĐ}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_CONLAI" HeaderText="Còn lại" DataField="C_CONLAI"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="true" FilterControlWidth="75%"
                DataType="System.Decimal" DataFormatString="{0:### ### ### VNĐ}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="NHANVIENHANNAME" HeaderText="NV Nhận" DataField="NHANVIENHANNAME"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="NHANVIENPHATNAME" HeaderText="NV Phát" DataField="NHANVIENPHATNAME"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="NHANVIENKHAITHACNAME" HeaderText="NV Khai thác"
                DataField="NHANVIENKHAITHACNAME" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_NGUOIKYNHAN" HeaderText="Người ký nhận" DataField="C_NGUOIKYNHAN"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_BOPHAN" HeaderText="Bộ phận" DataField="C_BOPHAN"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="DOITACNAME" HeaderText="Đối tác" DataField="DOITACNAME"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_GIADOITAC" HeaderText="Giá đối tác" DataField="C_GIADOITAC"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" FilterControlWidth="75%" DataType="System.Decimal"
                DataFormatString="{0:### ### ###}">
            </telerik:GridBoundColumn>
        </Columns>
    </MasterTableView>
    <ClientSettings>
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="True" FrozenColumnsCount="3"
            ScrollHeight="400px" />
    </ClientSettings>
    <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" SortedDescToolTip="Sắp xếp giảm dần"
        SortToolTip="Click để sắp xếp" />
    <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<asp:SqlDataSource ID="BAOCAOTONGHOPQTDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [NHANGUI].[PK_ID], [NHANGUI].[C_NGAY], [NHANGUI].[C_TYGIA], [NHANGUI].[FK_KHACHHANG], [NHANGUI].[C_BILL], 'BC' + [NHANGUI].[C_BILL] as C_BILLFIX, [NHANGUI].[C_TENKH], [NHANGUI].[C_TELGUI], [NHANGUI].[C_NGUOINHAN], [NHANGUI].[C_DIACHINHAN], [NHANGUI].[C_TELNHAN], [NHANGUI].[FK_QUANHUYEN], [NHANGUI].[C_NOIDUNG],[NHANGUI].[C_GIATRIHANGHOA],[NHANGUI].[C_SOKIEN], [NHANGUI].[FK_MASANPHAM],  [NHANGUI].[C_PPXD], [NHANGUI].[C_KHOILUONG], (CASE WHEN [NHANGUI].[C_TYPE] = N'2' THEN ISNULL([NHANGUI].[C_GIACUOC],0) * [NHANGUI].[C_TYGIA] ELSE ISNULL([NHANGUI].[C_GIACUOC],0) END) as [C_GIACUOC], [NHANGUI].[C_HINHTHUCTT], ISNULL([NHANGUI].[C_DATHU],0) as C_DATHU, (CASE WHEN [NHANGUI].[C_TYPE] = N'2' THEN ISNULL([NHANGUI].[C_TIENHANGVAT],0) * [NHANGUI].[C_TYGIA] - ISNULL([NHANGUI].[C_DATHU],0) ELSE ISNULL([NHANGUI].[C_TIENHANGVAT],0) - ISNULL([NHANGUI].[C_DATHU],0) END) as [C_CONLAI], [NHANGUI].[C_DONGGOI], [NHANGUI].[C_KHAIGIA], [NHANGUI].[C_COD], [NHANGUI].[C_BAOPHAT], [NHANGUI].[C_HENGIO], ([NHANGUI].[C_DONGGOI] + [NHANGUI].[C_KHAIGIA] + [NHANGUI].[C_COD] + [NHANGUI].[C_BAOPHAT] + [NHANGUI].[C_HENGIO]) as [C_PHUTROISUM], ISNULL([NHANGUI].[C_TIENHANG],0) as C_TIENHANG, [NHANGUI].[C_VAT], ISNULL([NHANGUI].[C_TIENHANGVAT],0) as C_TIENHANGVAT, [NHANGUI].[FK_NHANVIENNHAN], [NHANGUI].[FK_DOITAC], [NHANGUI].[C_GIADOITAC], [NHANGUI].[FK_NHANVIENPHAT], [NHANGUI].[C_NGAYGIOPHAT], [NHANGUI].[FK_NHANVIENKHAITHAC], [NHANGUI].[C_NGUOIKYNHAN], [NHANGUI].[C_BOPHAN], [NHANGUI].[FK_VUNGLAMVIEC], USERSNHAN.C_NAME as NHANVIENNHANNAME,USERSPHAT.C_NAME as NHANVIENPHATNAME,USERSKHAITHAC.C_NAME as NHANVIENKHAITHACNAME,DMMASANPHAM.C_NAME as SANPHAMNAME,DMQUANHUYEN.C_NAME as QUANHUYENNAME,DMTINHTHANH.C_NAME as TINHTHANHNAME, DMDOITAC.C_NAME as DOITACNAME FROM [NHANGUI] LEFT OUTER JOIN USERS as USERSNHAN ON NHANGUI.FK_NHANVIENNHAN = USERSNHAN.PK_ID LEFT OUTER JOIN USERS as USERSPHAT ON NHANGUI.FK_NHANVIENPHAT = USERSPHAT.PK_ID LEFT OUTER JOIN USERS as USERSKHAITHAC ON NHANGUI.FK_NHANVIENKHAITHAC = USERSKHAITHAC.PK_ID LEFT OUTER JOIN DMMASANPHAM ON NHANGUI.FK_MASANPHAM=DMMASANPHAM.PK_ID LEFT OUTER JOIN DMQUANHUYEN ON NHANGUI.FK_QUANHUYEN = DMQUANHUYEN.C_CODE LEFT OUTER JOIN DMTINHTHANH ON DMQUANHUYEN.FK_TINHTHANH = DMTINHTHANH.PK_ID LEFT OUTER JOIN DMDOITAC ON DMDOITAC.PK_ID = NHANGUI.FK_DOITAC WHERE [NHANGUI].[FK_VUNGLAMVIEC] = @FK_VUNGLAMVIEC AND [NHANGUI].[C_TYPE] = 2 ORDER BY [NHANGUI].C_NGAY DESC">
    <SelectParameters>
        <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
    </SelectParameters>
</asp:SqlDataSource>
