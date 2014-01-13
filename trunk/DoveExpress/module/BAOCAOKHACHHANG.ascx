<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BAOCAOKHACHHANG.ascx.cs"
    Inherits="module_BAOCAOKHACHHANG" %>
<%@ Register TagPrefix="uc1" Namespace="ITCLIB.Admin" %>
<telerik:RadCodeBlock ID="RadCodeBlockBAOCAOKHACHHANG" runat="server">
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

            var grid = $get("<%=RadGridBAOCAOKHACHHANG.ClientID %>");
            var elements = grid.getElementsByTagName(tagName);
            for (var i = 0; i < elements.length; i++) {
                var element = elements[i];
                if (element.id.indexOf(serverID) >= 0)
                    return element;
            }
        }
    </script>
    <script type="text/javascript">
        var cmbkhachhang;
        function OnClientLoadKhachHang(sender) {
            cmbkhachhang = sender;
        }
        function cmbNhomKhachHangClientSelectedIndexChangedHandler(sender, eventArgs) {
            cmbkhachhang.requestItems(eventArgs.get_item().get_value(), false);
        }
        function ItemsLoadedKhachHang(combo, eventArqs) {
            if (combo.get_items().get_count() > 0) {
                combo.trackChanges();
                combo.get_items().getItem(0).select();
                combo.updateClientState();
                combo.commitChanges();
            } else {
                combo.set_text("");
            }
            $find("<%=RadGridBAOCAOKHACHHANG.ClientID %>").get_masterTableView().rebind();
        }
        function cmbKhachHangClientSelectedIndexChangedHandler(sender, eventArgs) {
            $find("<%=RadGridBAOCAOKHACHHANG.ClientID %>").get_masterTableView().rebind();
        }
        function cmbYearClientSelectedIndexChangedHandler(sender, eventArgs) {
            $find("<%=RadGridBAOCAOKHACHHANG.ClientID %>").get_masterTableView().rebind();
            return false;
        }
        function cmbMonthClientSelectedIndexChangedHandler(sender, eventArgs) {
            $find("<%=RadGridBAOCAOKHACHHANG.ClientID %>").get_masterTableView().rebind();
            return false;
        }
    </script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelBAOCAOKHACHHANG"
    runat="server" />
<div style="width: 100%; margin: 10px 10px 10px 10px;">
    Chọn tháng:&nbsp;
    <telerik:RadComboBox ID="cmbMonth" runat="server" OnClientSelectedIndexChanged="cmbMonthClientSelectedIndexChangedHandler"
        ShowToggleImage="True" EmptyMessage="Chọn tháng" OnPreRender="cmbMonth_PreRender">
        <Items>
            <telerik:RadComboBoxItem Value="0" Text="Tất cả" />
            <telerik:RadComboBoxItem Value="1" Text="Tháng 1" />
            <telerik:RadComboBoxItem Value="2" Text="Tháng 2" />
            <telerik:RadComboBoxItem Value="3" Text="Tháng 3" />
            <telerik:RadComboBoxItem Value="4" Text="Tháng 4" />
            <telerik:RadComboBoxItem Value="5" Text="Tháng 5" />
            <telerik:RadComboBoxItem Value="6" Text="Tháng 6" />
            <telerik:RadComboBoxItem Value="7" Text="Tháng 7" />
            <telerik:RadComboBoxItem Value="8" Text="Tháng 8" />
            <telerik:RadComboBoxItem Value="9" Text="Tháng 9" />
            <telerik:RadComboBoxItem Value="10" Text="Tháng 10" />
            <telerik:RadComboBoxItem Value="11" Text="Tháng 11" />
            <telerik:RadComboBoxItem Value="12" Text="Tháng 12" />
        </Items>
    </telerik:RadComboBox>
    Chọn năm:&nbsp;
    <telerik:RadComboBox ID="cmbYear" runat="server" OnClientSelectedIndexChanged="cmbYearClientSelectedIndexChangedHandler"
        ShowToggleImage="True" EmptyMessage="Chọn năm" OnPreRender="cmbYear_PreRender">
        <Items>
            <telerik:RadComboBoxItem Value="0" Text="Tất cả" />
        </Items>
    </telerik:RadComboBox>
    Nhóm khách hàng:&nbsp;
    <telerik:RadComboBox ID="cmbNhomKhachHang" runat="server" DataTextField="C_NAME"
        DataValueField="PK_ID" DataSourceID="NHOMKHACHHANGDataSource" ShowToggleImage="True"
        EmptyMessage="Chọn nhóm" OnClientSelectedIndexChanged="cmbNhomKhachHangClientSelectedIndexChangedHandler"
        OnPreRender="cmbNhomKhachHang_PreRender">
    </telerik:RadComboBox>
    Khách hàng:&nbsp;
    <telerik:RadComboBox ID="cmbKhachHang" runat="server" DataTextField="C_CODE" DataValueField="C_CODE"
        DataSourceID="KHACHHANGDataSource" ShowToggleImage="True" EmptyMessage="Chọn khách hàng"
        OnClientItemsRequested="ItemsLoadedKhachHang" OnClientLoad="OnClientLoadKhachHang"
        OnItemsRequested="cmbKhachHang_ItemsRequested" OnClientSelectedIndexChanged="cmbKhachHangClientSelectedIndexChangedHandler">
    </telerik:RadComboBox>
