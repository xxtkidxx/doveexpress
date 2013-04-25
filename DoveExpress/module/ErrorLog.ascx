<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ErrorLog.ascx.cs" Inherits="Admin_ErrorLog" %>
<telerik:RadCodeBlock ID="RadCodeBlockErrorLog" runat="server">
 <script type="text/javascript">
     function OnClientFileOpenErrorLog(oExplorer, args) {

     }
 </script>
</telerik:RadCodeBlock>
<div style="padding-top: 5px;"></div>
<telerik:RadFileExplorer Skin="Vista" runat="server" ID="RadFileExplorerErrorLog" Height="400px" Width="100%" onclientfileopen="OnClientFileOpenErrorLog">
</telerik:RadFileExplorer>


