<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PriceCheckQT.ascx.cs" Inherits="ext_PriceCheckQT" %>
<telerik:RadCodeBlock ID="RadCodeBlockPriceCheckQT" runat="server">
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
        var cmbQuocGia;
        function OnClientLoadQuocGia(sender) {
            cmbQuocGia = sender;
        }
        function cmbQuocGiaClientSelectedIndexChangedHandler(sender, eventArgs) {
            $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("cmbQuocGia;" + eventArgs.get_item().get_value());
            var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelPriceCheckQT.ClientID %>");
            var currentUpdatedControl = "<%= pnPriceCheckQT.ClientID %>";
            currentLoadingPanel.show(currentUpdatedControl);
            return false;
        }
        var txtC_KHOILUONG;
        function OnClientLoadtxtC_KHOILUONG(sender) {
            txtC_KHOILUONG = sender;
        }
        function OnValueChangedtxtC_KHOILUONG(sender, eventArgs) {
            $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("txtC_KHOILUONG;" + eventArgs.get_newValue());
            var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelPriceCheckQT.ClientID %>");
            var currentUpdatedControl = "<%= pnPriceCheckQT.ClientID %>";
            currentLoadingPanel.show(currentUpdatedControl);
            return false;
        }
        var txtC_GIATRIHANGHOA;
        function OnClientLoadtxtC_GIATRIHANGHOA(sender) {
            txtC_GIATRIHANGHOA = sender;
        }
        function OnValueChangedtxtC_GIATRIHANGHOA(sender, eventArgs) {

            return false;
        }
        function cmbSanPhamClientSelectedIndexChangedHandler(sender, eventArgs) {
            $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("cmbSanPham;" + eventArgs.get_item().get_value());
            var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelPriceCheckQT.ClientID %>");
            var currentUpdatedControl = "<%= pnPriceCheckQT.ClientID %>";
            currentLoadingPanel.show(currentUpdatedControl);
            return false;
        }
        function cmbC_TAILIEUClientSelectedIndexChangedHandler(sender, eventArgs) {
            $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("cmbC_TAILIEU;" + eventArgs.get_item().get_value());
            var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelPriceCheckQT.ClientID %>");
            var currentUpdatedControl = "<%= pnPriceCheckQT.ClientID %>";
            currentLoadingPanel.show(currentUpdatedControl);
            return false;
        }
        var txtPPXD;
        var PPXD;
        function OnClientLoadtxtPPXD(sender) {
            txtPPXD = sender;
        }
        var txtC_GIACUOC;
        function OnClientLoadtxtC_GIACUOC(sender) {
            txtC_GIACUOC = sender;
        }
        var txtC_TIENHANG;
        function OnClientLoadtxtC_TIENHANG(sender) {
            txtC_TIENHANG = sender;
        }
        var txtC_TIENHANGVAT;
        function OnClientLoadtxtC_TIENHANGVAT(sender) {
            txtC_TIENHANGVAT = sender;
        }
        var txtC_DONGGOI;
        function OnClientLoadtxtC_DONGGOI(sender) {
            txtC_DONGGOI = sender;
        }
        var txtC_KHAIGIA;
        function OnClientLoadtxtC_KHAIGIA(sender) {
            txtC_KHAIGIA = sender;
        }
        var txtC_COD;
        function OnClientLoadtxtC_COD(sender) {
            txtC_COD = sender;
        }
        var txtC_BAOPHAT;
        function OnClientLoadtxtC_BAOPHAT(sender) {
            txtC_BAOPHAT = sender;
        }
        var txtC_HENGIO;
        function OnClientLoadtxtC_HENGIO(sender) {
            txtC_HENGIO = sender;
        }
        var txtC_TYGIA;
        function OnClientLoadtxtC_TYGIA(sender) {
            txtC_TYGIA = sender;
        }
        function OnValueChangedtxtC_TYGIA(sender, eventArgs) {
            //txtC_TIENHANGVATVND.set_value(txtC_TIENHANGVAT.get_value() * eventArgs.get_newValue());
            return false;
        }
        function OnValueChangedtxtC_GIACUOC(sender, eventArgs) {
            txtPPXD.set_value(txtC_GIACUOC.get_value() * parseFloat(PPXD) / 100);
            txtC_TIENHANG.set_value(txtC_GIACUOC.get_value() + txtPPXD.get_value() + txtC_BAOPHAT.get_value() + txtC_HENGIO.get_value() + txtC_COD.get_value() + txtC_KHAIGIA.get_value() + txtC_DONGGOI.get_value());
            return false;
        }
        function OnValueChangedtxtPPXD(sender, eventArgs) {
            txtC_TIENHANG.set_value(txtC_GIACUOC.get_value() + txtPPXD.get_value() + txtC_BAOPHAT.get_value() + txtC_HENGIO.get_value() + txtC_COD.get_value() + txtC_KHAIGIA.get_value() + txtC_DONGGOI.get_value());
            return false;
        }
        function OnValueChangedtxtC_DONGGOI(sender, eventArgs) {
            txtC_TIENHANG.set_value(txtC_GIACUOC.get_value() + txtPPXD.get_value() + txtC_BAOPHAT.get_value() + txtC_HENGIO.get_value() + txtC_COD.get_value() + txtC_KHAIGIA.get_value() + txtC_DONGGOI.get_value());
            return false;
        }
        function OnValueChangedtxtC_KHAIGIA(sender, eventArgs) {
            txtC_TIENHANG.set_value(txtC_GIACUOC.get_value() + txtPPXD.get_value() + txtC_BAOPHAT.get_value() + txtC_HENGIO.get_value() + txtC_COD.get_value() + txtC_KHAIGIA.get_value() + txtC_DONGGOI.get_value());
            return false;
        }
        function OnValueChangedtxtC_COD(sender, eventArgs) {
            txtC_TIENHANG.set_value(txtC_GIACUOC.get_value() + txtPPXD.get_value() + txtC_BAOPHAT.get_value() + txtC_HENGIO.get_value() + txtC_COD.get_value() + txtC_KHAIGIA.get_value() + txtC_DONGGOI.get_value());
            return false;
        }
        function OnValueChangedtxtC_BAOPHAT(sender, eventArgs) {
            txtC_TIENHANG.set_value(txtC_GIACUOC.get_value() + txtPPXD.get_value() + txtC_BAOPHAT.get_value() + txtC_COD.get_value() + txtC_KHAIGIA.get_value() + txtC_DONGGOI.get_value());
            return false;
        }
        function OnValueChangedtxtC_HENGIO(sender, eventArgs) {
            txtC_TIENHANG.set_value(txtC_GIACUOC.get_value() + txtPPXD.get_value() + txtC_BAOPHAT.get_value() + txtC_HENGIO.get_value() + txtC_COD.get_value() + txtC_KHAIGIA.get_value() + txtC_DONGGOI.get_value());
            return false;
        }
        function OnValueChangedtxtC_TIENHANG(sender, eventArgs) {
            txtC_TIENHANGVAT.set_value(txtC_TIENHANG.get_value() * 1.1);
            return false;
        }
        var isCOD = false;
        function SetC_COD() {
            isCOD = !isCOD;
            if (isCOD) {
                //txtC_COD.set_value(0);
            }
            else {
                txtC_COD.set_value(0);
            }
        }
        var isKHAIGIA = false;
        function SetC_KHAIGIA() {
            isKHAIGIA = !isKHAIGIA;
            if (isKHAIGIA) {
                txtC_KHAIGIA.set_value(Math.max(2.5, txtC_GIATRIHANGHOA.get_value() * 0.02));
            }
            else {
                txtC_KHAIGIA.set_value(0);
            }
        }
        var isHENGIO = false;
        function SetC_HENGIO() {
            isHENGIO = !isHENGIO;
            if (isHENGIO) {
                //txtC_HENGIO.set_value(0); 
            }
            else {
                txtC_HENGIO.set_value(0);
            }
        }
        var isBAOPHAT = false;
        function SetC_BAOPHAT() {
            isBAOPHAT = !isBAOPHAT;
            if (isBAOPHAT) {
                //txtC_BAOPHAT.set_value(0); 
            }
            else {
                txtC_BAOPHAT.set_value(0);
            }
        }
        var isDONGGOI = false;
        function SetC_DONGGOI() {
            isDONGGOI = !isDONGGOI;
            if (isDONGGOI) {
                //txtC_DONGGOI.set_value(0); 
            }
            else {
                txtC_DONGGOI.set_value(0);
            }
        }
        function cmbC_TAILIEUClientSelectedIndexChangedHandler(sender, eventArgs) {
            $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("cmbC_TAILIEU;" + eventArgs.get_item().get_value());
            var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelPriceCheckQT.ClientID %>");
            var currentUpdatedControl = "<%= pnPriceCheckQT.ClientID %>";
            currentLoadingPanel.show(currentUpdatedControl);
            return false;
        }
    </script>
    <script type="text/javascript">
        function onResponseEndNG() {
            if (typeof (result) != "undefined" && result && result != "") {
                //alert(result);
                var arrayOfStrings = result.split(",-,");
                if (arrayOfStrings[0] != "msg") {
                    PPXD = arrayOfStrings[1];
                    txtC_GIACUOC.set_value(arrayOfStrings[2]);
                }
                else {
                    alert(arrayOfStrings[1]);
                }
                var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelPriceCheckQT.ClientID %>");
                var currentUpdatedControl = "<%= pnPriceCheckQT.ClientID %>";
                currentLoadingPanel.hide(currentUpdatedControl);
                result = "";
            }
            return false;
        }
    </script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelPriceCheckQT" runat="server" />
