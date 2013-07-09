<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Report.aspx.cs" Inherits="Report" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>PHẦN MỀM QUẢN LÝ CHUYỂN PHÁT NHANH DOVE EXPRESS</title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager" runat="server">
        </telerik:RadScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" 
               UpdatePanelsRenderMode="Inline">
        </telerik:RadAjaxManager>    
    <div>
        <asp:Button ID="btnPrint" runat="server" Text="In Bill" onclick="btnPrint_Click" />
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" 
            Height="100%" ShowPrintButton="False">
            <LocalReport EnableExternalImages="True" EnableHyperlinks="True" ReportPath="Report/ReportBill.rdlc">
            </LocalReport>
        </rsweb:ReportViewer>
        <iframe id="frmPrint" name="IframeName" width="500" 
          height="200" runat="server" 
          style="display: none" runat="server"></iframe>
    </div>
    </form>
</body>
</html>