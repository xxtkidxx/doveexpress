﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager" runat="server">
    <Services>
      <asp:ServiceReference Path="MyWebService.asmx" />
    </Services>
  </telerik:RadScriptManager>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript">
        function controlkeypress(source, eventArgs) {
            var c = eventArgs.get_keyCode();
            if (c == 13) {
                eventArgs.set_cancel(true);
            }
        }
        function OnKeyPressRadTextBox(sender, eventArgs) {
            var charCode = eventArgs.get_keyCode();
            if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
                eventArgs.set_cancel(true);
            }
            return false;
        }
        var PK_ID, currentkhieunai, currentRowIndex = null;

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

                obj.PK_ID = "";
                obj.C_CODE = "";
                obj.C_TYPE = "";
                obj.C_DATE = "";
                obj.C_BILL = "";
                obj.FK_KHACHHANG = "";
                obj.C_TENKH = "";
                obj.C_SDT = "";
                obj.C_NOIDUNG = "";
                obj.FK_NGUOITAO = "";
                obj.C_STATUS = "";

                return obj;
            }
        };

        function getDataItemKeyValue(radGrid, item) {
            return parseInt(item.getDataKeyValue("PK_ID"));
        }

        function pageLoad(sender, args) {
            PK_ID = $find("<%= RadGridKHIEUNAI.ClientID %>").get_masterTableView().get_dataItems()[0].getDataKeyValue("PK_ID");
            $find("<%= txtC_CODE.ClientID %>").focus();
            currentRowIndex = 0;
        }

        function rowSelected(sender, args) {
            PK_ID = args.getDataKeyValue("PK_ID");
            currentRowIndex = args.get_gridDataItem().get_element().rowIndex;
            $find("<%= RadTabStripKHIEUNAI.ClientID %>").set_selectedIndex(0);
                alert(PK_ID);
                MyWebService.GetKHIEUNAIByPK_ID(PK_ID, setValues);
            }

            function setValues(khieunai) {
                $get("<%= txtID.ClientID %>").value = khieunai.PK_ID;
                $find("<%= txtC_CODE.ClientID %>").set_value(khieunai.C_CODE);
            $find("<%= txtC_CODE.ClientID %>").focus();
        }

        function getValues() {
            khieunai.PK_ID = $get("<%= txtID.ClientID %>").value;
                khieunai.C_CODE = $find("<%= txtC_CODE.ClientID %>").get_value();
                return khieunai;
            }

            function updateChanges() {
                MyWebService.UpdateKHIEUNAIByKHIEUNAI(getValues(), updateGrid);
            }

            function updateGrid(result) {
                var tableView = $find("<%= RadGridKHIEUNAI.ClientID %>").get_masterTableView();
                tableView.set_dataSource(result);
                tableView.dataBind();

                var grid = $find("<%= RadGridKHIEUNAI.ClientID %>");
                grid.repaint();
            }

            function tabSelected(sender, args) {
                if (currentkhieunai == null) {
                    currentkhieunai = getValues();
                }

                switch (args.get_tab().get_index()) {
                    case 1:
                        {
                            var gridItems = $find("<%= RadGridKHIEUNAI.ClientID %>").get_masterTableView().get_dataItems();
                            var newID = parseInt(gridItems[gridItems.length - 1].getDataKeyValue("PK_ID")) + 1;
                            var newkhieunai = khieunai.create();
                            newkhieunai.PK_ID = newID;
                            setValues(newkhieunai);
                            $get("<%= btnSave.ClientID %>").value = "Thêm";
                            $get("<%= btnDelete.ClientID %>").parentNode.style.display = "none";
                            break;
                        }
                    default:
                        {
                            setValues(currentkhieunai);
                            currentkhieunai = null;
                            $get("<%= btnSave.ClientID %>").value = "Lưu";
                            $get("<%= btnDelete.ClientID %>").parentNode.style.display = "";
                            break;
                        }
                }
            }

            function deleteCurrent() {
                var table = $find("<%= RadGridKHIEUNAI.ClientID %>").get_masterTableView().get_element();
                var row = table.rows[currentRowIndex];
                table.deleteRow(currentRowIndex);
                var dataItem = $find(row.id);
                if (dataItem) {
                    dataItem.dispose();
                    Array.remove($find("<%= RadGridKHIEUNAI.ClientID %>").get_masterTableView()._dataItems, dataItem);
                }
                var gridItems = $find("<%= RadGridKHIEUNAI.ClientID %>").get_masterTableView().get_dataItems();
                MyWebService.DeleteKHIEUNAIByPK_ID(PK_ID, updateGrid);
                gridItems[gridItems.length - 1].set_selected(true);
            }

    </script>
