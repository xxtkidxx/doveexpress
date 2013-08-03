<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NHANGUIQT.ascx.cs" Inherits="module_NHANGUIQT" %>
<%@ Register TagPrefix="uc1" Namespace="ITCLIB.Admin" %>
<telerik:RadCodeBlock ID="RadCodeBlockNHANGUIQT" runat="server">
<script type="text/javascript">
    function PrintOnClientLinkClicked() {
        if ($find("<%= RadGridNHANGUIQT.MasterTableView.ClientID %>").get_selectedItems().length != 0) {
            var IDNHANGUI = $find("<%= RadGridNHANGUIQT.MasterTableView.ClientID %>").get_selectedItems()[0].getDataKeyValue("PK_ID")
            var url = "Report.aspx?TYPE=INBILLQT&ID=" + IDNHANGUI;
            window.open(url, '_blank');
            window.focus();
        } else {
            alert("Không có phiếu nhận gửi được chọn");
        }
    }
</script>
<script type="text/javascript">
    var flag = false;
    var CUOCCHINH;
    function RowDblClick(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("NHANGUIQT") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewNHANGUIQT") && (CanEdit == "True")) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
    }
    var cmbMaKhachHang;
    function OnClientLoadcmbMaKhachHang(sender) {
        cmbMaKhachHang = sender;
    }
    var radautoC_TENKH;
    function OnClientLoadradautoC_TENKH(sender) {
        radautoC_TENKH = sender;
    }
     var txtC_TELGUI;
    function OnClientLoadtxtC_TELGUI(sender) {
        txtC_TELGUI = sender;
    }
    var cmbQuocGia;
    function OnClientLoadQuocGia(sender) {
        cmbQuocGia = sender;
    }
    function cmbQuocGiaClientSelectedIndexChangedHandler(sender, eventArgs) {
        $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("cmbQuocGia;" + eventArgs.get_item().get_value());
        var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelNHANGUIQT.ClientID %>");
        var currentUpdatedControl = "<%= RadGridNHANGUIQT.ClientID %>"; 
        currentLoadingPanel.show(currentUpdatedControl);
        return false;
    }
    function cmbSanPhamClientSelectedIndexChangedHandler(sender, eventArgs) {
         $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("cmbSanPham;" + eventArgs.get_item().get_value());
         var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelNHANGUIQT.ClientID %>");
        var currentUpdatedControl = "<%= RadGridNHANGUIQT.ClientID %>"; 
        currentLoadingPanel.show(currentUpdatedControl);
         return false;
    }
   function cmbMaKhachHangClientSelectedIndexChangedHandler(sender, eventArgs) {
         $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("cmbMaKhachHang;" + eventArgs.get_item().get_value());
         var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelNHANGUIQT.ClientID %>");
         var currentUpdatedControl = "<%= RadGridNHANGUIQT.ClientID %>"; 
         currentLoadingPanel.show(currentUpdatedControl);
         return false;
    }
    function cmbFK_DOITACClientSelectedIndexChangedHandler(sender, eventArgs) {
         $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("cmbFK_DOITAC;" + eventArgs.get_item().get_value());
         var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelNHANGUIQT.ClientID %>");
        var currentUpdatedControl = "<%= RadGridNHANGUIQT.ClientID %>"; 
        currentLoadingPanel.show(currentUpdatedControl);
         return false;
    }    
    function OnValueChangedtxtC_KHOILUONG(sender, eventArgs) {
        $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("txtC_KHOILUONG;" + eventArgs.get_newValue());
        var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelNHANGUIQT.ClientID %>");
        var currentUpdatedControl = "<%= RadGridNHANGUIQT.ClientID %>"; 
        currentLoadingPanel.show(currentUpdatedControl);
        return false;
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
    var txtC_KHAC;
    function OnClientLoadtxtC_KHAC(sender) {
        txtC_KHAC = sender;
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
        txtPPXD.set_value(txtC_GIACUOC.get_value() * PPXD/100);
        if (!flag) {
            txtC_TIENHANG.set_value(txtC_GIACUOC.get_value() + txtPPXD.get_value() + txtC_KHAC.get_value() + txtC_COD.get_value() + txtC_KHAIGIA.get_value() + txtC_DONGGOI.get_value());
        }
        return false;
    }
    function OnValueChangedtxtPPXD(sender, eventArgs) {
        if (!flag) {
            txtC_TIENHANG.set_value(txtC_GIACUOC.get_value() + txtPPXD.get_value() + txtC_KHAC.get_value() + txtC_COD.get_value() + txtC_KHAIGIA.get_value() + txtC_DONGGOI.get_value());
        }
        return false;
    }
    function OnValueChangedtxtC_DONGGOI(sender, eventArgs) {
        if (flag) {
           txtC_GIACUOC.set_value(((txtC_TIENHANG.get_value() - txtC_KHAC.get_value() - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*100);
           txtPPXD.set_value(((txtC_TIENHANG.get_value() - txtC_KHAC.get_value() - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*parseFloat(PPXD));
        }
        else {
            txtC_TIENHANG.set_value(txtC_GIACUOC.get_value() + txtPPXD.get_value() + txtC_KHAC.get_value() + txtC_COD.get_value() + txtC_KHAIGIA.get_value() + txtC_DONGGOI.get_value());
        }        
        return false;
    }
    function OnValueChangedtxtC_KHAIGIA(sender, eventArgs) {
       if (flag) {
           txtC_GIACUOC.set_value(((txtC_TIENHANG.get_value() - txtC_KHAC.get_value() - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*100);
           txtPPXD.set_value(((txtC_TIENHANG.get_value() - txtC_KHAC.get_value() - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*parseFloat(PPXD));
        }
        else {
            txtC_TIENHANG.set_value(txtC_GIACUOC.get_value() + txtPPXD.get_value() + txtC_KHAC.get_value() + txtC_COD.get_value() + txtC_KHAIGIA.get_value() + txtC_DONGGOI.get_value());
        }        
        return false;
    }
    function OnValueChangedtxtC_COD(sender, eventArgs) {
        if (flag) {
           txtC_GIACUOC.set_value(((txtC_TIENHANG.get_value() - txtC_KHAC.get_value() - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*100);
           txtPPXD.set_value(((txtC_TIENHANG.get_value() - txtC_KHAC.get_value() - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*parseFloat(PPXD));
        }
        else {
            txtC_TIENHANG.set_value(txtC_GIACUOC.get_value() + txtPPXD.get_value() + txtC_KHAC.get_value() + txtC_COD.get_value() + txtC_KHAIGIA.get_value() + txtC_DONGGOI.get_value());
        }        
        return false;
    }
    function OnValueChangedtxtC_KHAC(sender, eventArgs) {
        if (flag) {
           txtC_GIACUOC.set_value(((txtC_TIENHANG.get_value() - txtC_KHAC.get_value() - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*100);
           txtPPXD.set_value(((txtC_TIENHANG.get_value() - txtC_KHAC.get_value() - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*parseFloat(PPXD));
        }
        else {
            txtC_TIENHANG.set_value(txtC_GIACUOC.get_value() + txtPPXD.get_value() + txtC_KHAC.get_value() + txtC_COD.get_value() + txtC_KHAIGIA.get_value() + txtC_DONGGOI.get_value());
        }        
        return false;
    }
    function OnValueChangedtxtC_TIENHANG(sender, eventArgs) {
        txtC_VAT.set_value(txtC_TIENHANG.get_value()*0.1);
        if (flag) {
           txtC_GIACUOC.set_value(((txtC_TIENHANG.get_value() - txtC_KHAC.get_value() - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*100);
           txtPPXD.set_value(((txtC_TIENHANG.get_value() - txtC_KHAC.get_value() - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*parseFloat(PPXD));
        }
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
        }
        return false;
    }
    function OnValueChangedtxtC_DATHU(sender, eventArgs) {
        txtC_CONLAI.set_value(txtC_TIENHANGVAT.get_value() - eventArgs.get_newValue());
        return false;
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
           txtC_GIACUOC.set_value(((txtC_TIENHANG.get_value() - txtC_KHAC.get_value() - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*100);
           txtPPXD.set_value(((txtC_TIENHANG.get_value() - txtC_KHAC.get_value() - txtC_COD.get_value() - txtC_KHAIGIA.get_value() - txtC_DONGGOI.get_value())/(100 + parseFloat(PPXD)))*parseFloat(PPXD));
        }
        else 
        {
            txtC_GIACUOC.set_value(CUOCCHINH);                  
        }
    }
    function radautoC_TENKHOnClientTextChanged(sender, eventArgs) {
        $find('<%=RadAjaxManager.GetCurrent(Page).ClientID %>').ajaxRequest("radautoC_TENKH;" + sender.get_text());
        var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelNHANGUIQT.ClientID %>");
        var currentUpdatedControl = "<%= RadGridNHANGUIQT.ClientID %>"; 
        currentLoadingPanel.show(currentUpdatedControl);
        return false;
    }
</script>
<script type="text/javascript">
    function onResponseEndNG() {
        if (typeof (result) != "undefined" && result && result != "") {
            //alert(result);
            var arrayOfStrings = result.split(",");
            if (arrayOfStrings[0] != "msg") {
                if (arrayOfStrings[1] != "") {
                    //cmbMaKhachHang.set_value(arrayOfStrings[0]);
                    //cmbMaKhachHang.set_text(arrayOfStrings[0]);
                }
                else {
                }
                if (arrayOfStrings[1] != "") {
                    var entry = new Telerik.Web.UI.AutoCompleteBoxEntry();
                    entry.set_text(arrayOfStrings[1]);
                    radautoC_TENKH.get_entries().add(entry);
                }
                else {
                    //radautoC_MAKH.get_entries().clear();
                    //radautoC_TENKH.get_entries().clear();
                }
                txtC_TELGUI.set_value(arrayOfStrings[2]);
                PPXD = arrayOfStrings[3];
                txtC_GIACUOC.set_value(arrayOfStrings[4]);
                CUOCCHINH = arrayOfStrings[4];
                txtC_GIADOITAC.set_value(arrayOfStrings[5]);
            }
            else {
                alert(arrayOfStrings[1]);
            }
            var currentLoadingPanel = $find("<%= RadAjaxLoadingPanelNHANGUIQT.ClientID %>");
            var currentUpdatedControl = "<%= RadGridNHANGUIQT.ClientID %>";
            currentLoadingPanel.hide(currentUpdatedControl);
            result = "";
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

        var grid = $get("<%=RadGridNHANGUIQT.ClientID %>");
        var elements = grid.getElementsByTagName(tagName);
        for (var i = 0; i < elements.length; i++) {
            var element = elements[i];
            if (element.id.indexOf(serverID) >= 0)
                return element;
        }
    }
</script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelNHANGUIQT" runat="server" />
<telerik:RadGrid ID="RadGridNHANGUIQT" runat="server" Skin="Vista" 
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="NHANGUIQTDataSource" ShowFooter="True"
    ondatabound="RadGridNHANGUIQT_DataBound" 
    onitemdeleted="RadGridNHANGUIQT_ItemDeleted" oniteminserted="RadGridNHANGUIQT_ItemInserted" 
    onitemupdated="RadGridNHANGUIQT_ItemUpdated" 
    onitemcommand="RadGridNHANGUIQT_ItemCommand" 
    onitemdatabound="RadGridNHANGUIQT_ItemDataBound" CellSpacing="0">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
     <GroupingSettings CaseSensitive ="false"  />
    <MasterTableView Name="MasterTableViewNHANGUIQT" CommandItemDisplay="Top" DataSourceID="NHANGUIQTDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b>Quản lý nhận gửi quốc tế</b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridNHANGUIQT.EditIndexes.Count == 0 && ITCLIB.Security.Security.CanEditModule("NHANGUIQT") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridNHANGUIQT.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Update.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridNHANGUIQT.EditIndexes.Count > 0 || RadGridNHANGUIQT.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridNHANGUIQT.MasterTableView.IsItemInserted && ITCLIB.Security.Security.CanAddModule("NHANGUIQT") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="PerformInsert" Visible='<%# RadGridNHANGUIQT.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Insert.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:return confirm('Bạn có muốn xóa bản ghi đã chọn không?')" runat="server" CommandName="DeleteSelected" Visible='<%# ITCLIB.Security.Security.CanDeleteModule("NHANGUIQT") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Delete.gif" />Xóa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btXuatbaocao" runat="server" OnClientClick ='<%# String.Format("javascript:return PrintOnClientLinkClicked()")%>' ><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/img_OpenPanel.gif" />Xuất phiếu</asp:LinkButton>&nbsp;&nbsp;
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
                <telerik:GridBoundColumn UniqueName="PK_ID" HeaderText="" DataField="PK_ID" Visible ="false"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
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
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy}">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_BILL" HeaderText="Số Bill" DataField="C_BILL" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="FK_KHACHHANG" HeaderText="Mã khách hàng" DataField="FK_KHACHHANG" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_TENKH" HeaderText="Tên khách hàng" DataField="C_TENKH" HeaderStyle-Width="110px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_TELGUI" HeaderText="Điện thoại gửi" DataField="C_TELGUI" HeaderStyle-Width="110px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_NGUOINHAN" HeaderText="Người nhận" DataField="C_NGUOINHAN" HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_DIACHINHAN" HeaderText="Địa chỉ nhận" DataField="C_DIACHINHAN" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_TELNHAN" HeaderText="Điện thoại nhận" DataField="C_TELNHAN" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="QUOCGIANAME" HeaderText="Quốc gia" DataField="QUOCGIANAME" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_NOIDUNG" HeaderText="Nội dung" DataField="C_NOIDUNG" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_KHOILUONG" HeaderText="Khối lượng" DataField="C_KHOILUONG" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="SANPHAMNAME" HeaderText="Dịch vụ" DataField="SANPHAMNAME" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_GIACUOC" HeaderText="Cước chính" DataField="C_GIACUOC" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_PPXD" HeaderText="PPXD" DataField="C_PPXD" HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_PHUTROISUM" HeaderText="DV phụ trội" DataField="C_PHUTROISUM" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_TIENHANG" HeaderText="Tiền hàng" DataField="C_TIENHANG" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_VAT" HeaderText="VAT" DataField="C_VAT" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_TIENHANGVAT" HeaderText="Tiền hàng (VAT)" DataField="C_TIENHANGVAT" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_HINHTHUCTT" HeaderText="Hình thức TT" DataField="C_HINHTHUCTT" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn UniqueName="C_DATHU" HeaderText="Đã thu" DataField="C_DATHU" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn UniqueName="C_CONLAI" HeaderText="Còn lại" DataField="C_CONLAI" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>               
                <telerik:GridBoundColumn UniqueName="NHANVIENNHANNAME" HeaderText="Nhân viên nhận" DataField="NHANVIENNHANNAME" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="DOITACNAME" HeaderText="Đối tác" DataField="DOITACNAME" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_GIADOITAC" HeaderText="Giá đối tác" DataField="C_GIADOITAC" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="NHANVIENPHATNAME" HeaderText="Nhân viên phát" DataField="NHANVIENPHATNAME" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_NGAYGIOPHAT" HeaderText="Ngày giờ phát" DataField="C_NGAYGIOPHAT" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy hh:mm tt}">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="NHANVIENKHAITHACNAME" HeaderText="Nhân viên khai thác" DataField="NHANVIENKHAITHACNAME" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_NGUOIKYNHAN" HeaderText="Người ký" DataField="C_NGUOIKYNHAN" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_BOPHAN" HeaderText="Bộ phận" DataField="C_BOPHAN" HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
        </Columns>
        <EditFormSettings InsertCaption="Thêm nhận gửi mới" CaptionFormatString="Sửa nhận gửi: <b>{0}</b>" CaptionDataField="C_BILL" EditFormType="Template" PopUpSettings-Width="900px">
        <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
           <FormTemplate>
            <div class="headerthongtin">
              <ul>
                <li class="lifirst"><asp:LinkButton ID="btnSave" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'><img src="Images/img_save.jpg" /><%# (Container is GridEditFormInsertItem) ? "Lưu" : "Lưu" %></asp:LinkButton></li>
                     <li><asp:LinkButton ID="btnClose" runat="server" CommandName="Cancel"><img src="Images/img_Close.jpg" />Đóng</asp:LinkButton></li>                     
              </ul>
            </div>               
            <div class="clearfix bgpopup"> 
            <div style="width:900px; height:500px; background:#FFFFFF" class="clearfix">      
            <table id="tblEdit" class ="TableEditInGrid" cellspacing="3" cellpadding="3" style="width: 100%" border="0">
            <tr>
                <td style ="width:100px;"> <span class="rtsTxtnew">Ngày nhận gửi:</td>
                <td colspan="4">
                    <telerik:RadDatePicker ID="radNgaynhangui" Width ="150px" DbSelectedDate ='<%# Bind("C_NGAY") %>' runat="server" AutoPostBack ="false" >
                        <DateInput ID ="DateInput1" runat ="server" DateFormat ="dd/MM/yyyy" MinDate="1/1/1890 12:00:00 AM">
                        <ClientEvents  OnKeyPress ="controlkeypress"/>
                        </DateInput>
                    </telerik:RadDatePicker>
                </td>
                <td style ="width:100px;"> <span class="rtsTxtnew">Số Bill:</span></td>
                <td colspan="4">
                    <asp:HiddenField ID="txtID" Value ='<%# Eval( "PK_ID") %>' runat="server" />
                    <telerik:RadTextBox ID="txtCODE" Width ="90%" Text='<%# Bind("C_BILL") %>' runat="server"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="rfvCODE" runat="server" ErrorMessage="Số Bill không thể rỗng" ControlToValidate="txtCODE" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="cuvCODE" ControlToValidate="txtCODE" OnServerValidate="CheckBill" runat="server" ErrorMessage="Số Bill đã tồn tại" Display="Dynamic" ValidationGroup="G1"></asp:CustomValidator>
                </td>               
            </tr>
            <tr>
                <td style ="width:100px;"> <span class="rtsTxtnew">Mã khách hàng:</span></td>
                <td colspan="4">
                    <telerik:RadComboBox ID="cmbMaKhachHang" runat="server"  onclientload="OnClientLoadcmbMaKhachHang" 
                    DataTextField="C_CODE" DataValueField="C_CODE" DataSourceID="KHACHHANGDataSource" SelectedValue='<%# Bind("FK_KHACHHANG") %>'
                    ShowToggleImage="True" EmptyMessage="Chọn mã" onclientselectedindexchanged="cmbMaKhachHangClientSelectedIndexChangedHandler">
                    </telerik:RadComboBox>
                </td>
                <td style ="width:100px;"> <span class="rtsTxtnew">Tên người gửi:</span></td>
                <td colspan="4">
                    <asp:HiddenField ID="hfC_TENKH" runat="server"  Value ='<%# Eval("C_TENKH") %>'/>
                    <telerik:RadAutoCompleteBox ID="radautoC_TENKH" Width ="90%" runat="server" 
                        AllowCustomEntry="True" DataSourceID="KHACHHANGCHITIETDataSource" onclientload="OnClientLoadradautoC_TENKH" OnClientTextChanged="radautoC_TENKHOnClientTextChanged"
                        DataTextField="C_NAME" DataValueField="PK_ID" InputType="Text" TextSettings-SelectionMode="Single" DropDownHeight="100" DropDownWidth="100">
                    </telerik:RadAutoCompleteBox>                    
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
                <td style =" width:100px;"> <span class="rtsTxtnew">Quốc gia:</span></td>
                <td colspan="12">
                    <telerik:RadComboBox ID="cmbQuocGia" runat="server" SelectedValue='<%# Bind("FK_QUOCGIA") %>'
                    DataTextField="C_NAME" DataValueField="C_CODE" DataSourceID="QUOCGIADataSource"
                    ShowToggleImage="True" EmptyMessage="Chọn quốc gia" 
                    onclientload="OnClientLoadQuocGia" 
                    onclientselectedindexchanged="cmbQuocGiaClientSelectedIndexChangedHandler">
                    </telerik:RadComboBox>
                </td>
            </tr> 
            <tr> 
                <td style =" width:100px;"> <span class="rtsTxtnew">Nội dung:</span></td>
                <td colspan="16">
                    <telerik:RadTextBox ID="txtC_NOIDUNG" Width ="90%" Text='<%# Bind("C_NOIDUNG") %>' runat="server"></telerik:RadTextBox>
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
                <td style =" width:100px;"><span class="rtsTxtnew">PPXD(%):</span></td>
                <td colspan="4">
                     <telerik:RadNumericTextBox  ID="txtPPXD" Width ="90%" Text='<%# Bind("C_PPXD") %>' Runat="server" ClientEvents-OnLoad="OnClientLoadtxtPPXD" ClientEvents-OnValueChanged="OnValueChangedtxtPPXD">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>
                <td style =" width:100px;"><span class="rtsTxtnew">DV đóng gói:</td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_DONGGOI" Width ="90%" Runat="server" Text='<%# Bind("C_DONGGOI") %>' ClientEvents-OnLoad="OnClientLoadtxtC_DONGGOI" ClientEvents-OnValueChanged="OnValueChangedtxtC_DONGGOI">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>
                <td style =" width:100px;"><span class="rtsTxtnew">DV khai giá:</td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_KHAIGIA" Width ="90%" Runat="server" Text='<%# Bind("C_KHAIGIA") %>' ClientEvents-OnLoad="OnClientLoadtxtC_KHAIGIA" ClientEvents-OnValueChanged="OnValueChangedtxtC_KHAIGIA">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>                
                <td style =" width:100px;"> <span class="rtsTxtnew">DV COD:</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_COD" Width ="90%" Runat="server" Text='<%# Bind("C_COD") %>' ClientEvents-OnLoad="OnClientLoadtxtC_COD" ClientEvents-OnValueChanged="OnValueChangedtxtC_COD">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>                
                <td style =" width:100px;"><span class="rtsTxtnew">DV khác:</td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_KHAC" Width ="90%" Runat="server" Text='<%# Bind("C_KHAC") %>' ClientEvents-OnLoad="OnClientLoadtxtC_KHAC" ClientEvents-OnValueChanged="OnValueChangedtxtC_KHAC">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>
                <td style =" width:100px;"><span class="rtsTxtnew">Tổng cước:</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_TIENHANG" Width ="90%" Runat="server" Text='<%# Bind("C_TIENHANG") %>' ClientEvents-OnLoad="OnClientLoadtxtC_TIENHANG" ClientEvents-OnValueChanged="OnValueChangedtxtC_TIENHANG">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>  
            </tr>
            <tr>                
                <td style =" width:100px;"> <span class="rtsTxtnew">VAT:</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_VAT" Width ="90%" Runat="server" Text='<%# Bind("C_VAT") %>' ClientEvents-OnLoad="OnClientLoadtxtC_VAT" ClientEvents-OnValueChanged="OnValueChangedtxtC_VAT">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>                
                <td style =" width:100px;"><span class="rtsTxtnew">Tổng cước (VAT):</span></td>
                <td colspan="4">
                    <telerik:RadNumericTextBox  ID="txtC_TIENHANGVAT" Width ="90%" Runat="server" Text='<%# Bind("C_TIENHANGVAT") %>' ClientEvents-OnLoad="OnClientLoadtxtC_TIENHANGVAT" ClientEvents-OnValueChanged="OnValueChangedtxtC_TIENHANGVAT">
                            <NumberFormat DecimalSeparator ="." GroupSeparator =" " DecimalDigits="0"/>
                    </telerik:RadNumericTextBox>
                </td>
                 <td colspan="4">
                    <input id="btnGiaCuoi" type="checkbox" onclick="SetGiaCuoi();" value="false"/>Theo giá cuối
                </td> 
            </tr>
            <tr>                         
                <td style =" width:100px;"> <span class="rtsTxtnew">HTTT:</span></td>
                <td colspan="4">
                 <telerik:RadComboBox ID="cmbC_HINHTHUCTT" SelectedValue='<%# Bind("C_HINHTHUCTT") %>' runat="server" EmptyMessage="Chọn">
                            <Items>
                                <telerik:RadComboBoxItem Value ="Thanh toán ngay" Text ="Thanh toán ngay" />
                                <telerik:RadComboBoxItem Value ="Thanh toán sau" Text ="Thanh toán sau" />
                                <telerik:RadComboBoxItem Value ="Thanh toán đầu nhận" Text ="Thanh toán đầu nhận" />
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
                    <telerik:RadNumericTextBox  ID="txtC_CONLAI" Width ="90%" Runat="server" Text='<%# Eval("C_CONLAI") %>' ClientEvents-OnLoad="OnClientLoadtxtC_CONLAI">
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
                    <telerik:RadDateTimePicker ID="radC_NGAYGIOPHAT"  Width ="90%" DbSelectedDate ='<%# Bind("C_NGAYGIOPHAT") %>' runat="server" AutoPostBack ="false">
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
            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="True" FrozenColumnsCount="3" ScrollHeight="450px" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<asp:SqlDataSource ID="NHANGUIQTDataSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>" 
    DeleteCommand="DELETE FROM [NHANGUI] WHERE [PK_ID] = @PK_ID" 
    InsertCommand="INSERT INTO [NHANGUI] ([C_NGAY], [C_BILL], [FK_KHACHHANG], [C_TENKH], [C_TELGUI], [C_NGUOINHAN], [C_DIACHINHAN], [C_TELNHAN], [FK_QUOCGIA], [C_NOIDUNG], [FK_MASANPHAM], [C_PPXD], [C_KHOILUONG], [C_GIACUOC], [C_DONGGOI], [C_KHAIGIA], [C_COD], [C_KHAC], [C_HINHTHUCTT], [C_DATHU], [C_TIENHANG], [C_VAT], [C_TIENHANGVAT], [FK_NHANVIENNHAN], [FK_DOITAC], [C_GIADOITAC], [FK_NHANVIENPHAT], [C_NGAYGIOPHAT], [C_NGUOIKYNHAN], [C_BOPHAN],[C_TYPE],[FK_VUNGLAMVIEC]) VALUES (@C_NGAY, @C_BILL, @FK_KHACHHANG, @C_TENKH, @C_TELGUI, @C_NGUOINHAN, @C_DIACHINHAN, @C_TELNHAN, @FK_QUOCGIA, @C_NOIDUNG, @FK_MASANPHAM, @C_PPXD, @C_KHOILUONG, @C_GIACUOC, @C_DONGGOI, @C_KHAIGIA, @C_COD, @C_KHAC, @C_HINHTHUCTT, @C_DATHU, @C_TIENHANG, @C_VAT, @C_TIENHANGVAT, @FK_NHANVIENNHAN, @FK_DOITAC, @C_GIADOITAC, @FK_NHANVIENPHAT, @C_NGAYGIOPHAT, @C_NGUOIKYNHAN, @C_BOPHAN,2,@FK_VUNGLAMVIEC)"
    SelectCommand="SELECT [NHANGUI].[PK_ID], [NHANGUI].[C_NGAY], [NHANGUI].[FK_KHACHHANG], [NHANGUI].[C_BILL], [NHANGUI].[C_TENKH], [NHANGUI].[C_TELGUI], [NHANGUI].[C_NGUOINHAN], [NHANGUI].[C_DIACHINHAN], [NHANGUI].[C_TELNHAN], [NHANGUI].[FK_QUOCGIA], [NHANGUI].[C_NOIDUNG], [NHANGUI].[FK_MASANPHAM],  [NHANGUI].[C_PPXD], [NHANGUI].[C_KHOILUONG], [NHANGUI].[C_GIACUOC], [NHANGUI].[C_DONGGOI], [NHANGUI].[C_KHAIGIA], [NHANGUI].[C_COD], [NHANGUI].[C_KHAC], [NHANGUI].[C_HINHTHUCTT], [NHANGUI].[C_DATHU], ([NHANGUI].[C_TIENHANG] - [NHANGUI].[C_DATHU]) as [C_CONLAI],([NHANGUI].[C_DONGGOI] + [NHANGUI].[C_KHAIGIA] + [NHANGUI].[C_COD] + [NHANGUI].[C_KHAC]) as [C_PHUTROISUM], [NHANGUI].[C_TIENHANG], [NHANGUI].[C_VAT], [NHANGUI].[C_TIENHANGVAT], [NHANGUI].[FK_NHANVIENNHAN], [NHANGUI].[FK_DOITAC], [NHANGUI].[C_GIADOITAC], [NHANGUI].[FK_NHANVIENPHAT], [NHANGUI].[C_NGAYGIOPHAT], [NHANGUI].[FK_NHANVIENKHAITHAC], [NHANGUI].[C_NGUOIKYNHAN], [NHANGUI].[C_BOPHAN],USERSNHAN.C_NAME as NHANVIENNHANNAME,USERSPHAT.C_NAME as NHANVIENPHATNAME,USERSKHAITHAC.C_NAME as NHANVIENKHAITHACNAME,DMMASANPHAM.C_NAME as SANPHAMNAME,DMQUOCGIA.C_NAME as QUOCGIANAME FROM [NHANGUI] LEFT OUTER JOIN USERS as USERSNHAN ON NHANGUI.FK_NHANVIENNHAN = USERSNHAN.PK_ID LEFT OUTER JOIN USERS as USERSPHAT ON NHANGUI.FK_NHANVIENPHAT = USERSPHAT.PK_ID LEFT OUTER JOIN USERS as USERSKHAITHAC ON NHANGUI.FK_NHANVIENKHAITHAC = USERSKHAITHAC.PK_ID LEFT OUTER JOIN DMMASANPHAM ON NHANGUI.FK_MASANPHAM=DMMASANPHAM.PK_ID LEFT OUTER JOIN DMQUOCGIA ON NHANGUI.FK_QUOCGIA = DMQUOCGIA.C_CODE WHERE [NHANGUI].[C_TYPE] = 2 AND [NHANGUI].FK_VUNGLAMVIEC = @FK_VUNGLAMVIEC" 
    UpdateCommand="UPDATE [NHANGUI] SET [C_NGAY] = @C_NGAY, [C_BILL] = @C_BILL, [FK_KHACHHANG] = @FK_KHACHHANG,[C_TENKH] = @C_TENKH, [C_TELGUI] = @C_TELGUI, [C_NGUOINHAN] = @C_NGUOINHAN, [C_DIACHINHAN] = @C_DIACHINHAN, [C_TELNHAN] = @C_TELNHAN, [FK_QUOCGIA] = @FK_QUOCGIA, [C_NOIDUNG] = @C_NOIDUNG, [FK_MASANPHAM] = @FK_MASANPHAM, [C_PPXD] = @C_PPXD, [C_KHOILUONG] = @C_KHOILUONG, [C_GIACUOC] = @C_GIACUOC, [C_DONGGOI]=@C_DONGGOI, [C_KHAIGIA]=@C_KHAIGIA, [C_COD]=@C_COD, [C_KHAC]=@C_KHAC, [C_HINHTHUCTT] = @C_HINHTHUCTT, [C_DATHU] = @C_DATHU, [C_TIENHANG] = @C_TIENHANG, [C_VAT] = @C_VAT, [C_TIENHANGVAT] = @C_TIENHANGVAT, [FK_NHANVIENNHAN] = @FK_NHANVIENNHAN, [FK_DOITAC] = @FK_DOITAC, [C_GIADOITAC] = @C_GIADOITAC, [FK_NHANVIENPHAT] = @FK_NHANVIENPHAT, [C_NGAYGIOPHAT] = @C_NGAYGIOPHAT, [FK_NHANVIENKHAITHAC]=@FK_NHANVIENKHAITHAC, [C_NGUOIKYNHAN] = @C_NGUOIKYNHAN, [C_BOPHAN] = @C_BOPHAN WHERE [PK_ID] = @PK_ID">
    <SelectParameters>
        <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="PK_ID" Type="Int32" />
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
        <asp:Parameter Name="FK_QUOCGIA" Type="String" />
        <asp:Parameter Name="C_NOIDUNG" Type="String" />
        <asp:Parameter Name="FK_MASANPHAM" Type="Int32" />
        <asp:Parameter Name="C_PPXD" Type="Single" />
        <asp:Parameter Name="C_KHOILUONG" Type="Single" />
        <asp:Parameter Name="C_GIACUOC" Type="Single" />
        <asp:Parameter Name="C_DONGGOI" Type="String" />
        <asp:Parameter Name="C_KHAIGIA" Type="String" />
        <asp:Parameter Name="C_COD" Type="String" />
        <asp:Parameter Name="C_KHAC" Type="String" />
        <asp:Parameter Name="C_HINHTHUCTT" Type="String" />
        <asp:Parameter Name="C_DATHU" Type="String" />
        <asp:Parameter Name="C_TIENHANG" Type="String" />
        <asp:Parameter Name="C_VAT" Type="String" />
        <asp:Parameter Name="C_TIENHANGVAT" Type="String" />
        <asp:Parameter Name="FK_NHANVIENNHAN" Type="Int32" />
        <asp:Parameter Name="FK_DOITAC" Type="Int32" />
        <asp:Parameter Name="C_GIADOITAC" Type="Single" />
        <asp:Parameter Name="FK_NHANVIENPHAT" Type="Int32" />
        <asp:Parameter Name="C_NGAYGIOPHAT" Type="DateTime" />
        <asp:Parameter Name="C_NGUOIKYNHAN" Type="String" />
        <asp:Parameter Name="C_BOPHAN" Type="String" />
        <asp:SessionParameter Name="FK_VUNGLAMVIEC" Type="String" SessionField="VUNGLAMVIEC" />
    </InsertParameters>
    <UpdateParameters>
         <asp:Parameter Name="C_NGAY" Type="DateTime" />
        <asp:Parameter Name="C_BILL" Type="String" />
        <asp:Parameter Name="FK_KHACHHANG" Type="String" />
        <asp:Parameter Name="C_TENKH" Type="String" />
        <asp:Parameter Name="C_TELGUI" Type="String" />
        <asp:Parameter Name="C_NGUOINHAN" Type="String" />
        <asp:Parameter Name="C_DIACHINHAN" Type="String" />
        <asp:Parameter Name="C_TELNHAN" Type="String" />
        <asp:Parameter Name="FK_QUOCGIA" Type="String" />
        <asp:Parameter Name="C_NOIDUNG" Type="String" />
        <asp:Parameter Name="FK_MASANPHAM" Type="Int32" />
        <asp:Parameter Name="C_PPXD" Type="Single" />
        <asp:Parameter Name="C_KHOILUONG" Type="Single" />
        <asp:Parameter Name="C_GIACUOC" Type="Single" />
        <asp:Parameter Name="C_DONGGOI" Type="String" />
        <asp:Parameter Name="C_KHAIGIA" Type="String" />
        <asp:Parameter Name="C_COD" Type="String" />
        <asp:Parameter Name="C_KHAC" Type="String" />
        <asp:Parameter Name="C_HINHTHUCTT" Type="String" />
        <asp:Parameter Name="C_DATHU" Type="String" />
        <asp:Parameter Name="C_TIENHANG" Type="String" />
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
        <asp:Parameter Name="PK_ID" Type="Int32" />
    </UpdateParameters>       
</asp:SqlDataSource>
<asp:SqlDataSource ID="KHACHHANGDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
 SelectCommand="SELECT DMKHACHHANG.* FROM DMKHACHHANG" >
</asp:SqlDataSource>
 <asp:SqlDataSource ID="KHACHHANGCHITIETDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
 SelectCommand="SELECT DMKHACHHANGCHITIET.* FROM DMKHACHHANGCHITIET" >
</asp:SqlDataSource>
<asp:SqlDataSource ID="MASANPHAMDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
  SelectCommand="SELECT [PK_ID], [C_CODE], [C_NAME] FROM [DMMASANPHAM]  WHERE C_CODE <> ' ' ORDER BY PK_ID">
</asp:SqlDataSource>
<asp:SqlDataSource ID="MAVUNGDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>">
</asp:SqlDataSource>
 <asp:SqlDataSource ID="QUOCGIADataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT [DMQUOCGIA].[PK_ID], [DMQUOCGIA].[C_CODE], [DMQUOCGIA].[C_NAME] FROM [DMQUOCGIA]">
 </asp:SqlDataSource>
<asp:SqlDataSource ID="UserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT USERS.PK_ID,USERS.FK_GroupUser,USERS.FK_DEPT,USERS.C_LoginName,USERS.C_Password,USERS.C_NAME,USERS.C_Address,USERS.c_Tel,USERS.C_Email,USERS.C_DESC,GROUPUSER.C_NAME AS GROUPUSERNAME FROM USERS INNER JOIN GROUPUSER ON  USERS.FK_GROUPUSER = GROUPUSER.PK_ID WHERE FK_GROUPUSER NOT IN (0,1)">
</asp:SqlDataSource>
<asp:SqlDataSource ID="DOITACDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>" 
    SelectCommand="SELECT [DMDOITAC].[PK_ID], [DMDOITAC].[C_CODE], [DMDOITAC].[C_NAME], [DMDOITAC].[C_ADDRESS], [DMDOITAC].[C_TEL], [DMDOITAC].[C_NGUOILIENHE] FROM [DMDOITAC]">
</asp:SqlDataSource>
