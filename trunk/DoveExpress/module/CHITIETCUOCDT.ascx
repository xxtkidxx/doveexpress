<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CHITIETCUOCDT.ascx.cs" Inherits="module_CHITIETCUOCDT" %>
<telerik:RadScriptBlock ID="RadScriptBlockCHITIETCUOCDT" runat="server">   
<script type="text/javascript">
    function cmbDoiTacClientSelectedIndexChangedHandler(sender, eventArgs) {
        $find("<%=RadGridCHITIETCUOCDT.ClientID %>").get_masterTableView().rebind();
    }
    function cmbNhomKhachHangClientSelectedIndexChangedHandler(sender, eventArgs) {
        $find("<%=RadGridCHITIETCUOCDT.ClientID %>").get_masterTableView().rebind();
    }
    function cmbSanPhamClientSelectedIndexChangedHandler(sender, eventArgs) {
        $find("<%=RadGridCHITIETCUOCDT.ClientID %>").get_masterTableView().rebind();
    }
    function cmbLoaiTienClientSelectedIndexChangedHandler(sender, eventArgs) {
        $find("<%=RadGridCHITIETCUOCDT.ClientID %>").get_masterTableView().rebind();
    }
</script>
<script type="text/javascript">
        function RowDblClick(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("DANHMUCCHUNG") %>";
            if ((eventArgs.get_tableView().get_name() == "TableViewCHITIETCUOCDT") && (CanEdit == "True")) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
        }
</script>
</telerik:RadScriptBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelCHITIETCUOCDT" runat="server" />
<div style ="width:100%; margin: 10px 10px 10px 10px; ">
Dịch vụ:&nbsp; 
<telerik:RadComboBox ID="cmbSanPham" runat="server"
DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="MASANPHAMDataSource"
ShowToggleImage="True" EmptyMessage="Chọn dịch vụ" 
onclientselectedindexchanged="cmbSanPhamClientSelectedIndexChangedHandler" onprerender="cmbSanPham_PreRender">
</telerik:RadComboBox>
Loại tiền:&nbsp; 
<telerik:RadComboBox ID="cmbLoaiTien" runat="server"
ShowToggleImage="True" EmptyMessage="Chọn loại" onclientselectedindexchanged="cmbLoaiTienClientSelectedIndexChangedHandler" 
onprerender="cmbLoaiTien_PreRender">
<Items>
    <telerik:RadComboBoxItem Value ="VND" Text ="VND" />
    <telerik:RadComboBoxItem Value ="USD" Text ="USD" />
</Items>
</telerik:RadComboBox>
Đối tác:&nbsp; 
<telerik:RadComboBox ID="cmbDoiTac" runat="server" 
DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="DoiTacDataSource"
ShowToggleImage="True" EmptyMessage="Chọn đối tác" 
        onprerender="cmbDoiTac_PreRender" 
        onclientselectedindexchanged="cmbDoiTacClientSelectedIndexChangedHandler">
</telerik:RadComboBox>
</div>
<telerik:RadGrid ID="RadGridCHITIETCUOCDT" runat="server" Skin="Vista" 
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="False" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="MAVUNGDataSource" ShowFooter="True"
    ondatabound="RadGridCHITIETCUOCDT_DataBound" 
    onitemdeleted="RadGridCHITIETCUOCDT_ItemDeleted" oniteminserted="RadGridCHITIETCUOCDT_ItemInserted" 
    onitemupdated="RadGridCHITIETCUOCDT_ItemUpdated" 
    onitemcommand="RadGridCHITIETCUOCDT_ItemCommand" 
    onitemdatabound="RadGridCHITIETCUOCDT_ItemDataBound" CellSpacing="0" 
    onitemcreated="RadGridCHITIETCUOCDT_ItemCreated">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
     <GroupingSettings CaseSensitive ="false"  />
