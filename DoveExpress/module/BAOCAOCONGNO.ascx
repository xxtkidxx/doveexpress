<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BAOCAOCONGNO.ascx.cs" Inherits="module_BAOCAOCONGNO" %>
<%@ Register TagPrefix="uc1" Namespace="ITCLIB.Admin" %>
<telerik:RadCodeBlock ID="RadCodeBlockBAOCAOCONGNO" runat="server">
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

        var grid = $get("<%=RadGridBAOCAOCONGNO.ClientID %>");
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
        $find("<%=RadGridBAOCAOCONGNO.ClientID %>").get_masterTableView().rebind();
    }
    function cmbKhachHangClientSelectedIndexChangedHandler(sender, eventArgs) {
        $find("<%=RadGridBAOCAOCONGNO.ClientID %>").get_masterTableView().rebind();
    }
</script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelBAOCAOCONGNO" runat="server" />
<div style ="width:100%; margin: 10px 10px 10px 10px; ">
Nhóm khách hàng:&nbsp; 
<telerik:RadComboBox ID="cmbNhomKhachHang" runat="server"
DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="NHOMKHACHHANGDataSource"
ShowToggleImage="True" EmptyMessage="Chọn nhóm"
onclientselectedindexchanged="cmbNhomKhachHangClientSelectedIndexChangedHandler" onprerender="cmbNhomKhachHang_PreRender">
</telerik:RadComboBox>
Khách hàng:&nbsp; 
<telerik:RadComboBox ID="cmbKhachHang" runat="server" 
DataTextField="C_CODE" DataValueField="C_CODE" DataSourceID="KHACHHANGDataSource"
ShowToggleImage="True" EmptyMessage="Chọn khách hàng" AutoPostBack ="false"
onclientitemsrequested="ItemsLoadedKhachHang" onclientload="OnClientLoadKhachHang" 
onitemsrequested="cmbKhachHang_ItemsRequested" onclientselectedindexchanged="cmbKhachHangClientSelectedIndexChangedHandler">
</telerik:RadComboBox>
</div>
<telerik:RadGrid ID="RadGridBAOCAOCONGNO" runat="server" Skin="Vista" 
    AllowPaging="False" AllowSorting="True" 
    AllowFilteringByColumn="False" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False" onitemcommand="RadGridBAOCAOCONGNO_ItemCommand" 
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="BAOCAOCONGNODataSource" ShowFooter="True"
    ondatabound="RadGridBAOCAOCONGNO_DataBound" CellSpacing="0" 
    onexcelmlexportrowcreated="RadGridBAOCAOCONGNO_ExcelMLExportRowCreated" 
    onitemdatabound="RadGridBAOCAOCONGNO_ItemDataBound">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
     <GroupingSettings CaseSensitive ="false"  />
    <MasterTableView Name="MasterTableViewBAOCAOCONGNO" CommandItemDisplay="Top" DataSourceID="BAOCAOCONGNODataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                       <b>Báo cáo doanh số theo ngày</b>&nbsp;&nbsp;&nbsp;&nbsp;
                       <asp:LinkButton ID="lbPrint" runat="server"  Visible ="false" CommandName="PrintGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/approval.gif" />In</asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;
                       <asp:LinkButton ID="lblRefesh" runat="server" CommandName="RebindGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Refresh.gif" />Làm mới</asp:LinkButton>
                    </div>
                    <div style="padding: 5px 5px;float:right;width:auto">
                        <asp:LinkButton ID="ExportToPdfButton" runat="server" CommandName="ExportToPdf"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/pdf.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToWordButton" runat="server" CommandName="ExportToWord"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/word.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToExcelButton" runat="server" CommandName="ExportToExcel"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/excel.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToCsvButton" runat="server" CommandName="ExportToCsv"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/csv.gif" /></asp:LinkButton>&nbsp;&nbsp;
                    </div>
        </CommandItemTemplate>
        <GroupByExpressions>
          <telerik:GridGroupByExpression>
            <SelectFields>
              <telerik:GridGroupByField FieldAlias="C_TIENHANG" Aggregate="Sum" FieldName="C_TIENHANG" FormatString=" {0} VNĐ" HeaderText="Tiền hàng" />
              <telerik:GridGroupByField FieldAlias="C_TIENHANGVAT" Aggregate="Sum" FieldName="C_TIENHANGVAT" FormatString=" {0} VNĐ" HeaderText="Tiền hàng (VAT)" />
              <telerik:GridGroupByField FieldAlias="C_DATHU" Aggregate="Sum" FieldName="C_DATHU" FormatString=" {0} VNĐ" HeaderText="Đã thu" />
              <telerik:GridGroupByField FieldAlias="C_CONLAI" Aggregate="Sum" FieldName="C_CONLAI" FormatString=" {0} VNĐ" HeaderText="Còn lại" />
            </SelectFields>
            <GroupByFields>
              <telerik:GridGroupByField FieldAlias="FK_KHACHHANG" FieldName="FK_KHACHHANG" />
            </GroupByFields>
          </telerik:GridGroupByExpression>
        </GroupByExpressions>
        <Columns>
                <telerik:GridBoundColumn UniqueName="C_NGAY" HeaderText="Ngày" DataField="C_NGAY" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy}">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_BILL" HeaderText="Số Bill" DataField="C_BILL" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="FK_KHACHHANG" HeaderText="Mã khách hàng" DataField="FK_KHACHHANG" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_TENKH" HeaderText="Tên khách hàng" DataField="C_TENKH" HeaderStyle-Width="110px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="SANPHAMNAME" HeaderText="Dịch vụ" DataField="SANPHAMNAME" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_TIENHANG" HeaderText="Tiền hàng" DataField="C_TIENHANG" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" Aggregate="Sum" FooterText="Tổng : ">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_VAT" HeaderText="VAT" DataField="C_VAT" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_TIENHANGVAT" HeaderText="Tiền hàng (VAT)" DataField="C_TIENHANGVAT" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" Aggregate="Sum" FooterText="Tổng : ">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_HINHTHUCTT" HeaderText="Hình thức TT" DataField="C_HINHTHUCTT" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn UniqueName="C_DATHU" HeaderText="Đã thu" DataField="C_DATHU" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" Aggregate="Sum" FooterText="Tổng : ">
                </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn UniqueName="C_CONLAI" HeaderText="Còn lại" DataField="C_CONLAI" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" Aggregate="Sum" FooterText="Tổng : ">
                </telerik:GridBoundColumn>               
                <telerik:GridBoundColumn UniqueName="NHANVIENNHANNAME" HeaderText="Nhân viên nhận" DataField="NHANVIENNHANNAME" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="NHANVIENPHATNAME" HeaderText="Nhân viên phát" DataField="NHANVIENPHATNAME" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_NGAYGIOPHAT" HeaderText="Ngày giờ phát" DataField="C_NGAYGIOPHAT" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy hh:mm tt}">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="NHANVIENKHAITHACNAME" HeaderText="Nhân viên khai thác" DataField="NHANVIENKHAITHACNAME" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_NGUOIKYNHAN" HeaderText="Người ký" DataField="C_NGUOIKYNHAN" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_BOPHAN" HeaderText="Bộ phận" DataField="C_BOPHAN" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
        </Columns>
        </MasterTableView>
        <ClientSettings>
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="True" FrozenColumnsCount="0" ScrollHeight="450px" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<asp:SqlDataSource ID="BAOCAOCONGNODataSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>" 
    SelectCommand="SELECT [NHANGUI].[PK_ID], [NHANGUI].[C_NGAY], [NHANGUI].[FK_KHACHHANG], [NHANGUI].[C_BILL], [NHANGUI].[C_TENKH], [NHANGUI].[C_TELGUI], [NHANGUI].[C_NGUOINHAN], [NHANGUI].[C_DIACHINHAN], [NHANGUI].[C_TELNHAN], [NHANGUI].[FK_QUANHUYEN], [NHANGUI].[C_NOIDUNG], [NHANGUI].[FK_MASANPHAM],  [NHANGUI].[C_PPXD], [NHANGUI].[C_KHOILUONG], [NHANGUI].[C_GIACUOC], [NHANGUI].[C_DONGGOI], [NHANGUI].[C_KHAIGIA], [NHANGUI].[C_COD], [NHANGUI].[C_KHAC], [NHANGUI].[C_HINHTHUCTT], [NHANGUI].[C_DATHU], ([NHANGUI].[C_TIENHANGVAT] - [NHANGUI].[C_DATHU]) as [C_CONLAI],([NHANGUI].[C_DONGGOI] + [NHANGUI].[C_KHAIGIA] + [NHANGUI].[C_COD] + [NHANGUI].[C_KHAC]) as [C_PHUTROISUM], [NHANGUI].[C_TIENHANG], [NHANGUI].[C_VAT], [NHANGUI].[C_TIENHANGVAT], [NHANGUI].[FK_NHANVIENNHAN], [NHANGUI].[FK_DOITAC], [NHANGUI].[C_GIADOITAC], [NHANGUI].[FK_NHANVIENPHAT], [NHANGUI].[C_NGAYGIOPHAT], [NHANGUI].[FK_NHANVIENKHAITHAC], [NHANGUI].[C_NGUOIKYNHAN], [NHANGUI].[C_BOPHAN],USERSNHAN.C_NAME as NHANVIENNHANNAME,USERSPHAT.C_NAME as NHANVIENPHATNAME,USERSKHAITHAC.C_NAME as NHANVIENKHAITHACNAME,DMMASANPHAM.C_NAME as SANPHAMNAME,DMQUANHUYEN.C_NAME as QUANHUYENNAME,DMTINHTHANH.C_NAME as TINHTHANHNAME FROM [NHANGUI] LEFT OUTER JOIN USERS as USERSNHAN ON NHANGUI.FK_NHANVIENNHAN = USERSNHAN.PK_ID LEFT OUTER JOIN USERS as USERSPHAT ON NHANGUI.FK_NHANVIENPHAT = USERSPHAT.PK_ID LEFT OUTER JOIN USERS as USERSKHAITHAC ON NHANGUI.FK_NHANVIENKHAITHAC = USERSKHAITHAC.PK_ID LEFT OUTER JOIN DMMASANPHAM ON NHANGUI.FK_MASANPHAM=DMMASANPHAM.PK_ID LEFT OUTER JOIN DMQUANHUYEN ON NHANGUI.FK_QUANHUYEN = DMQUANHUYEN.C_CODE LEFT OUTER JOIN DMTINHTHANH ON DMQUANHUYEN.FK_TINHTHANH = DMTINHTHANH.PK_ID WHERE ([NHANGUI].[FK_KHACHHANG] = @FK_KHACHHANG AND [NHANGUI].[FK_VUNGLAMVIEC] = @FK_VUNGLAMVIEC)">
    <SelectParameters>
         <asp:ControlParameter ControlID="cmbKhachHang" DefaultValue="0" Name="FK_KHACHHANG" PropertyName="SelectedValue" />
         <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
    </SelectParameters>        
</asp:SqlDataSource>
 <asp:SqlDataSource ID="NHOMKHACHHANGDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
 SelectCommand="SELECT DMNHOMKHACHHANG.* FROM DMNHOMKHACHHANG" >
</asp:SqlDataSource>
<asp:SqlDataSource ID="KHACHHANGDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>">
</asp:SqlDataSource>
