<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DN_DTXD_muasamTSCD.ascx.cs" Inherits="module_DN_DTXD_muasamTSCD" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxProxyDTXD_muasamTSCD" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGridDoanhnghiep_DTXD_muasamTSCD">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridDoanhnghiep_DTXD_muasamTSCD" LoadingPanelID="RadAjaxLoadingPanelDTXD_muasamTSCD" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<%--Lấy 196 cố định cho tiêu chí : Tại Đầu tư xây dựng 2. Danh sách mua sắm các Tài sản cố định--%>

<telerik:RadAjaxLoadingPanel Skin="Windows7" ID="RadAjaxLoadingPanelDTXD_muasamTSCD" runat="server" />
<telerik:RadGrid ID="RadGridDoanhnghiep_DTXD_muasamTSCD" runat="server" Skin="Windows7"
    AllowPaging="false" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="false" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"   ShowHeader ="false" 
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="DTXD_muasamTSCDDataSource" ShowFooter="True"
    ondatabound="RadGridDoanhnghiep_DTXD_muasamTSCD_DataBound" 
    onitemdeleted="RadGridDoanhnghiep_DTXD_muasamTSCD_ItemDeleted" oniteminserted="RadGridDoanhnghiep_DTXD_muasamTSCD_ItemInserted" 
    onitemupdated="RadGridDoanhnghiep_DTXD_muasamTSCD_ItemUpdated" 
    onitemcommand="RadGridDoanhnghiep_DTXD_muasamTSCD_ItemCommand" 
    onitemdatabound="RadGridDoanhnghiep_DTXD_muasamTSCD_ItemDataBound" 
    CellSpacing="0" ItemStyle-BorderColor="Blue" ItemStyle-BorderWidth="1px" ItemStyle-BorderStyle="Solid">
     <GroupingSettings CaseSensitive ="false"  />
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
    <MasterTableView Name="MasterTableViewDTXD_muasamTSCD" CommandItemDisplay="Top" DataSourceID="DTXD_muasamTSCDDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="InPlace" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridDoanhnghiep_DTXD_muasamTSCD.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;                 
                        <asp:LinkButton ID="LinkButton4" runat="server" CommandName="RebindGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Refresh.gif" />Làm mới</asp:LinkButton>
                    </div>
        </CommandItemTemplate>
                <Columns>
<telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditColumn" HeaderStyle-Width ="60px">
                <ItemStyle HorizontalAlign="Center" Width ="60px"></ItemStyle>
                </telerik:GridEditCommandColumn>
