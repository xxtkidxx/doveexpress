<%@ Control Language="C#" AutoEventWireup="true" CodeFile="QUOCGIA.ascx.cs" Inherits="module_QUOCGIA" %>
<telerik:RadCodeBlock ID="RadCodeBlockQUOCGIA"  runat ="server" >
<script type="text/javascript">
         function RowDblClickQUOCGIA(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("Lists") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewQUOCGIA") && (CanEdit == "True")) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
        }
</script>
<script type="text/javascript">
    var registeredElements = [];
    function GetRegisteredServerElement(serverID) {
        var clientID = "";
        for (var i = 0; i < registeredElements.length; i++) {
            clientID = registeredElements[i];
            if (clientID.indexOf(serverID) >= 0)
                break;
        }
        return $get(clientID);
    }
    function GetGridServerElementQUOCGIA(serverID, tagName) {
        if (!tagName)
            tagName = "*";

        var grid = $get("<%=RadGridQUOCGIA.ClientID %>");
        var elements = grid.getElementsByTagName(tagName);
        for (var i = 0; i < elements.length; i++) {
            var element = elements[i];
            if (element.id.indexOf(serverID) >= 0)
                return element;
        }
    }
  </script> 
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelQUOCGIA" runat="server" />
<telerik:RadSplitter ID="RadSplitterQUOCGIA" runat="server" Width="100%" Height ="550px">
<telerik:RadPane ID="LeftPaneQUOCGIA" runat="server" Width="20%">
<telerik:RadPanelBar ID="RadPanelBarListKHUVUC" Width ="100%" Height ="100%"  
        runat="server" ExpandMode="MultipleExpandedItems"
        Skin ="Vista" DataFieldID="PK_ID" 
        DataSourceID="SqlDataSourceKHUVUC" DataTextField="C_NAME"  DataValueField="PK_ID" 
        onitemdatabound="RadPanelBarListKHUVUC_ItemDataBound" 
        onitemclick="RadPanelBarListKHUVUC_ItemClick">
     </telerik:RadPanelBar>
</telerik:RadPane>
<telerik:RadSplitBar ID="RadSplitBarQUOCGIA" runat="server" CollapseMode="Forward" />
<telerik:RadPane ID="MiddlePaneQUOCGIA" runat="server" Width="79%">
<telerik:RadGrid ID="RadGridQUOCGIA" runat="server" Skin="Vista" 
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"   Height ="100%"
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="QUOCGIADataSource" ShowFooter="True"
    ondatabound="RadGridQUOCGIA_DataBound" 
    onitemdeleted="RadGridQUOCGIA_ItemDeleted" oniteminserted="RadGridQUOCGIA_ItemInserted" 
    onitemupdated="RadGridQUOCGIA_ItemUpdated" 
    onitemcommand="RadGridQUOCGIA_ItemCommand" 
    onitemdatabound="RadGridQUOCGIA_ItemDataBound" CellSpacing="0" 
    onitemcreated="RadGridQUOCGIA_ItemCreated" 
        onprerender="RadGridQUOCGIA_PreRender">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML">
<Excel Format="ExcelML"></Excel>
    </ExportSettings>   
     <GroupingSettings CaseSensitive ="false"  />
    <MasterTableView Name ="MasterTableViewQUOCGIA" CommandItemDisplay="Top" DataSourceID="QUOCGIADataSource" DataKeyNames="pk_id" ClientDataKeyNames="pk_id" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b>
                           Quản lý quốc gia: <asp:Label ID="lblcap" runat="server" 
                            Text="Label" onprerender="lblcap_PreRender"></asp:Label></b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridQUOCGIA.EditIndexes.Count == 0  && ITCLIB.Security.Security.CanEditModule("QUOCGIAs") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridQUOCGIA.MasterTableView.IsItemInserted && ITCLIB.Security.Security.CanAddModule("QUOCGIAs") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:return confirm('Bạn có muốn xóa bản ghi đã chọn không?')" Visible ='<%# ITCLIB.Security.Security.CanDeleteModule("QUOCGIAs") %>' runat="server" CommandName="DeleteSelected"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Delete.gif" />Xóa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton4" runat="server" CommandName="RebindGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Refresh.gif" />Làm mới</asp:LinkButton>
                    </div>
                    <div style="padding: 5px 5px;float:right;width:auto">
                        <asp:LinkButton ID="ExportToPdfButton" runat="server" CommandName="ExportToPdf"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/pdf.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToWordButton" runat="server" CommandName="ExportToWord"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/word.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToExcelButton" runat="server" CommandName="ExportToExcel"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/excel.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToCsvButton" runat="server" CommandName="ExportToCsv"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/csv.gif" /></asp:LinkButton>&nbsp;&nbsp;
                    </div>
        </CommandItemTemplate>
<CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

<RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column"></RowIndicatorColumn>

<ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column"></ExpandCollapseColumn>
        <Columns>
                <telerik:GridBoundColumn UniqueName="pk_id" HeaderText="" DataField="pk_id" Visible ="false">
                </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn UniqueName="FK_KHUVUC" HeaderText="" DataField="FK_KHUVUC" Visible ="false">
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
              <telerik:GridBoundColumn UniqueName="C_CODE" HeaderText="Mã quốc gia" DataField="C_CODE" 
              AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
              </telerik:GridBoundColumn>
              <telerik:GridBoundColumn UniqueName="C_NAME" HeaderText="Tên quốc gia" DataField="c_name" 
              AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
              </telerik:GridBoundColumn>
        </Columns>
        <EditFormSettings InsertCaption="Thêm quốc gia mới" CaptionFormatString="Sửa quốc gia: <b>{0}</b>" CaptionDataField="C_NAME" EditFormType="Template" PopUpSettings-Width="600px">
        <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
           <FormTemplate>
           <div class="headerthongtin">
              <ul>
                <li class="lifirst"><asp:LinkButton ID="btnSave" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'><img src="Images/img_save.jpg" /><%# (Container is GridEditFormInsertItem) ? "Lưu" : "Lưu" %></asp:LinkButton></li>
                     <li><asp:LinkButton ID="btnClose" runat="server" CommandName="Cancel"><img src="Images/img_Close.jpg" />Đóng</asp:LinkButton></li>                     
              </ul>
            </div>  
              <table id="Table1" cellspacing="3" cellpadding="3" style="width: 100%" border="0">
                        <tr>
                            <td>
                                Thuộc khu vực:
                            </td>
                            <td>
                            <asp:DropDownList ID="ddlKhuvuc" SelectedValue='<%# Bind("FK_KHUVUC") %>' DataTextField="C_NAME" DataValueField="PK_ID" runat="server" DataSourceID="SqlDataSourceKHUVUC" AppendDataBoundItems="True">
                            <asp:ListItem Value="" Text="Chọn"></asp:ListItem>
                            </asp:DropDownList>   
                            <br />
                            <asp:RequiredFieldValidator ForeColor ="Red"  ID="RequiredFieldValidator1" runat="server" ErrorMessage="Khu vực không thể rỗng" ControlToValidate="ddlKhuvuc" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
                   </td>
               </tr>
                        <tr>
                            <td>
                                Mã quốc gia:
                            </td>
                            <td>
                                <asp:HiddenField ID="txtID" Value='<%# Eval("pk_id") %>' runat="server"  />
                                <asp:TextBox ID="txtCode" Width ="400px" Text='<%# Bind( "C_CODE") %>' runat="server"></asp:TextBox>
                               <br /><span style="color:Red;">
                                <asp:RequiredFieldValidator ID="rfvCode" runat="server" ErrorMessage="Mã quốc gia không thể rỗng" ControlToValidate="txtCode" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
                             </span> 
                            </td>
                        </tr> 
                        <tr>
                            <td>
                                Tên quốc gia:
                            </td>
                            <td>
                                <asp:TextBox ID="txtName" Width ="400px" Text='<%# Bind( "C_NAME") %>' runat="server"></asp:TextBox>
                               <br /><span style="color:Red;">
                                <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Tên quốc gia không thể rỗng" ControlToValidate="txtName" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
                             </span> 
                            </td>
                        </tr>                    
                    </table>
             </FormTemplate>
        <PopUpSettings Width="600px" ></PopUpSettings>
        </EditFormSettings>
        </MasterTableView>
        <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G1"/>
        <ClientSettings>
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
            <ClientEvents OnPopUpShowing="PopUpShowing" />
            <ClientEvents OnRowDblClick="RowDblClickQUOCGIA" />
            <Scrolling  AllowScroll ="false" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
<FilterMenu EnableImageSprites="False"></FilterMenu>
</telerik:RadGrid>
<asp:SqlDataSource ID="QUOCGIADataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
        DeleteCommand="DELETE FROM [DMQUOCGIA] WHERE [pk_id] = @pk_id" 
        InsertCommand="INSERT INTO [DMQUOCGIA] ([C_CODE], [C_NAME],[FK_KHUVUC]) VALUES (@C_CODE, @C_NAME,@FK_KHUVUC)"
        SelectCommand="SELECT * FROM [DMQUOCGIA] where FK_KHUVUC =@FK_KHUVUC ORDER BY LTRIM([c_name])"     
    UpdateCommand="UPDATE [DMQUOCGIA] SET [C_CODE] = @C_CODE, [C_NAME] = @C_NAME, [FK_KHUVUC] = @FK_KHUVUC WHERE [pk_id] = @pk_id" >
        <SelectParameters>
            <asp:SessionParameter DefaultValue="1" Name="FK_KHUVUC" SessionField="kvID"/>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="C_CODE" Type="String" />
            <asp:Parameter Name="C_NAME" Type="String" />
            <asp:Parameter Name="FK_KHUVUC" Type="Int32" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="pk_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="C_CODE" Type="String" />
            <asp:Parameter Name="C_NAME" Type="String" />
            <asp:Parameter Name="FK_KHUVUC" Type="Int32" />
        </InsertParameters>
</asp:SqlDataSource>      
</telerik:RadPane>
 </telerik:RadSplitter>
 <asp:SqlDataSource ID="SqlDataSourceKHUVUC" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
    SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMKHUVUC]">
 </asp:SqlDataSource> 