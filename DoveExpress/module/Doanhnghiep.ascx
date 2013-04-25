<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Doanhnghiep.ascx.cs" Inherits="module_Doanhnghiep" %>
<%@ Register TagPrefix="uc1" TagName="NganhNghe" Src="Doanhnghiep_Nganhnge.ascx" %>
<telerik:RadCodeBlock ID="RadCodeBlockDoanhNghiep"  runat ="server" >
<script type="text/javascript">
         function RowDblClickDoanhNghiep(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("DoanhNghieps") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewDoanhNghiep") && (CanEdit == "True")) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
        }
</script>
<script type="text/javascript">
    var registeredElements = [];
    function GetRegisteredServerElement(serverID) {
        var clientID = "";
        for (var i = 0; i < registeredElements.length; i++) {
            clientID = registeredElements[i];
            if (clientID.indexOf(serverID) >= 0)
                break;
        }
        return $get(clientID);
    }
    function GetGridServerElementDoanhNghiep(serverID, tagName) {
        if (!tagName)
            tagName = "*";

        var grid = $get("<%=RadGridDoanhNghieps.ClientID %>");
        var elements = grid.getElementsByTagName(tagName);
        for (var i = 0; i < elements.length; i++) {
            var element = elements[i];
            if (element.id.indexOf(serverID) >= 0)
                return element;
        }
    }
  </script> 
<script type="text/javascript">
    var comboBox;
    function OnClientLoadDoanhNghiep(sender) {
        comboBox = sender;
    }
    function ClientNodeClicking(sender, args) {
        var txtpk = GetGridServerElementDoanhNghiep("hfParent");
        var node = args.get_node()
        if (node == null) {
            txtpk.value = "0";
            comboBox.set_value("0");
            comboBox.set_text("Doanh nghiệp hoạt động trong khu CNC Hòa lạc");
        }
        else {
            txtpk.value = node.get_value();
            comboBox.set_text(node.get_text());
            comboBox.set_value(node.get_value());
            comboBox.trackChanges();
            comboBox.get_items().getItem(0).set_text(node.get_text());
            comboBox.commitChanges();
            comboBox.hideDropDown();
        }
    }

    function StopPropagation(e) {
        if (!e) {
            e = window.event;
        }

        e.cancelBubble = true;
    }

    function OnClientDropDownOpenedHandler(sender, eventArgs) {
        var tree = sender.get_items().getItem(0).findControl("RadTreViewDir");
        var selectedNode = tree.get_selectedNode();
        if (selectedNode) {
            selectedNode.scrollIntoView();
        }
    }
    function OnClientShowText(sender, eventArgs) {

    }
    function OnClientCloseText(sender, eventArgs) {
        if (eventArgs.get_argument() != null) {
        }
        else {
        }
        return false;
    }
</script>
<script type="text/javascript">
    var cmbDoangnghep;
    function OnClientLoadcmbDoangnghep(sender) {
        cmbDoangnghep = sender;
    }
    function listDoangNghiepClientNodeClicking(sender, args) {
        var hfFK_DEPT = document.getElementById("ContentPlaceHolder_ctl00_hfFilter");
        var node = args.get_node();
        if (node == null) {
            hfFK_DEPT.value = "0";
            cmbDoangnghep.set_value("0");
            cmbDoangnghep.set_text("Doanh nghiệp hoạt động trong khu CNC Hòa lạc");
        }
        else {
            hfFK_DEPT.value = node.get_value();
            cmbDoangnghep.set_value(node.get_value());
            cmbDoangnghep.set_text(node.get_text());
            cmbDoangnghep.trackChanges();
            cmbDoangnghep.get_items().getItem(0).set_text(node.get_text());
            cmbDoangnghep.commitChanges();
            cmbDoangnghep.hideDropDown();
        }
        $find("<%= RadGridDoanhNghieps.ClientID %>").get_masterTableView().rebind();
    }

    function cmbDoangnghepOnClientDropDownOpenedHandler(sender, eventArgs) {
        var tree = sender.get_items().getItem(0).findControl("radViewDoangnghiep");
        var selectedNode = tree.get_selectedNode();
        if (selectedNode) {
            selectedNode.scrollIntoView();
        }
    }
</script>
<script type="text/javascript">
    var cmbLoaihinh;
    function OnClientLoadcmbLoaihinh(sender) {
        cmbLoaihinh = sender;
    }

    var txtvonNNTW, txtVonNNDP;
    function OnClientLoadtxtvonNNTW(sender) {
        txtvonNNTW = sender;
    }
    function OnClientLoadtxtVonNNDP(sender) {
        txtVonNNDP = sender;
    }

    function cmbLoaihinhOnClientSelectedIndexChanged(sender, eventArgs) {
        var loaihinh = eventArgs.get_item().get_text();
        var maloai = eventArgs.get_item().get_value();
        var chkChiphoi = GetGridServerElementDoanhNghiep("chkChiphoi");
        var hfchiphoi = GetGridServerElementDoanhNghiep("hfchiphoi");
        if (loaihinh == "Cty CP, Cty TNHH có vốn Nhà nước > 50%") {
            txtvonNNTW.enable();
            txtVonNNDP.enable();
            chkChiphoi.checked = false;
            chkChiphoi.disabled = "disabled";
            hfchiphoi.value = "";
        }
        else if (loaihinh == "Công ty TNHH tư nhân, Công ty TNHH có vốn Nhà nước ≤ 50%") {
            txtvonNNTW.enable();
            txtVonNNDP.disable();
            txtVonNNDP.clear();
            chkChiphoi.checked = false;
            chkChiphoi.disabled = "disabled";
            hfchiphoi.value = "";
        }
        else if (loaihinh == "Công ty cổ phần có vốn Nhà nước ≤ 50%") {
            txtvonNNTW.disable();
            txtVonNNDP.disable();
            txtvonNNTW.clear();
            txtVonNNDP.clear();
            chkChiphoi.removeAttribute("disabled");
            chkChiphoi.checked = false;
            hfchiphoi.value = "0";
        }
        else {
            chkChiphoi.disabled = "disabled";
            chkChiphoi.checked = false;
            hfchiphoi.value = "";
            txtvonNNTW.clear();
            txtVonNNDP.clear();
            txtvonNNTW.disable();
            txtVonNNDP.disable();
        }
    }

    function chkChiphoislected() {
        var chkChiphoi = GetGridServerElementDoanhNghiep("chkChiphoi");
        var hfchiphoi = GetGridServerElementDoanhNghiep("hfchiphoi");
        if (!chkChiphoi.checked) {
            hfchiphoi.value = "0";
        }
        else {
            hfchiphoi.value = "1";
        }
        return false;
    }
