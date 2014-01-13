<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BAOCAODOITAC.ascx.cs"
    Inherits="module_BAOCAODOITAC" %>
<%@ Register TagPrefix="uc1" Namespace="ITCLIB.Admin" %>
<telerik:RadCodeBlock ID="RadCodeBlockBAOCAODOITAC" runat="server">
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

            var grid = $get("<%=RadGridBAOCAODOITAC.ClientID %>");
            var elements = grid.getElementsByTagName(tagName);
            for (var i = 0; i < elements.length; i++) {
                var element = elements[i];
                if (element.id.indexOf(serverID) >= 0)
                    return element;
            }
        }
        function cmbDoiTacClientSelectedIndexChangedHandler(sender, eventArgs) {
            $find("<%=RadGridBAOCAODOITAC.ClientID %>").get_masterTableView().rebind();
            return false;
        }
    </script>
     <script type="text/javascript">
         function DoitacOnClientLinkClicked() {
             if ($find("<%= RadGridBAOCAODOITAC.MasterTableView.ClientID %>").get_selectedItems().length != 0) {
                 var IDString = 'BILL';
                 for (index = 0; index < $find("<%= RadGridBAOCAODOITAC.MasterTableView.ClientID %>").get_selectedItems().length; ++index) {
                     IDString += '-' + $find("<%= RadGridBAOCAODOITAC.MasterTableView.ClientID %>").get_selectedItems()[index].getDataKeyValue("C_BILL");
                 }
                 var oWindow = radopen("Popup.aspx?ctl=DOITACPOPUP&IDBILL=" + IDString, "Cập nhật đối tác");
             } else {
                 alert("Không có phiếu nhận gửi được chọn");
             }
             return false;
         }
         function OnClientShowBAOCAODOITAC(sender, eventArgs) {

         }
         function OnClientCloseBAOCAODOITAC(sender, eventArgs) {
             //var TypeName = sender.get_name();
             $find("<%=RadGridBAOCAODOITAC.ClientID %>").get_masterTableView().rebind();
         }
    </script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelBAOCAODOITAC" runat="server" />
<div style="width: 90%; margin: 10px 10px 10px 10px;">
    Từ ngày:&nbsp;
    <telerik:RadDatePicker ID="radTuNgay" Width="150px" runat="server" AutoPostBack="true">
        <DateInput ID="DateInput1" runat="server" DateFormat="dd/MM/yyyy" MinDate="1/1/1890 12:00:00 AM">
        </DateInput>
    </telerik:RadDatePicker>
    Đến ngày:&nbsp;
    <telerik:RadDatePicker ID="radDenNgay" Width="150px" runat="server" AutoPostBack="true">
        <DateInput ID="DateInput2" runat="server" DateFormat="dd/MM/yyyy" MinDate="1/1/1890 12:00:00 AM">
        </DateInput>
    </telerik:RadDatePicker>
    Đối tác:&nbsp;
    <telerik:RadComboBox ID="cmbDoiTac" runat="server" Width="150px" DataTextField="C_NAME"
        DataValueField="PK_ID" DataSourceID="DoiTacDataSource" ShowToggleImage="True" OnPreRender="cmbDoiTac_PreRender"
        OnClientSelectedIndexChanged="cmbDoiTacClientSelectedIndexChangedHandler" EmptyMessage="Chọn đối tác">
    </telerik:RadComboBox>
