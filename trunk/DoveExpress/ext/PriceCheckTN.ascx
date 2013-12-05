<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PriceCheckTN.ascx.cs"
    Inherits="ext_PriceCheckTN" %>
<telerik:RadCodeBlock ID="RadCodeBlockPriceCheckTN" runat="server">
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
            font-size: 40px;
            text-shadow: 1px 1px 1px #aaa;
            padding-top: 30px;
        }
        /* Table 1 Style */
        table.table1
        {
            font-family: "Trebuchet MS" , sans-serif;
            font-size: 16px;
            font-weight: bold;
            line-height: 1.4em;
            font-style: normal;
            border-collapse: separate;
            padding-top: 30px;
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
            font-size: 32px;
            text-align: center;
            padding: 10px 0px;
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
    <script type="text/javascript">
        var cmbQuanHuyen;
        function OnClientLoadQuanHuyen(sender) {
            cmbQuanHuyen = sender;
        }
        function cmbTinhThanhClientSelectedIndexChangedHandler(sender, eventArgs) {
            cmbQuanHuyen.requestItems(eventArgs.get_item().get_value(), false);
        }
        function ItemsLoadedQuanHuyen(combo, eventArqs) {
            if (combo.get_items().get_count() > 0) {
                combo.trackChanges();
                combo.get_items().getItem(0).select();
                combo.updateClientState();
                combo.commitChanges();
            } else {
                combo.set_text("");
            }
        }
        function cmbQuanHuyenClientSelectedIndexChangedHandler(sender, eventArgs) {
            $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("cmbQuanHuyen;" + eventArgs.get_item().get_value());
            var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelPriceCheckTN.ClientID %>");
            var currentUpdatedControl = "<%= pnPriceCheckTN.ClientID %>";
            currentLoadingPanel.show(currentUpdatedControl);
            return false;
        }
    </script>
    <script type="text/javascript">
        function onResponseEndNG() {
            if (typeof (result) != "undefined" && result && result != "") {
                alert(result);
            }
            var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelPriceCheckTN.ClientID %>");
            var currentUpdatedControl = "<%= pnPriceCheckTN.ClientID %>";
            currentLoadingPanel.hide(currentUpdatedControl);
            result = "";
            return false;
        }
    </script>
</telerik:RadCodeBlock>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxyPriceCheckTN" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="pnPriceCheckTN">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="pnPriceCheckTN" LoadingPanelID="RadAjaxLoadingPanelPriceCheckTN">
                </telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelPriceCheckTN" runat="server" />
<center>
    <h1>
        Tính giá gửi hàng trong nước</h1>
    <asp:Panel ID="pnPriceCheckTN" runat="server">
        <table class="table1">
            <tfoot>
                <tr>
                    <th scope="row">
                        Giá cước
                    </th>
                    <td>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        Giá cước (VAT)
                    </th>
                    <td>
                    </td>
                </tr>
            </tfoot>
            <tbody>
                <tr>
                    <th scope="row">
                        Tỉnh thành
                    </th>
                    <td>
                        <telerik:RadComboBox ID="cmbTinhThanh" runat="server" DataTextField="C_NAME" DataValueField="PK_ID"
                            DataSourceID="TINHTHANHDataSource" ShowToggleImage="True" EmptyMessage="Chọn tỉnh"
                            OnClientSelectedIndexChanged="cmbTinhThanhClientSelectedIndexChangedHandler">
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        Quận huyện
                    </th>
                    <td>
                        <telerik:RadComboBox ID="cmbQuanHuyen" runat="server" DataTextField="C_NAME" DataValueField="C_CODE"
                            DataSourceID="QUANHUYENDataSource" ShowToggleImage="True" EmptyMessage="Chọn quận huyện"
                            OnClientItemsRequested="ItemsLoadedQuanHuyen" OnClientLoad="OnClientLoadQuanHuyen"
                            OnItemsRequested="cmbQuanHuyen_ItemsRequested" OnClientSelectedIndexChanged="cmbQuanHuyenClientSelectedIndexChangedHandler">
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        Người gửi
                    </th>
                    <td>
                        <asp:Label ID="lblNguoigui" runat="server" Text="-"></asp:Label>
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
                        Người nhận
                    </th>
                    <td>
                        <asp:Label ID="lblNguoinhan" runat="server" Text="-"></asp:Label>
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
                        Ngày nhận
                    </th>
                    <td>
                        <asp:Label ID="lblNgaynhan" runat="server" Text="-"></asp:Label>
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
    </asp:Panel>
</center>
<asp:SqlDataSource ID="MASANPHAMDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMMASANPHAM]  WHERE C_TYPE = N'Trong nước' ORDER BY PK_ID">
</asp:SqlDataSource>
<asp:SqlDataSource ID="MAVUNGDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>">
</asp:SqlDataSource>
<asp:SqlDataSource ID="TINHTHANHDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [DMTINHTHANH].[PK_ID], [DMTINHTHANH].[C_CODE], [DMTINHTHANH].[C_NAME] FROM [DMTINHTHANH] LEFT OUTER JOIN DMQUOCGIA ON DMTINHTHANH.FK_QUOCGIA = DMQUOCGIA.PK_ID WHERE DMQUOCGIA.C_CODE='VN' ORDER BY DMTINHTHANH.C_ORDER ASC, DMTINHTHANH.C_NAME ASC">
</asp:SqlDataSource>
<asp:SqlDataSource ID="QUANHUYENDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>">
</asp:SqlDataSource>
