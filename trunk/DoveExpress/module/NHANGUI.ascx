<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NHANGUI.ascx.cs" Inherits="module_NHANGUI" %>
<%@ Register TagPrefix="uc1" TagName="NHANGUIDVPT" Src="NHANGUIDVPT.ascx" %>
<telerik:RadCodeBlock ID="RadCodeBlockNHANGUI" runat="server">
<script type="text/javascript">
        function RowDblClick(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("NHANGUI") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewNHANGUI") && (CanEdit == "True")) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
        }
    var cmbQuanHuyen;
    function OnClientLoadQuanHuyen(sender) {
        cmbQuanHuyen = sender;
    }
    function cmbTinhThanhClientSelectedIndexChangedHandler(sender, eventArgs) {
        cmbQuanHuyen.requestItems(eventArgs.get_item().get_value(), false);        
    }
    function ItemsLoadedQuanHuyen(combo, eventArqs) {
        if (combo.get_items().get_count() > 0) {
            combo.trackChanges();
            combo.get_items().getItem(0).select();
            combo.updateClientState();
            combo.commitChanges();
        } else {
            combo.set_text("");
        }
    }
    function cmbQuanHuyenClientSelectedIndexChangedHandler(sender, eventArgs) {
        $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("cmbQuanHuyen;" + eventArgs.get_item().get_value());
         return false;
    }
    function cmbSanPhamClientSelectedIndexChangedHandler(sender, eventArgs) {
         $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("cmbSanPham;" + eventArgs.get_item().get_value());
         return false;
    }
    function cmbNhomKhachHangClientSelectedIndexChangedHandler(sender, eventArgs) {
         $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("cmbNhomKhachHang;" + eventArgs.get_item().get_value());
         return false;
    }    
</script>
<script type="text/javascript">
     function onResponseEndNG() {
         if (typeof (result) != "undefined" && result && result != "") {
             alert(result);
             result = "";
         }
         return false;
     }
</script>
<script type="text/javascript">
      var registeredElementsCT = [];
      function GetRegisteredServerElementCT(serverID) {
          var clientID = "";
          for (var i = 0; i < registeredElementsCT.length; i++) {
              clientID = registeredElementsCT[i];
              if (clientID.indexOf(serverID) >= 0)
                  break;
          }
          return $get(clientID);
      }
      function GetGridServerElementCT(serverID, tagName) {
          if (!tagName)
              tagName = "*";

          var grid = $get("<%=RadGridNHANGUI.ClientID %>");
          var elements = grid.getElementsByTagName(tagName);
          for (var i = 0; i < elements.length; i++) {
              var element = elements[i];
              if (element.id.indexOf(serverID) >= 0)
                  return element;
          }
      }
