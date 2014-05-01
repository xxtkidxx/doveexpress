<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CHITIETCUOC.ascx.cs" Inherits="module_CHITIETCUOC" %>
<telerik:RadScriptBlock ID="RadScriptBlockCHITIETCUOC" runat="server">
    <script type="text/javascript">
        function cmbMaBangCuocClientSelectedIndexChangedHandler(sender, eventArgs) {
            $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("PTVALUE,2");
            return false;
        }
        function cmbSanPhamClientSelectedIndexChangedHandler(sender, eventArgs) {
            $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("PTVALUE,1");
            return false;
        }
        function cmbLoaiTienClientSelectedIndexChangedHandler(sender, eventArgs) {
            $find("<%=RadGridCHITIETCUOC.ClientID %>").get_masterTableView().rebind();
        return false;
    }
    </script>
    <script type="text/javascript">
        function RowDblClick(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("BANGCUOC") %>";
            if ((eventArgs.get_tableView().get_name() == "TableViewCHITIETCUOC") && (CanEdit == "True")) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
        }
    </script>
    <script type="text/javascript">
        function onClientClickSelectedCTC(sender1, sender2, sender3) {
            $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("SelectedCTC," + sender1 + "," + sender2 + "," + sender3);
            return false;
        }
        function onClientClickSelectedCTC1(sender1, sender2, sender3) {
            $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("SelectedCTC1," + sender1 + "," + sender2 + "," + sender3);
            return false;
        }
        function onResponseEndCTC() {

            if (typeof (result) != "undefined" && result && result != "") {
                //alert(result);
                var arrayOfStrings = result.split(",-,");
                if (arrayOfStrings[0] == "PTVALUE") {
                    $find("<%=txtC_PPXD.ClientID %>").set_value(arrayOfStrings[1]);
                $find("<%=txtC_VAT.ClientID %>").set_value(arrayOfStrings[2]);
                $find("<%=txtC_DONGGOIX.ClientID %>").set_value(arrayOfStrings[3]);
                $find("<%=txtC_DONGGOIY.ClientID %>").set_value(arrayOfStrings[4]);
                $find("<%=txtC_KHAIGIAX.ClientID %>").set_value(arrayOfStrings[5]);
                $find("<%=txtC_KHAIGIAY.ClientID %>").set_value(arrayOfStrings[6]);
                $find("<%=txtC_BAOPHATX.ClientID %>").set_value(arrayOfStrings[7]);
                $find("<%=txtC_BAOPHATY.ClientID %>").set_value(arrayOfStrings[8]);
                $find("<%=txtC_HENGIOX.ClientID %>").set_value(arrayOfStrings[9]);
                $find("<%=txtC_HENGIOY.ClientID %>").set_value(arrayOfStrings[10]);
                $find("<%=txtC_HAIQUANX.ClientID %>").set_value(arrayOfStrings[11]);
                $find("<%=txtC_HAIQUANY.ClientID %>").set_value(arrayOfStrings[12]);
                $find("<%=txtC_HUNTRUNGX.ClientID %>").set_value(arrayOfStrings[13]);
                $find("<%=txtC_HUNTRUNGY.ClientID %>").set_value(arrayOfStrings[14]);

                $find("<%=RadGridCHITIETCUOC.ClientID %>").get_masterTableView().rebind();
            }
            else {
                var masterTable = $find("<%= RadGridCHITIETCUOC.ClientID %>").get_masterTableView();
                var dataItems = masterTable.get_dataItems();
                for (var i = 0; i < dataItems.length; i++) {
                    if (dataItems[i].get_nestedViews().length > 0) {
                        var nestedView = dataItems[i].get_nestedViews()[0];
                        if (nestedView.get_dataItems().length > 0) {
                            var firstDataItem = nestedView.get_dataItems()[0];
                            if (firstDataItem.getDataKeyValue("FK_MAVUNG") == arrayOfStrings[1]) {
                                nestedView.rebind();
                            }
                        }
                    }
                }
            }
            result = "";
        }
        return false;
    }
    </script>
