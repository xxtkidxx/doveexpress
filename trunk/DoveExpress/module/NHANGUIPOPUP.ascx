<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NHANGUIPOPUP.ascx.cs"
    Inherits="module_NHANGUIPOPUP" %>
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
            var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelNHANGUIPOPUP.ClientID %>");
            var currentUpdatedControl = "<%= RadAjaxPanelNHANGUIPOPUP.ClientID %>";
            currentLoadingPanel.show(currentUpdatedControl);
            return false;
        }
        function onResponseEndNGPU() {
            if (typeof (result) != "undefined" && result && result != "") {
                alert(result);
            }
            var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelNHANGUIPOPUP.ClientID %>");
            var currentUpdatedControl = "<%= RadAjaxPanelNHANGUIPOPUP.ClientID %>";
            currentLoadingPanel.hide(currentUpdatedControl);
            result = "";
            CloseWindows();
            return false;
        }
    </script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelNHANGUIPOPUP" runat="server" />
<telerik:RadAjaxPanel ID="RadAjaxPanelNHANGUIPOPUP" runat="server">
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
                    <td style="width: 100px;">
                        <span class="rtsTxtnew">Ngày giờ:</span>
                    </td>
                    <td colspan="4">
                        <telerik:RadDateTimePicker ID="radC_NGAYGIOPHAT" Width="95%" runat="server" AutoPostBack="false">
                            <DateInput ID="DateInput2" runat="server" DateFormat="dd/MM/yyyy HH:mm" MinDate="1/1/1890 00:00">
                                <ClientEvents OnKeyPress="controlkeypress" />
                            </DateInput>
                        </telerik:RadDateTimePicker>
                    </td>
                    <td style="width: 100px;">
                        <span class="rtsTxtnew">Trạng thái:</span>
                    </td>
                    <td colspan="4">
                        <telerik:RadComboBox ID="cmbFK_TRANGTHAI" runat="server" DataTextField="C_NAME" DataValueField="C_CODE"
                            DataSourceID="FK_TRANGTHAIDataSource" ShowToggleImage="True" EmptyMessage="Chọn">
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px;">
                        <span class="rtsTxtnew">Diễn giải:</span>
                    </td>
                    <td colspan="12">
                        <telerik:RadTextBox ID="txtC_DESC" Width="90%" Text="" runat="server">
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
<asp:SqlDataSource ID="UserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT USERS.PK_ID,USERS.FK_GroupUser,USERS.FK_DEPT,USERS.C_LoginName,USERS.C_Password,USERS.C_NAME,USERS.C_Address,USERS.c_Tel,USERS.C_Email,USERS.C_DESC,GROUPUSER.C_NAME AS GROUPUSERNAME FROM USERS INNER JOIN GROUPUSER ON  USERS.FK_GROUPUSER = GROUPUSER.PK_ID WHERE FK_GROUPUSER NOT IN (0,1) AND (FK_VUNGLAMVIEC = N'Tất cả' OR FK_VUNGLAMVIEC = @FK_VUNGLAMVIEC)">
    <SelectParameters>
        <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="FK_TRANGTHAIDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMTRANGTHAI]"></asp:SqlDataSource>
