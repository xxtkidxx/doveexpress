<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Doanhnghiep_Laodongthunhap.ascx.cs" Inherits="module_Doanhnghiep_Laodongthunhap" %>



<telerik:RadCodeBlock ID="RadCodeBlockDoanhnghiepThunhap" runat="server">
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

    var RadNumericTextBox01, RadNumericTextBox02, RadNumericTextBox03, RadNumericTextBox04, RadNumericTextBox05;
    function OnClientLoadRadNumericTextBox01(sender) {
        RadNumericTextBox01 = sender;
    }
    function OnClientLoadRadNumericTextBox02(sender) {
        RadNumericTextBox02 = sender;
    }
    function OnClientLoadRadNumericTextBox03(sender) {
        RadNumericTextBox03 = sender;
    }
    function OnClientLoadRadNumericTextBox04(sender) {
        RadNumericTextBox04 = sender;
    }
    function OnClientLoadRadNumericTextBox05(sender) {
        RadNumericTextBox05 = sender;
    }
    function OnValueChangedRadNumericTextBox01(sender, args) {

    }
    function OnValueChangedRadNumericTextBox02(sender, args) {
        RadNumericTextBox01.set_value(RadNumericTextBox02.get_value() + RadNumericTextBox03.get_value() + RadNumericTextBox04.get_value());
    }
    function OnValueChangedRadNumericTextBox03(sender, args) {
        RadNumericTextBox01.set_value(RadNumericTextBox02.get_value() + RadNumericTextBox03.get_value() + RadNumericTextBox04.get_value());
    }
    function OnValueChangedRadNumericTextBox04(sender, args) {
        RadNumericTextBox01.set_value(RadNumericTextBox02.get_value() + RadNumericTextBox03.get_value() + RadNumericTextBox04.get_value());
    }
    function OnValueChangedRadNumericTextBox05(sender, args) {
    }
</script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelDoanhnghiepThunhap" runat="server" />

<div style =" width:100%; margin: 10px 10px 10px 10px; ">
Chọn ngày báo cáo:&nbsp; 
<telerik:RadDatePicker ID="radDatareport" Width ="120px" runat="server" 
    AutoPostBack ="true"  >
<Calendar ID="Calendar1" runat ="server"  UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>
<DateInput ID="DateInput2" runat ="server" DisplayDateFormat ="dd/MM/yyyy" DateFormat ="dd/MM/yyyy" 
        AutoPostBack="True"></DateInput>
<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
</telerik:RadDatePicker>
</div>

<telerik:RadGrid ID="RadGridDoanhnghiepThunhap" runat="server" Skin="Windows7" 
    AllowPaging="false" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="false" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="DoanhnghiepThunhapDataSource" ShowFooter="True"
    ondatabound="RadGridDoanhnghiepThunhap_DataBound"  
    onitemcommand="RadGridDoanhnghiepThunhap_ItemCommand" CellSpacing="0" 
    onprerender="RadGridDoanhnghiepThunhap_PreRender" 
    onitemupdated="RadGridDoanhnghiepThunhap_ItemUpdated" 
    onitemdatabound="RadGridDoanhnghiepThunhap_ItemDataBound">
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
    <MasterTableView Name="MasterTableViewDoanhnghiepThunhap" CommandItemDisplay="Top" DataSourceID="DoanhnghiepThunhapDataSource" DataKeyNames="PK_ID,C_CODE" 
    ClientDataKeyNames="PK_ID,C_CODE" EditMode="InPlace" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b><asp:Label ID="Label1" ForeColor ="Red" runat="server" Text="" OnPreRender ="lblCap_PreRender"></asp:Label></b>&nbsp;&nbsp;&nbsp;&nbsp;
                       <br /><br /><asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridDoanhnghiepThunhap.EditIndexes.Count == 0 && ITCLIB.Security.Security.CanEditModule("DoanhNghieps") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridDoanhnghiepThunhap.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/img_save.jpg" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridDoanhnghiepThunhap.EditIndexes.Count > 0 || RadGridDoanhnghiepThunhap.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InsertCode" Visible='<%# !RadGridDoanhnghiepThunhap.MasterTableView.IsItemInserted && ITCLIB.Security.Security.CanAddModule("DoanhNghieps") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Tạo bảng báo cáo</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:return confirm('Bạn có muốn xóa dữ liệu thống kê đang theo dõi?')" runat="server" CommandName="DeleteSelected" Visible='<%# ITCLIB.Security.Security.CanDeleteModule("DoanhNghieps") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Delete.gif" />Xóa</asp:LinkButton>&nbsp;&nbsp;
                       <asp:LinkButton ID="LinkButton4" runat="server" CommandName="RebindGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Refresh.gif" />Làm mới</asp:LinkButton>&nbsp;&nbsp;
                       <asp:LinkButton ID="LinkButton5" runat="server" OnClientClick="javascript:return CancelEdit()"><img style="border:0px;vertical-align:middle;" alt="" src="Images/img_close.jpg" />Đóng</asp:LinkButton>
                    </div>
                    <div style="padding: 5px 5px;float:right;width:auto">
                        <asp:LinkButton ID="ExportToPdfButton" runat="server" CommandName="ExportToPdf"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/pdf.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToWordButton" runat="server" CommandName="ExportToWord"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/word.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToExcelButton" runat="server" CommandName="ExportToExcel"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/excel.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToCsvButton" runat="server" CommandName="ExportToCsv"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/csv.gif" /></asp:LinkButton>&nbsp;&nbsp;
                    </div>
        </CommandItemTemplate>
<CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
<RowIndicatorColumn FilterControlAltText="Filter RowIndicator column"></RowIndicatorColumn>
<ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column"></ExpandCollapseColumn>
        <Columns>
         <telerik:GridBoundColumn UniqueName="MADOANHNGHIEP" HeaderText="Mã doanh nghiệp"  Visible ="false"
                      DataField="MADOANHNGHIEP" FilterControlAltText="Filter MADOANHNGHIEP column"  ReadOnly ="true" 
                      SortExpression="MADOANHNGHIEP">
                </telerik:GridBoundColumn>
         <telerik:GridBoundColumn UniqueName="TENDOANHNGHIEP" HeaderText="Tên doanh nghiệp"  AllowFiltering ="true"  Visible ="false"
                    DataField="TENDOANHNGHIEP" SortExpression="TENDOANHNGHIEP" ReadOnly ="true" 
                      FilterControlAltText="Filter TENDOANHNGHIEP column">
                </telerik:GridBoundColumn>
         <telerik:GridBoundColumn DataField="PK_ID" Visible ="false" UniqueName="PK_ID" DataType="System.Int64"></telerik:GridBoundColumn>
         <telerik:GridBoundColumn DataField="FK_DOANHNGHIEP" Visible ="false" UniqueName="FK_DOANHNGHIEP" DataType="System.Int32"></telerik:GridBoundColumn>
         <telerik:GridBoundColumn DataField="FK_TIEUCHI" DataType="System.Int32"  Visible ="false"  UniqueName="FK_TIEUCHI"></telerik:GridBoundColumn>
     <telerik:GridTemplateColumn DataField="C_NAME"  ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter C_NAME column" HeaderText=""   HeaderStyle-Width ="420px" 
        SortExpression="C_NAME" UniqueName="C_NAME">   
     <ItemTemplate>
            <%#getName(Eval("C_NAME"),Eval("C_LEVEL").ToString(),Eval("C_HEADER"))%>
      </ItemTemplate>
      <EditItemTemplate>
           <%#getName(Eval("C_NAME"),Eval("C_LEVEL").ToString(),Eval("C_HEADER"))%>
      </EditItemTemplate>
    </telerik:GridTemplateColumn>
     <telerik:GridTemplateColumn DataField="C_CODE"  ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter C_CODE column" HeaderText="Mã"  HeaderStyle-Width ="30px" 
        SortExpression="C_CODE" UniqueName="C_CODE">   
     <ItemTemplate>
            <%#Eval("C_CODE")%>
      </ItemTemplate>
      <EditItemTemplate>           
          <asp:Label ID="lblCode" runat="server" Text='<%#Eval("C_CODE")%>'></asp:Label>
      </EditItemTemplate>
    </telerik:GridTemplateColumn>
    <telerik:GridBoundColumn DataField="C_DATE" DataType="System.DateTime"  Visible ="false"  ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter C_DATE column" HeaderText="Ngày thống kê" ReadOnly ="true" HeaderStyle-Width ="8%" 
        SortExpression="C_DATE" UniqueName="C_DATE" DataFormatString="{0: dd/MM/yyyy}">
    </telerik:GridBoundColumn>
     <telerik:GridTemplateColumn DataField="VALUE1"  ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter VALUE1 column" HeaderText="Phát sinh trong năm (Triệu đồng)"  ItemStyle-Width ="120px" HeaderStyle-Width ="120px" 
        SortExpression="VALUE1" UniqueName="VALUE1">   
     <ItemTemplate>
            <%#Eval("VALUE1")%>
      </ItemTemplate>
      <EditItemTemplate>
            <telerik:RadNumericTextBox  ID="txtVALUE1" Runat="server" Text ='<%#Bind("VALUE1")%>'
             IncrementSettings-InterceptMouseWheel="true" Width="120px"  CssClass ="csstextNum" MaxValue="500000" MinValue="0" IncrementSettings-InterceptArrowKeys="true" >
             <NumberFormat  DecimalDigits ="0"/>
             </telerik:RadNumericTextBox>
      </EditItemTemplate>
     <HeaderStyle HorizontalAlign ="Center" />
    </telerik:GridTemplateColumn>   
     <telerik:GridTemplateColumn> </telerik:GridTemplateColumn>          
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
<asp:SqlDataSource ID="DoanhnghiepThunhapDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
        DeleteCommand="DELETE FROM DOANHNGHIEP_VALUE WHERE (PK_ID = @PK_ID)" 
        InsertCommand="INSERT INTO DOANHNGHIEP_VALUE(FK_DOANHNGHIEP, FK_TIEUCHI, C_DATE, VALUE1, VALUE2) VALUES (@FK_DOANHNGHIEP, @FK_TIEUCHI, @C_DATE, @VALUE1, @VALUE2)"
        SelectCommand="SELECT DOANHNGHIEP.MADOANHNGHIEP, DOANHNGHIEP.TENDOANHNGHIEP, DOANHNGHIEP_VALUE.PK_ID, DOANHNGHIEP_VALUE.FK_DOANHNGHIEP, DOANHNGHIEP_VALUE.FK_TIEUCHI, DOANHNGHIEP_VALUE.C_DATE, DOANHNGHIEP_VALUE.C_DATE_EDIT, DOANHNGHIEP_VALUE.VALUE1, DOANHNGHIEP_VALUE.VALUE2, CONVERT (DATETIME, FLOOR(CONVERT (FLOAT, DOANHNGHIEP_VALUE.C_DATE))) AS DATEONLY, DOANHNGHIEP_TIEUCHI.C_CODE, DOANHNGHIEP_TIEUCHI.C_NAME, DOANHNGHIEP_TIEUCHI.C_HEADER, DOANHNGHIEP_TIEUCHI.C_LEVEL, DOANHNGHIEP_TIEUCHI.C_ISTYPE FROM DOANHNGHIEP_VALUE INNER JOIN DOANHNGHIEP ON DOANHNGHIEP_VALUE.FK_DOANHNGHIEP = DOANHNGHIEP.PK_ID INNER JOIN DOANHNGHIEP_TIEUCHI ON DOANHNGHIEP_VALUE.FK_TIEUCHI = DOANHNGHIEP_TIEUCHI.PK_ID WHERE (DOANHNGHIEP.PK_ID = @PK_ID) AND (DOANHNGHIEP_TIEUCHI.C_TYPE = 'THUNHAP') AND (CONVERT(NVARCHAR(8), DOANHNGHIEP_VALUE.C_DATE, 112) = CONVERT(NVARCHAR(8), @C_DATE, 112)) ORDER BY DATEONLY DESC, DOANHNGHIEP_TIEUCHI.C_ORDER"      
        UpdateCommand="UPDATE DOANHNGHIEP_VALUE SET C_DATE_EDIT = GETDATE(), VALUE1 = @VALUE1, VALUE2 = @VALUE2 WHERE (PK_ID = @PK_ID)" >
    <DeleteParameters>
        <asp:Parameter Name="PK_ID" />
    </DeleteParameters>
    <InsertParameters>
        <asp:QueryStringParameter DefaultValue="0" Name="FK_DOANHNGHIEP" 
            QueryStringField="IDDN" />
        <asp:Parameter Name="FK_TIEUCHI" />
        <asp:Parameter Name="C_DATE" />
        <asp:Parameter Name="VALUE1" />
        <asp:Parameter Name="VALUE2" />
    </InsertParameters>
    <SelectParameters>
        <asp:QueryStringParameter DefaultValue="0" Name="PK_ID" 
            QueryStringField="IDDN" />
        <asp:ControlParameter ControlID="radDatareport" DefaultValue="01/01/2000" 
            Name="C_DATE" PropertyName="SelectedDate" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="VALUE1" />
        <asp:Parameter Name="VALUE2" />
        <asp:Parameter Name="PK_ID" />
    </UpdateParameters>
</asp:SqlDataSource>