</telerik:RadScriptBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelCHITIETCUOC" runat="server" />
<div style="width: 100%; margin: 10px 10px 10px 10px;">
    Dịch vụ:&nbsp; 
    <telerik:RadComboBox ID="cmbSanPham" runat="server"
        DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="MASANPHAMDataSource"
        ShowToggleImage="True" EmptyMessage="Chọn dịch vụ"
        OnClientSelectedIndexChanged="cmbSanPhamClientSelectedIndexChangedHandler" OnPreRender="cmbSanPham_PreRender">
    </telerik:RadComboBox>
    Loại tiền:&nbsp; 
    <telerik:RadComboBox ID="cmbLoaiTien" runat="server"
        ShowToggleImage="True" EmptyMessage="Chọn loại" OnClientSelectedIndexChanged="cmbLoaiTienClientSelectedIndexChangedHandler"
        OnPreRender="cmbLoaiTien_PreRender">
        <Items>
            <telerik:RadComboBoxItem Value="VND" Text="VND" />
            <telerik:RadComboBoxItem Value="USD" Text="USD" Visible="false" />
        </Items>
    </telerik:RadComboBox>
    Bảng cước:&nbsp; 
    <telerik:RadComboBox ID="cmbMaBangCuoc" runat="server"
        DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="MABANGCUOCDataSource"
        ShowToggleImage="True" EmptyMessage="Chọn bảng"
        OnPreRender="cmbMaBangCuoc_PreRender"
        OnClientSelectedIndexChanged="cmbMaBangCuocClientSelectedIndexChangedHandler">
    </telerik:RadComboBox>
