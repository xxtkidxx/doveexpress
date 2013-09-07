<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MABANGCUOCQT.ascx.cs" Inherits="module_MABANGCUOCQT" %>
<telerik:RadCodeBlock ID="RadCodeBlockMABANGCUOCQT" runat="server">
<script type="text/javascript">
        function RowDblClick(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("Lists") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewMABANGCUOCQT") && (CanEdit == "True")) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
        }
</script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelMABANGCUOCQT" runat="server" />
<telerik:RadGrid ID="RadGridMABANGCUOCQT" runat="server" Skin="Vista" 
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="MABANGCUOCQTDataSource" ShowFooter="True"
    ondatabound="RadGridMABANGCUOCQT_DataBound" 
    onitemdeleted="RadGridMABANGCUOCQT_ItemDeleted" oniteminserted="RadGridMABANGCUOCQT_ItemInserted" 
    onitemupdated="RadGridMABANGCUOCQT_ItemUpdated" 
    onitemcommand="RadGridMABANGCUOCQT_ItemCommand" 
    onitemdatabound="RadGridMABANGCUOCQT_ItemDataBound" CellSpacing="0">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
     <GroupingSettings CaseSensitive ="false"  />
    <MasterTableView Name="MasterTableViewMABANGCUOCQT" CommandItemDisplay="Top" DataSourceID="MABANGCUOCQTDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b>Quản lý mã bảng cước</b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridMABANGCUOCQT.EditIndexes.Count == 0 && ITCLIB.Security.Security.CanEditModule("JobLists") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridMABANGCUOCQT.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Update.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridMABANGCUOCQT.EditIndexes.Count > 0 || RadGridMABANGCUOCQT.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridMABANGCUOCQT.MasterTableView.IsItemInserted && ITCLIB.Security.Security.CanAddModule("JobLists") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="PerformInsert" Visible='<%# RadGridMABANGCUOCQT.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Insert.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
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
                <telerik:GridBoundColumn UniqueName="C_CODE" HeaderText="Mã bảng cước" DataField="C_CODE" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_NAME" HeaderText="Tên bảng cước đối tác" DataField="DOITACNAME" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_VALUE1" HeaderText="Mức chênh lệch" DataField="C_VALUE1" AllowFiltering="false">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_VALUE2" HeaderText="% chênh lệch" DataField="C_VALUE2"  AllowFiltering="false">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="VUNGLAMVIECNAME" HeaderText="Vùng làm việc" DataField="VUNGLAMVIECNAME" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
        </Columns>
        <EditFormSettings InsertCaption="Thêm mã bảng cước mới" CaptionFormatString="Sửa mã bảng cước: <b>{0}</b>" CaptionDataField="C_CODE" EditFormType="Template" PopUpSettings-Width="600px">
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
                 <td style =" width:150px;"> <span class="rtsTxtnew">Mã bảng cước:</td>
                <td colspan="4">
                    <asp:HiddenField ID="txtID" Value ='<%# Eval( "PK_ID") %>' runat="server" />
                    <telerik:RadTextBox ID="txtCODE" Width ="90%" Text='<%# Bind( "C_CODE") %>' runat="server"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="rfvCODE" runat="server" ErrorMessage="Mã bảng cước không thể rỗng" ControlToValidate="txtCODE" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="cuvCODE" ControlToValidate="txtCODE" OnServerValidate="CheckCode" runat="server" ErrorMessage="Mã bảng cước đã tồn tại" Display="Dynamic" ValidationGroup="G1"></asp:CustomValidator>
                </td>
            </tr> 
            <tr>
                 <td style =" width:150px;"> <span class="rtsTxtnew">Bảng cước đối tác:</td>
                <td colspan="4">
                   <asp:DropDownList ID="ddlDoitac" SelectedValue='<%# Bind("FK_DOITAC") %>' DataTextField="C_NAME" DataValueField="PK_ID" runat="server" DataSourceID="DoiTacDataSource" AppendDataBoundItems="True">
                   <asp:ListItem Value="" Text="Chọn"></asp:ListItem>
                   </asp:DropDownList>
                   <asp:RequiredFieldValidator ID="rfvDoitac" runat="server" ErrorMessage="Hãy chọn bảng cước đối tác" ControlToValidate="ddlDoitac" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>                                                                
                </td>
            </tr>
            <tr>
                 <td style =" width:150px;"> <span class="rtsTxtnew">Mức chênh lệch:</td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_VALUE1" Width ="90%" Runat="server" Text='<%# Bind("C_VALUE1") %>'>
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="1"/>
                    </telerik:RadNumericTextBox>            
                </td>
            </tr>
            <tr>
                 <td style =" width:150px;"> <span class="rtsTxtnew">% chênh lệch:</td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="RadNumericTextBox1" Width ="90%" Runat="server" Text='<%# Bind("C_VALUE2") %>'>
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="1"/>
                    </telerik:RadNumericTextBox>            
                </td>
            </tr>
            <tr>
                 <td style =" width:150px;"> <span class="rtsTxtnew">Vùng làm việc:</td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbFK_VUNGLAMVIEC" runat="server" SelectedValue='<%# Bind("FK_VUNGLAMVIEC") %>'
                    DataTextField="C_NAME" DataValueField="C_CODE" DataSourceID="VUNGLAMVIECDataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn">
                    </telerik:RadComboBox>
                </td>
            </tr>
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
            <ClientEvents OnPopUpShowing="PopUpShowingSmall" />
            <ClientEvents OnRowDblClick="RowDblClick" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<asp:SqlDataSource ID="MABANGCUOCQTDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
        DeleteCommand="DELETE FROM [DMMABANGCUOCQT] WHERE [PK_ID] = @PK_ID" 
        InsertCommand="INSERT INTO [DMMABANGCUOCQT] ([C_CODE], [FK_DOITAC],[C_VALUE1],[C_VALUE2],[FK_VUNGLAMVIEC]) VALUES (@C_CODE, @FK_DOITAC,@C_VALUE1,@C_VALUE2,@FK_VUNGLAMVIEC)"
        SelectCommand="SELECT [DMMABANGCUOCQT].[PK_ID], [DMMABANGCUOCQT].[C_CODE], [DMMABANGCUOCQT].[FK_DOITAC], [DMMABANGCUOCQT].[C_VALUE1], [DMMABANGCUOCQT].[C_VALUE2],[DMMABANGCUOCQT].[FK_VUNGLAMVIEC], [DMDOITAC].[C_NAME] as [DOITACNAME], [DMVUNGLAMVIEC].[C_NAME] as [VUNGLAMVIECNAME] FROM [DMMABANGCUOCQT] LEFT OUTER JOIN [DMDOITAC] ON [DMMABANGCUOCQT].[FK_DOITAC] = [DMDOITAC].[PK_ID] LEFT OUTER JOIN [DMVUNGLAMVIEC] ON [DMMABANGCUOCQT].[FK_VUNGLAMVIEC] = [DMVUNGLAMVIEC].[C_CODE] ORDER BY LTRIM([DMMABANGCUOCQT].[C_CODE])"      
        UpdateCommand="UPDATE [DMMABANGCUOCQT] SET [C_CODE] = @C_CODE, [FK_DOITAC] = @FK_DOITAC, [C_VALUE1] = @C_VALUE1, [C_VALUE2] = @C_VALUE2, [FK_VUNGLAMVIEC] = @FK_VUNGLAMVIEC WHERE [PK_ID] = @PK_ID" >
        <UpdateParameters>
            <asp:Parameter Name="C_CODE" Type="String" />
            <asp:Parameter Name="FK_DOITAC" Type="String" />
            <asp:Parameter Name="C_VALUE1" Type="String" DefaultValue="0" />
            <asp:Parameter Name="C_VALUE2" Type="String" DefaultValue="0" />
            <asp:Parameter Name="FK_VUNGLAMVIEC" Type="String" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="PK_ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="C_CODE" Type="String" />
            <asp:Parameter Name="FK_DOITAC" Type="String" />
            <asp:Parameter Name="C_VALUE1" Type="String" DefaultValue="0" />
            <asp:Parameter Name="C_VALUE2" Type="String" DefaultValue="0" />
            <asp:Parameter Name="FK_VUNGLAMVIEC" Type="String" />
        </InsertParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="DoiTacDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMDoiTac] ORDER BY LTRIM([C_CODE])">
</asp:SqlDataSource>
 <asp:SqlDataSource ID="VUNGLAMVIECDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
 SelectCommand="SELECT DMVUNGLAMVIEC.* FROM DMVUNGLAMVIEC" >
</asp:SqlDataSource>

