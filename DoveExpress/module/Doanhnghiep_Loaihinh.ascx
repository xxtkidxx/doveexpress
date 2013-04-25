<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Doanhnghiep_Loaihinh.ascx.cs" Inherits="module_Doanhnghiep_Loaihinh" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxProxyLoaiHinhDN" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGridLoaiHinhDN">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridLoaiHinhDN" LoadingPanelID="RadAjaxLoadingPanelLoaiHinhDN" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadCodeBlock ID="RadCodeBlockLoaiHinhDN" runat="server">
<script type="text/javascript">
        function RowDblClickUser(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("Lists") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewLoaiHinhDN") && (CanEdit == "True")) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
        }
</script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelLoaiHinhDN" runat="server" />
<telerik:RadGrid ID="RadGridLoaiHinhDN" runat="server" Skin="Vista" 
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="LoaiHinhDNDataSource" ShowFooter="True"
    ondatabound="RadGridLoaiHinhDN_DataBound" 
    onitemdeleted="RadGridLoaiHinhDN_ItemDeleted" oniteminserted="RadGridLoaiHinhDN_ItemInserted" 
    onitemupdated="RadGridLoaiHinhDN_ItemUpdated" 
    onitemcommand="RadGridLoaiHinhDN_ItemCommand" 
    onitemdatabound="RadGridLoaiHinhDN_ItemDataBound" CellSpacing="0">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML">
<Excel Format="ExcelML"></Excel>
    </ExportSettings>   
     <GroupingSettings CaseSensitive ="false"  />
    <MasterTableView Name="MasterTableViewLoaiHinhDN" CommandItemDisplay="Top" DataSourceID="LoaiHinhDNDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b>Quản lý Loại hình doanh nghiệp</b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridLoaiHinhDN.EditIndexes.Count == 0 && ITCLIB.Security.Security.CanEditModule("Lists") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridLoaiHinhDN.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Update.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridLoaiHinhDN.EditIndexes.Count > 0 || RadGridLoaiHinhDN.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridLoaiHinhDN.MasterTableView.IsItemInserted && ITCLIB.Security.Security.CanAddModule("Lists") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="PerformInsert" Visible='<%# RadGridLoaiHinhDN.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Insert.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:return confirm('Bạn có muốn xóa bản ghi đã chọn không?')" runat="server" CommandName="DeleteSelected" Visible='<%# ITCLIB.Security.Security.CanDeleteModule("Lists") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Delete.gif" />Xóa</asp:LinkButton>&nbsp;&nbsp;
                       <asp:LinkButton ID="LinkButton4" runat="server" CommandName="RebindGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Refresh.gif" />Làm mới</asp:LinkButton>
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
                  <telerik:GridBoundColumn UniqueName="PK_ID" HeaderText="" DataField="PK_ID" Visible ="false"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                 <telerik:GridTemplateColumn HeaderText ="" ShowFilterIcon="false">   
                 <FilterTemplate >
                  <center> <asp:Button ID="btnSearch" Visible ="false" Text="Tìm" runat="server"/>
                   <asp:ImageButton ID="btnShowAll" runat="server" ImageUrl="../Images/Grid/filterCancel.gif" AlternateText="Xem tất" ToolTip="Xem tất" OnClick="btnShowAll_Click" Style="vertical-align: middle" />
                  </center>
                 </FilterTemplate>
                  <ItemTemplate>
                      <asp:Label ID="lblSTT" runat="server" Text=""></asp:Label>
                </ItemTemplate>
                 <HeaderStyle HorizontalAlign ="Center" Width ="30px" />
                 <ItemStyle HorizontalAlign ="Center" Width ="30px" />
               </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn UniqueName="C_NAME" HeaderText="Tên loại hình doanh nghiệp" ShowFilterIcon ="false"  AllowFiltering ="true" FilterControlWidth ="100%"  AutoPostBackOnFilter ="true" 
                    DataField="C_NAME" SortExpression="C_NAME">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TRANGTHAI" 
                    FilterControlAltText="Filter TRANGTHAI column" HeaderText="Trạng thái" ShowFilterIcon ="false"  AllowFiltering ="true" FilterControlWidth ="100%"  AutoPostBackOnFilter ="true" 
                    ReadOnly="True" SortExpression="TRANGTHAI" UniqueName="TRANGTHAI">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="C_TYPE" Visible ="false" 
                    FilterControlAltText="Filter C_TYPE column" HeaderText="Mã loại hình" ShowFilterIcon ="false"  AllowFiltering ="true" FilterControlWidth ="100%"  AutoPostBackOnFilter ="true" 
                    ReadOnly="True" SortExpression="C_TYPE" UniqueName="C_TYPE">
                </telerik:GridBoundColumn>
        </Columns>
        <EditFormSettings InsertCaption="Thêm loại hình doanh nghiệp mới" CaptionFormatString="Sửa loại hình doanh nghiệp: <b>{0}</b>" CaptionDataField="C_NAME" EditFormType="Template" PopUpSettings-Width="600px">
        <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
           <FormTemplate>
            <div class="headerthongtin">
              <ul>
                <li class="lifirst"><asp:LinkButton ID="btnSave" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'><img src="Images/img_save.jpg" /><%# (Container is GridEditFormInsertItem) ? "Lưu" : "Lưu" %></asp:LinkButton></li>
                     <li><asp:LinkButton ID="btnClose" runat="server" CommandName="Cancel"><img src="Images/img_Close.jpg" />Đóng</asp:LinkButton></li>                     
              </ul>
            </div>               
            <div class="clearfix bgpopup"> 
            <div style="width:600px;background:#FFFFFF" class="clearfix">      
            <table id="tblEdit" class ="TableEditInGrid" cellspacing="3" cellpadding="3" style="width: 100%" border="0">
            <tr>
                 <td style =" width:150px;"> <span class="rtsTxtnew">Loại hình doanh nghiệp:</td>
                <td colspan="4">
                    <asp:HiddenField ID="txtID" Value ='<%# Eval( "PK_ID") %>' runat="server" />
                    <asp:TextBox ID="txtName" Width ="400px" Text='<%# Bind( "C_NAME") %>' runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Tên loại hình doanh nghiệp không thể rỗng" ControlToValidate="txtName" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="cuvName" ControlToValidate="txtName" OnServerValidate="CheckName" runat="server" ErrorMessage="Tên loại hình doanh nghiệp đã tồn tại" Display="Dynamic" ValidationGroup="G1"></asp:CustomValidator>
                </td>
            </tr> 
            <tr>
                 <td style =" width:150px;"> <span class="rtsTxtnew">Trạng thái:</td>
                <td colspan="4">
                    <asp:RadioButtonList ID="txtStatus" runat="server" RepeatDirection="Horizontal" SelectedValue ='<%# Bind( "C_STATUS") %>'>
                        <asp:ListItem Text="" Value ="" style =" display:none;"></asp:ListItem>
                        <asp:ListItem Text ="Đang sử dụng" Value ="1"></asp:ListItem>
                         <asp:ListItem Text ="Đình chỉ" Value ="0"></asp:ListItem>
                    </asp:RadioButtonList>
                 </td>
            </tr> 
             </table>
            </div> 
             </center> 
        <!-- end bgpopup--></div>    
             </FormTemplate>

