<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NHANGUIDVPT.ascx.cs" Inherits="module_NHANGUIDVPT" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxProxyNHANGUIDVPT" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGridNHANGUIDVPT">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridNHANGUIDVPT" LoadingPanelID="RadAjaxLoadingPanelNHANGUIDVPT" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel Skin="Windows7" ID="RadAjaxLoadingPanelNHANGUIDVPT" runat="server" />
<telerik:RadGrid ID="RadGridNHANGUIDVPT" runat="server" Skin="Windows7"
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="true"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="NHANGUIDVPTsDataSource" ShowFooter="True"
    ondatabound="RadGridNHANGUIDVPT_DataBound" 
    onitemdeleted="RadGridNHANGUIDVPT_ItemDeleted" oniteminserted="RadGridNHANGUIDVPT_ItemInserted" 
    onitemupdated="RadGridNHANGUIDVPT_ItemUpdated" 
    onitemcommand="RadGridNHANGUIDVPT_ItemCommand" 
    onitemdatabound="RadGridNHANGUIDVPT_ItemDataBound">
     <GroupingSettings CaseSensitive ="false"/>
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
    <MasterTableView Name="MasterTableViewNHANGUIDVPT" CommandItemDisplay="Top" DataSourceID="NHANGUIDVPTsDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="InPlace" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b>Chi tiết dịch vụ phụ trội</b>&nbsp;&nbsp;&nbsp;&nbsp;       
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridNHANGUIDVPT.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;                 
                        <asp:LinkButton ID="LinkButton4" runat="server" CommandName="RebindGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Refresh.gif" />Làm mới</asp:LinkButton>
                    </div>
        </CommandItemTemplate>
        <Columns>
                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditColumn" HeaderStyle-Width ="60px">
                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </telerik:GridEditCommandColumn>
                <telerik:GridButtonColumn HeaderStyle-Width ="40px" ConfirmText="Bạn muốn xóa chi tiết nguồn vốn?" ConfirmTitle="Xóa" ButtonType="ImageButton" CommandName="Delete" Text="Xóa" UniqueName="DeleteColumn">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </telerik:GridButtonColumn>    
                <telerik:GridBoundColumn UniqueName="PK_ID" HeaderText="ID" DataField="PK_ID" Visible="false">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn HeaderText="Dịch vụ" HeaderStyle-Width ="200px" SortExpression="FK_DICHVU" UniqueName="FK_DICHVU" DataField="FK_DICHVU" AllowFiltering ="false">
                    <ItemTemplate>
                        <%# Eval("FK_DICHVU")%>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <span>
                            <telerik:RadComboBox ID="cmbFK_DICHVU" SelectedValue='<%# Bind("FK_DICHVU") %>' runat="server" EmptyMessage="Chọn">
                            <Items>
                                <telerik:RadComboBoxItem Value ="Đóng gói" Text ="Đóng gói" />
                                <telerik:RadComboBoxItem Value ="Khai giá" Text ="Khai giá" />
                                <telerik:RadComboBoxItem Value ="COD" Text ="COD" />
                                <telerik:RadComboBoxItem Value ="Khác" Text ="Khác" />
                            </Items>
                            </telerik:RadComboBox>
                        </span>
                    </EditItemTemplate>
                 </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Giá tiền" SortExpression="C_GIATIEN" UniqueName="C_GIATIEN" AllowFiltering ="false">
                    <ItemTemplate>
                        <telerik:RadNumericTextBox  ID="txtC_GIATIEN" Runat="server" Enabled ="false"  CssClass ="csstextNum" Text ='<%#Eval("C_GIATIEN")%>' Width="100px">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                        </telerik:RadNumericTextBox>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <span>
                            <telerik:RadNumericTextBox  ID="txtC_GIATIEN" Runat="server" Text ='<%#Bind("C_GIATIEN")%>' Width="120px">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                            </telerik:RadNumericTextBox>
                            <span style="color: Red"><asp:RequiredFieldValidator ID="RequiredFieldValidatorC_GIATIEN"
                                ControlToValidate="txtC_GIATIEN" ErrorMessage="Giá tiền ko thể rỗng" runat="server" setFocusOnError="True" Display="Dynamic" ValidationGroup="G2"></asp:RequiredFieldValidator>
                            </span>
                        </span>
                    </EditItemTemplate>
                    <FooterTemplate>
                           <telerik:RadNumericTextBox runat="server" Enabled ="false"  CssClass ="csstextNum" ID="lblTongtien" Width="100px">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                            </telerik:RadNumericTextBox>
                    </FooterTemplate>
                 </telerik:GridTemplateColumn>     
        </Columns>
        </MasterTableView>
        <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G2"/>
        <ClientSettings AllowKeyboardNavigation="true" KeyboardNavigationSettings-AllowSubmitOnEnter="true"></ClientSettings> 
        <ClientSettings>
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True"/>
         </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<asp:SqlDataSource ID="NHANGUIDVPTsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
        DeleteCommand="DELETE FROM DICHVUPT WHERE PK_ID = @PK_ID" 
        InsertCommand="INSERT INTO DICHVUPT (FK_NHANGUI,FK_DICHVU,C_GIATIEN,C_TYPE) VALUES (@FK_NHANGUI,@FK_DICHVU,@C_GIATIEN,1);SELECT @NEWIDDVPT = SCOPE_IDENTITY()"
        SelectCommand="SELECT DICHVUPT.PK_ID,DICHVUPT.FK_NHANGUI,DICHVUPT.FK_DICHVU,DICHVUPT.C_GIATIEN FROM DICHVUPT WHERE FK_NHANGUI=@FK_NHANGUI AND C_TYPE=1"        
        UpdateCommand="UPDATE DICHVUPT SET FK_DICHVU=@FK_DICHVU,C_GIATIEN=@C_GIATIEN WHERE PK_ID = @PK_ID" 
        oninserted="NHANGUIDVPTsDataSource_Inserted">
        <UpdateParameters>
            <asp:Parameter Name="FK_DICHVU" Type="Int32" />
            <asp:Parameter Name="C_GIATIEN" Type="String" />
        </UpdateParameters>
        <SelectParameters>
           <asp:ControlParameter Name="FK_NHANGUI" Type="Int32" ControlID="txtID" DefaultValue="0"/>
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="PK_ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>      
            <asp:Parameter Name="FK_DICHVU" Type="Int32" />
            <asp:Parameter Name="C_GIATIEN" Type="String" />
            <asp:ControlParameter Name="FK_NHANGUI" Type="Int32" ControlID="txtID" DefaultValue="0"/>
            <asp:Parameter Name="NEWIDDVPT" Type="Int32" Direction="Output" DefaultValue="0"/>
        </InsertParameters>
</asp:SqlDataSource>