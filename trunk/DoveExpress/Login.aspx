<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<%@ Register Namespace="ITCLIB.Security" TagPrefix="Office" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>PHẦN MỀM QUẢN LÝ CHUYỂN PHÁT NHANH DOVE EXPRESS</title>
    <link href="css/login.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="js/jquery.corner.js" type="text/javascript"></script>
    <script type="text/javascript">
        // test auto-ready logic - call corner before DOM is ready
        $(function () {
            $('.login').corner();
            $('.myCorner').corner();
        });
    </script>
</head>
<body style="background: #c4c4c4">
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager" runat="server">
    </telerik:RadScriptManager>
    <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>
    <div id="divlayout">
        <div id="divheader" class="clearfix">
        </div>
        <div id="divcontent" class="clearfix">
            <img alt="" src="images/imt_login_up.png" class="imgbgcontent" />
            <div id="divnoidungthaydoi" class="clearfix">
                <table border="0">
                    <tr>
                        <td style="width: 300px">
                        </td>
                        <td style="width: 100px">
                            <span class="rtsTxtnew"><strong>Tên đăng nhập</strong> </span>
                        </td>
                        <td>
                            <span class="txtleft">
                                <asp:TextBox ID="txtUser" Width="200px" runat="server" Height="15px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvUser" runat="server" ErrorMessage="Bạn chưa nhập tên đăng nhập"
                                    ControlToValidate="txtUser" ValidationGroup="G1" Display="Dynamic">*</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="regUser" ControlToValidate="txtUser" ValidationExpression="^([\u0080-\ua7ffa-zA-Z0-9'\s])+$"
                                    Display="Dynamic" ErrorMessage="Không thể nhập kí tự đặc biệt" ValidationGroup="G1"
                                    runat="server"></asp:RegularExpressionValidator>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <span class="rtsTxtnew"><strong>Mật khẩu</strong> </span>
                        </td>
                        <td>
                            <span class="txtleft">
                                <asp:TextBox ID="txtPass" Width="200px" TextMode="Password" runat="server" Height="15px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPass" runat="server" ErrorMessage="Bạn chưa nhập mật khẩu"
                                    ControlToValidate="txtPass" ValidationGroup="G1" Display="Dynamic">*</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="regPass" ControlToValidate="txtPass" ValidationExpression="^([\u0080-\ua7ffa-zA-Z0-9'\s])+$"
                                    Display="Dynamic" ErrorMessage="Không thể nhập kí tự đặc biệt" ValidationGroup="G1"
                                    runat="server"></asp:RegularExpressionValidator>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <span class="rtsTxtnew"><strong>Vùng làm việc</strong> </span>
                        </td>
                        <td>
                            <span class="txtleft">
                                <telerik:RadComboBox ID="cmbVungLamViec" DataTextField="C_NAME" DataValueField="C_CODE"
                                    DataSourceID="VUNGLAMVIECDataSource" ShowToggleImage="True" runat="server" EmptyMessage="Chọn vùng làm việc"
                                    OnPreRender="cmbVungLamViec_PreRender">
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="rfvVungLamViec" runat="server" ErrorMessage="Bạn chưa chọn vùng làm việc"
                                    ControlToValidate="cmbVungLamViec" ValidationGroup="G1" Display="Dynamic">*</asp:RequiredFieldValidator>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                            <br />
                            <asp:Button ID="btnLogin" CssClass="btLogin" ValidationGroup="G1" runat="server"
                                Text="Đăng nhập" OnClick="btnLogin_Click" />
                            <input id="btnCancel" type="reset" class="btLogin" value="Nhập lại" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="text-align: center">
                            <br />
                            <asp:LinkButton ID="lbtnForgotPass" runat="server" CssClass="Link" ForeColor="White"
                                OnClick="lbtnForgotPass_Click" Font-Size="12px">Quên mật khẩu</asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td colspan="2" style="text-align: center">
                            <br />
                            <asp:Panel ID="pnForgotPass" runat="server" Height="28px" Width="258px" Visible="False">
                                Email :
                                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                                    ErrorMessage="Bạn chưa nhập email" SetFocusOnError="True" ValidationGroup="G2"
                                    Display="Dynamic">*</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                                    ErrorMessage="Email bạn nhập không đúng định dạng" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                    ValidationGroup="G2" Display="Dynamic">*</asp:RegularExpressionValidator>
                                <asp:CustomValidator ID="cvEmail" ControlToValidate="txtEmail" OnServerValidate="CheckEmail"
                                    runat="server" ErrorMessage="Email không hợp lệ với tên đăng nhập" ValidationGroup="G2"
                                    Display="Dynamic">Email không hợp lệ với tên đăng nhập</asp:CustomValidator>
                                <asp:Button ID="btnForgotPass" ValidationGroup="G2" runat="server" Text="Gửi" OnClick="btnForgotPass_Click" />
                            </asp:Panel>
                            <asp:ValidationSummary ID="vsLogin" ValidationGroup="G1" ShowSummary="false" HeaderText="Vui lòng kiểm tra lại :"
                                runat="server" ShowMessageBox="True" />
                            <asp:ValidationSummary ID="vsForgotPass" ValidationGroup="G2" ShowSummary="false"
                                HeaderText="Vui lòng kiểm tra lại :" runat="server" ShowMessageBox="True" />
                        </td>
                    </tr>
                </table>
            </div>
            <img alt="" src="images/imt_login_down.png" class="imgbgcontent" />
        </div>
        <div style="clear: both;">
        </div>
        <div id="divfooter">
            ©Copyright 2012-<%= System.DateTime.Now.Year %>
            Chuyển phát nhanh Bồ Câu - Dove Express.
            <br />
            Hà Nội: 33 ngách 15 ngõ 167 Tây Sơn, Đống Đa - ÐT: 04.2242.4232 - Fax: 04.3533.5153
            - Email: hn@dovevn.com
            <br />
            TP.HCM: 49/3 Hậu Giang, Tân Bình - ÐT: 08. 2218.0607 - Fax: 08. 3948.7154 - Email:
            hcm@dovevn.com
            <br />
            Website: www.dovevn.com
        </div>
    </div>
    </form>
</body>
</html>
<asp:sqldatasource id="VUNGLAMVIECDataSource" runat="server" connectionstring="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    selectcommand="SELECT DMVUNGLAMVIEC.* FROM DMVUNGLAMVIEC">
</asp:sqldatasource>
