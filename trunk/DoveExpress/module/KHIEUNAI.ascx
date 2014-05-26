<%@ Control Language="C#" AutoEventWireup="true" CodeFile="KHIEUNAI.ascx.cs" Inherits="module_KHIEUNAI" %>
<%@ Register TagPrefix="custom" Namespace="ITCLIB.Admin" %>
<telerik:RadCodeBlock ID="RadCodeBlockKHIEUNAI" runat="server">
    <script type="text/javascript">
        function RowDblClick(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("KHIEUNAI") %>";
        if ((eventArgs.get_tableView().get_name() == "MasterTableViewKHIEUNAI") && (CanEdit == "True")) {
            sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
        }
    }
    </script>
    <script type="text/javascript">
        var registeredElementsDT = [];
        function GetRegisteredServerElementDT(serverID) {
            var clientID = "";
            for (var i = 0; i < registeredElementsDT.length; i++) {
                clientID = registeredElementsDT[i];
                if (clientID.indexOf(serverID) >= 0)
                    break;
            }
            return $get(clientID);
        }
        function GetGridServerElementDT(serverID, tagName) {
            if (!tagName)
                tagName = "*";

            var grid = $get("<%=RadGridKHIEUNAI.ClientID %>");
        var elements = grid.getElementsByTagName(tagName);
        for (var i = 0; i < elements.length; i++) {
            var element = elements[i];
            if (element.id.indexOf(serverID) >= 0)
                return element;
        }
    }
    </script>
    <script type="text/javascript">
        var cmbC_TYPE;
        function OnClientLoadcmbC_TYPE(sender) {
            cmbC_TYPE = sender;
        }
        var cmbMaKhachHang;
        function OnClientLoadcmbMaKhachHang(sender) {
            cmbMaKhachHang = sender;
        }
        var txtC_TENKH;
        function OnClientLoadtxtC_TENKH(sender) {
            txtC_TENKH = sender;
        }
        var txtC_SDT;
        function OnClientLoadtxtC_SDT(sender) {
            txtC_SDT = sender;
        }
        var txtC_BILL;
        function OnClientLoadtxtC_BILL(sender) {
            txtC_BILL = sender;
        }
        function OnKeyPressRadTextBox(sender, eventArgs) {
            var charCode = eventArgs.get_keyCode();
            if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
                eventArgs.set_cancel(true);
            }
            return false;
        }
        checkKH = true;
        function cmbC_TYPEClientSelectedIndexChangedHandler(sender, eventArgs) {
            if (eventArgs.get_item().get_value() == 'Bill') {
                checkKH = !checkKH;
                $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("cmbC_TYPE;" + txtC_BILL.get_value());
                var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelKHIEUNAI.ClientID %>");
                var currentUpdatedControl = "<%= RadGridKHIEUNAI.ClientID %>";
                currentLoadingPanel.show(currentUpdatedControl);
            }
            return false;
        }
        function cmbMaKhachHangClientSelectedIndexChangedHandler(sender, eventArgs) {
            if (checkKH) {
                $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("cmbMaKhachHang;" + eventArgs.get_item().get_value());
                var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelKHIEUNAI.ClientID %>");
                var currentUpdatedControl = "<%= RadGridKHIEUNAI.ClientID %>";
                currentLoadingPanel.show(currentUpdatedControl);
            }
            return false;
        }
        function OnValueChangedtxtC_BILL(sender, eventArgs) {
            if (cmbC_TYPE.get_selectedItem().get_value() == 'Bill') {
                checkKH = !checkKH;
                $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("txtC_BILL;" + eventArgs.get_newValue());
                var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelKHIEUNAI.ClientID %>");
                var currentUpdatedControl = "<%= RadGridKHIEUNAI.ClientID %>";
                currentLoadingPanel.show(currentUpdatedControl);
            }
            return false;
        }
    </script>
     <script type="text/javascript">
         function onResponseEndKN() {
             if (typeof (result) != "undefined" && result && result != "") {
                 //alert(result);
                 var arrayOfStrings = result.split(",-,");
                 if (arrayOfStrings[0] != "msg") {
                     if (arrayOfStrings[0] != "") {
                         if (!checkKH) {
                             var comboItem = new Telerik.Web.UI.RadComboBoxItem();
                             comboItem = cmbMaKhachHang.findItemByText(arrayOfStrings[0]);
                             comboItem.set_text(arrayOfStrings[0]);
                             cmbMaKhachHang.trackChanges();
                             comboItem.select();
                             cmbMaKhachHang.commitChanges();
                         }
                         txtC_TENKH.set_value(arrayOfStrings[1]);
                         txtC_SDT.set_value(arrayOfStrings[2]);
                         checkKH = true;
                     }
                     else {
                     }
                     
                }
                var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelKHIEUNAI.ClientID %>");
                var currentUpdatedControl = "<%= RadGridKHIEUNAI.ClientID %>";
                currentLoadingPanel.hide(currentUpdatedControl);
                result = "";
            }
            return false;
        }
    </script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelKHIEUNAI" runat="server" />
