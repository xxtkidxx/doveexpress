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
</telerik:RadCodeBlock>
<div class="headerthongtin">
    <ul>
        <li class="lifirst">
            <asp:LinkButton ID="btnSave" runat="server"><img src="Images/img_save.jpg" />Lưu</asp:LinkButton></li>
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
                    <span class="rtsTxtnew">Nhân viên phát:</span>
                </td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbFK_NHANVIENPHAT" runat="server" DataTextField="C_NAME"
                        DataValueField="PK_ID" DataSourceID="UserDataSource" ShowToggleImage="True" EmptyMessage="Chọn">
                    </telerik:RadComboBox>
                </td>
                <td style="width: 100px;">
                    <span class="rtsTxtnew">Ngày giờ phát:</span>
                </td>
                <td colspan="4">
                    <telerik:RadDateTimePicker ID="radC_NGAYGIOPHAT" Width="95%" runat="server" AutoPostBack="false">
                        <DateInput ID="DateInput2" runat="server" DateFormat="dd/MM/yyyy hh:mm tt" MinDate="1/1/1890 12:00:00 AM">
                            <ClientEvents OnKeyPress="controlkeypress" />
                        </DateInput>
                    </telerik:RadDateTimePicker>
                </td>
                <td style="width: 100px;">
                    <span class="rtsTxtnew">Nhân viên KT:</span>
                </td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbFK_NHANVIENKHAITHAC" runat="server" DataTextField="C_NAME"
                        DataValueField="PK_ID" DataSourceID="UserDataSource" ShowToggleImage="True" EmptyMessage="Chọn">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="width: 100px;">
                    <span class="rtsTxtnew">Người ký nhận:</span>
                </td>
                <td colspan="4">
                    <telerik:RadTextBox ID="txtC_NGUOIKYNHAN" Width="90%" Text="" runat="server">
                    </telerik:RadTextBox>
                </td>
                <td style="width: 100px;">
                    <span class="rtsTxtnew">Bộ phận:</span>
                </td>
                <td colspan="4">
                    <telerik:RadTextBox ID="txtC_BOPHAN" Width="90%" Text="" runat="server">
                    </telerik:RadTextBox>
                </td>
                <td style="width: 100px;">
                    <span class="rtsTxtnew">Trạng thái:</span>
                </td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbFK_TRANGTHAI" runat="server" DataTextField="C_NAME" DataValueField="C_NAME"
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
<asp:SqlDataSource ID="UserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT USERS.PK_ID,USERS.FK_GroupUser,USERS.FK_DEPT,USERS.C_LoginName,USERS.C_Password,USERS.C_NAME,USERS.C_Address,USERS.c_Tel,USERS.C_Email,USERS.C_DESC,GROUPUSER.C_NAME AS GROUPUSERNAME FROM USERS INNER JOIN GROUPUSER ON  USERS.FK_GROUPUSER = GROUPUSER.PK_ID WHERE FK_GROUPUSER NOT IN (0,1)">
</asp:SqlDataSource>
<asp:SqlDataSource ID="FK_TRANGTHAIDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMTRANGTHAI]"></asp:SqlDataSource>
