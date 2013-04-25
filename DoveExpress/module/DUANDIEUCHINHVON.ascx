<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DUANDIEUCHINHVON.ascx.cs" Inherits="module_DUANDIEUCHINHVON" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxProxyDUANDIEUCHINHVON" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGridDUANDIEUCHINHVON">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridDUANDIEUCHINHVON" LoadingPanelID="RadAjaxLoadingPanelDUANDIEUCHINHVON" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel Skin="Windows7" ID="RadAjaxLoadingPanelDUANDIEUCHINHVON" runat="server" />
<telerik:RadGrid ID="RadGridDUANDIEUCHINHVON" runat="server" Skin="Windows7"
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="true"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="DUANDIEUCHINHVONsDataSource" ShowFooter="True"
    ondatabound="RadGridDUANDIEUCHINHVON_DataBound" 
    onitemdeleted="RadGridDUANDIEUCHINHVON_ItemDeleted" oniteminserted="RadGridDUANDIEUCHINHVON_ItemInserted" 
    onitemupdated="RadGridDUANDIEUCHINHVON_ItemUpdated" 
    onitemcommand="RadGridDUANDIEUCHINHVON_ItemCommand" 
    onitemdatabound="RadGridDUANDIEUCHINHVON_ItemDataBound">
     <GroupingSettings CaseSensitive ="false"  />
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
    <MasterTableView Name="MasterTableViewDUANDIEUCHINHVON" CommandItemDisplay="Top" DataSourceID="DUANDIEUCHINHVONsDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="InPlace" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b>Chi tiết nguồn vốn</b>&nbsp;&nbsp;&nbsp;&nbsp;       
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridDUANDIEUCHINHVON.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;                 
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
                <telerik:GridTemplateColumn HeaderText="Nguồn vốn" HeaderStyle-Width ="200px" SortExpression="NGUONVON" UniqueName="NGUONVON" DataField="NGUONVON" AllowFiltering ="false">
                    <ItemTemplate>
                        <%# Eval("NGUONVON") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <span>
                            <telerik:RadComboBox ID="cmbFK_NGUONVON" SelectedValue='<%# Bind("FK_NGUONVON") %>' runat="server" EmptyMessage="Chọn" DataSourceID="NGUONVONDataSource" DataTextField="C_NAME" DataValueField="PK_ID"></telerik:RadComboBox>
                        </span>
                    </EditItemTemplate>
                 </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Tổng tiền" SortExpression="TONGTIEN" UniqueName="TONGTIEN" AllowFiltering ="false">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblTONGTIEN" Text='<%# Eval("TONGTIEN", "{0:####.## VNĐ}") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <span>
                            <telerik:RadNumericTextBox runat="server" ID="tbTONGTIEN" Width="100px" DbValue='<%# Bind("TONGTIEN") %>' NumberFormat-DecimalDigits=0></telerik:RadNumericTextBox>
                            <span style="color: Red"><asp:RequiredFieldValidator ID="RequiredFieldValidatorTONGTIEN"
                                ControlToValidate="tbTONGTIEN" ErrorMessage="Tổng tiền ko thể rỗng" runat="server" setFocusOnError="True" Display="Dynamic" ValidationGroup="G2"></asp:RequiredFieldValidator>
                            </span>
                        </span>
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
<asp:SqlDataSource ID="DUANDIEUCHINHVONsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
        DeleteCommand="DELETE FROM DUANDIEUCHINHVON WHERE PK_ID = @PK_ID" 
        InsertCommand="INSERT INTO DUANDIEUCHINHVON (FK_NGUONVON,TONGTIEN,FK_DUAN) VALUES (@FK_NGUONVON,@TONGTIEN,@FK_DUAN);SELECT @NEWIDDCVON = SCOPE_IDENTITY()"
        SelectCommand="SELECT DUANDIEUCHINHVON.PK_ID,DUANDIEUCHINHVON.FK_NGUONVON,DUANDIEUCHINHVON.TONGTIEN,DMNGUONVON.C_NAME as NGUONVON FROM DUANDIEUCHINHVON LEFT OUTER JOIN DMNGUONVON ON DMNGUONVON.PK_ID = DUANDIEUCHINHVON.FK_NGUONVON WHERE FK_DUAN=@FK_DUAN"
        
    UpdateCommand="UPDATE DUANDIEUCHINHVON SET FK_NGUONVON=@FK_NGUONVON,TONGTIEN=@TONGTIEN WHERE PK_ID = @PK_ID" 
    oninserted="DUANDIEUCHINHVONsDataSource_Inserted">
        <UpdateParameters>
            <asp:Parameter Name="FK_NGUONVON" Type="Int32" />
            <asp:Parameter Name="TONGTIEN" Type="String" />
        </UpdateParameters>
        <SelectParameters>
           <asp:ControlParameter Name="FK_DUAN" Type="Int32" ControlID="txtID" DefaultValue="0"/>
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="PK_ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>      
            <asp:Parameter Name="FK_NGUONVON" Type="Int32" />
            <asp:Parameter Name="TONGTIEN" Type="String" />
            <asp:ControlParameter Name="FK_DUAN" Type="Int32" ControlID="txtID" DefaultValue="0"/>
            <asp:Parameter Name="NEWIDDCVON" Type="Int32" Direction="Output" DefaultValue="0"/>
        </InsertParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="NGUONVONDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
   SelectCommand="SELECT DMNGUONVON.PK_ID,DMNGUONVON.C_NAME,DMNGUONVON.C_DESC FROM DMNGUONVON">
</asp:SqlDataSource>