</div>
<telerik:RadGrid ID="RadGridCHITIETCUOC" runat="server" Skin="Vista"
    AllowPaging="True" PageSize="20" AllowSorting="True"
    AllowFilteringByColumn="False" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True"
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True"
    DataSourceID="MAVUNGDataSource" ShowFooter="True"
    OnDataBound="RadGridCHITIETCUOC_DataBound"
    OnItemDeleted="RadGridCHITIETCUOC_ItemDeleted" OnItemInserted="RadGridCHITIETCUOC_ItemInserted"
    OnItemUpdated="RadGridCHITIETCUOC_ItemUpdated"
    OnItemCommand="RadGridCHITIETCUOC_ItemCommand"
    OnItemDataBound="RadGridCHITIETCUOC_ItemDataBound" CellSpacing="0"
    OnItemCreated="RadGridCHITIETCUOC_ItemCreated">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp"
        PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>
    <GroupingSettings CaseSensitive="false" />
    <MasterTableView Name="MasterTableViewMAVUNG" HierarchyDefaultExpanded="false" CommandItemDisplay="Top" DataSourceID="MAVUNGDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="InPlace" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
            <div style="padding: 5px 5px; float: left; width: auto">
                <b>Quản lý bảng cước</b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridCHITIETCUOC.EditIndexes.Count == 0 && ITCLIB.Security.Security.CanEditModule("BANGCUOC") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridCHITIETCUOC.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Update.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridCHITIETCUOC.EditIndexes.Count > 0 || RadGridCHITIETCUOC.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible="false"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="PerformInsert" Visible='<%# RadGridCHITIETCUOC.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Insert.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:return confirm('Bạn có muốn xóa bản ghi đã chọn không?')" runat="server" CommandName="DeleteSelected" Visible="false"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Delete.gif" />Xóa</asp:LinkButton>&nbsp;&nbsp;
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
            <telerik:GridBoundColumn UniqueName="PK_ID" DataField="PK_ID" Visible="false">
            </telerik:GridBoundColumn>
            <telerik:GridTemplateColumn HeaderText="" AllowFiltering="false" ShowFilterIcon="false">
                <ItemTemplate>
                    <asp:Label ID="lblSTT" runat="server" Text=""></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Center" Width="30px" />
                <ItemStyle HorizontalAlign="Center" Width="30px" />
            </telerik:GridTemplateColumn>
            <telerik:GridBoundColumn UniqueName="C_CODE" HeaderText="Mã mã vùng" DataField="C_CODE" AllowFiltering="false">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn UniqueName="C_NAME" HeaderText="Tên mã vùng" DataField="C_NAME" AllowFiltering="false">
            </telerik:GridBoundColumn>
            <telerik:GridTemplateColumn DataField="PK_ID" DataType="System.Decimal" HeaderText="COD x" AllowFiltering="false" UniqueName="CODX">
                <ItemTemplate>
                    <%# LoadCODX(Eval("PK_ID").ToString())%>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadNumericTextBox runat="server" ID="txtC_CODX" DbValue='<%# LoadCODX(Eval("PK_ID").ToString()) %>'>
                        <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="0" />
                    </telerik:RadNumericTextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn DataField="PK_ID" DataType="System.Decimal" HeaderText="COD y" AllowFiltering="false" UniqueName="CODY">
                <ItemTemplate>
                    <%# LoadCODY(Eval("PK_ID").ToString())%>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadNumericTextBox runat="server" ID="txtC_CODY" DbValue='<%# LoadCODY(Eval("PK_ID").ToString()) %>'>
                        <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="1" />
                    </telerik:RadNumericTextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridBoundColumn UniqueName="C_DESC" HeaderText="Tuyến đường thuộc vùng" DataField="C_DESC" Visible="false" AllowFiltering="false">
            </telerik:GridBoundColumn>
        </Columns>
        <DetailTables>
            <telerik:GridTableView DataKeyNames="PK_ID,FK_MAVUNG" ClientDataKeyNames="FK_MAVUNG" DataSourceID="CHITIETCUOCDataSource" Width="100%" runat="server" CommandItemDisplay="Top" Name="TableViewCHITIETCUOC" EditMode="InPlace" NoDetailRecordsText="Không có dữ liệu.">
                <ParentTableRelation>
                    <telerik:GridRelationFields DetailKeyField="FK_MAVUNG" MasterKeyField="PK_ID"></telerik:GridRelationFields>
                </ParentTableRelation>
                <CommandItemTemplate>
                    <div style="padding: 5px 5px; float: left; width: auto">
                        <b>Chi tiết cước</b>&nbsp;&nbsp;&nbsp;&nbsp;                        
               <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridCHITIETCUOC.MasterTableView.IsItemInserted && ITCLIB.Security.Security.CanAddModule("BANGCUOC")%>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
               <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:return confirm('Bạn có muốn xóa bản ghi đã chọn không?')" runat="server" Visible='<%# ITCLIB.Security.Security.CanDeleteModule("BANGCUOC")%>' CommandName="DeleteSelected"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Delete.gif" />Xóa</asp:LinkButton>&nbsp;&nbsp;
                    </div>
                </CommandItemTemplate>
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn" HeaderStyle-Width="80px" EditImageUrl="~/images/grid/Edit.gif"></telerik:GridEditCommandColumn>
                    <telerik:GridTemplateColumn DataField="C_KHOILUONG" DataType="System.Decimal" HeaderText="Khối lượng" AllowFiltering="false" UniqueName="C_KHOILUONG">
                        <ItemTemplate>
                            <%# Eval("C_KHOILUONG")%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadNumericTextBox runat="server" ID="txtC_KHOILUONG" DbValue='<%# Bind("C_KHOILUONG") %>'>
                                <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="0" />
                            </telerik:RadNumericTextBox>
                        </EditItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="C_CUOCPHI" DataType="System.Decimal" HeaderText="Cước phí" AllowFiltering="false" UniqueName="C_CUOCPHI">
                        <ItemTemplate>
                            <telerik:RadNumericTextBox runat="server" CssClass="csstextNum" ID="txtC_CUOCPHI" Width="100px" Enabled="false" DbValue='<%# Eval("C_CUOCPHI") %>'>
                                <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="0" />
                            </telerik:RadNumericTextBox>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadNumericTextBox runat="server" ID="txtC_CUOCPHI" DbValue='<%# Bind("C_CUOCPHI") %>'>
                                <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="0" />
                            </telerik:RadNumericTextBox>
                        </EditItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn UniqueName="C_TYPE" HeaderText="Luỹ kế cuối" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:CheckBox ID="chkDefault" runat="server" onclick='<%# String.Format("if(!onClientClickSelectedCTC({0},{1},{2})) return false;",Eval("PK_ID"),Eval("FK_MAVUNG"),Eval("C_TYPE")) %>' Checked='<%# getstatus(Eval("C_TYPE")) %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                        </EditItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn UniqueName="C_TYPE1" HeaderText="Mức tính theo Kg" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:CheckBox ID="chkDefault1" runat="server" onclick='<%# String.Format("if(!onClientClickSelectedCTC1({0},{1},{2})) return false;",Eval("PK_ID"),Eval("FK_MAVUNG"),Eval("C_TYPE1")) %>' Checked='<%# getstatus(Eval("C_TYPE1")) %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                        </EditItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </telerik:GridTableView>
        </DetailTables>
    </MasterTableView>
    <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G1" />
    <ClientSettings>
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
        <ClientEvents OnPopUpShowing="PopUpShowing" />
        <ClientEvents OnRowDblClick="RowDblClick" />
    </ClientSettings>
    <SortingSettings SortedAscToolTip="Sắp xếp tăng dần"
        SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
    <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<style type="text/css">
    table.gridtable {
        font-family: verdana,arial,sans-serif;
        font-size: 13px;
        color: #333333;
        border-width: 1px;
        border-color: #666666;
        border-collapse: collapse;
        width: 80%;
        margin: 5px 5px 5px 5px;
    }

        table.gridtable th {
            border-width: 1px;
            padding: 5px;
            font-weight: bold;
            border-style: solid;
            border-color: #666666;
            background-color: #dedede;
        }

        table.gridtable td {
            border-width: 1px;
            padding: 5px;
            border-style: solid;
            border-color: #666666;
            background-color: #ffffff;
        }
