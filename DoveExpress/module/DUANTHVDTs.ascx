<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DUANTHVDTs.ascx.cs" Inherits="module_DUANTHVDT" %>

<telerik:RadCodeBlock ID="RadCodeBlockDUANTHVDT" runat="server">
<script type="text/javascript">
        function RowDblClickUser(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("DUANs") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewDUANTHVDT") && (CanEdit == "True")) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
        }
</script>
<script type="text/javascript">
    function CloseAndRebind(args) {
        GetRadWindow().BrowserWindow.refreshGrid(args);
        GetRadWindow().close();
    }

    function GetRadWindow() {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including clasic dialog
        else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; //IE (and Moz as well)

        return oWindow;
    }

    function CancelEdit() {
        GetRadWindow().close();
    }
    var RadNumericTextBox1, RadNumericTextBox2, RadNumericTextBox3, RadNumericTextBox4, RadNumericTextBox5, RadNumericTextBox6, RadNumericTextBox7, RadNumericTextBox8, RadNumericTextBox9, RadNumericTextBox10, RadNumericTextBox11, RadNumericTextBox12, RadNumericTextBox13, RadNumericTextBox14, RadNumericTextBox15, RadNumericTextBox16, RadNumericTextBox17, RadNumericTextBox18, RadNumericTextBox19, RadNumericTextBox20, RadNumericTextBox21, RadNumericTextBox22, RadNumericTextBox23, RadNumericTextBox24, RadNumericTextBox25;
    function OnClientLoadRadNumericTextBox1(sender) {
        RadNumericTextBox1 = sender;
    }
    function OnClientLoadRadNumericTextBox2(sender) {
        RadNumericTextBox2 = sender;
    }
    function OnClientLoadRadNumericTextBox3(sender) {
        RadNumericTextBox3 = sender;
    }
    function OnClientLoadRadNumericTextBox4(sender) {
        RadNumericTextBox4 = sender;
    }
    function OnClientLoadRadNumericTextBox5(sender) {
        RadNumericTextBox5 = sender;
    }
    function OnClientLoadRadNumericTextBox6(sender) {
        RadNumericTextBox6 = sender;
    }
    function OnClientLoadRadNumericTextBox7(sender) {
        RadNumericTextBox7 = sender;
    }
    function OnClientLoadRadNumericTextBox8(sender) {
        RadNumericTextBox8 = sender;
    }
    function OnClientLoadRadNumericTextBox9(sender) {
        RadNumericTextBox9 = sender;
    }
    function OnClientLoadRadNumericTextBox10(sender) {
        RadNumericTextBox10 = sender;
    }
    function OnClientLoadRadNumericTextBox11(sender) {
        RadNumericTextBox11 = sender;
    }
    function OnClientLoadRadNumericTextBox12(sender) {
        RadNumericTextBox12 = sender;
    }
    function OnClientLoadRadNumericTextBox13(sender) {
        RadNumericTextBox13 = sender;
    }
    function OnClientLoadRadNumericTextBox14(sender) {
        RadNumericTextBox14 = sender;
    }
    function OnClientLoadRadNumericTextBox15(sender) {
        RadNumericTextBox15 = sender;
    }
    function OnClientLoadRadNumericTextBox16(sender) {
        RadNumericTextBox16 = sender;
    }
    function OnClientLoadRadNumericTextBox17(sender) {
        RadNumericTextBox17 = sender;
    }
    function OnClientLoadRadNumericTextBox18(sender) {
        RadNumericTextBox18 = sender;
    }
    function OnClientLoadRadNumericTextBox19(sender) {
        RadNumericTextBox19 = sender;
    }
    function OnClientLoadRadNumericTextBox20(sender) {
        RadNumericTextBox20 = sender;
    }
    function OnClientLoadRadNumericTextBox21(sender) {
        RadNumericTextBox21 = sender;
    }
    function OnClientLoadRadNumericTextBox22(sender) {
        RadNumericTextBox22 = sender;
    }
    function OnClientLoadRadNumericTextBox23(sender) {
        RadNumericTextBox23 = sender;
    }
    function OnClientLoadRadNumericTextBox24(sender) {
        RadNumericTextBox24 = sender;
    }
    function OnClientLoadRadNumericTextBox25(sender) {
        RadNumericTextBox25 = sender;
    }    
    function OnValueChangedRadNumericTextBox1(sender, args) {
    
    }
    function OnValueChangedRadNumericTextBox2(sender, args) {
       
    }
    function OnValueChangedRadNumericTextBox3(sender, args) {
        RadNumericTextBox2.set_value(RadNumericTextBox3.get_value() + RadNumericTextBox4.get_value());
    }
    function OnValueChangedRadNumericTextBox4(sender, args) {
        RadNumericTextBox2.set_value(RadNumericTextBox3.get_value() + RadNumericTextBox4.get_value());
    }
    function OnValueChangedRadNumericTextBox5(sender, args) {

    }
    function OnValueChangedRadNumericTextBox6(sender, args) {
        RadNumericTextBox5.set_value(RadNumericTextBox6.get_value() + RadNumericTextBox7.get_value());
    }
    function OnValueChangedRadNumericTextBox7(sender, args) {
        RadNumericTextBox5.set_value(RadNumericTextBox6.get_value() + RadNumericTextBox7.get_value());
    }
    function OnValueChangedRadNumericTextBox8(sender, args) {

    }
    function OnValueChangedRadNumericTextBox9(sender, args) {
        RadNumericTextBox8.set_value(RadNumericTextBox9.get_value() - RadNumericTextBox10.get_value());
    }
    function OnValueChangedRadNumericTextBox10(sender, args) {
        RadNumericTextBox8.set_value(RadNumericTextBox9.get_value() - RadNumericTextBox10.get_value());

    } 
    function OnValueChangedRadNumericTextBox11(sender, args) {

    }
    function OnValueChangedRadNumericTextBox12(sender, args) {

    }
    function OnValueChangedRadNumericTextBox13(sender, args) {
        RadNumericTextBox12.set_value(RadNumericTextBox13.get_value() + RadNumericTextBox14.get_value());
        RadNumericTextBox11.set_value(RadNumericTextBox13.get_value() + RadNumericTextBox14.get_value() + RadNumericTextBox16.get_value() - RadNumericTextBox15.get_value());
    }
    function OnValueChangedRadNumericTextBox14(sender, args) {
        RadNumericTextBox12.set_value(RadNumericTextBox13.get_value() + RadNumericTextBox14.get_value());
        RadNumericTextBox11.set_value(RadNumericTextBox13.get_value() + RadNumericTextBox14.get_value() + RadNumericTextBox16.get_value() - RadNumericTextBox15.get_value());
    }
    function OnValueChangedRadNumericTextBox15(sender, args) {
        RadNumericTextBox11.set_value(RadNumericTextBox13.get_value() + RadNumericTextBox14.get_value() + RadNumericTextBox16.get_value() - RadNumericTextBox15.get_value());
    } 
    function OnValueChangedRadNumericTextBox16(sender, args) {
        RadNumericTextBox11.set_value(RadNumericTextBox13.get_value() + RadNumericTextBox14.get_value() + RadNumericTextBox16.get_value() - RadNumericTextBox15.get_value());
    }
    function OnValueChangedRadNumericTextBox17(sender, args) {
    }
    function OnValueChangedRadNumericTextBox18(sender, args) {
        RadNumericTextBox17.set_value(RadNumericTextBox18.get_value() + RadNumericTextBox19.get_value());
    }
    function OnValueChangedRadNumericTextBox19(sender, args) {
        RadNumericTextBox17.set_value(RadNumericTextBox18.get_value() + RadNumericTextBox19.get_value());
    }
    function OnValueChangedRadNumericTextBox20(sender, args) {

    } 
    function OnValueChangedRadNumericTextBox21(sender, args) {
        RadNumericTextBox20.set_value(RadNumericTextBox21.get_value() + RadNumericTextBox22.get_value());
    }
    function OnValueChangedRadNumericTextBox22(sender, args) {
        RadNumericTextBox20.set_value(RadNumericTextBox21.get_value() + RadNumericTextBox22.get_value());
    }
    function OnValueChangedRadNumericTextBox23(sender, args) {

    }
    function OnValueChangedRadNumericTextBox24(sender, args) {
        RadNumericTextBox23.set_value(RadNumericTextBox24.get_value() + RadNumericTextBox25.get_value());
    }
    function OnValueChangedRadNumericTextBox25(sender, args) {
        RadNumericTextBox23.set_value(RadNumericTextBox24.get_value() + RadNumericTextBox25.get_value());
    }
