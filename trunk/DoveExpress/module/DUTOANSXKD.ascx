<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DUTOANSXKD.ascx.cs" Inherits="module_DUTOANSXKD" %>
<%@ Register TagPrefix="uc1" TagName="DUTOANTHU" Src="DUTOANCHIs.ascx" %>
<%@ Register TagPrefix="uc1" TagName="DUTOANCHI" Src="DUTOANTHUs.ascx" %>
<%@ Register TagPrefix="uc1" TagName="DUTOANNSNN" Src="DUTOANNSNNs.ascx" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxProxyDUTOANSXKD" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadSplitterDUTOANSXKD">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadSplitterDUTOANSXKD" LoadingPanelID="RadAjaxLoadingPanelDUTOANSXKD" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadScriptBlock ID="RadScriptBlockDUTOANSXKD" runat="server">   
<script type="text/javascript">
    var RadGridCHI, RadGridTHU, RadGridNSNN;
    function RadGridCHICreated(sender, args) {
        RadGridCHI = sender;
    }
    function RadGridTHUCreated(sender, args) {
        RadGridTHU = sender;
    }
    function RadGridNSNNCreated(sender, args) {
        RadGridNSNN = sender;
    }
    function RadGridCHIRebind() {
        RadGridCHI.get_masterTableView().rebind();
        return false;
    }
    function RadGridTHURebind() {
        RadGridTHU.get_masterTableView().rebind();
        return false;
    }
    function RadGridNSNNRebind() {
        RadGridNSNN.get_masterTableView().rebind();
        return false;
    }
    function cmbClientSelectedIndexChangedHandler(sender, eventArgs) {
        RadGridCHIRebind();
        RadGridTHURebind();
        RadGridNSNNRebind();        
    }
</script>
</telerik:RadScriptBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelDUTOANSXKD" runat="server" />
<b>Chọn năm:</b><telerik:RadComboBox ID="cmbYear" runat="server" 
    OnClientSelectedIndexChanged = "cmbClientSelectedIndexChangedHandler" AllowCustomText ="true"
    EmptyMessage="Chọn" onload="cmbYear_Load">                               
 </telerik:RadComboBox> 
<telerik:RadSplitter ID="RadSplitterDUTOANSXKD" runat="server" Width="100%" Height ="550px" Orientation="Horizontal">
<telerik:RadPane ID="RadPaneDUTOANSXKDTHU" runat="server" Width="32%">
      <uc1:DUTOANTHU id="DUTOANTHU1" runat="server"/>  
</telerik:RadPane>
<telerik:RadSplitBar ID="RadSplitBar1" runat="server" CollapseMode="None" />
<telerik:RadPane ID="RadPaneDUTOANSXKDCHI" runat="server" Width="32%">   
      <uc1:DUTOANCHI id="DUTOANCHI1" runat="server"/>  
</telerik:RadPane>
<telerik:RadSplitBar ID="RadSplitBar2" runat="server" CollapseMode="None" />
<telerik:RadPane ID="RadPaneDUTOANSXKDNS" runat="server" Width="32%">   
    <uc1:DUTOANNSNN id="DUTOANNSNN1" runat="server"/>  
</telerik:RadPane>
 </telerik:RadSplitter>