</div>
<telerik:RadGrid ID="RadGridBAOCAOKHACHHANG" runat="server" Skin="Vista" AllowPaging="True"
    PageSize="50" AllowSorting="True" AllowFilteringByColumn="True" GridLines="None" AllowMultiRowSelection="True"
    ShowStatusBar="True" AutoGenerateColumns="False" OnItemCommand="RadGridBAOCAOKHACHHANG_ItemCommand"
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" AllowAutomaticInserts="True"
    AllowAutomaticUpdates="True" DataSourceID="BAOCAOKHACHHANGDataSource" ShowFooter="True"
    OnDataBound="RadGridBAOCAOKHACHHANG_DataBound" CellSpacing="0" OnExcelMLExportRowCreated="RadGridBAOCAOKHACHHANG_ExcelMLExportRowCreated"
    OnItemDataBound="RadGridBAOCAOKHACHHANG_ItemDataBound" OnItemCreated="RadGridBAOCAOKHACHHANG_ItemCreated">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp"
        NextPageToolTip="Trang tiếp" PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau"
        PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true"
        OpenInNewWindow="true" Excel-Format="Biff">
    </ExportSettings>
    <GroupingSettings CaseSensitive="false" />
    <MasterTableView Name="MasterTableViewBAOCAOKHACHHANG" CommandItemDisplay="Top" DataSourceID="BAOCAOKHACHHANGDataSource"
        DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
            <div style="padding: 5px 5px; float: left; width: auto">
                <b>Báo cáo doanh số theo khách hàng</b>&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:LinkButton ID="LinkButton5" runat="server" OnClientClick="javascript:return confirm('Bạn có muốn xác nhận các Bill này đã thanh toán không?')"
                    CommandName="ConfirmPayment" Visible='<%# ITCLIB.Security.Security.CanPrintModule("NHANGUI") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/img_OpenPanel.gif" />Xác nhận đã thanh toán</asp:LinkButton>&nbsp;&nbsp;
                <asp:LinkButton ID="LinkButton6" runat="server" OnClientClick="javascript:return confirm('Bạn có muốn xác nhận các Bill này chưa thanh toán không?')"
                    CommandName="ConfirmUnPayment" Visible='<%# ITCLIB.Security.Security.CanPrintModule("NHANGUI") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/img_OpenPanel.gif" />Xác nhận chưa thanh toán</asp:LinkButton>&nbsp;&nbsp;
                <asp:LinkButton ID="lblRefesh" runat="server" CommandName="RebindGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Refresh.gif" />Làm mới</asp:LinkButton>
            </div>
            <div style="padding: 5px 5px; float: right; width: auto">
                <asp:LinkButton ID="ExportToPdfButton" runat="server" CommandName="ExportToPdf"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/pdf.gif" /></asp:LinkButton>&nbsp;&nbsp;
                <asp:LinkButton ID="ExportToWordButton" runat="server" CommandName="ExportToWord"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/word.gif" /></asp:LinkButton>&nbsp;&nbsp;
                <asp:LinkButton ID="ExportToExcelButton" runat="server" CommandName="ExportToExcel"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/excel.gif" /></asp:LinkButton>&nbsp;&nbsp;
                <asp:LinkButton ID="ExportToCsvButton" runat="server" CommandName="ExportToCsv"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/csv.gif" /></asp:LinkButton>&nbsp;&nbsp;
            </div>
        </CommandItemTemplate>
        <GroupByExpressions>
            <telerik:GridGroupByExpression>
                <SelectFields>
                    <telerik:GridGroupByField FieldAlias="C_KHOILUONG" Aggregate="Sum" FieldName="C_KHOILUONG"
                        FormatString=" {0} g" HeaderText="Khối lượng" />
                    <telerik:GridGroupByField FieldAlias="C_TIENHANGVAT" Aggregate="Sum" FieldName="C_TIENHANGVAT"
                        FormatString="{0:### ### ### VNĐ}" HeaderText="Tổng cước (VAT)" />
                    <telerik:GridGroupByField FieldAlias="C_DATHU" Aggregate="Sum" FieldName="C_DATHU"
                        FormatString="{0:### ### ### VNĐ}" HeaderText="Đã thu" />
                    <telerik:GridGroupByField FieldAlias="C_CONLAI" Aggregate="Sum" FieldName="C_CONLAI"
                        FormatString="{0:### ### ### VNĐ}" HeaderText="Còn lại" />
                </SelectFields>
                <GroupByFields>
                    <telerik:GridGroupByField FieldAlias="FK_KHACHHANG" FieldName="FK_KHACHHANG" />
                </GroupByFields>
            </telerik:GridGroupByExpression>
        </GroupByExpressions>
        <Columns>
            <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn" HeaderStyle-Width="40px"
                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
            </telerik:GridClientSelectColumn>
            <telerik:GridBoundColumn UniqueName="C_NGAYFIX" HeaderText="Ngày" DataField="C_NGAYFIX"
                HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                ShowFilterIcon="true" FilterControlWidth="75%" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy}">
            </telerik:GridBoundColumn>
            <telerik:GridTemplateColumn UniqueName="C_BILLFIX" HeaderText="Số Bill" DataField="C_BILLFIX"
                HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%"
                SortExpression="C_BILLFIX">
                <ItemTemplate>
                    <asp:Label ID="lblC_BILL" runat="server" Text='<%# String.Format("{0}", Eval("C_BILLFIX").ToString())%>'></asp:Label>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridBoundColumn UniqueName="C_NGUOINHAN" HeaderText="Người nhận" DataField="C_NGUOINHAN"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_DIACHINHAN" HeaderText="Địa chỉ nhận" DataField="C_DIACHINHAN"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_DIACHINHANFIX" HeaderText="Tỉnh/Quốc Gia"
                DataField="C_DIACHINHANFIX" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_NOIDUNG" HeaderText="Nội dung" DataField="C_NOIDUNG"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_KHOILUONG" HeaderText="Khối lượng" DataField="C_KHOILUONG"
                HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                DataType="System.Int64" CurrentFilterFunction="Contains" FilterControlWidth="75%"
                Aggregate="Sum" FooterText="Tổng : ">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_GIACUOC" HeaderText="Cước chính" DataField="C_GIACUOC"
                HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" FilterControlWidth="75%" DataType="System.Int64"
                DataFormatString="{0:### ### ###}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_TIENHANGVAT" HeaderText="Tổng cước (VAT)"
                DataField="C_TIENHANGVAT" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlWidth="75%"
                Aggregate="Sum" FooterText="Tổng : " DataType="System.Decimal" DataFormatString="{0:### ### ###}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_DATHU" HeaderText="Đã thu" DataField="C_DATHU"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" FilterControlWidth="75%" Aggregate="Sum" FooterText="Tổng : "
                DataType="System.Decimal" DataFormatString="{0:### ### ###}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_CONLAI" HeaderText="Còn lại" DataField="C_CONLAI"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" FilterControlWidth="75%" Aggregate="Sum" FooterText="Tổng : "
                DataType="System.Decimal" DataFormatString="{0:### ### ###}">
            </telerik:GridBoundColumn>
        </Columns>
    </MasterTableView>
    <ClientSettings>
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="True" FrozenColumnsCount="0"
            ScrollHeight="450px" />
    </ClientSettings>
    <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" SortedDescToolTip="Sắp xếp giảm dần"
        SortToolTip="Click để sắp xếp" />
    <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<asp:SqlDataSource ID="BAOCAOKHACHHANGDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [NHANGUI].[PK_ID], [NHANGUI].[C_NGAY], CONVERT(date, [NHANGUI].[C_NGAY]) as C_NGAYFIX, [NHANGUI].[FK_KHACHHANG], [NHANGUI].[C_BILL], 'BC' + [NHANGUI].[C_BILL] as C_BILLFIX, [NHANGUI].[C_TENKH], [NHANGUI].[C_TELGUI], [NHANGUI].[C_NGUOINHAN], [NHANGUI].[C_DIACHINHAN], [NHANGUI].[C_TELNHAN], [NHANGUI].[FK_QUANHUYEN], [NHANGUI].[C_NOIDUNG], [NHANGUI].[FK_MASANPHAM],  [NHANGUI].[C_PPXD], [NHANGUI].[C_KHOILUONG], (CASE WHEN [NHANGUI].[C_TYPE] = N'2' THEN ISNULL([NHANGUI].[C_GIACUOC],0) * [NHANGUI].[C_TYGIA] ELSE ISNULL([NHANGUI].[C_GIACUOC],0) END) as [C_GIACUOC], [NHANGUI].[C_HINHTHUCTT], ISNULL([NHANGUI].[C_DATHU],0) as C_DATHU, (CASE WHEN [NHANGUI].[C_TYPE] = N'2' THEN ISNULL([NHANGUI].[C_TIENHANGVAT],0) * [NHANGUI].[C_TYGIA] - ISNULL([NHANGUI].[C_DATHU],0) ELSE ISNULL([NHANGUI].[C_TIENHANGVAT],0) - ISNULL([NHANGUI].[C_DATHU],0) END) as [C_CONLAI],([NHANGUI].[C_DONGGOI] + [NHANGUI].[C_KHAIGIA] + [NHANGUI].[C_COD] + [NHANGUI].[C_BAOPHAT] + [NHANGUI].[C_HENGIO]) as [C_PHUTROISUM], [NHANGUI].[C_TIENHANG], [NHANGUI].[C_VAT], (CASE WHEN [NHANGUI].[C_TYPE] = N'2' THEN ISNULL([NHANGUI].[C_TIENHANGVAT],0) * [NHANGUI].[C_TYGIA] ELSE ISNULL([NHANGUI].[C_TIENHANGVAT],0) END) as C_TIENHANGVAT, [NHANGUI].[FK_NHANVIENNHAN], [NHANGUI].[FK_DOITAC], [NHANGUI].[C_GIADOITAC], [NHANGUI].[FK_NHANVIENPHAT], [NHANGUI].[C_NGAYGIOPHAT], [NHANGUI].[FK_NHANVIENKHAITHAC], [NHANGUI].[C_NGUOIKYNHAN], [NHANGUI].[C_BOPHAN],USERSNHAN.C_NAME as NHANVIENNHANNAME,USERSPHAT.C_NAME as NHANVIENPHATNAME,USERSKHAITHAC.C_NAME as NHANVIENKHAITHACNAME,DMMASANPHAM.C_NAME as SANPHAMNAME,DMQUANHUYEN.C_NAME as QUANHUYENNAME,DMTINHTHANH.C_NAME as TINHTHANHNAME,CASE WHEN NHANGUI.C_TYPE = 1 THEN DMQUANHUYEN.C_NAME + '-' + DMTINHTHANH.C_NAME ELSE DMQUOCGIA.C_NAME END AS C_DIACHINHANFIX FROM [NHANGUI] LEFT OUTER JOIN USERS as USERSNHAN ON NHANGUI.FK_NHANVIENNHAN = USERSNHAN.PK_ID LEFT OUTER JOIN USERS as USERSPHAT ON NHANGUI.FK_NHANVIENPHAT = USERSPHAT.PK_ID LEFT OUTER JOIN USERS as USERSKHAITHAC ON NHANGUI.FK_NHANVIENKHAITHAC = USERSKHAITHAC.PK_ID LEFT OUTER JOIN DMMASANPHAM ON NHANGUI.FK_MASANPHAM=DMMASANPHAM.PK_ID LEFT OUTER JOIN DMQUANHUYEN ON NHANGUI.FK_QUANHUYEN = DMQUANHUYEN.C_CODE LEFT OUTER JOIN DMTINHTHANH ON DMQUANHUYEN.FK_TINHTHANH = DMTINHTHANH.PK_ID LEFT OUTER JOIN DMQUOCGIA ON NHANGUI.FK_QUOCGIA = DMQUOCGIA.C_CODE WHERE (month([NHANGUI].[C_NGAY]) = @MONTH OR @MONTH = 0) AND (year([NHANGUI].[C_NGAY]) = @YEAR OR @YEAR = 0) AND ([NHANGUI].[FK_KHACHHANG] = @FK_KHACHHANG AND [NHANGUI].[FK_VUNGLAMVIEC] = @FK_VUNGLAMVIEC)">
    <SelectParameters>
        <asp:ControlParameter ControlID="cmbMonth" Name="MONTH" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="cmbYear" Name="YEAR" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="cmbKhachHang" DefaultValue="0" Name="FK_KHACHHANG"
            PropertyName="SelectedValue" />
        <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="NHOMKHACHHANGDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT DMNHOMKHACHHANG.* FROM DMNHOMKHACHHANG WHERE FK_VUNGLAMVIEC = @FK_VUNGLAMVIEC">
    <SelectParameters>
        <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="KHACHHANGDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>">
</asp:SqlDataSource>
