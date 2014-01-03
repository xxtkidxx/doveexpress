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
                        NHẬP SỐ PHIẾU GỬI (BILL)
                    </th>
                    <td>
                        (BC)<telerik:RadNumericTextBox ID="txtBILL" Width="50%" Text='<%# Bind("C_BILL") %>'
                            runat="server">
                            <NumberFormat DecimalSeparator="." GroupSeparator="" DecimalDigits="0" />
                        </telerik:RadNumericTextBox>
                        <asp:ImageButton ID="imgSearch" runat="server" ImageUrl="~/images/imgsearch.png"
                            Width="40px" ImageAlign="AbsMiddle" OnClick="imgSearch_Click" />
                    </td>
                </tr>
                 <tr>
                    <th scope="row">
                        Mã khách hàng
                    </th>
                    <td>
                        <asp:Label ID="lblMaKhachHang" runat="server" Text="-"></asp:Label>
                    </td>
                </tr>
                 <tr>
                    <th scope="row">
                        Ngày gửi
                    </th>
                    <td>
                        <asp:Label ID="lblNgaygui" runat="server" Text="-"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        Dịch vụ
                    </th>
                    <td>
                        <asp:Label ID="lblDichvu" runat="server" Text="-"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        Địa chỉ đến
                    </th>
                    <td>
                        <asp:Label ID="lblDiachinhan" runat="server" Text="-"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        <asp:Label ID="lblQuanhuyen" runat="server" Text="Tỉnh thành/Quận huyện"></asp:Label>
                    </th>
                    <td>
                        <asp:Label ID="lblQuanhuyenValue" runat="server" Text="-"></asp:Label>
                    </td>
                </tr>
            </tbody>
        </table>
        <telerik:RadGrid ID="RadGridBILLCHECK" runat="server" AutoGenerateColumns="false"
            Skin="Hay" AllowFilteringByColumn="false" AllowSorting="false" AllowPaging="True"
            Width="99%" BorderColor="#D6D1C6">
            <HeaderStyle BackColor="#EDEDED" BorderColor="#D6D1C6" Font-Bold="True" ForeColor="#575757"
                Height="30px" />
            <ItemStyle BorderStyle="Outset" Height="30px" />
            <PagerStyle Mode="NextPrevNumericAndAdvanced" />
              <MasterTableView NoMasterRecordsText="Dữ liệu tracking chưa được cập nhật">
                <Columns>
                    <telerik:GridBoundColumn UniqueName="C_DATE" DataField="C_DATE" HeaderText="Thời gian" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy hh:mm:tt}">
                        <HeaderStyle HorizontalAlign="Center" Width="50px"/>
                        <ItemStyle HorizontalAlign="Center" Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="TRANGTHAINAME" DataField="TRANGTHAINAME" HeaderText="Trạng thái">
                        <HeaderStyle HorizontalAlign="Center" Width="70px"/>
                        <ItemStyle HorizontalAlign="Center" Width="70px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="C_DESC" DataField="C_DESC" HeaderText="Diễn giải">
                        <HeaderStyle HorizontalAlign="Center" Width="70px"/>
                        <ItemStyle HorizontalAlign="Center" Width="70px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </asp:Panel>