<MasterTableView Name="MasterTableViewMAVUNG" HierarchyDefaultExpanded="false" CommandItemDisplay="Top" DataSourceID="MAVUNGDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="InPlace" NoMasterRecordsText="Không có dữ liệu">
<CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b>Quản lý bảng cước</b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridCHITIETCUOCDT.EditIndexes.Count == 0 && ITCLIB.Security.Security.CanEditModule("DANHMUCCHUNG") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridCHITIETCUOCDT.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Update.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridCHITIETCUOCDT.EditIndexes.Count > 0 || RadGridCHITIETCUOCDT.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridCHITIETCUOCDT.MasterTableView.IsItemInserted && ITCLIB.Security.Security.CanAddModule("DANHMUCCHUNG") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="PerformInsert" Visible='<%# RadGridCHITIETCUOCDT.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Insert.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:return confirm('Bạn có muốn xóa bản ghi đã chọn không?')" runat="server" CommandName="DeleteSelected" Visible='<%# ITCLIB.Security.Security.CanDeleteModule("DANHMUCCHUNG") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Delete.gif" />Xóa</asp:LinkButton>&nbsp;&nbsp;
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
                <telerik:GridBoundColumn UniqueName="PK_ID" DataField="PK_ID" Visible ="false">
                </telerik:GridBoundColumn>
                 <telerik:GridTemplateColumn HeaderText ="" AllowFiltering="false" ShowFilterIcon="false">   
                  <ItemTemplate>
                      <asp:Label ID="lblSTT" runat="server" Text=""></asp:Label>
                </ItemTemplate>
                 <HeaderStyle HorizontalAlign ="Center" Width ="30px" />
                 <ItemStyle HorizontalAlign ="Center" Width ="30px" />
               </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn UniqueName="C_CODE" HeaderText="Mã mã vùng" DataField="C_CODE" AllowFiltering="false">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_NAME" HeaderText="Tên mã vùng" DataField="C_NAME" AllowFiltering="false">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_DESC" HeaderText="Tuyến đường thuộc vùng" DataField="C_DESC" AllowFiltering="false">
                </telerik:GridBoundColumn>
