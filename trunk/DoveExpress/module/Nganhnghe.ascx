<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Nganhnghe.ascx.cs" Inherits="module_Nganhnghe" %>
<telerik:RadCodeBlock ID="RadCodeBlockNganhnghe"  runat ="server" >
<script type="text/javascript">
         function RowDblClickNganhnghe(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("Lists") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewNganhnghe") && (CanEdit == "True")) {
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
    function GetGridServerElementNganhnghe(serverID, tagName) {
        if (!tagName)
            tagName = "*";

        var grid = $get("<%=RadGridNganhnghes.ClientID %>");
        var elements = grid.getElementsByTagName(tagName);
        for (var i = 0; i < elements.length; i++) {
            var element = elements[i];
            if (element.id.indexOf(serverID) >= 0)
                return element;
        }
    }
  </script> 
<script type="text/javascript">
    var comboBox;
    function OnClientLoadNganhnghe(sender) {
        comboBox = sender;
    }
    function ClientNodeClicking(sender, args) {
        var txtpk = GetGridServerElementNganhnghe("hfID");
        var node = args.get_node()
        txtpk.value = node.get_value();
        comboBox.set_text(node.get_text());
        comboBox.set_value(node.get_value());
        comboBox.trackChanges();
        comboBox.get_items().getItem(0).set_text(node.get_text());
        comboBox.commitChanges();
        comboBox.hideDropDown();
    }

    function StopPropagation(e) {
        if (!e) {
            e = window.event;
        }

        e.cancelBubble = true;
    }

    function OnClientDropDownOpenedHandler(sender, eventArgs) {
        var tree = sender.get_items().getItem(0).findControl("RaTreViewDir");
        var selectedNode = tree.get_selectedNode();
        if (selectedNode) {
            selectedNode.scrollIntoView();
        }
    }
    function OnClientShowText(sender, eventArgs) {

    }
    function OnClientCloseText(sender, eventArgs) {
        if (eventArgs.get_argument() != null) {
        }
        else {
        }
        return false;
    }
</script>

</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelNganhnghe" runat="server" />

<table id="Table1" cellspacing="3" cellpadding="3" style="width: 100%" border="0">
<tr>
 <td style =" width:15%">
                    Xem theo cấp xếp mã ngành:
                </td>
                <td>
<telerik:RadComboBox ID="rcbParent" runat="server" Width="150px"  AutoPostBack ="true"  AppendDataBoundItems ="true"
    ShowToggleImage="True" Style="vertical-align: middle;"
    EmptyMessage="Chọn cấp xếp" ExpandAnimation-Type="None" CollapseAnimation-Type="None">
    <Items >
        <telerik:RadComboBoxItem Text ="Tất cả" Value ="0" />
        <telerik:RadComboBoxItem Text ="Cấp 1" Value ="1" />
        <telerik:RadComboBoxItem Text ="Cấp 2" Value ="2" />
        <telerik:RadComboBoxItem Text ="Cấp 3" Value ="3" />
        <telerik:RadComboBoxItem Text ="Cấp 4" Value ="4" />
        <telerik:RadComboBoxItem Text ="Cấp 5" Value ="5" />
    </Items>
    <ExpandAnimation Type="None"></ExpandAnimation>
    <CollapseAnimation Type="None"></CollapseAnimation>
</telerik:RadComboBox>
  </td>
    </tr>
                 
</table>
<telerik:RadGrid ID="RadGridNganhnghes" runat="server" Skin="Vista" 
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"   Height ="100%"
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="NganhnghesDataSource" ShowFooter="True"
    ondatabound="RadGridNganhnghes_DataBound" 
    onitemdeleted="RadGridNganhnghes_ItemDeleted" oniteminserted="RadGridNganhnghes_ItemInserted" 
    onitemupdated="RadGridNganhnghes_ItemUpdated" 
    onitemcommand="RadGridNganhnghes_ItemCommand" 
    onitemdatabound="RadGridNganhnghes_ItemDataBound" CellSpacing="0" >
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML">
<Excel Format="ExcelML"></Excel>
    </ExportSettings>   
     <GroupingSettings CaseSensitive ="false"  />
    <MasterTableView Name ="MasterTableViewNganhnghe" CommandItemDisplay="Top" DataSourceID="NganhnghesDataSource" DataKeyNames="pk_id" ClientDataKeyNames="pk_id" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b>
                           <asp:Label ID="lblcap" runat="server" 
                            Text="Label" onprerender="lblcap_PreRender"></asp:Label>&nbsp;(Theo hướng dẫn của Tổng cục Thống kê)</b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridNganhnghes.EditIndexes.Count == 0  && ITCLIB.Security.Security.CanEditModule("Lists") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridNganhnghes.MasterTableView.IsItemInserted && ITCLIB.Security.Security.CanAddModule("Lists") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:return confirm('Bạn có muốn xóa bản ghi đã chọn không?')" Visible ='<%# ITCLIB.Security.Security.CanDeleteModule("Lists") %>' runat="server" CommandName="DeleteSelected"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Delete.gif" />Xóa</asp:LinkButton>&nbsp;&nbsp;
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
                 <telerik:GridBoundColumn UniqueName="PK_ID" HeaderText="" DataField="PK_ID" Visible ="false"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                 <telerik:GridTemplateColumn HeaderText ="" ShowFilterIcon="false">   
                 <FilterTemplate >
                  <center> <asp:Button ID="btnSearch" Visible ="false" Text="Tìm" runat="server"/>
                   <asp:ImageButton ID="btnShowAll" runat="server" ImageUrl="../Images/Grid/filterCancel.gif" AlternateText="Xem tất" ToolTip="Xem tất" OnClick="btnShowAll_Click" Style="vertical-align: middle" />
                  </center>
                 </FilterTemplate>
                  <ItemTemplate>
                      <asp:Label ID="lblSTT" runat="server" Text=""></asp:Label>
                </ItemTemplate>
                 <HeaderStyle HorizontalAlign ="Center" Width ="30px" />
                 <ItemStyle HorizontalAlign ="Center" Width ="30px" />
               </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn UniqueName="c_name" HeaderText="Tên" DataField="c_name"  HeaderStyle-Width ="200px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="C_TYPE" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%"
                    FilterControlAltText="Filter C_TYPE column" HeaderText="Cấp xếp" ItemStyle-HorizontalAlign ="Right"  HeaderStyle-Width ="60px"
                    SortExpression="C_TYPE" UniqueName="C_TYPE">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="C_CODE" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%"
                    FilterControlAltText="Filter C_CODE column" HeaderText="Mã ngành"  ItemStyle-HorizontalAlign ="Right"  HeaderStyle-Width ="100px"
                    SortExpression="C_CODE" UniqueName="C_CODE">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="C_DESC" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%"
                    FilterControlAltText="Filter C_DESC column" HeaderText="Nội dung" 
                    SortExpression="C_DESC" UniqueName="C_DESC">
                </telerik:GridBoundColumn>
        </Columns>
<EditFormSettings InsertCaption="Thêm ngành nghề kinh doanh mới" CaptionFormatString="Sửa ngành nghề kinh doanh: <b>{0}</b>" CaptionDataField="C_NAME" EditFormType="Template" PopUpSettings-Width="600px">
<EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
<FormTemplate>
<div class="headerthongtin">
<ul>
<li class="lifirst"><asp:LinkButton ID="btnSave" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'><img src="Images/img_save.jpg" /><%# (Container is GridEditFormInsertItem) ? "Lưu" : "Lưu" %></asp:LinkButton></li>
<li><asp:LinkButton ID="btnClose" runat="server" CommandName="Cancel"><img src="Images/img_Close.jpg" />Đóng</asp:LinkButton></li>                     
</ul>
</div>  
<table id="TableEditInGrid" cellspacing="3" cellpadding="3" style="width: 100%" border="0">
<tr>
    <td style =" width :120px;">
        Cấp xếp mã ngành:
    </td>
    <td colspan ="3">
        <telerik:RadComboBox ID="rcbLevel" runat="server" Width="150px"  AutoPostBack ="true" SelectedValue = '<%# Bind( "C_TYPE") %>'  AppendDataBoundItems ="true"
                ShowToggleImage="True" Style="vertical-align: middle;"
                EmptyMessage="Chọn cấp xếp" ExpandAnimation-Type="None" CollapseAnimation-Type="None">
                <Items >
                    <telerik:RadComboBoxItem Text ="Cấp 1" Value ="1" />
                    <telerik:RadComboBoxItem Text ="Cấp 2" Value ="2" />
                    <telerik:RadComboBoxItem Text ="Cấp 3" Value ="3" />
                    <telerik:RadComboBoxItem Text ="Cấp 4" Value ="4" />
                    <telerik:RadComboBoxItem Text ="Cấp 5" Value ="5" />
                    <telerik:RadComboBoxItem Text ="" Value ="" Visible ="false" />
                </Items>
                <ExpandAnimation Type="None"></ExpandAnimation>
                <CollapseAnimation Type="None"></CollapseAnimation>
            </telerik:RadComboBox>
        <br /><asp:RequiredFieldValidator ForeColor ="Red"  ID="rfvcap" runat="server" ErrorMessage="Cấp xếp ngành nghề kinh doanh không thể rỗng" ControlToValidate="rcbLevel" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
</td>
</tr>
<tr>
   <td>
        Mã ngành nghề KD:
    </td>
    <td>
        <telerik:RadTextBox ID="txtCode" Width ="90%" Text='<%# Bind( "C_CODE") %>' runat="server"></telerik:RadTextBox>
        <br /><asp:RequiredFieldValidator ID="rfvCode" ForeColor ="Red"  runat="server" ErrorMessage="Mã ngành nghề kinh doanh không thể rỗng" ControlToValidate="txtCode" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
         <asp:CustomValidator ID="cuvCode" ForeColor ="Red" ControlToValidate="txtCode" OnServerValidate="CheckCode" runat="server" ErrorMessage="Mã ngành nghề kinh doanh đã tồn tại" Display="Dynamic" ValidationGroup="G1"></asp:CustomValidator>
        <br /><asp:CustomValidator ID="cuvLencode" ForeColor ="Red" ControlToValidate="txtCode" OnServerValidate="CheckLenCode" runat="server" ErrorMessage="Mã đúng chỉ tối đa 5 ký tự" Display="Dynamic" ValidationGroup="G1"></asp:CustomValidator>
    </td>   
</tr>    
<tr>
 <td>
        Tên ngành nghề KD:
    </td>
    <td>
        <asp:HiddenField ID="txtID" Value='<%# Eval("pk_id") %>' runat="server"  />
        <telerik:RadTextBox ID="txtName" Width ="90%" Text='<%# Bind( "C_NAME") %>' runat="server"></telerik:RadTextBox>
       <br /><asp:RequiredFieldValidator ID="rfvName" ForeColor ="Red"  runat="server" ErrorMessage="Tên ngành nghề kinh doanh không thể rỗng" ControlToValidate="txtName" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
       </td>
</tr>
<tr>
    <td>
        Nội dung:
    </td>
    <td colspan ="3">
        <telerik:RadTextBox ID="txtdesc" Width ="90%" Rows="5" Columns ="35" TextMode ="MultiLine" Text='<%# Bind( "C_DESC") %>' runat="server"></telerik:RadTextBox>
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
            <ClientEvents OnPopUpShowing="PopUpShowingSmall" />
            <ClientEvents OnRowDblClick="RowDblClickNganhnghe" />
            <Scrolling  AllowScroll ="false" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />

<FilterMenu EnableImageSprites="False"></FilterMenu>

<HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Vista"></HeaderContextMenu>
</telerik:RadGrid>
<asp:SqlDataSource ID="NganhnghesDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
        DeleteCommand="DELETE FROM [DMNGANHNGHEKD] WHERE [PK_ID] = @original_PK_ID "
        InsertCommand="INSERT INTO [DMNGANHNGHEKD] ([C_NAME], [C_TYPE], [C_CODE], [C_DESC]) VALUES (@C_NAME, @C_TYPE, @C_CODE, @C_DESC)"
        SelectCommand="SELECT * FROM [DMNGANHNGHEKD] WHERE ([C_TYPE] = @C_TYPE) or (@C_TYPE =0) "     
    
    UpdateCommand="UPDATE [DMNGANHNGHEKD] SET [C_NAME] = @C_NAME, [C_TYPE] = @C_TYPE, [C_CODE] = @C_CODE, [C_DESC] = @C_DESC WHERE [PK_ID] = @original_PK_ID "
    ConflictDetection="CompareAllValues" 
    OldValuesParameterFormatString="original_{0}" >
        <DeleteParameters>
            <asp:Parameter Name="original_PK_ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="C_NAME" Type="String" />
            <asp:Parameter Name="C_TYPE" Type="Int32" />
            <asp:Parameter Name="C_CODE" Type="String" />
            <asp:Parameter Name="C_DESC" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="rcbParent" DefaultValue="0" Name="C_TYPE" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="C_NAME" Type="String" />
            <asp:Parameter Name="C_TYPE" Type="Int32" />
            <asp:Parameter Name="C_CODE" Type="String" />
            <asp:Parameter Name="C_DESC" Type="String" />
            <asp:Parameter Name="original_PK_ID" Type="Int32" />
        </UpdateParameters>
</asp:SqlDataSource>  

<telerik:RadWindowManager ReloadOnShow="true" ShowContentDuringLoad="false" ID="RadWindowManagerCG" runat="server" VisibleStatusbar="False"
   OnClientClose="OnClientCloseText" OnClientShow="OnClientShowText" Behaviors ="Close,Reload" ></telerik:RadWindowManager>