<telerik:RadGrid ID="RadGridKHIEUNAI" runat="server" Skin="Vista"
    AllowPaging="True" PageSize="20" AllowSorting="True"
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True"
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True"
    DataSourceID="KHIEUNAIDataSource" ShowFooter="True"
    OnDataBound="RadGridKHIEUNAI_DataBound"
    OnItemDeleted="RadGridKHIEUNAI_ItemDeleted" OnItemInserted="RadGridKHIEUNAI_ItemInserted"
    OnItemUpdated="RadGridKHIEUNAI_ItemUpdated"
    OnItemCommand="RadGridKHIEUNAI_ItemCommand"
    OnItemDataBound="RadGridKHIEUNAI_ItemDataBound" CellSpacing="0"
    OnItemCreated="RadGridKHIEUNAI_ItemCreated">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp"
        PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>
    <GroupingSettings CaseSensitive="false" />
    <MasterTableView Name="MasterTableViewKHIEUNAI" CommandItemDisplay="Top" DataSourceID="KHIEUNAIDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
            <div style="padding: 5px 5px; float: left; width: auto">
                <b>Quản lý khiếu nại</b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridKHIEUNAI.EditIndexes.Count == 0 && ITCLIB.Security.Security.CanEditModule("KHIEUNAI") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridKHIEUNAI.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Update.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridKHIEUNAI.EditIndexes.Count > 0 || RadGridKHIEUNAI.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridKHIEUNAI.MasterTableView.IsItemInserted && ITCLIB.Security.Security.CanAddModule("KHIEUNAI") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="PerformInsert" Visible='<%# RadGridKHIEUNAI.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Insert.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:return confirm('Bạn có muốn xóa bản ghi đã chọn không?')" runat="server" CommandName="DeleteSelected" Visible='<%# ITCLIB.Security.Security.CanDeleteModule("KHIEUNAI") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Delete.gif" />Xóa</asp:LinkButton>&nbsp;&nbsp;
                       <asp:LinkButton ID="LinkButton4" runat="server" CommandName="RebindGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Refresh.gif" />Làm mới</asp:LinkButton>
            </div>
            <div style="padding: 5px 5px; float: right; width: auto">
                <asp:LinkButton ID="ExportToPdfButton" runat="server" CommandName="ExportToPdf"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/pdf.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToWordButton" runat="server" CommandName="ExportToWord"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/word.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToExcelButton" runat="server" CommandName="ExportToExcel"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/excel.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToCsvButton" runat="server" CommandName="ExportToCsv"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/csv.gif" /></asp:LinkButton>&nbsp;&nbsp;
            </div>
        </CommandItemTemplate>
        <Columns>
            <telerik:GridBoundColumn UniqueName="PK_ID" HeaderText="" DataField="PK_ID" Visible="false"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridTemplateColumn HeaderText="" ShowFilterIcon="false">
                <FilterTemplate>
                    <center>
                    <asp:ImageButton ID="btnShowAll" runat="server" ImageUrl="../Images/Grid/filterCancel.gif" AlternateText="Xem tất" ToolTip="Xem tất" OnClick="btnShowAll_Click" Style="vertical-align: middle" />
                  </center>
                </FilterTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblSTT" runat="server" Text=""></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Center" Width="30px" />
                <ItemStyle HorizontalAlign="Center" Width="30px" />
            </telerik:GridTemplateColumn>
            <telerik:GridBoundColumn UniqueName="C_CODE" HeaderText="Mã khiếu nại" DataField="C_CODE" HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_TYPE" HeaderText="Loại khiếu nại" DataField="C_TYPE" HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_DATE" HeaderText="Thời gian" DataField="C_DATE"
                HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                ShowFilterIcon="true" FilterControlWidth="70%" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_BILL" HeaderText="Chủ đề" DataField="C_BILL" HeaderStyle-Width="180px" HeaderStyle-HorizontalAlign="Center" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
             <telerik:GridBoundColumn UniqueName="FK_KHACHHANG" HeaderText="Mã khách hàng" DataField="FK_KHACHHANG"
                HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_TENKH" HeaderText="Tên khách hàng" DataField="C_TENKH"
                HeaderStyle-Width="110px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_SDT" HeaderText="Số điện thoại" DataField="C_SDT" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="NGUOIGIAIQUYETNAME" HeaderText="Người giải quyết" DataField="NGUOIGIAIQUYETNAME" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_STATUS" HeaderText="Tình trạng" DataField="C_STATUS" HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center" 
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>            
        </Columns>
        <EditFormSettings InsertCaption="Thêm khiếu nại mới" CaptionFormatString="Sửa khiếu nại: <b>{0}</b>" CaptionDataField="C_CODE" EditFormType="Template" PopUpSettings-Width="900px">
            <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
            <FormTemplate>
                <div class="headerthongtin">
                    <ul>
                        <li class="lifirst">
                            <asp:LinkButton ID="btnSave" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'><img src="Images/img_save.jpg" /><%# (Container is GridEditFormInsertItem) ? "Lưu" : "Lưu" %></asp:LinkButton></li>
                        <li>
                            <asp:LinkButton ID="btnClose" runat="server" CommandName="Cancel"><img src="Images/img_Close.jpg" />Đóng</asp:LinkButton></li>
                    </ul>
                </div>
                <div class="clearfix bgpopup">
                    <div style="width: 900px; height: 250px; background: #FFFFFF" class="clearfix">
                        <table id="tblEdit" class="TableEditInGrid" cellspacing="3" cellpadding="3" style="width: 100%" border="0">
                            <tr>
                                <td style="width: 100px;">
                                    <span class="rtsTxtnew">Mã khiếu nại:</span>
                                </td>
                                <td colspan="4">
                                    <asp:HiddenField ID="txtID" Value='<%# Eval("PK_ID") %>' runat="server" />
                                    <telerik:RadTextBox ID="txtC_CODE" Width="80%" Text='<%# Bind("C_CODE") %>' runat="server" MaxLength="7">
                                        <ClientEvents OnKeyPress="OnKeyPressRadTextBox" />
                                    </telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="rfvtxtC_CODE" runat="server" ErrorMessage="Mã khiếu nại không thể rỗng"
                                        ControlToValidate="txtC_CODE" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="cfvtxtC_CODE" ControlToValidate="txtC_CODE" OnServerValidate="CheckMaKN"
                                        runat="server" ErrorMessage="Mã khiếu nại đã tồn tại" Display="Dynamic" ValidationGroup="G1"></asp:CustomValidator>
                                </td>
                                 <td style="width: 100px;">
                                    <span class="rtsTxtnew">Ngày tiếp nhận:
                                </td>
                                <td colspan="4">
                                    <telerik:RadDateTimePicker ID="radC_DATE" Width="95%" DbSelectedDate='<%# Bind("C_DATE") %>'
                                        runat="server" AutoPostBack="false">
                                        <DateInput ID="DateInput1" runat="server" DateFormat="dd/MM/yyyy HH:mm" MinDate="1/1/1890 00:00">
                                            <ClientEvents OnKeyPress="controlkeypress" />
                                        </DateInput>
                                    </telerik:RadDateTimePicker>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 150px;"><span class="rtsTxtnew">Loại:</td>
                                <td colspan="4">
                                   <telerik:RadComboBox ID="cmbC_TYPE" SelectedValue='<%# Bind("C_TYPE") %>'
                                        runat="server" EmptyMessage="Chọn" OnClientSelectedIndexChanged="cmbC_TYPEClientSelectedIndexChangedHandler" OnClientLoad="OnClientLoadcmbC_TYPE">
                                        <Items>
                                            <telerik:RadComboBoxItem Value="Bill" Text="Bill" />
                                            <telerik:RadComboBoxItem Value="Khác" Text="Khác" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                                <td style="width: 150px;"><span class="rtsTxtnew">Số Bill/Chủ đề:</td>
                                <td colspan="4">
                                    <telerik:RadTextBox ID="txtC_BILL" Text='<%# Bind( "C_BILL") %>' runat="server" Width="90%" ClientEvents-OnValueChanged="OnValueChangedtxtC_BILL" ClientEvents-OnLoad="OnClientLoadtxtC_BILL"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100px;">
                                    <span class="rtsTxtnew">Mã khách hàng:</span>
                                </td>
                                <td colspan="4">
                                    <telerik:RadComboBox ID="cmbMaKhachHang" runat="server" OnClientLoad="OnClientLoadcmbMaKhachHang"
                                        DataTextField="C_CODE" DataValueField="C_CODE" DataSourceID="KHACHHANGDataSource"
                                        SelectedValue='<%# Bind("FK_KHACHHANG") %>' ShowToggleImage="True" EmptyMessage="Chọn mã"
                                        OnClientSelectedIndexChanged="cmbMaKhachHangClientSelectedIndexChangedHandler"
                                        AllowCustomText="True" Filter="Contains">
                                    </telerik:RadComboBox>
                                </td>
                                <td style="width: 100px;">
                                    <span class="rtsTxtnew">Tên khách hàng:</span>
                                </td>
                                <td colspan="4">
                                    <telerik:RadTextBox ID="txtC_TENKH" Width="90%" Text='<%# Bind("C_TENKH") %>' ClientEvents-OnLoad="OnClientLoadtxtC_TENKH"
                                        runat="server">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width: 100px;">
                                    <span class="rtsTxtnew">Số điện thoại:</span>
                                </td>
                                <td colspan="4">
                                    <telerik:RadTextBox ID="txtC_SDT" Width="90%" Text='<%# Bind("C_SDT") %>' ClientEvents-OnLoad="OnClientLoadtxtC_SDT"
                                        runat="server">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 150px;"><span class="rtsTxtnew">Nội dung:</td>
                                <td colspan="12">
                                    <telerik:RadTextBox ID="txtC_NOIDUNG" Text='<%# Bind( "C_NOIDUNG") %>' runat="server" Width="90%" TextMode="MultiLine"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 150px;"><span class="rtsTxtnew">Người giải quyết:</td>
                                <td colspan="4">
                                    <telerik:RadComboBox ID="cmbFK_NGUOIGIAIQUYET" runat="server" SelectedValue='<%# Bind("FK_NGUOIGIAIQUYET") %>'
                                        DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="UserDataSource" ShowToggleImage="True"
                                        EmptyMessage="Chọn" AllowCustomText="True" Filter="Contains">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                             <tr>
                                <td style="width: 150px;"><span class="rtsTxtnew">Thông tin:</td>
                                <td colspan="12">
                                    <telerik:RadTextBox ID="txtC_THONGTIN" Text='<%# Bind( "C_THONGTIN") %>' runat="server" Width="90%" TextMode="MultiLine"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 150px;"><span class="rtsTxtnew">Trạng thái:</td>
                                <td colspan="4">
                                    <telerik:RadComboBox ID="cmbC_STATUS" SelectedValue='<%# Bind("C_STATUS") %>'
                                        runat="server" EmptyMessage="Chọn">
                                        <Items>                                           
                                            <telerik:RadComboBoxItem Value="Đang khiếu nại" Text="Đang khiếu nại" />
                                             <telerik:RadComboBoxItem Value="Đóng" Text="Đóng" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                    </center> 
        <!-- end bgpopup-->
                </div>
            </FormTemplate>
        </EditFormSettings>
    </MasterTableView>
    <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G1" />
    <ClientSettings AllowKeyboardNavigation="true" KeyboardNavigationSettings-AllowSubmitOnEnter="true" ClientEvents-OnKeyPress="KeyPressed">
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
        <ClientEvents OnPopUpShowing="PopUpShowing" />
        <ClientEvents OnRowDblClick="RowDblClick" />
        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="True" FrozenColumnsCount="5" ScrollHeight="450px" />
    </ClientSettings>
    <SortingSettings SortedAscToolTip="Sắp xếp tăng dần"
        SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
    <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<asp:SqlDataSource ID="KHIEUNAIDataSource" runat="server"
    ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    DeleteCommand="DELETE FROM [KHIEUNAI] WHERE [PK_ID] = @PK_ID"
    InsertCommand="INSERT INTO [KHIEUNAI] ([C_CODE], [C_TYPE], [C_DATE], [C_BILL], [FK_KHACHHANG], [C_TENKH], [C_SDT], [C_NOIDUNG], [FK_NGUOIGIAIQUYET], [C_THONGTIN], [C_STATUS]) VALUES (@C_CODE, @C_TYPE, @C_DATE, @C_BILL, @FK_KHACHHANG, @C_TENKH, @C_SDT, @C_NOIDUNG, @FK_NGUOIGIAIQUYET, @C_THONGTIN, @C_STATUS)"
    SelectCommand="SELECT [KHIEUNAI].[PK_ID], [KHIEUNAI].[C_CODE], [KHIEUNAI].[C_TYPE], [KHIEUNAI].[C_DATE], [KHIEUNAI].[C_BILL], [KHIEUNAI].[FK_KHACHHANG], [KHIEUNAI].[C_TENKH], [KHIEUNAI].[C_SDT], [KHIEUNAI].[C_NOIDUNG], [KHIEUNAI].[FK_NGUOIGIAIQUYET], [KHIEUNAI].[C_THONGTIN], [KHIEUNAI].[C_STATUS], USERS.C_NAME as NGUOIGIAIQUYENAME FROM [KHIEUNAI] LEFT OUTER JOIN USERS ON KHIEUNAI.FK_NGUOIGIAIQUYET =USERS.PK_ID"
    UpdateCommand="UPDATE [KHIEUNAI] SET [C_CODE] = @C_CODE, [C_TYPE] = @C_TYPE, [C_DATE] = @C_DATE, [C_BILL] = @C_BILL, [FK_KHACHHANG] = @FK_KHACHHANG, [C_TENKH] = @C_TENKH, [C_SDT] = @C_SDT, [C_NOIDUNG] = @C_NOIDUNG, [FK_NGUOIGIAIQUYET] = @FK_NGUOIGIAIQUYET, [C_THONGTIN] = @C_THONGTIN, [C_STATUS] = @C_STATUS WHERE [PK_ID] = @PK_ID">
    <SelectParameters>
        <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="C_CODE" Type="String" />
        <asp:Parameter Name="C_TYPE" Type="String" />
        <asp:Parameter Name="C_DATE" Type="DateTime"/>
        <asp:Parameter Name="C_BILL" Type="String" />
        <asp:Parameter Name="FK_KHACHHANG" Type="Int32" />
        <asp:Parameter Name="C_TENKH" Type="String" />
        <asp:Parameter Name="C_SDT" Type="String" />
        <asp:Parameter Name="C_NOIDUNG" Type="String" />
        <asp:Parameter Name="FK_NGUOIGIAIQUYET" Type="Int32" />
        <asp:Parameter Name="C_THONGTIN" Type="String" />
        <asp:Parameter Name="C_STATUS" Type="String" />
        <asp:Parameter Name="PK_ID" Type="Int32" />
    </UpdateParameters>
    <DeleteParameters>
        <asp:Parameter Name="PK_ID" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
       <asp:Parameter Name="C_CODE" Type="String" />
        <asp:Parameter Name="C_TYPE" Type="String" />
        <asp:Parameter Name="C_DATE" Type="DateTime"/>
        <asp:Parameter Name="C_BILL" Type="String" />
        <asp:Parameter Name="FK_KHACHHANG" Type="Int32" />
        <asp:Parameter Name="C_TENKH" Type="String" />
        <asp:Parameter Name="C_SDT" Type="String" />
        <asp:Parameter Name="C_NOIDUNG" Type="String" />
        <asp:Parameter Name="FK_NGUOIGIAIQUYET" Type="Int32" />
        <asp:Parameter Name="C_THONGTIN" Type="String" />
        <asp:Parameter Name="C_STATUS" Type="String" />
    </InsertParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="UserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT USERS.PK_ID,USERS.FK_GroupUser,USERS.FK_DEPT,USERS.C_LoginName,USERS.C_Password,USERS.C_NAME,USERS.C_Address,USERS.c_Tel,USERS.C_Email,USERS.C_DESC,GROUPUSER.C_NAME AS GROUPUSERNAME FROM USERS INNER JOIN GROUPUSER ON  USERS.FK_GROUPUSER = GROUPUSER.PK_ID WHERE FK_GROUPUSER NOT IN (0,1) AND (FK_VUNGLAMVIEC = N'Tất cả' OR FK_VUNGLAMVIEC = @FK_VUNGLAMVIEC)">
    <SelectParameters>
        <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="KHACHHANGDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT DMKHACHHANG.* FROM DMKHACHHANG LEFT OUTER JOIN DMNHOMKHACHHANG ON DMKHACHHANG.FK_NHOMKHACHHANG = DMNHOMKHACHHANG.PK_ID WHERE DMNHOMKHACHHANG.FK_VUNGLAMVIEC = @FK_VUNGLAMVIEC">
    <SelectParameters>
        <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
    </SelectParameters>
</asp:SqlDataSource>