</script>
<script type="text/javascript">
    function RadMenu_ItemClientClick(sender, args) {
        var menuItemValue = args.get_item().get_value();
        switch (menuItemValue) {
            case "LAODONG":
                var oWindow = radopen("Popup.aspx?ctl=dnLaodong&IDDN=" + idtextselect, "LAODONG");
                oWindow.set_title("CloudEOffice_Quản lý Lao động các doanh nghiệp");
                oWindow.maximize();
                break;
            case "DAUTU":
                var oWindow = radopen("Popup.aspx?ctl=dndautu&IDDN=" + idtextselect, "LAODONG");
                oWindow.set_title("CloudEOffice_Quản lý đầu tư xây dựng");
                oWindow.maximize();
                break;
            case "DAOTAO":
                var oWindow = radopen("Popup.aspx?ctl=dndaotao&IDDN=" + idtextselect, "LAODONG");
                oWindow.set_title("CloudEOffice_Quản lý Lao động các doanh nghiệp");
                oWindow.maximize();
                break;
            case "NHAHANG":
                var oWindow = radopen("Popup.aspx?ctl=dnNhahang&IDDN=" + idtextselect, "dnNhahang");
                oWindow.set_title("CloudEOffice_Quản lý hoạt động nhà hàng");
                oWindow.maximize();
                break;
            case "DICHVU":
                var oWindow = radopen("Popup.aspx?ctl=dndichvu&IDDN=" + idtextselect, "dnNhahang");
                oWindow.set_title("CloudEOffice_Quản lý hoạt động dịch vụ khác");
                oWindow.maximize();
                break;
            case "THUNHAP":
                var oWindow = radopen("Popup.aspx?ctl=dnthunhap&IDDN=" + idtextselect, "dnNhahang");
                oWindow.set_title("CloudEOffice_Quản lý thu nhập Tình hình đào tạo nghề");
                oWindow.maximize();
                break;
            case "GOPVON":
                var oWindow = radopen("Popup.aspx?ctl=dngopvon&IDDN=" + idtextselect, "dnNhahang");
                oWindow.set_title("CloudEOffice_Quản lý thu nhập Tình hình đào tạo nghề");
                oWindow.maximize();
                break;
            case "HDDUAN":
                var oWindow = radopen("Popup.aspx?ctl=dnhdduan&IDDN=" + idtextselect, "dnNhahang");
                oWindow.set_title("CloudEOffice_Quản lý thu nhập Tình hình đào tạo nghề");
                oWindow.maximize();
                break;
            case "TAINAN":
                var oWindow = radopen("Popup.aspx?ctl=dntainan&IDDN=" + idtextselect, "dnNhahang");
                oWindow.set_title("CloudEOffice_Quản lý thu nhập Tình hình đào tạo nghề");
                oWindow.maximize();
                break;
            case "CNTT":
                var oWindow = radopen("Popup.aspx?ctl=dnCNTT&IDDN=" + idtextselect, "dnNhahang");
                oWindow.set_title("CloudEOffice_Quản lý thu nhập Tình hình đào tạo nghề");
                oWindow.maximize();
                break;
            case "BVMT":
                var oWindow = radopen("Popup.aspx?ctl=dnBVMT&IDDN=" + idtextselect, "dnNhahang");
                oWindow.set_title("CloudEOffice_Quản lý thu nhập Tình hình đào tạo nghề");
                oWindow.maximize();
                break;
            case "XAYDUNG":
                var oWindow = radopen("Popup.aspx?ctl=dnXaydung&IDDN=" + idtextselect, "dnNhahang");
                oWindow.set_title("CloudEOffice_Quản lý thu nhập Tình hình đào tạo nghề");
                oWindow.maximize();
                break;
            case "LUUTRU":
                var oWindow = radopen("Popup.aspx?ctl=dnLuutru&IDDN=" + idtextselect, "dnNhahang");
                oWindow.set_title("CloudEOffice_Quản lý thu nhập Tình hình đào tạo nghề");
                oWindow.maximize();
                break;
        }
    }
    var idtextselect;
    function RowContextMenu(sender, eventArgs) {
        //    var ListCVTYPE ="<%=Session["CVTYPE"]%>";     
        //    var index = eventArgs.get_itemIndexHierarchical();
        //    var idType = eventArgs.getDataKeyValue("FK_TYPE"); 
        //    var IsVisible = 0;
        //    var arrayID = ListCVTYPE.split(',');
        //    for(var i=0; i<arrayID.length; i++)
        //    {
        //        if(arrayID[i] == idType)
        //        {
        //            IsVisible = 1;break;
        //        }
        //    }
        var menu = $find("<%=RadMenu1.ClientID %>");
        //    if(IsVisible ==1)
        //    {
        //        var menuItem = menu.findItemByValue("PROCESS");
        //        menuItem.set_visible(true);
        //    }
        //    else {
        //        var menuItem = menu.findItemByValue("PROCESS");
        //        menuItem.set_visible(false);
        //    }

        var evt = eventArgs.get_domEvent();
        idtextselect = eventArgs.getDataKeyValue("PK_ID");
        var index = eventArgs.get_itemIndexHierarchical();
        sender.get_masterTableView().selectItem(sender.get_masterTableView().get_dataItems()[index].get_element(), true);
        menu.show(evt);
        evt.cancelBubble = true;
        evt.returnValue = false;
        if (evt.stopPropagation) {
            evt.stopPropagation();
            evt.preventDefault();
        }
    }
</script> 
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxProxyDoanhNghiep" runat="server" />
 <table id="Table1" cellspacing="3" cellpadding="3" style="width: 100%" border="0">
<tr>
 <td style =" width:15%">
                    Trực thuộc doanh nghiệp:
                </td>
                <td>
