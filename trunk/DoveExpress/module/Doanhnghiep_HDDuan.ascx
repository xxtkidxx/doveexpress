<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Doanhnghiep_HDDuan.ascx.cs" Inherits="module_Doanhnghiep_HDDuan" %>
<%@ Register TagPrefix="uc1" TagName="chitheonganhkinhte" Src="DN_HDDA_NganhKT.ascx" %>

<telerik:RadCodeBlock ID="RadCodeBlockDoanhnghiepHDDuan" runat="server">
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
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelDoanhnghiepHDDuan" runat="server" />

<div style =" width:100%; margin: 10px 10px 10px 10px; ">
Chọn ngày báo cáo:&nbsp; 
<telerik:RadDatePicker ID="radDatareport" Width ="120px" runat="server" 
    AutoPostBack ="true" onselecteddatechanged="radDatareport_SelectedDateChanged"  >
<Calendar ID="Calendar1" runat ="server"  UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>
<DateInput ID="DateInput2" runat ="server" DisplayDateFormat ="dd/MM/yyyy" DateFormat ="dd/MM/yyyy" 
        AutoPostBack="True"></DateInput>
</telerik:RadDatePicker>
</div>

<telerik:RadGrid ID="RadGridDoanhnghiepHDDuan" runat="server" Skin="Windows7" 
    AllowPaging="false" PageSize="20" AllowSorting="True" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"  AllowFilteringByColumn ="false" 
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True"  ShowHeader ="false" 
    DataSourceID="DoanhnghiepHDDuanDataSource" ShowFooter="True"
    ondatabound="RadGridDoanhnghiepHDDuan_DataBound"  
    onitemcommand="RadGridDoanhnghiepHDDuan_ItemCommand" CellSpacing="0" 
    onprerender="RadGridDoanhnghiepHDDuan_PreRender" 
    onitemupdated="RadGridDoanhnghiepHDDuan_ItemUpdated"  onitemdatabound="RadGridDoanhnghiepHDDuan_ItemDataBound">
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
    <MasterTableView Name="MasterTableViewDoanhnghiepHDDuan" CommandItemDisplay="Top" DataSourceID="DoanhnghiepHDDuanDataSource" DataKeyNames="PK_ID,C_CODE,C_TABLE"
    ClientDataKeyNames="PK_ID,C_CODE,C_TABLE" EditMode="InPlace" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b><asp:Label ID="Label1" ForeColor ="Red" runat="server" Text="" OnPreRender ="lblCap_PreRender"></asp:Label></b>&nbsp;&nbsp;&nbsp;&nbsp;
                       <br /><br /><asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridDoanhnghiepHDDuan.EditIndexes.Count == 0 && ITCLIB.Security.Security.CanEditModule("DoanhNghieps") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridDoanhnghiepHDDuan.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/img_save.jpg" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridDoanhnghiepHDDuan.EditIndexes.Count > 0 || RadGridDoanhnghiepHDDuan.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InsertCode" Visible='<%# !RadGridDoanhnghiepHDDuan.MasterTableView.IsItemInserted && ITCLIB.Security.Security.CanAddModule("DoanhNghieps") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Tạo bảng báo cáo</asp:LinkButton>&nbsp;&nbsp;
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
         <telerik:GridBoundColumn DataField="C_TABLE" DataType="System.Int32"  Visible ="false"  UniqueName="C_TABLE"></telerik:GridBoundColumn>
    <telerik:GridBoundColumn DataField="C_DATE" DataType="System.DateTime"  Visible ="false"  ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter C_DATE column" HeaderText="Ngày thống kê" ReadOnly ="true" HeaderStyle-Width ="8%" 
        SortExpression="C_DATE" UniqueName="C_DATE" DataFormatString="{0: dd/MM/yyyy}">
    </telerik:GridBoundColumn>
     <telerik:GridTemplateColumn DataField="VALUE1"  ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter VALUE1 column" HeaderText="Thực hiện" SortExpression="VALUE1" UniqueName="VALUE1">   
     <ItemTemplate>
            <%#Eval("VALUE1")%>        
      </ItemTemplate>
      <EditItemTemplate>
          <asp:HiddenField ID="hfLevel" runat="server" Value ='<%#Eval("C_LEVEL") %>' />
          <asp:HiddenField ID="fhTable" runat="server" Value ='<%#Eval("C_TABLE") %>' />
          <table class ="tableInGrid">
