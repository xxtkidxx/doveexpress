<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Doanhnghiep_Nganhnge.ascx.cs" Inherits="module_Doanhnghiep_Nganhnge" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxProxyDUANVON" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGridDoanhnghiep_NganhngheDKSXKD">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridDoanhnghiep_NganhngheDKSXKD" LoadingPanelID="RadAjaxLoadingPanelDUANVON" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel Skin="Windows7" ID="RadAjaxLoadingPanelDUANVON" runat="server" />
<telerik:RadGrid ID="RadGridDoanhnghiep_NganhngheDKSXKD" runat="server" Skin="Windows7"
    AllowPaging="false" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="false" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="DoanhNghiep_NganhngheDataSource" ShowFooter="True"
    ondatabound="RadGridDoanhnghiep_NganhngheDKSXKD_DataBound" 
    onitemdeleted="RadGridDoanhnghiep_NganhngheDKSXKD_ItemDeleted" oniteminserted="RadGridDoanhnghiep_NganhngheDKSXKD_ItemInserted" 
    onitemupdated="RadGridDoanhnghiep_NganhngheDKSXKD_ItemUpdated" 
    onitemcommand="RadGridDoanhnghiep_NganhngheDKSXKD_ItemCommand" 
    onitemdatabound="RadGridDoanhnghiep_NganhngheDKSXKD_ItemDataBound" 
    CellSpacing="0">
     <GroupingSettings CaseSensitive ="false"  />
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
    <MasterTableView Name="MasterTableViewDUANVON" CommandItemDisplay="Top" DataSourceID="DoanhNghiep_NganhngheDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="InPlace" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridDoanhnghiep_NganhngheDKSXKD.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;                 
                        <asp:LinkButton ID="LinkButton4" runat="server" CommandName="RebindGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Refresh.gif" />Làm mới</asp:LinkButton>
                    </div>
        </CommandItemTemplate>
                <Columns>
                <telerik:GridBoundColumn UniqueName="PK_ID" HeaderText="" DataField="PK_ID" Visible ="false"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="FK_NGANHNGHE" HeaderText="" DataField="FK_NGANHNGHE" Visible ="false"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn HeaderText ="" ShowFilterIcon="false">   
                  <ItemTemplate>
                      <asp:Label ID="lblSTT" runat="server" Text=""></asp:Label>
                </ItemTemplate>
                <EditItemTemplate></EditItemTemplate>
                 <HeaderStyle HorizontalAlign ="Center" Width ="30px" />
                 <ItemStyle HorizontalAlign ="Center" Width ="30px" />
               </telerik:GridTemplateColumn>
               <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditColumn" HeaderStyle-Width ="60px">
                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </telerik:GridEditCommandColumn>
                <telerik:GridButtonColumn HeaderStyle-Width ="40px" ConfirmText="Bạn muốn xóa chi tiết nguồn vốn?" ConfirmTitle="Xóa" ButtonType="ImageButton" CommandName="Delete" Text="Xóa" UniqueName="DeleteColumn">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </telerik:GridButtonColumn> 
               <telerik:GridTemplateColumn UniqueName="C_CODE" HeaderText="Mã ngành" DataField="C_CODE" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                 <ItemTemplate>
                <%#Eval("C_CODE") %>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:HiddenField ID="txtID" Value ='<%#Eval("PK_ID") %>' runat="server" />
                </EditItemTemplate>
                </telerik:GridTemplateColumn>
               <telerik:GridTemplateColumn UniqueName="C_NAME" HeaderText="Ngành nghề kinh doanh" DataField="C_NAME" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                <ItemTemplate>
                <%#Eval("C_NAME") %>
                </ItemTemplate>
                <EditItemTemplate>
                 Ngành nghề đăng ký <telerik:RadComboBox ID="radNganhnghe" Width ="300px" DataSourceID ="NganhgheSqlDataSource" DataTextField ="NAMEDN" DataValueField ="PK_ID" 
                     Filter ="Contains" EmptyMessage ="Chọn nghành nghề" SelectedValue ='<%# Bind("FK_NGANHNGHE") %>' runat="server">
                </telerik:RadComboBox>
                </EditItemTemplate>
                </telerik:GridTemplateColumn>                
                <telerik:GridTemplateColumn UniqueName="C_STATUS" HeaderText="Ngành SXKD chính" DataField="C_STATUS" 
                 AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
               <ItemTemplate>
                <asp:CheckBox ID ="chkStatus" Enabled ="false" Checked ='<%#getstauts(Eval("C_STATUS")) %>' runat="server"></asp:CheckBox>
               </ItemTemplate>
               <EditItemTemplate>
                <asp:CheckBox ID ="chkStatus" Checked ='<%#getstauts(Eval("C_STATUS")) %>' runat="server"></asp:CheckBox>
               </EditItemTemplate>
                </telerik:GridTemplateColumn>
        </Columns>
        </MasterTableView>
        <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G2"/>
        <ClientSettings AllowKeyboardNavigation="true" KeyboardNavigationSettings-AllowSubmitOnEnter="true"></ClientSettings> 
        <ClientSettings>
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True"/>
            <ClientEvents OnPopUpShowing="PopUpShowing"/>
         </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<asp:SqlDataSource ID="DoanhNghiep_NganhngheDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
        DeleteCommand="DELETE FROM [DOANHNGHIEP_NGANHNGHESXKD] WHERE [PK_ID] = @PK_ID" 
        InsertCommand="INSERT INTO [DOANHNGHIEP_NGANHNGHESXKD] ([FK_DOANHNGHIEP], [FK_NGANHNGHE], [C_STATUS]) VALUES (@FK_DOANHNGHIEP, @FK_NGANHNGHE, @C_STATUS);SELECT @NEWIDDK = SCOPE_IDENTITY()"
        SelectCommand="SELECT DOANHNGHIEP_NGANHNGHESXKD.PK_ID, DOANHNGHIEP_NGANHNGHESXKD.FK_DOANHNGHIEP, DOANHNGHIEP_NGANHNGHESXKD.FK_NGANHNGHE, DOANHNGHIEP_NGANHNGHESXKD.C_STATUS, DMNGANHNGHEKD.C_NAME, DMNGANHNGHEKD.C_CODE FROM DOANHNGHIEP_NGANHNGHESXKD INNER JOIN DMNGANHNGHEKD ON DOANHNGHIEP_NGANHNGHESXKD.FK_NGANHNGHE = DMNGANHNGHEKD.PK_ID WHERE (DOANHNGHIEP_NGANHNGHESXKD.FK_DOANHNGHIEP = @FK_DOANHNGHIEP)"
        
    
    UpdateCommand="UPDATE [DOANHNGHIEP_NGANHNGHESXKD] SET [FK_NGANHNGHE] = @FK_NGANHNGHE, [C_STATUS] = @C_STATUS WHERE [PK_ID] = @PK_ID" 
    oninserted="DoanhNghiep_NganhngheDataSource_Inserted" >
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="FK_DOANHNGHIEP" 
                SessionField="txtID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="FK_NGANHNGHE" Type="Int32" />
            <asp:Parameter Name="C_STATUS" Type="Boolean" />
            <asp:Parameter Name="PK_ID" Type="Int32" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="PK_ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>      
            <asp:SessionParameter DefaultValue="-1" Name="FK_DOANHNGHIEP" 
                SessionField="txtID" />
            <asp:Parameter Name="FK_NGANHNGHE" Type="Int32" />
            <asp:Parameter Name="C_STATUS" Type="Boolean"/>
            <asp:Parameter Name="NEWIDDK" Type="Int32" Direction="Output" DefaultValue="0"/>
        </InsertParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="NganhgheSqlDataSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>" 
    SelectCommand="SELECT PK_ID, C_CODE +' || ' + C_NAME AS NAMEDN, C_NAME FROM [DMNGANHNGHEKD] ORDER BY [C_NAME], [PK_ID]"></asp:SqlDataSource>