</telerik:RadCodeBlock>
<telerik:RadGrid ID="RadGridKHIEUNAI" DataSourceID="KHIEUNAIDataSource" runat="server"
    Skin="Vista" AllowPaging="True" PageSize="20" AllowSorting="True" AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False" OnDataBound="RadGridKHIEUNAI_DataBound" OnColumnCreated="RadGridKHIEUNAI_ColumnCreated" Height="300px">
    <MasterTableView Name="MasterTableViewKHIEUNAI" CommandItemDisplay="Top" DataSourceID="KHIEUNAIDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
            <div style="padding: 5px 5px; float: left; width: auto">
                <b>Quản lý khiếu nại</b>&nbsp;&nbsp;&nbsp;&nbsp;
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
            <telerik:GridBoundColumn UniqueName="NGUOITAONAME" HeaderText="Người tạo" DataField="NGUOITAONAME" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
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
            <asp:LinkButton ID="btnSave" runat="server"><img src="Images/img_save.jpg" />Lưu</asp:LinkButton></li>
        <li>
            <asp:LinkButton ID="btnDelete" runat="server"><img src="Images/img_Close.jpg" />Xóa</asp:LinkButton></li>
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
                    <telerik:RadTextBox ID="txtC_CODE" Width="80%" runat="server" MaxLength="7">
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
                        runat="server" EmptyMessage="Chọn">
                        <Items>
                            <telerik:RadComboBoxItem Value="Bill" Text="Bill" />
                            <telerik:RadComboBoxItem Value="Khác" Text="Khác" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td style="width: 150px;"><span class="rtsTxtnew">Số Bill/Chủ đề:</td>
                <td colspan="4">
                    <telerik:RadTextBox ID="txtC_BILL" runat="server" Width="90%"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 100px;">
                    <span class="rtsTxtnew">Mã khách hàng:</span>
                </td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbMaKhachHang" runat="server"
                        DataTextField="C_CODE" DataValueField="C_CODE" DataSourceID="KHACHHANGDataSource"
                        ShowToggleImage="True" EmptyMessage="Chọn mã"
                        AllowCustomText="True" Filter="Contains">
                    </telerik:RadComboBox>
                </td>
                <td style="width: 100px;">
                    <span class="rtsTxtnew">Tên khách hàng:</span>
                </td>
                <td colspan="4">
                    <telerik:RadTextBox ID="txtC_TENKH" Width="90%" runat="server">
                    </telerik:RadTextBox>
                </td>
                <td style="width: 100px;">
                    <span class="rtsTxtnew">Số điện thoại:</span>
                </td>
                <td colspan="4">
                    <telerik:RadTextBox ID="txtC_SDT" Width="90%"
                        runat="server">
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
<asp:SqlDataSource ID="KHIEUNAIDataSource" runat="server"
    ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    DeleteCommand="DELETE FROM [KHIEUNAI] WHERE [PK_ID] = @PK_ID"
    InsertCommand="INSERT INTO [KHIEUNAI] ([C_CODE], [C_TYPE], [C_DATE], [C_BILL], [FK_KHACHHANG], [C_TENKH], [C_SDT], [C_NOIDUNG], [FK_NGUOITAO], [C_STATUS]) VALUES (@C_CODE, @C_TYPE, @C_DATE, @C_BILL, @FK_KHACHHANG, @C_TENKH, @C_SDT, @C_NOIDUNG, @FK_NGUOITAO, @C_STATUS)"
    SelectCommand="SELECT [KHIEUNAI].[PK_ID], [KHIEUNAI].[C_CODE], [KHIEUNAI].[C_TYPE], [KHIEUNAI].[C_DATE], [KHIEUNAI].[C_BILL], [KHIEUNAI].[FK_KHACHHANG], [KHIEUNAI].[C_TENKH], [KHIEUNAI].[C_SDT], [KHIEUNAI].[C_NOIDUNG], [KHIEUNAI].[FK_NGUOITAO], [KHIEUNAI].[C_STATUS], USERS.C_NAME as NGUOITAONAME FROM [KHIEUNAI] LEFT OUTER JOIN USERS ON KHIEUNAI.FK_NGUOITAO =USERS.PK_ID"
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
<asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Visible="true" Text="Button" />
<asp:TextBox ID="TextBox1" runat="server" Visible="true"></asp:TextBox>
    </form>
</body>
</html>