</script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelDUANTHVDT" runat="server" />
<div style ="width:100%; margin: 10px 10px 10px 10px; ">
Chọn năm:&nbsp; 
<telerik:RadComboBox ID="cmbYear" runat="server" AutoPostBack ="true" 
        ShowToggleImage="True" EmptyMessage="Chọn năm" onload="cmbYear_Load">
</telerik:RadComboBox><br><br>
<b>Tên dự án:&nbsp; <asp:Label ID="lblTENDUAN" ForeColor ="Red" runat="server" Text=""></asp:Label><br><br>
Mã dự án:&nbsp; <asp:Label ID="lblMADUAN" ForeColor ="Red" runat="server" Text=""></asp:Label><br><br>
Tổng đầu tư:&nbsp; <asp:Label ID="lblTONGDAUTU" ForeColor ="Red" runat="server" Text=""></asp:Label><br><br>
Tổng dự toán:&nbsp; <asp:Label ID="lblTONGDUTOAN" ForeColor ="Red" runat="server" Text=""></asp:Label></b>
</div>
<telerik:RadGrid ID="RadGridDUANTHVDT" runat="server" Skin="Windows7" 
    AllowPaging="false" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="false" GridLines="None" ShowStatusBar="True"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="DUANTHVDTDataSource" ShowFooter="True"
    ondatabound="RadGridDUANTHVDT_DataBound"  
    onitemcommand="RadGridDUANTHVDT_ItemCommand" CellSpacing="0" 
    onprerender="RadGridDUANTHVDT_PreRender" 
    onitemupdated="RadGridDUANTHVDT_ItemUpdated" 
    onitemcreated="RadGridDUANTHVDT_ItemCreated" 
    onitemdatabound="RadGridDUANTHVDT_ItemDataBound">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML">