</style>
<table class="gridtable">
    <tr>
        <th>Phụ phí xăng dầu(%)
        </th>
        <th>VAT
        </th>
        <th>Đóng gói
        </th>
        <th>Khai giá
        </th>
        <th>Báo phát
        </th>
        <th>Hẹn giờ
        </th>
        <th>Hải quan
        </th>
        <th>Hun trùng
        </th>
    </tr>
    <tr>
        <td>
            <telerik:RadNumericTextBox runat="server" CssClass="csstextNum" ID="txtC_PPXD" Width="50px">
                <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="1" />
            </telerik:RadNumericTextBox>
        </td>
        <td>
            <telerik:RadNumericTextBox runat="server" CssClass="csstextNum" ID="txtC_VAT" Width="50px">
                <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="1" />
            </telerik:RadNumericTextBox>
        </td>
        <td>x: 
            <telerik:RadNumericTextBox runat="server" CssClass="csstextNum" ID="txtC_DONGGOIX" Width="60px">
                <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="0" />
            </telerik:RadNumericTextBox>
            y: 
            <telerik:RadNumericTextBox runat="server" CssClass="csstextNum" ID="txtC_DONGGOIY" Width="40px">
                <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="1" />
            </telerik:RadNumericTextBox>
        </td>
        <td>x: 
            <telerik:RadNumericTextBox runat="server" CssClass="csstextNum" ID="txtC_KHAIGIAX" Width="60px">
                <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="0" />
            </telerik:RadNumericTextBox>
            y: 
            <telerik:RadNumericTextBox runat="server" CssClass="csstextNum" ID="txtC_KHAIGIAY" Width="40px">
                <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="1" />
            </telerik:RadNumericTextBox>
        </td>
        <td>x: 
            <telerik:RadNumericTextBox runat="server" CssClass="csstextNum" ID="txtC_BAOPHATX" Width="60px">
                <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="01" />
            </telerik:RadNumericTextBox>
            y: 
            <telerik:RadNumericTextBox runat="server" CssClass="csstextNum" ID="txtC_BAOPHATY" Width="40px">
                <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="1" />
            </telerik:RadNumericTextBox>
        </td>
        <td>x: 
            <telerik:RadNumericTextBox runat="server" CssClass="csstextNum" ID="txtC_HENGIOX" Width="60px">
                <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="0" />
            </telerik:RadNumericTextBox>
            y: 
            <telerik:RadNumericTextBox runat="server" CssClass="csstextNum" ID="txtC_HENGIOY" Width="40px">
                <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="1" />
            </telerik:RadNumericTextBox>
        </td>
        <td>x: 
            <telerik:RadNumericTextBox runat="server" CssClass="csstextNum" ID="txtC_HAIQUANX" Width="60px">
                <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="0" />
            </telerik:RadNumericTextBox>
            y: 
            <telerik:RadNumericTextBox runat="server" CssClass="csstextNum" ID="txtC_HAIQUANY" Width="40px">
                <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="1" />
            </telerik:RadNumericTextBox>
        </td>
        <td>x: 
            <telerik:RadNumericTextBox runat="server" CssClass="csstextNum" ID="txtC_HUNTRUNGX" Width="60px">
                <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="0" />
            </telerik:RadNumericTextBox>
            y: 
            <telerik:RadNumericTextBox runat="server" CssClass="csstextNum" ID="txtC_HUNTRUNGY" Width="40px">
                <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="1" />
            </telerik:RadNumericTextBox>
        </td>
    </tr>
</table>
<div style="width: 100%; margin: 5px 5px 5px 5px;">
    <asp:Button ID="btnSave" runat="server" Text="Lưu" OnClick="btnSave_Click" />