<telerik:RadComboBox ID="rcbParent" runat="server" Width="500px"  OnClientLoad ="OnClientLoadcmbDoangnghep" 
OnClientDropDownOpened ="cmbDoangnghepOnClientDropDownOpenedHandler" AutoPostBack ="true" 
    ShowToggleImage="True" Style="vertical-align: middle;"
    EmptyMessage="Chọn doanh nghiệp" ExpandAnimation-Type="None" CollapseAnimation-Type="None">
            <ItemTemplate>
            <div id ="div1">
                        <telerik:RadTreeView runat="server" ID="radViewDoangnghiep" OnClientNodeClicking ="listDoangNghiepClientNodeClicking" 
                        Width="100%" Height="200px" DataFieldID="PK_ID" DataFieldParentID="FK_DOANHNGHIEP" DataSourceID="SqlDataSourceListDoanhNghiep" 
                            DataTextField="TENDOANHNGHIEP" DataValueField="PK_ID" >                        
                        </telerik:RadTreeView>
                </div>
            </ItemTemplate>
                <Items>
                <telerik:RadComboBoxItem Text=""  />
            </Items>
    <ExpandAnimation Type="None"></ExpandAnimation>
    <CollapseAnimation Type="None"></CollapseAnimation>
</telerik:RadComboBox>
                <script type="text/javascript">
                    var div1 = document.getElementById("div1");
                    div1.onclick = StopPropagation;
                </script>
                    <asp:HiddenField ID="hfFilter" runat="server" />
  </td>
    </tr>
                 
</table>

 <telerik:RadGrid ID="RadGridDoanhNghieps" runat="server" Skin="Vista" 
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"   Height ="100%"
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="DoanhNghiepsDataSource" ShowFooter="True"
    ondatabound="RadGridDoanhNghieps_DataBound" 
    onitemdeleted="RadGridDoanhNghieps_ItemDeleted" oniteminserted="RadGridDoanhNghieps_ItemInserted" 
    onitemupdated="RadGridDoanhNghieps_ItemUpdated" 
    onitemcommand="RadGridDoanhNghieps_ItemCommand" 
    onitemdatabound="RadGridDoanhNghieps_ItemDataBound" CellSpacing="0" 
    onitemcreated="RadGridDoanhNghieps_ItemCreated" >
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML">
<Excel Format="ExcelML"></Excel>
    </ExportSettings>   
     <GroupingSettings CaseSensitive ="false"  />
    <MasterTableView Name ="MasterTableViewDoanhNghiep" CommandItemDisplay="Top" 
        DataSourceID="DoanhNghiepsDataSource" DataKeyNames="PK_ID" 
        ClientDataKeyNames="PK_ID" EditMode="PopUp" 
        NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b>
                           <asp:Label ID="lblcap" runat="server" 
                            Text="Label" onprerender="lblcap_PreRender"></asp:Label></b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridDoanhNghieps.EditIndexes.Count == 0  && ITCLIB.Security.Security.CanEditModule("DoanhNghieps") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridDoanhNghieps.MasterTableView.IsItemInserted && ITCLIB.Security.Security.CanAddModule("DoanhNghieps") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:return confirm('Bạn có muốn xóa bản ghi đã chọn không?')" Visible ='<%# ITCLIB.Security.Security.CanDeleteModule("DoanhNghieps") %>' runat="server" CommandName="DeleteSelected"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Delete.gif" />Xóa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton4" runat="server" CommandName="RebindGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Refresh.gif" />Làm mới</asp:LinkButton>
                    </div>
                    <div style="padding: 5px 5px;float:right;width:auto">
                        <asp:LinkButton ID="ExportToPdfButton" runat="server" CommandName="ExportToPdf"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/pdf.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToWordButton" runat="server" CommandName="ExportToWord"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/word.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToExcelButton" runat="server" CommandName="ExportToExcel"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/excel.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToCsvButton" runat="server" CommandName="ExportToCsv"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/csv.gif" /></asp:LinkButton>&nbsp;&nbsp;
                    </div>
        </CommandItemTemplate>
        <NestedViewSettings DataSourceID ="ViewDoanhNghiepSqlDataSource">
                <ParentTableRelation>
                    <telerik:GridRelationFields DetailKeyField="PK_ID" MasterKeyField="PK_ID" />
                </ParentTableRelation>
        </NestedViewSettings>
        <NestedViewTemplate>
        <fieldset style =" padding:5px;" >
        <legend style =" padding:5px;">Thông tin chi tiết</legend>
        <table id="tblEdit" class ="TableEditInGrid" cellspacing="3" cellpadding="3" style="width: 100%" border="0">
        <tr>
            <td class ="title" style =" width :120px">
                Mã doanh nghiệp</td>
            <td>
                <asp:Label ID="lblSH" runat="server" Text='<%#Eval("MADOANHNGHIEP") %>'></asp:Label>
            </td>
            <td class ="title" style =" width :120px">
                Tên doanh nghiệp:</td>
            <td>
                <asp:Label ID="lblSovaoso" runat="server" Text='<%#Eval("TENDOANHNGHIEP") %>'></asp:Label>
            </td>
             <td class ="title">
                Tên giao dịch:</td>
            <td>
                <asp:Label ID="lblBrow" runat="server" Text='<%#Eval("TENGIAODICH")%>'></asp:Label>
            </td>
        </tr>
        <tr>
            <td class ="title">
                Tên tiếng anh</td>
            <td colspan="5">
                <asp:Label ID="lblheader" runat="server" Text='<%#Eval("TENTIENGANH") %>'></asp:Label>
            </td>
        </tr>
        <tr>
            <td class ="title">
                Mã số thuế</td>
            <td>
                <asp:Label ID="lblType" runat="server" Text='<%#Eval("MASOTHUE") %>'></asp:Label>
            </td>
            <td class ="title">
                Địa chỉ:</td>
            <td>
                <asp:Label ID="lblRole" runat="server" Text='<%#Eval("DIACHI") %>'></asp:Label>
            </td>
            <td class ="title">
                Điện thoại:<asp:Label ID="lblNumber" runat="server" Text='<%#Eval("DIENTHOAI") %>'></asp:Label>
            </td>
            <td class ="title">
                Fax:<asp:Label ID="lblPage" runat="server" Text='<%#Eval("FAX") %>'></asp:Label>
            </td>
        </tr>
        <tr>
            <td class ="title">
                Email</td>
            <td>
                <asp:Label ID="lblPrivate" runat="server" Text='<%#Eval("EMAIL") %>'></asp:Label>
            </td>
            <td class ="title">
                WEBSITE</td>
            <td>
                <asp:Label ID="lblEmr" runat="server" Text='<%#Eval("WEBSITE") %>'></asp:Label>
            </td>
            <td class ="title">
                Tên giám đốc:</td>
            <td>
                <asp:Label ID="lblStatus" runat="server" Text='<%#Eval("TENGIAMDOC") %>'></asp:Label>
            </td>
        </tr>
        <tr>
            <td class ="title">
                Giới tính:</td>
            <td>
                <asp:Label ID="lbldatePub"  runat="server" Text='<%#Eval("GIOITINH") %>'></asp:Label>
            </td>
            <td class ="title">
                Quốc tịch</td>
            <td>
                <asp:Label ID="lblOffice" runat="server" Text='<%#Eval("QUOCTICH") %>'></asp:Label>
            </td>
            <td class ="title">
                Trình độ:</td>
            <td>
                <asp:Label ID="lblField" runat="server" Text='<%#Eval("TRINHDO") %>'></asp:Label>
            </td>
        </tr>
        <tr>
            <td  class ="title">
               Loại hình doanh nghiệp:</td>
            <td>
                <asp:Label ID="lbldateDiw" runat="server" Text='<%#Eval("LOAIHINHDN") %>'></asp:Label>
            </td>
            <td class ="title">
                Phần trăm vốn nhà nước:</td>
            <td colspan ="3">
                <asp:Label ID="Label2" runat="server" Text='<%#Eval("PHANTRAMVONNN")%>'></asp:Label>(%)
            </td>
        </tr>
         </table>
