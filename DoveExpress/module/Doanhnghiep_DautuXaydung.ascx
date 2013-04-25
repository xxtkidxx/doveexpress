<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Doanhnghiep_DautuXaydung.ascx.cs" Inherits="module_Doanhnghiep_DautuXaydung" %>
<%@ Register TagPrefix="uc1" TagName="ContrinhHT" Src="DN_DTXD_Congtrinhhoanthanh.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Muasam" Src="DN_DTXD_muasamTSCD.ascx" %>

<telerik:RadCodeBlock ID="RadCodeBlockDoanhnghiep_DautuXaydung" runat="server">
<script type="text/javascript">
    function CloseAndRebind(args) {
        GetRadWindow().BrowserWindow.refreshGrid(args);
        GetRadWindow().close();
    }

    function GetRadWindow() {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including clasic dialog
        else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; //IE (and Moz as well)

        return oWindow;
    }

    function CancelEdit() {
        GetRadWindow().close();
    }
</script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelDoanhnghiep_DautuXaydung" runat="server" />

<div style =" width:100%; margin: 10px 10px 10px 10px; ">
Chọn ngày báo cáo:&nbsp; 
<telerik:RadDatePicker ID="radDatareport" Width ="120px" runat="server" 
    AutoPostBack ="true" 
        onselecteddatechanged="radDatareport_SelectedDateChanged"  >
<Calendar ID="Calendar1" runat ="server"  UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>
<DateInput ID="DateInput2" runat ="server" DisplayDateFormat ="dd/MM/yyyy" DateFormat ="dd/MM/yyyy" 
        AutoPostBack="True"></DateInput>
<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
</telerik:RadDatePicker>
</div>
<h2></h2>
<telerik:RadGrid ID="RadGridDoanhnghiep_DautuXaydung" runat="server" Skin="Windows7" 
    AllowPaging="false" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="false" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="Doanhnghiep_DautuXaydungDataSource" ShowFooter="True"
    ondatabound="RadGridDoanhnghiep_DautuXaydung_DataBound"  
    onitemcommand="RadGridDoanhnghiep_DautuXaydung_ItemCommand" CellSpacing="0" 
    onprerender="RadGridDoanhnghiep_DautuXaydung_PreRender" 
    onitemupdated="RadGridDoanhnghiep_DautuXaydung_ItemUpdated" 
    onitemdatabound="RadGridDoanhnghiep_DautuXaydung_ItemDataBound">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML">
<Excel Format="ExcelML"></Excel>
    </ExportSettings>   
       <GroupingSettings CaseSensitive ="false" CollapseTooltip="Đóng nhóm" 
         ExpandTooltip="Mở nhóm" 
         GroupContinuedFormatString="... tiếp các bản ghi của nhóm từ trang trước. " 
         GroupContinuesFormatString=" Các bản ghi được hiển thị tiếp ở trang sau." 
         GroupSplitDisplayFormat=" Hiển thị {0} / {1} bản ghi." 
         UnGroupButtonTooltip="Chick vào đây để hủy nhóm" 
         UnGroupTooltip="Kéo ra ngoài đẻ hủy nhóm"  />
    <MasterTableView Name="MasterTableViewDoanhnghiep_DautuXaydung" CommandItemDisplay="Top" DataSourceID="Doanhnghiep_DautuXaydungDataSource" DataKeyNames="PK_ID" 
    ClientDataKeyNames="PK_ID" EditMode="InPlace" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b><asp:Label ID="Label1" ForeColor ="Red" runat="server" Text="" OnPreRender ="lblCap_PreRender"></asp:Label></b>&nbsp;&nbsp;&nbsp;&nbsp;
                       <br /><br />
                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="InsertChange" Visible='<%# ITCLIB.Security.Security.CanAddModule("DoanhNghieps") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/img_save.jpg" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton6" runat="server" CommandName="CancelChange" Visible='<%# ITCLIB.Security.Security.CanAddModule("DoanhNghieps") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InsertCode" Visible='<%# ITCLIB.Security.Security.CanAddModule("DoanhNghieps") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Tạo bảng báo cáo</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:return confirm('Bạn có muốn xóa dữ liệu thống kê đang theo dõi?')" runat="server" CommandName="DeleteSelected" Visible='<%# ITCLIB.Security.Security.CanDeleteModule("DoanhNghieps") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Delete.gif" />Xóa</asp:LinkButton>&nbsp;&nbsp;
                       <asp:LinkButton ID="LinkButton4" runat="server" CommandName="RebindGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Refresh.gif" />Làm mới</asp:LinkButton>&nbsp;&nbsp;
                       <asp:LinkButton ID="LinkButton5" runat="server" OnClientClick="javascript:return CancelEdit()"><img style="border:0px;vertical-align:middle;" alt="" src="Images/img_close.jpg" />Đóng</asp:LinkButton>
                    </div>
                    <div style="padding: 5px 5px;float:right;width:auto; display:none;">
                        <asp:LinkButton ID="ExportToPdfButton" runat="server" CommandName="ExportToPdf"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/pdf.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToWordButton" runat="server" CommandName="ExportToWord"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/word.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToExcelButton" runat="server" CommandName="ExportToExcel"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/excel.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToCsvButton" runat="server" CommandName="ExportToCsv"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/csv.gif" /></asp:LinkButton>&nbsp;&nbsp;
                    </div>
        </CommandItemTemplate>
<CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
<RowIndicatorColumn FilterControlAltText="Filter RowIndicator column"></RowIndicatorColumn>
<ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column"></ExpandCollapseColumn>
<ColumnGroups>
</ColumnGroups>
        <Columns>
         <telerik:GridBoundColumn DataField="PK_ID" Visible ="false" UniqueName="PK_ID" DataType="System.Int64"></telerik:GridBoundColumn>
         <telerik:GridBoundColumn DataField="FK_DOANHNGHIEP" Visible ="false" UniqueName="FK_DOANHNGHIEP" DataType="System.Int32"></telerik:GridBoundColumn>
         <telerik:GridBoundColumn DataField="FK_TIEUCHI" DataType="System.Int32"  Visible ="false"  UniqueName="FK_TIEUCHI"></telerik:GridBoundColumn>
     <telerik:GridTemplateColumn DataField="C_NAME"  ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter C_NAME column" HeaderText=""   SortExpression="C_NAME" UniqueName="C_NAME" >   
     <ItemTemplate>
            <%#getName(Eval("C_NAME"),Eval("C_LEVEL").ToString(),Eval("C_HEADER"))%>
<table class ="tableInGrid" style =" border:1px solid blue !important; padding: 0 0 0 0 !important;">
<asp:Panel runat ="server" ID = "paneltable">
        <tr>
        <td rowspan ="2" style ="font-weight:bold; width:100px;"></td>
        <td rowspan ="2" style ="font-weight:bold; width:250px;">Tên công trình, tên tài sản cố định</td>
         <td rowspan ="2" style ="font-weight:bold; width:50px;" class="tddece2">MÃ</td>
          <td rowspan ="2" style ="font-weight:bold; width:250px;" class="tddece2">Địa điểm xây dựng</td>
            <td class="tddece" style ="font-weight:bold;">
            Thời gian
            </td>
             <td class="tddece" colspan ="3" style ="font-weight:bold;">
            Khả năng thiết kế
            </td>
            <td rowspan ="2" style ="font-weight:bold; width:70px;" class="tddece2">Tổng số vốn đầu tư (triệu đồng)</td>
         <td rowspan ="2" style ="font-weight:bold; width:70px;" class="tddecelast">Giá trị TSCĐ mới tăng (triệu đồng)</td>
        </tr>
        <tr>       
            <td style =" width:70px; font-weight:bold;" class="tddece2" >
            Khởi công
            </td>
            <td style =" width:70px; font-weight:bold;" class="tddece2">
           Hoàn thành
            </td>
            <td style =" width:70px; font-weight:bold;" class="tddece2">
            ĐƠn vị
            </td>
            <td style =" width:70px; font-weight:bold;" class="tddece2">
            Số lượng
            </td>
        </tr>
