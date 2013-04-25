<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UserCompanys.ascx.cs" Inherits="Modules_UserCompanys" %>
<%@ Register TagPrefix="custom" Namespace="ITCLIB.Filter" %>
<telerik:RadCodeBlock ID="RadCodeBlockUserCompany" runat="server">
<script type="text/javascript">
        function RowDblClickUserCompany(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("UserCompanys") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewUserCompany") && (CanEdit == "True")) {
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
    function GetGridServerElementDoanhNghiep(serverID, tagName) {
        if (!tagName)
            tagName = "*";

        var grid = $get("<%=RadGridUserCompany.ClientID %>");
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
    function OnClientLoadDoanhNghiep(sender) {
        comboBox = sender;
    }
    function ClientNodeClicking(sender, args) {
        var txtpk = GetGridServerElementDoanhNghiep("hfParent");
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
<script type="text/javascript">
    var cmbDoangnghep;
    function OnClientLoadcmbDoangnghep(sender) {
        cmbDoangnghep = sender;
    }
    function listDoangNghiepClientNodeClicking(sender, args) {
        var hfFK_DEPT = document.getElementById("ContentPlaceHolder_ctl00_hfFilter");
        var node = args.get_node();
        if (node == null) {
            hfFK_DEPT.value = "0";
            cmbDoangnghep.set_value("");
            cmbDoangnghep.set_text("Chọn doanh nghiệp mẹ");
        }
        else {
            hfFK_DEPT.value = node.get_value();
            cmbDoangnghep.set_value(node.get_value());
            cmbDoangnghep.set_text(node.get_text());
            cmbDoangnghep.trackChanges();
            cmbDoangnghep.get_items().getItem(0).set_text(node.get_text());
            cmbDoangnghep.commitChanges();
            cmbDoangnghep.hideDropDown();
        }
        $find("<%= RadGridUserCompany.ClientID %>").get_masterTableView().rebind();
    }

    function StopPropagation(e) {
        if (!e) {
            e = window.event;
        }

        e.cancelBubble = true;
    }

    function cmbDoangnghepOnClientDropDownOpenedHandler(sender, eventArgs) {
        var tree = sender.get_items().getItem(0).findControl("radViewDoangnghiep");
        var selectedNode = tree.get_selectedNode();
        if (selectedNode) {
            selectedNode.scrollIntoView();
        }
    }
</script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelUserCompany" runat="server" />
<telerik:RadGrid ID="RadGridUserCompany" runat="server" Skin="Vista" 
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="true"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="UserCompanysDataSource" ShowFooter="True"
    ondatabound="RadGridUserCompany_DataBound" 
    onitemdeleted="RadGridUserCompany_ItemDeleted" oniteminserted="RadGridUserCompany_ItemInserted" 
    onitemupdated="RadGridUserCompany_ItemUpdated" 
    onitemcommand="RadGridUserCompany_ItemCommand" 
    onitemdatabound="RadGridUserCompany_ItemDataBound">
     <GroupingSettings CaseSensitive ="false"  />
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
    <MasterTableView Name="MasterTableViewUserCompany" CommandItemDisplay="Top" DataSourceID="UserCompanysDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b>Quản lý người dùng công ty</b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridUserCompany.EditIndexes.Count == 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridUserCompany.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Update.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridUserCompany.EditIndexes.Count > 0 || RadGridUserCompany.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridUserCompany.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="PerformInsert" Visible='<%# RadGridUserCompany.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Insert.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
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
                <telerik:GridTemplateColumn UniqueName="TENDOANHNGHIEP" HeaderText="Tên công ty" DataField="TENDOANHNGHIEP" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                    <ItemTemplate>
                        <%# Eval("TENDOANHNGHIEP")%>
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
                <custom:FilteringGroupUserCompany UniqueName="GROUPUSERNAME" DataField="GROUPUSERNAME" HeaderText="Nhóm người dùng" FilterControlWidth="100%">
                   <itemtemplate>
                         <%# Eval("GROUPUSERNAME")%>
                   </itemtemplate>
                </custom:FilteringGroupUserCompany>             
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
	             <td style =" width:150px;"> <span class="rtsTxtnew">Công ty:</span></td>
	            <td colspan="4">
                    <asp:TextBox ID="txtID" Text='<%# Eval( "PK_ID") %>' Visible="false" runat="server"></asp:TextBox>
                    <tr>
<td>
    Doanh nghiệp trực thuộc:
</td>
<td colspan ="3">
 <asp:HiddenField ID="hfParent" runat="server"  Value ='<%# Bind("FK_DOANHNGHIEP")%>'/>
<telerik:RadComboBox ID="rcbParent" runat="server" Width="99%" ShowToggleImage="True" Style="vertical-align: middle;" 
EmptyMessage="Chọn doanh nghiệp" ExpandAnimation-Type="None" CollapseAnimation-Type="None">
        <ItemTemplate>
        <div id ="div1">
                    <telerik:RadTreeView runat="server" ID="RadTreViewDir" OnClientNodeClicking ="ClientNodeClicking" 
                    Width="100%" Height="200px" DataFieldID="PK_ID" DataFieldParentID="FK_DOANHNGHIEP" DataSourceID="DoanhNghiepTreelist" 
                        DataTextField="TENDOANHNGHIEP" DataValueField="PK_ID" >                        
                    </telerik:RadTreeView>
            </div>
        </ItemTemplate>
            <Items>
            <telerik:RadComboBoxItem Text=""  />
        </Items>
<ExpandAnimation Type="None"></ExpandAnimation>
<CollapseAnimation Type="None"></CollapseAnimation>
</telerik:RadComboBox>
            <script type="text/javascript">
                var div1 = document.getElementById("div1");
                div1.onclick = StopPropagation;
            </script>
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorCompany" runat="server" ForeColor ="Red" ErrorMessage="Hãy chọn công ty" ControlToValidate="rcbParent" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>            
                </td>
            </tr>
            <tr>
	             <td style =" width:150px;"> <span class="rtsTxtnew">Tên đăng nhập:</span></td>
	            <td colspan="4">
                     <asp:TextBox ID="txtLoginName" Width="200px" Text='<%# Bind( "C_LoginName") %>' runat="server"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="rfvLoginName" runat="server" ErrorMessage="Tên đăng nhập không thể rỗng" ControlToValidate="txtLoginName" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>                                
                     <asp:CustomValidator ID="cuvID" ControlToValidate="txtLoginName" OnServerValidate="CheckLoginName" runat="server" ErrorMessage="Tên đăng nhập đã tồn tại" Display="Dynamic" ValidationGroup="G1"></asp:CustomValidator>
                     <asp:RegularExpressionValidator id="regUserCompany" ControlToValidate="txtLoginName" ValidationExpression= "^([\u0080-\ua7ffa-zA-Z0-9'_\s])+$" Display="Dynamic" ErrorMessage="Không thể nhập kí tự đặc biệt" ValidationGroup="G1" runat="server"></asp:RegularExpressionValidator>                             
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
                 <asp:TextBox ID="txtDesc" Text='<%# Bind( "C_DESC") %>' TextMode="MultiLine" runat="server" Columns="1" Rows="2" Width="90%"></asp:TextBox>
              </td>
             </tr> 
             <tr>
               <td style =" width:150px;"> <span class="rtsTxtnew">Nhóm người dùng:</td>
              <td colspan="4">
                 <asp:DropDownList ID="ddlGroupUserCompany" SelectedValue='<%# Bind("FK_GROUPUSER") %>' DataTextField="C_NAME" DataValueField="PK_ID" runat="server" DataSourceID="GroupUserDataSource" AppendDataBoundItems="True">
                    <asp:ListItem Value="" Text="Chọn"></asp:ListItem>
                 </asp:DropDownList>
                 <asp:RequiredFieldValidator ID="rfvGroupUserCompany" runat="server" ErrorMessage="Hãy chọn nhóm người dùng" ControlToValidate="ddlGroupUserCompany" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>                                                                
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
            <ClientEvents OnRowDblClick="RowDblClickUserCompany" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<asp:SqlDataSource ID="UserCompanysDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
        DeleteCommand="DELETE FROM USERS WHERE PK_ID = @PK_ID" 
        InsertCommand="INSERT INTO USERS (FK_GROUPUSER,FK_DEPT,FK_DOANHNGHIEP,C_LoginName,C_Password,C_NAME,C_Address,c_Tel,C_Email,C_DESC) VALUES (@FK_GROUPUSER,0,@FK_DOANHNGHIEP, @C_LoginName,@C_Password,@C_NAME,@C_Address,@c_Tel,@C_Email,@C_DESC)"
        SelectCommand="SELECT USERS.PK_ID,USERS.FK_GroupUser,USERS.FK_DOANHNGHIEP,USERS.C_LoginName,USERS.C_Password,USERS.C_NAME,USERS.C_Address,USERS.c_Tel,USERS.C_Email,USERS.C_DESC,GROUPUSER.C_NAME AS GROUPUSERNAME,DOANHNGHIEP.TENDOANHNGHIEP FROM USERS INNER JOIN GROUPUSER ON  USERS.FK_GROUPUSER = GROUPUSER.PK_ID INNER JOIN DOANHNGHIEP ON USERS.FK_DOANHNGHIEP = DOANHNGHIEP.PK_ID WHERE FK_GroupUser <> 0 AND GROUPUSER.C_TYPE = 1 order by LTRIM(DOANHNGHIEP.TENDOANHNGHIEP)"
        UpdateCommand="UPDATE USERS SET FK_GROUPUSER=@FK_GROUPUSER,C_LoginName = @C_LoginName, C_Password = ISNULL(@C_Password,C_Password),C_NAME=@C_NAME,C_Address=@C_Address,c_Tel=@c_Tel,C_Email=@C_Email,C_DESC=@C_DESC WHERE PK_ID = @PK_ID">
        <UpdateParameters>
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
            <asp:Parameter Name="FK_DOANHNGHIEP" Type="String" ConvertEmptyStringToNull="False"/>
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
   SelectCommand="SELECT GROUPUSER.PK_ID,GROUPUSER.C_NAME FROM GROUPUSER WHERE PK_ID <> 0  AND C_TYPE = 1 order by LTRIM(GROUPUSER.C_NAME)">
  </asp:SqlDataSource>
  <asp:SqlDataSource ID="DOANHNGHIEPDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
   SelectCommand="SELECT DOANHNGHIEP.PK_ID,DOANHNGHIEP.TENDOANHNGHIEP FROM DOANHNGHIEP order by LTRIM(DOANHNGHIEP.TENDOANHNGHIEP)">
  </asp:SqlDataSource>
  <asp:SqlDataSource ID="DoanhNghiepTreelist" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
    SelectCommand="SELECT 0 as PK_ID , NULL AS FK_DOANHNGHIEP, N'Root' AS TENDOANHNGHIEP FROM [DOANHNGHIEP] UNION SELECT PK_ID, FK_DOANHNGHIEP, TENDOANHNGHIEP FROM [DOANHNGHIEP]">
</asp:SqlDataSource>
