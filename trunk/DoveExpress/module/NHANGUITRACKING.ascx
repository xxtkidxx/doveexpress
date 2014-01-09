<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NHANGUITRACKING.ascx.cs"
    Inherits="module_NHANGUITRACKING" %>
<telerik:RadCodeBlock ID="RadCodeBlockNHANGUITRACKING" runat="server">
    <script type="text/javascript">
        function RowDblClick(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("NHANGUIPH") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewNHANGUITRACKING") && (CanEdit == "True")) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
        }
    </script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelNHANGUITRACKING"
    runat="server" />
<telerik:RadGrid ID="RadGridNHANGUITRACKING" runat="server" Skin="Vista" AllowPaging="True"
    PageSize="20" AllowSorting="True" AllowFilteringByColumn="True" GridLines="None"
    ShowStatusBar="True" AutoGenerateColumns="False" AllowMultiRowEdit="True" AllowAutomaticDeletes="True"
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" DataSourceID="NHANGUITRACKINGDataSource"
    ShowFooter="True" OnDataBound="RadGridNHANGUITRACKING_DataBound" OnItemDeleted="RadGridNHANGUITRACKING_ItemDeleted"
    OnItemInserted="RadGridNHANGUITRACKING_ItemInserted" OnItemUpdated="RadGridNHANGUITRACKING_ItemUpdated"
    OnItemCommand="RadGridNHANGUITRACKING_ItemCommand" OnItemDataBound="RadGridNHANGUITRACKING_ItemDataBound"
    CellSpacing="0">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp"
        NextPageToolTip="Trang tiếp" PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau"
        PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true"
        OpenInNewWindow="true" Excel-Format="ExcelML">
        <Excel Format="ExcelML"></Excel>
    </ExportSettings>
    <GroupingSettings CaseSensitive="false" />
    <MasterTableView Name="MasterTableViewNHANGUITRACKING" CommandItemDisplay="Top" DataSourceID="NHANGUITRACKINGDataSource"
        DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
            <div style="padding: 5px 5px; float: left; width: auto">
                <b>Tracking Bill</b>&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridNHANGUITRACKING.EditIndexes.Count == 0 && ITCLIB.Security.Security.CanEditModule("NHANGUIPH") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridNHANGUITRACKING.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Update.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridNHANGUITRACKING.EditIndexes.Count > 0 || RadGridNHANGUITRACKING.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridNHANGUITRACKING.MasterTableView.IsItemInserted && ITCLIB.Security.Security.CanAddModule("NHANGUIPH") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                <asp:LinkButton ID="LinkButton3" runat="server" CommandName="PerformInsert" Visible='<%# RadGridNHANGUITRACKING.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Insert.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:return confirm('Bạn có muốn xóa bản ghi đã chọn không?')"
                    runat="server" CommandName="DeleteSelected" Visible='<%# ITCLIB.Security.Security.CanDeleteModule("NHANGUIPH") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Delete.gif" />Xóa</asp:LinkButton>&nbsp;&nbsp;
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
            <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn" HeaderStyle-Width="30px"
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
            <telerik:GridBoundColumn UniqueName="PK_ID" HeaderText="PK_ID" DataField="PK_ID"
                DataType="System.Int64" Visible="false" SortExpression="PK_ID">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_DATE" HeaderText="Thời gian" DataField="C_DATE"
                HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                ShowFilterIcon="false" FilterControlWidth="100%" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy HH:mm}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="TRANGTHAINAME" HeaderText="Trạng thái" DataField="TRANGTHAINAME"
                HeaderStyle-Width="110px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="C_DESC" HeaderText="Diễn giải" UniqueName="C_DESC"
                HeaderStyle-Width="110px" HeaderStyle-HorizontalAlign="Center" AutoPostBackOnFilter="true"
                CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
            </telerik:GridBoundColumn>
        </Columns>
        <EditFormSettings InsertCaption="Thêm tracking mới" CaptionFormatString="Sửa tracking: <b>{0}</b>"
            CaptionDataField="C_BILL" EditFormType="Template" PopUpSettings-Width="600px">
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
                    <div style="width: 600px; background: #FFFFFF" class="clearfix">
                        <table id="tblEdit" class="TableEditInGrid" cellspacing="3" cellpadding="3" style="width: 100%"
                            border="0">
                            <tr>
                                <td style="width: 150px;">
                                    <span class="rtsTxtnew">Thời gian:
                                </td>
                                <td colspan="4">
                                    <asp:HiddenField ID="txtID" Value='<%# Eval( "PK_ID") %>' runat="server" />
                                    <asp:HiddenField ID="txtC_BILL" Value='<%# Eval( "C_BILL") %>' runat="server" />
                                    <telerik:RadDateTimePicker ID="radC_DATE" Width="95%" DbSelectedDate='<%# Bind("C_DATE") %>'
                                        runat="server" AutoPostBack="false">
                                        <DateInput ID="DateInput1" runat="server" DateFormat="dd/MM/yyyy hh:mm tt" MinDate="1/1/1890 12:00:00 AM">
                                            <ClientEvents OnKeyPress="controlkeypress" />
                                        </DateInput>
                                    </telerik:RadDateTimePicker>
                                    <asp:RequiredFieldValidator ID="rfvCODE" runat="server" ErrorMessage="Thời gian không thể rỗng"
                                        ControlToValidate="radC_DATE" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 150px;">
                                    <span class="rtsTxtnew">Trạng thái:
                                </td>
                                <td colspan="4">
                                    <telerik:RadComboBox ID="cmbFK_TRANGTHAI" runat="server" DataTextField="C_NAME" DataValueField="C_CODE"
                                        SelectedValue='<%# Bind("FK_TRANGTHAI") %>' DataSourceID="FK_TRANGTHAIDataSource"
                                        ShowToggleImage="True" EmptyMessage="Chọn">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="rfvFK_TRANGTHAI" runat="server" ErrorMessage="Trạng thái không thể rỗng"
                                        ControlToValidate="cmbFK_TRANGTHAI" SetFocusOnError="True" Display="Dynamic"
                                        ValidationGroup="G1"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 150px;">
                                    <span class="rtsTxtnew">Diễn giải:
                                </td>
                                <td colspan="12">
                                    <telerik:RadTextBox ID="txtC_DESC" Width="90%" Text='<%# Bind("C_DESC") %>' runat="server">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                    </center>
                    <!-- end bgpopup-->
                </div>
            </FormTemplate>
            <PopUpSettings Width="600px"></PopUpSettings>
        </EditFormSettings>
    </MasterTableView>
    <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G1" />
    <ClientSettings AllowKeyboardNavigation="true" KeyboardNavigationSettings-AllowSubmitOnEnter="true"
        ClientEvents-OnKeyPress="KeyPressed">
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
        <ClientEvents OnPopUpShowing="PopUpShowing" />
        <ClientEvents OnRowDblClick="RowDblClick" />
    </ClientSettings>
    <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" SortedDescToolTip="Sắp xếp giảm dần"
        SortToolTip="Click để sắp xếp" />
    <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<asp:SqlDataSource ID="NHANGUITRACKINGDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    DeleteCommand="DELETE FROM [TRACKING] WHERE [PK_ID] = @PK_ID" InsertCommand="INSERT INTO [TRACKING] ([C_BILL], [C_DATE], [FK_TRANGTHAI], [C_DESC]) VALUES (@C_BILL, @C_DATE, @FK_TRANGTHAI, @C_DESC)"
    SelectCommand="SELECT [TRACKING].[PK_ID], [TRACKING].[C_BILL], [TRACKING].[C_DATE], [TRACKING].[FK_TRANGTHAI], [TRACKING].[C_DESC], [DMTRANGTHAI].[C_NAME] as TRANGTHAINAME FROM [TRACKING] LEFT OUTER JOIN [DMTRANGTHAI] ON [TRACKING].[FK_TRANGTHAI] = [DMTRANGTHAI].[C_CODE] WHERE [C_BILL] = @C_BILL ORDER BY [C_DATE] ASC"
    UpdateCommand="UPDATE [TRACKING] SET [C_BILL] = @C_BILL, [C_DATE] = @C_DATE, [FK_TRANGTHAI] = @FK_TRANGTHAI, [C_DESC] = @C_DESC WHERE [PK_ID] = @PK_ID">
    <SelectParameters>
        <asp:QueryStringParameter Name="C_BILL" Type="String" QueryStringField="IDBILL" DefaultValue="0" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="PK_ID" Type="Int64" />
    </DeleteParameters>
    <InsertParameters>
        <asp:QueryStringParameter Name="C_BILL" Type="String" QueryStringField="IDBILL" DefaultValue="0" />
        <asp:Parameter Name="C_DATE" Type="DateTime" />
        <asp:Parameter Name="FK_TRANGTHAI" Type="String" />
        <asp:Parameter Name="C_DESC" Type="String" />
    </InsertParameters>
    <UpdateParameters>
        <asp:QueryStringParameter Name="C_BILL" Type="String" QueryStringField="IDBILL" DefaultValue="0" />
        <asp:Parameter Name="C_DATE" Type="DateTime" />
        <asp:Parameter Name="FK_TRANGTHAI" Type="String" />
        <asp:Parameter Name="C_DESC" Type="String" />
        <asp:Parameter Name="PK_ID" Type="Int64" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="FK_TRANGTHAIDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMTRANGTHAI]"></asp:SqlDataSource>