</div>
<asp:SqlDataSource ID="CHITIETCUOCDataSource" runat="server"
    ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    DeleteCommand="DELETE FROM [DMCHITIETCUOC] WHERE [PK_ID] = @PK_ID"
    InsertCommand="INSERT INTO [DMCHITIETCUOC] ([FK_MABANGCUOC], [FK_MASANPHAM], [FK_MAVUNG], [C_LOAITIEN], [C_KHOILUONG], [C_CUOCPHI], [C_TYPE], [C_TYPE1]) VALUES (@FK_MABANGCUOC, @FK_MASANPHAM, @FK_MAVUNG, @C_LOAITIEN, @C_KHOILUONG, @C_CUOCPHI,0,0)"
    SelectCommand="SELECT [PK_ID], [FK_MABANGCUOC], [FK_MASANPHAM], [FK_MAVUNG], [C_LOAITIEN], [C_KHOILUONG], [C_CUOCPHI], [C_TYPE], [C_TYPE1] FROM [DMCHITIETCUOC] WHERE [FK_MAVUNG] =@FK_MAVUNG AND [FK_MABANGCUOC] = @FK_MABANGCUOC AND [FK_MASANPHAM] = @FK_MASANPHAM AND [C_LOAITIEN] = @C_LOAITIEN ORDER BY [C_TYPE] ASC, [C_TYPE1] ASC, [C_KHOILUONG] ASC"
    UpdateCommand="UPDATE [DMCHITIETCUOC] SET [C_KHOILUONG] = @C_KHOILUONG, [C_CUOCPHI] = @C_CUOCPHI WHERE [PK_ID] = @PK_ID">
    <SelectParameters>
        <asp:Parameter Name="FK_MAVUNG" Type="Int32" />
        <asp:ControlParameter ControlID="cmbMaBangCuoc" DefaultValue="0" Name="FK_MABANGCUOC" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="cmbSanPham" DefaultValue="0" Name="FK_MASANPHAM" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="cmbLoaiTien" DefaultValue="0" Name="C_LOAITIEN" PropertyName="SelectedValue" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="PK_ID" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:ControlParameter ControlID="cmbMaBangCuoc" DefaultValue="0" Name="FK_MABANGCUOC" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="cmbSanPham" DefaultValue="0" Name="FK_MASANPHAM" PropertyName="SelectedValue" />
        <asp:Parameter Name="FK_MAVUNG" Type="Int32" />
        <asp:ControlParameter ControlID="cmbLoaiTien" DefaultValue="0" Name="C_LOAITIEN" PropertyName="SelectedValue" />
        <asp:Parameter Name="C_KHOILUONG" Type="String" />
        <asp:Parameter Name="C_CUOCPHI" Type="Decimal" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="C_KHOILUONG" Type="String" />
        <asp:Parameter Name="C_CUOCPHI" Type="Decimal" />
        <asp:Parameter Name="PK_ID" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="MAVUNGDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    DeleteCommand="DELETE FROM [DMMAVUNG] WHERE [PK_ID] = @PK_ID"
    InsertCommand="INSERT INTO [DMMAVUNG] ([C_CODE], [C_NAME], [C_DESC]) VALUES (@C_CODE, @C_NAME, @C_DESC)"
    SelectCommand="SELECT [DMMAVUNG].[PK_ID], [DMMAVUNG].[C_CODE], [DMMAVUNG].[C_NAME], [DMMAVUNG].[C_DESC] FROM [DMMAVUNG] WHERE FK_MASANPHAM = @FK_MASANPHAM AND DMMAVUNG.FK_VUNGLAMVIEC = @FK_VUNGLAMVIEC ORDER BY LTRIM([C_CODE])"
    UpdateCommand="UPDATE [DMMAVUNG] SET [C_CODE] = @C_CODE, [C_NAME] = @C_NAME,[C_DESC] = @C_DESC WHERE [PK_ID] = @PK_ID">
    <SelectParameters>
        <asp:ControlParameter ControlID="cmbSanPham" DefaultValue="0" Name="FK_MASANPHAM" PropertyName="SelectedValue" />
        <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="C_CODE" Type="String" />
        <asp:Parameter Name="C_NAME" Type="String" />
        <asp:Parameter Name="C_DESC" Type="String" />
    </UpdateParameters>
    <DeleteParameters>
        <asp:Parameter Name="PK_ID" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="C_CODE" Type="String" />
        <asp:Parameter Name="C_NAME" Type="String" />
        <asp:Parameter Name="C_DESC" Type="String" />
    </InsertParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="MABANGCUOCDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME],[FK_VUNGLAMVIEC] FROM [DMMABANGCUOC] WHERE [DMMABANGCUOC].FK_VUNGLAMVIEC = @FK_VUNGLAMVIEC ORDER BY LTRIM([C_CODE])">
    <SelectParameters>
        <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="MASANPHAMDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMMASANPHAM]  WHERE [C_TYPE] = N'Trong nước' ORDER BY LTRIM([C_CODE])"></asp:SqlDataSource>