<div class="headerthongtin">
    <ul style =" display :none;">
    <li class="lifirst">
    <asp:LinkButton ID="btTextRef" runat="server" Visible ="false"  OnClientClick='<%# String.Format("javascript:return OnClientLinkClickedTextRef({0})", Eval("PK_ID"))%>' ><img src="Images/img_text_ref.jpg" />Tài liệu, văn bản liên quan</asp:LinkButton></li>
    <li><asp:LinkButton ID="btTextComment"  Visible ="false"  runat="server" OnClientClick='<%# String.Format("javascript:return OnClientLinkClickedTextComment({0})", Eval("PK_ID"))%>'><img src="Images/img_ykien.jpg" />Ý kiến chỉ đạo</asp:LinkButton></li>    
    <li><asp:LinkButton ID="btTextFile"  Visible ="false"  OnClientClick='<%# String.Format("javascript:return OnClientLinkClickedTextFile({0})", Eval("PK_ID"))%>' runat="server"><img src="Images/img_attFile.jpg" />File đính kèm</asp:LinkButton></li>                       
    </ul>
 </div>  
</fieldset>
        </NestedViewTemplate>
<CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
<RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column"></RowIndicatorColumn>
<ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column"></ExpandCollapseColumn>
        <Columns>
                <telerik:GridBoundColumn UniqueName="PK_ID" HeaderText="" DataField="PK_ID" Visible ="false"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="FK_DOANHNGHIEP" HeaderText="" DataField="FK_DOANHNGHIEP" Visible ="false"> </telerik:GridBoundColumn>
                 <telerik:GridTemplateColumn HeaderText ="" ShowFilterIcon="false">   
                 <FilterTemplate >
                  <center> <asp:Button ID="btnSearch" Visible ="false" Text="Tìm" runat="server"/>
                   <asp:ImageButton ID="btnShowAll" runat="server" ImageUrl="../Images/Grid/filterCancel.gif" AlternateText="Xem tất" ToolTip="Xem tất" OnClick="btnShowAll_Click" Style="vertical-align: middle" />
                  </center>
                 </FilterTemplate>
                  <ItemTemplate>
                      <asp:Label ID="lblSTT" runat="server" Text=""></asp:Label>
                </ItemTemplate>
                 <HeaderStyle HorizontalAlign ="Center" Width ="30px" />
                 <ItemStyle HorizontalAlign ="Center" Width ="30px" />
               </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn UniqueName="MADOANHNGHIEP" HeaderText="Mã DN" ShowFilterIcon ="false" FilterControlWidth ="100%"  AutoPostBackOnFilter ="true" 
                    DataField="MADOANHNGHIEP" FilterControlAltText="Filter MADOANHNGHIEP column" 
                    SortExpression="MADOANHNGHIEP">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TENDOANHNGHIEP" ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
                    FilterControlAltText="Filter TENDOANHNGHIEP column" HeaderText="Tên DN" 
                    SortExpression="TENDOANHNGHIEP" UniqueName="TENDOANHNGHIEP">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TENGIAODICH" ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
                    FilterControlAltText="Filter TENGIAODICH column" HeaderText="Tên giao dịch" 
                    SortExpression="TENGIAODICH" UniqueName="TENGIAODICH">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TENTIENGANH" ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
                    FilterControlAltText="Filter TENTIENGANH column" HeaderText="Tên tiếng anh" 
                    SortExpression="TENTIENGANH" UniqueName="TENTIENGANH">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="MASOTHUE" ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
                    FilterControlAltText="Filter MASOTHUE column" HeaderText="Mã số thuể" 
                    SortExpression="MASOTHUE" UniqueName="MASOTHUE">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DIACHI" ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
                    FilterControlAltText="Filter DIACHI column" HeaderText="Địa chỉ" 
                    SortExpression="DIACHI" UniqueName="DIACHI">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DIENTHOAI" ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
                    FilterControlAltText="Filter DIENTHOAI column" HeaderText="Điện thoại" 
                    SortExpression="DIENTHOAI" UniqueName="DIENTHOAI">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SOCNDT" ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
                    FilterControlAltText="Filter SOCNDT column" HeaderText="Số CNDT" 
                    SortExpression="SOCNDT" UniqueName="SOCNDT">
                </telerik:GridBoundColumn>
        </Columns>
<EditFormSettings InsertCaption="Thêm doanh nghiệp mới" CaptionFormatString="Sửa doanh nghiệp: <b>{0}</b>" CaptionDataField="TENDOANHNGHIEP" EditFormType="Template" PopUpSettings-Width="800px">
<EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
<FormTemplate>
<div class="headerthongtin">
    <ul>
    <li class="lifirst"><asp:LinkButton ID="btnSave" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'><img src="Images/img_save.jpg" /><%# (Container is GridEditFormInsertItem) ? "Lưu" : "Lưu" %></asp:LinkButton></li>
            <li><asp:LinkButton ID="btnClose" runat="server" CommandName="Cancel"><img src="Images/img_Close.jpg" />Đóng</asp:LinkButton></li>                     
    </ul>