<asp:Panel ID = "panelheader_b1" runat ="server">
        <tr>        
            <td style =" width:350px; font-weight:bold;"></td>
            <td style =" width:30px; font-weight:bold;" class="tddece2">  Mã      </td>
            <td style =" width:80px; font-weight:bold;" class="tddece2">  Đơn vị      </td>
            <td style =" width:100px; font-weight:bold;" class="tddece2"> Thực hiện     </td>
            <td style =" width:100px; font-weight:bold;display :none;" class="tddece2"></td>
            <td style =" width:100px; font-weight:bold;display :none;" class="tddecelast"></td>
        </tr>
</asp:Panel>
<asp:Panel ID = "panelheader_b2" runat ="server">
        <tr>    
            <td style =" width:350px; font-weight:bold;"  >
                    </td>
            <td style =" width:30px; font-weight:bold;" >
                  </td>
            <td style =" width:80px; font-weight:bold;" >
               </td>    
            <td style =" width:100px; font-weight:bold;" class="tddece2" >
            Số         </td>
            <td style =" width:100px; font-weight:bold;" class="tddece2">
            Số phát      </td>
            <td style =" width:100px; font-weight:bold;" class="tddecelast">
            Số đã      </td>
        </tr>
</asp:Panel>
        <tr>
        <td style =" width:350px;" > <%#getName(Eval("C_NAME"),Eval("C_LEVEL").ToString(),Eval("C_HEADER"))%></td>
       <td style =" width:30px;"><%#Eval("C_CODE")%></td>
        <td style =" width:80px;"> <%#Eval("C_UNIT")%></td>
            <td>            
             <telerik:RadNumericTextBox  ID="txtVALUE1" Runat="server" Text ='<%#Bind("VALUE1")%>' Enabled ='<%#(bool)Eval("C_ISTYPE") %>' 
             IncrementSettings-InterceptMouseWheel="true"  Width="90px"  CssClass ="csstextNum" MaxValue="500000" MinValue="0" IncrementSettings-InterceptArrowKeys="true" >
             <NumberFormat  DecimalDigits ="0"/>
             </telerik:RadNumericTextBox>
             <telerik:RadNumericTextBox  ID="txtVALUE2" Runat="server" Text ='<%#Bind("VALUE2")%>' Enabled ='<%#(bool)Eval("C_ISTYPE") %>' 
             IncrementSettings-InterceptMouseWheel="true"  Width="90px"  CssClass ="csstextNum" MaxValue="500000" MinValue="0" IncrementSettings-InterceptArrowKeys="true" >
             <NumberFormat  DecimalDigits ="0"/>
             </telerik:RadNumericTextBox>         
            </td>
            <td>
              <telerik:RadNumericTextBox  ID="txtVALUE3" Runat="server" Text ='<%#Bind("VALUE3")%>'  Enabled ='<%#(bool)Eval("C_ISTYPE") %>' 
             IncrementSettings-InterceptMouseWheel="true"  Width="90px"  CssClass ="csstextNum" MaxValue="500000" MinValue="0" IncrementSettings-InterceptArrowKeys="true" >
             <NumberFormat  DecimalDigits ="0"/>
             </telerik:RadNumericTextBox>      
            </td>
            <td>
             <telerik:RadNumericTextBox  ID="txtVALUE4" Runat="server" Text ='<%#Bind("VALUE4")%>' Enabled ='<%#(bool)Eval("C_ISTYPE") %>' 
             IncrementSettings-InterceptMouseWheel="true"  Width="90px"  CssClass ="csstextNum" MaxValue="500000" MinValue="0" IncrementSettings-InterceptArrowKeys="true" >
             <NumberFormat  DecimalDigits ="0"/>
            </telerik:RadNumericTextBox>
            </td>
        </tr>
        <tr>
        <td colspan ="6">
        <uc1:chitheonganhkinhte id ="nganhkinhte" runat ="server" /> 
        </td>
        </tr>
    </table>            
      </EditItemTemplate>
    </telerik:GridTemplateColumn>   
    <telerik:GridTemplateColumn>   
    </telerik:GridTemplateColumn> 
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
<asp:SqlDataSource ID="DoanhnghiepHDDuanDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
        DeleteCommand="DELETE FROM DOANHNGHIEP_VALUE WHERE (PK_ID = @PK_ID)" 
        InsertCommand="INSERT INTO DOANHNGHIEP_VALUE(FK_DOANHNGHIEP, FK_TIEUCHI, C_DATE, VALUE1, VALUE2, VALUE3, VALUE4, VALUE5, VALUE6, VALUE7, VALUE8, VALUE9) VALUES (@FK_DOANHNGHIEP, @FK_TIEUCHI, @C_DATE, @VALUE1, @VALUE2, @VALUE3, @VALUE4, @VALUE5, @VALUE6, @VALUE7, @VALUE8, @VALUE9)"
        SelectCommand="SELECT DOANHNGHIEP.MADOANHNGHIEP, DOANHNGHIEP.TENDOANHNGHIEP, DOANHNGHIEP_VALUE.PK_ID, DOANHNGHIEP_VALUE.FK_DOANHNGHIEP, DOANHNGHIEP_VALUE.FK_TIEUCHI, DOANHNGHIEP_VALUE.C_DATE, DOANHNGHIEP_VALUE.C_DATE_EDIT, DOANHNGHIEP_VALUE.VALUE1, DOANHNGHIEP_VALUE.VALUE2, DOANHNGHIEP_VALUE.VALUE3, DOANHNGHIEP_VALUE.VALUE4, DOANHNGHIEP_VALUE.VALUE5, DOANHNGHIEP_VALUE.VALUE6, DOANHNGHIEP_VALUE.VALUE7, DOANHNGHIEP_VALUE.VALUE8, DOANHNGHIEP_VALUE.VALUE9, DOANHNGHIEP_VALUE.VALUE10, DOANHNGHIEP_VALUE.VALUE11, CONVERT (DATETIME, FLOOR(CONVERT (FLOAT, DOANHNGHIEP_VALUE.C_DATE))) AS DATEONLY, DOANHNGHIEP_TIEUCHI.C_CODE, DOANHNGHIEP_TIEUCHI.C_NAME, DOANHNGHIEP_TIEUCHI.C_HEADER, DOANHNGHIEP_TIEUCHI.C_LEVEL, DOANHNGHIEP_TIEUCHI.C_UNIT, DOANHNGHIEP_TIEUCHI.C_TABLE , DOANHNGHIEP_TIEUCHI.C_ISTYPE FROM DOANHNGHIEP_VALUE INNER JOIN DOANHNGHIEP ON DOANHNGHIEP_VALUE.FK_DOANHNGHIEP = DOANHNGHIEP.PK_ID INNER JOIN DOANHNGHIEP_TIEUCHI ON DOANHNGHIEP_VALUE.FK_TIEUCHI = DOANHNGHIEP_TIEUCHI.PK_ID WHERE (DOANHNGHIEP.PK_ID = @PK_ID) AND (DOANHNGHIEP_TIEUCHI.C_TYPE = 'HDDUAN') AND ((CONVERT(NVARCHAR(8), DOANHNGHIEP_VALUE.C_DATE, 112) =  @C_DATE) or (CONVERT (DATETIME, FLOOR(CONVERT (FLOAT, DOANHNGHIEP_VALUE.C_DATE)))  =  CONVERT (DATETIME, FLOOR(CONVERT (FLOAT, GETDATE()))) and (@C_DATE =0))) ORDER BY DATEONLY DESC, DOANHNGHIEP_TIEUCHI.C_ORDER"      
        UpdateCommand="UPDATE DOANHNGHIEP_VALUE SET C_DATE_EDIT = GETDATE(), VALUE1 = @VALUE1, VALUE2 = @VALUE2, VALUE3 = @VALUE3, VALUE4 = @VALUE4, VALUE5 = @VALUE5, VALUE6 = @VALUE6, VALUE8 = @VALUE8, VALUE7 = @VALUE7, VALUE9 = @VALUE9 WHERE (PK_ID = @PK_ID)" >
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
        <asp:Parameter Name="VALUE5" />
        <asp:Parameter Name="VALUE6" />
        <asp:Parameter Name="VALUE7" />
        <asp:Parameter Name="VALUE8" />
        <asp:Parameter Name="VALUE9" />
    </InsertParameters>
    <SelectParameters>
        <asp:QueryStringParameter DefaultValue="0" Name="PK_ID" 
            QueryStringField="IDDN" />
         <asp:QueryStringParameter DefaultValue="0" Name="C_DATE" 
            QueryStringField="dateselect" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="VALUE1" />
        <asp:Parameter Name="VALUE2" />
        <asp:Parameter Name="VALUE3" />
        <asp:Parameter Name="VALUE4" />
        <asp:Parameter Name="VALUE5" />
        <asp:Parameter Name="VALUE6" />
        <asp:Parameter Name="VALUE8" />
        <asp:Parameter Name="VALUE7" />
        <asp:Parameter Name="VALUE9" />
        <asp:Parameter Name="PK_ID" />
    </UpdateParameters>
</asp:SqlDataSource>

 <uc1:chitheonganhkinhte id ="nganhkinhte" runat ="server" /> 