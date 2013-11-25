<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MAVUNGQT.ascx.cs" Inherits="module_MAVUNGQT" %>
<telerik:RadCodeBlock ID="RadCodeBlockMAVUNGQT" runat="server">
<script type="text/javascript">
        function RowDblClick(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("BANGCUOC") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewMAVUNGQT") && (CanEdit == "True")) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
        }
</script>
<script type="text/javascript">
    var ListBoxQuocGia;
    function OnClientLoadListBoxQuocGia(sender) {
        ListBoxQuocGia = sender;
    }
    var ListBoxQuocGiaSelect;
    function OnClientLoadListBoxQuocGiaSelect(sender) {
        ListBoxQuocGiaSelect = sender;
    }
    var panelControl;
    function OnClientLoadPanelControl(sender) {
        panelControl = sender;
    }
    function onClientTransferringHandler(sender, e) {
        var itemvalue = e.get_item().get_value();
        if (ListBoxQuocGiaSelect.findItemByValue(itemvalue) != null) {
            e.set_cancel(true);
        }
    }
    function OnClientDeleteQuocGia(sender, e) {
        if (!confirm("Bạn thực sự muốn xóa quận huyện khỏi danh sách chọn?")) {
            e.set_cancel(true);
        }
    }  
</script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelMAVUNGQT" runat="server" />
<telerik:RadGrid ID="RadGridMAVUNGQT" runat="server" Skin="Vista" 
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="MAVUNGQTDataSource" ShowFooter="True"
    ondatabound="RadGridMAVUNGQT_DataBound" 
    onitemdeleted="RadGridMAVUNGQT_ItemDeleted" oniteminserted="RadGridMAVUNGQT_ItemInserted" 
    onitemupdated="RadGridMAVUNGQT_ItemUpdated" 
    onitemcommand="RadGridMAVUNGQT_ItemCommand" 
    onitemdatabound="RadGridMAVUNGQT_ItemDataBound" CellSpacing="0">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
     <GroupingSettings CaseSensitive ="false"  />
    <MasterTableView Name="MasterTableViewMAVUNGQT" CommandItemDisplay="Top" DataSourceID="MAVUNGQTDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b>Quản lý vùng tính cước</b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridMAVUNGQT.EditIndexes.Count == 0 && ITCLIB.Security.Security.CanEditModule("BANGCUOC") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridMAVUNGQT.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Update.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridMAVUNGQT.EditIndexes.Count > 0 || RadGridMAVUNGQT.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridMAVUNGQT.MasterTableView.IsItemInserted && ITCLIB.Security.Security.CanAddModule("BANGCUOC") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="PerformInsert" Visible='<%# RadGridMAVUNGQT.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Insert.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:return confirm('Bạn có muốn xóa bản ghi đã chọn không?')" runat="server" CommandName="DeleteSelected" Visible='<%# ITCLIB.Security.Security.CanDeleteModule("BANGCUOC") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Delete.gif" />Xóa</asp:LinkButton>&nbsp;&nbsp;
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
                <telerik:GridBoundColumn UniqueName="MASANPHAMNAME" HeaderText="Dịch vụ" DataField="MASANPHAMNAME" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_CODE" HeaderText="Mã vùng tính cước" DataField="C_CODE" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_NAME" HeaderText="Tên vùng tính cước" DataField="C_NAME" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
        </Columns>
        <EditFormSettings InsertCaption="Thêm vùng tính cước mới" CaptionFormatString="Sửa vùng tính cước: <b>{0}</b>" CaptionDataField="C_NAME" EditFormType="Template" PopUpSettings-Width="600px">
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
                <td style =" width:150px;"> <span class="rtsTxtnew">Tên dịch vụ:</td>
                <td colspan="4">
                   <telerik:RadComboBox ID="cmbSanPham" runat="server" SelectedValue='<%# Bind("FK_MASANPHAM") %>'
                    DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="MASANPHAMDataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn dịch vụ">
                    </telerik:RadComboBox>
                   <asp:RequiredFieldValidator ID="rfvMASANPHAM" runat="server" ErrorMessage="Dịch vụ không thể rỗng" ControlToValidate="txtName" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>                   
                </td>
            </tr>
            <tr>
                 <td style =" width:150px;"> <span class="rtsTxtnew">Mã vùng tính cước:</td>
                <td colspan="4">
                    <asp:HiddenField ID="txtID" Value ='<%# Eval( "PK_ID") %>' runat="server" />
                    <asp:HiddenField ID="txtC_DESC" Value ='<%# Eval( "C_DESC") %>' runat="server" />
                    <telerik:RadTextBox ID="txtCODE" Width ="90%" Text='<%# Bind( "C_CODE") %>' runat="server"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="rfvCODE" runat="server" ErrorMessage="Mã vùng tính cước không thể rỗng" ControlToValidate="txtCODE" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="cuvCODE" ControlToValidate="txtCODE" OnServerValidate="CheckCode" runat="server" ErrorMessage="Mã vùng tính cước đã tồn tại" Display="Dynamic" ValidationGroup="G1"></asp:CustomValidator>
                </td>
            </tr> 
            <tr>
                 <td style =" width:150px;"> <span class="rtsTxtnew">Tên vùng tính cước:</td>
                <td colspan="4">
                   <telerik:RadTextBox ID="txtName" Text='<%# Bind( "C_NAME") %>' runat="server" Width="90%"></telerik:RadTextBox>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Tên vùng tính cước không thể rỗng" ControlToValidate="txtName" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
                   <asp:CustomValidator ID="CustomValidator1" ControlToValidate="txtName" OnServerValidate="CheckName" runat="server" ErrorMessage="Tên vùng tính cước đã tồn tại" Display="Dynamic" ValidationGroup="G1"></asp:CustomValidator>
                </td>
            </tr>
             </table>
            </div>
