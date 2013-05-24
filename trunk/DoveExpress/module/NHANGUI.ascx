<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NHANGUI.ascx.cs" Inherits="module_NHANGUI" %>
<telerik:RadCodeBlock ID="RadCodeBlockNHANGUI" runat="server">
<script type="text/javascript">
        function RowDblClick(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("NHANGUI") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewNHANGUI") && (CanEdit == "True")) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
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
                        <b>Quản lý nhận gửi</b>&nbsp;&nbsp;&nbsp;&nbsp;
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
                <telerik:GridBoundColumn UniqueName="C_NGAY" HeaderText="Ngày" DataField="C_NGAY" HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center"
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
                <telerik:GridBoundColumn UniqueName="C_NOIDUNG" HeaderText="Nội dung" DataField="C_NOIDUNG" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_KHOILUONG" HeaderText="Khối lượng" DataField="C_KHOILUONG" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="SANPHAMNAME" HeaderText="Dịch vụ" DataField="SANPHAMNAME" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="MAVUNGNAME" HeaderText="Vùng tính cước" DataField="MAVUNGNAME" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_GIACUOC" HeaderText="Cước chính" DataField="C_GIACUOC" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_PPXD" HeaderText="PPXD" DataField="C_PPXD" HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_PHUTROI" HeaderText="DV phụ trội" DataField="C_PHUTROI" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_HINHTHUCTT" HeaderText="Hình thức TT" DataField="C_HINHTHUCTT" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_TINHTRANGTT" HeaderText="Tình trạng TT" DataField="C_TINHTRANGTT" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_TIENHANG" HeaderText="Tiền hàng" DataField="C_TIENHANG" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
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
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
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
                <td style ="width:100px;"> <span class="rtsTxtnew">Số Bill:</td>
                <td colspan="4">
                    <asp:HiddenField ID="txtID" Value ='<%# Eval( "PK_ID") %>' runat="server" />
                    <telerik:RadTextBox ID="txtCODE" Width ="90%" Text='<%# Bind("C_BILL") %>' runat="server"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="rfvCODE" runat="server" ErrorMessage="Số Bill không thể rỗng" ControlToValidate="txtCODE" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="cuvCODE" ControlToValidate="txtCODE" OnServerValidate="CheckBill" runat="server" ErrorMessage="Số Bill đã tồn tại" Display="Dynamic" ValidationGroup="G1"></asp:CustomValidator>
                </td>               
            </tr>
            <tr>
                <td style ="width:100px;"> <span class="rtsTxtnew">Nhóm KH:</td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbNhomKhachHang" runat="server"
                    DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="NHOMKHACHHANGDataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn nhóm">
                    </telerik:RadComboBox>
                </td>
                <td style ="width:100px;"> <span class="rtsTxtnew">Mã khách hàng:</td>
                <td colspan="4">
                    <telerik:RadTextBox ID="txtC_MAKH" Width ="90%" Text='<%# Bind("C_MAKH") %>' runat="server"></telerik:RadTextBox>
                </td>
                <td style ="width:100px;"> <span class="rtsTxtnew">Tên khách hàng:</td>
                <td colspan="8">
                    <telerik:RadTextBox ID="txtC_TENKH" Width ="90%" Text='<%# Bind("C_TENKH") %>' runat="server"></telerik:RadTextBox>
                </td>               
            </tr> 
            <tr> 
                <td style ="width:100px;"> <span class="rtsTxtnew">Người nhận:</td>
                <td colspan="4">
                    <telerik:RadTextBox ID="txtC_NGUOINHAN" Width ="90%" Text='<%# Bind("C_NGUOINHAN") %>' runat="server"></telerik:RadTextBox>
                </td>               
                <td style =" width:100px;"> <span class="rtsTxtnew">Địa chỉ nhận:</td>
                <td colspan="12">
                    <telerik:RadTextBox ID="txtC_DIACHINHAN" Width ="90%" Text='<%# Bind("C_DIACHINHAN") %>' runat="server"></telerik:RadTextBox>
                </td>
            </tr> 
            <tr> 
                <td style =" width:100px;"> <span class="rtsTxtnew">Nội dung:</td>
                <td colspan="16">
                    <telerik:RadTextBox ID="RadTextBox1" Width ="90%" Text='<%# Bind("C_NOIDUNG") %>' runat="server"></telerik:RadTextBox>
                </td>
            </tr
            <tr> 
                <td style =" width:100px;"> <span class="rtsTxtnew">Khối lượng:</td>
                <td colspan="4">
                    <telerik:RadTextBox ID="txtC_KHOILUONG" Width ="90%" Text='<%# Bind("C_KHOILUONG") %>' runat="server"></telerik:RadTextBox>
                </td>
                <td style =" width:100px;"> <span class="rtsTxtnew">Dịch vụ:</td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbSanPham" runat="server" 
                    DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="MASANPHAMDataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn dịch vụ">
                    </telerik:RadComboBox>
                </td>
                <td style =" width:100px;"> <span class="rtsTxtnew">Vùng tính cước:</td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbMaVung" runat="server" SelectedValue='<%# Bind("FK_MAVUNG") %>'
                    DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="MAVUNGDataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn vùng">
                    </telerik:RadComboBox>
                </td>
            </tr
            <tr>                
                <td style =" width:100px;"> <span class="rtsTxtnew">Cước chính:</td>
                <td colspan="4">
                    <telerik:RadTextBox ID="txtC_GIACUOC" Width ="90%" Text='<%# Bind("C_GIACUOC") %>' runat="server"></telerik:RadTextBox>
                </td>
                <td style =" width:100px;"> <span class="rtsTxtnew">PPXD:</td>
                <td colspan="4">
                    <telerik:RadTextBox ID="txtPPXD" Width ="90%" runat="server"></telerik:RadTextBox>
                </td>
                 <td style =" width:100px;"> <span class="rtsTxtnew">DV phụ trội:</td>
                <td colspan="4">
                    <telerik:RadTextBox ID="txtC_PHUTROI" Width ="90%" Text='<%# Bind("C_PHUTROI") %>' runat="server"></telerik:RadTextBox>
                </td>
            </tr
           </table>
            </div> 
             </center> 
        <!-- end bgpopup--></div>    
             </FormTemplate>
        </EditFormSettings>
        </MasterTableView>
        <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G1"/>
        <ClientSettings AllowKeyboardNavigation="true" KeyboardNavigationSettings-AllowSubmitOnEnter="true">
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
    InsertCommand="INSERT INTO [NHANGUI] ([C_NGAY], [C_MAKH], [C_BILL], [C_TENKH], [C_NGUOINHAN], [C_DIACHINHAN], [FK_MAVUNG], [C_NOIDUNG], [FK_MASANPHAM], [C_KHOILUONG], [C_GIACUOC], [C_PHUTROI], [C_HINHTHUCTT], [C_TINHTRANGTT], [C_TIENHANG], [FK_NHANVIENNHAN], [FK_DOITAC], [C_GIADOITAC], [FK_NHANVIENPHAT], [C_NGAYGIOPHAT], [C_NGUOIKYNHAN], [C_BOPHAN]) VALUES (@C_NGAY, @C_MAKH, @C_BILL, @C_TENKH, @C_NGUOINHAN, @C_DIACHINHAN, @FK_MAVUNG, @C_NOIDUNG, @FK_MASANPHAM, @C_KHOILUONG, @C_GIACUOC, @C_PHUTROI, @C_HINHTHUCTT, @C_TINHTRANGTT, @C_TIENHANG, @FK_NHANVIENNHAN, @FK_DOITAC, @C_GIADOITAC, @FK_NHANVIENPHAT, @C_NGAYGIOPHAT, @C_NGUOIKYNHAN, @C_BOPHAN)" 
    SelectCommand="SELECT [PK_ID], [C_NGAY], [C_MAKH], [C_BILL], [C_TENKH], [C_NGUOINHAN], [C_DIACHINHAN], [FK_MAVUNG], [C_NOIDUNG], [FK_MASANPHAM], [C_KHOILUONG], [C_GIACUOC], [C_PHUTROI], [C_HINHTHUCTT], [C_TINHTRANGTT], [C_TIENHANG], [FK_NHANVIENNHAN], [FK_DOITAC], [C_GIADOITAC], [FK_NHANVIENPHAT], [C_NGAYGIOPHAT], [C_NGUOIKYNHAN], [C_BOPHAN] FROM [NHANGUI]" 
    UpdateCommand="UPDATE [NHANGUI] SET [C_NGAY] = @C_NGAY, [C_MAKH] = @C_MAKH, [C_BILL] = @C_BILL, [C_TENKH] = @C_TENKH, [C_NGUOINHAN] = @C_NGUOINHAN, [C_DIACHINHAN] = @C_DIACHINHAN, [FK_MAVUNG] = @FK_MAVUNG, [C_NOIDUNG] = @C_NOIDUNG, [FK_MASANPHAM] = @FK_MASANPHAM, [C_KHOILUONG] = @C_KHOILUONG, [C_GIACUOC] = @C_GIACUOC, [C_PHUTROI] = @C_PHUTROI, [C_HINHTHUCTT] = @C_HINHTHUCTT, [C_TINHTRANGTT] = @C_TINHTRANGTT, [C_TIENHANG] = @C_TIENHANG, [FK_NHANVIENNHAN] = @FK_NHANVIENNHAN, [FK_DOITAC] = @FK_DOITAC, [C_GIADOITAC] = @C_GIADOITAC, [FK_NHANVIENPHAT] = @FK_NHANVIENPHAT, [C_NGAYGIOPHAT] = @C_NGAYGIOPHAT, [C_NGUOIKYNHAN] = @C_NGUOIKYNHAN, [C_BOPHAN] = @C_BOPHAN WHERE [PK_ID] = @PK_ID">
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
        <asp:Parameter Name="FK_MAVUNG" Type="Int32" />
        <asp:Parameter Name="C_NOIDUNG" Type="String" />
        <asp:Parameter Name="FK_MASANPHAM" Type="Int32" />
        <asp:Parameter Name="C_KHOILUONG" Type="Single" />
        <asp:Parameter Name="C_GIACUOC" Type="Single" />
        <asp:Parameter Name="C_PHUTROI" Type="String" />
        <asp:Parameter Name="C_HINHTHUCTT" Type="String" />
        <asp:Parameter Name="C_TINHTRANGTT" Type="String" />
        <asp:Parameter Name="C_TIENHANG" Type="String" />
        <asp:Parameter Name="FK_NHANVIENNHAN" Type="Int32" />
        <asp:Parameter Name="FK_DOITAC" Type="Int32" />
        <asp:Parameter Name="C_GIADOITAC" Type="Single" />
        <asp:Parameter Name="FK_NHANVIENPHAT" Type="Int32" />
        <asp:Parameter Name="C_NGAYGIOPHAT" Type="DateTime" />
        <asp:Parameter Name="C_NGUOIKYNHAN" Type="String" />
        <asp:Parameter Name="C_BOPHAN" Type="String" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="C_NGAY" Type="DateTime" />
        <asp:Parameter Name="C_MAKH" Type="String" />
        <asp:Parameter Name="C_BILL" Type="String" />
        <asp:Parameter Name="C_TENKH" Type="String" />
        <asp:Parameter Name="C_NGUOINHAN" Type="String" />
        <asp:Parameter Name="C_DIACHINHAN" Type="String" />
        <asp:Parameter Name="FK_MAVUNG" Type="Int32" />
        <asp:Parameter Name="C_NOIDUNG" Type="String" />
        <asp:Parameter Name="FK_MASANPHAM" Type="Int32" />
        <asp:Parameter Name="C_KHOILUONG" Type="Single" />
        <asp:Parameter Name="C_GIACUOC" Type="Single" />
        <asp:Parameter Name="C_PHUTROI" Type="String" />
        <asp:Parameter Name="C_HINHTHUCTT" Type="String" />
        <asp:Parameter Name="C_TINHTRANGTT" Type="String" />
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
 SelectCommand="SELECT DMNHOMKHACHHANG.* FROM DMNHOMKHACHHANG WHERE C_TYPE = 0" >
</asp:SqlDataSource>
<asp:SqlDataSource ID="MASANPHAMDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
        SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMMASANPHAM] ORDER BY PK_ID">
</asp:SqlDataSource>
<asp:SqlDataSource ID="MAVUNGDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>">
</asp:SqlDataSource>

