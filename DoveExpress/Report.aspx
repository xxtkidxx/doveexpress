<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Report.aspx.cs" Inherits="Report" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="printButtonDLL" Namespace="printButtonDLL" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>PHẦN MỀM QUẢN LÝ CHUYỂN PHÁT NHANH DOVE EXPRESS</title>
</head>
<body>
    <form id="form1" runat="server">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.0/jquery.min.js" language="javascript" type="text/javascript"></script>
<script type="text/javascript">
    function $_create(elem, tag, target) { return addElem(elem, target, tag) }
    function $_add(elem, target) { return addElem(elem, target) }
    function $_GB() { return GetBrowser(); }

    function GetBrowser() {

        //JQuery Script;
        if ($.browser.mozilla)
            return 'FF';
        else if ($.browser.msie)
            return 'IE';
        else if ($.browser.webkit)
            return 'OP';
        else if ($.browser.opera)
            return 'WK';
        else
            return 'FF';

    }

    function addElem(elem, target, tag) {
        if (typeof elem === 'string') {
            var el = document.getElementById(elem);
            if (!el) {

                el = document.createElement(tag);

                el.id = elem;
            }
            elem = el;
        }

        if (target) {

            var dest;
            if (typeof target === 'string')
                dest = document.getElementById(target);
            else
                dest = target;


            dest.appendChild(elem);

        }

        return elem;
    }

    function insert(elem, target) {
        if (typeof target === 'string')
            target = document.getElementById(target);
        var myDoc = target.contentWindow || target.contentDocument;
        if (myDoc.document) {
            myDoc = myDoc.document;
        }
        var headLoc = myDoc.getElementsByTagName("head").item(0);
        var scriptObj = myDoc.createElement("script");
        scriptObj.setAttribute("type", "text/javascript");
        scriptObj.innerHTML = 'window.print();';
        if (elem)
            elem = document.getElementById(elem);

        if (elem)
            headLoc.appendChild(elem);
        else
            headLoc.appendChild(scriptObj);

    }
</script>
    <div>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="960px" Font-Names="Verdana" Font-Size="8pt" Height="600px">
            <LocalReport EnableExternalImages="True" EnableHyperlinks="True" ReportPath="Report/ReportBill.rdlc">
            </LocalReport>
        </rsweb:ReportViewer>
        <cc1:PrintButton ID="PrintButton1" runat="server" />
    </div>
    </form>
</body>
</html>
