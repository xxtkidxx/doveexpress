<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Doanhnghiep_Dichvu.ascx.cs" Inherits="module_Doanhnghiep_Dichvu" %>


<telerik:RadCodeBlock ID="RadCodeBlockDoanhnghiepDichVu" runat="server">
<script type="text/javascript">
        function RowDblClickUser(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("DoanhNghieps") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewDoanhnghiepDichVu") && (CanEdit == "True")) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
        }
</script>
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
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelDoanhnghiepDichVu" runat="server" />

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

<telerik:RadGrid ID="RadGridDoanhnghiepDichVu" runat="server" Skin="Windows7" 
    AllowPaging="false" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="false" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="DoanhnghiepDichVuDataSource" ShowFooter="True"
    ondatabound="RadGridDoanhnghiepDichVu_DataBound"  
    onitemcommand="RadGridDoanhnghiepDichVu_ItemCommand" CellSpacing="0" 
    onprerender="RadGridDoanhnghiepDichVu_PreRender" 
    onitemupdated="RadGridDoanhnghiepDichVu_ItemUpdated">
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
    <MasterTableView Name="MasterTableViewDoanhnghiepDichVu" CommandItemDisplay="Top" DataSourceID="DoanhnghiepDichVuDataSource" DataKeyNames="PK_ID,C_CODE" 
    ClientDataKeyNames="PK_ID,C_CODE" EditMode="InPlace" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b><asp:Label ID="Label1" ForeColor ="Red" runat="server" Text="" OnPreRender ="lblCap_PreRender"></asp:Label></b>&nbsp;&nbsp;&nbsp;&nbsp;
                       <br /><br /><asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridDoanhnghiepDichVu.EditIndexes.Count == 0 && ITCLIB.Security.Security.CanEditModule("DoanhNghieps") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridDoanhnghiepDichVu.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/img_save.jpg" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridDoanhnghiepDichVu.EditIndexes.Count > 0 || RadGridDoanhnghiepDichVu.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InsertCode" Visible='<%# !RadGridDoanhnghiepDichVu.MasterTableView.IsItemInserted && ITCLIB.Security.Security.CanAddModule("DoanhNghieps") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Tạo bảng báo cáo</asp:LinkButton>&nbsp;&nbsp;
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
        FilterControlAltText="Filter C_NAME column" HeaderText=""  HeaderStyle-Width ="300px" 
        SortExpression="C_NAME" UniqueName="C_NAME">   
     <ItemTemplate>
            <%#getName(Eval("C_NAME"),Eval("C_LEVEL").ToString(),Eval("C_HEADER"))%>
      </ItemTemplate>
      <EditItemTemplate>
           <%#getName(Eval("C_NAME"),Eval("C_LEVEL").ToString(),Eval("C_HEADER"))%>
      </EditItemTemplate>
       <HeaderStyle HorizontalAlign ="Center"  />
    </telerik:GridTemplateColumn>
     <telerik:GridTemplateColumn DataField="C_CODE"  ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter C_CODE column" HeaderText="Mã"  HeaderStyle-Width ="30px" 
        SortExpression="C_CODE" UniqueName="C_CODE">   
     <ItemTemplate>
            <%#Eval("C_CODE")%>
      </ItemTemplate>
      <EditItemTemplate>
            <%#Eval("C_CODE")%>
      </EditItemTemplate>
       <HeaderStyle HorizontalAlign ="Center"  />
    </telerik:GridTemplateColumn>
    <telerik:GridBoundColumn DataField="C_DATE" DataType="System.DateTime"  Visible ="false"  ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter C_DATE column" HeaderText="Ngày thống kê" ReadOnly ="true" HeaderStyle-Width ="8%" 
        SortExpression="C_DATE" UniqueName="C_DATE" DataFormatString="{0: dd/MM/yyyy}">
    </telerik:GridBoundColumn>
     <telerik:GridTemplateColumn DataField="VALUE1"  ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter VALUE1 column" HeaderText="Số cơ sở có đến cuối năm"  ItemStyle-Width ="70px" HeaderStyle-Width ="70px" 
        SortExpression="VALUE1" UniqueName="VALUE1">   
     <ItemTemplate>
            <%#Eval("VALUE1")%>
      </ItemTemplate>
      <EditItemTemplate>
            <telerik:RadNumericTextBox  ID="txtVALUE1" Runat="server" Enabled ='<%#(bool)Eval("C_ISTYPE") %>' Text ='<%#Bind("VALUE1")%>'
             IncrementSettings-InterceptMouseWheel="true" Width="70px" CssClass ="csstextNum" MaxValue="500000" MinValue="0" IncrementSettings-InterceptArrowKeys="true" >
             <NumberFormat  DecimalDigits ="0"/>
             </telerik:RadNumericTextBox>
      </EditItemTemplate>
       <HeaderStyle HorizontalAlign ="Center"  />
    </telerik:GridTemplateColumn>
     <telerik:GridTemplateColumn DataField="VALUE2"  ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter VALUE2 column" HeaderText="Diện tích kinh doanh có đến cuối năm (m2)"  ItemStyle-Width ="70px" HeaderStyle-Width ="70px" 
        SortExpression="VALUE2" UniqueName="VALUE2">   
     <ItemTemplate>
            <%#Eval("VALUE2")%>
      </ItemTemplate>
      <EditItemTemplate>
            <telerik:RadNumericTextBox  ID="txtVALUE2" Runat="server" Text ='<%#Bind("VALUE2")%>'  Enabled ='<%#(bool)Eval("C_ISTYPE") %>' 
             IncrementSettings-InterceptMouseWheel="true" Width="70px" CssClass ="csstextNum" MaxValue="500000" MinValue="0" IncrementSettings-InterceptArrowKeys="true" >
             <NumberFormat  DecimalDigits ="0"/>
             </telerik:RadNumericTextBox>
      </EditItemTemplate>
       <HeaderStyle HorizontalAlign ="Center"  />
    </telerik:GridTemplateColumn>
     <telerik:GridTemplateColumn DataField="VALUE3"  ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter VALUE3 column" HeaderText="Doanh thu thuần (triệu đồng)"  ItemStyle-Width ="70px" HeaderStyle-Width ="70px" 
        SortExpression="VALUE3" UniqueName="VALUE3">   
     <ItemTemplate>
            <%#Eval("VALUE3")%>
      </ItemTemplate>
      <EditItemTemplate>
            <telerik:RadNumericTextBox  ID="txtVALUE3" Runat="server" Text ='<%#Bind("VALUE3")%>'  Enabled ='<%#(bool)Eval("C_ISTYPE") %>' 
             IncrementSettings-InterceptMouseWheel="true" Width="70px" CssClass ="csstextNum" MaxValue="500000" MinValue="0" IncrementSettings-InterceptArrowKeys="true" >
             <NumberFormat  DecimalDigits ="0"/>
             </telerik:RadNumericTextBox>
      </EditItemTemplate>
       <HeaderStyle HorizontalAlign ="Center"  />
    </telerik:GridTemplateColumn>
     <telerik:GridTemplateColumn DataField="VALUE4"  ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter VALUE4 column" HeaderText="Thuế GTGT, thuế xuất khẩu phát sinh phải nộp (triệu đồng)"  ItemStyle-Width ="100px" HeaderStyle-Width ="100px" 
        SortExpression="VALUE4" UniqueName="VALUE4">   
     <ItemTemplate>
            <%#Eval("VALUE4")%>
      </ItemTemplate>
      <EditItemTemplate>
            <telerik:RadNumericTextBox  ID="txtVALUE4" Runat="server" Text ='<%#Bind("VALUE4")%>'  Enabled ='<%#(bool)Eval("C_ISTYPE") %>' 
             IncrementSettings-InterceptMouseWheel="true" Width="70px" CssClass ="csstextNum" MaxValue="500000" MinValue="0" IncrementSettings-InterceptArrowKeys="true" >
             <NumberFormat  DecimalDigits ="0"/>
             </telerik:RadNumericTextBox>
      </EditItemTemplate>
      <HeaderStyle HorizontalAlign ="Center"  />
    </telerik:GridTemplateColumn>
    <telerik:GridTemplateColumn> </telerik:GridTemplateColumn>   
        </Columns>
        </MasterTableView>
        <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G1"/>
        <ClientSettings>
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
            <ClientEvents OnPopUpShowing="PopUpShowing" />
            <ClientEvents OnRowDblClick="RowDblClick" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />

<FilterMenu EnableImageSprites="False"></FilterMenu>

<HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Vista"></HeaderContextMenu>
</telerik:RadGrid>
<asp:SqlDataSource ID="DoanhnghiepDichVuDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
        DeleteCommand="DELETE FROM DOANHNGHIEP_VALUE WHERE (PK_ID = @PK_ID)" 
        InsertCommand="INSERT INTO DOANHNGHIEP_VALUE(FK_DOANHNGHIEP, FK_TIEUCHI, C_DATE, VALUE1, VALUE2, VALUE3, VALUE4) VALUES (@FK_DOANHNGHIEP, @FK_TIEUCHI, @C_DATE, @VALUE1, @VALUE2, @VALUE3, @VALUE4)"
        SelectCommand="SELECT DOANHNGHIEP.MADOANHNGHIEP, DOANHNGHIEP.TENDOANHNGHIEP, DOANHNGHIEP_VALUE.PK_ID, DOANHNGHIEP_VALUE.FK_DOANHNGHIEP, DOANHNGHIEP_VALUE.FK_TIEUCHI, DOANHNGHIEP_VALUE.C_DATE, DOANHNGHIEP_VALUE.C_DATE_EDIT, DOANHNGHIEP_VALUE.VALUE1, DOANHNGHIEP_VALUE.VALUE2, DOANHNGHIEP_VALUE.VALUE3, DOANHNGHIEP_VALUE.VALUE4, CONVERT (DATETIME, FLOOR(CONVERT (FLOAT, DOANHNGHIEP_VALUE.C_DATE))) AS DATEONLY, DOANHNGHIEP_TIEUCHI.C_CODE, DOANHNGHIEP_TIEUCHI.C_NAME, DOANHNGHIEP_TIEUCHI.C_HEADER, DOANHNGHIEP_TIEUCHI.C_LEVEL, DOANHNGHIEP_TIEUCHI.C_ISTYPE FROM DOANHNGHIEP_VALUE INNER JOIN DOANHNGHIEP ON DOANHNGHIEP_VALUE.FK_DOANHNGHIEP = DOANHNGHIEP.PK_ID INNER JOIN DOANHNGHIEP_TIEUCHI ON DOANHNGHIEP_VALUE.FK_TIEUCHI = DOANHNGHIEP_TIEUCHI.PK_ID WHERE (DOANHNGHIEP.PK_ID = @PK_ID) AND (DOANHNGHIEP_TIEUCHI.C_TYPE = 'DICHVU') AND (CONVERT(NVARCHAR(8), DOANHNGHIEP_VALUE.C_DATE, 112) = CONVERT(NVARCHAR(8), @C_DATE, 112)) ORDER BY DATEONLY DESC, DOANHNGHIEP_TIEUCHI.C_ORDER"      
        UpdateCommand="UPDATE DOANHNGHIEP_VALUE SET C_DATE_EDIT = GETDATE(), VALUE1 = @VALUE1, VALUE2 = @VALUE2, VALUE3 = @VALUE3, VALUE4 = @VALUE4 WHERE (PK_ID = @PK_ID)" >
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
        <asp:Parameter Name="VALUE3" />
        <asp:Parameter Name="VALUE4" />
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
        <asp:Parameter Name="VALUE3" />
        <asp:Parameter Name="VALUE4" />
        <asp:Parameter Name="PK_ID" />
    </UpdateParameters>
</asp:SqlDataSource>
