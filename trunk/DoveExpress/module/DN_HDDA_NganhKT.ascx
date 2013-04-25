<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DN_HDDA_NganhKT.ascx.cs" Inherits="module_DN_HDDA_NganhKT" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxProxyHDDA_NganhKT" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGridDoanhnghiep_HDDA_NganhKT">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridDoanhnghiep_HDDA_NganhKT" LoadingPanelID="RadAjaxLoadingPanelHDDA_NganhKT" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<%--Lấy 175 cố định cho tiêu chí : Hoạt động dự án _ Doanh thu thuần chia theo dự án--%>

<telerik:RadAjaxLoadingPanel Skin="Windows7" ID="RadAjaxLoadingPanelHDDA_NganhKT" runat="server" />

<telerik:RadGrid ID="RadGridDoanhnghiep_HDDA_NganhKT" runat="server" Skin="Windows7"
    AllowPaging="false" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="false" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"   ShowHeader ="false" 
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="HDDA_NganhKTDataSource" ShowFooter="True"
    ondatabound="RadGridDoanhnghiep_HDDA_NganhKT_DataBound" 
    onitemdeleted="RadGridDoanhnghiep_HDDA_NganhKT_ItemDeleted" oniteminserted="RadGridDoanhnghiep_HDDA_NganhKT_ItemInserted" 
    onitemupdated="RadGridDoanhnghiep_HDDA_NganhKT_ItemUpdated" 
    onitemcommand="RadGridDoanhnghiep_HDDA_NganhKT_ItemCommand" 
    onitemdatabound="RadGridDoanhnghiep_HDDA_NganhKT_ItemDataBound" 
    CellSpacing="0" ItemStyle-BorderColor="Blue" ItemStyle-BorderWidth="1px" ItemStyle-BorderStyle="Solid">
     <GroupingSettings CaseSensitive ="false"  />
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
    <MasterTableView Name="MasterTableViewHDDA_NganhKT" CommandItemDisplay="Top" DataSourceID="HDDA_NganhKTDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="InPlace" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridDoanhnghiep_HDDA_NganhKT.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;                 
                        <asp:LinkButton ID="LinkButton4" runat="server" CommandName="RebindGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Refresh.gif" />Làm mới</asp:LinkButton>
                    </div>
        </CommandItemTemplate>
                <Columns>
<telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditColumn" HeaderStyle-Width ="60px">
                <ItemStyle HorizontalAlign="Center" Width ="60px"></ItemStyle>
                </telerik:GridEditCommandColumn>