</div>  
<table id="tblEdit" class ="TableEditInGrid" cellspacing="3" cellpadding="3" style="width: 100%" border="0">
<tr>
    <td style =" width:15% !important;">
        Mã doanh nghiệp:
    </td>
    <td style =" width:35% !important; ">
        <asp:HiddenField ID="txtID" Value='<%# Eval("PK_ID") %>' runat="server"  />
        <asp:TextBox ID="txtCode" Width ="90%" Text='<%# Bind("MADOANHNGHIEP") %>' runat="server"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator ForeColor ="Red" ID="rfvCode" runat="server" ErrorMessage="Mã không thể rỗng" ControlToValidate="txtCode" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
        <asp:Label ID="lbtThongbao" runat="server" Text=""></asp:Label>
    </td>
    <td style =" width:15% !important;">
        Mã số thuế:
    </td>
    <td style =" width:35% !important;">
        <asp:TextBox ID="txtMasothue" Width ="99%" Text='<%# Bind("MASOTHUE") %>' runat="server"></asp:TextBox>
    </td>
</tr> 
<tr>
<td>
    Doanh nghiệp trực thuộc:
</td>
<td colspan ="3">
 <asp:HiddenField ID="hfParent" runat="server"  Value ='<%# Bind("FK_DOANHNGHIEP")%>'/>
<telerik:RadComboBox ID="rcbParent" runat="server" Width="99%" 
ShowToggleImage="True" Style="vertical-align: middle;" 
EmptyMessage="Chọn doanh nghiệp" ExpandAnimation-Type="None" CollapseAnimation-Type="None">
        <ItemTemplate>
        <div id ="div1">
                    <telerik:RadTreeView runat="server" ID="RadTreViewDir" OnClientNodeClicking ="ClientNodeClicking" 
                    Width="100%" Height="200px" DataFieldID="PK_ID" DataFieldParentID="FK_DOANHNGHIEP" DataSourceID="DoanhNghiepTreelist" 
                        DataTextField="TENDOANHNGHIEP" DataValueField="PK_ID" >                        
                    </telerik:RadTreeView>
            </div>
        </ItemTemplate>
            <Items>
            <telerik:RadComboBoxItem Text=""  />
        </Items>
<ExpandAnimation Type="None"></ExpandAnimation>
<CollapseAnimation Type="None"></CollapseAnimation>
</telerik:RadComboBox>
            <script type="text/javascript">
                var div1 = document.getElementById("div1");
                div1.onclick = StopPropagation;
            </script>
            <br />
                <asp:RequiredFieldValidator ForeColor ="Red"  ID="rfvParent" runat="server" ErrorMessage="Cần chọn doanh nghiệp mẹ" ControlToValidate="rcbParent" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
 </td>
</tr>
<tr>
    <td>
        Tên doanh nghiệp:
    </td>
    <td colspan ="3">
        <asp:TextBox ID="txtName" Width ="99%" Text='<%# Bind("TENDOANHNGHIEP") %>' runat="server"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator ID="rfvName" ForeColor ="Red" runat="server" ErrorMessage="Tên doanh nghiệp không thể rỗng" ControlToValidate="txtName" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
        <asp:Label ID="Label3" runat="server" Text=""></asp:Label>
    </td>   
</tr>  
<tr>
 <td>
        Tên giao dịch:
    </td>
    <td colspan ="3">
        <asp:TextBox ID="txttengiaodich" Width ="99%" Text='<%# Bind("TENGIAODICH") %>' runat="server"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator ID="rfvTengiaodich" ForeColor ="Red"  runat="server" ErrorMessage="Tên không thể rỗng" ControlToValidate="txttengiaodich" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
    </td> 
</tr>     
<tr>
    <td>
        Tên tiếng anh:
    </td>
    <td colspan ="3">
        <asp:TextBox ID="txtTentienganh" Width ="99%" Text='<%# Bind("TENTIENGANH") %>' runat="server"></asp:TextBox>
    </td>    
</tr>   
<tr>
    <td>
       Địa chỉ:
    </td>
    <td colspan ="3">
        <asp:TextBox ID="txtDiachi" Width ="99%" Text='<%# Bind("DIACHI") %>' runat="server"></asp:TextBox>
    </td>
</tr>   
<tr>
    <td>
        Điện thoại:
    </td>
    <td>
        <asp:TextBox ID="txtTel" Width ="99%" Text='<%# Bind("DIENTHOAI") %>' runat="server"></asp:TextBox>
    </td>
    <td>
        Fax:
    </td>
    <td>
        <asp:TextBox ID="txtFax" Width ="99%" Text='<%# Bind("FAX") %>' runat="server"></asp:TextBox>
    </td>
</tr>   
<tr>
    <td>
        Email:
    </td>
    <td>
        <asp:TextBox ID="txtEmail" Width ="99%" Text='<%# Bind("EMAIL") %>' runat="server"></asp:TextBox>
        <asp:RegularExpressionValidator ForeColor="Red"  ID="revEmail" runat="server" ErrorMessage="Email sai định dạng" ControlToValidate="txtEmail" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"  ValidationGroup="G1" Display="Dynamic"></asp:RegularExpressionValidator>
               
    </td>
     <td>
        Website:
    </td>
    <td>
        <asp:TextBox ID="txtwebsite" Width ="99%" Text='<%# Bind("WEBSITE") %>' runat="server"></asp:TextBox>
    </td>
</tr>     
<tr style =" font-weight:600;">
<td colspan ="4">
<div class="headerthongtin">
Thông tin về giám đốc doanh nghiệp/Dự án:
</div>
</td>
</tr> 
<tr>
    <td>
        Tên giám đốc:
    </td>
    <td colspan ="3">
        <asp:TextBox ID="txtTengiamdoc" Width ="99%" Text='<%# Bind("TENGIAMDOC") %>' runat="server"></asp:TextBox>
    </td>
