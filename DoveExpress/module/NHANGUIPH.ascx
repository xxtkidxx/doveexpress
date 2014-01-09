<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NHANGUIPH.ascx.cs" Inherits="module_NHANGUIPH" %>
<%@ Register TagPrefix="uc1" Namespace="ITCLIB.Admin" %>
<telerik:RadCodeBlock ID="RadCodeBlockNHANGUIPH" runat="server">
    <script type="text/javascript">
    function RowDblClick(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("NHANGUIPH") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewNHANGUIPH") && (CanEdit == "True")) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
    }   
    </script>
    <script type="text/javascript">
        var registeredElementsNG = [];
        function GetRegisteredServerElementNG(serverID) {
            var clientID = "";
            for (var i = 0; i < registeredElementsNG.length; i++) {
                clientID = registeredElementsNG[i];
                if (clientID.indexOf(serverID) >= 0)
                    break;
            }
            return $get(clientID);
        }
        function GetGridServerElementNG(serverID, tagName) {
            if (!tagName)
                tagName = "*";

            var grid = $get("<%=RadGridNHANGUIPH.ClientID %>");
            var elements = grid.getElementsByTagName(tagName);
            for (var i = 0; i < elements.length; i++) {
                var element = elements[i];
                if (element.id.indexOf(serverID) >= 0)
                    return element;
            }
        }
        function cmbDoiTacClientSelectedIndexChangedHandler(sender, eventArgs) {
            $find("<%=RadGridNHANGUIPH.ClientID %>").get_masterTableView().rebind();
        }
    </script>
    <script type="text/javascript">
        function TrangthaiOnClientLinkClicked() {
            if ($find("<%= RadGridNHANGUIPH.MasterTableView.ClientID %>").get_selectedItems().length != 0) {
                var IDString = 'BILL';
                for (index = 0; index < $find("<%= RadGridNHANGUIPH.MasterTableView.ClientID %>").get_selectedItems().length; ++index) {
                    IDString += '-' + $find("<%= RadGridNHANGUIPH.MasterTableView.ClientID %>").get_selectedItems()[index].getDataKeyValue("C_BILL");
                }
                var oWindow = radopen("Popup.aspx?ctl=NHANGUIPOPUP&IDBILL=" + IDString, "Cập nhật trạng thái BILL");
            } else {
                alert("Không có phiếu nhận gửi được chọn");
            }
            return false;
        }
        function OnClientShowNHANGUIPH(sender, eventArgs) {

        }
        function OnClientCloseNHANGUIPH(sender, eventArgs) {
            //var TypeName = sender.get_name();
            $find("<%=RadGridNHANGUIPH.ClientID %>").get_masterTableView().rebind();
        }
        function OnClientLinkClicked(IDvalue) {
            var oWindow = radopen("Popup.aspx?ctl=NHANGUITRACKING&IDBILL=" + IDvalue, "Tracking");
            oWindow.setSize(800, 600);
            oWindow.set_top(0);
            return false;
        }
    </script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelNHANGUIPH" runat="server" />
<style type="text/css">
    table.gridtable
    {
        font-family: verdana,arial,sans-serif;
        font-size: 13px;
        color: #333333;
        border-width: 1px;
        border-color: #666666;
        border-collapse: collapse;
        width: 30%;
        margin: 5px 5px 5px 5px;
    }
    table.gridtable th
    {
        border-width: 1px;
        padding: 5px;
        font-weight: bold;
        border-style: solid;
        border-color: #666666;
        background-color: #dedede;
    }
    table.gridtable td
    {
        border-width: 1px;
        padding: 5px;
        border-style: solid;
        border-color: #666666;
        background-color: #ffffff;
    }
</style>
<table class="gridtable">
    <tr>
        <th>
            Đối tác
        </th>
    </tr>
    <tr>
        <td>
            <telerik:RadComboBox ID="cmbDoiTac" runat="server" Width="95%" DataTextField="C_NAME"
                DataValueField="PK_ID" DataSourceID="DoiTacDataSource" ShowToggleImage="True"
                AppendDataBoundItems="true" EmptyMessage="Chọn đối tác" OnClientSelectedIndexChanged="cmbDoiTacClientSelectedIndexChangedHandler"
                OnPreRender="cmbDoiTac_PreRender">
                <Items>
                    <telerik:RadComboBoxItem runat="server" Text="Tất cả" Value="-1" />
                </Items>
            </telerik:RadComboBox>
        </td>
    </tr>
