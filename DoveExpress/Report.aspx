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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.0/jquery.min.js" language="javascript" type="text/javascript"></script>
<script type="text/javascript">
    function pageLoad() {

        if ($.browser.mozilla && !$("#ff_print").length) {
            try {
                var ControlName = 'ReportViewer1';
                var innerTbody = '<tbody><tr><td><input type="image" style="border-width: 0px; padding: 2px; height: 16px; width: 16px;" alt="Print" src="Reserved.ReportViewerWebControl.axd?OpType=Resource&Version=10.0.40219.329&Name=Microsoft.Reporting.WebForms.Icons.Print.gif" title="Print"></td></tr></tbody>';
                var innerTable = '<table title="Print" onclick="PrintFunc(\'' + ControlName + '\'); return false;" id="ff_print" style="border: 1px solid rgb(236, 233, 216); background-color: rgb(236, 233, 216); cursor: default;">' + innerTbody + '</table>'
                var outerDiv = '<div style="display: inline; font-size: 8pt; height: 30px;" class=" "><table cellspacing="0" cellpadding="0" style="display: inline;"><tbody><tr><td height="28px">' + innerTable + '</td></tr></tbody></table></div>';
                $("#ReportViewer1_ctl05 > div").append(outerDiv);
            }
            catch (e) { alert(e); }
        }
    }
    function PrintFunc() {
        $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("PrintReport;Full");
    }
</script>
<script type="text/javascript">
    function onResponseEndReport() {
        if (typeof (result) != "undefined" && result && result != "") {
            alert(result);
            result = "";
        }
        return false;
    }
</script>
         <telerik:RadScriptManager ID="RadScriptManager" runat="server">
        </telerik:RadScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" 
               UpdatePanelsRenderMode="Inline">
        </telerik:RadAjaxManager>    
    <div>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="100%">
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