</tr>    
<tr>
<td>
Giới tính:</td>
<td> <asp:RadioButtonList runat ="server"  ID ="rdoSex" Width ="100px" RepeatDirection ="Horizontal" SelectedValue ='<%# Bind("GIOITINH") %>'>
           <asp:ListItem Text ="Nam" Value ="1" ></asp:ListItem>
           <asp:ListItem Text ="Nữ" Value ="0" ></asp:ListItem>
            <asp:ListItem Text ="" Value ="" style =" display:none;" ></asp:ListItem>
       </asp:RadioButtonList></td>
       <td>Ngày sinh:</td>
<td>
   <telerik:RadDateTimePicker ID="radNgaysinh" Width ="150px" DbSelectedDate ='<%# Bind("NGAYSINH") %>' runat="server">
        <DateInput ID ="DateInput1" runat ="server" DateFormat ="dd/MM/yyyy"></DateInput>
        </telerik:RadDateTimePicker>
</td>
</tr>
<tr>
    <td>
        Quốc tịch:
    </td>
    <td>
       <telerik:RadComboBox ID="rcbQuoctich" DataSourceID ="QuoctichSqlDataSource" DataTextField ="C_NAME" DataValueField ="PK_ID"  
         EmptyMessage ="Chọn quốc tịch" SelectedValue ='<%# Bind("QUOCTICH") %>' runat="server" Filter ="Contains">
        </telerik:RadComboBox>
    </td>
     <td>
        Trình độ (Cao nhất):
    </td>
    <td>
        <telerik:RadComboBox ID="rcbTrinhdo" DataSourceID ="TrihdoSqlDataSource" DataTextField ="C_NAME" DataValueField ="PK_ID"  
         EmptyMessage ="Chọn trình độ học vấn" SelectedValue ='<%# Bind("TRINHDO") %>' runat="server" Filter ="Contains">
        </telerik:RadComboBox>
     </td>
</tr>
<tr style =" font-weight:600;">
<td colspan ="4">
<div class="headerthongtin">
Loại hình doanh nghiệp:
</div>
</td>
</tr> 
<tr>
  <td colspan ="3">
        Loại hình doanh nghiệp:
        <telerik:RadComboBox ID="rcbLoaihinh" Width ="350px" DataSourceID ="LoaiHinhSqlDataSource" DataTextField ="C_NAME" DataValueField ="PK_ID" 
         Filter ="Contains" EmptyMessage ="Chọn loại hình doanh nghiệp" SelectedValue ='<%# Bind("LOAIHINHDN") %>' runat="server">
        </telerik:RadComboBox>
     </td>
     <td>Vốn NNTW:<telerik:RadNumericTextBox Width ="50px" ID="txtperVNN"  Enabled ='<%#SetEnable(Eval("LOAIHINHDN"), "1") %>' DbValue ='<%# Bind("PHANTRAMVONNN") %>' runat="server"  IncrementSettings-InterceptMouseWheel="true"
        MaxValue="100" MinValue="0" ShowSpinButtons="true" IncrementSettings-InterceptArrowKeys="true">
         <NumberFormat  DecimalDigits ="0"/>
      </telerik:RadNumericTextBox>(%)</td>
</tr>
<tr>
  <td></td>
   <td colspan ="2">
       <asp:HiddenField ID="hfchiphoi" runat="server"  Value ='<%# Bind("NHANUOCCHIPHOI")%>'/>
       <asp:CheckBox ID="chkChiphoi" runat="server" Text ="Nhà nước chi phối"  Enabled ='<%#SetEnable(Eval("LOAIHINHDN"), "3") %>' onclick="javascript: chkChiphoislected()" Checked ='<%#getChiphoi(Eval("NHANUOCCHIPHOI")) %>' />
   </td>
    <td>
       Vốn NNĐP:<telerik:RadNumericTextBox Width ="50px"  ID="txtperVDP"  Enabled ='<%#SetEnable(Eval("LOAIHINHDN"), "2") %>' DbValue ='<%# Bind("PHANTRAMVONTN") %>' runat="server"  IncrementSettings-InterceptMouseWheel="true"
        MaxValue="100" MinValue="0" ShowSpinButtons="true" IncrementSettings-InterceptArrowKeys="true">
         <NumberFormat  DecimalDigits ="0"/>
        </telerik:RadNumericTextBox>(%)
   </td>
</tr>
<tr style =" font-weight:600;">
<td colspan ="4">
<div class="headerthongtin">
Các ngành đăng ký hoạt động sản xuất kinh doanh (VSIC 2007 - 5 số):
</div>
</td>
</tr> 
<tr>
<td colspan ="4">
<uc1:NganhNghe id="DUANVON1" runat="server"/>   
</td>
</tr>
</table>

</FormTemplate>
<PopUpSettings Width="800px" Height ="100%" ></PopUpSettings>
        </EditFormSettings>
        </MasterTableView>
        <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G1"/>
        <ClientSettings>
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
            <ClientEvents OnPopUpShowing="PopUpShowing" />
            <ClientEvents OnRowDblClick="RowDblClickDoanhNghiep"  OnRowContextMenu="RowContextMenu"/>
            <Scrolling  AllowScroll ="false" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
<FilterMenu EnableImageSprites="False"></FilterMenu>
    <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Vista">
    </HeaderContextMenu>
