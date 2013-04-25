<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ActionLog.ascx.cs" Inherits="Admin_ActionLog" %>
<telerik:RadCodeBlock ID="RadCodeBlockActionLog" runat="server">
 <script type="text/javascript">
     function OnClientFileOpenActionLog(oExplorer, args) {

     }
 </script>
</telerik:RadCodeBlock>
<div style="padding-top: 5px;"></div>
<telerik:RadFileExplorer Skin="Vista" runat="server" ID="RadFileExplorerActionLog" Height="400px" Width="100%" onclientfileopen="OnClientFileOpenActionLog">
</telerik:RadFileExplorer>
