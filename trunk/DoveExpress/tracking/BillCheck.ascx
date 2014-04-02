<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BillCheck.ascx.cs" Inherits="ext_BillCheck" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerCheckBill" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="pnCheckBill">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="pnCheckBill" LoadingPanelID="RadAjaxLoadingPanel">
                </telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<script type="text/javascript">
function OnKeyPressRadTextBox(sender, eventArgs) {
            var charCode = eventArgs.get_keyCode();
            if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
                eventArgs.set_cancel(true);
            }
            return false;
        }
</script>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanel" runat="server" />
    <asp:Panel ID="pnCheckBill" runat="server">
        <table class="table1">
            <tfoot>
                <tr>
                    <th scope="row">
                        TÌNH TRẠNG HIỆN TẠI:
                    </th>
                    <td>
                        <asp:Label ID="lblC_STATUS" runat="server" Text="-"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        LỊCH SỬ HÀNH TRÌNH:
                    </th>
                </tr>
            </tfoot>
            <tbody>
                <tr>
                    <th scope="row">
                        NHẬP SỐ PHIẾU GỬI (BILL):
                    </th>
                    <td>
                        (BC)<telerik:RadTextBox ID="txtBILL" Width="30%" Text='<%# Bind("C_BILL") %>' runat="server">
                        <ClientEvents OnKeyPress="OnKeyPressRadTextBox" />
                        </telerik:RadTextBox>
                        <asp:ImageButton ID="imgSearch" runat="server" ImageUrl="~/images/imgsearch.png"
                            Width="30px" ImageAlign="AbsMiddle" OnClick="imgSearch_Click" />
                    </td>
                </tr>
                 <tr>
                    <th scope="row">
                        Mã khách hàng:
                    </th>
                    <td>
                        <asp:Label ID="lblMaKhachHang" runat="server" Text="-"></asp:Label>
                    </td>
                </tr>
                 <tr>
                    <th scope="row">
                        Ngày gửi:
                    </th>
                    <td>
                        <asp:Label ID="lblNgaygui" runat="server" Text="-"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        Dịch vụ:
                    </th>
                    <td>
                        <asp:Label ID="lblDichvu" runat="server" Text="-"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        Địa chỉ đến:
                    </th>
                    <td>
                        <asp:Label ID="lblDiachinhan" runat="server" Text="-"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        <asp:Label ID="lblQuanhuyen" runat="server" Text="Tỉnh thành/Quận huyện:"></asp:Label>
                    </th>
                    <td>
                        <asp:Label ID="lblQuanhuyenValue" runat="server" Text="-"></asp:Label>
                    </td>
                </tr>
            </tbody>
        </table>
        <telerik:RadGrid ID="RadGridBILLCHECK" runat="server" AutoGenerateColumns="false" ShowHeader = "false"
            Skin="Vista" AllowFilteringByColumn="false" AllowSorting="false" AllowPaging="True"
            Width="99%" ItemStyle-Font-Bold ="true" AlternatingItemStyle-Font-Bold = "true" ItemStyle-Font-Size="14px" AlternatingItemStyle-Font-Size="14px" ItemStyle-ForeColor="#005CA2" AlternatingItemStyle-ForeColor="#005CA2" ItemStyle-Height="30px" AlternatingItemStyle-Height="30px">
            <PagerStyle Mode="NextPrevNumericAndAdvanced" />
              <MasterTableView NoMasterRecordsText="Dữ liệu tracking chưa được cập nhật">
                <Columns>
                    <telerik:GridBoundColumn UniqueName="C_DATE" DataField="C_DATE" HeaderText="Thời gian" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy HH:mm}">
                        <HeaderStyle HorizontalAlign="Center" Width="50px"/>
                        <ItemStyle HorizontalAlign="Center" Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="TRANGTHAINAME" DataField="TRANGTHAINAME" HeaderText="Trạng thái">
                        <HeaderStyle HorizontalAlign="Center" Width="180px"/>
                        <ItemStyle HorizontalAlign="Center" Width="180px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="C_DESC" DataField="C_DESC" HeaderText="Diễn giải">
                        <HeaderStyle HorizontalAlign="Center" Width="200px"/>
                        <ItemStyle HorizontalAlign="Center" Width="200px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </asp:Panel>