<telerik:GridButtonColumn HeaderStyle-Width ="40px" ConfirmText="Bạn muốn xóa chi tiết nguồn vốn?" ConfirmTitle="Xóa" ButtonType="ImageButton" CommandName="Delete" Text="Xóa" UniqueName="DeleteColumn">
                    <ItemStyle HorizontalAlign="Center" Width ="40px"></ItemStyle>
                </telerik:GridButtonColumn> 
 <telerik:GridBoundColumn DataField="PK_ID" Visible ="false" UniqueName="PK_ID" DataType="System.Int64"></telerik:GridBoundColumn>
     <telerik:GridTemplateColumn DataField="VALUE9" ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter VALUE9 column" HeaderText="Tên công trình" HeaderStyle-Width ="250px" 
        SortExpression="VALUE9" UniqueName="VALUE9">   
        <ItemStyle Width="240px" />
     <ItemTemplate>
           <%#Eval("VALUE9")%>
      </ItemTemplate>
      <InsertItemTemplate>
            <telerik:RadTextBox  ID="txtVALUE9" Width ="230px" Runat="server" Text ='<%#Bind("VALUE9")%>'></telerik:RadTextBox>
            <asp:RequiredFieldValidator ForeColor ="Red"  ID="rfvName" runat="server" ErrorMessage="Tên không thể rỗng" ControlToValidate="txtVALUE9" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
      </InsertItemTemplate>
      <EditItemTemplate>
            <telerik:RadTextBox  ID="txtVALUE9" Width ="230px" Runat="server" Text ='<%#Bind("VALUE9")%>'></telerik:RadTextBox>
            <asp:RequiredFieldValidator  ForeColor ="Red" ID="rfvName" runat="server" ErrorMessage="Tên không thể rỗng" ControlToValidate="txtVALUE9" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
      </EditItemTemplate>
    </telerik:GridTemplateColumn>
     <telerik:GridTemplateColumn DataField="VALUE1"  ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter VALUE1 column" HeaderText="Mã số"  ItemStyle-Width ="50px" HeaderStyle-Width ="50px" 
        SortExpression="VALUE1" UniqueName="VALUE1">  
   <ItemStyle Width="50px" /> 
     <ItemTemplate>
            <%#Eval("VALUE1")%>
      </ItemTemplate>
      <InsertItemTemplate>
             <telerik:RadTextBox  ID="txtVALUE1" Runat="server" Width ="40px" Text ='<%#Bind("VALUE1")%>'></telerik:RadTextBox>
      </InsertItemTemplate>
      <EditItemTemplate>
            <telerik:RadTextBox  ID="txtVALUE1" Runat="server" Width ="40px" Text ='<%#Bind("VALUE1")%>'></telerik:RadTextBox>
      </EditItemTemplate>
    </telerik:GridTemplateColumn>
     <telerik:GridTemplateColumn DataField="VALUE2" ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter VALUE2 column" HeaderText="Địa điểm xây dựng" HeaderStyle-Width ="250px" 
        SortExpression="VALUE2" UniqueName="VALUE2">   
     <ItemTemplate>
            <%#Eval("VALUE2")%>
      </ItemTemplate>
      <InsertItemTemplate>
            <telerik:RadTextBox  ID="txtVALUE2" Width ="250px" Runat="server" Text ='<%#Bind("VALUE2")%>'></telerik:RadTextBox>
      </InsertItemTemplate>
      <EditItemTemplate>
            <telerik:RadTextBox  ID="txtVALUE2" Width ="250px" Runat="server" Text ='<%#Bind("VALUE2")%>'></telerik:RadTextBox>
      </EditItemTemplate>
    </telerik:GridTemplateColumn>
     <telerik:GridTemplateColumn DataField="VALUE3"  FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter VALUE3 column" HeaderText="Khởi công"  ItemStyle-Width ="70px" HeaderStyle-Width ="70px" 
        SortExpression="VALUE3" UniqueName="VALUE3">   
     <ItemTemplate>
            <%#Eval("VALUE3")%>
      </ItemTemplate>
      <EditItemTemplate>
            <telerik:RadTextBox ID="txtVALUE3" Runat="server" Text ='<%#Bind("VALUE3")%>' Width="60px" ></telerik:RadTextBox>
      </EditItemTemplate>
      <InsertItemTemplate>
            <telerik:RadTextBox ID="txtVALUE3" Runat="server" Text ='<%#Bind("VALUE3")%>' Width="60px" ></telerik:RadTextBox>      
      </InsertItemTemplate>
    </telerik:GridTemplateColumn>
     <telerik:GridTemplateColumn DataField="VALUE4"  ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter VALUE4 column" HeaderText="Hoàn thành"  ItemStyle-Width ="70px" HeaderStyle-Width ="70px" 
        SortExpression="VALUE4" UniqueName="VALUE4">   
     <ItemTemplate>
            <%#Eval("VALUE4")%>
      </ItemTemplate>
      <EditItemTemplate>
            <telerik:RadTextBox ID="txtVALUE4" Runat="server" Text ='<%#Bind("VALUE4")%>' Width="60px" ></telerik:RadTextBox>
      </EditItemTemplate>
      <InsertItemTemplate>
            <telerik:RadTextBox ID="txtVALUE4" Runat="server" Text ='<%#Bind("VALUE4")%>' Width="60px" ></telerik:RadTextBox>     
      </InsertItemTemplate>
    </telerik:GridTemplateColumn>
     <telerik:GridTemplateColumn DataField="VALUE5"   ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter VALUE5 column" HeaderText="Đơn vị"  ItemStyle-Width ="70px" HeaderStyle-Width ="70px" 
        SortExpression="VALUE5" UniqueName="VALUE5">   
     <ItemTemplate>
            <%#Eval("VALUE5")%>
      </ItemTemplate>
           <EditItemTemplate>
            <telerik:RadTextBox ID="txtVALUE5" Runat="server" Text ='<%#Bind("VALUE5")%>' Width="60px" ></telerik:RadTextBox>
      </EditItemTemplate>
      <InsertItemTemplate>
            <telerik:RadTextBox ID="txtVALUE5" Runat="server" Text ='<%#Bind("VALUE5")%>' Width="60px" ></telerik:RadTextBox>     
      </InsertItemTemplate>
    </telerik:GridTemplateColumn>
     <telerik:GridTemplateColumn DataField="VALUE6"   ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter VALUE6 column" HeaderText="Số lượng"  ItemStyle-Width ="70px" HeaderStyle-Width ="70px" 
        SortExpression="VALUE6" UniqueName="VALUE6">   
     <ItemTemplate>
            <%#Eval("VALUE6")%>
      </ItemTemplate>
      <EditItemTemplate>
            <telerik:RadNumericTextBox  ID="txtVALUE6" Runat="server" Text ='<%#Bind("VALUE6")%>'
             IncrementSettings-InterceptMouseWheel="true" Width="60px"  CssClass ="csstextNum" MaxValue="500000" MinValue="0" IncrementSettings-InterceptArrowKeys="true" >
             <NumberFormat  DecimalDigits ="0"/>
             </telerik:RadNumericTextBox>
      </EditItemTemplate>
      <InsertItemTemplate>
             <telerik:RadNumericTextBox  ID="txtVALUE6" Runat="server" Text ='<%#Bind("VALUE6")%>'
             IncrementSettings-InterceptMouseWheel="true" Width="60px"  CssClass ="csstextNum" MaxValue="500000" MinValue="0" IncrementSettings-InterceptArrowKeys="true" >
             <NumberFormat  DecimalDigits ="0"/>
             </telerik:RadNumericTextBox>
      </InsertItemTemplate>
       <ItemStyle Width="70px" HorizontalAlign ="Right"  /> 
    </telerik:GridTemplateColumn>
     <telerik:GridTemplateColumn DataField="VALUE7"  ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter VALUE7 column" HeaderText="Tổng số vốn đầu tư (triệu đồng)"  ItemStyle-Width ="70px" HeaderStyle-Width ="70px" 
        SortExpression="VALUE7" UniqueName="VALUE7">   
     <ItemTemplate>
            <%#Eval("VALUE7")%>
      </ItemTemplate>
      <EditItemTemplate>
            <telerik:RadNumericTextBox  ID="txtVALUE7" Runat="server" Text ='<%#Bind("VALUE7")%>'
             IncrementSettings-InterceptMouseWheel="true" Width="60px"  CssClass ="csstextNum" MaxValue="500000" MinValue="0" IncrementSettings-InterceptArrowKeys="true" >
             <NumberFormat  DecimalDigits ="0"/>
             </telerik:RadNumericTextBox>
      </EditItemTemplate>
      <InsertItemTemplate>
            <telerik:RadNumericTextBox  ID="txtVALUE7" Runat="server" Text ='<%#Bind("VALUE7")%>'
             IncrementSettings-InterceptMouseWheel="true" Width="60px"  CssClass ="csstextNum" MaxValue="500000" MinValue="0" IncrementSettings-InterceptArrowKeys="true" >
             <NumberFormat  DecimalDigits ="0"/>
             </telerik:RadNumericTextBox>
      </InsertItemTemplate>
       <ItemStyle Width="70px" HorizontalAlign ="Right"  /> 
    </telerik:GridTemplateColumn>
     <telerik:GridTemplateColumn DataField="VALUE8" ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter VALUE8 column" HeaderText="Giá trị TSCĐ mới tăng (triệu đồng)"  ItemStyle-Width ="70px" HeaderStyle-Width ="70px" 
        SortExpression="VALUE8" UniqueName="VALUE8">   
     <ItemTemplate>
            <%#Eval("VALUE8")%>
      </ItemTemplate>
      <EditItemTemplate>
            <telerik:RadNumericTextBox  ID="txtVALUE8"  Runat="server" Text ='<%#Bind("VALUE8")%>'
             IncrementSettings-InterceptMouseWheel="true" Width="60px"  CssClass ="csstextNum" MaxValue="500000" MinValue="0" IncrementSettings-InterceptArrowKeys="true" >
             <NumberFormat  DecimalDigits ="0"/>
             </telerik:RadNumericTextBox>
      </EditItemTemplate>
      <InsertItemTemplate>
            <telerik:RadNumericTextBox  ID="txtVALUE8"  Runat="server" Text ='<%#Bind("VALUE8")%>'
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
            <ClientEvents OnPopUpShowing="PopUpShowing"/>
         </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<asp:SqlDataSource ID="DTXD_muasamTSCDDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
        DeleteCommand="DELETE FROM [DOANHNGHIEP_VALUE] WHERE [PK_ID] = @original_PK_ID" 
        InsertCommand="INSERT INTO [DOANHNGHIEP_VALUE] ([FK_DOANHNGHIEP], [FK_TIEUCHI], [C_DATE], [C_DATE_EDIT], [VALUE1], [VALUE2], [VALUE3], [VALUE4], [VALUE5], [VALUE6], [VALUE7], [VALUE8], [VALUE9], [VALUE10], [VALUE11]) VALUES (@FK_DOANHNGHIEP, 196, @C_DATE, @C_DATE_EDIT, @VALUE1, @VALUE2, @VALUE3, @VALUE4, @VALUE5, @VALUE6, @VALUE7, @VALUE8, @VALUE9, @VALUE10, @VALUE11); SELECT @NEWIDDK = SCOPE_IDENTITY(); "
        SelectCommand="SELECT * FROM [DOANHNGHIEP_VALUE] where FK_TIEUCHI ='196' AND VALUE9 IS NOT NULL AND FK_DOANHNGHIEP =@FK_DOANHNGHIEP AND ((CONVERT(NVARCHAR(8), DOANHNGHIEP_VALUE.C_DATE, 112) =  @C_DATE) or (CONVERT (DATETIME, FLOOR(CONVERT (FLOAT, DOANHNGHIEP_VALUE.C_DATE)))  =  CONVERT (DATETIME, FLOOR(CONVERT (FLOAT, GETDATE()))) and (@C_DATE =0))) "        
    UpdateCommand="UPDATE [DOANHNGHIEP_VALUE] SET [FK_DOANHNGHIEP] = @FK_DOANHNGHIEP, [C_DATE_EDIT] = (GETDATE()), [VALUE1] = @VALUE1, [VALUE2] = @VALUE2, [VALUE3] = @VALUE3, [VALUE4] = @VALUE4, [VALUE5] = @VALUE5, [VALUE6] = @VALUE6, [VALUE7] = @VALUE7, [VALUE8] = @VALUE8, [VALUE9] = @VALUE9, [VALUE10] = @VALUE10, [VALUE11] = @VALUE11 WHERE [PK_ID] = @original_PK_ID" 
    oninserted="DTXD_muasamTSCDDataSource_Inserted" 
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
