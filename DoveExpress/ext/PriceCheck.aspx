<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PriceCheck.aspx.cs" Inherits="PriceCheck" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register TagPrefix="custom" Src="PriceCheckTN.ascx" TagName="PriceCheckTN" %>
<%@ Register TagPrefix="custom" Src="PriceCheckQT.ascx" TagName="PriceCheckQT" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
       <title>CHUYỂN PHÁT NHANH DOVE EXPRESS</title>
</head>
<body>
    <form id="formPriceCheck" runat="server">
    <telerik:RadScriptManager ID="RadScriptManagerPriceCheck" runat="server">
    </telerik:RadScriptManager>
    <telerik:RadAjaxManager ID="RadAjaxManagerPriceCheck" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>
    <telerik:RadTabStrip runat="server" ID="RadTabStripPriceCheck" MultiPageID="RadMultiPagePriceCheck" SelectedIndex="0" Skin="Silk">
            <Tabs>
                <telerik:RadTab Text="Trong nước" Width="200px"></telerik:RadTab>
                <telerik:RadTab Text="Quốc tế" Width="200px"></telerik:RadTab>
            </Tabs>
        </telerik:RadTabStrip>
        <telerik:RadMultiPage runat="server" ID="RadMultiPagePriceCheck" SelectedIndex="0" CssClass="outerMultiPage">
            <telerik:RadPageView runat="server" ID="RadPageViewTN">
                    <custom:PriceCheckTN  ID ="PriceCheckTN" runat ="server"  />
            </telerik:RadPageView>
            <telerik:RadPageView runat="server" ID="RadPageViewQT">

            </telerik:RadPageView>
        </telerik:RadMultiPage>
    </form>
</body>
</html>