<center>
    <h1>
        Tính giá gửi hàng quốc tế</h1>
    <asp:Panel ID="pnPriceCheckQT" runat="server">
        <table class="table1">
            <tfoot>
                <tr>
                    <th scope="row">
                        Giá cước
                    </th>
                    <td>
                         <telerik:RadNumericTextBox  ID="txtC_TIENHANG" Width ="90%" Runat="server" ClientEvents-OnLoad="OnClientLoadtxtC_TIENHANG" ClientEvents-OnValueChanged="OnValueChangedtxtC_TIENHANG">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox> 
                    </td>
                    <th scope="row">
                        Giá cước (VAT)
                    </th>
                    <td>
                        <telerik:RadNumericTextBox  ID="txtC_TIENHANGVAT" Width ="90%" Runat="server" ClientEvents-OnLoad="OnClientLoadtxtC_TIENHANGVAT">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                    </td>
                </tr>
            </tfoot>
            <tbody>
            <tr>
                    <th scope="row">
                        Khu vực gửi hàng
                    </th>
                     <td>
                     <telerik:RadComboBox ID="cmbVungLamViec" DataTextField="C_NAME" 
                               DataValueField="C_CODE" DataSourceID="VUNGLAMVIECDataSource"
                           ShowToggleImage="True" runat="server" EmptyMessage="Chọn vùng làm việc" 
                               nprerender="cmbVungLamViec_PreRender" 
                               onprerender="cmbVungLamViec_PreRender"></telerik:RadComboBox>
                       </td>
                       <th scope="row">
                        Tỷ giá
                    </th>
                     <td>
                    <telerik:RadNumericTextBox ID="txtC_TYGIA" Width ="90%" runat="server" ClientEvents-OnValueChanged="OnValueChangedtxtC_TYGIA" ClientEvents-OnLoad="OnClientLoadtxtC_TYGIA">
                        <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                       </td>
                </tr>
                <tr>
                    <th scope="row">
                        Quốc gia
                    </th>
                    <td>
                        <telerik:RadComboBox ID="cmbQuocGia" runat="server" DataTextField="C_NAME" DataValueField="C_CODE" DataSourceID="QUOCGIADataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn quốc gia" 
                    onclientload="OnClientLoadQuocGia" 
                    onclientselectedindexchanged="cmbQuocGiaClientSelectedIndexChangedHandler">
                    </telerik:RadComboBox>
                    </td>
                    <th scope="row">
                        Loại hàng hoá
                    </th>
                    <td>
                       <telerik:RadComboBox ID="cmbC_TAILIEU" runat="server" EmptyMessage="Chọn" onclientselectedindexchanged="cmbC_TAILIEUClientSelectedIndexChangedHandler">
                            <Items>
                                <telerik:RadComboBoxItem Value ="Tài liệu" Text ="Tài liệu" />
                                <telerik:RadComboBoxItem Value ="Không phải tài liệu" Text ="Không phải tài liệu" />
                            </Items>
                 </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        Khối lượng (g)
                    </th>
                    <td>
                        <telerik:RadNumericTextBox ID="txtC_KHOILUONG" Width="90%" runat="server" ClientEvents-OnValueChanged="OnValueChangedtxtC_KHOILUONG"
                            ClientEvents-OnLoad="OnClientLoadtxtC_KHOILUONG">
                            <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="0" />
                        </telerik:RadNumericTextBox>
                    </td>
                    <th scope="row">
                        Giá trị hàng hoá
                    </th>
                    <td>
                        <telerik:RadNumericTextBox ID="txtC_GIATRIHANGHOA" Width="90%" runat="server" ClientEvents-OnLoad="OnClientLoadtxtC_GIATRIHANGHOA"
                            ClientEvents-OnValueChanged="OnValueChangedtxtC_GIATRIHANGHOA">
                            <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="0" />
                        </telerik:RadNumericTextBox>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        Dịch vụ
                    </th>
                    <td>
                        <telerik:RadComboBox ID="cmbSanPham" runat="server" DataTextField="C_NAME" DataValueField="PK_ID"
                            DataSourceID="MASANPHAMDataSource" ShowToggleImage="True" EmptyMessage="Chọn dịch vụ"
                            OnClientSelectedIndexChanged="cmbSanPhamClientSelectedIndexChangedHandler">
                        </telerik:RadComboBox>
                    </td>
                    <th scope="row">
                        Cước chính
                    </th>
                    <td>
                        <telerik:RadNumericTextBox ID="txtC_GIACUOC" Width="90%" runat="server" ClientEvents-OnLoad="OnClientLoadtxtC_GIACUOC"
                            ClientEvents-OnValueChanged="OnValueChangedtxtC_GIACUOC">
                            <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="0" />
                        </telerik:RadNumericTextBox>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        PPXD
                    </th>
                    <td>
                        <telerik:RadNumericTextBox ID="txtPPXD" Width="90%" runat="server" ClientEvents-OnLoad="OnClientLoadtxtPPXD"
                            ClientEvents-OnValueChanged="OnValueChangedtxtPPXD">
                            <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="0" />
                        </telerik:RadNumericTextBox>
                    </td>
                    <th scope="row">
                        <input id="btnC_DONGGOI" type="checkbox" onclick="SetC_DONGGOI();" value="false" />Đóng
                        gói
                    </th>
                    <td>
                        <telerik:RadNumericTextBox ID="txtC_DONGGOI" Width="90%" runat="server" ClientEvents-OnLoad="OnClientLoadtxtC_DONGGOI"
                            ClientEvents-OnValueChanged="OnValueChangedtxtC_DONGGOI">
                            <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="0" />
                        </telerik:RadNumericTextBox>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        <input id="btnC_KHAIGIA" type="checkbox" onclick="SetC_KHAIGIA();" value="false" />Khai
                        giá
                    </th>
                    <td>
                        <telerik:RadNumericTextBox ID="txtC_KHAIGIA" Width="90%" runat="server" ClientEvents-OnLoad="OnClientLoadtxtC_KHAIGIA"
                            ClientEvents-OnValueChanged="OnValueChangedtxtC_KHAIGIA">
                            <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="0" />
                        </telerik:RadNumericTextBox>
                    </td>
                    <th scope="row">
                        <input id="btnC_COD" type="checkbox" onclick="SetC_COD();" value="false" />Hun trùng
                    </th>
                    <td>
                        <telerik:RadNumericTextBox ID="txtC_COD" Width="90%" runat="server" ClientEvents-OnLoad="OnClientLoadtxtC_COD"
                            ClientEvents-OnValueChanged="OnValueChangedtxtC_COD">
                            <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="0" />
                        </telerik:RadNumericTextBox>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        <input id="btnC_BAOPHAT" type="checkbox" onclick="SetC_BAOPHAT();" value="false" />Hải quan
                    </th>
                    <td>
                        <telerik:RadNumericTextBox ID="txtC_BAOPHAT" Width="90%" runat="server" ClientEvents-OnLoad="OnClientLoadtxtC_BAOPHAT"
                            ClientEvents-OnValueChanged="OnValueChangedtxtC_BAOPHAT">
                            <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="0" />
                        </telerik:RadNumericTextBox>
                    </td>
                    <th scope="row">
                        <input id="btnC_HENGIO" type="checkbox" onclick="SetC_HENGIO();" value="false" />Hẹn giờ
                    </th>
                    <td>
                        <telerik:RadNumericTextBox ID="txtC_HENGIO" Width="90%" runat="server" ClientEvents-OnLoad="OnClientLoadtxtC_HENGIO"
                            ClientEvents-OnValueChanged="OnValueChangedtxtC_HENGIO">
                            <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="0" />
                        </telerik:RadNumericTextBox>
                    </td>
                </tr>
            </tbody>
        </table>
    </asp:Panel>
</center>
<asp:SqlDataSource ID="MASANPHAMDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
  SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMMASANPHAM]  WHERE C_TYPE = N'Quốc tế' ORDER BY PK_ID">
</asp:SqlDataSource>
<asp:SqlDataSource ID="MAVUNGDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>">
</asp:SqlDataSource>
 <asp:SqlDataSource ID="QUOCGIADataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [DMQUOCGIA].[PK_ID], [DMQUOCGIA].[C_CODE], [DMQUOCGIA].[C_NAME] FROM [DMQUOCGIA]">
 </asp:SqlDataSource>
 <asp:SqlDataSource ID="VUNGLAMVIECDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
 SelectCommand="SELECT DMVUNGLAMVIEC.* FROM DMVUNGLAMVIEC" >
</asp:SqlDataSource>

