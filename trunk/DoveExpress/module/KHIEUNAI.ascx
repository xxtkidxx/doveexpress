<%@ Control Language="C#" AutoEventWireup="true" CodeFile="KHIEUNAI.ascx.cs" Inherits="module_KHIEUNAI" %>
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript">
        function OnKeyPressRadTextBox(sender, eventArgs) {
            var charCode = eventArgs.get_keyCode();
            if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
                eventArgs.set_cancel(true);
            }
            return false;
        }
        var PK_ID, currentkhieunai;
        var khieunai =
        {
            PK_ID: null,
            C_CODE: null,
            C_TYPE: null,
            C_DATE: null,
            C_BILL: null,
            FK_KHACHHANG: null,
            C_TENKH: null,
            C_SDT: null,
            C_NOIDUNG: null,
            FK_NGUOITAO: null,
            C_STATUS: null,
            create: function () {
                var obj = new Object();

                obj.PK_ID = "0";
                obj.C_CODE = "<%=GetMaxKN()%>";
                obj.C_TYPE = "Khác";
                obj.C_DATE = new Date();
                obj.C_BILL = "";
                obj.FK_KHACHHANG = "";
                obj.C_TENKH = "";
                obj.C_SDT = "";
                obj.C_NOIDUNG = "";
                obj.FK_NGUOITAO = "<%=Session["UserID"].ToString()%>";
                obj.C_STATUS = "Đang xử lý";
                return obj;
            }
        };

        function pageLoad(sender, args) {
            PK_ID = $find("<%= RadGridKHIEUNAI.ClientID %>").get_masterTableView().get_dataItems()[0].getDataKeyValue("PK_ID");
            $find("<%= txtC_CODE.ClientID %>").focus();
        }

        function rowSelected(sender, args) {
            PK_ID = args.getDataKeyValue("PK_ID");
            $find("<%= RadTabStripKHIEUNAI.ClientID %>").set_selectedIndex(0);
            MyWebService.GetKHIEUNAIByPK_ID(PK_ID, setValues);
        }

        function setValues(khieunai) {
            checkAjax = false;
            $get("<%= txtID.ClientID %>").value = khieunai.PK_ID;
            $find("<%= txtC_CODE.ClientID %>").set_value(khieunai.C_CODE);
            $find("<%= radC_DATE.ClientID %>").set_selectedDate(khieunai.C_DATE);
            $find("<%= cmbC_TYPE.ClientID %>").findItemByText(khieunai.C_TYPE).select();
            $find("<%= txtC_BILL.ClientID %>").set_value(khieunai.C_BILL);
            $find("<%= txtC_TENKH.ClientID %>").set_value(khieunai.C_TENKH);
            $find("<%= txtC_SDT.ClientID %>").set_value(khieunai.C_SDT);
            $find("<%= txtC_NOIDUNG.ClientID %>").set_value(khieunai.C_NOIDUNG);
            $find("<%= cmbC_STATUS.ClientID %>").findItemByText(khieunai.C_STATUS).select();
            $find("<%= txtC_CODE.ClientID %>").focus();
            if ($find("<%= cmbMaKhachHang.ClientID %>").findItemByText(khieunai.FK_KHACHHANG) != null) {
                $find("<%= cmbMaKhachHang.ClientID %>").findItemByText(khieunai.FK_KHACHHANG).select();
            } else {
                $find("<%= cmbMaKhachHang.ClientID %>").set_text("");
            }
            if ($find("<%= cmbFK_NGUOITAO.ClientID %>").findItemByValue(khieunai.FK_NGUOITAO) != null) {
                $find("<%= cmbFK_NGUOITAO.ClientID %>").findItemByValue(khieunai.FK_NGUOITAO).select();
            } else {
                $find("<%= cmbFK_NGUOITAO.ClientID %>").set_text("");
            }
            checkAjax = true;
            if (checkEdit) {
                $find("<%= RadListViewKHIEUNAIGIAIQUYET.ClientID %>").rebind();
            }
        }

        function getValues() {
            khieunai.PK_ID = $get("<%= txtID.ClientID %>").value;
            khieunai.C_CODE = $find("<%= txtC_CODE.ClientID %>").get_value();
            khieunai.C_DATE = $find("<%= radC_DATE.ClientID %>").get_selectedDate();
            khieunai.C_TYPE = $find("<%= cmbC_TYPE.ClientID %>").get_value();
            khieunai.C_BILL = $find("<%= txtC_BILL.ClientID %>").get_value();
            khieunai.C_TENKH = $find("<%= txtC_TENKH.ClientID %>").get_value();
            khieunai.C_SDT = $find("<%= txtC_SDT.ClientID %>").get_value();
            khieunai.C_NOIDUNG = $find("<%= txtC_NOIDUNG.ClientID %>").get_value();
            khieunai.C_STATUS = $find("<%= cmbC_STATUS.ClientID %>").get_value();
            khieunai.FK_KHACHHANG = $find("<%= cmbMaKhachHang.ClientID %>").get_value();
            khieunai.FK_NGUOITAO = $find("<%= cmbFK_NGUOITAO.ClientID %>").get_value();
            return khieunai;
        }

        function updateChanges() {
            MyWebService.UpdateKHIEUNAIByKHIEUNAI(getValues(), updateGrid);
        }

        function updateGrid(result) {
            $find("<%= RadGridKHIEUNAI.ClientID %>").get_masterTableView().set_dataSource(result);
            $find("<%= RadGridKHIEUNAI.ClientID %>").get_masterTableView().rebind();
        }
        checkAjax = true;
        checkEdit = true;
        function tabSelected(sender, args) {
            /*if (currentkhieunai == null) {
                currentkhieunai = getValues();
            }*/
            var elem = document.getElementById('divRadListView');
            switch (args.get_tab().get_index()) {
                case 1:
                    {
                        checkEdit = false;
                        $(elem).hide();
                        var newkhieunai = khieunai.create();
                        setValues(newkhieunai);
                        $get("<%= btnSave.ClientID %>").value = "Thêm";
                            $get("<%= btnDelete.ClientID %>").parentNode.style.display = "none";
                        break;
                    }
                default:
                    {
                        checkEdit = true;
                        $find("<%= RadGridKHIEUNAI.ClientID %>").get_masterTableView().selectItem(0);
                        $get("<%= btnSave.ClientID %>").value = "Lưu";
                            $get("<%= btnDelete.ClientID %>").parentNode.style.display = "";
                            break;
                        }
                }
            }

            function deleteCurrent() {
                MyWebService.DeleteKHIEUNAIByPK_ID(PK_ID, updateGrid);
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
            if (checkAjax && eventArgs.get_item().get_value() == 'Bill') {
                checkKH = !checkKH;
                $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("cmbC_TYPE;" + txtC_BILL.get_value());
                var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelKHIEUNAI.ClientID %>");
                var currentUpdatedControl = "<%= RadSplitterKHIEUNAI.ClientID %>";
                currentLoadingPanel.show(currentUpdatedControl);
            }
            return false;
        }
        function cmbMaKhachHangClientSelectedIndexChangedHandler(sender, eventArgs) {
            if (checkAjax && checkKH) {
                $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("cmbMaKhachHang;" + eventArgs.get_item().get_value());
                var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelKHIEUNAI.ClientID %>");
                var currentUpdatedControl = "<%= RadSplitterKHIEUNAI.ClientID %>";
                currentLoadingPanel.show(currentUpdatedControl);
            }
            return false;
        }
        function OnValueChangedtxtC_BILL(sender, eventArgs) {
            if (checkAjax && cmbC_TYPE.get_selectedItem().get_value() == 'Bill') {
                checkKH = !checkKH;
                $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("txtC_BILL;" + eventArgs.get_newValue());
                var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelKHIEUNAI.ClientID %>");
                var currentUpdatedControl = "<%= RadSplitterKHIEUNAI.ClientID %>";
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
                    }
                    else {
                    }
                    checkKH = true;
                }
                var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelKHIEUNAI.ClientID %>");
                var currentUpdatedControl = "<%= RadSplitterKHIEUNAI.ClientID %>";
                currentLoadingPanel.hide(currentUpdatedControl);
                result = "";
            }
            return false;
        }
    </script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelKHIEUNAI" runat="server" />