<PopUpSettings Width="600px"></PopUpSettings>
        </EditFormSettings>
        </MasterTableView>
        <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G1"/>
        <ClientSettings>
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
            <ClientEvents OnPopUpShowing="PopUpShowingSmall" />
            <ClientEvents OnRowDblClick="RowDblClick" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />

<FilterMenu EnableImageSprites="False"></FilterMenu>

<HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Vista"></HeaderContextMenu>
</telerik:RadGrid>
<asp:SqlDataSource ID="LoaiHinhDNDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
        DeleteCommand="DELETE FROM DMLOAIHINHDN WHERE (PK_ID = @PK_ID)" 
        InsertCommand="INSERT INTO DMLOAIHINHDN(C_NAME, C_STATUS, C_TYPE) VALUES (@C_NAME, @C_STATUS, @C_TYPE)"
        SelectCommand="SELECT PK_ID, C_NAME, C_STATUS, (CASE WHEN (C_STATUS = '1') THEN N'Đang sử dụng' ELSE N'Đình chỉ' END) AS TRANGTHAI, C_TYPE FROM DMLOAIHINHDN ORDER BY PK_ID"      
    UpdateCommand="UPDATE DMLOAIHINHDN SET C_NAME = @C_NAME, C_STATUS = @C_STATUS WHERE (PK_ID = @PK_ID)" >
    <DeleteParameters>
        <asp:Parameter Name="PK_ID" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="C_NAME" />
        <asp:Parameter Name="C_STATUS" />
        <asp:Parameter Name="C_TYPE" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="C_NAME" />
        <asp:Parameter Name="C_STATUS" />
        <asp:Parameter Name="PK_ID" />
    </UpdateParameters>
</asp:SqlDataSource>