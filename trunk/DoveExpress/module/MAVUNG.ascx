<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MAVUNG.ascx.cs" Inherits="module_MAVUNG" %>
<telerik:RadCodeBlock ID="RadCodeBlockMAVUNG" runat="server">
<script type="text/javascript">
        function RowDblClick(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("Lists") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewMAVUNG") && (CanEdit == "True")) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
        }
</script>
<script type="text/javascript">
    var ListBoxQuanHuyen;
    function OnClientLoadListBoxQuanHuyen(sender) {
        ListBoxQuanHuyen = sender;
    }
    var ListBoxQuanHuyenSelect;
    function OnClientLoadListBoxQuanHuyenSelect(sender) {
        ListBoxQuanHuyenSelect = sender;
    }
    var panelControl;
    function OnClientLoadPanelControl(sender) {
        panelControl = sender;
    }
    function onClientTransferringHandler(sender, e) {
        var itemvalue = e.get_item().get_value();
        if (ListBoxQuanHuyenSelect.findItemByValue(itemvalue) != null) {
            e.set_cancel(true);
        }
    }
    function OnClientDeleteQuanHuyen(sender, e) {
        if (!confirm("Bạn thực sự muốn xóa quận huyện khỏi danh sách chọn?")) {
            e.set_cancel(true);
        }
    }  
</script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelMAVUNG" runat="server" />
<telerik:RadGrid ID="RadGridMAVUNG" runat="server" Skin="Vista" 
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="MAVUNGDataSource" ShowFooter="True"
    ondatabound="RadGridMAVUNG_DataBound" 
    onitemdeleted="RadGridMAVUNG_ItemDeleted" oniteminserted="RadGridMAVUNG_ItemInserted" 
    onitemupdated="RadGridMAVUNG_ItemUpdated" 
    onitemcommand="RadGridMAVUNG_ItemCommand" 
    onitemdatabound="RadGridMAVUNG_ItemDataBound" CellSpacing="0">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
     <GroupingSettings CaseSensitive ="false"  />
    <MasterTableView Name="MasterTableViewMAVUNG" CommandItemDisplay="Top" DataSourceID="MAVUNGDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b>Quản lý vùng tính cước</b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridMAVUNG.EditIndexes.Count == 0 && ITCLIB.Security.Security.CanEditModule("JobLists") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridMAVUNG.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Update.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridMAVUNG.EditIndexes.Count > 0 || RadGridMAVUNG.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridMAVUNG.MasterTableView.IsItemInserted && ITCLIB.Security.Security.CanAddModule("JobLists") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="PerformInsert" Visible='<%# RadGridMAVUNG.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Insert.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:return confirm('Bạn có muốn xóa bản ghi đã chọn không?')" runat="server" CommandName="DeleteSelected" Visible='<%# ITCLIB.Security.Security.CanDeleteModule("JobLists") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Delete.gif" />Xóa</asp:LinkButton>&nbsp;&nbsp;
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
                <telerik:GridBoundColumn UniqueName="C_DESC" HeaderText="Tuyến đường thuộc vùng" DataField="C_DESC" 
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
 <span style =" width :300px; text-align:left; float:left;"> Chọn quận huyện:</span> ||<span style =" width :250px; color: Blue "> Danh sách quận huyện</span>                     
</div>
<div style ="width:98%; background-color:White;padding-left:2px;">
<div style =" width :20%; float :left;"> 
    <telerik:RadPanelBar ID="RadPanelBarTinhThanh" Width ="100%" Height ="200px" 
                        runat="server" ExpandMode="FullExpandedItem"  OnItemClick ="RadPanelBarLoadTextfromDept_ItemClick"
                        Skin ="Vista" DataFieldID="PK_ID"  
                        DataSourceID="SqlDataSourceTINHTHANH" DataTextField="C_NAME"  DataValueField="PK_ID" >
     </telerik:RadPanelBar>    
