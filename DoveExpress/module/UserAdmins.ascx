﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UserAdmins.ascx.cs" Inherits="Modules_UserAdmins" %>
<%@ Register TagPrefix="custom" Namespace="ITCLIB.Filter" %>
<telerik:RadCodeBlock ID="RadCodeBlockUserAdmin" runat="server">
<script type="text/javascript">
        function RowDblClickUserAdmin(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("UserAdmins") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewUserAdmin") && (CanEdit == "True")) {
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
    function GetGridServerElementUserAdmin(serverID, tagName) {
        if (!tagName)
            tagName = "*";

        var grid = $get("<%=RadGridUserAdmin.ClientID %>");
        var elements = grid.getElementsByTagName(tagName);
        for (var i = 0; i < elements.length; i++) {
            var element = elements[i];
            if (element.id.indexOf(serverID) >= 0)
                return element;
        }
    }
  </script>
<script type="text/javascript">
      var cmbDept;
      function OnClientLoadDept(sender) {
          cmbDept = sender;
      }
      function nodeClicking(sender, args)
            {
                var hfFK_DEPT = GetGridServerElementUserAdmin("hfFK_DEPT");  
                var node = args.get_node()
                hfFK_DEPT.value = node.get_value();
                cmbDept.set_value(node.get_value());
                cmbDept.set_text(node.get_text());
                cmbDept.trackChanges();
                cmbDept.get_items().getItem(0).set_text(node.get_text());
                cmbDept.commitChanges();
                cmbDept.hideDropDown();
                // Call comboBox.attachDropDown if:
                // 1) The RadComboBox is inside an AJAX panel.
                // 2) The RadTreeView has a server-side event handler for the NodeClick event, i.e. it initiates a postback when clicking on a Node.
                // Otherwise the AJAX postback becomes a normal postback regardless of the outer AJAX panel.
                //comboBox.attachDropDown();
            }
            function StopPropagation(e)
            {
                if(!e)
                {
                    e = window.event;
                }

                e.cancelBubble = true;
            }            
            function OnClientDropDownOpenedHandler(sender, eventArgs)
            {
                var tree = sender.get_items().getItem(0).findControl("tvDept");
                var selectedNode = tree.get_selectedNode();
                if (selectedNode)
                {
                    selectedNode.scrollIntoView();
                }
            }
</script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelUserAdmin" runat="server" />
<telerik:RadGrid ID="RadGridUserAdmin" runat="server" Skin="Vista" 
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="true"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="UserAdminsDataSource" ShowFooter="True"
    ondatabound="RadGridUserAdmin_DataBound" 
    onitemdeleted="RadGridUserAdmin_ItemDeleted" oniteminserted="RadGridUserAdmin_ItemInserted" 
    onitemupdated="RadGridUserAdmin_ItemUpdated" 
    onitemcommand="RadGridUserAdmin_ItemCommand" 
    onitemdatabound="RadGridUserAdmin_ItemDataBound">
     <GroupingSettings CaseSensitive ="false"  />
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
    <MasterTableView Name="MasterTableViewUserAdmin" CommandItemDisplay="Top" DataSourceID="UserAdminsDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b>Quản lý người dùng hệ thống</b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridUserAdmin.EditIndexes.Count == 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridUserAdmin.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Update.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridUserAdmin.EditIndexes.Count > 0 || RadGridUserAdmin.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridUserAdmin.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="PerformInsert" Visible='<%# RadGridUserAdmin.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Insert.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
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
                <telerik:GridBoundColumn UniqueName="C_LoginName" HeaderText="Tên đăng nhập" DataField="C_LoginName"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn UniqueName="C_DEPTNAME" HeaderText="Tên phòng ban" DataField="C_DEPTNAME" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                    <ItemTemplate>
                        <%# Eval("C_DEPTNAME")%>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>  
                <telerik:GridBoundColumn UniqueName="C_NAME" HeaderText="Họ và tên" DataField="C_NAME"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_Address" HeaderText="Địa chỉ" DataField="C_Address"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_Tel" HeaderText="Số điện thoại" DataField="C_Tel"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_Email" HeaderText="Email" DataField="C_Email"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <custom:FilteringGroupUserAdmin UniqueName="GROUPUSERNAME" DataField="GROUPUSERNAME" HeaderText="Nhóm người dùng" FilterControlWidth="100%">
                   <itemtemplate>
                         <%# Eval("GROUPUSERNAME")%>
                   </itemtemplate>
                </custom:FilteringGroupUserAdmin>             
        </Columns>
        <EditFormSettings InsertCaption="Thêm người dùng mới" CaptionFormatString="Sửa người dùng: <b>{0}</b>" CaptionDataField="C_LOGINNAME" EditFormType="Template" PopUpSettings-Width="800px">
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
	             <td style =" width:150px;"> <span class="rtsTxtnew">Phòng ban:</span></td>
	            <td colspan="4">
                    <asp:TextBox ID="txtID" Text='<%# Eval( "PK_ID") %>' Visible="false" runat="server"></asp:TextBox>
                    <asp:HiddenField ID="hfFK_DEPT" runat="server"  Value ='<%# Bind("FK_DEPT")%>'/>
                    <telerik:RadComboBox ID="cmbDept" runat="server" Width="250px" ShowToggleImage="True" Style="vertical-align: middle;" OnClientDropDownOpened="OnClientDropDownOpenedHandler" OnClientLoad ="OnClientLoadDept"
                    EmptyMessage="Chọn phòng ban" ExpandAnimation-Type="None" CollapseAnimation-Type="None">
                        <ItemTemplate>
                            <div id="div1">
                                <telerik:RadTreeView runat="server" ID="tvDept" OnClientNodeClicking="nodeClicking" Width="100%" Height="140px" DataFieldID="PK_ID" DataFieldParentID="C_PARENT" DataSourceID="DeptDataSource" 
                                     DataTextField="C_NAME" DataValueField="PK_ID">
                                </telerik:RadTreeView>
                            </div>
                        </ItemTemplate>
                        <Items>
                            <telerik:RadComboBoxItem Text="" />
                        </Items>
                    </telerik:RadComboBox>                    
                </td>
            </tr>
            <tr>
	             <td style =" width:150px;"> <span class="rtsTxtnew">Tên đăng nhập:</span></td>
	            <td colspan="4">
                     <asp:TextBox ID="txtLoginName" Width="200px" Text='<%# Bind( "C_LoginName") %>' runat="server"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="rfvLoginName" runat="server" ErrorMessage="Tên đăng nhập không thể rỗng" ControlToValidate="txtLoginName" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>                                
                     <asp:CustomValidator ID="cuvID" ControlToValidate="txtLoginName" OnServerValidate="CheckLoginName" runat="server" ErrorMessage="Tên đăng nhập đã tồn tại" Display="Dynamic" ValidationGroup="G1"></asp:CustomValidator>
                     <asp:RegularExpressionValidator id="regUserAdmin" ControlToValidate="txtLoginName" ValidationExpression= "^([\u0080-\ua7ffa-zA-Z0-9'_\s])+$" Display="Dynamic" ErrorMessage="Không thể nhập kí tự đặc biệt" ValidationGroup="G1" runat="server"></asp:RegularExpressionValidator>                             
                </td>
            </tr>
            <tr>
	             <td style =" width:150px;"> <span class="rtsTxtnew">Mật khẩu:</span></td>
	            <td colspan="4">
                     <asp:TextBox ID="txtPassword" Width="200px" TextMode="Password" runat="server"></asp:TextBox>                                
                     <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Mật khẩu không thể rỗng" ControlToValidate="txtPassword" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1" Enabled="<%# (Container is GridEditFormInsertItem)%>"></asp:RequiredFieldValidator>                                
                     <asp:RegularExpressionValidator id="regPass" ControlToValidate="txtPassword" ValidationExpression="^([\u0080-\ua7ffa-zA-Z0-9'_\s])+$" Display="Dynamic" ErrorMessage="Không thể nhập kí tự đặc biệt" ValidationGroup="G1" runat="server"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
	             <td style =" width:150px;"> <span class="rtsTxtnew">Xác nhận mật khẩu:</span></td>
	            <td colspan="4">
                    <asp:TextBox ID="txtCPassword" Width="200px" TextMode="Password" runat="server" ></asp:TextBox>
                    <asp:CompareValidator ID="cvCPassword" runat="server" ErrorMessage="Xác nhận mật khẩu không trùng nhau" ControlToCompare="txtPassword" ControlToValidate="txtCPassword" SetFocusOnError="True" ValidationGroup="G1" Display="Dynamic"></asp:CompareValidator>            
                </td>
            </tr>
            <tr>
                <td style =" width:150px;"> <span class="rtsTxtnew">Họ và tên:</td>
               <td colspan="4">
                   <asp:TextBox ID="txtC_NAME" Width="200px" Text='<%# Bind( "C_NAME") %>' runat="server"></asp:TextBox>
                   <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ErrorMessage="Họ và Tên không thể rỗng" ControlToValidate="txtC_NAME" SetFocusOnError="True" ValidationGroup="G1" Display="Dynamic"></asp:RequiredFieldValidator>
               </td>
            </tr> 
            <tr>
                 <td style =" width:150px;"> <span class="rtsTxtnew">Địa chỉ:</td>
                <td colspan="4">
                   <asp:TextBox ID="txtAddress" Width="90%" Text='<%# Bind( "C_Address") %>' runat="server"></asp:TextBox>
                </td>
            </tr> 
            <tr>
                 <td style =" width:150px;"> <span class="rtsTxtnew">Điện thoại:</td>
                <td colspan="4">
                   <asp:TextBox ID="txtTel" Width="100px" Text='<%# Bind( "C_Tel") %>' runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                 <td style =" width:150px;"> <span class="rtsTxtnew">Email:</td>
                <td colspan="4">
                    <asp:TextBox ID="txtEmail" Width="100px" Text='<%# Bind( "C_Email") %>' runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Email không thể rỗng" ControlToValidate="txtEmail" SetFocusOnError="True" ValidationGroup="G1" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ErrorMessage="Email sai định dạng" ControlToValidate="txtEmail" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"  ValidationGroup="G1" Display="Dynamic"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
               <td style =" width:150px;"> <span class="rtsTxtnew">Mô tả người dùng:</td>
              <td colspan="4">
                 <telerik:RadTextBox ID="txtDesc" Text='<%# Bind( "C_DESC") %>' TextMode="MultiLine" runat="server" Columns="1" Rows="3" Width="90%"></telerik:RadTextBox>
              </td>
             </tr> 
             <tr>
               <td style =" width:150px;"> <span class="rtsTxtnew">Nhóm người dùng:</td>
              <td colspan="4">
                 <asp:DropDownList ID="ddlGroupUserAdmin" SelectedValue='<%# Bind("FK_GROUPUSER") %>' DataTextField="C_NAME" DataValueField="PK_ID" runat="server" DataSourceID="GroupUserDataSource" AppendDataBoundItems="True">
                    <asp:ListItem Value="" Text="Chọn"></asp:ListItem>
                 </asp:DropDownList>
                 <asp:RequiredFieldValidator ID="rfvGroupUserAdmin" runat="server" ErrorMessage="Hãy chọn nhóm người dùng" ControlToValidate="ddlGroupUserAdmin" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>                                                                
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
            <ClientEvents OnPopUpShowing="PopUpShowingSmall" />
            <ClientEvents OnRowDblClick="RowDblClickUserAdmin" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<asp:SqlDataSource ID="UserAdminsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
        DeleteCommand="DELETE FROM USERS WHERE PK_ID = @PK_ID" 
        InsertCommand="INSERT INTO USERS (FK_GROUPUSER,FK_DEPT,FK_DOANHNGHIEP,C_LoginName,C_Password,C_NAME,C_Address,c_Tel,C_Email,C_DESC) VALUES (@FK_GROUPUSER,@FK_DEPT,0, @C_LoginName,@C_Password,@C_NAME,@C_Address,@c_Tel,@C_Email,@C_DESC)"
        SelectCommand="SELECT USERS.PK_ID,USERS.FK_GroupUser,USERS.FK_DEPT,USERS.C_LoginName,USERS.C_Password,USERS.C_NAME,USERS.C_Address,USERS.c_Tel,USERS.C_Email,USERS.C_DESC,GROUPUSER.C_NAME AS GROUPUSERNAME,DMPHONGBAN.C_NAME AS C_DEPTNAME FROM USERS INNER JOIN GROUPUSER ON  USERS.FK_GROUPUSER = GROUPUSER.PK_ID LEFT OUTER JOIN DMPHONGBAN ON USERS.FK_DEPT = DMPHONGBAN.PK_ID WHERE FK_GroupUser <> 0 AND GROUPUSER.C_TYPE = 0"
        UpdateCommand="UPDATE USERS SET FK_GROUPUSER=@FK_GROUPUSER,FK_DEPT=@FK_DEPT,C_LoginName = @C_LoginName, C_Password = ISNULL(@C_Password,C_Password),C_NAME=@C_NAME,C_Address=@C_Address,c_Tel=@c_Tel,C_Email=@C_Email,C_DESC=@C_DESC WHERE PK_ID = @PK_ID">
        <UpdateParameters>
            <asp:Parameter Name="FK_DEPT" Type="String" ConvertEmptyStringToNull="False"/>            
            <asp:Parameter Name="FK_GROUPUSER" Type="String" ConvertEmptyStringToNull="False"/>
            <asp:Parameter Name="C_LoginName" Type="String" />
            <asp:Parameter Name="C_Password" Type="String" />
            <asp:Parameter Name="C_NAME" Type="String" />
            <asp:Parameter Name="C_Address" Type="String" />
            <asp:Parameter Name="C_Tel" Type="String" />
            <asp:Parameter Name="C_Email" Type="String" />
            <asp:Parameter Name="C_DESC" Type="String" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="PK_ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="FK_DEPT" Type="String" ConvertEmptyStringToNull="False"/>
            <asp:Parameter Name="FK_GROUPUSER" Type="String" ConvertEmptyStringToNull="False"/>
            <asp:Parameter Name="C_LoginName" Type="String" />
            <asp:Parameter Name="C_Password" Type="String" />
            <asp:Parameter Name="C_NAME" Type="String" />
            <asp:Parameter Name="C_Address" Type="String" />
            <asp:Parameter Name="C_Tel" Type="String" />
            <asp:Parameter Name="C_Email" Type="String" />
            <asp:Parameter Name="C_DESC" Type="String" />
        </InsertParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="GroupUserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
   SelectCommand="SELECT GROUPUSER.PK_ID,GROUPUSER.C_NAME FROM GROUPUSER WHERE PK_ID <> 0  AND C_TYPE = 0 order by LTRIM(GROUPUSER.C_NAME)">
  </asp:SqlDataSource>
  <asp:SqlDataSource ID="DeptDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
   SelectCommand="SELECT DMPHONGBAN.PK_ID,DMPHONGBAN.C_NAME,DMPHONGBAN.C_PARENT FROM DMPHONGBAN order by LTRIM(DMPHONGBAN.C_NAME)">
  </asp:SqlDataSource>