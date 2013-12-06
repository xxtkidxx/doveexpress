<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NHANGUI.ascx.cs" Inherits="module_NHANGUI" %>
<%@ Register TagPrefix="uc1" Namespace="ITCLIB.Admin" %>
<telerik:RadCodeBlock ID="RadCodeBlockNHANGUI" runat="server">
<script type="text/javascript">
    function PrintOnClientLinkClicked3() {
        if ($find("<%= RadGridNHANGUI.MasterTableView.ClientID %>").get_selectedItems().length != 0) {
            var IDNHANGUI = $find("<%= RadGridNHANGUI.MasterTableView.ClientID %>").get_selectedItems()[0].getDataKeyValue("C_BILL");
            var url = "";
            url = "Report.aspx?TYPE=INBILLKIM&ID=" + IDNHANGUI;
            window.open(url, '_blank');
            window.focus();
        } else {
            alert("Không có phiếu nhận gửi được chọn");
        }

    }
    function PrintOnClientLinkClicked2() {
        if ($find("<%= RadGridNHANGUI.MasterTableView.ClientID %>").get_selectedItems().length != 0) {
            var IDNHANGUI = $find("<%= RadGridNHANGUI.MasterTableView.ClientID %>").get_selectedItems()[0].getDataKeyValue("C_BILL");
            var url = "";
            url = "Report.aspx?TYPE=INBILL2&ID=" + IDNHANGUI;
            window.open(url, '_blank');
            window.focus();
        } else {
            alert("Không có phiếu nhận gửi được chọn");
        }
    }
    function PrintOnClientLinkClicked1() {
        if ($find("<%= RadGridNHANGUI.MasterTableView.ClientID %>").get_selectedItems().length != 0) {
            var IDNHANGUI = $find("<%= RadGridNHANGUI.MasterTableView.ClientID %>").get_selectedItems()[0].getDataKeyValue("C_BILL");
            var url = "";
            url = "Report.aspx?TYPE=INBILL&ID=" + IDNHANGUI;
            window.open(url, '_blank');
            window.focus();
        } else {
            alert("Không có phiếu nhận gửi được chọn");
        }
    }
    function PrintOnClientLinkClickedEdit3(IDNHANGUI) {
        var url = "";
        url = "Report.aspx?TYPE=INBILLKIM&ID=" + IDNHANGUI;
        window.open(url, '_blank');
        window.focus();
    }
    function PrintOnClientLinkClickedEdit2(IDNHANGUI) {
        var url = "";
        url = "Report.aspx?TYPE=INBILL2&ID=" + IDNHANGUI;
        window.open(url, '_blank');
        window.focus();
    }
    function PrintOnClientLinkClickedEdit1(IDNHANGUI) {
        var url = "";
        url = "Report.aspx?TYPE=INBILL&ID=" + IDNHANGUI;
        window.open(url, '_blank');
        window.focus();
    }