</div>
<telerik:RadGrid ID="RadGridBAOCAODOITAC" runat="server" Skin="Vista" AllowPaging="True"
    PageSize="50" AllowSorting="True" AllowFilteringByColumn="True" GridLines="None" AllowMultiRowSelection="True"
    ShowStatusBar="True" AutoGenerateColumns="False" OnItemCommand="RadGridBAOCAODOITAC_ItemCommand"
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" AllowAutomaticInserts="True"
    AllowAutomaticUpdates="True" DataSourceID="BAOCAODOITACDataSource" ShowFooter="True"
    OnDataBound="RadGridBAOCAODOITAC_DataBound" CellSpacing="0" OnExcelMLExportRowCreated="RadGridBAOCAODOITAC_ExcelMLExportRowCreated"
    OnItemDataBound="RadGridBAOCAODOITAC_ItemDataBound" onitemcreated="RadGridBAOCAODOITAC_ItemCreated">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp"
        NextPageToolTip="Trang tiếp" PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau"
        PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true"
        OpenInNewWindow="true" Excel-Format="Biff">
    </ExportSettings>
    <GroupingSettings CaseSensitive="false" />
    <MasterTableView Name="MasterTableViewBAOCAODOITAC" CommandItemDisplay="Top" DataSourceID="BAOCAODOITACDataSource"
        DataKeyNames="C_BILL" ClientDataKeyNames="C_BILL" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
            <div style="padding: 5px 5px; float: left; width: auto">
                <b>Báo cáo doanh số theo đối tác</b>&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:LinkButton ID="btnTrangthai" runat="server" OnClientClick='<%# String.Format("javascript:return DoitacOnClientLinkClicked()")%>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/img_OpenPanel.gif"/>Cập nhật đối tác hàng loạt</asp:LinkButton>&nbsp;&nbsp;
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
            <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn" HeaderStyle-Width="40px"
                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
            </telerik:GridClientSelectColumn>
            <telerik:GridBoundColumn UniqueName="C_NGAYFIX" HeaderText="Ngày" DataField="C_NGAYFIX"
                HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                ShowFilterIcon="true" FilterControlWidth="75%" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy}">
            </telerik:GridBoundColumn>
            <telerik:GridTemplateColumn UniqueName="C_BILLFIX" HeaderText="Số Bill" DataField="C_BILLFIX"
                HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" FilterControlWidth="75%" SortExpression="C_BILLFIX">
                <ItemTemplate>
                    <%# String.Format("{0}", Eval("C_BILLFIX").ToString())%>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridBoundColumn UniqueName="C_NGUOINHAN" HeaderText="Người nhận" DataField="C_NGUOINHAN"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_TELNHAN" HeaderText="Số điện thoại nhận" DataField="C_TELNHAN"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_DIACHINHAN" HeaderText="Địa chỉ nhận" DataField="C_DIACHINHAN"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_DIACHINHANFIX" HeaderText="Tỉnh/Quốc Gia" DataField="C_DIACHINHANFIX"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_NOIDUNG" HeaderText="Nội dung" DataField="C_NOIDUNG"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_KHOILUONG" HeaderText="Khối lượng" DataField="C_KHOILUONG"
                HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" FilterControlWidth="75%" Aggregate="Sum" FooterText="Tổng : ">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_TIENHANGVAT" HeaderText="Tổng cước (VAT)"
                DataField="C_TIENHANGVAT" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlWidth="75%"
                Aggregate="Sum" FooterText="Tổng : " DataType="System.Decimal" DataFormatString="{0:### ### ###}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_GIATRIHANGHOA" HeaderText="Giá trị hàng hoá"
                DataField="C_GIATRIHANGHOA" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlWidth="75%"
                DataType="System.Decimal" DataFormatString="{0:### ### ###}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_GIADOITAC" HeaderText="Giá đối tác" DataField="C_GIADOITAC"
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
<telerik:RadWindowManager ReloadOnShow="true" ShowContentDuringLoad="false" ID="RadWindowManagerBAOCAODOITAC"
    runat="server" VisibleStatusbar="False" OnClientClose="OnClientCloseBAOCAODOITAC"
    Behaviors="Move, Close" OnClientShow="OnClientShowBAOCAODOITAC" Width="900px" Height="100%"
    Top="50px" Left="100px">