</script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelNHANGUI" runat="server" />
<telerik:RadGrid ID="RadGridNHANGUI" runat="server" Skin="Vista" 
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="NHANGUIDataSource" ShowFooter="True"
    ondatabound="RadGridNHANGUI_DataBound" 
    onitemdeleted="RadGridNHANGUI_ItemDeleted" oniteminserted="RadGridNHANGUI_ItemInserted" 
    onitemupdated="RadGridNHANGUI_ItemUpdated" 
    onitemcommand="RadGridNHANGUI_ItemCommand" 
    onitemdatabound="RadGridNHANGUI_ItemDataBound" CellSpacing="0">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
     <GroupingSettings CaseSensitive ="false"  />
    <MasterTableView Name="MasterTableViewNHANGUI" CommandItemDisplay="Top" DataSourceID="NHANGUIDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b>Quản lý nhận gửi trong nước</b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridNHANGUI.EditIndexes.Count == 0 && ITCLIB.Security.Security.CanEditModule("NHANGUI") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridNHANGUI.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Update.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridNHANGUI.EditIndexes.Count > 0 || RadGridNHANGUI.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridNHANGUI.MasterTableView.IsItemInserted && ITCLIB.Security.Security.CanAddModule("NHANGUI") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="PerformInsert" Visible='<%# RadGridNHANGUI.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Insert.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:return confirm('Bạn có muốn xóa bản ghi đã chọn không?')" runat="server" CommandName="DeleteSelected" Visible='<%# ITCLIB.Security.Security.CanDeleteModule("NHANGUI") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Delete.gif" />Xóa</asp:LinkButton>&nbsp;&nbsp;
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
                <telerik:GridBoundColumn UniqueName="C_NGAY" HeaderText="Ngày" DataField="C_NGAY" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy}">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_BILL" HeaderText="Số Bill" DataField="C_BILL" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_MAKH" HeaderText="Mã khách hàng" DataField="C_MAKH" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_TENKH" HeaderText="Tên khách hàng" DataField="C_TENKH" HeaderStyle-Width="110px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_NGUOINHAN" HeaderText="Người nhận" DataField="C_NGUOINHAN" HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_DIACHINHAN" HeaderText="Địa chỉ nhận" DataField="C_DIACHINHAN" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="TINHTHANHNAME" HeaderText="Tỉnh thành" DataField="TINHTHANHNAME" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="QUANHUYENNAME" HeaderText="Quận huyện" DataField="MAVUNGNAME" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_NOIDUNG" HeaderText="Nội dung" DataField="C_NOIDUNG" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_KHOILUONG" HeaderText="Khối lượng" DataField="C_KHOILUONG" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="SANPHAMNAME" HeaderText="Dịch vụ" DataField="SANPHAMNAME" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_GIACUOC" HeaderText="Cước chính" DataField="C_GIACUOC" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_PPXD" HeaderText="PPXD" DataField="C_PPXD" HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_PHUTROISUM" HeaderText="DV phụ trội" DataField="C_PHUTROISUM" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_TIENHANG" HeaderText="Tiền hàng" DataField="C_TIENHANG" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_HINHTHUCTT" HeaderText="Hình thức TT" DataField="C_HINHTHUCTT" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn UniqueName="C_DATHU" HeaderText="Đã thu" DataField="C_DATHU" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn UniqueName="C_CONLAI" HeaderText="Còn lại" DataField="C_CONLAI" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>               
                <telerik:GridBoundColumn UniqueName="NHANVIENNHANNAME" HeaderText="Nhân viên nhận" DataField="NHANVIENNHANNAME" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="DOITACNAME" HeaderText="Đối tác" DataField="DOITACNAME" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_GIADOITAC" HeaderText="Giá đối tác" DataField="C_GIADOITAC" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="NHANVIENPHATNAME" HeaderText="Nhân viên phát" DataField="NHANVIENPHATNAME" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_NGAYGIOPHAT" HeaderText="Ngày giờ phát" DataField="C_NGAYGIOPHAT" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy hh:mm tt}">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_NGUOIKYNHAN" HeaderText="Người ký" DataField="C_NGUOIKYNHAN" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_BOPHAN" HeaderText="Bộ phận" DataField="C_BOPHAN" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
        </Columns>
        <EditFormSettings InsertCaption="Thêm nhận gửi mới" CaptionFormatString="Sửa nhận gửi: <b>{0}</b>" CaptionDataField="C_BILL" EditFormType="Template" PopUpSettings-Width="900px">
        <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
           <FormTemplate>
            <div class="headerthongtin">
              <ul>
                <li class="lifirst"><asp:LinkButton ID="btnSave" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'><img src="Images/img_save.jpg" /><%# (Container is GridEditFormInsertItem) ? "Lưu" : "Lưu" %></asp:LinkButton></li>
                     <li><asp:LinkButton ID="btnClose" runat="server" CommandName="Cancel"><img src="Images/img_Close.jpg" />Đóng</asp:LinkButton></li>                     
              </ul>
            </div>               
            <div class="clearfix bgpopup"> 
            <div style="width:900px;background:#FFFFFF" class="clearfix">      
            <table id="tblEdit" class ="TableEditInGrid" cellspacing="3" cellpadding="3" style="width: 100%" border="0">
            <tr>
                <td style ="width:100px;"> <span class="rtsTxtnew">Ngày nhận gửi:</td>
                <td colspan="4">
                    <telerik:RadDatePicker ID="radNgaynhangui" Width ="150px" DbSelectedDate ='<%# Bind("C_NGAY") %>' runat="server" AutoPostBack ="false" >
                        <DateInput ID ="DateInput1" runat ="server" DateFormat ="dd/MM/yyyy" MinDate="1/1/1890 12:00:00 AM">
                        <ClientEvents  OnKeyPress ="controlkeypress"/>
                        </DateInput>
                    </telerik:RadDatePicker>
                </td>
                <td style ="width:100px;"> <span class="rtsTxtnew">Số Bill:</span></td>
                <td colspan="4">
                    <asp:HiddenField ID="txtID" Value ='<%# Eval( "PK_ID") %>' runat="server" />
                    <telerik:RadTextBox ID="txtCODE" Width ="90%" Text='<%# Bind("C_BILL") %>' runat="server"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="rfvCODE" runat="server" ErrorMessage="Số Bill không thể rỗng" ControlToValidate="txtCODE" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="cuvCODE" ControlToValidate="txtCODE" OnServerValidate="CheckBill" runat="server" ErrorMessage="Số Bill đã tồn tại" Display="Dynamic" ValidationGroup="G1"></asp:CustomValidator>
                </td>               
            </tr>
            <tr>
                <td style ="width:100px;"> <span class="rtsTxtnew">Nhóm KH:</span></td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbNhomKhachHang" runat="server"
                    DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="NHOMKHACHHANGDataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn nhóm" onclientselectedindexchanged="cmbNhomKhachHangClientSelectedIndexChangedHandler">
                    </telerik:RadComboBox>
                </td>
                <td style ="width:100px;"> <span class="rtsTxtnew">Mã khách hàng:</span></td>
                <td colspan="4">
                    <telerik:RadAutoCompleteBox ID="radautoC_MAKH" Width ="90%" runat="server" 
                        AllowCustomEntry="True" DataSourceID="KHACHHANGDataSource" 
                        DataTextField="C_CODE" DataValueField="PK_ID" InputType="Text">
                        <TextSettings SelectionMode="Single" />
                    </telerik:RadAutoCompleteBox>
                    <telerik:RadTextBox ID="txtC_MAKH" Width ="90%"  Visible="false" Text='<%# Eval("C_MAKH") %>' runat="server"></telerik:RadTextBox>
                </td>
                <td style ="width:100px;"> <span class="rtsTxtnew">Tên khách hàng:</span></td>
                <td colspan="8">
                    <telerik:RadAutoCompleteBox ID="radautoC_TENKH" Width ="90%" runat="server" 
                        AllowCustomEntry="True" DataSourceID="KHACHHANGDataSource" 
                        DataTextField="C_NAME" DataValueField="PK_ID" InputType="Text">
                        <TextSettings SelectionMode="Single" />
                    </telerik:RadAutoCompleteBox>
                    <telerik:RadTextBox ID="txtC_TENKH" Width ="90%"  Visible="false" Text='<%# Eval("C_TENKH") %>' runat="server"></telerik:RadTextBox>
                </td>               
            </tr> 
            <tr> 
                <td style ="width:100px;"> <span class="rtsTxtnew">Người nhận:</span></td>
                <td colspan="4">
                    <telerik:RadTextBox ID="txtC_NGUOINHAN" Width ="90%" Text='<%# Bind("C_NGUOINHAN") %>' runat="server"></telerik:RadTextBox>
                </td>               
                <td style =" width:100px;"> <span class="rtsTxtnew">Địa chỉ nhận:</span></td>
                <td colspan="12">
                    <telerik:RadTextBox ID="txtC_DIACHINHAN" Width ="90%" Text='<%# Bind("C_DIACHINHAN") %>' runat="server"></telerik:RadTextBox>
                </td>
            </tr> 
            <tr> 
                <td style ="width:100px;"> <span class="rtsTxtnew">Tỉnh thành:</span></td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbTinhThanh" runat="server"
                    DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="TINHTHANHDataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn tỉnh"
                    onclientselectedindexchanged="cmbTinhThanhClientSelectedIndexChangedHandler">
                    </telerik:RadComboBox>
                </td>               
                <td style =" width:100px;"> <span class="rtsTxtnew">Quận huyện:</span></td>
                <td colspan="12">
                    <asp:TextBox ID="txtQuanHuyen" CssClass="txttext" Text='<%# Eval( "FK_QUANHUYEN") %>' Visible="false" runat="server"></asp:TextBox>
                    <telerik:RadComboBox ID="cmbQuanHuyen" runat="server" 
                    DataTextField="C_NAME" DataValueField="C_CODE" DataSourceID="QUANHUYENDataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn quận huyện" 
                    onclientitemsrequested="ItemsLoadedQuanHuyen" onclientload="OnClientLoadQuanHuyen" 
                    onitemsrequested="cmbQuanHuyen_ItemsRequested" onclientselectedindexchanged="cmbQuanHuyenClientSelectedIndexChangedHandler">
                    </telerik:RadComboBox>
                </td>
            </tr> 
            <tr> 
                <td style =" width:100px;"> <span class="rtsTxtnew">Nội dung:</span></td>
                <td colspan="16">
                    <telerik:RadTextBox ID="txtC_NOIDUNG" Width ="90%" Text='<%# Bind("C_NOIDUNG") %>' runat="server"></telerik:RadTextBox>
                </td>
            </tr
            <tr>                
                <td style =" width:100px;"> <span class="rtsTxtnew">Dịch vụ:</span></td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbSanPham" runat="server" 
                    DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="MASANPHAMDataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn dịch vụ" onclientselectedindexchanged="cmbSanPhamClientSelectedIndexChangedHandler">
                    </telerik:RadComboBox>
                </td>
                <td style =" width:100px;"><span class="rtsTxtnew">PPXD:</span></td>
                <td colspan="4">
                     <telerik:RadNumericTextBox  ID="txtPPXD" Width ="90%" Runat="server">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="1"/>
                    </telerik:RadNumericTextBox>
                </td>
                <td style =" width:100px;"> <span class="rtsTxtnew">Khối lượng (g):</span></td>
                <td colspan="4">
                     <telerik:RadNumericTextBox  ID="txtC_KHOILUONG" Width ="90%" Runat="server" Text='<%# Bind("C_KHOILUONG") %>'>
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="1"/>
                    </telerik:RadNumericTextBox>
                </td>
            </tr
            <tr>                
                <td style =" width:100px;"> <span class="rtsTxtnew">Cước chính:</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_GIACUOC" Width ="90%" Runat="server" Text='<%# Bind("C_GIACUOC") %>'>
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>                
                <td style =" width:100px;"> <span class="rtsTxtnew">DV phụ trội:</td>
                <td colspan="8">
                    <uc1:NHANGUIDVPT ID ="NHANGUIDVPT" runat = "server"/>  
                </td>
            </tr
            <tr>     
                <td style =" width:100px;"><span class="rtsTxtnew">Tổng cước:</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_TIENHANG" Width ="90%" Runat="server" Text='<%# Bind("C_TIENHANG") %>'>
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>           
                <td style =" width:100px;"> <span class="rtsTxtnew">HTTT:</span></td>
                <td colspan="4">
                 <telerik:RadComboBox ID="cmbC_HINHTHUCTT" SelectedValue='<%# Bind("C_HINHTHUCTT") %>' runat="server" EmptyMessage="Chọn">
                            <Items>
                                <telerik:RadComboBoxItem Value ="Thanh toán ngay" Text ="Thanh toán ngay" />
                                <telerik:RadComboBoxItem Value ="Thanh toán sau" Text ="Thanh toán sau" />
                                <telerik:RadComboBoxItem Value ="Thanh toán đầu nhận" Text ="Thanh toán đầu nhận" />
                                <telerik:RadComboBoxItem Value ="Khác" Text ="Khác" />
                            </Items>
                 </telerik:RadComboBox>
                </td>               
                <td style =" width:100px;"> <span class="rtsTxtnew">Đã thu:</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_DATHU" Width ="90%" Runat="server" Text='<%# Bind("C_DATHU") %>'>
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>
            </tr
            <tr>
                <td style =" width:100px;"> <span class="rtsTxtnew">Còn lại:</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_CONLAI" Width ="90%" Runat="server">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>
                <td style =" width:100px;"><span class="rtsTxtnew">Nhân viên nhận:</span></td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbFK_NHANVIENNHAN" runat="server" SelectedValue='<%# Bind("FK_NHANVIENNHAN") %>'
                    DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="UserDataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn">
                    </telerik:RadComboBox>
                </td>
                <td style =" width:100px;"><span class="rtsTxtnew">Đối tác:</span></td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbFK_DOITAC" runat="server" SelectedValue='<%# Bind("FK_DOITAC") %>'
                    DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="DoitacDataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
             <td style =" width:100px;"><span class="rtsTxtnew">Giá đối tác:</span></td>
                <td colspan="4">
                     <telerik:RadNumericTextBox  ID="txtC_GIADOITAC" Width ="90%" Runat="server" Text='<%# Bind("C_GIADOITAC") %>'>
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>
                <td style =" width:100px;"> <span class="rtsTxtnew">Nhân viên phát:</span></td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbFK_NHANVIENPHAT" runat="server" SelectedValue='<%# Bind("FK_NHANVIENPHAT") %>'
                    DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="UserDataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn">
                    </telerik:RadComboBox>
                </td>
                <td style =" width:100px;"> <span class="rtsTxtnew">Ngày giờ phát:</span></td>
                <td colspan="4">
                    <telerik:RadDateTimePicker ID="radC_NGAYGIOPHAT"  Width ="90%" DbSelectedDate ='<%# Bind("C_NGAYGIOPHAT") %>' runat="server" AutoPostBack ="false">
                        <DateInput ID ="DateInput2" runat ="server" DateFormat ="dd/MM/yyyy hh:mm tt" MinDate="1/1/1890 12:00:00 AM">
                        <ClientEvents  OnKeyPress ="controlkeypress"/>
                        </DateInput>
                    </telerik:RadDateTimePicker>
                </td>
            </tr>
             <tr>
             <td style =" width:100px;"><span class="rtsTxtnew">Người ký nhận:</span></td>
                <td colspan="4">
                     <telerik:RadTextBox ID="txtC_NGUOIKYNHAN" Width ="90%" Text='<%# Bind("C_NGUOIKYNHAN") %>' runat="server"></telerik:RadTextBox>
                </td>
                <td style =" width:100px;"> <span class="rtsTxtnew">Bộ phận:</span></td>
                <td colspan="4">
                    <telerik:RadTextBox ID="txtC_BOPHAN" Width ="90%" Text='<%# Bind("C_BOPHAN") %>' runat="server"></telerik:RadTextBox>
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
            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="True" FrozenColumnsCount="3" ScrollHeight="450px" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<asp:SqlDataSource ID="NHANGUIDataSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>" 
    DeleteCommand="DELETE FROM [NHANGUI] WHERE [PK_ID] = @PK_ID" 
    InsertCommand="INSERT INTO [NHANGUI] ([C_NGAY], [C_MAKH], [C_BILL], [C_TENKH], [C_NGUOINHAN], [C_DIACHINHAN], [FK_QUANHUYEN], [C_NOIDUNG], [FK_MASANPHAM], [C_KHOILUONG], [C_GIACUOC], [C_PHUTROI], [C_HINHTHUCTT], [C_DATHU], [C_TIENHANG], [FK_NHANVIENNHAN], [FK_DOITAC], [C_GIADOITAC], [FK_NHANVIENPHAT], [C_NGAYGIOPHAT], [C_NGUOIKYNHAN], [C_BOPHAN]) VALUES (@C_NGAY, @C_MAKH, @C_BILL, @C_TENKH, @C_NGUOINHAN, @C_DIACHINHAN, @FK_QUANHUYEN, @C_NOIDUNG, @FK_MASANPHAM, @C_KHOILUONG, @C_GIACUOC, @C_PHUTROI, @C_HINHTHUCTT, @C_DATHU, @C_TIENHANG, @FK_NHANVIENNHAN, @FK_DOITAC, @C_GIADOITAC, @FK_NHANVIENPHAT, @C_NGAYGIOPHAT, @C_NGUOIKYNHAN, @C_BOPHAN);SELECT @IDNHANGUI = SCOPE_IDENTITY()" 
    SelectCommand="SELECT [NHANGUI].[PK_ID], [NHANGUI].[C_NGAY], [NHANGUI].[C_MAKH], [NHANGUI].[C_BILL], [NHANGUI].[C_TENKH], [NHANGUI].[C_NGUOINHAN], [NHANGUI].[C_DIACHINHAN], [NHANGUI].[FK_QUANHUYEN], [NHANGUI].[C_NOIDUNG], [NHANGUI].[FK_MASANPHAM], [NHANGUI].[C_KHOILUONG], [NHANGUI].[C_GIACUOC], [NHANGUI].[C_PHUTROI], [NHANGUI].[C_HINHTHUCTT], [NHANGUI].[C_DATHU], [NHANGUI].[C_TIENHANG], [NHANGUI].[FK_NHANVIENNHAN], [NHANGUI].[FK_DOITAC], [NHANGUI].[C_GIADOITAC], [NHANGUI].[FK_NHANVIENPHAT], [NHANGUI].[C_NGAYGIOPHAT], [NHANGUI].[C_NGUOIKYNHAN], [NHANGUI].[C_BOPHAN],USERSNHAN.C_NAME as NHANVIENNHANNAME,USERSPHAT.C_NAME as NHANVIENPHATNAME FROM [NHANGUI] LEFT OUTER JOIN USERS as USERSNHAN ON NHANGUI.FK_NHANVIENNHAN = USERSNHAN.PK_ID LEFT OUTER JOIN USERS as USERSPHAT ON NHANGUI.FK_NHANVIENPHAT = USERSPHAT.PK_ID" 
    UpdateCommand="UPDATE [NHANGUI] SET [C_NGAY] = @C_NGAY, [C_MAKH] = @C_MAKH, [C_BILL] = @C_BILL, [C_TENKH] = @C_TENKH, [C_NGUOINHAN] = @C_NGUOINHAN, [C_DIACHINHAN] = @C_DIACHINHAN, [FK_QUANHUYEN] = @FK_QUANHUYEN, [C_NOIDUNG] = @C_NOIDUNG, [FK_MASANPHAM] = @FK_MASANPHAM, [C_KHOILUONG] = @C_KHOILUONG, [C_GIACUOC] = @C_GIACUOC, [C_PHUTROI] = @C_PHUTROI, [C_HINHTHUCTT] = @C_HINHTHUCTT, [C_DATHU] = @C_DATHU, [C_TIENHANG] = @C_TIENHANG, [FK_NHANVIENNHAN] = @FK_NHANVIENNHAN, [FK_DOITAC] = @FK_DOITAC, [C_GIADOITAC] = @C_GIADOITAC, [FK_NHANVIENPHAT] = @FK_NHANVIENPHAT, [C_NGAYGIOPHAT] = @C_NGAYGIOPHAT, [C_NGUOIKYNHAN] = @C_NGUOIKYNHAN, [C_BOPHAN] = @C_BOPHAN WHERE [PK_ID] = @PK_ID"
    oninserted="NHANGUIDataSource_Inserted">
    <DeleteParameters>
        <asp:Parameter Name="PK_ID" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="C_NGAY" Type="DateTime" />
        <asp:Parameter Name="C_MAKH" Type="String" />
        <asp:Parameter Name="C_BILL" Type="String" />
        <asp:Parameter Name="C_TENKH" Type="String" />
        <asp:Parameter Name="C_NGUOINHAN" Type="String" />
        <asp:Parameter Name="C_DIACHINHAN" Type="String" />
        <asp:Parameter Name="FK_QUANHUYEN" Type="String" />
        <asp:Parameter Name="C_NOIDUNG" Type="String" />
        <asp:Parameter Name="FK_MASANPHAM" Type="Int32" />
        <asp:Parameter Name="C_KHOILUONG" Type="Single" />
        <asp:Parameter Name="C_GIACUOC" Type="Single" />
        <asp:Parameter Name="C_PHUTROI" Type="String" />
        <asp:Parameter Name="C_HINHTHUCTT" Type="String" />
        <asp:Parameter Name="C_DATHU" Type="String" />
        <asp:Parameter Name="C_TIENHANG" Type="String" />
        <asp:Parameter Name="FK_NHANVIENNHAN" Type="Int32" />
        <asp:Parameter Name="FK_DOITAC" Type="Int32" />
        <asp:Parameter Name="C_GIADOITAC" Type="Single" />
        <asp:Parameter Name="FK_NHANVIENPHAT" Type="Int32" />
        <asp:Parameter Name="C_NGAYGIOPHAT" Type="DateTime" />
        <asp:Parameter Name="C_NGUOIKYNHAN" Type="String" />
        <asp:Parameter Name="C_BOPHAN" Type="String" />
        <asp:Parameter Name="IDNHANGUI" Type="Int32" Direction="Output" DefaultValue="0"/>
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="C_NGAY" Type="DateTime" />
        <asp:Parameter Name="C_MAKH" Type="String" />
        <asp:Parameter Name="C_BILL" Type="String" />
        <asp:Parameter Name="C_TENKH" Type="String" />
        <asp:Parameter Name="C_NGUOINHAN" Type="String" />
        <asp:Parameter Name="C_DIACHINHAN" Type="String" />
        <asp:Parameter Name="FK_QUANHUYEN" Type="String" />
        <asp:Parameter Name="C_NOIDUNG" Type="String" />
        <asp:Parameter Name="FK_MASANPHAM" Type="Int32" />
        <asp:Parameter Name="C_KHOILUONG" Type="Single" />
        <asp:Parameter Name="C_GIACUOC" Type="Single" />
        <asp:Parameter Name="C_PHUTROI" Type="String" />
        <asp:Parameter Name="C_HINHTHUCTT" Type="String" />
        <asp:Parameter Name="C_DATHU" Type="String" />
        <asp:Parameter Name="C_TIENHANG" Type="String" />
        <asp:Parameter Name="FK_NHANVIENNHAN" Type="Int32" />
        <asp:Parameter Name="FK_DOITAC" Type="Int32" />
        <asp:Parameter Name="C_GIADOITAC" Type="Single" />
        <asp:Parameter Name="FK_NHANVIENPHAT" Type="Int32" />
        <asp:Parameter Name="C_NGAYGIOPHAT" Type="DateTime" />
        <asp:Parameter Name="C_NGUOIKYNHAN" Type="String" />
        <asp:Parameter Name="C_BOPHAN" Type="String" />
        <asp:Parameter Name="PK_ID" Type="Int32" />
    </UpdateParameters>       
