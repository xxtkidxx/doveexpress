<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SOQUYTIENMAT.ascx.cs" Inherits="module_SOQUYTIENMAT" %>
<%@ Register TagPrefix="uc1" Namespace="ITCLIB.Admin" %>
<telerik:RadCodeBlock ID="RadCodeBlockSOQUYTIENMAT" runat="server">
<script type="text/javascript">
    function RowDblClick(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("SOQUYTIENMAT") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewSOQUYTIENMAT") && (CanEdit == "True")) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
    }   
</script>
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

        var grid = $get("<%=RadGridSOQUYTIENMAT.ClientID %>");
        var elements = grid.getElementsByTagName(tagName);
        for (var i = 0; i < elements.length; i++) {
            var element = elements[i];
            if (element.id.indexOf(serverID) >= 0)
                return element;
        }
    }
</script>
<script type="text/javascript">
    function cmbYearClientSelectedIndexChangedHandler(sender, eventArgs) {
        $find("<%=RadGridSOQUYTIENMAT.ClientID %>").get_masterTableView().rebind();
        return false;
    }
    function cmbMonthClientSelectedIndexChangedHandler(sender, eventArgs) {
        $find("<%=RadGridSOQUYTIENMAT.ClientID %>").get_masterTableView().rebind();
        return false;
    }
</script>
<div style ="width:100%; margin: 10px 10px 10px 10px;">
Chọn tháng:&nbsp; 
<telerik:RadComboBox ID="cmbMonth" runat="server" onclientselectedindexchanged="cmbMonthClientSelectedIndexChangedHandler"
ShowToggleImage="True" EmptyMessage="Chọn tháng" onprerender="cmbMonth_PreRender">
<Items>
    <telerik:RadComboBoxItem Value ="1" Text ="Tháng 1" />
    <telerik:RadComboBoxItem Value ="2" Text ="Tháng 2" />
    <telerik:RadComboBoxItem Value ="3" Text ="Tháng 3" />
    <telerik:RadComboBoxItem Value ="4" Text ="Tháng 4" />
    <telerik:RadComboBoxItem Value ="5" Text ="Tháng 5" />
    <telerik:RadComboBoxItem Value ="6" Text ="Tháng 6" />
    <telerik:RadComboBoxItem Value ="7" Text ="Tháng 7" />
    <telerik:RadComboBoxItem Value ="8" Text ="Tháng 8" />
    <telerik:RadComboBoxItem Value ="9" Text ="Tháng 9" />
    <telerik:RadComboBoxItem Value ="10" Text ="Tháng 10" />
    <telerik:RadComboBoxItem Value ="11" Text ="Tháng 11" />
    <telerik:RadComboBoxItem Value ="12" Text ="Tháng 12" />
</Items>
</telerik:RadComboBox>
Chọn năm:&nbsp; 
<telerik:RadComboBox ID="cmbYear" runat="server" onclientselectedindexchanged="cmbYearClientSelectedIndexChangedHandler"
ShowToggleImage="True" EmptyMessage="Chọn năm" onprerender="cmbYear_PreRender">
<Items>
</Items>
</telerik:RadComboBox>
</div>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelSOQUYTIENMAT" runat="server" />
<telerik:RadAjaxPanel ID="RadAjaxPanelSOQUYTIENMAT" runat="server" Height="200px" Width="100%">
<style type="text/css">
table.gridtable {
	font-family: verdana,arial,sans-serif;
	font-size:13px;
	color:#333333;
	border-width: 1px;
	border-color: #666666;
	border-collapse: collapse;
	width:50%;
	margin: 10px 10px 10px 10px;
}
table.gridtable th {
	border-width: 1px;
	padding: 8px;
	font-weight: bold;
	border-style: solid;
	border-color: #666666;
	background-color: #dedede;
}
table.gridtable td {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #666666;
	background-color: #ffffff;
}
</style>
<table class="gridtable">
<tr>
	<th>Tồn đầu</th><th>Tổng thu</th><th>Tổng chi</th><th>Tồn cuối</th><th>Tồn thực tế</th>
