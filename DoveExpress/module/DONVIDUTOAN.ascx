<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DONVIDUTOAN.ascx.cs" Inherits="module_Donvidutoan" %>
<telerik:RadCodeBlock ID="RadCodeBlockDonvidutoan" runat="server">
<script type="text/javascript">
        function RowDblClickDonvidutoan(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("Donvidutoans") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewDonvidutoan") && (CanEdit == "True")) {
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
    function GetGridServerElementDonvidutoan(serverID, tagName) {
        if (!tagName)
            tagName = "*";

        var grid = $get("<%=RadGridDonvidutoan.ClientID %>");
        var elements = grid.getElementsByTagName(tagName);
        for (var i = 0; i < elements.length; i++) {
            var element = elements[i];
            if (element.id.indexOf(serverID) >= 0)
                return element;
        }
    }
    function OnClientShowDonvidutoan(sender, eventArgs) {

    }
    function OnClientCloseDonvidutoan(sender, eventArgs) {
        if (eventArgs.get_argument() != null) {
        }
        else {
        }
        return false;
    }
  </script>
  <script type="text/javascript">
      var idtextselect;
      function RadMenuDonvidutoan_ItemClientClick(sender, args) {
          var menuItemValue = args.get_item().get_value();
          switch (menuItemValue) {
              case "DTKH":
                  var oWindow = radopen("Popup.aspx?ctl=DTKHs&dtID=" + idtextselect, "DTKH");
                  oWindow.set_title("Quản lý đề tài dự án các đơn vị dự toán");
                  oWindow.maximize();
                  break;
              case "SXKD":
                  var oWindow = radopen("Popup.aspx?ctl=DUTOANSXKDs&dtID=" + idtextselect, "DUTOANSXKDs");
                  oWindow.set_title("Quản lý hoạt động sản xuất kinh doanh");
                  oWindow.maximize();
                  break;
              case "LEPHI":
                  var oWindow = radopen("Popup.aspx?ctl=DUTOANLEPHIs&dtID=" + idtextselect, "DUTOANLEPHIs");
                  oWindow.set_title("Quản lý hoạt động thu lệ phí");
                  oWindow.maximize();
                  break;
              case "VIENTRO":
                  var oWindow = radopen("Popup.aspx?ctl=DUTOANVIENTROs&dtID=" + idtextselect, "DUTOANVIENTROs");
                  oWindow.set_title("Quản lý các khoản viện trợ");
                  oWindow.maximize();
                  break;
          }
      }
      function RowContextMenuDonvidutoan(sender, eventArgs) {
          var menu = $find("<%=RadMenuDonvidutoan.ClientID %>");
          var evt = eventArgs.get_domEvent();
          idtextselect = eventArgs.getDataKeyValue("PK_ID");
          var index = eventArgs.get_itemIndexHierarchical();
          sender.get_masterTableView().selectItem(sender.get_masterTableView().get_dataItems()[index].get_element(), true);
          menu.show(evt);
          evt.cancelBubble = true;
          evt.returnValue = false;
          if (evt.stopPropagation) {
              evt.stopPropagation();
              evt.preventDefault();
          }
      }
</script> 
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelDonvidutoan" runat="server" />
<telerik:RadGrid ID="RadGridDonvidutoan" runat="server" Skin="Vista" 
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="true"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="DonvidutoansDataSource" ShowFooter="True"
    ondatabound="RadGridDonvidutoan_DataBound" 
    onitemdeleted="RadGridDonvidutoan_ItemDeleted" oniteminserted="RadGridDonvidutoan_ItemInserted" 
    onitemupdated="RadGridDonvidutoan_ItemUpdated" 
    onitemcommand="RadGridDonvidutoan_ItemCommand" 
    onitemdatabound="RadGridDonvidutoan_ItemDataBound">
     <GroupingSettings CaseSensitive ="false"  />
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
    <MasterTableView Name="MasterTableViewDonvidutoan" CommandItemDisplay="Top" DataSourceID="DonvidutoansDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b>Quản lý đơn vị dự toán</b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridDonvidutoan.EditIndexes.Count == 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridDonvidutoan.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Update.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridDonvidutoan.EditIndexes.Count > 0 || RadGridDonvidutoan.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridDonvidutoan.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="PerformInsert" Visible='<%# RadGridDonvidutoan.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Insert.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:return confirm('Bạn có muốn xóa bản ghi đã chọn không?')" runat="server" CommandName="DeleteSelected"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Delete.gif" />Xóa</asp:LinkButton>&nbsp;&nbsp;
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
                <telerik:GridBoundColumn UniqueName="PK_ID" HeaderText="ID" DataField="PK_ID" Visible="false">
                </telerik:GridBoundColumn>
                 <telerik:GridTemplateColumn UniqueName="STT" HeaderText="STT"  HeaderStyle-Width ="70px"  HeaderStyle-HorizontalAlign ="Center">
                <FilterTemplate>
                            <asp:Button ID="btnSearch" Text="Tìm" runat="server"/>
                            <asp:ImageButton ID="btnShowAll" runat="server" ImageUrl="../Images/Grid/filterCancel.gif" AlternateText="Xem tất" ToolTip="Xem tất" OnClick="btnShowAll_Click" Style="vertical-align: middle" />
                    </FilterTemplate>
					<ItemTemplate>
						<asp:Label ID="lblSTT" runat="server"/>
					</ItemTemplate>
                    <ItemStyle HorizontalAlign = "Center" Width ="70px" />
				</telerik:GridTemplateColumn>
                <telerik:GridBoundColumn UniqueName="TENDONVI" HeaderText="Tên đề tài, dự án" DataField="TENDONVI"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="MADUTOAN" HeaderText="Mã quan hệ ngân sách" DataField="MADUTOAN" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>                            
        </Columns>
        <EditFormSettings InsertCaption="Thêm đơn vị dự toán mới" CaptionFormatString="Sửa đơn vị dự toán: <b>{0}</b>" CaptionDataField="TENDONVI" EditFormType="Template" PopUpSettings-Width="800px">
             <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
             <FormTemplate>
             <div class="headerthongtin">
              <ul>
                <li class="lifirst"><asp:LinkButton ID="btnSave" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'><img src="Images/img_save.jpg" /><%# (Container is GridEditFormInsertItem) ? "Lưu" : "Lưu" %></asp:LinkButton></li>
                     <li><asp:LinkButton ID="btnClose" runat="server" CommandName="Cancel"><img src="Images/img_Close.jpg" />Đóng</asp:LinkButton></li>                     
              </ul>
            </div>               
            <div class="clearfix bgpopup"> 
            <center>
            <div style="width:800px;background:#FFFFFF" class="clearfix">      
            <table id="tblEdit" class ="TableEditInGrid" cellspacing="3" cellpadding="3" style="width: 100%" border="0">
            <tr>
	             <td style =" width:150px;"> <span class="rtsTxtnew">Tên đơn vị dự toán:</span></td>
	            <td colspan="4">
                     <asp:TextBox ID="txtID" Text='<%# Eval( "PK_ID") %>' Visible="false" runat="server"></asp:TextBox>
                     <telerik:RadTextBox ID="txtTENDONVI" Width="95%" Text='<%# Bind("TENDONVI") %>' runat="server"></telerik:RadTextBox>
                     <asp:RequiredFieldValidator ID="rfvTENDONVI" runat="server" ErrorMessage="Tên đơn vị dự toán không thể rỗng" ControlToValidate="txtTENDONVI" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>                                
                     <asp:CustomValidator ID="cuvID" ControlToValidate="txtTENDONVI" OnServerValidate="CheckTENDONVI" runat="server" ErrorMessage="Tên đơn vị dự toán đã tồn tại" Display="Dynamic" ValidationGroup="G1"></asp:CustomValidator>    
                </td>
            </tr>
            <tr>
	             <td style =" width:150px;"> <span class="rtsTxtnew">Mã quan hệ ngân sách:</span></td>
	            <td colspan="4">
                     <telerik:RadTextBox ID="txtMADUTOAN" Width="95%" Text='<%# Bind("MADUTOAN") %>' runat="server"></telerik:RadTextBox>
                     <asp:RequiredFieldValidator ID="rfvMADUTOAN" runat="server" ErrorMessage="Mã quan hệ ngân sách không thể rỗng" ControlToValidate="txtMADUTOAN" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>                                
                </td>
            </tr>                                       
            </table>
            <div style="clear:both"></div>                                                   
            <div class="headerthongtin">
            </div>
            </div> 
             </center> 
        <!-- end bgpopup--></div>    
             </FormTemplate>
        </EditFormSettings>
        </MasterTableView>
        <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G1"/>
        <ClientSettings>
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
            <ClientEvents OnRowDblClick="RowDblClickDonvidutoan" OnRowContextMenu="RowContextMenuDonvidutoan" OnPopUpShowing="PopUpShowingSmall"/>
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<telerik:RadContextMenu ID="RadMenuDonvidutoan" runat="server" OnClientItemClicked ="RadMenuDonvidutoan_ItemClientClick" EnableRoundedCorners="true" EnableShadows="true">
        <Items>            
            <telerik:RadMenuItem Text="Thông tin thu, chi, nộp ngân sách, số chuyển năm sau..." Value ="SXKD" ImageUrl ="../images/img_save.jpg" />
            <telerik:RadMenuItem Text="Thông tin số phí, lệ phí" Value ="LEPHI" ImageUrl ="../images/img_save.jpg" />
            <telerik:RadMenuItem Text="Thông tin tiếp nhận sử dụng viện trợ" Value ="VIENTRO" ImageUrl ="../images/img_save.jpg" />
            <telerik:RadMenuItem Text="Đề tài dự án khoa học" Value ="DTKH" ImageUrl ="../images/img_save.jpg" />
        </Items>
</telerik:RadContextMenu>
<telerik:RadWindowManager ReloadOnShow="true" ShowContentDuringLoad="false" ID="RadWindowManagerDonvidutoan" runat="server" VisibleStatusbar="False"
   OnClientClose="OnClientCloseDonvidutoan" OnClientShow="OnClientShowDonvidutoan" Behaviors ="Close,Reload" ></telerik:RadWindowManager>
<asp:SqlDataSource ID="DonvidutoansDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
        DeleteCommand="DELETE FROM DUTOANDONVI WHERE PK_ID = @PK_ID" 
        InsertCommand="INSERT INTO DUTOANDONVI (TENDONVI,MADUTOAN) VALUES (@TENDONVI,@MADUTOAN)"
        SelectCommand="SELECT DUTOANDONVI.PK_ID,DUTOANDONVI.TENDONVI,DUTOANDONVI.MADUTOAN FROM DUTOANDONVI"
        UpdateCommand="UPDATE DUTOANDONVI SET TENDONVI=@TENDONVI,MADUTOAN=@MADUTOAN WHERE PK_ID = @PK_ID">
        <UpdateParameters>
            <asp:Parameter Name="TENDONVI" Type="String" ConvertEmptyStringToNull="False"/>            
            <asp:Parameter Name="MADUTOAN" Type="String" ConvertEmptyStringToNull="False"/>
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="PK_ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="TENDONVI" Type="String" ConvertEmptyStringToNull="False"/>            
            <asp:Parameter Name="MADUTOAN" Type="String" ConvertEmptyStringToNull="False"/>
        </InsertParameters>
</asp:SqlDataSource>
