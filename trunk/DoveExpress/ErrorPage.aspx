<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ErrorPage.aspx.cs" Inherits="ErrorPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">   
    <div>
         <asp:Label ID="lblMessage" runat="server" Text="Có lỗi xảy ra.Vui lòng đăng nhập với quyền cao nhất và kiểm tra lỗi hệ thống."></asp:Label>
         <br />
         <asp:HyperLink ID="hplHome" runat="server" NavigateUrl="Login.aspx">Quay lại</asp:HyperLink>
    </div>
    </form>
</body>
</html>