</table>
<telerik:RadGrid ID="RadGridNHANGUIPH" runat="server" Skin="Vista" AllowPaging="True"
    PageSize="50" AllowSorting="True" AllowFilteringByColumn="True" GridLines="None"
    ShowStatusBar="True" AutoGenerateColumns="False" AllowMultiRowSelection="True"
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" AllowAutomaticInserts="True"
    AllowAutomaticUpdates="True" DataSourceID="NHANGUIPHDataSource" ShowFooter="True"
    OnDataBound="RadGridNHANGUIPH_DataBound" OnItemUpdated="RadGridNHANGUIPH_ItemUpdated"
    OnItemCommand="RadGridNHANGUIPH_ItemCommand" OnItemDataBound="RadGridNHANGUIPH_ItemDataBound"
    CellSpacing="0" OnItemCreated="RadGridNHANGUIPH_ItemCreated">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp"
        NextPageToolTip="Trang tiếp" PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau"
        PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />
    <GroupingSettings CaseSensitive="false" />
    <MasterTableView Name="MasterTableViewNHANGUIPH" CommandItemDisplay="Top" DataSourceID="NHANGUIPHDataSource"
        DataKeyNames="C_BILL" ClientDataKeyNames="C_BILL" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu"
        InsertItemPageIndexAction="ShowItemOnFirstPage">
        <CommandItemTemplate>
            <div style="padding: 5px 5px; float: left; width: auto">
                <b>Quản lý trạng thái Bill</b>&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridNHANGUIPH.EditIndexes.Count == 0 && ITCLIB.Security.Security.CanEditModule("NHANGUIPH") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa thông tin phát hàng</asp:LinkButton>&nbsp;&nbsp;
                <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridNHANGUIPH.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Update.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridNHANGUIPH.EditIndexes.Count > 0 || RadGridNHANGUIPH.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                <asp:LinkButton ID="btnTrangthai" runat="server" OnClientClick='<%# String.Format("javascript:return TrangthaiOnClientLinkClicked()")%>' Visible='<%# ITCLIB.Security.Security.CanEditModule("NHANGUIPH") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/img_OpenPanel.gif"/>Cập nhật trạng thái Bill hàng loạt</asp:LinkButton>&nbsp;&nbsp;
                <asp:LinkButton ID="LinkButton4" runat="server" CommandName="RebindGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Refresh.gif" />Làm mới</asp:LinkButton>
            </div>
        </CommandItemTemplate>
        <Columns>
            <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn" HeaderStyle-Width="40px"
                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
            </telerik:GridClientSelectColumn>
            <telerik:GridTemplateColumn HeaderText="" ShowFilterIcon="false">
                <FilterTemplate>
                    <center>
                        <asp:ImageButton ID="btnShowAll" runat="server" ImageUrl="../Images/Grid/filterCancel.gif"
                            AlternateText="Xem tất" ToolTip="Xem tất" OnClick="btnShowAll_Click" Style="vertical-align: middle" />
                    </center>
                </FilterTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblSTT" runat="server" Text=""></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Center" Width="30px" />
                <ItemStyle HorizontalAlign="Center" Width="30px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn UniqueName="Tracking" HeaderText="Thông tin Tracking"
                HeaderStyle-Width="110px" HeaderStyle-HorizontalAlign="Center" DataField="C_BILL"
                AllowFiltering="False">
                <ItemTemplate>
                    <asp:LinkButton ID="libTracking" OnClientClick='<%# String.Format("javascript:return OnClientLinkClicked({0})", Eval("C_BILL"))%>'
                        runat="server" Visible='<%# ITCLIB.Security.Security.CanEditModule("NHANGUIPH") %>'>Thông tin Tracking</asp:LinkButton>&nbsp;&nbsp;
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridBoundColumn UniqueName="C_NGAY" HeaderText="Ngày" DataField="C_NGAY"
                HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                ShowFilterIcon="false" FilterControlWidth="100%" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy}">
            </telerik:GridBoundColumn>
            <telerik:GridTemplateColumn UniqueName="C_BILL" HeaderText="Số Bill" DataField="C_BILL"
                HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%"
                SortExpression="C_BILL">
                <ItemTemplate>
                    <asp:Label ID="lblC_BILL" runat="server" Text='<%# String.Format("BC{0}", Eval("C_BILL").ToString())%>'></asp:Label>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridBoundColumn UniqueName="FK_KHACHHANG" HeaderText="Mã khách hàng" DataField="FK_KHACHHANG"
                HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_TENKH" HeaderText="Tên khách hàng" DataField="C_TENKH"
                HeaderStyle-Width="110px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_NOIDUNG" HeaderText="Nội dung" DataField="C_NOIDUNG"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_NGUOINHAN" HeaderText="Người nhận" DataField="C_NGUOINHAN"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_DIACHINHAN" HeaderText="Địa chỉ nhận" DataField="C_DIACHINHAN"
                HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="TRANGTHAINAME" HeaderText="Trạng thái cuối" DataField="TRANGTHAINAME"
                HeaderStyle-Width="110px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_NGAYGIOPHAT" HeaderText="Thời gian nhận" DataField="C_NGAYGIOPHAT"
                HeaderStyle-Width="110px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="true" FilterControlWidth="80%"
                DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy hh:mm:tt}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_NGUOIKYNHAN" HeaderText="Người nhận" DataField="C_NGUOIKYNHAN"
                HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
        </Columns>
        <EditFormSettings InsertCaption="Thêm nhận gửi mới" CaptionFormatString="Sửa nhận gửi: <b>{0}</b>"
            CaptionDataField="C_BILL" EditFormType="Template" PopUpSettings-Width="900px">
            <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column">
            </EditColumn>
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
                    <div style="width: 900px; height: 70px; background: #FFFFFF" class="clearfix">
                        <table id="tblEdit" class="TableEditInGrid" cellspacing="3" cellpadding="3" style="width: 100%"
                            border="0">
                            <tr>
                                <asp:HiddenField ID="txtID" Value='<%# Eval("PK_ID") %>' runat="server" />
                                <td style="width: 100px;">
                                    <span class="rtsTxtnew">Nhân viên phát:</span>
                                </td>
                                <td colspan="4">
                                    <telerik:RadComboBox ID="cmbFK_NHANVIENPHAT" runat="server" SelectedValue='<%# Bind("FK_NHANVIENPHAT") %>'
                                        DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="UserDataSource" ShowToggleImage="True"
                                        EmptyMessage="Chọn" AllowCustomText="True" Filter="Contains">
                                    </telerik:RadComboBox>
                                </td>
                                <td style="width: 100px;">
                                    <span class="rtsTxtnew">Ngày giờ phát:</span>
                                </td>
                                <td colspan="4">
                                    <telerik:RadDateTimePicker ID="radC_NGAYGIOPHAT" Width="95%" DbSelectedDate='<%# Bind("C_NGAYGIOPHAT") %>'
                                        runat="server" AutoPostBack="false">
                                        <DateInput ID="DateInput2" runat="server" DateFormat="dd/MM/yyyy hh:mm tt" MinDate="1/1/1890 12:00:00 AM">
                                            <ClientEvents OnKeyPress="controlkeypress" />
                                        </DateInput>
                                    </telerik:RadDateTimePicker>
                                </td>
                                <td style="width: 100px;">
                                    <span class="rtsTxtnew">Nhân viên KT:</span>
                                </td>
                                <td colspan="4">
                                    <telerik:RadComboBox ID="cmbFK_NHANVIENKHAITHAC" runat="server" SelectedValue='<%# Bind("FK_NHANVIENKHAITHAC") %>'
                                        DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="UserDataSource" ShowToggleImage="True"
                                        EmptyMessage="Chọn" AllowCustomText="True" Filter="Contains">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100px;">
                                    <span class="rtsTxtnew">Người ký nhận:</span>
                                </td>
                                <td colspan="4">
                                    <telerik:RadTextBox ID="txtC_NGUOIKYNHAN" Width="90%" Text='<%# Bind("C_NGUOIKYNHAN") %>'
                                        runat="server">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width: 100px;">
                                    <span class="rtsTxtnew">Bộ phận:</span>
                                </td>
                                <td colspan="4">
                                    <telerik:RadTextBox ID="txtC_BOPHAN" Width="90%" Text='<%# Bind("C_BOPHAN") %>' runat="server">
                                    </telerik:RadTextBox>
                                </td>
                                <td colspan="4">
                                    <span style="color: red;">Đã phát</span><asp:CheckBox ID="chkFK_TRANGTHAI" runat="server"
                                        Checked='<%# Eval("FK_TRANGTHAI") == DBNull.Value ? false : bool.Parse(Eval("FK_TRANGTHAI").ToString()) %>'>
                                    </asp:CheckBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="headerthongtin">
                    </div>
                    </center>
                    <!-- end bgpopup-->
                </div>
            </FormTemplate>
        </EditFormSettings>
    </MasterTableView>
    <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G1" />
    <ClientSettings AllowKeyboardNavigation="true" KeyboardNavigationSettings-AllowSubmitOnEnter="true"
        ClientEvents-OnKeyPress="KeyPressed">
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
        <ClientEvents OnPopUpShowing="PopUpShowing" />
        <ClientEvents OnRowDblClick="RowDblClick" />
        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="True" FrozenColumnsCount="3"
            ScrollHeight="400px" />
    </ClientSettings>
    <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" SortedDescToolTip="Sắp xếp giảm dần"
        SortToolTip="Click để sắp xếp" />
    <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<telerik:RadWindowManager ReloadOnShow="true" ShowContentDuringLoad="false" ID="RadWindowManagerNHANGUIPH"
    runat="server" VisibleStatusbar="False" OnClientClose="OnClientCloseNHANGUIPH"
    Behaviors="Move, Close" OnClientShow="OnClientShowNHANGUIPH" Width="900px" Height="100%"
    Top="50px" Left="100px">
