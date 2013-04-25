<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Doanhnghiep_Daotao.ascx.cs" Inherits="module_Doanhnghiep_Daotao" %>

<telerik:RadCodeBlock ID="RadCodeBlockDoanhnghiepDaotao" runat="server">
<script type="text/javascript">
        function RowDblClickUser(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("DoanhNghieps") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewDoanhnghiepDaotao") && (CanEdit == "True")) {
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
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelDoanhnghiepDaotao" runat="server" />

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
<div style =" width:100%; margin: 10px 10px 10px 10px; ">
Năm thực hiện kế hoạch đào tạo:&nbsp; 
    <telerik:RadComboBox ID="radNamthuchien" runat="server" Width ="70px" AppendDataBoundItems="true" AutoPostBack ="true">
        <Items>
            <telerik:RadComboBoxItem Text ="2000" Value ="2000" />
            <telerik:RadComboBoxItem Text ="2001" Value ="2001" />
            <telerik:RadComboBoxItem Text ="2002" Value ="2002" />
            <telerik:RadComboBoxItem Text ="2003" Value ="2003" />
            <telerik:RadComboBoxItem Text ="2004" Value ="2004" />
            <telerik:RadComboBoxItem Text ="2005" Value ="2005" />
            <telerik:RadComboBoxItem Text ="2006" Value ="2006" />
            <telerik:RadComboBoxItem Text ="2007" Value ="2007" />
            <telerik:RadComboBoxItem Text ="2008" Value ="2008" />
            <telerik:RadComboBoxItem Text ="2009" Value ="2009" />
            <telerik:RadComboBoxItem Text ="2010" Value ="2010" />
            <telerik:RadComboBoxItem Text ="2011" Value ="2011" />
            <telerik:RadComboBoxItem Text ="2012" Value ="2012" />
            <telerik:RadComboBoxItem Text ="2013" Value ="2013" />
            <telerik:RadComboBoxItem Text ="2014" Value ="2014" />
            <telerik:RadComboBoxItem Text ="2015" Value ="2015" />
            <telerik:RadComboBoxItem Text ="2016" Value ="2016" />
            <telerik:RadComboBoxItem Text ="2017" Value ="2017" />
            <telerik:RadComboBoxItem Text ="2018" Value ="2018" />
            <telerik:RadComboBoxItem Text ="2019" Value ="2019" />
            <telerik:RadComboBoxItem Text ="2020" Value ="2020" />
            <telerik:RadComboBoxItem Text ="2012" Value ="2021" />
        </Items>
    </telerik:RadComboBox>
</div>

<telerik:RadGrid ID="RadGridDoanhnghiepDaotao" runat="server" Skin="Windows7" 
    AllowPaging="false" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="false" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="DoanhnghiepDaotaoDataSource" ShowFooter="True"
    ondatabound="RadGridDoanhnghiepDaotao_DataBound"  
    onitemcommand="RadGridDoanhnghiepDaotao_ItemCommand" CellSpacing="0" 
    onprerender="RadGridDoanhnghiepDaotao_PreRender" 
    onitemupdated="RadGridDoanhnghiepDaotao_ItemUpdated">
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
    <MasterTableView Name="MasterTableViewDoanhnghiepDaotao" CommandItemDisplay="Top" DataSourceID="DoanhnghiepDaotaoDataSource" DataKeyNames="PK_ID" 
    ClientDataKeyNames="PK_ID" EditMode="InPlace" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b><asp:Label ID="Label1" ForeColor ="Red" runat="server" Text="" OnPreRender ="lblCap_PreRender"></asp:Label></b>&nbsp;&nbsp;&nbsp;&nbsp;
                       <br /><br /><asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridDoanhnghiepDaotao.EditIndexes.Count == 0 && ITCLIB.Security.Security.CanEditModule("DoanhNghieps") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridDoanhnghiepDaotao.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/img_save.jpg" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridDoanhnghiepDaotao.EditIndexes.Count > 0 || RadGridDoanhnghiepDaotao.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InsertCode" Visible='<%# !RadGridDoanhnghiepDaotao.MasterTableView.IsItemInserted && ITCLIB.Security.Security.CanAddModule("DoanhNghieps") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Tạo bảng báo cáo</asp:LinkButton>&nbsp;&nbsp;
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
<ColumnGroups>
<telerik:GridColumnGroup HeaderText ="Thực hiện trong năm" Name = "thuchien" HeaderStyle-Font-Bold ="true" HeaderStyle-HorizontalAlign ="Center"></telerik:GridColumnGroup>
</ColumnGroups>
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
        FilterControlAltText="Filter C_NAME column" HeaderText="" HeaderStyle-Width ="350px" 
        SortExpression="C_NAME" UniqueName="C_NAME">   
     <ItemTemplate>
            <%#getName(Eval("C_NAME"),Eval("C_LEVEL").ToString(),Eval("C_HEADER"))%>
      </ItemTemplate>
      <EditItemTemplate>
           <%#getName(Eval("C_NAME"),Eval("C_LEVEL").ToString(),Eval("C_HEADER"))%>
      </EditItemTemplate>
    </telerik:GridTemplateColumn>
     <telerik:GridTemplateColumn DataField="C_CODE"  ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter C_CODE column" HeaderText="Mã"  HeaderStyle-Width ="50px" 
        SortExpression="C_CODE" UniqueName="C_CODE">   
     <ItemTemplate>
            <%#Eval("C_CODE")%>
      </ItemTemplate>
      <EditItemTemplate>
            <%#Eval("C_CODE")%>
      </EditItemTemplate>
    </telerik:GridTemplateColumn>
    <telerik:GridBoundColumn DataField="C_DATE" DataType="System.DateTime"  Visible ="false"  ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter C_DATE column" HeaderText="Ngày thống kê" ReadOnly ="true" HeaderStyle-Width ="8%" 
        SortExpression="C_DATE" UniqueName="C_DATE" DataFormatString="{0: dd/MM/yyyy}">
    </telerik:GridBoundColumn>
     <telerik:GridTemplateColumn DataField="C_UNIT"  ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter C_UNIT column" HeaderText="Đơn vị tính"  ItemStyle-Width ="80px" HeaderStyle-Width ="80px" 
        SortExpression="C_UNIT" UniqueName="C_UNIT">   
     <ItemTemplate>
            <%#Eval("C_UNIT")%>
      </ItemTemplate>
      <EditItemTemplate>
             <%#Eval("C_UNIT")%>         
      </EditItemTemplate>
    </telerik:GridTemplateColumn>
     <telerik:GridTemplateColumn DataField="VALUE2" ColumnGroupName ="thuchien"  ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter VALUE2 column" HeaderText="Tổng số"  ItemStyle-Width ="100px" HeaderStyle-Width ="100px" 
        SortExpression="VALUE2" UniqueName="VALUE2">   
     <ItemTemplate>
            <%#Eval("VALUE2")%>
      </ItemTemplate>
      <EditItemTemplate>
    <%--  VALUE1 lưu năm thực hiện--%>
            <telerik:RadNumericTextBox  ID="txtVALUE2" Runat="server" Text ='<%#Bind("VALUE2")%>'
             IncrementSettings-InterceptMouseWheel="true" Width="70px" CssClass ="csstextNum" MaxValue="500000" MinValue="0" IncrementSettings-InterceptArrowKeys="true" >
             <NumberFormat  DecimalDigits ="0"/>
             </telerik:RadNumericTextBox>
      </EditItemTemplate>
    </telerik:GridTemplateColumn>
     <telerik:GridTemplateColumn DataField="VALUE3"  ColumnGroupName ="thuchien" ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter VALUE3 column" HeaderText="Trong đó: Nữ"  ItemStyle-Width ="100px" HeaderStyle-Width ="100px" 
        SortExpression="VALUE3" UniqueName="VALUE3">   
     <ItemTemplate>
            <%#Eval("VALUE3")%>
      </ItemTemplate>
      <EditItemTemplate>
            <telerik:RadNumericTextBox  ID="txtVALUE3" Runat="server" Text ='<%#Bind("VALUE3")%>'  
             IncrementSettings-InterceptMouseWheel="true" Width="70px" CssClass ="csstextNum" MaxValue="500000" MinValue="0"  IncrementSettings-InterceptArrowKeys="true" >
             <NumberFormat  DecimalDigits ="0"/>
             </telerik:RadNumericTextBox>
      </EditItemTemplate>
    </telerik:GridTemplateColumn>   
    <telerik:GridTemplateColumn></telerik:GridTemplateColumn>            
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
<asp:SqlDataSource ID="DoanhnghiepDaotaoDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
        DeleteCommand="DELETE FROM DOANHNGHIEP_VALUE WHERE (PK_ID = @PK_ID)" 
        SelectCommand="SELECT DOANHNGHIEP.MADOANHNGHIEP, DOANHNGHIEP.TENDOANHNGHIEP, DOANHNGHIEP_VALUE.PK_ID, DOANHNGHIEP_VALUE.FK_DOANHNGHIEP, DOANHNGHIEP_VALUE.FK_TIEUCHI, DOANHNGHIEP_VALUE.C_DATE, DOANHNGHIEP_VALUE.C_DATE_EDIT, DOANHNGHIEP_VALUE.VALUE1, DOANHNGHIEP_VALUE.VALUE2, DOANHNGHIEP_VALUE.VALUE3, DOANHNGHIEP_VALUE.VALUE4, DOANHNGHIEP_VALUE.VALUE5, DOANHNGHIEP_VALUE.VALUE6, DOANHNGHIEP_VALUE.VALUE7, DOANHNGHIEP_VALUE.VALUE8, DOANHNGHIEP_VALUE.VALUE9, DOANHNGHIEP_VALUE.VALUE10, DOANHNGHIEP_VALUE.VALUE11, CONVERT (DATETIME, FLOOR(CONVERT (FLOAT, DOANHNGHIEP_VALUE.C_DATE))) AS DATEONLY, DOANHNGHIEP_TIEUCHI.C_CODE, DOANHNGHIEP_TIEUCHI.C_NAME, DOANHNGHIEP_TIEUCHI.C_HEADER, DOANHNGHIEP_TIEUCHI.C_LEVEL, DOANHNGHIEP_TIEUCHI.C_UNIT FROM DOANHNGHIEP_VALUE INNER JOIN DOANHNGHIEP ON DOANHNGHIEP_VALUE.FK_DOANHNGHIEP = DOANHNGHIEP.PK_ID INNER JOIN DOANHNGHIEP_TIEUCHI ON DOANHNGHIEP_VALUE.FK_TIEUCHI = DOANHNGHIEP_TIEUCHI.PK_ID WHERE (DOANHNGHIEP_VALUE.VALUE1 = @VALUE1) AND (DOANHNGHIEP.PK_ID = @PK_ID) AND (DOANHNGHIEP_TIEUCHI.C_TYPE = 'DAOTAO') AND (CONVERT(NVARCHAR(8), DOANHNGHIEP_VALUE.C_DATE, 112) = CONVERT(NVARCHAR(8), @C_DATE, 112)) ORDER BY DATEONLY DESC, DOANHNGHIEP_TIEUCHI.C_ORDER"      
        UpdateCommand="UPDATE DOANHNGHIEP_VALUE SET C_DATE_EDIT = GETDATE(), VALUE2 = @VALUE2, VALUE3 = @VALUE3, VALUE4 = @VALUE4 WHERE (PK_ID = @PK_ID)" >
    <DeleteParameters>
        <asp:Parameter Name="PK_ID" />
    </DeleteParameters>
    <SelectParameters>
        <asp:QueryStringParameter DefaultValue="0" Name="PK_ID" 
            QueryStringField="IDDN" />
        <asp:ControlParameter ControlID="radDatareport" DefaultValue="01/01/2000" 
            Name="C_DATE" PropertyName="SelectedDate" />
            <asp:ControlParameter ControlID="radNamthuchien" DefaultValue="" 
            Name="VALUE1" PropertyName="SelectedValue" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="VALUE2" />
        <asp:Parameter Name="VALUE3" />
        <asp:Parameter Name="VALUE4" />
        <asp:Parameter Name="PK_ID" />
    </UpdateParameters>
</asp:SqlDataSource>