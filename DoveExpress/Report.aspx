<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Report.aspx.cs" Inherits="Report" %>


<%@ Register Assembly="Telerik.ReportViewer.WebForms, Version=8.0.14.225, Culture=neutral, PublicKeyToken=a9d7983dfcc261be" Namespace="Telerik.ReportViewer.WebForms" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>PHẦN MỀM QUẢN LÝ CHUYỂN PHÁT NHANH DOVE EXPRESS</title>
    <style type="text/css">			
		html#html, body#body, form#form1, div#content, center#center
		{	
			border: 0px solid black;
			padding: 0px;
			margin: 0px;
			height: 100%;
		}
    </style>
</head>
<body id="body">
    <form id="form1" runat="server">              
    <div id="content"><center id="center">
        <telerik:ReportViewer ID="ReportViewer1" runat="server" Height="800px" Width="100%" />
    </center></div>
    </form>
</body>
</html>