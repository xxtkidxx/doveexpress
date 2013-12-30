﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BAOCAODOITAC.ascx.cs"
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
        DataValueField="PK_ID" DataSourceID="DoiTacDataSource" ShowToggleImage="True"
        OnClientSelectedIndexChanged="cmbDoiTacClientSelectedIndexChangedHandler" EmptyMessage="Chọn đối tác">
    </telerik:RadComboBox>
</div>
<telerik:RadGrid ID="RadGridBAOCAODOITAC" runat="server" Skin="Vista" AllowPaging="True"
    PageSize="50" AllowSorting="True" AllowFilteringByColumn="True" GridLines="None"
    ShowStatusBar="True" AutoGenerateColumns="False" OnItemCommand="RadGridBAOCAODOITAC_ItemCommand"
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" AllowAutomaticInserts="True"
    AllowAutomaticUpdates="True" DataSourceID="BAOCAODOITACDataSource" ShowFooter="True"
    OnDataBound="RadGridBAOCAODOITAC_DataBound" CellSpacing="0" OnExcelMLExportRowCreated="RadGridBAOCAODOITAC_ExcelMLExportRowCreated"
    OnItemDataBound="RadGridBAOCAODOITAC_ItemDataBound">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp"
        NextPageToolTip="Trang tiếp" PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau"
        PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true"
        OpenInNewWindow="true" Excel-Format="Biff">
    </ExportSettings>
    <GroupingSettings CaseSensitive="false" />
    <MasterTableView Name="MasterTableViewBAOCAODOITAC" CommandItemDisplay="Top" DataSourceID="BAOCAODOITACDataSource"
        DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
            <div style="padding: 5px 5px; float: left; width: auto">
                <b>Báo cáo doanh số theo ngày</b>&nbsp;&nbsp;&nbsp;&nbsp;
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
                FilterControlWidth="75%" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy}">
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
<asp:SqlDataSource ID="BAOCAODOITACDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [NHANGUI].[PK_ID], [NHANGUI].[C_NGAY], [NHANGUI].[FK_KHACHHANG], [NHANGUI].[C_BILL], 'BC' + [NHANGUI].[C_BILL] as C_BILLFIX, [NHANGUI].[C_TENKH], [NHANGUI].[C_TELGUI], [NHANGUI].[C_NGUOINHAN], [NHANGUI].[C_DIACHINHAN], [NHANGUI].[C_TELNHAN], [NHANGUI].[FK_QUANHUYEN], [NHANGUI].[C_NOIDUNG], [NHANGUI].[FK_MASANPHAM],  [NHANGUI].[C_PPXD], [NHANGUI].[C_KHOILUONG], [NHANGUI].[C_GIACUOC], [NHANGUI].[C_HINHTHUCTT], ISNULL([NHANGUI].[C_DATHU],0) as C_DATHU, (ISNULL([NHANGUI].[C_TIENHANGVAT],0) - ISNULL([NHANGUI].[C_DATHU],0)) as [C_CONLAI],([NHANGUI].[C_DONGGOI] + [NHANGUI].[C_KHAIGIA] + [NHANGUI].[C_COD] + [NHANGUI].[C_BAOPHAT] + [NHANGUI].[C_HENGIO]) as [C_PHUTROISUM], [NHANGUI].[C_TIENHANG], [NHANGUI].[C_VAT], ISNULL([NHANGUI].[C_TIENHANGVAT],0) as C_TIENHANGVAT, [NHANGUI].[FK_NHANVIENNHAN], [NHANGUI].[FK_DOITAC], [NHANGUI].[C_GIADOITAC], [NHANGUI].[FK_NHANVIENPHAT], [NHANGUI].[C_NGAYGIOPHAT], [NHANGUI].[FK_NHANVIENKHAITHAC], [NHANGUI].[C_NGUOIKYNHAN], [NHANGUI].[C_BOPHAN], [NHANGUI].[FK_VUNGLAMVIEC], USERSNHAN.C_NAME as NHANVIENNHANNAME,USERSPHAT.C_NAME as NHANVIENPHATNAME,USERSKHAITHAC.C_NAME as NHANVIENKHAITHACNAME,DMMASANPHAM.C_NAME as SANPHAMNAME,DMQUANHUYEN.C_NAME as QUANHUYENNAME,DMTINHTHANH.C_NAME as TINHTHANHNAME FROM [NHANGUI] LEFT OUTER JOIN USERS as USERSNHAN ON NHANGUI.FK_NHANVIENNHAN = USERSNHAN.PK_ID LEFT OUTER JOIN USERS as USERSPHAT ON NHANGUI.FK_NHANVIENPHAT = USERSPHAT.PK_ID LEFT OUTER JOIN USERS as USERSKHAITHAC ON NHANGUI.FK_NHANVIENKHAITHAC = USERSKHAITHAC.PK_ID LEFT OUTER JOIN DMMASANPHAM ON NHANGUI.FK_MASANPHAM=DMMASANPHAM.PK_ID LEFT OUTER JOIN DMQUANHUYEN ON NHANGUI.FK_QUANHUYEN = DMQUANHUYEN.C_CODE LEFT OUTER JOIN DMTINHTHANH ON DMQUANHUYEN.FK_TINHTHANH = DMTINHTHANH.PK_ID WHERE ([NHANGUI].[C_NGAY] >= @TUNGAY) AND ([NHANGUI].[C_NGAY] <= @DENNGAY) AND [NHANGUI].[FK_VUNGLAMVIEC] = @FK_VUNGLAMVIEC AND [NHANGUI].[FK_DOITAC] = @FK_DOITAC">
    <SelectParameters>
        <asp:ControlParameter ControlID="radTuNgay" DefaultValue="0" Name="TUNGAY" PropertyName="SelectedDate" />
        <asp:ControlParameter ControlID="radDenNgay" DefaultValue="0" Name="DENNGAY" PropertyName="SelectedDate" />
        <asp:ControlParameter ControlID="cmbDoitac" DefaultValue="0" Name="FK_DOITAC" PropertyName="SelectedValue" />
        <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="DoiTacDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMDoiTac] WHERE [DMDOITAC].FK_VUNGLAMVIEC = @FK_VUNGLAMVIEC ORDER BY LTRIM([C_CODE])">
    <SelectParameters>
        <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
    </SelectParameters>
</asp:SqlDataSource>