</div>
<div style =" width :80%; float:right;">
    <telerik:RadListBox ID="RadListBoxQuanHuyen" runat="server" Width ="48%" Height ="200px"  
            SelectionMode="Multiple" AllowTransfer="True" TransferToID="RadListBoxQuanHuyenRef" 
            AutoPostBackOnTransfer="True" AutoPostBackOnReorder="True" EnableDragAndDrop="True" 
            DataKeyField="pk_id" DataSortField="c_signer"  OnClientLoad ="OnClientLoadListBoxQuanHuyen"
            DataSourceID="QuanHuyenDataSource" DataTextField="C_NAME" DataValueField="C_CODE" Skin="Vista" 
           TransferMode="Copy" OnClientTransferring ="onClientTransferringHandler">
           <Localization AllToLeft ="Bỏ chọn tất cả" AllToRight ="Chọn tất cả" Delete ="Xóa" ToLeft ="Bỏ chọn" ToRight ="Chọn"  />
           <ButtonSettings TransferButtons ="TransferFrom,TransferAllFrom" />
        </telerik:RadListBox>
    <telerik:RadListBox ID="RadListBoxQuanHuyenRef" runat="server" Width ="48%" Height ="200px" AllowDelete ="true"  
            SelectionMode="Multiple" AutoPostBackOnReorder="true" EnableDragAndDrop="true"
            OnClientLoad="OnClientLoadListBoxQuanHuyenSelect" Skin="Vista" OnClientDeleting ="OnClientDeleteQuanHuyen">
            <Localization Delete ="Bỏ chọn" />
            <ButtonSettings ShowDelete ="true"  />
     </telerik:RadListBox>
 </div>  
<p style =" height: 26px; line-height :26px; color:Blue;">Ghi chú: Click vào quận huyện trên danh sách trái kéo và thả vào Box phải để chọn</p>
<br />
</div>    
             </center> 
        <!-- end bgpopup--></div>    
             </FormTemplate>
        </EditFormSettings>
        </MasterTableView>
        <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G1"/>
        <ClientSettings AllowKeyboardNavigation="true" KeyboardNavigationSettings-AllowSubmitOnEnter="true">
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
            <ClientEvents OnPopUpShowing="PopUpShowingSmall" />
            <ClientEvents OnRowDblClick="RowDblClick" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<asp:SqlDataSource ID="MAVUNGDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
        DeleteCommand="DELETE FROM [DMMAVUNG] WHERE [PK_ID] = @PK_ID" 
        InsertCommand="INSERT INTO [DMMAVUNG] ([FK_MASANPHAM],[C_CODE], [C_NAME], [C_DESC],[C_TYPE]) VALUES (@FK_MASANPHAM,@C_CODE, @C_NAME, @C_DESC,1)"
        SelectCommand="SELECT [DMMAVUNG].[PK_ID], [DMMAVUNG].[FK_MASANPHAM], [DMMAVUNG].[C_CODE], [DMMAVUNG].[C_NAME], [DMMAVUNG].[C_DESC],DMMASANPHAM.C_NAME as MASANPHAMNAME FROM [DMMAVUNG] LEFT OUTER JOIN DMMASANPHAM ON DMMAVUNG.FK_MASANPHAM = DMMASANPHAM.PK_ID WHERE DMMAVUNG.C_TYPE = 1 ORDER BY DMMAVUNG.PK_ID"      
        UpdateCommand="UPDATE [DMMAVUNG] SET [FK_MASANPHAM] = @FK_MASANPHAM,[C_CODE] = @C_CODE, [C_NAME] = @C_NAME,[C_DESC] = @C_DESC WHERE [PK_ID] = @PK_ID" >
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
        </InsertParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="MASANPHAMDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
        SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMMASANPHAM]  WHERE C_CODE <> 'QT' ORDER BY PK_ID">
</asp:SqlDataSource>
 <asp:SqlDataSource ID="SqlDataSourceTINHTHANH" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [DMTINHTHANH].[PK_ID], [DMTINHTHANH].[C_CODE], [DMTINHTHANH].[C_NAME] FROM [DMTINHTHANH] LEFT OUTER JOIN DMQUOCGIA ON DMTINHTHANH.FK_QUOCGIA = DMQUOCGIA.PK_ID WHERE DMQUOCGIA.C_CODE='VN'">
 </asp:SqlDataSource>
 <asp:SqlDataSource ID="QUANHUYENDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
        SelectCommand="SELECT * FROM [DMQUANHUYEN] where (@FK_TINHTHANH = 0 OR FK_TINHTHANH =@FK_TINHTHANH) ORDER BY LTRIM([C_CODE])">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="0" Name="FK_TINHTHANH" SessionField="ValueFilter"/>
        </SelectParameters>
</asp:SqlDataSource>  

