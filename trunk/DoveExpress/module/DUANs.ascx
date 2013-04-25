<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DUANs.ascx.cs" Inherits="module_DUANs" %>
<%@ Register TagPrefix="custom" Namespace="ITCLIB.Filter" %>
<%@ Register TagPrefix="uc1" TagName="DUANVON" Src="DUANVON.ascx" %>
<telerik:RadCodeBlock ID="RadCodeBlockDUAN" runat="server">
<script type="text/javascript">
        function RowDblClickDUAN(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("DUANs") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewDUAN") && (CanEdit == "True")) {
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
    function GetGridServerElementDUAN(serverID, tagName) {
        if (!tagName)
            tagName = "*";

        var grid = $get("<%=RadGridDUAN.ClientID %>");
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

        var txtpk = GetGridServerElementDUAN("hfParent");
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
        var tree = sender.get_items().getItem(0).findControl("RadTreViewDir");
        var selectedNode = tree.get_selectedNode();
        if (selectedNode) {
            selectedNode.scrollIntoView();
        }
    }
    function OnClientShowDUAN(sender, eventArgs) {

    }
    function OnClientCloseDUAN(sender, eventArgs) {
        if (eventArgs.get_argument() != null) {
        }
        else {
        }
        return false;
    }
</script>
  <script type="text/javascript">
      var idtextselect;
      function RadMenuDUAN_ItemClientClick(sender, args) {
          var menuItemValue = args.get_item().get_value();
          switch (menuItemValue) {
              case "TTDC":
                  var oWindow = radopen("Popup.aspx?ctl=DUANTTDCs&daID=" + idtextselect, "DUANTTDCs");
                  oWindow.set_title("Quản lý thông tin điều chỉnh dự án");
                  oWindow.maximize();
                  break;
              case "TTTHCD":
                  var oWindow = radopen("Popup.aspx?ctl=TTTHCDs&daID=" + idtextselect, "TTTHCD");
                  oWindow.set_title("Quản lý thông tin thu hồi, chấm dứt đầu tư");
                  oWindow.maximize();
                  break;
              case "TTDG":
                  var oWindow = radopen("Popup.aspx?ctl=TTDGs&daID=" + idtextselect, "TTDG");
                  oWindow.set_title("Quản lý thông tin đánh giá sơ bộ dự án đầu tư");
                  oWindow.maximize();
                  break;
              case "THVDT":
                  var oWindow = radopen("Popup.aspx?ctl=THVDTs&daID=" + idtextselect, "THVDT");
                  oWindow.set_title("Quản lý tình hình thực hiện vốn đầu tư");
                  oWindow.maximize();
                  break;
          }
      }
      function RowContextMenuDUAN(sender, eventArgs) {
          var menu = $find("<%=RadMenuDUAN.ClientID %>");
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
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelDUAN" runat="server" />
<telerik:RadGrid ID="RadGridDUAN" runat="server" Skin="Vista" 
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="true"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="DUANsDataSource" ShowFooter="True"
    ondatabound="RadGridDUAN_DataBound" 
    onitemdeleted="RadGridDUAN_ItemDeleted" oniteminserted="RadGridDUAN_ItemInserted" 
    onitemupdated="RadGridDUAN_ItemUpdated" 
    onitemcommand="RadGridDUAN_ItemCommand" 
    onitemdatabound="RadGridDUAN_ItemDataBound" 
    onitemcreated="RadGridDUAN_ItemCreated">
     <GroupingSettings CaseSensitive ="false"  />
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
    <MasterTableView Name="MasterTableViewDUAN" CommandItemDisplay="Top" DataSourceID="DUANsDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b>Quản lý dự án đầu tư phát triển</b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridDUAN.EditIndexes.Count == 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridDUAN.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Update.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridDUAN.EditIndexes.Count > 0 || RadGridDUAN.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridDUAN.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="PerformInsert" Visible='<%# RadGridDUAN.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Insert.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
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
        <NestedViewSettings DataSourceID ="ViewDUANSqlDataSource">
                <ParentTableRelation>
                    <telerik:GridRelationFields DetailKeyField="PK_ID" MasterKeyField="PK_ID" />
                </ParentTableRelation>
        </NestedViewSettings>
        <NestedViewTemplate>
        <fieldset style =" padding:5px;" >
        <legend style =" padding:5px;">Thông tin chi tiết</legend>
        <table class="TableEditInGrid">
        <tr>
            <td class ="title" style =" width :120px">
                Tên dự án</td>
            <td>
                <asp:Label ID="lblSH" runat="server" Text='<%#Eval("TENDUAN") %>'></asp:Label>
            </td>
            <td class ="title" style =" width :120px">
                Tên doanh nghiệp:</td>
            <td>
                <asp:Label ID="lblSovaoso" runat="server" Text='<%#Eval("TENDOANHNGHIEP") %>'></asp:Label>
            </td>
             <td class ="title">
                Số chứng nhận đầu tư:</td>
            <td>
                <asp:Label ID="lblBrow" runat="server" Text='<%#Eval("SOCNDT")%>'></asp:Label>
            </td>
        </tr>
        <tr>
            <td class ="title">
                Ngày cấp:</td>
            <td colspan="5">
                <asp:Label ID="lblheader" runat="server" Text='<%#Eval("NGAYCAP") %>'></asp:Label>
            </td>
        </tr>
        <tr>
            <td class ="title">
                Vị trí dự án:</td>
            <td>
                <asp:Label ID="lblRole" runat="server" Text='<%#Eval("VITRIDUAN") %>'></asp:Label>
            </td>            
        </tr>
        <tr>
            <td class ="title">
                Tổng vốn:</td>
            <td>
                <asp:Label ID="lblEmr" runat="server" Text='<%#Eval("TONGVON") %>'></asp:Label>
            </td>
            <td class ="title">
                Tiến độ góp vốn:</td>
            <td>
                <asp:Label ID="lblStatus" runat="server" Text='<%#Eval("TIENDOGOPVON") %>'></asp:Label>
            </td>
        </tr>
        <tr>
            <td class ="title">
                Thời hạn:</td>
            <td>
                <asp:Label ID="lbldatePub"  runat="server" Text='<%#Eval("THOIHAN") %>'></asp:Label>
            </td>
            <td class ="title">
                Bắt đầu:</td>
            <td>
                <asp:Label ID="Label1"  runat="server" Text='<%#Eval("BATDAU") %>'></asp:Label>
            </td>
            <td class ="title">
                Kết thúc:</td>
            <td>
                <asp:Label ID="Label2"  runat="server" Text='<%#Eval("KETTHUC") %>'></asp:Label>
            </td>
            <td class ="title">
                Diện tích:</td>
            <td>
                <asp:Label ID="lblField" runat="server" Text='<%#Eval("DIENTICH") %>'></asp:Label>
            </td>
        </tr>
        <tr>
            <td  class ="title">
               Trạng thái dự án:</td>
            <td>
                <asp:Label ID="lbldateDiw" runat="server" Text='<%#Eval("TRANGTHAIDUAN") %>'></asp:Label>
            </td>
        </tr>        
         </table>
<div class="headerthongtin">
    <ul>
    <li class="lifirst">
    <asp:LinkButton ID="btTextRef" runat="server"  OnClientClick='<%# String.Format("javascript:return OnClientLinkClickedTextRef({0})", Eval("PK_ID"))%>' ><img src="Images/img_text_ref.jpg" />Tình trạng cấp phép</asp:LinkButton></li>
    </ul>
 </div>  
</fieldset>
        </NestedViewTemplate>
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
                <telerik:GridBoundColumn UniqueName="TENDUAN" HeaderText="Tên dự án" DataField="TENDUAN"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="MADUAN" HeaderText="Mã dự án" DataField="MADUAN"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="SOCNDT" HeaderText="Số chứng nhận đầu tư" DataField="SOCNDT"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>  
                <telerik:GridBoundColumn UniqueName="NGAYCAP" HeaderText="Ngày cấp" DataField="NGAYCAP"
                AllowFiltering="false" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy}">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="VITRIDUAN" HeaderText="Vị trí dự án" DataField="VITRIDUAN"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="DIENTICH" HeaderText="Diện tích" DataField="DIENTICH"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <custom:FilteringGroupDUAN UniqueName="TRANGTHAIDUAN" DataField="TRANGTHAIDUAN" HeaderText="Tình trạng" FilterControlWidth="100%">
                   <itemtemplate>
                         <%# Eval("TRANGTHAIDUAN")%>
                   </itemtemplate>
                </custom:FilteringGroupDUAN>             
        </Columns>
 <EditFormSettings InsertCaption="Thêm dự án đầu tư phát triển mới" CaptionFormatString="Sửa dự án đầu tư phát triển: <b>{0}</b>" CaptionDataField="TENDUAN" EditFormType="Template">
             <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
             <FormTemplate>
             <div class="headerthongtin">
              <ul>
                <li class="lifirst"><asp:LinkButton ID="btnSave" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'><img src="Images/img_save.jpg" /><%# (Container is GridEditFormInsertItem) ? "Lưu" : "Lưu" %></asp:LinkButton></li>
                     <li><asp:LinkButton ID="btnClose" runat="server" CommandName="Cancel"><img src="Images/img_Close.jpg" />Đóng</asp:LinkButton></li>                     
              </ul>
            </div>               

<table id="tblEdit" class ="TableEditInGrid" cellspacing="3" cellpadding="3" style="width: 100%" border="0">
    <tr>
	    <td style =" width:150px;"><span class="rtsTxtnew">Tên dự án:</span></td>
	    <td colspan="5">
                <asp:TextBox ID="txtID" Text='<%# Eval( "PK_ID") %>' Visible="false" runat="server"></asp:TextBox>
                <asp:TextBox ID="txtTENDUAN" Width="95%" Text='<%# Bind("TENDUAN") %>' runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvTENDUAN" runat="server" ErrorMessage="Tên dự án không thể rỗng" ControlToValidate="txtTENDUAN" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>                                
                <asp:CustomValidator ID="cuvID" ControlToValidate="txtTENDUAN" OnServerValidate="CheckTENDUAN" runat="server" ErrorMessage="Tên đè tài đã tồn tại" Display="Dynamic" ValidationGroup="G1"></asp:CustomValidator>    
        </td>
    </tr>
     <tr>
	    <td style =" width:150px;"><span class="rtsTxtnew">Mã dự án:</span></td>
	    <td colspan="5">
                <asp:TextBox ID="txtMADUAN" Width="40%" Text='<%# Bind("MADUAN") %>' runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorMADUAN" runat="server" ErrorMessage="Mã dự án không thể rỗng" ControlToValidate="txtMADUAN" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>                                
                <asp:CustomValidator ID="CustomValidatorMADUAN" ControlToValidate="txtMADUAN" OnServerValidate="CheckMADUAN" runat="server" ErrorMessage="Mã dự án đã tồn tại" Display="Dynamic" ValidationGroup="G1"></asp:CustomValidator>    
        </td>
    </tr>
    <tr><td> <span class="rtsTxtnew">Doanh nghiệp:</span></td>
<td colspan="5">
 <asp:HiddenField ID="hfParent" runat="server"  Value ='<%# Bind("FK_DOANHNGHIEP")%>'/>
<telerik:RadComboBox ID="rcbParent" runat="server" Width="95%" ShowToggleImage="True" Style="vertical-align: middle;" 
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
            <telerik:RadComboBoxItem Text=""/>
        </Items>
<ExpandAnimation Type="None"></ExpandAnimation>
<CollapseAnimation Type="None"></CollapseAnimation>
</telerik:RadComboBox>
            <script type="text/javascript">
                var div1 = document.getElementById("div1");
                div1.onclick = StopPropagation;
            </script>            
 </td>
</tr>
    <tr>
        <td>
            <span class="rtsTxtnew">Số CNDT:</span>
        </td>
        <td  colspan="2">
                <asp:TextBox ID="txtSoCNKD" Width ="95%" Text='<%# Bind("SOCNDT") %>' runat="server"></asp:TextBox>  
        </td>
         <td>
             <span class="rtsTxtnew">Ngày cấp:</span>
         </td>
         <td>
           <telerik:RadDateTimePicker ID="radNgaycap" Width ="150px" DbSelectedDate ='<%# Bind("NGAYCAP") %>' runat="server">
                <DateInput ID ="DateStart" runat ="server" DateFormat ="dd/MM/yyyy"></DateInput>
                </telerik:RadDateTimePicker>
        </td>
    </tr>
    <tr>
      <td> <span class="rtsTxtnew">Vị trí dự án:</span>    </td>
      <td colspan="2">
        <telerik:RadComboBox ID="rbcVitriduan" DataSourceID ="VITRIDUANDataSource" DataTextField ="C_NAME" DataValueField ="PK_ID"  
         EmptyMessage ="Chọn Vị trí dự án" SelectedValue ='<%# Bind("FK_VITRIDUAN") %>' runat="server" Filter ="Contains">
        </telerik:RadComboBox>
       </td>
        <td colspan="3"><span class="rtsTxtnew">Số giấy phép chuyên ngành (nếu có): &nbsp;&nbsp;</span>
        <asp:TextBox ID="txtGPCN" Width ="150px" Text='<%# Bind("GPCN") %>' runat="server"></asp:TextBox>  
        </td>
    </tr>
    <tr>
	    <td> <span class="rtsTxtnew">Mục tiêu:</span></td>
	    <td colspan="5">
                <telerik:RadTextBox runat="server" ID="txtMUCTIEU" TextMode="MultiLine" Columns="1" Rows="4" Width="95%" Text='<%# Bind("MUCTIEU") %>'></telerik:RadTextBox>
        </td>
    </tr>
    <tr>
	    <td> <span class="rtsTxtnew">Quy mô:</span></td>
	    <td  colspan="2">
                <asp:TextBox ID="TextBox5" Width ="95%" Text='<%# Bind("QUYMO") %>' runat="server"></asp:TextBox>
        </td>
        <td> <span class="rtsTxtnew">Diện tích:</span></td>
	            <td colspan="2">
                     <asp:TextBox ID="txtDIENTICH" Width ="95%" Text='<%# Bind("DIENTICH") %>' runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td> <span class="rtsTxtnew">Thời hạn:</span></td>
	    <td><asp:TextBox ID="txtTHOIHAN" Width ="100px" Text='<%# Bind("THOIHAN") %>' runat="server"></asp:TextBox>
         </td>
        <td style =" width:100px;"> <span class="rtsTxtnew">Bắt đầu:</span> </td>
         <td>
           <telerik:RadDateTimePicker ID="RadDateTimePicker1" Width ="150px" DbSelectedDate ='<%# Bind("BATDAU") %>' runat="server">
                <DateInput ID ="DateInputBATDAU" runat ="server" DateFormat ="dd/MM/yyyy"></DateInput>
                </telerik:RadDateTimePicker>
        </td>
        <td>
             <span class="rtsTxtnew">Kết thúc:</span>
         </td>
         <td>
           <telerik:RadDateTimePicker ID="RadDateTimePicker2" Width ="150px" DbSelectedDate ='<%# Bind("KETTHUC") %>' runat="server">
                <DateInput ID ="DateInputKETTHUC" runat ="server" DateFormat ="dd/MM/yyyy"></DateInput>
                </telerik:RadDateTimePicker>
        </td>
     </tr>
    <tr>
	           <td> <span class="rtsTxtnew">Tình trạng:</span></td>
               <td colspan="5">
                    <asp:DropDownList ID="ddlTTDUAN" SelectedValue='<%# Bind("FK_TRANGTHAIDUAN") %>' DataTextField="C_NAME" DataValueField="PK_ID" runat="server" DataSourceID="TTDUANDataSource" AppendDataBoundItems="True">
                    <asp:ListItem Value="" Text="Chọn"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvTTDUAN" runat="server" ErrorMessage="Hãy chọn tình trạng dự án" ControlToValidate="ddlTTDUAN" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>                                                    
                </td>
            </tr>
<tr style =" font-weight:600;">
<td colspan ="6">
<div class="headerthongtin">
Thông tin về Nguồn vốn đầu tư
</div>
</td>
</tr> 
    <tr>
	    <td> <span class="rtsTxtnew">Tiến độ góp vốn:</span></td>
	    <td>
            <asp:TextBox ID="txtTIENDOGOPVON" Width ="100px" Text='<%# Bind("TIENDOGOPVON") %>' runat="server"></asp:TextBox>
       </td>
        <td><span class="rtsTxtnew">Tổng vốn:</span></td>
	    <td colspan="3">
                <telerik:RadNumericTextBox runat="server" ID="txtTONGVON" Width="100px" DbValue='<%# Bind("TONGVON") %>' NumberFormat-DecimalDigits=0></telerik:RadNumericTextBox>
        </td>
    </tr>
</table>
         <uc1:DUANVON id="DUANVON1" runat="server"/>  
                                             
<div class="headerthongtin">
</div>               </FormTemplate>
<PopUpSettings Width="800px" Height ="100%" ></PopUpSettings>
        </EditFormSettings>
        </MasterTableView>
        <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G1"/>
        <ClientSettings>
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
            <ClientEvents OnRowDblClick="RowDblClickDUAN" OnRowContextMenu="RowContextMenuDUAN" OnPopUpShowing="PopUpShowing"/>
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<telerik:RadContextMenu ID="RadMenuDUAN" CssClass="itemmenu" runat="server" OnClientItemClicked ="RadMenuDUAN_ItemClientClick" EnableRoundedCorners="true" EnableShadows="true">
        <Items>
            <telerik:RadMenuItem Text="Thông tin các lần điều chỉnh" Value ="TTDC" ImageUrl ="../images/img_save.jpg" />
            <telerik:RadMenuItem Text="Thông tin các lần thu hồi, chấm dứt" Value ="TTTHCD" ImageUrl ="../images/img_save.jpg" Visible =false />
            <telerik:RadMenuItem Text="Thông tin đánh giá sơ bộ" Value ="TTDG" ImageUrl ="../images/img_save.jpg" Visible =false />
             <telerik:RadMenuItem Text="Tình hình thực hiện vốn đầu tư" Value ="THVDT" ImageUrl ="../images/img_save.jpg"/>
        </Items>
</telerik:RadContextMenu>
<telerik:RadWindowManager ReloadOnShow="true" ShowContentDuringLoad="false" ID="RadWindowManagerDUAN" runat="server" VisibleStatusbar="False"
   OnClientClose="OnClientCloseDUAN" OnClientShow="OnClientShowDUAN" Behaviors ="Close,Reload" ></telerik:RadWindowManager>
<asp:SqlDataSource ID="DUANsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
        DeleteCommand="DELETE FROM DUAN WHERE PK_ID = @PK_ID" 
        InsertCommand="INSERT INTO DUAN (TENDUAN,MADUAN,SOCNDT,NGAYCAP,GPCN,FK_DOANHNGHIEP,MUCTIEU,QUYMO,NGUOIDAIDIEN,FK_QUOCTICH,FK_CHUCVU,FK_VITRIDUAN,DIENTHOAI,FAX,EMAIL,TONGVON,TIENDOGOPVON,THOIHAN,BATDAU,KETTHUC,DIENTICH,FK_TRANGTHAIDUAN) VALUES (@TENDUAN,@MADUAN,@SOCNDT,@NGAYCAP,@GPCN,@FK_DOANHNGHIEP,@MUCTIEU,@QUYMO,@NGUOIDAIDIEN,@FK_QUOCTICH,@FK_CHUCVU,@FK_VITRIDUAN,@DIENTHOAI,@FAX,@EMAIL,@TONGVON,@TIENDOGOPVON,@THOIHAN,@BATDAU,@KETTHUC,@DIENTICH,@FK_TRANGTHAIDUAN);SELECT @IDDA = SCOPE_IDENTITY()"
        SelectCommand="SELECT DUAN.*,COUNTRY.COUNTRYNAME,DMTTDUAN.C_NAME as TRANGTHAIDUAN,DMCHUCVU.C_NAME as CHUCVU,DMVITRIDUAN.C_NAME as VITRIDUAN,DOANHNGHIEP.TENDOANHNGHIEP FROM DUAN LEFT OUTER JOIN COUNTRY ON DUAN.FK_QUOCTICH = COUNTRY.COUNTRYID LEFT OUTER JOIN DMTTDUAN ON DUAN.FK_TRANGTHAIDUAN = DMTTDUAN.PK_ID LEFT OUTER JOIN DMCHUCVU ON DUAN.FK_CHUCVU = DMCHUCVU.PK_ID LEFT OUTER JOIN DMVITRIDUAN ON DUAN.FK_VITRIDUAN = DMVITRIDUAN.PK_ID LEFT OUTER JOIN DOANHNGHIEP ON DUAN.FK_DOANHNGHIEP = DOANHNGHIEP.PK_ID"
        UpdateCommand="UPDATE DUAN SET TENDUAN=@TENDUAN,MADUAN=@MADUAN,FK_DOANHNGHIEP=@FK_DOANHNGHIEP,SOCNDT=@SOCNDT,NGAYCAP = @NGAYCAP,MUCTIEU = @MUCTIEU,QUYMO=@QUYMO,GPCN=@GPCN,NGUOIDAIDIEN=@NGUOIDAIDIEN,FK_QUOCTICH=@FK_QUOCTICH,FK_CHUCVU=@FK_CHUCVU,FK_VITRIDUAN=@FK_VITRIDUAN,DIENTHOAI=@DIENTHOAI,FAX=@FAX,EMAIL=@EMAIL,TONGVON=@TONGVON,TIENDOGOPVON=@TIENDOGOPVON,THOIHAN=@THOIHAN,BATDAU=@BATDAU,KETTHUC=@KETTHUC,DIENTICH=@DIENTICH,FK_TRANGTHAIDUAN=@FK_TRANGTHAIDUAN WHERE PK_ID = @PK_ID" 
    oninserted="DUANsDataSource_Inserted">
        <UpdateParameters>
            <asp:Parameter Name="TENDUAN" Type="String" ConvertEmptyStringToNull="False"/>   
            <asp:Parameter Name="MADUAN" Type="String" ConvertEmptyStringToNull="False"/>         
            <asp:Parameter Name="SOCNDT" Type="String" ConvertEmptyStringToNull="False"/>
            <asp:Parameter Name="FK_DOANHNGHIEP" Type="Int32" />
            <asp:Parameter Name="NGAYCAP" Type="DateTime" />
            <asp:Parameter Name="BATDAU" Type="DateTime" />
            <asp:Parameter Name="KETTHUC" Type="DateTime" />
            <asp:Parameter Name="GPCN" Type="String" />
            <asp:Parameter Name="MUCTIEU" Type="String" />
            <asp:Parameter Name="QUYMO" Type="String" />
            <asp:Parameter Name="NGUOIDAIDIEN" Type="String" />
            <asp:Parameter Name="FK_QUOCTICH" Type="Int32" />
            <asp:Parameter Name="FK_CHUCVU" Type="Int32" />
            <asp:Parameter Name="FK_VITRIDUAN" Type="Int32" />
            <asp:Parameter Name="DIENTHOAI" Type="String" />
            <asp:Parameter Name="FAX" Type="String" />
            <asp:Parameter Name="EMAIL" Type="String" />
            <asp:Parameter Name="TONGVON" Type="Int32" />
            <asp:Parameter Name="TIENDOGOPVON" Type="String" />
            <asp:Parameter Name="THOIHAN" Type="Int32" />
            <asp:Parameter Name="DIENTICH" Type="Int32" />
            <asp:Parameter Name="FK_TRANGTHAIDUAN" Type="Int32" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="PK_ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="TENDUAN" Type="String" ConvertEmptyStringToNull="False"/>   
            <asp:Parameter Name="MADUAN" Type="String" ConvertEmptyStringToNull="False"/>                  
            <asp:Parameter Name="SOCNDT" Type="String" ConvertEmptyStringToNull="False"/>
            <asp:Parameter Name="FK_DOANHNGHIEP" Type="Int32" />
            <asp:Parameter Name="NGAYCAP" Type="DateTime"/>
            <asp:Parameter Name="BATDAU" Type="DateTime" />
            <asp:Parameter Name="KETTHUC" Type="DateTime" />
            <asp:Parameter Name="GPCN" Type="String" />
            <asp:Parameter Name="MUCTIEU" Type="String" />
            <asp:Parameter Name="QUYMO" Type="String" />
            <asp:Parameter Name="NGUOIDAIDIEN" Type="String" />
            <asp:Parameter Name="FK_QUOCTICH" Type="Int32" />
            <asp:Parameter Name="FK_CHUCVU" Type="Int32" />
            <asp:Parameter Name="FK_VITRIDUAN" Type="Int32" />
            <asp:Parameter Name="DIENTHOAI" Type="String" />
            <asp:Parameter Name="FAX" Type="String" />
            <asp:Parameter Name="EMAIL" Type="String" />
            <asp:Parameter Name="TONGVON" Type="Int32" />
            <asp:Parameter Name="TIENDOGOPVON" Type="String" />
            <asp:Parameter Name="THOIHAN" Type="Int32" />
            <asp:Parameter Name="DIENTICH" Type="Int32" />
            <asp:Parameter Name="FK_TRANGTHAIDUAN" Type="Int32" />
            <asp:Parameter Name="IDDA" Type="Int32" Direction="Output" DefaultValue="0"/>
        </InsertParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="CHUCVUDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
   SelectCommand="SELECT DMCHUCVU.PK_ID,DMCHUCVU.C_NAME FROM DMCHUCVU order by LTRIM(DMCHUCVU.C_NAME)">
</asp:SqlDataSource>
<asp:SqlDataSource ID="TTDUANDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
   SelectCommand="SELECT DMTTDUAN.PK_ID,DMTTDUAN.C_NAME FROM DMTTDUAN order by LTRIM(DMTTDUAN.C_NAME)">
</asp:SqlDataSource>
<asp:SqlDataSource ID="VITRIDUANDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
   SelectCommand="SELECT DMVITRIDUAN.PK_ID,DMVITRIDUAN.C_NAME FROM DMVITRIDUAN order by LTRIM(DMVITRIDUAN.C_NAME)">
</asp:SqlDataSource>
<asp:SqlDataSource ID="COUNTRYDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
   SelectCommand="SELECT COUNTRY.COUNTRYID,COUNTRY.COUNTRYNAME FROM COUNTRY order by LTRIM(COUNTRY.COUNTRYID)">
</asp:SqlDataSource>
<asp:SqlDataSource ID="ViewDUANSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
SelectCommand="SELECT DUAN.*,COUNTRY.COUNTRYNAME,DMTTDUAN.C_NAME as TRANGTHAIDUAN,DMCHUCVU.C_NAME as CHUCVU,DMVITRIDUAN.C_NAME as VITRIDUAN,DOANHNGHIEP.TENDOANHNGHIEP FROM DUAN LEFT OUTER JOIN COUNTRY ON DUAN.FK_QUOCTICH = COUNTRY.COUNTRYID LEFT OUTER JOIN DMTTDUAN ON DUAN.FK_TRANGTHAIDUAN = DMTTDUAN.PK_ID LEFT OUTER JOIN DMCHUCVU ON DUAN.FK_CHUCVU = DMCHUCVU.PK_ID LEFT OUTER JOIN DMVITRIDUAN ON DUAN.FK_VITRIDUAN = DMVITRIDUAN.PK_ID LEFT OUTER JOIN DOANHNGHIEP ON DUAN.FK_DOANHNGHIEP = DOANHNGHIEP.PK_ID WHERE DUAN.PK_ID = @PK_ID">
  <SelectParameters>
        <asp:Parameter Name ="PK_ID" Type ="Int64" />
  </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="DoanhNghiepTreelist" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
    SelectCommand="SELECT 0 as PK_ID , NULL AS FK_DOANHNGHIEP, N'Root' AS TENDOANHNGHIEP FROM [DOANHNGHIEP] UNION SELECT PK_ID, FK_DOANHNGHIEP, TENDOANHNGHIEP FROM [DOANHNGHIEP]">
</asp:SqlDataSource>