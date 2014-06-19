<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NHANGUIBILLEDIT.ascx.cs"
    Inherits="module_NHANGUIBILLEDIT" %>
<telerik:RadCodeBlock ID="RadCodeBlockNHANGUIPH" runat="server">
    <script type="text/javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function CloseWindows() {
            GetRadWindow().close();
        }

        function CloseWindowsWithArg() {
            var customArg = $get("txtValue").value;
            GetRadWindow().close(customArg);
        }
    </script>
    <script type="text/javascript">
        function SaveInfo(sender, eventArgs) {
            checkKH = true;
            $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("Save;");
            var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelNHANGUIBILLEDIT.ClientID %>");
            var currentUpdatedControl = "<%= RadAjaxPanelNHANGUIBILLEDIT.ClientID %>";
            currentLoadingPanel.show(currentUpdatedControl);
            return false;
        }
        function onResponseEndNGPU() {
            if (typeof (result) != "undefined" && result && result != "") {
                alert(result);
            }
            var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelNHANGUIBILLEDIT.ClientID %>");
            var currentUpdatedControl = "<%= RadAjaxPanelNHANGUIBILLEDIT.ClientID %>";
            currentLoadingPanel.hide(currentUpdatedControl);
            result = "";
            //CloseWindows();
            return false;
        }
        function OnKeyPressRadTextBox(sender, eventArgs) {
            var charCode = eventArgs.get_keyCode();
            if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
                eventArgs.set_cancel(true);
            }
            return false;
        }
    </script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelNHANGUIBILLEDIT" runat="server" />
<telerik:RadAjaxPanel ID="RadAjaxPanelNHANGUIBILLEDIT" runat="server">
    <div class="headerthongtin">
        <ul>
            <li class="lifirst">
                <asp:LinkButton ID="btnSave" runat="server" OnClientClick="SaveInfo();return false;"><img src="Images/img_save.jpg" />Lưu</asp:LinkButton></li>
            <li>
                <asp:LinkButton ID="btnClose" runat="server" OnClientClick="CloseWindows();return false;" Visible="false"><img src="Images/img_Close.jpg" />Đóng</asp:LinkButton></li>
        </ul>
    </div>
    <div class="clearfix bgpopup">
        <div style="width: 400px; height: 70px; background: #FFFFFF" class="clearfix">
            <table id="tblEdit" class="TableEditInGrid" cellspacing="3" cellpadding="3" style="width: 100%"
                border="0">
                <tr>
                    <td style="width: 100px;">
                        <span class="rtsTxtnew">Số Bill cũ:</span>
                    </td>
                    <td colspan="12">
                        <telerik:RadTextBox ID="txtC_BILLOLD" Width="90%" Text="" runat="server" MaxLength="7">
                            <ClientEvents OnKeyPress="OnKeyPressRadTextBox" />
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px;">
                        <span class="rtsTxtnew">Số Bill mới:</span>
                    </td>
                    <td colspan="12">
                        <telerik:RadTextBox ID="txtC_BILLNEW" Width="90%" Text="" runat="server" MaxLength="7">
                            <ClientEvents OnKeyPress="OnKeyPressRadTextBox" />
                        </telerik:RadTextBox>
                    </td>
                </tr>
            </table>
        </div>
        <div class="headerthongtin">
        </div>
        <!-- end bgpopup-->
    </div>
</telerik:RadAjaxPanel>
