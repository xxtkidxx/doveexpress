<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BAOCAODOITACPOPUP.ascx.cs"
    Inherits="module_BAOCAODOITACPOPUP" %>
<telerik:RadCodeBlock ID="RadCodeBlockBAOCAODOITACPOPUP" runat="server">
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
            var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelBAOCAODOITACPOPUP.ClientID %>");
            var currentUpdatedControl = "<%= RadAjaxPanelBAOCAODOITACPOPUP.ClientID %>";
            currentLoadingPanel.show(currentUpdatedControl);
            return false;
        }
        function onResponseEndNGPU() {
            if (typeof (result) != "undefined" && result && result != "") {
                alert(result);
            }
            var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelBAOCAODOITACPOPUP.ClientID %>");
            var currentUpdatedControl = "<%= RadAjaxPanelBAOCAODOITACPOPUP.ClientID %>";
            currentLoadingPanel.hide(currentUpdatedControl);
            result = "";
            CloseWindows();
            return false;
        }
    </script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelBAOCAODOITACPOPUP"
    runat="server" />
<telerik:RadAjaxPanel ID="RadAjaxPanelBAOCAODOITACPOPUP" runat="server">
    <div class="headerthongtin">
        <ul>
            <li class="lifirst">
                <asp:LinkButton ID="btnSave" runat="server" OnClientClick="SaveInfo();return false;"><img src="Images/img_save.jpg" />Lưu</asp:LinkButton></li>
            <li>
                <asp:LinkButton ID="btnClose" runat="server" OnClientClick="CloseWindows();return false;"><img src="Images/img_Close.jpg" />Đóng</asp:LinkButton></li>
        </ul>
    </div>
    <div class="clearfix bgpopup">
        <div style="width: 865px; height: 90px; background: #FFFFFF" class="clearfix">
            <table id="tblEdit" class="TableEditInGrid" cellspacing="3" cellpadding="3" style="width: 100%"
                border="0">
                <tr>
                    <asp:HiddenField ID="txtID" Value='' runat="server" />
                    <td style="width: 100px;">
                        <span class="rtsTxtnew">Đối tác:</span>
                    </td>
                    <td colspan="4">
                        <telerik:RadComboBox ID="cmbDoiTac" runat="server" Width="150px" DataTextField="C_NAME"
                            DataValueField="PK_ID" DataSourceID="DoiTacDataSource" ShowToggleImage="True"
                            EmptyMessage="Chọn đối tác">
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 100px;">
                        <span class="rtsTxtnew">Giá đối tác:</span>
                    </td>
                    <td colspan="4">
                        <telerik:RadNumericTextBox ID="txtC_GIADOITAC" Width="90%" runat="server">
                            <NumberFormat DecimalSeparator="." GroupSeparator=" " DecimalDigits="0" />
                        </telerik:RadNumericTextBox>
                    </td>
                </tr>
            </table>
        </div>
        <div class="headerthongtin">
        </div>
        <!-- end bgpopup-->
    </div>
</telerik:RadAjaxPanel>
<asp:SqlDataSource ID="DoiTacDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMDoiTac] WHERE [DMDOITAC].FK_VUNGLAMVIEC = @FK_VUNGLAMVIEC ORDER BY LTRIM([C_CODE])">
    <SelectParameters>
        <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
    </SelectParameters>
</asp:SqlDataSource>