<div class ="headerthongtin" id ="Div2">
 <span style =" width :300px; text-align:left; float:left;"> Chọn quốc gia:</span> ||<span style =" width :250px; color: Blue "> Danh sách quốc gia</span>                     
</div>
<telerik:RadSplitter ID="RadSplitterQuocGia" runat="server" Width="100%" Height ="250px">
<telerik:RadPane ID="LeftPaneQuocGia" runat="server" Width="20%">
<telerik:RadPanelBar ID="RadPanelBarKhuVuc" Width ="100%" Height ="200px" 
runat="server" ExpandMode="FullExpandedItem"  OnItemClick ="RadPanelBarLoadTextfromDept_ItemClick"
Skin ="Vista" DataFieldID="PK_ID" AppendDataBoundItems="True" DataSourceID="SqlDataSourceKHUVUC" DataTextField="C_NAME"  DataValueField="PK_ID" >
<Items> 
<telerik:RadPanelItem runat="server" Text="Tất cả" Value="0">  
</telerik:RadPanelItem> 
</Items> 
</telerik:RadPanelBar>    
 </telerik:RadPane>
<telerik:RadSplitBar ID="RadSplitBarQuocGia" runat="server" CollapseMode="Forward" />
<telerik:RadPane ID="MiddlePaneQuocGia" runat="server" Width="79%">
    <telerik:RadListBox ID="RadListBoxQuocGia" runat="server" Width ="48%" Height ="200px"  
            SelectionMode="Multiple" AllowTransfer="True" TransferToID="RadListBoxQuocGiaRef" 
            AutoPostBackOnTransfer="True" AutoPostBackOnReorder="True" EnableDragAndDrop="True" 
            DataKeyField="pk_id" DataSortField="c_signer"  OnClientLoad ="OnClientLoadListBoxQuocGia"
            DataSourceID="QuocGiaDataSource" DataTextField="C_NAME" DataValueField="C_CODE" Skin="Vista" 
           TransferMode="Copy" OnClientTransferring ="onClientTransferringHandler">
           <Localization AllToLeft ="Bỏ chọn tất cả" AllToRight ="Chọn tất cả" Delete ="Xóa" ToLeft ="Bỏ chọn" ToRight ="Chọn"  />
           <ButtonSettings TransferButtons ="TransferFrom,TransferAllFrom" />
        </telerik:RadListBox>
    <telerik:RadListBox ID="RadListBoxQuocGiaRef" runat="server" Width ="48%" Height ="200px" AllowDelete ="true"  
            SelectionMode="Multiple" AutoPostBackOnReorder="true" EnableDragAndDrop="true"
            OnClientLoad="OnClientLoadListBoxQuocGiaSelect" Skin="Vista" OnClientDeleting ="OnClientDeleteQuocGia">
            <Localization Delete ="Bỏ chọn" />
            <ButtonSettings ShowDelete ="true"  />
     </telerik:RadListBox>
