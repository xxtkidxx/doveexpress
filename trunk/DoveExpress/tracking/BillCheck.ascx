<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BillCheck.ascx.cs" Inherits="ext_BillCheck" %>
<style type="text/css">
    *
    {
        margin: 0;
        padding: 0;
    }
    body
    {
        font-family: Georgia, serif;
        font-size: 20px;
        font-style: italic;
        font-weight: normal;
        letter-spacing: normal;
        background: #f0f0f0;
    }
    .head
    {
        font-family: Helvetica,Arial,Verdana;
        text-transform: uppercase;
        font-weight: bold;
        font-size: 12px;
        font-style: normal;
        letter-spacing: 3px;
        color: #888;
        border-bottom: 3px solid #f0f0f0;
        padding-bottom: 10px;
        margin-bottom: 10px;
    }
    .head a
    {
        color: #1D81B6;
        text-decoration: none;
        float: right;
        text-shadow: 1px 1px 1px #888;
    }
    .head a:hover
    {
        color: #f0f0f0;
    }
    h1
    {
        font-family: "Trebuchet MS" ,sans-serif;
        color: #9CD009;
        font-weight: normal;
        font-style: normal;
        font-size: 36px;
        text-shadow: 1px 1px 1px #aaa;
        padding-top: 20px;
    }
    /* Table 1 Style */
    table.table1
    {
        font-family: "Trebuchet MS" , sans-serif;
        font-size: 16px;
        font-weight: bold;
        line-height: 1em;
        font-style: normal;
        border-collapse: separate;
        padding-top: 20px;
    }
    .table1 thead th
    {
        padding: 15px;
        color: #fff;
        text-shadow: 1px 1px 1px #568F23;
        border: 1px solid #93CE37;
        border-bottom: 3px solid #9ED929;
        background-color: #9DD929;
        background: -webkit-gradient(
        linear,
        left bottom,
        left top,
        color-stop(0.02, rgb(123,192,67)),
        color-stop(0.51, rgb(139,198,66)),
        color-stop(0.87, rgb(158,217,41))
        );
        background: -moz-linear-gradient(
        center bottom,
        rgb(123,192,67) 2%,
        rgb(139,198,66) 51%,
        rgb(158,217,41) 87%
        );
        -webkit-border-top-left-radius: 5px;
        -webkit-border-top-right-radius: 5px;
        -moz-border-radius: 5px 5px 0px 0px;
        border-top-left-radius: 5px;
        border-top-right-radius: 5px;
    }
    .table1 thead th:empty
    {
        background: transparent;
        border: none;
    }
    .table1 tbody th
    {
        color: #fff;
        text-shadow: 1px 1px 1px #568F23;
        background-color: #9DD929;
        border: 1px solid #93CE37;
        border-right: 3px solid #9ED929;
        padding: 0px 10px;
        background: -webkit-gradient(
        linear,
        left bottom,
        right top,
        color-stop(0.02, rgb(158,217,41)),
        color-stop(0.51, rgb(139,198,66)),
        color-stop(0.87, rgb(123,192,67))
        );
        background: -moz-linear-gradient(
        left bottom,
        rgb(158,217,41) 2%,
        rgb(139,198,66) 51%,
        rgb(123,192,67) 87%
        );
        -moz-border-radius: 5px 0px 0px 5px;
        -webkit-border-top-left-radius: 5px;
        -webkit-border-bottom-left-radius: 5px;
        border-top-left-radius: 5px;
        border-bottom-left-radius: 5px;
    }
    .table1 tfoot td
    {
        color: #9CD009;
        font-size: 26px;
        text-align: center;
        padding: 8px 0px;
        text-shadow: 1px 1px 1px #444;
    }
    .table1 tfoot th
    {
        color: #FF0000;
    }
    .table1 tbody td
    {
        padding: 10px;
        text-align: center;
        background-color: #DEF3CA;
        border: 2px solid #E7EFE0;
        -moz-border-radius: 2px;
        -webkit-border-radius: 2px;
        border-radius: 2px;
        color: #666;
        text-shadow: 1px 1px 1px #fff;
    }
    .table1 tbody span.check::before
    {
        content: url(../images/check0.png);
    }
</style>
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
<center>
    <h1>
        CHUYỂN PHÁT NHANH DOVEEXPRESS - KIỂM TRA TRẠNG THÁI BILL</h1>
    <asp:Panel ID="pnCheckBill" runat="server">
        <table class="table1">
            <tfoot>
                <tr>
                    <th scope="row">
                        TRẠNG THÁI
                    </th>
                    <td>
                        <asp:Label ID="lblC_STATUS" runat="server" Text="-"></asp:Label>
                    </td>
                </tr>
            </tfoot>
            <tbody>
                <tr>
                    <th scope="row">
                        Mã BILL
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
                        Địa chỉ nhận
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
</center>