</asp:SqlDataSource>
 <asp:SqlDataSource ID="NHOMKHACHHANGDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
 SelectCommand="SELECT DMNHOMKHACHHANG.* FROM DMNHOMKHACHHANG" >
</asp:SqlDataSource>
 <asp:SqlDataSource ID="KHACHHANGDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
 SelectCommand="SELECT DMKHACHHANG.* FROM DMKHACHHANG" >
</asp:SqlDataSource>
<asp:SqlDataSource ID="MASANPHAMDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
  SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMMASANPHAM]  WHERE C_CODE <> 'QT' ORDER BY PK_ID">
</asp:SqlDataSource>
<asp:SqlDataSource ID="MAVUNGDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>">
</asp:SqlDataSource>
 <asp:SqlDataSource ID="TINHTHANHDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [DMTINHTHANH].[PK_ID], [DMTINHTHANH].[C_CODE], [DMTINHTHANH].[C_NAME] FROM [DMTINHTHANH] LEFT OUTER JOIN DMQUOCGIA ON DMTINHTHANH.FK_QUOCGIA = DMQUOCGIA.PK_ID WHERE DMQUOCGIA.C_CODE='VN'">
 </asp:SqlDataSource>
 <asp:SqlDataSource ID="QUANHUYENDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>">
</asp:SqlDataSource>
<asp:SqlDataSource ID="UserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT USERS.PK_ID,USERS.FK_GroupUser,USERS.FK_DEPT,USERS.C_LoginName,USERS.C_Password,USERS.C_NAME,USERS.C_Address,USERS.c_Tel,USERS.C_Email,USERS.C_DESC,GROUPUSER.C_NAME AS GROUPUSERNAME FROM USERS INNER JOIN GROUPUSER ON  USERS.FK_GROUPUSER = GROUPUSER.PK_ID WHERE FK_GroupUser <> 0">
</asp:SqlDataSource>
<asp:SqlDataSource ID="DOITACDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>" 
    SelectCommand="SELECT [DMDOITAC].[PK_ID], [DMDOITAC].[C_CODE], [DMDOITAC].[C_NAME], [DMDOITAC].[C_ADDRESS], [DMDOITAC].[C_TEL], [DMDOITAC].[C_NGUOILIENHE] FROM [DMDOITAC]">
</asp:SqlDataSource>