</tr>
<tr>
	<td>
        <telerik:RadNumericTextBox  ID="txtTONDAU" Enabled="false" ForeColor="Red" Width ="90%" Runat="server"><NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/></telerik:RadNumericTextBox>    
    </td>
    <td>
        <telerik:RadNumericTextBox  ID="txtTONGTHU" Enabled="false" ForeColor="Red" Width ="90%" Runat="server"><NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/></telerik:RadNumericTextBox>    
    </td>
    <td>
        <telerik:RadNumericTextBox  ID="txtTONGCHI" Enabled="false" ForeColor="Red" Width ="90%" Runat="server"><NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/></telerik:RadNumericTextBox>    
    </td>
    <td>
        <telerik:RadNumericTextBox  ID="txtTONCUOI" Enabled="false" ForeColor="Red" Width ="90%" Runat="server"><NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/></telerik:RadNumericTextBox>    
    </td>
    <td>
        <telerik:RadNumericTextBox  ID="txtTONTHUCTE" Enabled="false" ForeColor="Red" Width ="90%" Runat="server"><NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/></telerik:RadNumericTextBox>    
    </td>
</tr>
</table>
<telerik:RadGrid ID="RadGridSOQUYTIENMAT" runat="server" Skin="Vista" 
    AllowPaging="False" PageSize="100" AllowSorting="True" AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False" AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" DataSourceID="SOQUYTIENMATDataSource" ShowFooter="True"
    ondatabound="RadGridSOQUYTIENMAT_DataBound" onitemdeleted="RadGridSOQUYTIENMAT_ItemDeleted" oniteminserted="RadGridSOQUYTIENMAT_ItemInserted" 
    onitemupdated="RadGridSOQUYTIENMAT_ItemUpdated" 
    onitemcommand="RadGridSOQUYTIENMAT_ItemCommand" onitemdatabound="RadGridSOQUYTIENMAT_ItemDataBound" CellSpacing="0" 
    onexcelmlexportrowcreated="RadGridSOQUYTIENMAT_ExcelMLExportRowCreated">     
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
     <GroupingSettings CaseSensitive ="false"  />
    <MasterTableView Name="MasterTableViewSOQUYTIENMAT" CommandItemDisplay="Top" DataSourceID="SOQUYTIENMATDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b>Quản lý sổ quỹ tiền mặt</b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridSOQUYTIENMAT.EditIndexes.Count == 0 && ITCLIB.Security.Security.CanEditModule("SOQUYTIENMAT") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridSOQUYTIENMAT.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Update.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridSOQUYTIENMAT.EditIndexes.Count > 0 || RadGridSOQUYTIENMAT.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridSOQUYTIENMAT.MasterTableView.IsItemInserted && ITCLIB.Security.Security.CanAddModule("SOQUYTIENMAT") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="PerformInsert" Visible='<%# RadGridSOQUYTIENMAT.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Insert.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:return confirm('Bạn có muốn xóa bản ghi đã chọn không?')" runat="server" CommandName="DeleteSelected" Visible='<%# ITCLIB.Security.Security.CanDeleteModule("SOQUYTIENMAT") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Delete.gif" />Xóa</asp:LinkButton>&nbsp;&nbsp;
                       <asp:LinkButton ID="LinkButton4" runat="server" CommandName="RebindGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Refresh.gif" />Làm mới</asp:LinkButton>
                    </div>
                    <div style="padding: 5px 5px;float:right;width:auto">
                        <asp:LinkButton ID="ExportToPdfButton" runat="server" CommandName="ExportToPdf"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/pdf.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToWordButton" runat="server" CommandName="ExportToWord"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/word.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToExcelButton" runat="server" CommandName="ExportToExcel"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/excel.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToCsvButton" runat="server" CommandName="ExportToCsv"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/csv.gif" /></asp:LinkButton>&nbsp;&nbsp;
                    </div>
        </CommandItemTemplate>
        <Columns>
                <telerik:GridBoundColumn UniqueName="PK_ID" HeaderText="" DataField="PK_ID" Visible ="false"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                 <telerik:GridTemplateColumn HeaderText ="" ShowFilterIcon="false">   
                 <FilterTemplate >
                  <center>
                    <asp:ImageButton ID="btnShowAll" runat="server" ImageUrl="../Images/Grid/filterCancel.gif" AlternateText="Xem tất" ToolTip="Xem tất" OnClick="btnShowAll_Click" Style="vertical-align: middle" />
                  </center>
                 </FilterTemplate>
                  <ItemTemplate>
                      <asp:Label ID="lblSTT" runat="server" Text=""></asp:Label>
                </ItemTemplate>
                 <HeaderStyle HorizontalAlign ="Center" Width ="30px" />
                 <ItemStyle HorizontalAlign ="Center" Width ="30px" />
               </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn UniqueName="C_NGAY" HeaderText="Ngày" DataField="C_NGAY" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy}">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_TYPE" HeaderText="Loại" DataField="C_TYPE" HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="KIHIEUTAIKHOANNAME" HeaderText="Nội dung" DataField="KIHIEUTAIKHOANNAME" HeaderStyle-Width="200px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_DESC" HeaderText="Diễn giải" DataField="C_DESC" HeaderStyle-Width="200px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn UniqueName="C_SOTIEN" HeaderText="Số tiền" DataField="C_SOTIEN" HeaderStyle-Width="110px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">   
                   <ItemTemplate>
                      <telerik:RadNumericTextBox  ID="txtC_SOTIEN" Enabled="false" Text ='<%#Bind("C_SOTIEN")%>' Width ="90%" Runat="server"><NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/></telerik:RadNumericTextBox>
                    </ItemTemplate>
               </telerik:GridTemplateColumn>
               <telerik:GridTemplateColumn UniqueName="C_TON" HeaderText="Tồn" HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">   
                   <ItemTemplate>
                      <telerik:RadNumericTextBox  ID="txtC_TON" Enabled="false" Width ="90%" Runat="server"><NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/></telerik:RadNumericTextBox>
                    </ItemTemplate>
               </telerik:GridTemplateColumn>
        </Columns>
        <EditFormSettings InsertCaption="Thêm nhận gửi mới" CaptionFormatString="Sửa nhận gửi: <b>{0}</b>" CaptionDataField="C_DESC" EditFormType="Template" PopUpSettings-Width="900px">
        <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
           <FormTemplate>
            <div class="headerthongtin">
              <ul>
                <li class="lifirst"><asp:LinkButton ID="btnSave" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'><img src="Images/img_save.jpg" /><%# (Container is GridEditFormInsertItem) ? "Lưu" : "Lưu" %></asp:LinkButton></li>
                     <li><asp:LinkButton ID="btnClose" runat="server" CommandName="Cancel"><img src="Images/img_Close.jpg" />Đóng</asp:LinkButton></li>                     
              </ul>
            </div>               
            <div class="clearfix bgpopup"> 
            <div style="width:900px; height:70px; background:#FFFFFF" class="clearfix">      
            <table id="tblEdit" class ="TableEditInGrid" cellspacing="3" cellpadding="3" style="width: 100%" border="0">
            <tr>
                <td style ="width:100px;"> <span class="rtsTxtnew">Ngày:</td>
                <td colspan="4">
                    <telerik:RadDatePicker ID="radNgaySOQUYTIENMAT" Width ="150px" DbSelectedDate ='<%# Bind("C_NGAY") %>' runat="server" AutoPostBack ="false" >
                        <DateInput ID ="DateInput1" runat ="server" DateFormat ="dd/MM/yyyy" MinDate="1/1/1890 12:00:00 AM">
                        <ClientEvents  OnKeyPress ="controlkeypress"/>
                        </DateInput>
                    </telerik:RadDatePicker>
                </td>
                <td style ="width:100px;"> <span class="rtsTxtnew">Loại:</span></td>
                <td colspan="4">
                    <asp:HiddenField ID="txtID" Value ='<%# Eval( "PK_ID") %>' runat="server" />
                    <telerik:RadComboBox ID="cmbC_TYPE" SelectedValue='<%# Bind("C_TYPE") %>' runat="server" EmptyMessage="Chọn">
                            <Items>
                                <telerik:RadComboBoxItem Value ="Thu" Text ="Thu" />
                                <telerik:RadComboBoxItem Value ="Chi" Text ="Chi" />
                                <telerik:RadComboBoxItem Value ="Tồn cuối kỳ" Text ="Tồn cuối kỳ" />
                            </Items>
                   </telerik:RadComboBox>
                </td>               
            </tr>
            <tr>
                <td style ="width:100px;"> <span class="rtsTxtnew">Nội dung:</span></td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbFK_KIHIEUTAIKHOAN" runat="server"
                    DataTextField="C_NAME" DataValueField="C_CODE" DataSourceID="KIHIEUTAIKHOANDataSource" SelectedValue='<%# Bind("FK_KIHIEUTAIKHOAN") %>'
                    ShowToggleImage="True" EmptyMessage="Chọn">
                    </telerik:RadComboBox>
                </td>
                <td style ="width:100px;"> <span class="rtsTxtnew">Diễn giải:</span></td>
                <td colspan="4">
                    <telerik:RadTextBox ID="txtC_DESC" Width ="90%" Text='<%# Bind("C_DESC") %>' runat="server"></telerik:RadTextBox>                 
                </td>
                <td style ="width:100px;"> <span class="rtsTxtnew">Số tiền:</span></td>
                <td colspan="4">
                  <telerik:RadNumericTextBox  ID="txtC_SOTIEN" Width ="90%" Runat="server" Text='<%# Bind("C_SOTIEN") %>'>
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>           
                </td>            
            <tr>
           </table>
            </div> 
             </center> 
        <!-- end bgpopup--></div>    
             </FormTemplate>
        </EditFormSettings>
        </MasterTableView>
        <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G1"/>
        <ClientSettings AllowKeyboardNavigation="true" KeyboardNavigationSettings-AllowSubmitOnEnter="true" ClientEvents-OnKeyPress="KeyPressed">
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
            <ClientEvents OnPopUpShowing="PopUpShowing" />
            <ClientEvents OnRowDblClick="RowDblClick" />
            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="True" FrozenColumnsCount="3" ScrollHeight="450px" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