<telerik:RadSplitter ID="RadSplitterKHIEUNAI" runat="server" Width="100%" Height="600px">
    <telerik:RadPane ID="LeftPaneKHIEUNAI" runat="server" Width="32%">
        <telerik:RadGrid ID="RadGridKHIEUNAI" DataSourceID="KHIEUNAIDataSource" runat="server" OnItemCommand="RadGridKHIEUNAI_ItemCommand"
            Skin="Vista" AllowPaging="True" PageSize="20" AllowSorting="True" AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="True"
            AutoGenerateColumns="False" OnDataBound="RadGridKHIEUNAI_DataBound" OnColumnCreated="RadGridKHIEUNAI_ColumnCreated" Height="590px">
            <MasterTableView Name="MasterTableViewKHIEUNAI" CommandItemDisplay="Top" DataSourceID="KHIEUNAIDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
                <CommandItemTemplate>
                    <div style="padding: 5px 5px; float: left; width: auto">
                        <b>Quản lý khiếu nại</b>&nbsp;&nbsp;&nbsp;&nbsp;
                     <asp:LinkButton ID="LinkButton11" runat="server" CommandName="ClearFilterGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/filterCancel.gif" />Xóa tìm kiếm</asp:LinkButton>&nbsp;&nbsp;
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
                    <telerik:GridBoundColumn UniqueName="C_CODE" HeaderText="Mã KN" DataField="C_CODE" HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="C_TYPE" HeaderText="Loại khiếu nại" DataField="C_TYPE" HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center"
                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" Visible="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="C_DATE" HeaderText="Thời gian" DataField="C_DATE"
                        HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                        ShowFilterIcon="true" FilterControlWidth="70%" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy HH:mm}" Visible="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="C_BILL" HeaderText="Chủ đề" DataField="C_BILL" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="FK_KHACHHANG" HeaderText="Mã khách hàng" DataField="FK_KHACHHANG"
                        HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                        CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" Visible="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="C_TENKH" HeaderText="Tên khách hàng" DataField="C_TENKH"
                        HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                        CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="C_SDT" HeaderText="Số điện thoại" DataField="C_SDT" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center"
                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="C_NOIDUNG" HeaderText="Nội dung" DataField="C_NOIDUNG" HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center"
                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" Visible="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="FK_NGUOITAO" HeaderText="Người tạo fix" DataField="FK_NGUOITAO" HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center"
                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" Visible="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="NGUOITAONAME" HeaderText="Người tạo" DataField="NGUOITAONAME" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" Visible="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="C_STATUS" HeaderText="Tình trạng" DataField="C_STATUS" HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center"
                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <ClientSettings>
                <Selecting AllowRowSelect="true"></Selecting>
                <ClientEvents OnRowSelected="rowSelected"></ClientEvents>
                <Scrolling AllowScroll="true" UseStaticHeaders="true"></Scrolling>
            </ClientSettings>
        </telerik:RadGrid>
    </telerik:RadPane>
    <telerik:RadSplitBar ID="RadSplitBarKHIEUNAI" runat="server" CollapseMode="Forward" />
    <telerik:RadPane ID="MiddlePaneKHIEUNAI" runat="server" Width="67%">
        <telerik:RadTabStrip ID="RadTabStripKHIEUNAI" OnClientTabSelected="tabSelected" Style="margin-top: 10px;"
            SelectedIndex="0" runat="server">
            <Tabs>
                <telerik:RadTab Text="Sửa khiếu nại">
                </telerik:RadTab>
                <telerik:RadTab Text="Thêm khiếu nại">
                </telerik:RadTab>
            </Tabs>
        </telerik:RadTabStrip>
        <div class="headerthongtin">
            <ul>
                <li class="lifirst">
                    <asp:LinkButton ID="btnSave" runat="server" OnClientClick="updateChanges(); return false;"><img src="Images/img_save.jpg" />Lưu</asp:LinkButton></li>
                <li>
                    <asp:LinkButton ID="btnDelete" runat="server" OnClientClick="if(!confirm('Bạn chắc chắn muốn xóa khiếu nại?'))return false; deleteCurrent(); return false;"><img src="Images/img_Close.jpg" />Xóa</asp:LinkButton></li>
            </ul>
        </div>
        <div style="width: 100%; height: 250px; background: #FFFFFF" class="clearfix">
            <table id="tblEdit" class="TableEditInGrid" cellspacing="3" cellpadding="3" style="width: 100%" border="0">
                <tr>
                    <td style="width: 100px;">
                        <span class="rtsTxtnew">Mã khiếu nại:</span>
                    </td>
                    <td colspan="4">
                        <asp:HiddenField ID="txtID" Value='<%# Eval("PK_ID") %>' runat="server" />
                        <telerik:RadTextBox ID="txtC_CODE" Width="80%" runat="server" MaxLength="7">
                            <ClientEvents OnKeyPress="OnKeyPressRadTextBox" />
                        </telerik:RadTextBox>

                    </td>
                    <td style="width: 100px;">
                        <span class="rtsTxtnew">Ngày tiếp nhận:</span>
                    </td>
                    <td colspan="4">
                        <telerik:RadDateTimePicker ID="radC_DATE" Width="95%"
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
                        <telerik:RadComboBox ID="cmbC_TYPE"
                            runat="server" EmptyMessage="Chọn" OnClientSelectedIndexChanged="cmbC_TYPEClientSelectedIndexChangedHandler" OnClientLoad="OnClientLoadcmbC_TYPE">
                            <Items>
                                <telerik:RadComboBoxItem Value="Bill" Text="Bill" />
                                <telerik:RadComboBoxItem Value="Khác" Text="Khác" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 150px;"><span class="rtsTxtnew">Số Bill/Chủ đề:</td>
                    <td colspan="4">
                        <telerik:RadTextBox ID="txtC_BILL" runat="server" Width="90%" ClientEvents-OnValueChanged="OnValueChangedtxtC_BILL" ClientEvents-OnLoad="OnClientLoadtxtC_BILL"></telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px;">
                        <span class="rtsTxtnew">Mã khách hàng:</span>
                    </td>
                    <td colspan="4">
                        <telerik:RadComboBox ID="cmbMaKhachHang" runat="server" OnClientLoad="OnClientLoadcmbMaKhachHang"
                            DataTextField="C_CODE" DataValueField="C_CODE" DataSourceID="KHACHHANGDataSource"
                            ShowToggleImage="True" EmptyMessage="Chọn mã"
                            OnClientSelectedIndexChanged="cmbMaKhachHangClientSelectedIndexChangedHandler"
                            AllowCustomText="True" Filter="Contains">
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 100px;">
                        <span class="rtsTxtnew">Tên khách hàng:</span>
                    </td>
                    <td colspan="4">
                        <telerik:RadTextBox ID="txtC_TENKH" Width="90%" runat="server" ClientEvents-OnLoad="OnClientLoadtxtC_TENKH">
                        </telerik:RadTextBox>
                    </td>
                    <td style="width: 100px;">
                        <span class="rtsTxtnew">Số điện thoại:</span>
                    </td>
                    <td colspan="4">
                        <telerik:RadTextBox ID="txtC_SDT" Width="90%" ClientEvents-OnLoad="OnClientLoadtxtC_SDT" runat="server">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px;"><span class="rtsTxtnew">Nội dung:</td>
                    <td colspan="12">
                        <telerik:RadTextBox ID="txtC_NOIDUNG" runat="server" Width="90%" TextMode="MultiLine"></telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px;"><span class="rtsTxtnew">Người tạo:</td>
                    <td colspan="4">
                        <telerik:RadComboBox ID="cmbFK_NGUOITAO" runat="server"
                            DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="UserDataSource" ShowToggleImage="True"
                            EmptyMessage="Chọn" AllowCustomText="True" Filter="Contains">
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px;"><span class="rtsTxtnew">Trạng thái:</td>
                    <td colspan="4">
                        <telerik:RadComboBox ID="cmbC_STATUS"
                            runat="server" EmptyMessage="Chọn">
                            <Items>
                                <telerik:RadComboBoxItem Value="Đang xử lý" Text="Đang xử lý" />
                                <telerik:RadComboBoxItem Value="Đóng" Text="Đóng" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
            </table>
            <div id="divRadListView">
                <telerik:RadListView Skin="Vista" ID="RadListViewKHIEUNAIGIAIQUYET" DataSourceID="SqlDataSourceKHIEUNAIGIAIQUYET" OnItemCreated="RadListViewKHIEUNAIGIAIQUYET_ItemCreated"
                    runat="server" ItemPlaceholderID="KHIEUNAIGIAIQUYETContainer" OnItemCommand="RadListViewKHIEUNAIGIAIQUYET_ItemCommand"
                    DataKeyNames="PK_ID">
                    <LayoutTemplate>
                        <fieldset id="FieldSet1">
                            <legend></legend>
                            <asp:PlaceHolder ID="KHIEUNAIGIAIQUYETContainer" runat="server"></asp:PlaceHolder>
                            <br />
                            <asp:Button ID="btnInitInsert" runat="server" Text="Thêm tình trạng" Visible ='<%# (cmbC_STATUS.SelectedIndex == 0) %>' OnClick="btnInitInsert_Click"></asp:Button>
                        </fieldset>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <fieldset>
                            <div class="headerthongtin">
                                <ul>
                                    <li class="lifirst">
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit"><img src="Images/img_save.jpg" />Sửa</asp:LinkButton></li>
                                    <li>
                                        <asp:LinkButton ID="btnDelete" runat="server" OnClientClick="javascript:return confirm('Bạn có muốn xóa bản ghi đã chọn không?')" CommandName="Delete" CommandArgument='<%#Eval("PK_ID") %>'><img src="Images/img_Close.jpg" />Xóa</asp:LinkButton></li>
                                </ul>
                            </div>
                            <div style="width: 100%; height: 60px; background: #FFFFFF" class="clearfix">
                                <table id="tblEdit" class="TableEditInGrid" cellspacing="3" cellpadding="3" style="width: 100%" border="0">
                                    <tr>
                                        <td style="width: 100px;">
                                            <span class="rtsTxtnew">Người giải quyết:</span></br>
                                        <telerik:RadComboBox ID="cmbFK_NGUOIGIAIQUYET" runat="server" SelectedValue='<%# Bind("FK_NGUOIGIAIQUYET") %>' Enabled="false"
                                            DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="UserDataSource" ShowToggleImage="True"
                                            EmptyMessage="Chọn" AllowCustomText="True" Filter="Contains">
                                        </telerik:RadComboBox>
                                        </td>
                                        <td colspan="12">
                                            <telerik:RadTextBox ID="txtC_NOIDUNGGIAIQUYET" runat="server" Width="90%" TextMode="MultiLine" Text='<%# Bind("C_NOIDUNG") %>' Enabled="false"></telerik:RadTextBox>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </fieldset>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <fieldset>
                            <div class="headerthongtin">
                                <ul>
                                    <li class="lifirst">
                                        <asp:LinkButton ID="btnSave" runat="server" CommandName="Update"><img src="Images/img_save.jpg" />Lưu</asp:LinkButton></li>
                                    <li>
                                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel"><img src="Images/img_Close.jpg" />Hủy</asp:LinkButton></li>
                                </ul>
                            </div>
                            <div style="width: 100%; height: 60px; background: #FFFFFF" class="clearfix">
                                <table id="tblEdit" class="TableEditInGrid" cellspacing="3" cellpadding="3" style="width: 100%" border="0">
                                    <tr>
                                        <td style="width: 100px;">
                                            <span class="rtsTxtnew">Người giải quyết:</span></br>
                                        <telerik:RadComboBox ID="cmbFK_NGUOIGIAIQUYET" runat="server" SelectedValue='<%# Bind("FK_NGUOIGIAIQUYET") %>'
                                            DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="UserDataSource" ShowToggleImage="True"
                                            EmptyMessage="Chọn" AllowCustomText="True" Filter="Contains">
                                        </telerik:RadComboBox>
                                        </td>
                                        <td colspan="12">
                                            <telerik:RadTextBox ID="txtC_NOIDUNGGIAIQUYET" runat="server" Text='<%# Bind("C_NOIDUNG") %>' Width="90%" TextMode="MultiLine"></telerik:RadTextBox>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </fieldset>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <fieldset>
                            <div class="headerthongtin">
                                <ul>
                                    <li class="lifirst">
                                        <asp:LinkButton ID="btnSave" runat="server" CommandName="PerformInsert"><img src="Images/img_save.jpg" />Lưu</asp:LinkButton></li>
                                    <li>
                                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel"><img src="Images/img_Close.jpg" />Hủy</asp:LinkButton></li>
                                </ul>
                            </div>
                            <div style="width: 100%; height: 60px; background: #FFFFFF" class="clearfix">
                                <table id="tblEdit" class="TableEditInGrid" cellspacing="3" cellpadding="3" style="width: 100%" border="0">
                                    <tr>
                                        <td style="width: 100px;">
                                            <span class="rtsTxtnew">Người giải quyết:</span></br>
                                        <telerik:RadComboBox ID="cmbFK_NGUOIGIAIQUYET" runat="server" SelectedValue='<%# Bind("FK_NGUOIGIAIQUYET") %>'
                                            DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="UserDataSource" ShowToggleImage="True"
                                            EmptyMessage="Chọn" AllowCustomText="True" Filter="Contains">
                                        </telerik:RadComboBox>
                                        </td>
                                        <td colspan="12">
                                            <telerik:RadTextBox ID="txtC_NOIDUNGGIAIQUYET" runat="server" Text='<%# Bind("C_NOIDUNG") %>' Width="90%" TextMode="MultiLine"></telerik:RadTextBox>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </fieldset>
                    </InsertItemTemplate>
                </telerik:RadListView>
            </div>
        </div>
        <!-- end bgpopup-->
    </telerik:RadPane>