</telerik:RadWindowManager>
<asp:SqlDataSource ID="NHANGUIPHDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [NHANGUI].[PK_ID], [NHANGUI].[C_NGAY], [NHANGUI].[FK_KHACHHANG], [NHANGUI].[C_BILL], [NHANGUI].[C_TENKH], [NHANGUI].[C_TELGUI], [NHANGUI].[C_NGUOINHAN], [NHANGUI].[C_DIACHINHAN], [NHANGUI].[C_TELNHAN], [NHANGUI].[FK_QUANHUYEN], [NHANGUI].[C_NOIDUNG], [NHANGUI].[C_SOKIEN], [NHANGUI].[C_GIATRIHANGHOA], [NHANGUI].[FK_MASANPHAM],  [NHANGUI].[C_PPXD], [NHANGUI].[C_KHOILUONGTHUC], [NHANGUI].[C_KHOILUONGQD], [NHANGUI].[C_KHOILUONG], [NHANGUI].[C_GIACUOC], [NHANGUI].[C_DONGGOI], [NHANGUI].[C_KHAIGIA], [NHANGUI].[C_COD], [NHANGUI].[C_BAOPHAT], [NHANGUI].[C_HENGIO], [NHANGUI].[C_HINHTHUCTT], [NHANGUI].[C_DATHU], ([NHANGUI].[C_TIENHANGVAT] - [NHANGUI].[C_DATHU]) as [C_CONLAI],([NHANGUI].[C_DONGGOI] + [NHANGUI].[C_KHAIGIA] + [NHANGUI].[C_COD] + [NHANGUI].[C_BAOPHAT] + [NHANGUI].[C_HENGIO]) as [C_PHUTROISUM], [NHANGUI].[C_TIENHANG], [NHANGUI].[C_VAT], [NHANGUI].[C_TIENHANGVAT], [NHANGUI].[FK_NHANVIENNHAN], [NHANGUI].[FK_DOITAC], [NHANGUI].[C_GIADOITAC], (CASE WHEN NOT EXISTS (SELECT USERS.PK_ID FROM USERS WHERE USERS.PK_ID = NHANGUI.FK_NHANVIENPHAT) THEN NULL ELSE NHANGUI.FK_NHANVIENPHAT END) as FK_NHANVIENPHAT, [NHANGUI].[C_NGAYGIOPHAT], (CASE WHEN NOT EXISTS (SELECT USERS.PK_ID FROM USERS WHERE USERS.PK_ID = NHANGUI.FK_NHANVIENKHAITHAC) THEN NULL ELSE NHANGUI.FK_NHANVIENKHAITHAC END) as FK_NHANVIENKHAITHAC, [NHANGUI].[C_NGUOIKYNHAN], [NHANGUI].[C_BOPHAN], [NHANGUI].[FK_TRANGTHAI], (CASE WHEN [NHANGUI].[FK_TRANGTHAI] = N'True' THEN N'Đã ký nhận' ELSE (SELECT TOP 1 DMTRANGTHAI.C_NAME FROM TRACKING LEFT OUTER JOIN DMTRANGTHAI ON TRACKING.FK_TRANGTHAI = DMTRANGTHAI.C_CODE WHERE TRACKING.C_BILL = NHANGUI.C_BILL ORDER BY TRACKING.C_DATE DESC) END) as TRANGTHAINAME, USERSNHAN.C_NAME as NHANVIENNHANNAME,USERSPHAT.C_NAME as NHANVIENPHATNAME,USERSKHAITHAC.C_NAME as NHANVIENKHAITHACNAME,DMMASANPHAM.C_NAME as SANPHAMNAME,DMQUANHUYEN.C_NAME as QUANHUYENNAME,DMTINHTHANH.C_NAME as TINHTHANHNAME FROM [NHANGUI] LEFT OUTER JOIN USERS as USERSNHAN ON NHANGUI.FK_NHANVIENNHAN = USERSNHAN.PK_ID LEFT OUTER JOIN USERS as USERSPHAT ON NHANGUI.FK_NHANVIENPHAT = USERSPHAT.PK_ID LEFT OUTER JOIN USERS as USERSKHAITHAC ON NHANGUI.FK_NHANVIENKHAITHAC = USERSKHAITHAC.PK_ID LEFT OUTER JOIN DMMASANPHAM ON NHANGUI.FK_MASANPHAM=DMMASANPHAM.PK_ID LEFT OUTER JOIN DMQUANHUYEN ON NHANGUI.FK_QUANHUYEN = DMQUANHUYEN.C_CODE LEFT OUTER JOIN DMTINHTHANH ON DMQUANHUYEN.FK_TINHTHANH = DMTINHTHANH.PK_ID WHERE (@FK_DOITAC = -1 OR FK_DOITAC = @FK_DOITAC) ORDER BY [NHANGUI].C_NGAY DESC"
    UpdateCommand="UPDATE [NHANGUI] SET [FK_NHANVIENPHAT] = @FK_NHANVIENPHAT, [C_NGAYGIOPHAT] = @C_NGAYGIOPHAT, [FK_NHANVIENKHAITHAC]=@FK_NHANVIENKHAITHAC, [C_NGUOIKYNHAN] = @C_NGUOIKYNHAN, [C_BOPHAN] = @C_BOPHAN, [FK_TRANGTHAI] = @FK_TRANGTHAI WHERE [C_BILL] = @C_BILL">
    <SelectParameters>
        <asp:ControlParameter Name="FK_DOITAC" Type="String" ControlID="cmbDoiTac" DefaultValue="-1" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="FK_NHANVIENPHAT" Type="Int32" />
        <asp:Parameter Name="C_NGAYGIOPHAT" Type="DateTime" />
        <asp:Parameter Name="FK_NHANVIENKHAITHAC" Type="Int32" />
        <asp:Parameter Name="C_NGUOIKYNHAN" Type="String" />
        <asp:Parameter Name="C_BOPHAN" Type="String" />
        <asp:Parameter Name="C_BILL" Type="string" />
        <asp:Parameter Name="FK_TRANGTHAI" Type="string" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="UserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT USERS.PK_ID,USERS.FK_GroupUser,USERS.FK_DEPT,USERS.C_LoginName,USERS.C_Password,USERS.C_NAME,USERS.C_Address,USERS.c_Tel,USERS.C_Email,USERS.C_DESC,GROUPUSER.C_NAME AS GROUPUSERNAME FROM USERS INNER JOIN GROUPUSER ON  USERS.FK_GROUPUSER = GROUPUSER.PK_ID WHERE FK_GROUPUSER NOT IN (0,1)">
</asp:SqlDataSource>
<asp:SqlDataSource ID="DoiTacDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMDoiTac] ORDER BY LTRIM([C_CODE])">
</asp:SqlDataSource>
<asp:SqlDataSource ID="FK_TRANGTHAIDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMTRANGTHAI]"></asp:SqlDataSource>
<asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Visible="false" Text="Button" />
<asp:TextBox ID="TextBox1" runat="server" Visible="false"></asp:TextBox>