</telerik:RadAjaxPanel>
<asp:SqlDataSource ID="SOQUYTIENMATDataSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>" 
    DeleteCommand="DELETE FROM [SOQUYTIENMAT] WHERE [PK_ID] = @PK_ID" 
    InsertCommand="INSERT INTO [SOQUYTIENMAT] ([C_NGAY], [C_TYPE], [FK_KIHIEUTAIKHOAN], [C_DESC], [C_SOTIEN], [C_TON],[C_ORDER],[FK_VUNGLAMVIEC]) VALUES (@C_NGAY, @C_TYPE, @FK_KIHIEUTAIKHOAN, @C_DESC, @C_SOTIEN, 0, @C_ORDER,@FK_VUNGLAMVIEC)"
    SelectCommand="SELECT [SOQUYTIENMAT].[PK_ID], [SOQUYTIENMAT].[C_NGAY], [SOQUYTIENMAT].[C_TYPE], [SOQUYTIENMAT].[FK_KIHIEUTAIKHOAN], [SOQUYTIENMAT].[C_DESC], [SOQUYTIENMAT].[C_SOTIEN], [SOQUYTIENMAT].[C_TON], [SOQUYTIENMAT].[C_ORDER],DMKIHIEUTAIKHOAN.C_NAME as KIHIEUTAIKHOANNAME FROM [SOQUYTIENMAT] LEFT OUTER JOIN DMKIHIEUTAIKHOAN ON SOQUYTIENMAT.FK_KIHIEUTAIKHOAN=DMKIHIEUTAIKHOAN.C_CODE  WHERE ([SOQUYTIENMAT].[FK_VUNGLAMVIEC] = @FK_VUNGLAMVIEC AND month([SOQUYTIENMAT].[C_NGAY]) = @MONTH AND year([SOQUYTIENMAT].[C_NGAY]) = @YEAR) OR ([SOQUYTIENMAT].[C_TYPE] = N'Tồn đầu kỳ') ORDER BY C_ORDER ASC, C_NGAY ASC, PK_ID ASC" 
    UpdateCommand="UPDATE [SOQUYTIENMAT] SET [C_NGAY] = @C_NGAY, [C_TYPE] = @C_TYPE, [FK_KIHIEUTAIKHOAN] = @FK_KIHIEUTAIKHOAN,[C_DESC] = @C_DESC, [C_SOTIEN] = @C_SOTIEN WHERE [PK_ID] = @PK_ID">
    <SelectParameters>
        <asp:ControlParameter ControlID="cmbMonth" Name="MONTH" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="cmbYear" Name="YEAR" PropertyName="SelectedValue" />
        <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="PK_ID" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="C_NGAY" Type="DateTime" />
        <asp:Parameter Name="C_TYPE" Type="String" />
        <asp:Parameter Name="FK_KIHIEUTAIKHOAN" Type="String"/>
        <asp:Parameter Name="C_DESC" Type="String" />
        <asp:Parameter Name="C_SOTIEN" Type="String" />   
        <asp:Parameter Name="C_ORDER" Type="Int32" />
        <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />     
    </InsertParameters>
    <UpdateParameters>
         <asp:Parameter Name="C_NGAY" Type="DateTime" />
        <asp:Parameter Name="C_TYPE" Type="String" />
        <asp:Parameter Name="FK_KIHIEUTAIKHOAN" Type="String"/>
        <asp:Parameter Name="C_DESC" Type="String" />
        <asp:Parameter Name="C_SOTIEN" Type="String" />  
    </UpdateParameters>       
</asp:SqlDataSource>
<asp:SqlDataSource ID="KIHIEUTAIKHOANDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
 SelectCommand="SELECT DMKIHIEUTAIKHOAN.* FROM DMKIHIEUTAIKHOAN" >
</asp:SqlDataSource>