<p style =" height: 26px; line-height :26px; color:Blue;">Ghi chú: Click vào quốc gia trên danh sách trái kéo và thả vào Box phải để chọn</p>
</telerik:RadPane>
 </telerik:RadSplitter> 
             </center> 
        <!-- end bgpopup--></div>    
             </FormTemplate>
        </EditFormSettings>
        </MasterTableView>
        <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G1"/>
        <ClientSettings AllowKeyboardNavigation="true" KeyboardNavigationSettings-AllowSubmitOnEnter="true" ClientEvents-OnKeyPress="KeyPressed">
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
            <ClientEvents OnPopUpShowing="PopUpShowingSmall" />
            <ClientEvents OnRowDblClick="RowDblClick" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<asp:SqlDataSource ID="MAVUNGQTDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
        DeleteCommand="DELETE FROM [DMMAVUNG] WHERE [PK_ID] = @PK_ID" 
        InsertCommand="INSERT INTO [DMMAVUNG] ([FK_MASANPHAM],[C_CODE], [C_NAME], [C_DESC],[C_TYPE],[FK_VUNGLAMVIEC]) VALUES (@FK_MASANPHAM,@C_CODE, @C_NAME, @C_DESC,2,@FK_VUNGLAMVIEC)"
        SelectCommand="SELECT [DMMAVUNG].[PK_ID], [DMMAVUNG].[FK_MASANPHAM], [DMMAVUNG].[C_CODE], [DMMAVUNG].[C_NAME], [DMMAVUNG].[C_DESC],DMMASANPHAM.C_NAME as MASANPHAMNAME FROM [DMMAVUNG] LEFT OUTER JOIN DMMASANPHAM ON DMMAVUNG.FK_MASANPHAM = DMMASANPHAM.PK_ID WHERE DMMAVUNG.C_TYPE = 2 AND DMMAVUNG.FK_VUNGLAMVIEC = @FK_VUNGLAMVIEC ORDER BY DMMAVUNG.PK_ID"      
        UpdateCommand="UPDATE [DMMAVUNG] SET [FK_MASANPHAM] = @FK_MASANPHAM,[C_CODE] = @C_CODE, [C_NAME] = @C_NAME,[C_DESC] = @C_DESC WHERE [PK_ID] = @PK_ID" >
        <SelectParameters>
            <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="FK_MASANPHAM" Type="Int32" />
            <asp:Parameter Name="C_CODE" Type="String" />
            <asp:Parameter Name="C_NAME" Type="String" />
            <asp:Parameter Name="C_DESC" Type="String" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="PK_ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="FK_MASANPHAM" Type="Int32" />
            <asp:Parameter Name="C_CODE" Type="String" />
            <asp:Parameter Name="C_NAME" Type="String" />
            <asp:Parameter Name="C_DESC" Type="String" />
            <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
        </InsertParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="MASANPHAMDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
        SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMMASANPHAM]  WHERE C_TYPE = N'Quốc tế' ORDER BY PK_ID">
</asp:SqlDataSource>
 <asp:SqlDataSource ID="SqlDataSourceKHUVUC" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMKHUVUC]">
 </asp:SqlDataSource> 
 <asp:SqlDataSource ID="QUOCGIADataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
        SelectCommand="SELECT * FROM [DMQUOCGIA] where (@FK_KHUVUC = 0 OR FK_KHUVUC =@FK_KHUVUC) ORDER BY LTRIM([PK_ID])">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="0" Name="FK_KHUVUC" SessionField="ValueFilter"/>
        </SelectParameters>
</asp:SqlDataSource>  

