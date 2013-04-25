<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DUANTTDCs.ascx.cs" Inherits="module_DUANTTDCs" %>
<%@ Register TagPrefix="custom" Namespace="ITCLIB.Filter" %>
<%@ Register TagPrefix="uc1" TagName="DUANVONDC" Src="DUANDIEUCHINHVON.ascx" %>
<telerik:RadCodeBlock ID="RadCodeBlockDUANTTDC" runat="server">
<script type="text/javascript">
        function RowDblClickDUANTTDC(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("DUANs") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewDUANTTDC") && (CanEdit == "True")) {
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
    function GetGridServerElementDUANTTDC(serverID, tagName) {
        if (!tagName)
            tagName = "*";

        var grid = $get("<%=RadGridDUANTTDC.ClientID %>");
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

        var txtpk = GetGridServerElementDUANTTDC("hfParent");
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
</script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelDUANTTDC" runat="server" />
<telerik:RadGrid ID="RadGridDUANTTDC" runat="server" Skin="Windows7" 
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="true"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="DUANTTDCsDataSource" ShowFooter="True"
    ondatabound="RadGridDUANTTDC_DataBound" 
    onitemdeleted="RadGridDUANTTDC_ItemDeleted" oniteminserted="RadGridDUANTTDC_ItemInserted" 
    onitemupdated="RadGridDUANTTDC_ItemUpdated" 
    onitemcommand="RadGridDUANTTDC_ItemCommand" 
    onitemdatabound="RadGridDUANTTDC_ItemDataBound">
     <GroupingSettings CaseSensitive ="false"  />
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
    <MasterTableView Name="MasterTableViewDUANTTDC" CommandItemDisplay="Top" DataSourceID="DUANTTDCsDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b><asp:Label ID="lblTitle" ForeColor ="Red" runat="server"></asp:Label></b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridDUANTTDC.EditIndexes.Count == 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridDUANTTDC.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Update.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridDUANTTDC.EditIndexes.Count > 0 || RadGridDUANTTDC.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridDUANTTDC.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="PerformInsert" Visible='<%# RadGridDUANTTDC.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Insert.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
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
                <telerik:GridBoundColumn UniqueName="TENDIEUCHINH" HeaderText="Tên dự án điều chỉnh" DataField="TENDIEUCHINH"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="SOCNDT" HeaderText="Số chứng nhận đầu tư điều chỉnh" DataField="SOCNDT"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>  
                <telerik:GridBoundColumn UniqueName="NGAYCAP" HeaderText="Ngày cấp điều chỉnh" DataField="NGAYCAP"
                AllowFiltering="false" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy}">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="VITRIDUAN" HeaderText="Vị trí dự án điều chỉnh" DataField="VITRIDUAN"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="DIENTICH" HeaderText="Diện tích điều chỉnh" DataField="DIENTICH"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <custom:FilteringGroupDUAN UniqueName="TRANGTHAIDUAN" DataField="TRANGTHAIDUAN" HeaderText="Tình trạng" FilterControlWidth="100%">
                   <itemtemplate>
                         <%# Eval("TRANGTHAIDUAN")%>
                   </itemtemplate>
                </custom:FilteringGroupDUAN>             
        </Columns>
        <EditFormSettings InsertCaption="Thêm điều chỉnh dự án đầu tư phát triển mới" CaptionFormatString="Sửa điều chỉnh dự án đầu tư phát triển: <b>{0}</b>" CaptionDataField="TENDUAN" EditFormType="Template">
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
                     <asp:TextBox ID="txtTENDUAN" Width="95%" runat="server" ReadOnly="True"></asp:TextBox>                     
        </td>
    </tr>
    <tr>
	    <td > <span class="rtsTxtnew">Lý do điều chỉnh:</span></td>
	    <td colspan="5">
                <telerik:RadTextBox runat="server" ID="RadTextBox1" TextMode="MultiLine" Columns="1" Rows="4" Width="95%" Text='<%# Bind("LYDODIEUCHINH") %>'></telerik:RadTextBox>
        </td>
    </tr>
    <tr>
        <td ><span class="rtsTxtnew">Tên điều chỉnh:</span></td>
	    <td colspan="5">
                <telerik:RadTextBox ID="txtTENDIEUCHINH" Width="95%" Text='<%# Bind("TENDIEUCHINH") %>' runat="server"></telerik:RadTextBox>                   
        </td>
    </tr>
<tr>
<td >
    <span class="rtsTxtnew">Doanh nghiệp:</span>
</td>
<td colspan="5">
 <asp:HiddenField ID="hfParent" runat="server"  Value ='<%# Bind("FK_DOANHNGHIEP")%>'/>
<telerik:RadComboBox ID="rcbParent" runat="server" Width="99%" 
ShowToggleImage="True" Style="vertical-align: middle;" 
EmptyMessage="Chọn doanh nghiệp" ExpandAnimation-Type="None" CollapseAnimation-Type="None">
        <ItemTemplate>
        <div id ="div1">
                    <telerik:RadTreeView runat="server" ID="RadTreViewDir" OnClientNodeClicking ="ClientNodeClicking" 
                    Width="100%" Height="95%" DataFieldID="PK_ID" DataFieldParentID="FK_DOANHNGHIEP" DataSourceID="DoanhNghiepTreelist" 
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
<td >
    <span class="rtsTxtnew">Số CNDT điều chỉnh:</span>
</td>
<td colspan="2">
        <asp:TextBox ID="txtSoCNKD" Width ="100px" Text='<%# Bind("SOCNDT") %>' runat="server"></asp:TextBox>  
</td>
<td >
     <span class="rtsTxtnew">Ngày cấp:</span>
 </td>
 <td colspan="2">
   <telerik:RadDateTimePicker ID="radNgaycap" Width ="150px" DbSelectedDate ='<%# Bind("NGAYCAP") %>' runat="server">
        <DateInput ID ="DateStart" runat ="server" DateFormat ="dd/MM/yyyy"></DateInput>
        </telerik:RadDateTimePicker>
</td>
</tr>
<tr>
<td >
             <span class="rtsTxtnew">Vị trí dự án:</span>
     </td>
      <td colspan="5">
        <telerik:RadComboBox ID="rbcVitriduan" DataSourceID ="VITRIDUANDataSource" DataTextField ="C_NAME" DataValueField ="PK_ID"  
         EmptyMessage ="Chọn Vị trí dự án" SelectedValue ='<%# Bind("FK_VITRIDUAN") %>' runat="server" Filter ="Contains">
        </telerik:RadComboBox>
     </td>
</tr>
<tr>
	            <td > <span class="rtsTxtnew">Mục tiêu:</span></td>
	            <td colspan="5">
                     <telerik:RadTextBox runat="server" ID="txtMUCTIEU" TextMode="MultiLine" Columns="1" Rows="4" Width="95%" Text='<%# Bind("MUCTIEU") %>'></telerik:RadTextBox>
                </td>
</tr>
<tr>
	    <td> <span class="rtsTxtnew">Quy mô:</span></td>
	    <td  colspan="2">
                <asp:TextBox ID="TextBox5" Width ="95%" Text='<%# Bind("QUYMO") %>' runat="server"></asp:TextBox>
        </td>
        <td > <span class="rtsTxtnew">Diện tích:</span></td>
	    <td colspan="2">
                <asp:TextBox ID="txtDIENTICH" Width ="95%" Text='<%# Bind("DIENTICH") %>' runat="server"></asp:TextBox>
        </td>
    </tr>
<tr>
        <td> <span class="rtsTxtnew">Thời hạn:</span></td>
	    <td>
                     <asp:TextBox ID="txtTHOIHAN" Width ="95%" Text='<%# Bind("THOIHAN") %>' runat="server"></asp:TextBox>
         </td>
        <td>
             <span class="rtsTxtnew">Bắt đầu:</span>
         </td>
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
	<td > <span class="rtsTxtnew">Tình trạng:</span></td>
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
	<td > <span class="rtsTxtnew">Tiến độ góp vốn:</span></td>
	<td colspan="2">
            <asp:TextBox ID="txtTIENDOGOPVON" Width ="95%" Text='<%# Bind("TIENDOGOPVON") %>' runat="server"></asp:TextBox>
    </td>
	<td > <span class="rtsTxtnew">Tổng vốn:</span></td>
	<td colspan="2">
            <telerik:RadNumericTextBox runat="server" ID="txtTONGVON" Width="95%" DbValue='<%# Bind("TONGVON") %>' NumberFormat-DecimalDigits=0></telerik:RadNumericTextBox>
    </td>
</tr>                        
 </table>
            <uc1:DUANVONDC id="DUANVONDC1" runat="server"/>                                                    
            <div class="headerthongtin"></div> 
             </FormTemplate>
<PopUpSettings Width="800px" Height ="100%" ></PopUpSettings>
        </EditFormSettings>
        </MasterTableView>
        <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G1"/>
        <ClientSettings>
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
            <ClientEvents OnRowDblClick="RowDblClickDUANTTDC" OnPopUpShowing="PopUpShowing"/>
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<asp:SqlDataSource ID="DUANTTDCsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
        DeleteCommand="DELETE FROM DUAN WHERE PK_ID = @PK_ID" 
        InsertCommand="INSERT INTO DUANDIEUCHINH (FK_DUAN=@FK_DUAN,TENDIEUCHINH,LYDODIEUCHINH,SOCNDT,NGAYCAP,GPCN,FK_DOANHNGHIEP,MUCTIEU,QUYMO,NGUOIDAIDIEN,FK_QUOCTICH,FK_CHUCVU,FK_VITRIDUAN,DIENTHOAI,FAX,EMAIL,TONGVON,TIENDOGOPVON,THOIHAN,BATDAU,KETTHUC,DIENTICH,FK_TRANGTHAIDUAN) VALUES (@TENDIEUCHINH,@LYDODIEUCHINH,@SOCNDT,@NGAYCAP,@GPCN,@FK_DOANHNGHIEP,@MUCTIEU,@QUYMO,@NGUOIDAIDIEN,@FK_QUOCTICH,@FK_CHUCVU,@FK_VITRIDUAN,@DIENTHOAI,@FAX,@EMAIL,@TONGVON,@TIENDOGOPVON,@THOIHAN,@BATDAU,@KETTHUC,@DIENTICH,@FK_TRANGTHAIDUAN);SELECT @IDDADC = SCOPE_IDENTITY()"
        SelectCommand="SELECT DUANDIEUCHINH.*,DMTTDUAN.C_NAME as TRANGTHAIDUAN,DMVITRIDUAN.C_NAME as VITRIDUAN,DOANHNGHIEP.TENDOANHNGHIEP,DUAN.TENDUAN,DUAN.FK_DOANHNGHIEP FROM DUANDIEUCHINH LEFT OUTER JOIN DUAN ON DUANDIEUCHINH.FK_DUAN = DUAN.PK_ID LEFT OUTER JOIN DMTTDUAN ON DUANDIEUCHINH.FK_TRANGTHAIDUAN = DMTTDUAN.PK_ID LEFT OUTER JOIN DMVITRIDUAN ON DUANDIEUCHINH.FK_VITRIDUAN = DMVITRIDUAN.PK_ID LEFT OUTER JOIN DOANHNGHIEP ON DUANDIEUCHINH.FK_DOANHNGHIEP = DOANHNGHIEP.PK_ID WHERE FK_DUAN=@FK_DUAN"
        UpdateCommand="UPDATE DUANDIEUCHINH SET TENDIEUCHINH=@TENDIEUCHINH,LYDODIEUCHINH=@LYDODIEUCHINH,FK_DOANHNGHIEP=@FK_DOANHNGHIEP,SOCNDT=@SOCNDT,NGAYCAP = @NGAYCAP,MUCTIEU = @MUCTIEU,QUYMO=@QUYMO,GPCN=@GPCN,NGUOIDAIDIEN=@NGUOIDAIDIEN,FK_QUOCTICH=@FK_QUOCTICH,FK_CHUCVU=@FK_CHUCVU,FK_VITRIDUAN=@FK_VITRIDUAN,DIENTHOAI=@DIENTHOAI,FAX=@FAX,EMAIL=@EMAIL,TONGVON=@TONGVON,TIENDOGOPVON=@TIENDOGOPVON,THOIHAN=@THOIHAN,BATDAU=@BATDAU,KETTHUC=@KETTHUC,DIENTICH=@DIENTICH,FK_TRANGTHAIDUAN=@FK_TRANGTHAIDUAN WHERE PK_ID = @PK_ID" 
    oninserted="DUANTTDCsDataSource_Inserted">
        <UpdateParameters>
            <asp:Parameter Name="TENDIEUCHINH" Type="String" ConvertEmptyStringToNull="False"/>   
            <asp:Parameter Name="LYDODIEUCHINH" Type="String" ConvertEmptyStringToNull="False"/>            
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
         <SelectParameters>
             <asp:QueryStringParameter Name="FK_DUAN" Type="Int32" QueryStringField="daID" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="PK_ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="FK_DUAN" Type="Int32" QueryStringField="daID" />
            <asp:Parameter Name="TENDIEUCHINH" Type="String" ConvertEmptyStringToNull="False"/> 
            <asp:Parameter Name="LYDODIEUCHINH" Type="String" ConvertEmptyStringToNull="False"/>            
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
            <asp:Parameter Name="IDDADC" Type="Int32" Direction="Output" DefaultValue="0"/>
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
SelectCommand="SELECT DUAN.*,COUNTRY.COUNTRYNAME,DMTTDUAN.C_NAME as TRANGTHAIDUAN,DMCHUCVU.C_NAME as CHUCVU,DMVITRIDUAN.C_NAME as VITRIDUAN,DOANHNGHIEP.TENDOANHNGHIEP FROM DUAN LEFT OUTER JOIN COUNTRY ON DUAN.FK_QUOCTICH = COUNTRY.COUNTRYID LEFT OUTER JOIN DMTTDUAN ON DUAN.FK_TRANGTHAIDUAN = DMTTDUAN.PK_ID LEFT OUTER JOIN DMCHUCVU ON DUAN.FK_CHUCVU = DMCHUCVU.PK_ID LEFT OUTER JOIN DMVITRIDUAN ON DUAN.FK_VITRIDUAN = DMVITRIDUAN.PK_ID LEFT OUTER JOIN DOANHNGHIEP ON DUAN.FK_DOANHNGHIEP = DOANHNGHIEP.PK_ID">
</asp:SqlDataSource>
<asp:SqlDataSource ID="DoanhNghiepTreelist" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
    SelectCommand="SELECT 0 as PK_ID , NULL AS FK_DOANHNGHIEP, N'Root' AS TENDOANHNGHIEP FROM [DOANHNGHIEP] UNION SELECT PK_ID, FK_DOANHNGHIEP, TENDOANHNGHIEP FROM [DOANHNGHIEP]">
</asp:SqlDataSource>