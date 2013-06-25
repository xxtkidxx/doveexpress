<%@ Control Language="C#" AutoEventWireup="true" CodeFile="KIHIEUTAIKHOAN.ascx.cs" Inherits="module_KIHIEUTAIKHOAN" %>
<%@ Register TagPrefix="custom" Namespace="ITCLIB.Admin" %>
<telerik:RadCodeBlock ID="RadCodeBlockKIHIEUTAIKHOAN" runat="server">
<script type="text/javascript">
        function RowDblClick(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("Lists") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewKIHIEUTAIKHOAN") && (CanEdit == "True")) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
        }
</script>
<script type="text/javascript">
    var registeredElementsDT = [];
    function GetRegisteredServerElementDT(serverID) {
        var clientID = "";
        for (var i = 0; i < registeredElementsDT.length; i++) {
            clientID = registeredElementsDT[i];
            if (clientID.indexOf(serverID) >= 0)
                break;
        }
        return $get(clientID);
    }
    function GetGridServerElementDT(serverID, tagName) {
        if (!tagName)
            tagName = "*";

        var grid = $get("<%=RadGridKIHIEUTAIKHOAN.ClientID %>");
        var elements = grid.getElementsByTagName(tagName);
        for (var i = 0; i < elements.length; i++) {
            var element = elements[i];
            if (element.id.indexOf(serverID) >= 0)
                return element;
        }
    }
</script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelKIHIEUTAIKHOAN" runat="server" />
<telerik:RadGrid ID="RadGridKIHIEUTAIKHOAN" runat="server" Skin="Vista" 
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="KIHIEUTAIKHOANDataSource" ShowFooter="True"
    ondatabound="RadGridKIHIEUTAIKHOAN_DataBound" 
    onitemdeleted="RadGridKIHIEUTAIKHOAN_ItemDeleted" oniteminserted="RadGridKIHIEUTAIKHOAN_ItemInserted" 
    onitemupdated="RadGridKIHIEUTAIKHOAN_ItemUpdated" 
    onitemcommand="RadGridKIHIEUTAIKHOAN_ItemCommand" 
    onitemdatabound="RadGridKIHIEUTAIKHOAN_ItemDataBound" CellSpacing="0" 
    onitemcreated="RadGridKIHIEUTAIKHOAN_ItemCreated">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
     <GroupingSettings CaseSensitive ="false"  />
    <MasterTableView Name="MasterTableViewKIHIEUTAIKHOAN" CommandItemDisplay="Top" DataSourceID="KIHIEUTAIKHOANDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b>Quản lý tài khoản</b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridKIHIEUTAIKHOAN.EditIndexes.Count == 0 && ITCLIB.Security.Security.CanEditModule("JobLists") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridKIHIEUTAIKHOAN.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Update.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridKIHIEUTAIKHOAN.EditIndexes.Count > 0 || RadGridKIHIEUTAIKHOAN.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridKIHIEUTAIKHOAN.MasterTableView.IsItemInserted && ITCLIB.Security.Security.CanAddModule("JobLists") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="PerformInsert" Visible='<%# RadGridKIHIEUTAIKHOAN.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Insert.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
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
                <telerik:GridBoundColumn UniqueName="C_CODE" HeaderText="Mã tài khoản" DataField="C_CODE" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_NAME" HeaderText="Diễn giải" DataField="C_NAME" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_DESC" HeaderText="Ghi chú" DataField="C_DESC" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
        </Columns>
        <EditFormSettings InsertCaption="Thêm tài khoản mới" CaptionFormatString="Sửa tài khoản: <b>{0}</b>" CaptionDataField="C_NAME" EditFormType="Template" PopUpSettings-Width="600px">
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
                 <td style =" width:150px;"> <span class="rtsTxtnew">Tài khoản:</td>
                <td colspan="4">
                    <asp:HiddenField ID="txtID" Value ='<%# Eval( "PK_ID") %>' runat="server" />
                    <telerik:RadTextBox ID="txtCODE" Width ="90%" Text='<%# Bind( "C_CODE") %>' runat="server"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="rfvCODE" runat="server" ErrorMessage="Mã tài khoản không thể rỗng" ControlToValidate="txtCODE" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="cuvCODE" ControlToValidate="txtCODE" OnServerValidate="CheckCode" runat="server" ErrorMessage="Mã tài khoản đã tồn tại" Display="Dynamic" ValidationGroup="G1"></asp:CustomValidator>
                </td>
            </tr> 
            <tr>
                 <td style =" width:150px;"> <span class="rtsTxtnew">Diễn giải:</td>
                <td colspan="4">
                   <telerik:RadTextBox ID="txtName" Text='<%# Bind( "C_NAME") %>' runat="server" Width="90%"></telerik:RadTextBox>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Tên tài khoản không thể rỗng" ControlToValidate="txtName" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
                   <asp:CustomValidator ID="CustomValidator1" ControlToValidate="txtName" OnServerValidate="CheckName" runat="server" ErrorMessage="Tên tài khoản đã tồn tại" Display="Dynamic" ValidationGroup="G1"></asp:CustomValidator>
                </td>
            </tr> 
            <tr>
                 <td style =" width:150px;"> <span class="rtsTxtnew">Ghi chú:</td>
                <td colspan="4">
                   <telerik:RadTextBox ID="txtC_DESC" Text='<%# Bind( "C_DESC") %>' runat="server" Width="90%"></telerik:RadTextBox>                   
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
            <ClientEvents OnPopUpShowing="PopUpShowing" />
            <ClientEvents OnRowDblClick="RowDblClick" />
            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="True" FrozenColumnsCount="5" ScrollHeight="450px" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<asp:SqlDataSource ID="KIHIEUTAIKHOANDataSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>" 
    DeleteCommand="DELETE FROM [DMKIHIEUTAIKHOAN] WHERE [PK_ID] = @PK_ID" 
    InsertCommand="INSERT INTO [DMKIHIEUTAIKHOAN] ([C_CODE], [C_NAME], [C_DESC]) VALUES (@C_CODE, @C_NAME, @C_DESC)" 
    SelectCommand="SELECT [DMKIHIEUTAIKHOAN].[PK_ID], [DMKIHIEUTAIKHOAN].[C_CODE], [DMKIHIEUTAIKHOAN].[C_NAME], [DMKIHIEUTAIKHOAN].[C_DESC] FROM [DMKIHIEUTAIKHOAN]" 
    UpdateCommand="UPDATE [DMKIHIEUTAIKHOAN] SET [C_CODE] = @C_CODE, [C_NAME] = @C_NAME, [C_DESC] = @C_DESC WHERE [PK_ID] = @PK_ID">
        <UpdateParameters>
            <asp:Parameter Name="C_CODE" Type="String" />
            <asp:Parameter Name="C_NAME" Type="String" />
            <asp:Parameter Name="C_DESC" Type="String" />
            <asp:Parameter Name="PK_ID" Type="Int32" />
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