</asp:Panel>
       <tr>
       <td colspan ="11">
           <uc1:Muasam ID ="ucmuasam" runat ="server" />
            <uc1:ContrinhHT ID ="uccongtrinh" runat ="server" />
            </td>
       </tr>  
</table>          
      </ItemTemplate>
    </telerik:GridTemplateColumn>         
        </Columns>
        </MasterTableView>
        <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G1"/>
        <ClientSettings>
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
            <ClientEvents OnPopUpShowing="PopUpShowing" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />

<FilterMenu EnableImageSprites="False"></FilterMenu>

<HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Vista"></HeaderContextMenu>
</telerik:RadGrid>
<asp:SqlDataSource ID="Doanhnghiep_DautuXaydungDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
        SelectCommand="SELECT DOANHNGHIEP.MADOANHNGHIEP, DOANHNGHIEP.TENDOANHNGHIEP, DOANHNGHIEP_VALUE.PK_ID, DOANHNGHIEP_VALUE.FK_DOANHNGHIEP, DOANHNGHIEP_VALUE.FK_TIEUCHI, DOANHNGHIEP_VALUE.C_DATE, DOANHNGHIEP_VALUE.C_DATE_EDIT, DOANHNGHIEP_VALUE.VALUE1, DOANHNGHIEP_VALUE.VALUE2, DOANHNGHIEP_VALUE.VALUE3, DOANHNGHIEP_VALUE.VALUE4, DOANHNGHIEP_VALUE.VALUE5, DOANHNGHIEP_VALUE.VALUE6, DOANHNGHIEP_VALUE.VALUE7, DOANHNGHIEP_VALUE.VALUE8, DOANHNGHIEP_VALUE.VALUE9, DOANHNGHIEP_VALUE.VALUE10, DOANHNGHIEP_VALUE.VALUE11, CONVERT (DATETIME, FLOOR(CONVERT (FLOAT, DOANHNGHIEP_VALUE.C_DATE))) AS DATEONLY, DOANHNGHIEP_TIEUCHI.C_CODE, DOANHNGHIEP_TIEUCHI.C_NAME, DOANHNGHIEP_TIEUCHI.C_HEADER, DOANHNGHIEP_TIEUCHI.C_LEVEL FROM DOANHNGHIEP_VALUE INNER JOIN DOANHNGHIEP ON DOANHNGHIEP_VALUE.FK_DOANHNGHIEP = DOANHNGHIEP.PK_ID INNER JOIN DOANHNGHIEP_TIEUCHI ON DOANHNGHIEP_VALUE.FK_TIEUCHI = DOANHNGHIEP_TIEUCHI.PK_ID WHERE (DOANHNGHIEP_VALUE.VALUE9 IS NULL) AND (DOANHNGHIEP.PK_ID = @PK_ID) AND (DOANHNGHIEP_TIEUCHI.C_TYPE = 'DAUTUXAYDUNG') AND ((CONVERT(NVARCHAR(8), DOANHNGHIEP_VALUE.C_DATE, 112) =  @C_DATE) or (CONVERT (DATETIME, FLOOR(CONVERT (FLOAT, DOANHNGHIEP_VALUE.C_DATE)))  =  CONVERT (DATETIME, FLOOR(CONVERT (FLOAT, GETDATE()))) and (@C_DATE =0))) ORDER BY DATEONLY DESC, DOANHNGHIEP_TIEUCHI.C_ORDER"  > 
    <SelectParameters>
        <asp:QueryStringParameter DefaultValue="0" Name="PK_ID" 
            QueryStringField="IDDN" />
       <asp:QueryStringParameter DefaultValue="0" Name="C_DATE" 
            QueryStringField="dateselect" />
    </SelectParameters>
</asp:SqlDataSource>