</script>
<script type="text/javascript">
    var flag = false;
    var CUOCCHINH;
    function RowDblClick(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("NHANGUI") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewNHANGUI") && (CanEdit == "True")) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
    }        
    var cmbMaKhachHang;
    function OnClientLoadcmbMaKhachHang(sender) {
        cmbMaKhachHang = sender;
    }
    var txtC_TENKH;
    function OnClientLoadtxtC_TENKH(sender) {
        txtC_TENKH = sender;
    }    
    var txtC_TELGUI;
    function OnClientLoadtxtC_TELGUI(sender) {
        txtC_TELGUI = sender;
    }
    var cmbQuanHuyen;
    function OnClientLoadQuanHuyen(sender) {
        cmbQuanHuyen = sender;
    }
    function cmbTinhThanhClientSelectedIndexChangedHandler(sender, eventArgs) {
        cmbQuanHuyen.requestItems(eventArgs.get_item().get_value(), false);        
    }
    function ItemsLoadedQuanHuyen(combo, eventArqs) {
        if (combo.get_items().get_count() > 0) {
            combo.trackChanges();
            combo.get_items().getItem(0).select();
            combo.updateClientState();
            combo.commitChanges();
        } else {
            combo.set_text("");
        }
    }
    function cmbQuanHuyenClientSelectedIndexChangedHandler(sender, eventArgs) {
        var hftext = GetGridServerElementNG("hfQuanHuyen");
        hftext.value = eventArgs.get_item().get_value();
        $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("cmbQuanHuyen;" + eventArgs.get_item().get_value());
        var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelNHANGUI.ClientID %>");
        var currentUpdatedControl = "<%= RadGridNHANGUI.ClientID %>"; 
        currentLoadingPanel.show(currentUpdatedControl);
        return false;
    }
    function cmbSanPhamClientSelectedIndexChangedHandler(sender, eventArgs) {
         $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("cmbSanPham;" + eventArgs.get_item().get_value());
         var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelNHANGUI.ClientID %>");
         var currentUpdatedControl = "<%= RadGridNHANGUI.ClientID %>"; 
         currentLoadingPanel.show(currentUpdatedControl);
         return false;
    }
    var checkKH = false;
    function cmbMaKhachHangClientSelectedIndexChangedHandler(sender, eventArgs) {
         checkKH = true;
         $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("cmbMaKhachHang;" + eventArgs.get_item().get_value());
         var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelNHANGUI.ClientID %>");
         var currentUpdatedControl = "<%= RadGridNHANGUI.ClientID %>"; 
         currentLoadingPanel.show(currentUpdatedControl);
         return false;
    }
    function cmbFK_DOITACClientSelectedIndexChangedHandler(sender, eventArgs) {
         $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("cmbFK_DOITAC;" + eventArgs.get_item().get_value());
         var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelNHANGUI.ClientID %>");
         var currentUpdatedControl = "<%= RadGridNHANGUI.ClientID %>"; 
         currentLoadingPanel.show(currentUpdatedControl);
         return false;
    }   
    function OnValueChangedtxtC_KHOILUONG(sender, eventArgs) {
        $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("txtC_KHOILUONG;" + eventArgs.get_newValue());
        var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelNHANGUI.ClientID %>");
        var currentUpdatedControl = "<%= RadGridNHANGUI.ClientID %>"; 
        currentLoadingPanel.show(currentUpdatedControl);
        return false;
    }
    function OnValueChangedtxtC_KHOILUONGTHUC(sender, eventArgs) {
        txtC_KHOILUONG.set_value(Math.max(txtC_KHOILUONGQD.get_value(),txtC_KHOILUONGTHUC.get_value())); 
        return false;
    } 
    function OnValueChangedtxtC_KHOILUONGQD(sender, eventArgs) {
        txtC_KHOILUONG.set_value(Math.max(txtC_KHOILUONGTHUC.get_value(),txtC_KHOILUONGQD.get_value())); 
        return false;
    }
    function OnValueChangedtxtC_GIATRIHANGHOA(sender, eventArgs) {
        
        return false;
    }
    var txtC_GIATRIHANGHOA;
    function OnClientLoadtxtC_GIATRIHANGHOA(sender) {
        txtC_GIATRIHANGHOA = sender;
    } 
    var txtC_KHOILUONGTHUC;
    function OnClientLoadtxtC_KHOILUONGTHUC(sender) {
        txtC_KHOILUONGTHUC = sender;
    } 
    var txtC_KHOILUONGQD;
    function OnClientLoadtxtC_KHOILUONGQD(sender) {
        txtC_KHOILUONGQD = sender;
    } 
    var txtC_KHOILUONG;
    function OnClientLoadtxtC_KHOILUONG(sender) {
        txtC_KHOILUONG = sender;
    } 
    var txtPPXD;
    var PPXD;
    function OnClientLoadtxtPPXD(sender) {
        txtPPXD = sender;
    }   
    var txtC_GIACUOC;
    function OnClientLoadtxtC_GIACUOC(sender) {
        txtC_GIACUOC = sender;
    }
    var txtC_TIENHANG;
    function OnClientLoadtxtC_TIENHANG(sender) {
        txtC_TIENHANG = sender;
    }
    var txtC_VAT;
    function OnClientLoadtxtC_VAT(sender) {
        txtC_VAT = sender;
    }
    var txtC_TIENHANGVAT;
    function OnClientLoadtxtC_TIENHANGVAT(sender) {
        txtC_TIENHANGVAT = sender;
    }
    var txtC_DONGGOI;
    function OnClientLoadtxtC_DONGGOI(sender) {
        txtC_DONGGOI = sender;
    }
    var txtC_KHAIGIA;
    function OnClientLoadtxtC_KHAIGIA(sender) {
        txtC_KHAIGIA = sender;
    }
    var txtC_COD;
    function OnClientLoadtxtC_COD(sender) {
        txtC_COD = sender;
    }
    var txtC_BAOPHAT;
    function OnClientLoadtxtC_BAOPHAT(sender) {
        txtC_BAOPHAT = sender;
    }
    var txtC_HENGIO;
    function OnClientLoadtxtC_HENGIO(sender) {
        txtC_HENGIO = sender;
    }
    var txtC_DATHU;
    function OnClientLoadtxtC_DATHU(sender) {
        txtC_DATHU = sender;
    }
    var txtC_CONLAI;
    function OnClientLoadtxtC_CONLAI(sender) {
        txtC_CONLAI = sender;
    }
    var txtC_GIADOITAC;
    function OnClientLoadtxtC_GIADOITAC(sender) {
        txtC_GIADOITAC = sender;
    }
    function OnValueChangedtxtC_GIACUOC(sender, eventArgs) {
        txtPPXD.set_value(txtC_GIACUOC.get_value() * parseFloat(PPXD)/100);
        if (!flag) {
            txtC_TIENHANG.set_value(txtC_GIACUOC.get_value() + txtPPXD.get_value() + txtC_BAOPHAT.get_value() + txtC_HENGIO.get_value() + txtC_COD.get_value() + txtC_KHAIGIA.get_value() + txtC_DONGGOI.get_value());
        }
        return false;
    }
    function OnValueChangedtxtPPXD(sender, eventArgs) {
        if (!flag) {
            txtC_TIENHANG.set_value(txtC_GIACUOC.get_value() + txtPPXD.get_value() + txtC_BAOPHAT.get_value()  + txtC_HENGIO.get_value() + txtC_COD.get_value() + txtC_KHAIGIA.get_value() + txtC_DONGGOI.get_value());
        }
        return false;
    }
    function OnValueChangedtxtC_DONGGOI(sender, eventArgs) {
        if (flag) {
           txtC_GIACUOC.set_value(((txtC_TIENHANG.get_value() - txtC_BAOPHAT.get_value() - txtC_HENGIO.get_value() - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*100);
           txtPPXD.set_value(((txtC_TIENHANG.get_value() - txtC_BAOPHAT.get_value() - txtC_HENGIO.get_value() - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*parseFloat(PPXD));
        }
        else {
            txtC_TIENHANG.set_value(txtC_GIACUOC.get_value() + txtPPXD.get_value() + txtC_BAOPHAT.get_value() + txtC_HENGIO.get_value()  + txtC_COD.get_value() + txtC_KHAIGIA.get_value() + txtC_DONGGOI.get_value());
        }        
        return false;
    }
    function OnValueChangedtxtC_KHAIGIA(sender, eventArgs) {
       if (flag) {
           txtC_GIACUOC.set_value(((txtC_TIENHANG.get_value() - txtC_BAOPHAT.get_value() - txtC_HENGIO.get_value()  - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*100);
           txtPPXD.set_value(((txtC_TIENHANG.get_value() - txtC_BAOPHAT.get_value() - txtC_HENGIO.get_value()  - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*parseFloat(PPXD));
        }
        else {
            txtC_TIENHANG.set_value(txtC_GIACUOC.get_value() + txtPPXD.get_value() + txtC_BAOPHAT.get_value() + txtC_HENGIO.get_value()  + txtC_COD.get_value() + txtC_KHAIGIA.get_value() + txtC_DONGGOI.get_value());
        }        
        return false;
    }
    function OnValueChangedtxtC_COD(sender, eventArgs) {
        if (flag) {
           txtC_GIACUOC.set_value(((txtC_TIENHANG.get_value() - txtC_BAOPHAT.get_value() - txtC_HENGIO.get_value()  - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*100);
           txtPPXD.set_value(((txtC_TIENHANG.get_value() - txtC_BAOPHAT.get_value() - txtC_HENGIO.get_value()  - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*parseFloat(PPXD));
        }
        else {
            txtC_TIENHANG.set_value(txtC_GIACUOC.get_value() + txtPPXD.get_value() + txtC_BAOPHAT.get_value() + txtC_HENGIO.get_value() + txtC_COD.get_value() + txtC_KHAIGIA.get_value() + txtC_DONGGOI.get_value());
        }        
        return false;
    }
    function OnValueChangedtxtC_BAOPHAT(sender, eventArgs) {
        if (flag) {
           txtC_GIACUOC.set_value(((txtC_TIENHANG.get_value() - txtC_BAOPHAT.get_value() - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*100);
           txtPPXD.set_value(((txtC_TIENHANG.get_value() - txtC_BAOPHAT.get_value() - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*parseFloat(PPXD));
        }
        else {
            txtC_TIENHANG.set_value(txtC_GIACUOC.get_value() + txtPPXD.get_value() + txtC_BAOPHAT.get_value() + txtC_COD.get_value() + txtC_KHAIGIA.get_value() + txtC_DONGGOI.get_value());
        }        
        return false;
    }
    function OnValueChangedtxtC_HENGIO(sender, eventArgs) {
        if (flag) {
           txtC_GIACUOC.set_value(((txtC_TIENHANG.get_value() - txtC_BAOPHAT.get_value() - txtC_HENGIO.get_value() - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*100);
           txtPPXD.set_value(((txtC_TIENHANG.get_value() - txtC_BAOPHAT.get_value() - txtC_HENGIO.get_value() - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*parseFloat(PPXD));
        }
        else {
            txtC_TIENHANG.set_value(txtC_GIACUOC.get_value() + txtPPXD.get_value() + txtC_BAOPHAT.get_value() + txtC_HENGIO.get_value() + txtC_COD.get_value() + txtC_KHAIGIA.get_value() + txtC_DONGGOI.get_value());
        }        
        return false;
    }     
    function OnValueChangedtxtC_TIENHANG(sender, eventArgs) {       
        txtC_VAT.set_value(txtC_TIENHANG.get_value()*0.1);                
        return false;
    }
    function OnValueChangedtxtC_VAT(sender, eventArgs) {
        if (!flag) {
            txtC_TIENHANGVAT.set_value(txtC_TIENHANG.get_value() + txtC_VAT.get_value());
        }
        return false;
    }
    function OnValueChangedtxtC_TIENHANGVAT(sender, eventArgs) {
        txtC_CONLAI.set_value(txtC_TIENHANGVAT.get_value() - txtC_DATHU.get_value());
        if (flag) {
         txtC_TIENHANG.set_value((txtC_TIENHANGVAT.get_value()/110)*100);
         txtC_GIACUOC.set_value(((txtC_TIENHANG.get_value() - txtC_BAOPHAT.get_value() - txtC_HENGIO.get_value() - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*100);
         txtPPXD.set_value(((txtC_TIENHANG.get_value() - txtC_BAOPHAT.get_value() - txtC_HENGIO.get_value() - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*parseFloat(PPXD));
        }
        return false;
    }
    function OnValueChangedtxtC_DATHU(sender, eventArgs) {
        txtC_CONLAI.set_value(txtC_TIENHANGVAT.get_value() - txtC_DATHU.get_value());
        return false;
    }
    var isCOD = false;
    function SetC_COD() {
        isCOD = !isCOD;
        if (isCOD) {          
           txtC_COD.set_value(20000 + txtC_GIATRIHANGHOA.get_value()*0.02);
        }
        else 
        {
            txtC_COD.set_value(0);            
        }      
    }
    var isKHAIGIA = false;
    function SetC_KHAIGIA() {
        isKHAIGIA = !isKHAIGIA;
        if (isKHAIGIA) {          
           txtC_KHAIGIA.set_value(Math.max(50000,txtC_GIATRIHANGHOA.get_value()*0.02)); 
        }
        else 
        {
            txtC_KHAIGIA.set_value(0);            
        }    
    }
    var isHENGIO = false;
    function SetC_HENGIO() {
        isHENGIO = !isHENGIO;
        if (isHENGIO) {          
           txtC_HENGIO.set_value(Math.max(50000,txtC_GIACUOC.get_value()*0.2)); 
        }
        else 
        {
            txtC_HENGIO.set_value(0);            
        }    
    }
    var isBAOPHAT = false;
    function SetC_BAOPHAT() {
        isBAOPHAT = !isBAOPHAT;
        if (isBAOPHAT) {          
           txtC_BAOPHAT.set_value(5000); 
        }
        else 
        {
            txtC_BAOPHAT.set_value(0);            
        }    
    }
    var isDONGGOI = false;
    function SetC_DONGGOI() {
        isDONGGOI = !isDONGGOI;
        if (isDONGGOI) {          
           //txtC_DONGGOI.set_value(0); 
        }
        else 
        {
            txtC_DONGGOI.set_value(0);            
        }   
    }
    function SetGiaCuoi() {
        flag = !flag;
        if (typeof (PPXD) == "undefined" || PPXD == "") {
                PPXD = (txtPPXD.get_value() / txtC_GIACUOC.get_value()) * 100;
        }
        if (typeof (CUOCCHINH) == "undefined" || CUOCCHINH == "") {
                CUOCCHINH = txtC_GIACUOC.get_value();
        }
        if (flag) {          
         txtC_TIENHANG.set_value((txtC_TIENHANGVAT.get_value()/110)*100);
         txtC_GIACUOC.set_value(((txtC_TIENHANG.get_value() - txtC_BAOPHAT.get_value() - txtC_HENGIO.get_value() - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*100);
         txtPPXD.set_value(((txtC_TIENHANG.get_value() - txtC_BAOPHAT.get_value() - txtC_HENGIO.get_value() - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*parseFloat(PPXD));
        }
        else 
        {
            txtC_GIACUOC.set_value(CUOCCHINH);                  
        }
    }
    function cmbC_HINHTHUCTTClientSelectedIndexChangedHandler(sender, eventArgs) {
        if ( eventArgs.get_item().get_value() == 'Thanh toán ngay')
        {
            txtC_DATHU.set_value(0);
            //txtC_DATHU.set_value(txtC_TIENHANGVAT.get_value());
        } else if ( eventArgs.get_item().get_value() == 'Đã thanh toán')
        {
            txtC_DATHU.set_value(txtC_TIENHANGVAT.get_value());
        } else if ( eventArgs.get_item().get_value() == 'Thanh toán sau')
        {
            txtC_DATHU.set_value(0);
        } else if ( eventArgs.get_item().get_value() == 'Thanh toán đầu nhận')
        {
            txtC_DATHU.set_value(0);
        } else
        {
            txtC_DATHU.set_value(0);
        }
        return false;
    }    
</script>
<script type="text/javascript">
     function onResponseEndNG() {
         if (typeof (result) != "undefined" && result && result != "") {
             //alert(result);
             var arrayOfStrings = result.split(",-,");
             if (arrayOfStrings[0] != "msg") {
                 if (arrayOfStrings[0] != "") {
                     //cmbMaKhachHang.set_value(arrayOfStrings[0]);
                     //cmbMaKhachHang.set_text(arrayOfStrings[0]);
                 }
                 else {
                 }
                 if (checkKH) {
                     txtC_TENKH.set_value(arrayOfStrings[1]);
                     txtC_TELGUI.set_value(arrayOfStrings[2]);
                     checkKH = false;
                 }             
                 PPXD = arrayOfStrings[3];
                 txtC_GIACUOC.set_value(arrayOfStrings[4]);
                 CUOCCHINH = arrayOfStrings[4];
                 txtC_GIADOITAC.set_value(arrayOfStrings[5]);
             }
             else {
                 alert(arrayOfStrings[1]);
                 if (checkKH) {
                     txtC_TENKH.set_value(arrayOfStrings[2]);
                     txtC_TELGUI.set_value(arrayOfStrings[3]);
                     checkKH = false;
                 }   
             }
             var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelNHANGUI.ClientID %>");
             var currentUpdatedControl = "<%= RadGridNHANGUI.ClientID %>"; 
             currentLoadingPanel.hide(currentUpdatedControl);
             result = "";
         }
         return false;
     }
     function OnKeyPresstxtBillNhanh(sender, eventArgs) {
         var c = eventArgs.get_keyCode();    
         if (c == 13) {
             alert("Đã nhập!");
         }
         return false;
     }
</script>
<script type="text/javascript">
      var registeredElementsNG = [];
      function GetRegisteredServerElementNG(serverID) {
          var clientID = "";
          for (var i = 0; i < registeredElementsNG.length; i++) {
              clientID = registeredElementsNG[i];
              if (clientID.indexOf(serverID) >= 0)
                  break;
          }
          return $get(clientID);
      }
      function GetGridServerElementNG(serverID, tagName) {
          if (!tagName)
              tagName = "*";

          var grid = $get("<%=RadGridNHANGUI.ClientID %>");
          var elements = grid.getElementsByTagName(tagName);
          for (var i = 0; i < elements.length; i++) {
              var element = elements[i];
              if (element.id.indexOf(serverID) >= 0)
                  return element;
          }
      }
</script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelNHANGUI" runat="server" />
<style type="text/css">
table.gridtable {
	font-family: verdana,arial,sans-serif;
	font-size:13px;
	color:#333333;
	border-width: 1px;
	border-color: #666666;
	border-collapse: collapse;
	width:30%;
	margin: 5px 5px 5px 5px;
}
table.gridtable th {
	border-width: 1px;
	padding: 5px;
	font-weight: bold;
	border-style: solid;
	border-color: #666666;
	background-color: #dedede;
}
table.gridtable td {
	border-width: 1px;
	padding: 5px;
	border-style: solid;
	border-color: #666666;
	background-color: #ffffff;
}
</style>
<table class="gridtable">
<tr>
	<th>Nhập nhanh bằng số Bill</th>
    <th>Đối tác</th>
</tr>
<tr>
	<td>
        <telerik:RadNumericTextBox  ID="txtBillNhanh" ForeColor="Red" Width ="200px" 
            Runat="server" ontextchanged="txtBillNhanh_TextChanged">
            <NumberFormat DecimalSeparator ="." GroupSeparator ="" DecimalDigits="0"/>
            <ClientEvents OnKeyPress ="OnKeyPresstxtBillNhanh"/>
        </telerik:RadNumericTextBox>    
    </td>
    <td>
        <telerik:RadComboBox ID="cmbDoiTac" runat="server" Width ="95%" 
            DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="DoiTacDataSourceFix"
            ShowToggleImage="True" EmptyMessage="Chọn đối tác" >
        </telerik:RadComboBox>    
    </td>
</tr>
</table>
<telerik:RadGrid ID="RadGridNHANGUI" runat="server" Skin="Vista" 
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False" AllowMultiRowSelection="True"
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="NHANGUIDataSource" ShowFooter="True"
    ondatabound="RadGridNHANGUI_DataBound" 
    onitemdeleted="RadGridNHANGUI_ItemDeleted" oniteminserted="RadGridNHANGUI_ItemInserted" 
    onitemupdated="RadGridNHANGUI_ItemUpdated" 
    onitemcommand="RadGridNHANGUI_ItemCommand" 
    onitemdatabound="RadGridNHANGUI_ItemDataBound" CellSpacing="0">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
     <GroupingSettings CaseSensitive ="false"  />
    <MasterTableView Name="MasterTableViewNHANGUI" CommandItemDisplay="Top" DataSourceID="NHANGUIDataSource" DataKeyNames="C_BILL" ClientDataKeyNames="C_BILL" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu" InsertItemPageIndexAction="ShowItemOnFirstPage">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b>Quản lý nhận gửi trong nước</b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridNHANGUI.EditIndexes.Count == 0 && ITCLIB.Security.Security.CanEditModule("NHANGUI") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridNHANGUI.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Update.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridNHANGUI.EditIndexes.Count > 0 || RadGridNHANGUI.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridNHANGUI.MasterTableView.IsItemInserted && ITCLIB.Security.Security.CanAddModule("NHANGUI") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="PerformInsert" Visible='<%# RadGridNHANGUI.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Insert.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:return confirm('Bạn có muốn xóa bản ghi đã chọn không?')" runat="server" CommandName="DeleteSelected" Visible='<%# ITCLIB.Security.Security.CanDeleteModule("NHANGUI") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Delete.gif" />Xóa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btXuatbaocao" runat="server" OnClientClick ='<%# String.Format("javascript:return PrintOnClientLinkClicked1()")%>' ><img style="border:0px;vertical-align:middle;" alt="" src="Images/print.gif" />In 1 bản</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton7" runat="server" OnClientClick ='<%# String.Format("javascript:return PrintOnClientLinkClicked2()")%>' ><img style="border:0px;vertical-align:middle;" alt="" src="Images/print.gif" />In 2 bản</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton8" runat="server" OnClientClick ='<%# String.Format("javascript:return PrintOnClientLinkClicked3()")%>' ><img style="border:0px;vertical-align:middle;" alt="" src="Images/print.gif" />In kim</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton5" runat="server" OnClientClick="javascript:return confirm('Bạn có muốn xác nhận các Bill này đã thanh toán không?')" CommandName="ConfirmPayment" Visible='<%# ITCLIB.Security.Security.CanPrintModule("NHANGUI") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/img_OpenPanel.gif" />Xác nhận đã thanh toán</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton6" runat="server" OnClientClick="javascript:return confirm('Bạn có muốn xác nhận các Bill này chưa thanh toán không?')" CommandName="ConfirmUnPayment" Visible='<%# ITCLIB.Security.Security.CanPrintModule("NHANGUI") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/img_OpenPanel.gif" />Xác nhận chưa thanh toán</asp:LinkButton>&nbsp;&nbsp;
                       <asp:LinkButton ID="LinkButton4" runat="server" CommandName="RebindGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Refresh.gif" />Làm mới</asp:LinkButton>
                    </div>
                    <div style="padding: 5px 5px;float:right;width:auto">
                        <asp:LinkButton ID="ExportToPdfButton" runat="server" CommandName="ExportToPdf"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/pdf.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToWordButton" runat="server" CommandName="ExportToWord"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/word.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToExcelButton" runat="server" CommandName="ExportToExcel"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/excel.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToCsvButton" runat="server" CommandName="ExportToCsv"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/csv.gif" /></asp:LinkButton>&nbsp;&nbsp;
                    </div>
        </CommandItemTemplate>
        <Columns>
                <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn" HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridClientSelectColumn>
                 <telerik:GridTemplateColumn HeaderText ="" ShowFilterIcon="false">   
                 <FilterTemplate >
                  <center>
                    <asp:ImageButton ID="btnShowAll" runat="server" ImageUrl="../Images/Grid/filterCancel.gif" AlternateText="Xem tất" ToolTip="Xem tất" OnClick="btnShowAll_Click" Style="vertical-align: middle" />
                  </center>
                 </FilterTemplate>
                  <ItemTemplate>
                      <asp:Label ID="lblSTT" runat="server" Text=""></asp:Label>
                </ItemTemplate>
                 <HeaderStyle HorizontalAlign ="Center" Width ="30px" />
                 <ItemStyle HorizontalAlign ="Center" Width ="30px" />
               </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn UniqueName="C_NGAY" HeaderText="Ngày" DataField="C_NGAY" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100%" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy}">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn UniqueName="C_BILL" HeaderText="Số Bill" DataField="C_BILL" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" SortExpression="C_BILL">
                    <ItemTemplate>
                        <asp:Label ID="lblC_BILL" runat="server" Text='<%# String.Format("BC{0}", Eval("C_BILL").ToString())%>'></asp:Label>                        
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn UniqueName="FK_KHACHHANG" HeaderText="Mã khách hàng" DataField="FK_KHACHHANG" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_TENKH" HeaderText="Tên khách hàng" DataField="C_TENKH" HeaderStyle-Width="110px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="TINHTHANHNAME" HeaderText="Tỉnh thành" DataField="TINHTHANHNAME" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_NOIDUNG" HeaderText="Nội dung" DataField="C_NOIDUNG" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_KHOILUONG" HeaderText="Khối lượng" DataField="C_KHOILUONG" HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="true" FilterControlWidth="80%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_GIACUOC" HeaderText="Cước chính" DataField="C_GIACUOC" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="true" FilterControlWidth="80%" DataType="System.Decimal" DataFormatString="{0:### ### ###}">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_TIENHANGVAT" HeaderText="Tiền hàng (VAT)" DataField="C_TIENHANGVAT" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="true" FilterControlWidth="80%" DataType="System.Decimal" DataFormatString="{0:### ### ###}">
                </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn UniqueName="C_DATHU" HeaderText="Đã thu" DataField="C_DATHU" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="true" FilterControlWidth="80%" DataType="System.Decimal" DataFormatString="{0:### ### ###}">
                </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn UniqueName="C_CONLAI" HeaderText="Còn lại" DataField="C_CONLAI" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="true" FilterControlWidth="80%" DataType="System.Decimal" DataFormatString="{0:### ### ###}">
                </telerik:GridBoundColumn>
        </Columns>
        <EditFormSettings InsertCaption="Thêm nhận gửi mới" CaptionFormatString="Sửa nhận gửi: <b>{0}</b>" CaptionDataField="C_BILL" EditFormType="Template" PopUpSettings-Width="900px">
        <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
           <FormTemplate>
            <div class="headerthongtin">
              <ul>
                <li class="lifirst"><asp:LinkButton ID="btnSave" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'><img src="Images/img_save.jpg" /><%# (Container is GridEditFormInsertItem) ? "Lưu" : "Lưu" %></asp:LinkButton></li>
                <li><asp:LinkButton ID="btnClose" runat="server" CommandName="Cancel"><img src="Images/img_Close.jpg" />Đóng</asp:LinkButton></li>
                <li><asp:LinkButton ID="btXuatbaocao" runat="server"  Visible='<%# !(Container is GridEditFormInsertItem) %>' OnClientClick ='<%# String.Format("javascript:return PrintOnClientLinkClickedEdit1({0})",Eval("C_BILL")) %>' ><img style="border:0px;vertical-align:middle;" alt="" src="Images/print.gif"/>In 1 bản</asp:LinkButton></li>
                <li><asp:LinkButton ID="LinkButton9" runat="server"  Visible='<%# !(Container is GridEditFormInsertItem) %>' OnClientClick ='<%# String.Format("javascript:return PrintOnClientLinkClickedEdit2({0})",Eval("C_BILL")) %>' ><img style="border:0px;vertical-align:middle;" alt="" src="Images/print.gif"/>In 2 bản</asp:LinkButton></li>
                <li><asp:LinkButton ID="LinkButton10" runat="server"  Visible='<%# !(Container is GridEditFormInsertItem) %>' OnClientClick ='<%# String.Format("javascript:return PrintOnClientLinkClickedEdit3({0})",Eval("C_BILL")) %>' ><img style="border:0px;vertical-align:middle;" alt="" src="Images/print.gif"/>In kim</asp:LinkButton></li>
              </ul>
            </div>               
            <div class="clearfix bgpopup"> 
            <div style="width:900px; height:500px; background:#FFFFFF" class="clearfix">      
            <table id="tblEdit" class ="TableEditInGrid" cellspacing="3" cellpadding="3" style="width: 100%" border="0">
            <tr>
                <td style ="width:100px;"> <span class="rtsTxtnew">Ngày nhận gửi:</td>
                <td colspan="4">
                    <telerik:RadDateTimePicker ID="radNgaynhangui" Width ="95%" DbSelectedDate ='<%# Bind("C_NGAY") %>' runat="server" AutoPostBack ="false" >
                        <DateInput ID ="DateInput1" runat ="server" DateFormat ="dd/MM/yyyy hh:mm tt" MinDate="1/1/1890 12:00:00 AM">
                        <ClientEvents  OnKeyPress ="controlkeypress"/>
                        </DateInput>
                    </telerik:RadDateTimePicker>
                </td>
                <td style ="width:100px;"> <span class="rtsTxtnew">Số Bill:</span></td>
                <td colspan="4">
                    <asp:HiddenField ID="txtID" Value ='<%# Eval("PK_ID") %>' runat="server" />
                    BC<telerik:RadNumericTextBox ID="txtCODE" Width ="80%" Text='<%# Bind("C_BILL") %>' runat="server">
                        <NumberFormat DecimalSeparator ="." GroupSeparator ="" DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                    <asp:RequiredFieldValidator ID="rfvCODE" runat="server" ErrorMessage="Số Bill không thể rỗng" ControlToValidate="txtCODE" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="cuvCODE" ControlToValidate="txtCODE" OnServerValidate="CheckBill" runat="server" ErrorMessage="Số Bill đã tồn tại" Display="Dynamic" ValidationGroup="G1"></asp:CustomValidator>
                </td>               
            </tr>
            <tr>
                <td style ="width:100px;"> <span class="rtsTxtnew">Mã khách hàng:</span></td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbMaKhachHang" runat="server"  onclientload="OnClientLoadcmbMaKhachHang" 
                    DataTextField="C_CODE" DataValueField="C_CODE" DataSourceID="KHACHHANGDataSource" SelectedValue='<%# Bind("FK_KHACHHANG") %>'
                    ShowToggleImage="True" EmptyMessage="Chọn mã" onclientselectedindexchanged="cmbMaKhachHangClientSelectedIndexChangedHandler" AllowCustomText="True" Filter="Contains">
                    </telerik:RadComboBox>
                </td>
                <td style ="width:100px;"> <span class="rtsTxtnew">Tên người gửi:</span></td>
                <td colspan="4">
                    <telerik:RadTextBox ID="txtC_TENKH" Width ="90%" Text='<%# Bind("C_TENKH") %>' ClientEvents-OnLoad="OnClientLoadtxtC_TENKH" runat="server"></telerik:RadTextBox>                               
                </td>
                <td style ="width:100px;"> <span class="rtsTxtnew">ĐT người gửi:</span></td>
                <td colspan="4">
                   <telerik:RadTextBox ID="txtC_TELGUI" Width ="90%" Text='<%# Bind("C_TELGUI") %>' ClientEvents-OnLoad="OnClientLoadtxtC_TELGUI" runat="server"></telerik:RadTextBox>               
                </td>            
            </tr> 
            <tr> 
                <td style ="width:100px;"> <span class="rtsTxtnew">Người nhận:</span></td>
                <td colspan="4">
                    <telerik:RadTextBox ID="txtC_NGUOINHAN" Width ="90%" Text='<%# Bind("C_NGUOINHAN") %>' runat="server"></telerik:RadTextBox>
                </td>               
                <td style =" width:100px;"> <span class="rtsTxtnew">Địa chỉ nhận:</span></td>
                <td colspan="4">
                    <telerik:RadTextBox ID="txtC_DIACHINHAN" Width ="90%" Text='<%# Bind("C_DIACHINHAN") %>' runat="server"></telerik:RadTextBox>
                </td>
                <td style ="width:100px;"> <span class="rtsTxtnew">ĐT người nhận:</span></td>
                <td colspan="4">
                   <telerik:RadTextBox ID="RadTextBox1" Width ="90%" Text='<%# Bind("C_TELNHAN") %>' runat="server"></telerik:RadTextBox>               
                </td>
            </tr> 
            <tr> 
                <td style ="width:100px;"> <span class="rtsTxtnew">Tỉnh thành:</span></td>
                <td colspan="4">
                    <asp:HiddenField ID="hfTinhThanh" runat="server" Value ='<%# cFunction.LoadIDTinhThanhCode(Eval("FK_QUANHUYEN").ToString()) %>' />
                    <telerik:RadComboBox ID="cmbTinhThanh" runat="server"
                    DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="TINHTHANHDataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn tỉnh"
                    onclientselectedindexchanged="cmbTinhThanhClientSelectedIndexChangedHandler">
                    </telerik:RadComboBox>
                </td>               
                <td style =" width:100px;"> <span class="rtsTxtnew">Quận huyện:</span></td>
                <td colspan="12">
                    <asp:HiddenField ID="hfQuanHuyen" runat="server"  Value ='<%# Bind("FK_QUANHUYEN") %>'/>
                    <telerik:RadComboBox ID="cmbQuanHuyen" runat="server" 
                    DataTextField="C_NAME" DataValueField="C_CODE" DataSourceID="QUANHUYENDataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn quận huyện" 
                    onclientitemsrequested="ItemsLoadedQuanHuyen" onclientload="OnClientLoadQuanHuyen" 
                    onitemsrequested="cmbQuanHuyen_ItemsRequested" onclientselectedindexchanged="cmbQuanHuyenClientSelectedIndexChangedHandler">
                    </telerik:RadComboBox>
                </td>
            </tr> 
            <tr> 
                <td style =" width:100px;"> <span class="rtsTxtnew">Nội dung:</span></td>
                <td colspan="9">
                    <telerik:RadTextBox ID="txtC_NOIDUNG" Width ="95%" Text='<%# Bind("C_NOIDUNG") %>' runat="server"></telerik:RadTextBox>
                </td>
                <td style =" width:100px;"> <span class="rtsTxtnew">Số kiện:</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="RadNumericTextBox1" Width ="90%" Runat="server" Text='<%# Bind("C_SOKIEN") %>'>
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td> 
            </tr>
            <tr>                
                <td style =" width:100px;"> <span class="rtsTxtnew">Giá trị hàng hoá:</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_GIATRIHANGHOA" Width ="90%" Runat="server" Text='<%# Bind("C_GIATRIHANGHOA") %>' ClientEvents-OnLoad="OnClientLoadtxtC_GIATRIHANGHOA" ClientEvents-OnValueChanged="OnValueChangedtxtC_GIATRIHANGHOA">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>               
                <td style =" width:100px;"> <span class="rtsTxtnew">KL thực (g):</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_KHOILUONGTHUC" Width ="90%" Runat="server" Text='<%# Bind("C_KHOILUONGTHUC") %>' ClientEvents-OnValueChanged="OnValueChangedtxtC_KHOILUONGTHUC" ClientEvents-OnLoad="OnClientLoadtxtC_KHOILUONGTHUC">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>
                <td style =" width:100px;"> <span class="rtsTxtnew">KL quy đổi (g):</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_KHOILUONGQD" Width ="90%" Runat="server" Text='<%# Bind("C_KHOILUONGQD") %>' ClientEvents-OnValueChanged="OnValueChangedtxtC_KHOILUONGQD" ClientEvents-OnLoad="OnClientLoadtxtC_KHOILUONGQD">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>
            </tr
            <tr>                
                <td style =" width:100px;"> <span class="rtsTxtnew">Dịch vụ:</span></td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbSanPham" runat="server" SelectedValue='<%# Bind("FK_MASANPHAM") %>'
                    DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="MASANPHAMDataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn dịch vụ" onclientselectedindexchanged="cmbSanPhamClientSelectedIndexChangedHandler">
                    </telerik:RadComboBox>
                </td>               
                <td style =" width:100px;"> <span class="rtsTxtnew">Khối lượng (g):</span></td>
                <td colspan="4">
                     <telerik:RadNumericTextBox  ID="txtC_KHOILUONG" Width ="90%" Runat="server" Text='<%# Bind("C_KHOILUONG") %>' ClientEvents-OnValueChanged="OnValueChangedtxtC_KHOILUONG" ClientEvents-OnLoad="OnClientLoadtxtC_KHOILUONG">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>
                <td style =" width:100px;"> <span class="rtsTxtnew">Cước chính:</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_GIACUOC" Width ="90%" Runat="server" Text='<%# Bind("C_GIACUOC") %>' ClientEvents-OnLoad="OnClientLoadtxtC_GIACUOC" ClientEvents-OnValueChanged="OnValueChangedtxtC_GIACUOC">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>
            </tr
            <tr>
                <td style =" width:100px;"><span class="rtsTxtnew">PPXD:</span></td>
                <td colspan="4">
                     <telerik:RadNumericTextBox  ID="txtPPXD" Width ="90%" Text='<%# Bind("C_PPXD") %>' Runat="server" ClientEvents-OnLoad="OnClientLoadtxtPPXD" ClientEvents-OnValueChanged="OnValueChangedtxtPPXD">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>          
                <td style =" width:100px;"><span class="rtsTxtnew"><input id="btnC_DONGGOI" type="checkbox" onclick="SetC_DONGGOI();" value="false"/>Đóng gói:</td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_DONGGOI" Width ="90%" Runat="server" Text='<%# Bind("C_DONGGOI") %>' ClientEvents-OnLoad="OnClientLoadtxtC_DONGGOI" ClientEvents-OnValueChanged="OnValueChangedtxtC_DONGGOI">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>
                <td style =" width:100px;"><span class="rtsTxtnew"><input id="btnC_KHAIGIA" type="checkbox" onclick="SetC_KHAIGIA();" value="false"/>Khai giá:</td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_KHAIGIA" Width ="90%" Runat="server" Text='<%# Bind("C_KHAIGIA") %>' ClientEvents-OnLoad="OnClientLoadtxtC_KHAIGIA" ClientEvents-OnValueChanged="OnValueChangedtxtC_KHAIGIA">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                     </telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>                
                <td style =" width:100px;"> <span class="rtsTxtnew"><input id="btnC_COD" type="checkbox" onclick="SetC_COD();" value="false"/>COD:</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_COD" Width ="90%" Runat="server" Text='<%# Bind("C_COD") %>' ClientEvents-OnLoad="OnClientLoadtxtC_COD" ClientEvents-OnValueChanged="OnValueChangedtxtC_COD">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>                
                <td style =" width:100px;"><span class="rtsTxtnew"><input id="btnC_BAOPHAT" type="checkbox" onclick="SetC_BAOPHAT();" value="false"/>Báo phát:</td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_BAOPHAT" Width ="90%" Runat="server" Text='<%# Bind("C_BAOPHAT") %>' ClientEvents-OnLoad="OnClientLoadtxtC_BAOPHAT" ClientEvents-OnValueChanged="OnValueChangedtxtC_BAOPHAT">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>
                <td style =" width:100px;"><span class="rtsTxtnew"><input id="btnC_HENGIO" type="checkbox" onclick="SetC_HENGIO();" value="false"/>Hẹn giờ:</td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_HENGIO" Width ="90%" Runat="server" Text='<%# Bind("C_HENGIO") %>' ClientEvents-OnLoad="OnClientLoadtxtC_HENGIO" ClientEvents-OnValueChanged="OnValueChangedtxtC_HENGIO">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>                
            </tr>
            <tr>  
                <td style =" width:100px;"><span class="rtsTxtnew">Tổng cước:</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_TIENHANG" Width ="90%" Runat="server" Text='<%# Bind("C_TIENHANG") %>' ClientEvents-OnLoad="OnClientLoadtxtC_TIENHANG" ClientEvents-OnValueChanged="OnValueChangedtxtC_TIENHANG">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>                 
                </td>                
                <td style =" width:100px;"> <span class="rtsTxtnew">VAT:</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_VAT" Width ="90%" Runat="server" Text='<%# Bind("C_VAT") %>' ClientEvents-OnLoad="OnClientLoadtxtC_VAT" ClientEvents-OnValueChanged="OnValueChangedtxtC_VAT">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>                
                <td style =" width:110px;"><span class="rtsTxtnew">Tổng cước (VAT)<br /><input id="btnGiaCuoi" type="checkbox" onclick="SetGiaCuoi();" value="false"/>Theo giá cuối:</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_TIENHANGVAT" Width ="90%" Runat="server" Text='<%# Bind("C_TIENHANGVAT") %>' ClientEvents-OnLoad="OnClientLoadtxtC_TIENHANGVAT" ClientEvents-OnValueChanged="OnValueChangedtxtC_TIENHANGVAT">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>                
            </tr>
            <tr>                         
                <td style =" width:100px;"> <span class="rtsTxtnew">HTTT:</span></td>
                <td colspan="4">
                 <telerik:RadComboBox ID="cmbC_HINHTHUCTT" SelectedValue='<%# Bind("C_HINHTHUCTT") %>' runat="server" EmptyMessage="Chọn" onclientselectedindexchanged="cmbC_HINHTHUCTTClientSelectedIndexChangedHandler">
                            <Items>
                                <telerik:RadComboBoxItem Value ="Thanh toán ngay" Text ="Thanh toán ngay" />
                                <telerik:RadComboBoxItem Value ="Thanh toán sau" Text ="Thanh toán sau" />
                                <telerik:RadComboBoxItem Value ="Thanh toán đầu nhận" Text ="Thanh toán đầu nhận" />
                                <telerik:RadComboBoxItem Value ="Đã thanh toán" Text ="Đã thanh toán" />
                                <telerik:RadComboBoxItem Value ="Khác" Text ="Khác" />
                            </Items>
                 </telerik:RadComboBox>
                </td>               
                <td style =" width:100px;"> <span class="rtsTxtnew">Đã thu:</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_DATHU" Width ="90%" Runat="server" Text='<%# Bind("C_DATHU") %>' ClientEvents-OnValueChanged="OnValueChangedtxtC_DATHU" ClientEvents-OnLoad="OnClientLoadtxtC_DATHU">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>
                <td style =" width:100px;"> <span class="rtsTxtnew">Còn lại:</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_CONLAI" Width ="90%" Runat="server" ClientEvents-OnLoad="OnClientLoadtxtC_CONLAI">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>
            </tr
            <tr>                
                <td style =" width:100px;"><span class="rtsTxtnew">Nhân viên nhận:</span></td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbFK_NHANVIENNHAN" runat="server" SelectedValue='<%# Bind("FK_NHANVIENNHAN") %>'
                    DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="UserDataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn">
                    </telerik:RadComboBox>
                </td>
                <td style =" width:100px;"><span class="rtsTxtnew">Đối tác:</span></td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbFK_DOITAC" runat="server" SelectedValue='<%# Bind("FK_DOITAC") %>'
                    DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="DoitacDataSource" onclientselectedindexchanged="cmbFK_DOITACClientSelectedIndexChangedHandler"
                    ShowToggleImage="True" EmptyMessage="Chọn">
                    </telerik:RadComboBox>
                </td>
                <td style =" width:100px;"><span class="rtsTxtnew">Giá đối tác:</span></td>
                <td colspan="4">
                     <telerik:RadNumericTextBox  ID="txtC_GIADOITAC" Width ="90%" Runat="server" Text='<%# Bind("C_GIADOITAC") %>' ClientEvents-OnLoad="OnClientLoadtxtC_GIADOITAC">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>
                <td style =" width:100px;"> <span class="rtsTxtnew">Nhân viên phát:</span></td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbFK_NHANVIENPHAT" runat="server" SelectedValue='<%# Bind("FK_NHANVIENPHAT") %>'
                    DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="UserDataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn">
                    </telerik:RadComboBox>
                </td>
                <td style =" width:100px;"> <span class="rtsTxtnew">Ngày giờ phát:</span></td>
                <td colspan="4">
                    <telerik:RadDateTimePicker ID="radC_NGAYGIOPHAT"  Width ="95%" DbSelectedDate ='<%# Bind("C_NGAYGIOPHAT") %>' runat="server" AutoPostBack ="false">
                        <DateInput ID ="DateInput2" runat ="server" DateFormat ="dd/MM/yyyy hh:mm tt" MinDate="1/1/1890 12:00:00 AM">
                        <ClientEvents  OnKeyPress ="controlkeypress"/>
                        </DateInput>
                    </telerik:RadDateTimePicker>
                </td>
                <td style =" width:100px;"><span class="rtsTxtnew">Nhân viên KT:</span></td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbFK_NHANVIENKHAITHAC" runat="server" SelectedValue='<%# Bind("FK_NHANVIENKHAITHAC") %>'
                    DataTextField="C_NAME" DataValueField="PK_ID" DataSourceID="UserDataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn">
                    </telerik:RadComboBox>
             </td>
            </tr>
             <tr>             
             <td style =" width:100px;"><span class="rtsTxtnew">Người ký nhận:</span></td>
                <td colspan="4">
                     <telerik:RadTextBox ID="txtC_NGUOIKYNHAN" Width ="90%" Text='<%# Bind("C_NGUOIKYNHAN") %>' runat="server"></telerik:RadTextBox>
                </td>
                <td style =" width:100px;"> <span class="rtsTxtnew">Bộ phận:</span></td>
                <td colspan="4">
                    <telerik:RadTextBox ID="txtC_BOPHAN" Width ="90%" Text='<%# Bind("C_BOPHAN") %>' runat="server"></telerik:RadTextBox>
                </td>
                <td style =" width:100px;"> <span class="rtsTxtnew">Trạng thái:</span></td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbFK_TRANGTHAI" runat="server" SelectedValue='<%# Bind("FK_TRANGTHAI") %>'
                    DataTextField="C_NAME" DataValueField="C_NAME" DataSourceID="FK_TRANGTHAIDataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn">
                    </telerik:RadComboBox>
                </td>
            </tr>
           </table>
            </div> 
             </center> 
        <!-- end bgpopup--></div>    
             </FormTemplate>
        </EditFormSettings>
        </MasterTableView>
        <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G1"/>
        <ClientSettings AllowKeyboardNavigation="true" KeyboardNavigationSettings-AllowSubmitOnEnter="true" ClientEvents-OnKeyPress="KeyPressed">
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
            <ClientEvents OnPopUpShowing="PopUpShowing" />
            <ClientEvents OnRowDblClick="RowDblClick" />
            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="True" FrozenColumnsCount="3" ScrollHeight="400px" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<asp:SqlDataSource ID="NHANGUIDataSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>" 
    DeleteCommand="DELETE FROM [NHANGUI] WHERE [C_BILL] = @C_BILL;DELETE FROM [SOQUYTIENMAT] WHERE [C_BILL] = @C_BILL" 
    InsertCommand="INSERT INTO [NHANGUI] ([C_NGAY], [C_BILL], [FK_KHACHHANG], [C_TENKH], [C_TELGUI], [C_NGUOINHAN], [C_DIACHINHAN], [C_TELNHAN], [FK_QUANHUYEN], [C_NOIDUNG], [C_SOKIEN], [C_GIATRIHANGHOA], [FK_MASANPHAM], [C_PPXD], [C_KHOILUONGTHUC], [C_KHOILUONGQD], [C_KHOILUONG], [C_GIACUOC], [C_DONGGOI], [C_KHAIGIA], [C_COD], [C_BAOPHAT], [C_HENGIO], [C_HINHTHUCTT], [C_DATHU], [C_TIENHANG], [C_VAT], [C_TIENHANGVAT], [FK_NHANVIENNHAN], [FK_DOITAC], [C_GIADOITAC], [FK_NHANVIENPHAT], [C_NGAYGIOPHAT], [FK_NHANVIENKHAITHAC], [C_NGUOIKYNHAN], [C_BOPHAN],[C_TYPE],[FK_VUNGLAMVIEC],[FK_TRANGTHAI]) VALUES (@C_NGAY, @C_BILL, @FK_KHACHHANG, @C_TENKH, @C_TELGUI, @C_NGUOINHAN, @C_DIACHINHAN, @C_TELNHAN, @FK_QUANHUYEN, @C_NOIDUNG, @C_SOKIEN, @C_GIATRIHANGHOA, @FK_MASANPHAM, @C_PPXD, @C_KHOILUONGTHUC, @C_KHOILUONGQD, @C_KHOILUONG, @C_GIACUOC, @C_DONGGOI, @C_KHAIGIA, @C_COD, @C_BAOPHAT, @C_HENGIO, @C_HINHTHUCTT, @C_DATHU, @C_TIENHANG, @C_VAT, @C_TIENHANGVAT, @FK_NHANVIENNHAN, @FK_DOITAC, @C_GIADOITAC, @FK_NHANVIENPHAT, @C_NGAYGIOPHAT, @FK_NHANVIENKHAITHAC, @C_NGUOIKYNHAN, @C_BOPHAN,1,@FK_VUNGLAMVIEC,@FK_TRANGTHAI);INSERT INTO [SOQUYTIENMAT] ([C_NGAY], [C_TYPE], [FK_KIHIEUTAIKHOAN], [C_DESC], [C_SOTIEN], [C_BILL],[C_TON],[C_ORDER],[FK_VUNGLAMVIEC]) VALUES (@C_NGAY,N'Thu',NULL, N'Bill ' + @C_BILL, @C_DATHU,@C_BILL,0,1,@FK_VUNGLAMVIEC)"
    SelectCommand="SELECT [NHANGUI].[PK_ID], [NHANGUI].[C_NGAY], [NHANGUI].[FK_KHACHHANG], [NHANGUI].[C_BILL], [NHANGUI].[C_TENKH], [NHANGUI].[C_TELGUI], [NHANGUI].[C_NGUOINHAN], [NHANGUI].[C_DIACHINHAN], [NHANGUI].[C_TELNHAN], [NHANGUI].[FK_QUANHUYEN], [NHANGUI].[C_NOIDUNG], [NHANGUI].[C_SOKIEN], [NHANGUI].[C_GIATRIHANGHOA], [NHANGUI].[FK_MASANPHAM],  [NHANGUI].[C_PPXD], [NHANGUI].[C_KHOILUONGTHUC], [NHANGUI].[C_KHOILUONGQD], [NHANGUI].[C_KHOILUONG], [NHANGUI].[C_GIACUOC], [NHANGUI].[C_DONGGOI], [NHANGUI].[C_KHAIGIA], [NHANGUI].[C_COD], [NHANGUI].[C_BAOPHAT], [NHANGUI].[C_HENGIO], [NHANGUI].[C_HINHTHUCTT], [NHANGUI].[C_DATHU], ([NHANGUI].[C_TIENHANGVAT] - [NHANGUI].[C_DATHU]) as [C_CONLAI],([NHANGUI].[C_DONGGOI] + [NHANGUI].[C_KHAIGIA] + [NHANGUI].[C_COD] + [NHANGUI].[C_BAOPHAT] + [NHANGUI].[C_HENGIO]) as [C_PHUTROISUM], [NHANGUI].[C_TIENHANG], [NHANGUI].[C_VAT], [NHANGUI].[C_TIENHANGVAT], [NHANGUI].[FK_NHANVIENNHAN], [NHANGUI].[FK_DOITAC], [NHANGUI].[C_GIADOITAC], [NHANGUI].[FK_NHANVIENPHAT], [NHANGUI].[C_NGAYGIOPHAT], [NHANGUI].[FK_NHANVIENKHAITHAC], [NHANGUI].[C_NGUOIKYNHAN], [NHANGUI].[C_BOPHAN],[NHANGUI].FK_TRANGTHAI, USERSNHAN.C_NAME as NHANVIENNHANNAME,USERSPHAT.C_NAME as NHANVIENPHATNAME,USERSKHAITHAC.C_NAME as NHANVIENKHAITHACNAME,DMMASANPHAM.C_NAME as SANPHAMNAME,DMQUANHUYEN.C_NAME as QUANHUYENNAME,DMTINHTHANH.C_NAME as TINHTHANHNAME FROM [NHANGUI] LEFT OUTER JOIN USERS as USERSNHAN ON NHANGUI.FK_NHANVIENNHAN = USERSNHAN.PK_ID LEFT OUTER JOIN USERS as USERSPHAT ON NHANGUI.FK_NHANVIENPHAT = USERSPHAT.PK_ID LEFT OUTER JOIN USERS as USERSKHAITHAC ON NHANGUI.FK_NHANVIENKHAITHAC = USERSKHAITHAC.PK_ID LEFT OUTER JOIN DMMASANPHAM ON NHANGUI.FK_MASANPHAM=DMMASANPHAM.PK_ID LEFT OUTER JOIN DMQUANHUYEN ON NHANGUI.FK_QUANHUYEN = DMQUANHUYEN.C_CODE LEFT OUTER JOIN DMTINHTHANH ON DMQUANHUYEN.FK_TINHTHANH = DMTINHTHANH.PK_ID WHERE [NHANGUI].[C_TYPE] = 1 AND [NHANGUI].FK_VUNGLAMVIEC = @FK_VUNGLAMVIEC ORDER BY [NHANGUI].C_NGAY DESC" 
    UpdateCommand="UPDATE [SOQUYTIENMAT] SET [C_NGAY]=CASE WHEN @C_HINHTHUCTT = N'Đã thanh toán' THEN GETDATE() ELSE C_NGAY END,[C_SOTIEN] = @C_DATHU, [C_DESC] = N'Bill ' + @C_BILL, [C_BILL] = @C_BILL WHERE [C_BILL]= @C_BILL;UPDATE [NHANGUI] SET [C_NGAY] = @C_NGAY, [C_BILL] = @C_BILL, [FK_KHACHHANG] = @FK_KHACHHANG,[C_TENKH] = @C_TENKH, [C_TELGUI] = @C_TELGUI, [C_NGUOINHAN] = @C_NGUOINHAN, [C_DIACHINHAN] = @C_DIACHINHAN, [C_TELNHAN] = @C_TELNHAN, [FK_QUANHUYEN] = @FK_QUANHUYEN, [C_NOIDUNG] = @C_NOIDUNG, [C_SOKIEN] = @C_SOKIEN, [C_GIATRIHANGHOA] = @C_GIATRIHANGHOA, [FK_MASANPHAM] = @FK_MASANPHAM, [C_PPXD] = @C_PPXD, [C_KHOILUONGTHUC] = @C_KHOILUONGTHUC, [C_KHOILUONGQD] = @C_KHOILUONGQD, [C_KHOILUONG] = @C_KHOILUONG, [C_GIACUOC] = @C_GIACUOC, [C_DONGGOI]=@C_DONGGOI, [C_KHAIGIA]=@C_KHAIGIA, [C_COD]=@C_COD, [C_BAOPHAT]=@C_BAOPHAT, [C_HENGIO]=@C_HENGIO, [C_HINHTHUCTT] = @C_HINHTHUCTT, [C_DATHU] = @C_DATHU, [C_TIENHANG] = @C_TIENHANG, [C_VAT] = @C_VAT, [C_TIENHANGVAT] = @C_TIENHANGVAT, [FK_NHANVIENNHAN] = @FK_NHANVIENNHAN, [FK_DOITAC] = @FK_DOITAC, [C_GIADOITAC] = @C_GIADOITAC, [FK_NHANVIENPHAT] = @FK_NHANVIENPHAT, [C_NGAYGIOPHAT] = @C_NGAYGIOPHAT, [FK_NHANVIENKHAITHAC]=@FK_NHANVIENKHAITHAC, [C_NGUOIKYNHAN] = @C_NGUOIKYNHAN, [C_BOPHAN] = @C_BOPHAN, [FK_TRANGTHAI] = @FK_TRANGTHAI WHERE [C_BILL] = @C_BILL">
    <SelectParameters>
        <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="C_BILL" Type="string" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="C_NGAY" Type="DateTime" />
        <asp:Parameter Name="C_BILL" Type="String" />
        <asp:Parameter Name="FK_KHACHHANG" Type="String" />
        <asp:Parameter Name="C_TENKH" Type="String" />
        <asp:Parameter Name="C_TELGUI" Type="String" />
        <asp:Parameter Name="C_NGUOINHAN" Type="String" />
        <asp:Parameter Name="C_DIACHINHAN" Type="String" />
        <asp:Parameter Name="C_TELNHAN" Type="String" />
        <asp:Parameter Name="FK_QUANHUYEN" Type="String" />
        <asp:Parameter Name="C_NOIDUNG" Type="String" />
        <asp:Parameter Name="C_SOKIEN" Type="Int32" />
        <asp:Parameter Name="C_GIATRIHANGHOA" Type="String" />
        <asp:Parameter Name="FK_MASANPHAM" Type="Int32" />
        <asp:Parameter Name="C_PPXD" Type="Single" />
        <asp:Parameter Name="C_KHOILUONGTHUC" Type="Single" />
        <asp:Parameter Name="C_KHOILUONGQD" Type="Single" />
        <asp:Parameter Name="C_KHOILUONG" Type="Single" />
        <asp:Parameter Name="C_GIACUOC" Type="Single" />
        <asp:Parameter Name="C_DONGGOI" Type="String" />
        <asp:Parameter Name="C_KHAIGIA" Type="String" />
        <asp:Parameter Name="C_COD" Type="String" />
        <asp:Parameter Name="C_BAOPHAT" Type="String" />
        <asp:Parameter Name="C_HENGIO" Type="String" />
        <asp:Parameter Name="C_HINHTHUCTT" Type="String" />
        <asp:Parameter Name="C_DATHU" Type="String" DefaultValue="0" />
        <asp:Parameter Name="C_TIENHANG" Type="String" DefaultValue="0" />
        <asp:Parameter Name="C_VAT" Type="String" />
        <asp:Parameter Name="C_TIENHANGVAT" Type="String" />
        <asp:Parameter Name="FK_NHANVIENNHAN" Type="Int32" />
        <asp:Parameter Name="FK_DOITAC" Type="Int32" />
        <asp:Parameter Name="C_GIADOITAC" Type="Single" />
        <asp:Parameter Name="FK_NHANVIENPHAT" Type="Int32" />
        <asp:Parameter Name="C_NGAYGIOPHAT" Type="DateTime" />
        <asp:Parameter Name="FK_NHANVIENKHAITHAC" Type="Int32" />
        <asp:Parameter Name="C_NGUOIKYNHAN" Type="String" />
        <asp:Parameter Name="C_BOPHAN" Type="String" />
        <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
        <asp:Parameter Name="FK_TRANGTHAI" Type="String" />        
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="C_NGAY" Type="DateTime" />
        <asp:Parameter Name="FK_KHACHHANG" Type="String" />
        <asp:Parameter Name="C_TENKH" Type="String" />
        <asp:Parameter Name="C_TELGUI" Type="String" />
        <asp:Parameter Name="C_NGUOINHAN" Type="String" />
        <asp:Parameter Name="C_DIACHINHAN" Type="String" />
        <asp:Parameter Name="C_TELNHAN" Type="String" />
        <asp:Parameter Name="FK_QUANHUYEN" Type="String" />
        <asp:Parameter Name="C_NOIDUNG" Type="String" />
        <asp:Parameter Name="C_SOKIEN" Type="Int32" />
        <asp:Parameter Name="C_GIATRIHANGHOA" Type="String" />
        <asp:Parameter Name="FK_MASANPHAM" Type="Int32" />
        <asp:Parameter Name="C_PPXD" Type="Single" />
        <asp:Parameter Name="C_KHOILUONGTHUC" Type="Single" />
        <asp:Parameter Name="C_KHOILUONGQD" Type="Single" />
        <asp:Parameter Name="C_KHOILUONG" Type="Single" />
        <asp:Parameter Name="C_GIACUOC" Type="Single" />
        <asp:Parameter Name="C_DONGGOI" Type="String" />
        <asp:Parameter Name="C_KHAIGIA" Type="String" />
        <asp:Parameter Name="C_COD" Type="String" />
        <asp:Parameter Name="C_BAOPHAT" Type="String" />
        <asp:Parameter Name="C_HENGIO" Type="String" />
        <asp:Parameter Name="C_HINHTHUCTT" Type="String" />
        <asp:Parameter Name="C_DATHU" Type="String" DefaultValue="0" />
        <asp:Parameter Name="C_TIENHANG" Type="String" DefaultValue="0" />
        <asp:Parameter Name="C_VAT" Type="String" />
        <asp:Parameter Name="C_TIENHANGVAT" Type="String" />
        <asp:Parameter Name="FK_NHANVIENNHAN" Type="Int32" />
        <asp:Parameter Name="FK_DOITAC" Type="Int32" />
        <asp:Parameter Name="C_GIADOITAC" Type="Single" />
        <asp:Parameter Name="FK_NHANVIENPHAT" Type="Int32" />
        <asp:Parameter Name="C_NGAYGIOPHAT" Type="DateTime" />
        <asp:Parameter Name="FK_NHANVIENKHAITHAC" Type="Int32" />
        <asp:Parameter Name="C_NGUOIKYNHAN" Type="String" />
        <asp:Parameter Name="C_BOPHAN" Type="String" />
        <asp:Parameter Name="FK_TRANGTHAI" Type="String" />   
        <asp:Parameter Name="C_BILL" Type="string" />
    </UpdateParameters>       
</asp:SqlDataSource>
<asp:SqlDataSource ID="KHACHHANGDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
 SelectCommand="SELECT DMKHACHHANG.* FROM DMKHACHHANG LEFT OUTER JOIN DMNHOMKHACHHANG ON DMKHACHHANG.FK_NHOMKHACHHANG = DMNHOMKHACHHANG.PK_ID WHERE DMNHOMKHACHHANG.FK_VUNGLAMVIEC = @FK_VUNGLAMVIEC" >
 <SelectParameters>
     <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
 </SelectParameters>
</asp:SqlDataSource>
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
<asp:SqlDataSource ID="UserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT USERS.PK_ID,USERS.FK_GroupUser,USERS.FK_DEPT,USERS.C_LoginName,USERS.C_Password,USERS.C_NAME,USERS.C_Address,USERS.c_Tel,USERS.C_Email,USERS.C_DESC,GROUPUSER.C_NAME AS GROUPUSERNAME FROM USERS INNER JOIN GROUPUSER ON  USERS.FK_GROUPUSER = GROUPUSER.PK_ID WHERE FK_GROUPUSER NOT IN (0,1)">
</asp:SqlDataSource>
<asp:SqlDataSource ID="DoiTacDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMDoiTac] WHERE [DMDOITAC].FK_VUNGLAMVIEC = @FK_VUNGLAMVIEC ORDER BY LTRIM([C_CODE])">
    <SelectParameters>
            <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="DoiTacDataSourceFix" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMDoiTac] WHERE [DMDOITAC].FK_VUNGLAMVIEC = @FK_VUNGLAMVIEC AND [DMDOITAC].C_TYPE = N'Nhập nhanh BILL' ORDER BY LTRIM([C_CODE])">
    <SelectParameters>
            <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="FK_TRANGTHAIDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMTRANGTHAI]">
</asp:SqlDataSource>
<asp:Button ID="Button1" runat="server" onclick="Button1_Click" Visible=false Text="Button" />
<asp:TextBox ID="TextBox1" runat="server" Visible=false></asp:TextBox>