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
    <MasterTableView Name="MasterTableViewNHANGUI" CommandItemDisplay="Top" DataSourceID="NHANGUIDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="EditForms" NoMasterRecordsText="Không có dữ liệu">
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
                <telerik:GridBoundColumn UniqueName="C_NGAY" HeaderText="Ngày" DataField="C_NGAY" HeaderStyle-Width="50px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_BILL" HeaderText="Số Bill" DataField="C_BILL" HeaderStyle-Width="50px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_MAKH" HeaderText="Mã khách hàng" DataField="C_MAKH" HeaderStyle-Width="100px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_TENKH" HeaderText="Tên khách hàng" DataField="C_TENKH" HeaderStyle-Width="110px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_NGUOINHAN" HeaderText="Người nhận" DataField="C_NGUOINHAN" HeaderStyle-Width="90px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_DIACHINHAN" HeaderText="Địa chỉ nhận" DataField="C_DIACHINHAN" HeaderStyle-Width="130px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn UniqueName="TINHTHANHNAME" HeaderText="Tỉnh thành đến" DataField="TINHTHANHNAME" HeaderStyle-Width="130px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="QUANHUYENNAME" HeaderText="Quận huyện đến" DataField="QUANHUYENNAME" HeaderStyle-Width="130px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_NOIDUNG" HeaderText="Nội dung" DataField="C_NOIDUNG" HeaderStyle-Width="130px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_KHOILUONG" HeaderText="Khối lượng" DataField="C_KHOILUONG" HeaderStyle-Width="130px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="BANGCUOCNAME" HeaderText="Dịch vụ" DataField="BANGCUOCNAME" HeaderStyle-Width="130px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_GIACUOC" HeaderText="Cước chính" DataField="C_GIACUOC" HeaderStyle-Width="130px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_PPXD" HeaderText="PPXD" DataField="C_PPXD" HeaderStyle-Width="130px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_PHUTROI" HeaderText="DV phụ trội" DataField="C_PHUTROI" HeaderStyle-Width="130px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_HINHTHUCTT" HeaderText="Hình thức TT" DataField="C_HINHTHUCTT" HeaderStyle-Width="130px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_TINHTRANGTT" HeaderText="Tình trạng TT" DataField="C_TINHTRANGTT" HeaderStyle-Width="130px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_TIENHANG" HeaderText="Tiền hàng" DataField="C_TIENHANG" HeaderStyle-Width="130px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="NHANVIENNHANNAME" HeaderText="Nhân viên nhận" DataField="NHANVIENNHANNAME" HeaderStyle-Width="130px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="DOITACNAME" HeaderText="Đối tác" DataField="DOITACNAME" HeaderStyle-Width="130px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_GIADOITAC" HeaderText="Giá đối tác" DataField="C_GIADOITAC" HeaderStyle-Width="130px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="NHANVIENPHATNAME" HeaderText="Nhân viên phát" DataField="NHANVIENPHATNAME" HeaderStyle-Width="130px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_NGAYGIOPHAT" HeaderText="Ngày giờ phát" DataField="C_NGAYGIOPHAT" HeaderStyle-Width="130px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_NGUOIKYNHAN" HeaderText="Người ký" DataField="C_NGUOIKYNHAN" HeaderStyle-Width="130px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_BOPHAN" HeaderText="Bộ phận" DataField="C_BOPHAN" HeaderStyle-Width="130px"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
        </Columns>
        <EditFormSettings InsertCaption="Thêm nhận gửi mới" CaptionFormatString="Sửa nhận gửi: <b>{0}</b>" CaptionDataField="C_BILL" EditFormType="Template" PopUpSettings-Width="600px">
        <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
           <FormTemplate>
            <div class="headerthongtin">
              <ul>
                <li class="lifirst"><asp:LinkButton ID="btnSave" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'><img src="Images/img_save.jpg" /><%# (Container is GridEditFormInsertItem) ? "Lưu" : "Lưu" %></asp:LinkButton></li>
                     <li><asp:LinkButton ID="btnClose" runat="server" CommandName="Cancel"><img src="Images/img_Close.jpg" />Đóng</asp:LinkButton></li>                     
              </ul>
            </div>               
            <div class="clearfix bgpopup"> 
            <div style="width:600px;background:#FFFFFF" class="clearfix">      
            <table id="tblEdit" class ="TableEditInGrid" cellspacing="3" cellpadding="3" style="width: 100%" border="0">
            <tr>
                <td style =" width:150px;"> <span class="rtsTxtnew">Ngày nhận gửi:</td>
                <td colspan="4">
                    <telerik:RadDatePicker ID="radNgaynhangui" Width ="150px" DbSelectedDate ='<%# Bind("C_NGAY") %>' runat="server" AutoPostBack ="false" >
                        <DateInput ID ="DateInput1" runat ="server" DateFormat ="dd/MM/yyyy" MinDate="1/1/1890 12:00:00 AM">
                        <ClientEvents  OnKeyPress ="controlkeypress"/>
                        </DateInput>
                    </telerik:RadDatePicker>
                </td>
            </tr> 
            <tr>
            <tr>
                 <td style =" width:150px;"> <span class="rtsTxtnew">Số Bill:</td>
                <td colspan="4">
                    <asp:HiddenField ID="txtID" Value ='<%# Eval( "PK_ID") %>' runat="server" />
                    <telerik:RadTextBox ID="txtCODE" Width ="90%" Text='<%# Bind( "C_BILL") %>' runat="server"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="rfvCODE" runat="server" ErrorMessage="Số Bill không thể rỗng" ControlToValidate="txtCODE" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="cuvCODE" ControlToValidate="txtCODE" OnServerValidate="CheckBill" runat="server" ErrorMessage="Số Bill đã tồn tại" Display="Dynamic" ValidationGroup="G1"></asp:CustomValidator>
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
    DeleteCommand="DELETE FROM [NHANGUI] WHERE [PL_ID] = @PL_ID" 
    InsertCommand="INSERT INTO [NHANGUI] ([C_NGAY], [C_MAKH], [C_BILL], [C_TENKH], [C_NGUOINHAN], [C_DIACHINHAN], [FK_QUANHUYEN], [C_NOIDUNG], [FK_MABANGCUOC], [C_KHOILUONG], [C_GIACUOC], [C_PHUTROI], [C_HINHTHUCTT], [C_TINHTRANGTT], [C_TIENHANG], [FK_NHANVIENNHAN], [FK_DOITAC], [C_GIADOITAC], [FK_NHANVIENPHAT], [C_NGAYGIOPHAT], [C_NGUOIKYNHAN], [C_BOPHAN]) VALUES (@C_NGAY, @C_MAKH, @C_BILL, @C_TENKH, @C_NGUOINHAN, @C_DIACHINHAN, @FK_QUANHUYEN, @C_NOIDUNG, @FK_MABANGCUOC, @C_KHOILUONG, @C_GIACUOC, @C_PHUTROI, @C_HINHTHUCTT, @C_TINHTRANGTT, @C_TIENHANG, @FK_NHANVIENNHAN, @FK_DOITAC, @C_GIADOITAC, @FK_NHANVIENPHAT, @C_NGAYGIOPHAT, @C_NGUOIKYNHAN, @C_BOPHAN)" 
    SelectCommand="SELECT [PL_ID], [C_NGAY], [C_MAKH], [C_BILL], [C_TENKH], [C_NGUOINHAN], [C_DIACHINHAN], [FK_QUANHUYEN], [C_NOIDUNG], [FK_MABANGCUOC], [C_KHOILUONG], [C_GIACUOC], [C_PHUTROI], [C_HINHTHUCTT], [C_TINHTRANGTT], [C_TIENHANG], [FK_NHANVIENNHAN], [FK_DOITAC], [C_GIADOITAC], [FK_NHANVIENPHAT], [C_NGAYGIOPHAT], [C_NGUOIKYNHAN], [C_BOPHAN] FROM [NHANGUI]" 
    UpdateCommand="UPDATE [NHANGUI] SET [C_NGAY] = @C_NGAY, [C_MAKH] = @C_MAKH, [C_BILL] = @C_BILL, [C_TENKH] = @C_TENKH, [C_NGUOINHAN] = @C_NGUOINHAN, [C_DIACHINHAN] = @C_DIACHINHAN, [FK_QUANHUYEN] = @FK_QUANHUYEN, [C_NOIDUNG] = @C_NOIDUNG, [FK_MABANGCUOC] = @FK_MABANGCUOC, [C_KHOILUONG] = @C_KHOILUONG, [C_GIACUOC] = @C_GIACUOC, [C_PHUTROI] = @C_PHUTROI, [C_HINHTHUCTT] = @C_HINHTHUCTT, [C_TINHTRANGTT] = @C_TINHTRANGTT, [C_TIENHANG] = @C_TIENHANG, [FK_NHANVIENNHAN] = @FK_NHANVIENNHAN, [FK_DOITAC] = @FK_DOITAC, [C_GIADOITAC] = @C_GIADOITAC, [FK_NHANVIENPHAT] = @FK_NHANVIENPHAT, [C_NGAYGIOPHAT] = @C_NGAYGIOPHAT, [C_NGUOIKYNHAN] = @C_NGUOIKYNHAN, [C_BOPHAN] = @C_BOPHAN WHERE [PL_ID] = @PL_ID">
    <DeleteParameters>
        <asp:Parameter Name="PL_ID" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="C_NGAY" Type="DateTime" />
        <asp:Parameter Name="C_MAKH" Type="String" />
        <asp:Parameter Name="C_BILL" Type="String" />
        <asp:Parameter Name="C_TENKH" Type="String" />
        <asp:Parameter Name="C_NGUOINHAN" Type="String" />
        <asp:Parameter Name="C_DIACHINHAN" Type="String" />
        <asp:Parameter Name="FK_QUANHUYEN" Type="Int32" />
        <asp:Parameter Name="C_NOIDUNG" Type="String" />
        <asp:Parameter Name="FK_MABANGCUOC" Type="Int32" />
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
        <asp:Parameter Name="FK_QUANHUYEN" Type="Int32" />
        <asp:Parameter Name="C_NOIDUNG" Type="String" />
        <asp:Parameter Name="FK_MABANGCUOC" Type="Int32" />
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
        <asp:Parameter Name="PL_ID" Type="Int32" />
    </UpdateParameters>
       
</asp:SqlDataSource>