</telerik:RadWindowManager>
<asp:SqlDataSource ID="BAOCAODOITACDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [NHANGUI].[PK_ID], [NHANGUI].[C_NGAY], DATEDIFF(D, 0, [NHANGUI].[C_NGAY])) as C_NGAYFIX, [NHANGUI].[FK_KHACHHANG], [NHANGUI].[C_BILL], 'BC' + [NHANGUI].[C_BILL] as C_BILLFIX, [NHANGUI].[C_TENKH], [NHANGUI].[C_TELGUI], [NHANGUI].[C_NGUOINHAN], [NHANGUI].[C_DIACHINHAN], [NHANGUI].[C_TELNHAN], [NHANGUI].[FK_QUANHUYEN], [NHANGUI].[C_NOIDUNG], [NHANGUI].[FK_MASANPHAM],  [NHANGUI].[C_PPXD], [NHANGUI].[C_KHOILUONG], (CASE WHEN [NHANGUI].[C_COD] <> 0 THEN ISNULL([NHANGUI].[C_GIATRIHANGHOA],0) ELSE 0 END) as [C_GIATRIHANGHOA], (CASE WHEN [NHANGUI].[C_TYPE] = N'2' THEN ISNULL([NHANGUI].[C_GIACUOC],0) * [NHANGUI].[C_TYGIA] ELSE ISNULL([NHANGUI].[C_GIACUOC],0) END) as [C_GIACUOC], [NHANGUI].[C_HINHTHUCTT], ISNULL([NHANGUI].[C_DATHU],0) as C_DATHU, (CASE WHEN [NHANGUI].[C_TYPE] = N'2' THEN ISNULL([NHANGUI].[C_TIENHANGVAT],0) * [NHANGUI].[C_TYGIA] - ISNULL([NHANGUI].[C_DATHU],0) ELSE ISNULL([NHANGUI].[C_TIENHANGVAT],0) - ISNULL([NHANGUI].[C_DATHU],0) END) as [C_CONLAI],([NHANGUI].[C_DONGGOI] + [NHANGUI].[C_KHAIGIA] + [NHANGUI].[C_COD] + [NHANGUI].[C_BAOPHAT] + [NHANGUI].[C_HENGIO]) as [C_PHUTROISUM], [NHANGUI].[C_TIENHANG], [NHANGUI].[C_VAT], (CASE WHEN [NHANGUI].[C_HINHTHUCTT] = N'Thanh toán đầu nhận' THEN CASE WHEN [NHANGUI].[C_TYPE] = N'2' THEN ISNULL([NHANGUI].[C_TIENHANGVAT],0) * [NHANGUI].[C_TYGIA] ELSE ISNULL([NHANGUI].[C_TIENHANGVAT],0) END ELSE 0 END) as C_TIENHANGVAT, [NHANGUI].[FK_NHANVIENNHAN], [NHANGUI].[FK_DOITAC], [NHANGUI].[C_GIADOITAC], [NHANGUI].[FK_NHANVIENPHAT], [NHANGUI].[C_NGAYGIOPHAT], [NHANGUI].[FK_NHANVIENKHAITHAC], [NHANGUI].[C_NGUOIKYNHAN], [NHANGUI].[C_BOPHAN], [NHANGUI].[FK_VUNGLAMVIEC], USERSNHAN.C_NAME as NHANVIENNHANNAME,USERSPHAT.C_NAME as NHANVIENPHATNAME,USERSKHAITHAC.C_NAME as NHANVIENKHAITHACNAME,DMMASANPHAM.C_NAME as SANPHAMNAME,DMQUANHUYEN.C_NAME as QUANHUYENNAME,DMTINHTHANH.C_NAME as TINHTHANHNAME,CASE WHEN NHANGUI.C_TYPE = 1 THEN DMQUANHUYEN.C_NAME + '-' + DMTINHTHANH.C_NAME ELSE DMQUOCGIA.C_NAME END AS C_DIACHINHANFIX FROM [NHANGUI] LEFT OUTER JOIN USERS as USERSNHAN ON NHANGUI.FK_NHANVIENNHAN = USERSNHAN.PK_ID LEFT OUTER JOIN USERS as USERSPHAT ON NHANGUI.FK_NHANVIENPHAT = USERSPHAT.PK_ID LEFT OUTER JOIN USERS as USERSKHAITHAC ON NHANGUI.FK_NHANVIENKHAITHAC = USERSKHAITHAC.PK_ID LEFT OUTER JOIN DMMASANPHAM ON NHANGUI.FK_MASANPHAM=DMMASANPHAM.PK_ID LEFT OUTER JOIN DMQUANHUYEN ON NHANGUI.FK_QUANHUYEN = DMQUANHUYEN.C_CODE LEFT OUTER JOIN DMTINHTHANH ON DMQUANHUYEN.FK_TINHTHANH = DMTINHTHANH.PK_ID LEFT OUTER JOIN DMQUOCGIA ON NHANGUI.FK_QUOCGIA = DMQUOCGIA.C_CODE WHERE ([NHANGUI].[C_NGAY] >= @TUNGAY) AND ([NHANGUI].[C_NGAY] <= @DENNGAY) AND [NHANGUI].[FK_VUNGLAMVIEC] = @FK_VUNGLAMVIEC AND (@FK_DOITAC = 0 OR [NHANGUI].[FK_DOITAC] = @FK_DOITAC)">
    <SelectParameters>
        <asp:ControlParameter ControlID="radTuNgay" DefaultValue="0" Name="TUNGAY" PropertyName="SelectedDate" />
        <asp:ControlParameter ControlID="radDenNgay" DefaultValue="0" Name="DENNGAY" PropertyName="SelectedDate" />
        <asp:ControlParameter ControlID="cmbDoitac" DefaultValue="0" Name="FK_DOITAC" PropertyName="SelectedValue" />
        <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="DoiTacDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMDoiTac] ORDER BY LTRIM([C_CODE])">
</asp:SqlDataSource>