</Columns>
<DetailTables>
    <telerik:GridTableView DataKeyNames="PK_ID,FK_MAVUNG" DataSourceID="CHITIETCUOCDTDataSource" Width="100%" runat="server" CommandItemDisplay="Top" Name="TableViewCHITIETCUOCDT" EditMode="InPlace" NoDetailRecordsText="Không có dữ liệu.">
           <ParentTableRelation>
                 <telerik:GridRelationFields DetailKeyField="FK_MAVUNG" MasterKeyField="PK_ID"></telerik:GridRelationFields>
           </ParentTableRelation>
           <CommandItemTemplate>
               <div style="padding: 5px 5px;float:left;width:auto">
               <b>Chi tiết cước</b>&nbsp;&nbsp;&nbsp;&nbsp;                        
               <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridCHITIETCUOCDT.MasterTableView.IsItemInserted && ITCLIB.Security.Security.CanAddModule("DANHMUCCHUNG")%>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
               <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:return confirm('Bạn có muốn xóa bản ghi đã chọn không?')" runat="server" Visible='<%# ITCLIB.Security.Security.CanDeleteModule("DANHMUCCHUNG")%>' CommandName="DeleteSelected"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Delete.gif" />Xóa</asp:LinkButton>&nbsp;&nbsp;
               </div>                    
            </CommandItemTemplate>
                            <Columns>
                             <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn" HeaderStyle-Width="80px" EditImageUrl="~/images/grid/Edit.gif"></telerik:GridEditCommandColumn>
                            <telerik:GridBoundColumn UniqueName="C_KHOILUONG" HeaderText="Khối lượng" DataField="C_KHOILUONG" AllowFiltering="false"></telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="C_CUOCPHI" DataType="System.Decimal" HeaderText="Cước phí" AllowFiltering="false" UniqueName="C_CUOCPHI">
                                <ItemTemplate>
                                 <telerik:RadNumericTextBox runat="server"  CssClass ="csstextNum" ID="txtC_CUOCPHI" Width="100px" Enabled = "false"  DbValue='<%# Eval("C_CUOCPHI") %>'>
                                    <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="1"/>
                                  </telerik:RadNumericTextBox>
                                </ItemTemplate>
                                <EditItemTemplate>
                                        <telerik:RadNumericTextBox runat="server" ID="txtC_CUOCPHI" DbValue='<%# Bind("C_CUOCPHI") %>'>
                                         <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="1"/>
                                        </telerik:RadNumericTextBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn> 
                            </Columns>
     </telerik:GridTableView>
 </DetailTables>
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
</telerik:RadGrid>
<asp:SqlDataSource ID="CHITIETCUOCDTDataSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>" 
    DeleteCommand="DELETE FROM [DMCHITIETCUOCDT] WHERE [PK_ID] = @PK_ID" 
    InsertCommand="INSERT INTO [DMCHITIETCUOCDT] ([FK_DoiTac], [FK_MASANPHAM], [FK_MAVUNG], [C_LOAITIEN], [C_KHOILUONG], [C_CUOCPHI]) VALUES (@FK_DoiTac, @FK_MASANPHAM, @FK_MAVUNG, @C_LOAITIEN, @C_KHOILUONG, @C_CUOCPHI)" 
    SelectCommand="SELECT [PK_ID], [FK_DoiTac], [FK_MASANPHAM], [FK_MAVUNG], [C_LOAITIEN], [C_KHOILUONG], [C_CUOCPHI] FROM [DMCHITIETCUOCDT] WHERE [FK_MAVUNG] =@FK_MAVUNG AND [FK_DoiTac] = @FK_DoiTac AND [FK_MASANPHAM] = @FK_MASANPHAM AND [C_LOAITIEN] = @C_LOAITIEN" 
    UpdateCommand="UPDATE [DMCHITIETCUOCDT] SET [C_KHOILUONG] = @C_KHOILUONG, [C_CUOCPHI] = @C_CUOCPHI WHERE [PK_ID] = @PK_ID">
    <SelectParameters>
        <asp:Parameter Name="FK_MAVUNG" Type="Int32" />
        <asp:ControlParameter ControlID="cmbDoiTac" DefaultValue="0" Name="FK_DoiTac" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="cmbSanPham" DefaultValue="0" Name="FK_MASANPHAM" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="cmbLoaiTien" DefaultValue="0" Name="C_LOAITIEN" PropertyName="SelectedValue" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="PK_ID" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:ControlParameter ControlID="cmbDoiTac" DefaultValue="0" Name="FK_DoiTac" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="cmbSanPham" DefaultValue="0" Name="FK_MASANPHAM" PropertyName="SelectedValue" />
        <asp:Parameter Name="FK_MAVUNG" Type="Int32" />
         <asp:ControlParameter ControlID="cmbLoaiTien" DefaultValue="0" Name="C_LOAITIEN" PropertyName="SelectedValue" />
        <asp:Parameter Name="C_KHOILUONG" Type="String" />
        <asp:Parameter Name="C_CUOCPHI" Type="Decimal" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="C_KHOILUONG" Type="String" />
        <asp:Parameter Name="C_CUOCPHI" Type="Decimal" />
        <asp:Parameter Name="PK_ID" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="MAVUNGDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
        DeleteCommand="DELETE FROM [DMMAVUNG] WHERE [PK_ID] = @PK_ID" 
        InsertCommand="INSERT INTO [DMMAVUNG] ([C_CODE], [C_NAME], [C_DESC]) VALUES (@C_CODE, @C_NAME, @C_DESC)"
        SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME], [C_DESC] FROM [DMMAVUNG] WHERE FK_MASANPHAM = @FK_MASANPHAM ORDER BY LTRIM([C_CODE])"      
        UpdateCommand="UPDATE [DMMAVUNG] SET [C_CODE] = @C_CODE, [C_NAME] = @C_NAME,[C_DESC] = @C_DESC WHERE [PK_ID] = @PK_ID" >
        <SelectParameters>
            <asp:ControlParameter ControlID="cmbSanPham" DefaultValue="0" Name="FK_MASANPHAM" PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="C_CODE" Type="String" />
            <asp:Parameter Name="C_NAME" Type="String" />
            <asp:Parameter Name="C_DESC" Type="String" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="PK_ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="C_CODE" Type="String" />
            <asp:Parameter Name="C_NAME" Type="String" />
            <asp:Parameter Name="C_DESC" Type="String" />
        </InsertParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="DoiTacDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMDoiTac] ORDER BY LTRIM([C_CODE])">
</asp:SqlDataSource>
<asp:SqlDataSource ID="MASANPHAMDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
        SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMMASANPHAM] ORDER BY LTRIM([C_CODE])">    
</asp:SqlDataSource>