</telerik:RadGrid>
<asp:SqlDataSource ID="DoanhNghiepsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
        DeleteCommand="DELETE FROM [DOANHNGHIEP] WHERE [PK_ID] = @PK_ID; Delete FROM DOANHNGHIEP_NGANHNGHESXKD WHERE FK_DOANHNGHIEP = @PK_ID; Delete FROM DOANHNGHIEP_VALUE WHERE FK_DOANHNGHIEP =@PK_ID" 
        InsertCommand="INSERT INTO DOANHNGHIEP(FK_DOANHNGHIEP, MADOANHNGHIEP, TENDOANHNGHIEP, TENGIAODICH, TENTIENGANH, MASOTHUE, DIACHI, DIENTHOAI, FAX, EMAIL, WEBSITE, TENGIAMDOC, GIOITINH, QUOCTICH, TRINHDO, HINHTHUCDAUTU, LOAIHINHDN, PHANTRAMVONNN, PHANTRAMVONTN, NHANUOCCHIPHOI, SOCNDT, NGAYCAPCNDT, VITRIDUAN, THONGTINBAOCAO, NGAYSINH, FK_NGANHSXKD_MAIN, FK_NGANHSXKD_1, FK_NGANHSXKD_2, FK_NGANHSXKD_3, FK_NGANHSXKD_4) VALUES (@FK_DOANHNGHIEP, @MADOANHNGHIEP, @TENDOANHNGHIEP, @TENGIAODICH, @TENTIENGANH, @MASOTHUE, @DIACHI, @DIENTHOAI, @FAX, @EMAIL, @WEBSITE, @TENGIAMDOC, @GIOITINH, @QUOCTICH, @TRINHDO, @HINHTHUCDAUTU, @LOAIHINHDN, @PHANTRAMVONNN, @PHANTRAMVONTN, @NHANUOCCHIPHOI, @SOCNDT, @NGAYCAPCNDT, @VITRIDUAN, @THONGTINBAOCAO, @NGAYSINH, @FK_NGANHSXKD_MAIN, @FK_NGANHSXKD_1, @FK_NGANHSXKD_2, @FK_NGANHSXKD_3, @FK_NGANHSXKD_4)"
        SelectCommand="SELECT * FROM DOANHNGHIEP WHERE (FK_DOANHNGHIEP = @FK_DOANHNGHIEP) ORDER BY TENDOANHNGHIEP DESC, TENGIAODICH DESC, TENTIENGANH DESC"     
        
    UpdateCommand="UPDATE DOANHNGHIEP SET FK_DOANHNGHIEP = @FK_DOANHNGHIEP, MADOANHNGHIEP = @MADOANHNGHIEP, TENDOANHNGHIEP = @TENDOANHNGHIEP, TENGIAODICH = @TENGIAODICH, TENTIENGANH = @TENTIENGANH, MASOTHUE = @MASOTHUE, DIACHI = @DIACHI, DIENTHOAI = @DIENTHOAI, FAX = @FAX, EMAIL = @EMAIL, WEBSITE = @WEBSITE, TENGIAMDOC = @TENGIAMDOC, GIOITINH = @GIOITINH, QUOCTICH = @QUOCTICH, TRINHDO = @TRINHDO, HINHTHUCDAUTU = @HINHTHUCDAUTU, LOAIHINHDN = @LOAIHINHDN, PHANTRAMVONNN = @PHANTRAMVONNN, PHANTRAMVONTN = @PHANTRAMVONTN, NHANUOCCHIPHOI = @NHANUOCCHIPHOI, SOCNDT = @SOCNDT, NGAYCAPCNDT = @NGAYCAPCNDT, VITRIDUAN = @VITRIDUAN, THONGTINBAOCAO = @THONGTINBAOCAO, NGAYSINH = @NGAYSINH, FK_NGANHSXKD_MAIN = @FK_NGANHSXKD_MAIN, FK_NGANHSXKD_1 = @FK_NGANHSXKD_1, FK_NGANHSXKD_2 = @FK_NGANHSXKD_2, FK_NGANHSXKD_3 = @FK_NGANHSXKD_3, FK_NGANHSXKD_4 = @FK_NGANHSXKD_4 WHERE (PK_ID = @PK_ID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="hfFilter" DefaultValue="0" 
                Name="FK_DOANHNGHIEP" PropertyName="Value" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="FK_DOANHNGHIEP" Type="Int32" />
            <asp:Parameter Name="MADOANHNGHIEP" Type="String" />
            <asp:Parameter Name="TENDOANHNGHIEP" Type="String" />
            <asp:Parameter Name="TENGIAODICH" Type="String" />
            <asp:Parameter Name="TENTIENGANH" Type="String" />
            <asp:Parameter Name="MASOTHUE" Type="String" />
            <asp:Parameter Name="DIACHI" Type="String" />
            <asp:Parameter Name="DIENTHOAI" Type="String" />
            <asp:Parameter Name="FAX" Type="String" />
            <asp:Parameter Name="EMAIL" Type="String" />
            <asp:Parameter Name="WEBSITE" Type="String" />
            <asp:Parameter Name="TENGIAMDOC" Type="String" />
            <asp:Parameter Name="GIOITINH" Type="Int32" />
            <asp:Parameter Name="QUOCTICH" Type="String" />
            <asp:Parameter Name="TRINHDO" Type="Int32" />
            <asp:Parameter Name="HINHTHUCDAUTU" Type="Int32" />
            <asp:Parameter Name="LOAIHINHDN" Type="Int32" />
            <asp:Parameter Name="PHANTRAMVONNN" Type="Double" />
            <asp:Parameter Name="PHANTRAMVONTN" Type="Double" />
            <asp:Parameter Name="NHANUOCCHIPHOI" Type="Int32" />
            <asp:Parameter Name="SOCNDT" Type="String" />
            <asp:Parameter Name="NGAYCAPCNDT" Type="DateTime" />
            <asp:Parameter Name="VITRIDUAN" Type="Int32" />
            <asp:Parameter Name="THONGTINBAOCAO" Type="Int32" />
            <asp:Parameter Name="NGAYSINH" Type="DateTime" />
            <asp:Parameter Name="FK_NGANHSXKD_MAIN" />
            <asp:Parameter Name="FK_NGANHSXKD_1" />
            <asp:Parameter Name="FK_NGANHSXKD_2" />
            <asp:Parameter Name="FK_NGANHSXKD_3" />
            <asp:Parameter Name="FK_NGANHSXKD_4" />
            <asp:Parameter Name="PK_ID" Type="Int32" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="PK_ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="FK_DOANHNGHIEP" Type="Int32" />
            <asp:Parameter Name="MADOANHNGHIEP" Type="String" />
            <asp:Parameter Name="TENDOANHNGHIEP" Type="String" />
            <asp:Parameter Name="TENGIAODICH" Type="String" />
            <asp:Parameter Name="TENTIENGANH" Type="String" />
            <asp:Parameter Name="MASOTHUE" Type="String" />
            <asp:Parameter Name="DIACHI" Type="String" />
            <asp:Parameter Name="DIENTHOAI" Type="String" />
            <asp:Parameter Name="FAX" Type="String" />
            <asp:Parameter Name="EMAIL" Type="String" />
            <asp:Parameter Name="WEBSITE" Type="String" />
            <asp:Parameter Name="TENGIAMDOC" Type="String" />
            <asp:Parameter Name="GIOITINH" Type="Int32" />
            <asp:Parameter Name="QUOCTICH" Type="String" />
            <asp:Parameter Name="TRINHDO" Type="Int32" />
            <asp:Parameter Name="HINHTHUCDAUTU" Type="Int32" />
            <asp:Parameter Name="LOAIHINHDN" Type="Int32" />
            <asp:Parameter Name="PHANTRAMVONNN" Type="Double" />
            <asp:Parameter Name="PHANTRAMVONTN" Type="Double" />
            <asp:Parameter Name="NHANUOCCHIPHOI" Type="Int32" />
            <asp:Parameter Name="SOCNDT" Type="String" />
            <asp:Parameter Name="NGAYCAPCNDT" Type="DateTime" />
            <asp:Parameter Name="VITRIDUAN" Type="Int32" />
            <asp:Parameter Name="THONGTINBAOCAO" Type="Int32" />
            <asp:Parameter Name="NGAYSINH" Type="DateTime" />
            <asp:Parameter Name="FK_NGANHSXKD_MAIN" />
            <asp:Parameter Name="FK_NGANHSXKD_1" />
            <asp:Parameter Name="FK_NGANHSXKD_2" />
            <asp:Parameter Name="FK_NGANHSXKD_3" />
            <asp:Parameter Name="FK_NGANHSXKD_4" />
        </InsertParameters>