</telerik:RadSplitter>
<asp:SqlDataSource ID="KHIEUNAIDataSource" runat="server"
    ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    DeleteCommand="DELETE FROM [KHIEUNAI] WHERE [PK_ID] = @PK_ID"
    InsertCommand="INSERT INTO [KHIEUNAI] ([C_CODE], [C_TYPE], [C_DATE], [C_BILL], [FK_KHACHHANG], [C_TENKH], [C_SDT], [C_NOIDUNG], [FK_NGUOITAO], [C_STATUS]) VALUES (@C_CODE, @C_TYPE, @C_DATE, @C_BILL, @FK_KHACHHANG, @C_TENKH, @C_SDT, @C_NOIDUNG, @FK_NGUOITAO, @C_STATUS)"
    SelectCommand="SELECT [KHIEUNAI].[PK_ID], [KHIEUNAI].[C_CODE], [KHIEUNAI].[C_TYPE], [KHIEUNAI].[C_DATE], [KHIEUNAI].[C_BILL], [KHIEUNAI].[FK_KHACHHANG], [KHIEUNAI].[C_TENKH], [KHIEUNAI].[C_SDT], [KHIEUNAI].[C_NOIDUNG], [KHIEUNAI].[FK_NGUOITAO], [KHIEUNAI].[C_STATUS], USERS.C_NAME as NGUOITAONAME FROM [KHIEUNAI] LEFT OUTER JOIN USERS ON KHIEUNAI.FK_NGUOITAO =USERS.PK_ID ORDER BY C_STATUS ASC, C_DATE DESC"
    UpdateCommand="UPDATE [KHIEUNAI] SET [C_CODE] = @C_CODE, [C_TYPE] = @C_TYPE, [C_DATE] = @C_DATE, [C_BILL] = @C_BILL, [FK_KHACHHANG] = @FK_KHACHHANG, [C_TENKH] = @C_TENKH, [C_SDT] = @C_SDT, [C_NOIDUNG] = @C_NOIDUNG, [FK_NGUOITAO] = @FK_NGUOITAO, [C_STATUS] = @C_STATUS WHERE [PK_ID] = @PK_ID">
    <SelectParameters>
        <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="C_CODE" Type="String" />
        <asp:Parameter Name="C_TYPE" Type="String" />
        <asp:Parameter Name="C_DATE" Type="DateTime" />
        <asp:Parameter Name="C_BILL" Type="String" />
        <asp:Parameter Name="FK_KHACHHANG" Type="Int32" />
        <asp:Parameter Name="C_TENKH" Type="String" />
        <asp:Parameter Name="C_SDT" Type="String" />
        <asp:Parameter Name="C_NOIDUNG" Type="String" />
        <asp:Parameter Name="FK_NGUOITAO" Type="Int32" />
        <asp:Parameter Name="C_STATUS" Type="String" />
        <asp:Parameter Name="PK_ID" Type="Int32" />
    </UpdateParameters>
    <DeleteParameters>
        <asp:Parameter Name="PK_ID" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="C_CODE" Type="String" />
        <asp:Parameter Name="C_TYPE" Type="String" />
        <asp:Parameter Name="C_DATE" Type="DateTime" />
        <asp:Parameter Name="C_BILL" Type="String" />
        <asp:Parameter Name="FK_KHACHHANG" Type="Int32" />
        <asp:Parameter Name="C_TENKH" Type="String" />
        <asp:Parameter Name="C_SDT" Type="String" />
        <asp:Parameter Name="C_NOIDUNG" Type="String" />
        <asp:Parameter Name="FK_NGUOITAO" Type="Int32" />
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
<asp:SqlDataSource ID="SqlDataSourceKHIEUNAIGIAIQUYET" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    DeleteCommand="DELETE FROM [KHIEUNAIGIAIQUYET] WHERE [PK_ID] = @PK_ID"
    InsertCommand="INSERT INTO [KHIEUNAIGIAIQUYET] ([FK_KHIEUNAI], [FK_NGUOIGIAIQUYET], [C_NOIDUNG]) VALUES (@FK_KHIEUNAI, @FK_NGUOIGIAIQUYET, @C_NOIDUNG)"
    SelectCommand="SELECT [KHIEUNAIGIAIQUYET].[PK_ID], [KHIEUNAIGIAIQUYET].[FK_KHIEUNAI], [KHIEUNAIGIAIQUYET].[FK_NGUOIGIAIQUYET], [KHIEUNAIGIAIQUYET].[C_NOIDUNG] FROM [KHIEUNAIGIAIQUYET] WHERE FK_KHIEUNAI = @FK_KHIEUNAI"
    UpdateCommand="UPDATE [KHIEUNAIGIAIQUYET] SET [FK_NGUOIGIAIQUYET] = @FK_NGUOIGIAIQUYET, [C_NOIDUNG] = @C_NOIDUNG WHERE [PK_ID] = @PK_ID">
    <SelectParameters>
        <asp:ControlParameter Name="FK_KHIEUNAI" Type="Int32" ControlID="txtID" PropertyName="Value" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="FK_NGUOIGIAIQUYET" Type="Int32" />
        <asp:Parameter Name="C_NOIDUNG" Type="String" />
        <asp:Parameter Name="PK_ID" Type="Int32" />
    </UpdateParameters>
    <DeleteParameters>
        <asp:Parameter Name="PK_ID" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:ControlParameter Name="FK_KHIEUNAI" Type="Int32" ControlID="txtID" PropertyName="Value" />
        <asp:Parameter Name="FK_NGUOIGIAIQUYET" Type="Int32" />
        <asp:Parameter Name="C_NOIDUNG" Type="String" />
    </InsertParameters>
</asp:SqlDataSource>
<asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Visible="false" Text="Button" />
<asp:TextBox ID="TextBox1" runat="server" Visible="false"></asp:TextBox>

