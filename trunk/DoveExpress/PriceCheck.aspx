<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PriceCheck.aspx.cs" Inherits="PriceCheck" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
       <title>CHUYỂN PHÁT NHANH DOVE EXPRESS</title>
   <link href="css/StyleSheet.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager" runat="server">
    </telerik:RadScriptManager>
    <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>
    <div class="clearfix bgpopup"> 
            <div style="width:900px; height:500px; background:#FFFFFF" class="clearfix">      
            <table id="tblEdit" class ="TableEditInGrid" cellspacing="3" cellpadding="3" style="width: 100%" border="0">
            <tr> 
                <td style ="width:100px;"> <span class="rtsTxtnew">Tỉnh thành:</span></td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbTinhThanh" runat="server"
                    DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="TINHTHANHDataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn tỉnh"
                    onclientselectedindexchanged="cmbTinhThanhClientSelectedIndexChangedHandler">
                    </telerik:RadComboBox>
                </td>               
                <td style =" width:100px;"> <span class="rtsTxtnew">Quận huyện:</span></td>
                <td colspan="12">
                     <telerik:RadComboBox ID="cmbQuanHuyen" runat="server" 
                    DataTextField="C_NAME" DataValueField="C_CODE" DataSourceID="QUANHUYENDataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn quận huyện" 
                    onclientitemsrequested="ItemsLoadedQuanHuyen" onclientload="OnClientLoadQuanHuyen" 
                    onitemsrequested="cmbQuanHuyen_ItemsRequested" onclientselectedindexchanged="cmbQuanHuyenClientSelectedIndexChangedHandler">
                    </telerik:RadComboBox>
                </td>
            </tr> 
            <tr>                
                <td style =" width:100px;"> <span class="rtsTxtnew">Giá trị hàng hoá:</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_GIATRIHANGHOA" Width ="90%" Runat="server" ClientEvents-OnValueChanged="OnValueChangedtxtC_GIATRIHANGHOA">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>               
            </tr>
            <tr>                
                <td style =" width:100px;"> <span class="rtsTxtnew">Dịch vụ:</span></td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbSanPham" runat="server" 
                    DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="MASANPHAMDataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn dịch vụ" onclientselectedindexchanged="cmbSanPhamClientSelectedIndexChangedHandler">
                    </telerik:RadComboBox>
                </td>               
                <td style =" width:100px;"> <span class="rtsTxtnew">Khối lượng (g):</span></td>
                <td colspan="4">
                     <telerik:RadNumericTextBox  ID="txtC_KHOILUONG" Width ="90%" Runat="server" ClientEvents-OnValueChanged="OnValueChangedtxtC_KHOILUONG" ClientEvents-OnLoad="OnClientLoadtxtC_KHOILUONG">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>
                <td style =" width:100px;"> <span class="rtsTxtnew">Cước chính:</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_GIACUOC" Width ="90%" Runat="server" ClientEvents-OnLoad="OnClientLoadtxtC_GIACUOC" ClientEvents-OnValueChanged="OnValueChangedtxtC_GIACUOC">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>
                <td style =" width:100px;"><span class="rtsTxtnew">PPXD:</span></td>
                <td colspan="4">
                     <telerik:RadNumericTextBox  ID="txtPPXD" Width ="90%" Runat="server" ClientEvents-OnLoad="OnClientLoadtxtPPXD" ClientEvents-OnValueChanged="OnValueChangedtxtPPXD">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>          
                <td style =" width:100px;"><span class="rtsTxtnew"><input id="btnC_DONGGOI" type="checkbox" onclick="SetC_DONGGOI();" value="false"/>Đóng gói:</td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_DONGGOI" Width ="90%" Runat="server" ClientEvents-OnValueChanged="OnValueChangedtxtC_DONGGOI">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>
                <td style =" width:100px;"><span class="rtsTxtnew"><input id="btnC_KHAIGIA" type="checkbox" onclick="SetC_KHAIGIA();" value="false"/>Khai giá:</td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_KHAIGIA" Width ="90%" Runat="server" ClientEvents-OnValueChanged="OnValueChangedtxtC_KHAIGIA">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                     </telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>                
                <td style =" width:100px;"> <span class="rtsTxtnew"><input id="btnC_COD" type="checkbox" onclick="SetC_COD();" value="false"/>COD:</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_COD" Width ="90%" Runat="server" ClientEvents-OnValueChanged="OnValueChangedtxtC_COD">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>                
                <td style =" width:100px;"><span class="rtsTxtnew"><input id="btnC_BAOPHAT" type="checkbox" onclick="SetC_BAOPHAT();" value="false"/>Báo phát:</td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_BAOPHAT" Width ="90%" Runat="server" ClientEvents-OnValueChanged="OnValueChangedtxtC_BAOPHAT">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>
                <td style =" width:100px;"><span class="rtsTxtnew"><input id="btnC_HENGIO" type="checkbox" onclick="SetC_HENGIO();" value="false"/>Hẹn giờ:</td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_HENGIO" Width ="90%" Runat="server" ClientEvents-OnValueChanged="OnValueChangedtxtC_HENGIO">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>                
            </tr>
            <tr>  
                <td style =" width:100px;"><span class="rtsTxtnew">Tổng cước:</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_TIENHANG" Width ="90%" Runat="server" ClientEvents-OnValueChanged="OnValueChangedtxtC_TIENHANG">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>                 
                </td>                
                <td style =" width:100px;"> <span class="rtsTxtnew">VAT:</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_VAT" Width ="90%" Runat="server" ClientEvents-OnValueChanged="OnValueChangedtxtC_VAT">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>                
                <td style =" width:110px;"><span class="rtsTxtnew">Tổng cước (VAT)<br /><input id="btnGiaCuoi" type="checkbox" onclick="SetGiaCuoi();" value="false"/>Theo giá cuối:</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_TIENHANGVAT" Width ="90%" Runat="server" ClientEvents-OnValueChanged="OnValueChangedtxtC_TIENHANGVAT">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>                
            </tr>
            
           </table>
            </div> 
        <!-- end bgpopup--></div>    
    </form>
</body>
</html>
<asp:SqlDataSource ID="MASANPHAMDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
  SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMMASANPHAM]  WHERE C_TYPE = N'Trong nước' ORDER BY PK_ID">
</asp:SqlDataSource>
<asp:SqlDataSource ID="MAVUNGDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>">
</asp:SqlDataSource>
 <asp:SqlDataSource ID="TINHTHANHDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [DMTINHTHANH].[PK_ID], [DMTINHTHANH].[C_CODE], [DMTINHTHANH].[C_NAME] FROM [DMTINHTHANH] LEFT OUTER JOIN DMQUOCGIA ON DMTINHTHANH.FK_QUOCGIA = DMQUOCGIA.PK_ID WHERE DMQUOCGIA.C_CODE='VN' ORDER BY DMTINHTHANH.C_ORDER ASC, DMTINHTHANH.C_NAME ASC">
 </asp:SqlDataSource>
 <asp:SqlDataSource ID="QUANHUYENDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>">
</asp:SqlDataSource>