</asp:SqlDataSource>     

<telerik:RadWindowManager ReloadOnShow="true" ShowContentDuringLoad="false" ID="RadWindowManagerCG" runat="server" VisibleStatusbar="False"
   OnClientClose="OnClientCloseText" OnClientShow="OnClientShowText" Behaviors ="Close,Reload" ></telerik:RadWindowManager>

<asp:SqlDataSource ID="ViewDoanhNghiepSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
    SelectCommand="SELECT * FROM [DOANHNGHIEP] WHERE [PK_ID] = @PK_ID">
    <SelectParameters>
        <asp:Parameter Name ="PK_ID" Type ="Int64" />
  </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="DoanhNghiepTreelist" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
    SelectCommand="SELECT 0 as PK_ID , NULL AS FK_DOANHNGHIEP, N'Doanh nghiệp hoạt động trong khu CNC Hòa lạc' AS TENDOANHNGHIEP FROM [DOANHNGHIEP] UNION SELECT PK_ID, FK_DOANHNGHIEP, TENDOANHNGHIEP FROM [DOANHNGHIEP]">
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSourceListDoanhNghiep" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
    SelectCommand="SELECT 0 as PK_ID , NULL AS FK_DOANHNGHIEP, N'Doanh nghiệp hoạt động trong khu CNC Hòa lạc' AS TENDOANHNGHIEP FROM [DOANHNGHIEP] UNION SELECT PK_ID, FK_DOANHNGHIEP, TENDOANHNGHIEP FROM [DOANHNGHIEP]">
 </asp:SqlDataSource>
<asp:SqlDataSource ID="TrihdoSqlDataSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>" 
    SelectCommand="SELECT * FROM [DMTRINHDO] ORDER BY [C_NAME], [PK_ID]"></asp:SqlDataSource>
<asp:SqlDataSource ID="QuoctichSqlDataSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>" 
    SelectCommand="SELECT CountryName as C_NAME,CountryID as PK_ID FROM [COUNTRY] ORDER BY [CountryID], [CountryName]"></asp:SqlDataSource>
<asp:SqlDataSource ID="LoaiHinhSqlDataSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>" 
    SelectCommand="SELECT * FROM [DMLOAIHINHDN] ORDER BY [C_NAME], [PK_ID]"></asp:SqlDataSource>
<asp:SqlDataSource ID="NganhgheSqlDataSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>" 
    SelectCommand="SELECT PK_ID, C_CODE +' || ' + C_NAME AS NAMEDN, C_NAME FROM [DMNGANHNGHEKD] ORDER BY [C_NAME], [PK_ID]"></asp:SqlDataSource>

<telerik:RadContextMenu ID="RadMenu1" runat="server" OnClientItemClicked ="RadMenu_ItemClientClick" 
EnableRoundedCorners="true" EnableShadows="true" Skin="Office2010Black" CssClass ="itemmenu">
    <Items>
        <telerik:RadMenuItem Text="Lao động" Value ="LAODONG" ImageUrl ="../images/img_laodong.jpg" />
        <telerik:RadMenuItem Text="Đầu tư xây dụng"  Value ="DAUTU" ImageUrl ="../images/img_tinh-hinh-xay-dung.jpg" />
        <telerik:RadMenuItem Text="Đào tạo nghề" Value ="DAOTAO" ImageUrl ="../images/img_daotaonghe.jpg" />
        <telerik:RadMenuItem Text="Hoạt động nhà hàng" Value ="NHAHANG" ImageUrl ="../images/img_hoatdong_nhahang.jpg" />
        <telerik:RadMenuItem Text="Hoạt động dịch vụ khác" Value ="DICHVU" ImageUrl ="../images/img_hoat-dong-khac.jpg" />
        <telerik:RadMenuItem Text="Thu nhập lao động" Value ="THUNHAP" ImageUrl ="../images/img_thunhaplaodong.jpg" />
        <telerik:RadMenuItem Text="Tinh hình góp vốn"  Value ="GOPVON" ImageUrl ="../images/img_gop-von.jpg" />
        <telerik:RadMenuItem Text="Tình hình hoạt động dự án"  Value ="HDDUAN" ImageUrl ="../images/img_hoat-dong-khac (2).jpg" />
        <telerik:RadMenuItem Text="Theo dõi tai nạn lao động" Value ="TAINAN" ImageUrl ="../images/img_tai-nan-ld.jpg" />
        <telerik:RadMenuItem Text="Ứng dụng công nghệ thông tin" Value ="CNTT" ImageUrl ="../images/img_cntt.jpg" />
        <telerik:RadMenuItem Text="Tình tình bảo vệ môi trường"  Value ="BVMT" ImageUrl ="../images/img_bv-moi-truong.jpg" />
        <telerik:RadMenuItem Text="Tình tình Xây dựng"  Value ="XAYDUNG" ImageUrl ="../images/img_xay-dung.jpg" />
        <telerik:RadMenuItem Text="Hoạt động lưu trú" Value ="LUUTRU" ImageUrl ="../images/img_luu-tru.jpg" />
    </Items>
</telerik:RadContextMenu>

 