<Excel Format="ExcelML"></Excel>
    </ExportSettings>   
       <GroupingSettings CaseSensitive ="false" CollapseTooltip="Đóng nhóm" 
         ExpandTooltip="Mở nhóm" 
         GroupContinuedFormatString="... tiếp các bản ghi của nhóm từ trang trước. " 
         GroupContinuesFormatString=" Các bản ghi được hiển thị tiếp ở trang sau." 
         GroupSplitDisplayFormat=" Hiển thị {0} / {1} bản ghi." 
         UnGroupButtonTooltip="Chick vào đây để hủy nhóm" 
         UnGroupTooltip="Kéo ra ngoài để hủy nhóm"  />
    <MasterTableView Name="MasterTableViewDUANTHVDT" CommandItemDisplay="Top" DataSourceID="DUANTHVDTDataSource" DataKeyNames="PK_ID" 
    ClientDataKeyNames="PK_ID" EditMode="InPlace" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b><asp:Label ID="lblCap" ForeColor ="Red" runat="server" Text="" OnPreRender ="lblCap_PreRender"></asp:Label></b>&nbsp;&nbsp;&nbsp;&nbsp;
                       <br /><br /><asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridDUANTHVDT.EditIndexes.Count == 0 && ITCLIB.Security.Security.CanEditModule("DUANs") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridDUANTHVDT.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/img_save.jpg" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridDUANTHVDT.EditIndexes.Count > 0 || RadGridDUANTHVDT.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InsertCode" Visible='<%# !RadGridDUANTHVDT.MasterTableView.IsItemInserted && ITCLIB.Security.Security.CanAddModule("DUANs") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Tạo bảng báo cáo</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:return confirm('Bạn có muốn xóa dữ liệu thống kê đang theo dõi?')" runat="server" CommandName="DeleteSelected" Visible='<%# ITCLIB.Security.Security.CanDeleteModule("DUANs") %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Delete.gif" />Xóa</asp:LinkButton>&nbsp;&nbsp;
                       <asp:LinkButton ID="LinkButton4" runat="server" CommandName="RebindGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Refresh.gif" />Làm mới</asp:LinkButton>&nbsp;&nbsp;
                       <asp:LinkButton ID="LinkButton5" runat="server" OnClientClick="javascript:return CancelEdit()"><img style="border:0px;vertical-align:middle;" alt="" src="Images/img_close.jpg" />Đóng</asp:LinkButton>
                    </div>
                    <div style="padding: 5px 5px;float:right;width:auto">
                        <asp:LinkButton ID="ExportToPdfButton" runat="server" CommandName="ExportToPdf"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/pdf.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToWordButton" runat="server" CommandName="ExportToWord"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/word.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToExcelButton" runat="server" CommandName="ExportToExcel"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/excel.gif" /></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="ExportToCsvButton" runat="server" CommandName="ExportToCsv"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/csv.gif" /></asp:LinkButton>&nbsp;&nbsp;
                    </div>
        </CommandItemTemplate>
<CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
<RowIndicatorColumn FilterControlAltText="Filter RowIndicator column"></RowIndicatorColumn>
<ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column"></ExpandCollapseColumn>
<Columns>
    <telerik:GridBoundColumn UniqueName="TENDUAN" HeaderText="TENDUAN" Visible ="false" DataField="TENDUAN">
    </telerik:GridBoundColumn>
    <telerik:GridBoundColumn DataField="PK_ID" Visible ="false" UniqueName="PK_ID" DataType="System.Int64"></telerik:GridBoundColumn>
    <telerik:GridBoundColumn DataField="FK_DUAN" Visible ="false" UniqueName="FK_DUAN" DataType="System.Int32"></telerik:GridBoundColumn>
    <telerik:GridBoundColumn DataField="FK_TIEUCHI" DataType="System.Int32" Visible ="false"  UniqueName="FK_TIEUCHI"></telerik:GridBoundColumn>
    <telerik:GridTemplateColumn DataField="C_NAME"  ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter C_NAME column" HeaderText="Chỉ tiêu"   SortExpression="C_NAME" UniqueName="C_NAME"  HeaderStyle-Width ="200px" >   
     <ItemTemplate>
            <%#getName(Eval("C_NAME"),Eval("C_LEVEL").ToString(),Eval("C_HEADER"))%>
      </ItemTemplate>
      <EditItemTemplate>
           <%#getName(Eval("C_NAME"),Eval("C_LEVEL").ToString(),Eval("C_HEADER"))%>
      </EditItemTemplate>
    </telerik:GridTemplateColumn>
     <telerik:GridTemplateColumn UniqueName="C_CODE" DataField="C_CODE"  DataType="System.String" Visible ="false" HeaderText="Mã" HeaderStyle-Width ="30px">
     <ItemTemplate>
            <%#Eval("C_CODE")%>
      </ItemTemplate>
      <EditItemTemplate>
            <asp:Label ID="lblC_CODE" ForeColor ="Red" runat="server" Text='<%#Eval("C_CODE")%>'></asp:Label>         
      </EditItemTemplate>
    </telerik:GridTemplateColumn>
    <telerik:GridBoundColumn UniqueName="C_DATE" DataField="C_DATE" DataType="System.Int32" Visible ="false" HeaderText="C_DATE">
    </telerik:GridBoundColumn>
     <telerik:GridTemplateColumn DataField="VALUE1"  ShowFilterIcon ="false" FilterControlWidth ="100%" AutoPostBackOnFilter ="true" 
        FilterControlAltText="Filter VALUE1 column" HeaderText="Giá trị (Triệu đồng)"  ItemStyle-Width ="70px" HeaderStyle-Width ="70px" 
        SortExpression="VALUE1" UniqueName="VALUE1">   
     <ItemTemplate>
            <%#Eval("VALUE1")%>
      </ItemTemplate>
      <EditItemTemplate>
            <telerik:RadNumericTextBox  ID="txtVALUE1" Runat="server" Enabled ='<%#(bool)Eval("C_ISTYPE") %>' Text ='<%#Bind("VALUE1")%>'
             IncrementSettings-InterceptMouseWheel="true" Width="120px"  CssClass ="csstextNum" MaxValue="500000" MinValue="0" IncrementSettings-InterceptArrowKeys="true">
             <NumberFormat  DecimalDigits ="0"/>
             </telerik:RadNumericTextBox>
      </EditItemTemplate>
    </telerik:GridTemplateColumn>
</Columns>
        </MasterTableView>
        <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G1"/>
        <ClientSettings>
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
            <ClientEvents OnPopUpShowing="PopUpShowing" />
            <ClientEvents OnRowDblClick="RowDblClick" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
<FilterMenu EnableImageSprites="False"></FilterMenu>

<HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Vista"></HeaderContextMenu>
</telerik:RadGrid>
<asp:SqlDataSource ID="DUANTHVDTDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
        DeleteCommand="DELETE FROM DUANVON_VALUE WHERE (PK_ID = @PK_ID)" 
        InsertCommand="INSERT INTO DUANVON_VALUE(FK_DUAN, FK_TIEUCHI, C_DATE, VALUE1, VALUE2, VALUE3, VALUE4, VALUE5, VALUE6, VALUE7, VALUE8, VALUE9) VALUES (@FK_DUAN, @FK_TIEUCHI, @C_DATE, @VALUE1, @VALUE2, @VALUE3, @VALUE4, @VALUE5, @VALUE6, @VALUE7, @VALUE8, @VALUE9)"
        SelectCommand="SELECT DUAN.TENDUAN, DUANVON_VALUE.PK_ID, DUANVON_VALUE.FK_DUAN, DUANVON_VALUE.FK_TIEUCHI, DUANVON_VALUE.C_DATE, DUANVON_VALUE.C_DATE_EDIT, DUANVON_VALUE.VALUE1, DUANVON_VALUE.VALUE2, DUANVON_VALUE.VALUE3, DUANVON_VALUE.VALUE4, DUANVON_VALUE.VALUE5, DUANVON_VALUE.VALUE6, DUANVON_VALUE.VALUE7, DUANVON_VALUE.VALUE8, DUANVON_VALUE.VALUE9, DUANVON_VALUE.VALUE10, DUANVON_VALUE.VALUE11, CONVERT (DATETIME, FLOOR(CONVERT (FLOAT, DUANVON_VALUE.C_DATE))) AS DATEONLY, DUANVON_TIEUCHI.C_CODE, DUANVON_TIEUCHI.C_NAME, DUANVON_TIEUCHI.C_HEADER, DUANVON_TIEUCHI.C_LEVEL,DUANVON_TIEUCHI.C_ISTYPE FROM DUANVON_VALUE INNER JOIN DUAN ON DUANVON_VALUE.FK_DUAN = DUAN.PK_ID INNER JOIN DUANVON_TIEUCHI ON DUANVON_VALUE.FK_TIEUCHI = DUANVON_TIEUCHI.PK_ID WHERE (DUAN.PK_ID = @PK_ID) AND (DUANVON_TIEUCHI.C_TYPE = 'VONDAUTU') AND (DUANVON_VALUE.C_DATE =@C_DATE) ORDER BY DATEONLY DESC,DUANVON_TIEUCHI.C_ORDER"      
        UpdateCommand="UPDATE DUANVON_VALUE SET C_DATE_EDIT = GETDATE(), VALUE1 = @VALUE1, VALUE2 = @VALUE2, VALUE3 = @VALUE3, VALUE4 = @VALUE4, VALUE5 = @VALUE5, VALUE6 = @VALUE6, VALUE8 = @VALUE8, VALUE7 = @VALUE7, VALUE9 = @VALUE9 WHERE (PK_ID = @PK_ID)" >
    <DeleteParameters>
        <asp:Parameter Name="PK_ID" />
    </DeleteParameters>
    <InsertParameters>
        <asp:QueryStringParameter DefaultValue="0" Name="FK_DUAN" QueryStringField="daID" />
        <asp:Parameter Name="FK_TIEUCHI" />
        <asp:Parameter Name="C_DATE" />
        <asp:Parameter Name="VALUE1" />
        <asp:Parameter Name="VALUE2" />
        <asp:Parameter Name="VALUE3" />
        <asp:Parameter Name="VALUE4" />
        <asp:Parameter Name="VALUE5" />
        <asp:Parameter Name="VALUE6" />
        <asp:Parameter Name="VALUE7" />
        <asp:Parameter Name="VALUE8" />
        <asp:Parameter Name="VALUE9" />
    </InsertParameters>
    <SelectParameters>
        <asp:QueryStringParameter DefaultValue="0" Name="PK_ID" QueryStringField="daID" />
        <asp:ControlParameter ControlID="cmbYear" DefaultValue="0" Name="C_DATE" PropertyName="SelectedValue" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="VALUE1" />
        <asp:Parameter Name="VALUE2" />
        <asp:Parameter Name="VALUE3" />
        <asp:Parameter Name="VALUE4" />
        <asp:Parameter Name="VALUE5" />
        <asp:Parameter Name="VALUE6" />
        <asp:Parameter Name="VALUE8" />
        <asp:Parameter Name="VALUE7" />
        <asp:Parameter Name="VALUE9" />
        <asp:Parameter Name="PK_ID" />
    </UpdateParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="DUANVON_TIEUCHISqlDataSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>" 
    SelectCommand="SELECT * FROM [DUANVON_TIEUCHI] WHERE ([C_TYPE] = @C_TYPE)">
    <SelectParameters>
        <asp:Parameter DefaultValue="VONDAUTU" Name="C_TYPE" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