<telerik:GridButtonColumn HeaderStyle-Width ="40px" ConfirmText="Bạn muốn xóa?" ConfirmTitle="Xóa" ButtonType="ImageButton" CommandName="Delete" Text="Xóa" UniqueName="DeleteColumn">
                    <ItemStyle HorizontalAlign="Center" Width ="40px"></ItemStyle>
                </telerik:GridButtonColumn> 
 <telerik:GridBoundColumn DataField="PK_ID" Visible ="false" UniqueName="PK_ID" DataType="System.Int64"></telerik:GridBoundColumn>
     <telerik:GridTemplateColumn DataField="VALUE9" ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter VALUE9 column" HeaderText="Tên công trình" HeaderStyle-Width ="300px" 
        SortExpression="VALUE9" UniqueName="VALUE9">   
        <ItemStyle Width="300px" />
     <ItemTemplate>
           <%#Eval("VALUE9")%>
      </ItemTemplate>
      <InsertItemTemplate>
           <telerik:RadComboBox ID="txtVALUE9" EmptyMessage ="Chọn ngành nghề kinh tế" Width ="290px" runat="server" SelectedValue ='<%#Bind("VALUE9")%>' AppendDataBoundItems ="true">
          <Items>
                <telerik:RadComboBoxItem Text ="Nông nghiệp và lâm nghiệp" Value ="1" />
                <telerik:RadComboBoxItem Text ="Thủy sản" Value ="2" />
                <telerik:RadComboBoxItem Text ="Công nghiệp khai thác mỏ" Value ="3" />
                <telerik:RadComboBoxItem Text ="Công nghiệp chế biến" Value ="4" />
                <telerik:RadComboBoxItem Text ="Sản xuất và phân phối điện, khí đốt và nước" Value ="5" />
                <telerik:RadComboBoxItem Text ="Xây dựng" Value ="6" />
                <telerik:RadComboBoxItem Text ="Thương nghiệp, sữa chữa xe có động cơ, mô tô, xe máy đồ dùng cá nhân và gia đình" Value ="7" />
                <telerik:RadComboBoxItem Text ="Khách sạn và nhà hàng" Value ="8" />
                <telerik:RadComboBoxItem Text ="Vận tải, kho bãi và thông tin liên lạc" Value ="9" />
                <telerik:RadComboBoxItem Text ="Tài chính, tín dụng" Value ="10" />
                <telerik:RadComboBoxItem Text ="Hoạt động khoa học và công nghệ" Value ="11" />
                <telerik:RadComboBoxItem Text ="Các hoạt động liên quan đến kinh doanh tài sản và dịch vụ tư vấn" Value ="12" />
                <telerik:RadComboBoxItem Text ="Quản lý nhà nước và an ninh quốc phòng bảo đảm xã  hội bắt buộc" Value ="13" />
                <telerik:RadComboBoxItem Text ="Giáo dục và đào tạo" Value ="14" />
                <telerik:RadComboBoxItem Text ="Y tế và hoạt động cứu trợ xã hội" Value ="15" />
                <telerik:RadComboBoxItem Text ="Hoạt động văn hóa thể thao" Value ="16" />
                <telerik:RadComboBoxItem Text ="Hoạt động Đảng, Đoàn thể và hiệp hội" Value ="14" />
                <telerik:RadComboBoxItem Text ="Hoạt động phục vụ cá nhân và cộng đồng " Value ="15" />
                <telerik:RadComboBoxItem Text ="Hoạt động của các tổ chức và đoàn thể quốc tế" Value ="16" />
          </Items>
          </telerik:RadComboBox>
          <asp:RequiredFieldValidator ForeColor ="Red"  ID="rfvName" runat="server" ErrorMessage="Cần chọn ngành nghề kinh tế" ControlToValidate="txtVALUE9" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
      </InsertItemTemplate>
      <EditItemTemplate>
            <telerik:RadComboBox ID="txtVALUE9" EmptyMessage ="Chọn ngành nghề kinh tế" Width ="290px" runat="server" SelectedValue ='<%#Bind("VALUE9")%>' AppendDataBoundItems ="true">
          <Items>
                <telerik:RadComboBoxItem Text ="Nông nghiệp và lâm nghiệp" Value ="1" />
                <telerik:RadComboBoxItem Text ="Thủy sản" Value ="2" />
                <telerik:RadComboBoxItem Text ="Công nghiệp khai thác mỏ" Value ="3" />
                <telerik:RadComboBoxItem Text ="Công nghiệp chế biến" Value ="4" />
                <telerik:RadComboBoxItem Text ="Sản xuất và phân phối điện, khí đốt và nước" Value ="5" />
                <telerik:RadComboBoxItem Text ="Xây dựng" Value ="6" />
                <telerik:RadComboBoxItem Text ="Thương nghiệp, sữa chữa xe có động cơ, mô tô, xe máy đồ dùng cá nhân và gia đình" Value ="7" />
                <telerik:RadComboBoxItem Text ="Khách sạn và nhà hàng" Value ="8" />
                <telerik:RadComboBoxItem Text ="Vận tải, kho bãi và thông tin liên lạc" Value ="9" />
                <telerik:RadComboBoxItem Text ="Tài chính, tín dụng" Value ="10" />
                <telerik:RadComboBoxItem Text ="Hoạt động khoa học và công nghệ" Value ="11" />
                <telerik:RadComboBoxItem Text ="Các hoạt động liên quan đến kinh doanh tài sản và dịch vụ tư vấn" Value ="12" />
                <telerik:RadComboBoxItem Text ="Quản lý nhà nước và an ninh quốc phòng bảo đảm xã  hội bắt buộc" Value ="13" />
                <telerik:RadComboBoxItem Text ="Giáo dục và đào tạo" Value ="14" />
                <telerik:RadComboBoxItem Text ="Y tế và hoạt động cứu trợ xã hội" Value ="15" />
                <telerik:RadComboBoxItem Text ="Hoạt động văn hóa thể thao" Value ="16" />
                <telerik:RadComboBoxItem Text ="Hoạt động Đảng, Đoàn thể và hiệp hội" Value ="14" />
                <telerik:RadComboBoxItem Text ="Hoạt động phục vụ cá nhân và cộng đồng " Value ="15" />
                <telerik:RadComboBoxItem Text ="Hoạt động của các tổ chức và đoàn thể quốc tế" Value ="16" />
          </Items>
          </telerik:RadComboBox>
            <asp:RequiredFieldValidator  ForeColor ="Red" ID="rfvName" runat="server" ErrorMessage="Cần chọn ngành nghề kinh tế" ControlToValidate="txtVALUE9" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
      </EditItemTemplate>
    </telerik:GridTemplateColumn>
     <telerik:GridTemplateColumn DataField="VALUE1" ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter VALUE1 column" HeaderText="Thực hiện"  ItemStyle-Width ="70px" HeaderStyle-Width ="70px" 
        SortExpression="VALUE1" UniqueName="VALUE1">   
     <ItemTemplate>
            <%#Eval("VALUE1")%>
      </ItemTemplate>
      <EditItemTemplate>
            <telerik:RadNumericTextBox  ID="txtVALUE1"  Runat="server" Text ='<%#Bind("VALUE1")%>'
             IncrementSettings-InterceptMouseWheel="true" Width="60px"  CssClass ="csstextNum" MaxValue="500000" MinValue="0" IncrementSettings-InterceptArrowKeys="true" >
             <NumberFormat  DecimalDigits ="0"/>
             </telerik:RadNumericTextBox>
      </EditItemTemplate>
      <InsertItemTemplate>
            <telerik:RadNumericTextBox  ID="txtVALUE1"  Runat="server" Text ='<%#Bind("VALUE1")%>'
             IncrementSettings-InterceptMouseWheel="true" Width="60px"  CssClass ="csstextNum" MaxValue="500000" MinValue="0" IncrementSettings-InterceptArrowKeys="true" >
             <NumberFormat  DecimalDigits ="0"/>
             </telerik:RadNumericTextBox>
      </InsertItemTemplate>
      <ItemStyle Width="70px" HorizontalAlign ="Right"  /> 
    </telerik:GridTemplateColumn>
     <telerik:GridTemplateColumn> </telerik:GridTemplateColumn>       
        </Columns>
        </MasterTableView>
        <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G1"/>
        <ClientSettings AllowKeyboardNavigation="true" KeyboardNavigationSettings-AllowSubmitOnEnter="true"></ClientSettings> 
        <ClientSettings>
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True"/>
         </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<asp:SqlDataSource ID="HDDA_NganhKTDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
        DeleteCommand="DELETE FROM [DOANHNGHIEP_VALUE] WHERE [PK_ID] = @original_PK_ID" 
        InsertCommand="INSERT INTO [DOANHNGHIEP_VALUE] ([FK_DOANHNGHIEP], [FK_TIEUCHI], [C_DATE], [C_DATE_EDIT], [VALUE1], [VALUE2], [VALUE3], [VALUE4], [VALUE5], [VALUE6], [VALUE7], [VALUE8], [VALUE9], [VALUE10], [VALUE11]) VALUES (@FK_DOANHNGHIEP, 175, @C_DATE, @C_DATE_EDIT, @VALUE1, @VALUE2, @VALUE3, @VALUE4, @VALUE5, @VALUE6, @VALUE7, @VALUE8, @VALUE9, @VALUE10, @VALUE11); SELECT @NEWIDDK = SCOPE_IDENTITY(); "
        SelectCommand="SELECT * FROM [DOANHNGHIEP_VALUE] where FK_TIEUCHI ='175' AND VALUE9 IS NOT NULL AND FK_DOANHNGHIEP =@FK_DOANHNGHIEP AND ((CONVERT(NVARCHAR(8), DOANHNGHIEP_VALUE.C_DATE, 112) =  @C_DATE) or (CONVERT (DATETIME, FLOOR(CONVERT (FLOAT, DOANHNGHIEP_VALUE.C_DATE)))  =  CONVERT (DATETIME, FLOOR(CONVERT (FLOAT, GETDATE()))) and (@C_DATE =0))) "        
    UpdateCommand="UPDATE [DOANHNGHIEP_VALUE] SET [FK_DOANHNGHIEP] = @FK_DOANHNGHIEP, [C_DATE_EDIT] = (GETDATE()), [VALUE1] = @VALUE1, [VALUE2] = @VALUE2, [VALUE3] = @VALUE3, [VALUE4] = @VALUE4, [VALUE5] = @VALUE5, [VALUE6] = @VALUE6, [VALUE7] = @VALUE7, [VALUE8] = @VALUE8, [VALUE9] = @VALUE9, [VALUE10] = @VALUE10, [VALUE11] = @VALUE11 WHERE [PK_ID] = @original_PK_ID" 
    oninserted="HDDA_NganhKTDataSource_Inserted" 
    OldValuesParameterFormatString="original_{0}" >
    <SelectParameters>
        <asp:QueryStringParameter DefaultValue="0" Name="FK_DOANHNGHIEP" 
            QueryStringField="IDDN" />
        <asp:QueryStringParameter DefaultValue="0" Name="C_DATE" 
            QueryStringField="dateselect" />                             
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="original_PK_ID" Type="Int64" />
    </DeleteParameters>
    <InsertParameters>
        <asp:QueryStringParameter DefaultValue="0" Name="FK_DOANHNGHIEP" 
            QueryStringField="IDDN" />
        <asp:Parameter Name="C_DATE" Type="DateTime" />
        <asp:Parameter Name="C_DATE_EDIT" Type="DateTime" />
        <asp:Parameter Name="VALUE1" Type="String" />
        <asp:Parameter Name="VALUE2" Type="String" />
        <asp:Parameter Name="VALUE3" Type="String" />
        <asp:Parameter Name="VALUE4" Type="String" />
        <asp:Parameter Name="VALUE5" Type="String" />
        <asp:Parameter Name="VALUE6" Type="String" />
        <asp:Parameter Name="VALUE7" Type="String" />
        <asp:Parameter Name="VALUE8" Type="String" />
        <asp:Parameter Name="VALUE9" Type="String" />
        <asp:Parameter Name="VALUE10" Type="String" />
        <asp:Parameter Name="VALUE11" Type="String" />
        <asp:Parameter Name="NEWIDDK" Type="Int32" Direction="Output" DefaultValue="0"/>
    </InsertParameters>
    <UpdateParameters>
        <asp:QueryStringParameter DefaultValue="0" Name="FK_DOANHNGHIEP" 
            QueryStringField="IDDN" />
        <asp:Parameter Name="VALUE1" Type="String" />
        <asp:Parameter Name="VALUE2" Type="String" />
        <asp:Parameter Name="VALUE3" Type="String" />
        <asp:Parameter Name="VALUE4" Type="String" />
        <asp:Parameter Name="VALUE5" Type="String" />
        <asp:Parameter Name="VALUE6" Type="String" />
        <asp:Parameter Name="VALUE7" Type="String" />
        <asp:Parameter Name="VALUE8" Type="String" />
        <asp:Parameter Name="VALUE9" Type="String" />
        <asp:Parameter Name="VALUE10" Type="String" />
        <asp:Parameter Name="VALUE11" Type="String" />
        <asp:Parameter Name="original_PK_ID" Type="Int64" />
    </UpdateParameters>
</asp:SqlDataSource>
