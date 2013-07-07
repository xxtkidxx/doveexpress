<%@ Control Language="C#" AutoEventWireup="true" CodeFile="REPORT.ascx.cs" Inherits="Reports_Report_CPDT" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelReport" runat="server" />
<div style ="text-align :center ; width :100%; padding :20px;">
 <CR:CrystalReportViewer runat="server" AutoDataBind="True" ID="crvReport" 
 ToolPanelWidth="200px" onunload="Report_Unload" DisplayToolbar="True" DisplayStatusbar="True" HasDrilldownTabs="True" HasCrystalLogo="True" HasPageNavigationButtons="True" PrintMode="ActiveX" DisplayPage="True" ToolPanelView="GroupTree">
</CR:CrystalReportViewer>
</div>
