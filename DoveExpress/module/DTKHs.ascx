<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DTKHs.ascx.cs" Inherits="module_DTKHs" %>
<%@ Register TagPrefix="custom" Namespace="ITCLIB.Filter" %>
<telerik:RadCodeBlock ID="RadCodeBlockDTKH" runat="server">
<script type="text/javascript">
        function RowDblClickDTKH(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("DTKHs") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewDTKH") && (CanEdit == "True")) {
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
    function GetGridServerElementDTKH(serverID, tagName) {
        if (!tagName)
            tagName = "*";

        var grid = $get("<%=RadGridDTKH.ClientID %>");
        var elements = grid.getElementsByTagName(tagName);
        for (var i = 0; i < elements.length; i++) {
            var element = elements[i];
            if (element.id.indexOf(serverID) >= 0)
                return element;
        }
    }
  </script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelDTKH" runat="server" />
<telerik:RadGrid ID="RadGridDTKH" runat="server" Skin="Windows7" 
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="true"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="DTKHsDataSource" ShowFooter="True"
    ondatabound="RadGridDTKH_DataBound" 
    onitemdeleted="RadGridDTKH_ItemDeleted" oniteminserted="RadGridDTKH_ItemInserted" 
    onitemupdated="RadGridDTKH_ItemUpdated" 
    onitemcommand="RadGridDTKH_ItemCommand" 
    onitemdatabound="RadGridDTKH_ItemDataBound">
     <GroupingSettings CaseSensitive ="false"  />
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
    <MasterTableView Name="MasterTableViewDTKH" CommandItemDisplay="Top" DataSourceID="DTKHsDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b><asp:Label ID="lblTitle" ForeColor ="Red" runat="server"></asp:Label></b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridDTKH.EditIndexes.Count == 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridDTKH.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Update.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridDTKH.EditIndexes.Count > 0 || RadGridDTKH.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridDTKH.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="PerformInsert" Visible='<%# RadGridDTKH.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Insert.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
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
                <telerik:GridBoundColumn UniqueName="TENDETAI" HeaderText="Tên đề tài, dự án" DataField="TENDETAI"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="SOTIEN" HeaderText="Số tiền" DataField="SOTIEN" AllowFiltering="false">
                </telerik:GridBoundColumn>  
                <telerik:GridBoundColumn UniqueName="NAMTHUCHIEN" HeaderText="Năm thực hiện" DataField="NAMTHUCHIEN"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="CHUNHIEM" HeaderText="Chủ nhiệm" DataField="CHUNHIEM"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="TENDONVI" HeaderText="Đơn vị thực hiện" DataField="TENDONVI" AllowFiltering="false">
                </telerik:GridBoundColumn>
                <custom:FilteringGroupDTKH UniqueName="TINHTRANG" DataField="TINHTRANG" HeaderText="Tình trạng" FilterControlWidth="100%">
                   <itemtemplate>
                         <%# Eval("TINHTRANG")%>
                   </itemtemplate>
                </custom:FilteringGroupDTKH>             
        </Columns>
        <EditFormSettings InsertCaption="Thêm dự án, đề tài khoa học mới" CaptionFormatString="Sửa dự án, đề tài khoa học: <b>{0}</b>" CaptionDataField="TENDETAI" EditFormType="Template" PopUpSettings-Width="800px">
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
                <tr>
	             <td style =" width:150px;"> <span class="rtsTxtnew">Đơn vị thực hiện:</span></td>
	            <td colspan="4">
                     <asp:TextBox ID="txtDONVITHUCHIEN" Width="300px" runat="server" ReadOnly="True"></asp:TextBox>
                </td>
                </tr>
	             <td style =" width:150px;"> <span class="rtsTxtnew">Tên dự án, đề tài khoa học:</span></td>
	            <td colspan="4">
                     <asp:TextBox ID="txtID" Text='<%# Eval( "PK_ID") %>' Visible="false" runat="server"></asp:TextBox>
                     <asp:TextBox ID="txtTENDETAI" Width="300px" Text='<%# Bind("TENDETAI") %>' runat="server"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="rfvTENDETAI" runat="server" ErrorMessage="Tên đề tài không thể rỗng" ControlToValidate="txtTENDETAI" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>                                
                     <asp:CustomValidator ID="cuvID" ControlToValidate="txtTENDETAI" OnServerValidate="CheckTENDETAI" runat="server" ErrorMessage="Tên đè tài đã tồn tại" Display="Dynamic" ValidationGroup="G1"></asp:CustomValidator>    
                </td>
            </tr>
            <tr>
	             <td style =" width:150px;"> <span class="rtsTxtnew">Số tiền:</span></td>
	            <td colspan="4">
                     <telerik:RadNumericTextBox ID="txtSOTIEN" Text='<%# Bind("SOTIEN") %>' runat="server" CssClass="iputnam" Width="100px" Font-Size="11px" NumberFormat-DecimalDigits=0 NumberFormat-GroupSeparator="" EnabledStyle-HorizontalAlign="Right"></telerik:RadNumericTextBox>                     
                </td>
            </tr>
            <tr>
	             <td style =" width:150px;"> <span class="rtsTxtnew">Năm thực hiện:</span></td>
	            <td colspan="4">
                     <asp:TextBox ID="txtNAMTHUCHIEN" Width="200px" Text='<%# Bind("NAMTHUCHIEN") %>' runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
	             <td style =" width:150px;"> <span class="rtsTxtnew">Chủ nhiệm:</span></td>
	            <td colspan="4">
                     <asp:TextBox ID="txtCHUNHIEM" Width="300px" Text='<%# Bind("CHUNHIEM") %>' runat="server"></asp:TextBox>
                </td>
            </tr>            
             <tr>
	            <td style =" width:150px;"> <span class="rtsTxtnew">Tình trạng:</span></td>
               <td colspan="4">
                           <asp:RadioButtonList ID="rblTINHTRANG" RepeatDirection="Horizontal"  runat="server" SelectedValue='<%# Bind("TINHTRANG") %>'>
                                <asp:ListItem Text="" Value="" style="display: none" />
                                <asp:ListItem Text="Không thực hiện" Value="Không thực hiện"></asp:ListItem>
                                <asp:ListItem Text="Chưa nghiệm thu" Value="Chưa nghiệm thu"></asp:ListItem>
                                <asp:ListItem Text="Đã nghiệm thu" Value="Đã nghiệm thu"></asp:ListItem>
                        </asp:RadioButtonList>
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
            <ClientEvents OnPopUpShowing="PopUpShowing" />
            <ClientEvents OnRowDblClick="RowDblClickDTKH" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<asp:SqlDataSource ID="DTKHsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
        DeleteCommand="DELETE FROM DUTOANDETAI WHERE PK_ID = @PK_ID" 
        InsertCommand="INSERT INTO DUTOANDETAI (TENDETAI,SOTIEN,NAMTHUCHIEN,CHUNHIEM,FK_DONVIDUTOAN,TINHTRANG) VALUES (@TENDETAI,@SOTIEN,@NAMTHUCHIEN, @CHUNHIEM,@FK_DONVIDUTOAN,@TINHTRANG)"
        SelectCommand="SELECT DUTOANDETAI.PK_ID,DUTOANDETAI.TENDETAI,DUTOANDETAI.SOTIEN,DUTOANDETAI.NAMTHUCHIEN,DUTOANDETAI.CHUNHIEM,DUTOANDETAI.TINHTRANG,DUTOANDONVI.TENDONVI FROM DUTOANDETAI LEFT OUTER JOIN DUTOANDONVI ON DUTOANDETAI.FK_DONVIDUTOAN = DUTOANDONVI.PK_ID WHERE FK_DONVIDUTOAN =@FK_DONVIDUTOAN"
        UpdateCommand="UPDATE DUTOANDETAI SET TENDETAI=@TENDETAI,SOTIEN=@SOTIEN,NAMTHUCHIEN = @NAMTHUCHIEN, CHUNHIEM = @CHUNHIEM,TINHTRANG=@TINHTRANG WHERE PK_ID = @PK_ID">
        <UpdateParameters>
            <asp:Parameter Name="TENDETAI" Type="String" ConvertEmptyStringToNull="False"/>            
            <asp:Parameter Name="SOTIEN" Type="String" ConvertEmptyStringToNull="False"/>
            <asp:Parameter Name="NAMTHUCHIEN" Type="String" />
            <asp:Parameter Name="CHUNHIEM" Type="String" />
            <asp:Parameter Name="TINHTRANG" Type="String" />
        </UpdateParameters>
        <SelectParameters>
             <asp:QueryStringParameter Name="FK_DONVIDUTOAN" Type="Int32" QueryStringField="dtID" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="PK_ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="TENDETAI" Type="String" ConvertEmptyStringToNull="False"/>            
            <asp:Parameter Name="SOTIEN" Type="String" ConvertEmptyStringToNull="False"/>
            <asp:Parameter Name="NAMTHUCHIEN" Type="String" />
            <asp:Parameter Name="CHUNHIEM" Type="String" />
            <asp:QueryStringParameter Name="FK_DONVIDUTOAN" Type="Int32" QueryStringField="dtID" />
            <asp:Parameter Name="TINHTRANG" Type="String" />
        </InsertParameters>
</asp:SqlDataSource>