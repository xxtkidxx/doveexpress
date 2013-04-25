<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Dutoanthus.ascx.cs" Inherits="module_Dutoanthus" %>
<%@ Register TagPrefix="custom" Namespace="ITCLIB.Filter" %>
<telerik:RadScriptBlock ID="RadScriptBlockthu" runat="server">   
<script type="text/javascript">
    function RowDblClickthu(sender, eventArgs) {
            var CanEdit = "<%=ITCLIB.Security.Security.CanEditModule("DUTOANSXKDs") %>";
            if ((eventArgs.get_tableView().get_name() == "MasterTableViewthu") && (CanEdit == "True")) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
    }
    </script>
<script type="text/javascript">
    function PopUpShowingthu(sender, eventArgs) {
        var popUp = eventArgs.get_popUp();
        var gridWidth = sender.get_element().offsetWidth;
        var gridHeight = sender.get_element().offsetHeight;
        var popUpWidth = popUp.style.width.substr(0, popUp.style.width.indexOf("px"));
        var popUpHeight = popUp.style.height.substr(0, popUp.style.height.indexOf("px"));
        popUp.style.left = "0px";
        popUp.style.top = "15px";
    } 
   </script>
</telerik:RadScriptBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelTHU" runat="server" />
<telerik:RadGrid ID="RadGridTHU" runat="server" Skin="Windows7" 
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="true"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="THUsDataSource" ShowFooter="True"
    ondatabound="RadGridTHU_DataBound" 
    onitemdeleted="RadGridTHU_ItemDeleted" oniteminserted="RadGridTHU_ItemInserted" 
    onitemupdated="RadGridTHU_ItemUpdated" 
    onitemcommand="RadGridTHU_ItemCommand" 
    onitemdatabound="RadGridTHU_ItemDataBound">
     <GroupingSettings CaseSensitive ="false"  />
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
    <MasterTableView Name="MasterTableViewthu" CommandItemDisplay="Top" DataSourceID="THUsDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="InPlace" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b><asp:Label ID="lblTitle" ForeColor ="Red" runat="server"></asp:Label></b>&nbsp;&nbsp;&nbsp;&nbsp;       
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridTHU.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;                 
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
                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditColumn" HeaderStyle-Width ="60px">
                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </telerik:GridEditCommandColumn>
                <telerik:GridButtonColumn HeaderStyle-Width ="40px" ConfirmText="Bạn muốn xóa dự toán thu?" ConfirmDialogType="RadWindow"
                    ConfirmTitle="Xóa" ButtonType="ImageButton" CommandName="Delete" Text="Xóa" UniqueName="DeleteColumn">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </telerik:GridButtonColumn>    
                <telerik:GridBoundColumn UniqueName="PK_ID" HeaderText="ID" DataField="PK_ID" Visible="false">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn UniqueName="STT" HeaderText="STT"  HeaderStyle-Width ="40px"  HeaderStyle-HorizontalAlign ="Center" AllowFiltering ="false">
					<ItemTemplate>
						<asp:Label ID="lblSTT" runat="server"/>
					</ItemTemplate>
                    <ItemStyle HorizontalAlign = "Center"/>
				</telerik:GridTemplateColumn>
                <custom:FilteringGroupNguonKP HeaderText="Nguồn kinh phí" HeaderStyle-Width ="200px" SortExpression="NGUONKINHPHI" UniqueName="NGUONKINHPHI" FilterControlWidth="100%" DataField="NGUONKINHPHI" AllowFiltering="false">
                    <ItemTemplate>
                        <%# Eval("NGUONKINHPHI") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <span>
                            <telerik:RadComboBox ID="cmbFK_NGUONKINHPHI" SelectedValue='<%# Bind("FK_NGUONKINHPHI") %>' runat="server" EmptyMessage="Chọn" DataSourceID="NGUONKINHPHIDataSource" DataTextField="C_NAME" DataValueField="PK_ID"></telerik:RadComboBox>
                        </span>
                    </EditItemTemplate>
                 </custom:FilteringGroupNguonKP>
                <telerik:GridTemplateColumn HeaderText="Mô tả" HeaderStyle-Width ="300px" SortExpression="MOTA" UniqueName="MOTA" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" AllowFiltering="false">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblMota" Text='<%# Eval("MOTA") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <span>
                            <telerik:RadTextBox runat="server" ID="txtMOTA" TextMode="MultiLine" Columns="1" Rows="4" Width="290px" Text='<%# Bind("MOTA") %>'></telerik:RadTextBox>                            
                        </span>
                    </EditItemTemplate>
                 </telerik:GridTemplateColumn>     
                <telerik:GridTemplateColumn HeaderText="Tổng tiền" SortExpression="TONGTIEN" UniqueName="TONGTIEN" AllowFiltering ="false">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblTONGTIEN" Text='<%# Eval("TONGTIEN", "{0:####.## VNĐ}") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <span>
                            <telerik:RadNumericTextBox runat="server" ID="tbTONGTIEN" Width="100px" DbValue='<%# Bind("TONGTIEN") %>' NumberFormat-DecimalDigits=0></telerik:RadNumericTextBox>
                            <span style="color: Red"><asp:RequiredFieldValidator ID="RequiredFieldValidatorTONGTIEN"
                                ControlToValidate="tbTONGTIEN" ErrorMessage="Tổng tiền ko thể rỗng" runat="server"></asp:RequiredFieldValidator>
                            </span>
                        </span>
                    </EditItemTemplate>
                 </telerik:GridTemplateColumn>     
        </Columns>
        </MasterTableView>
        <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G1"/>
        <ClientSettings>
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
            <ClientEvents OnPopUpShowing="PopUpShowingthu" />
            <ClientEvents OnRowDblClick="RowDblClickthu"/>
            <ClientEvents OnGridCreated="RadGridTHUCreated" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<asp:SqlDataSource ID="THUsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
        DeleteCommand="DELETE FROM DUTOANTHUCHI WHERE PK_ID = @PK_ID" 
        InsertCommand="INSERT INTO DUTOANTHUCHI (FK_NGUONKINHPHI,TONGTIEN,MOTA,FK_DONVI,NAM,LOAI) VALUES (@FK_NGUONKINHPHI,@TONGTIEN,@MOTA, @FK_DONVI,@NAM,1)"
        SelectCommand="SELECT DUTOANTHUCHI.PK_ID,DUTOANTHUCHI.FK_NGUONKINHPHI,DUTOANTHUCHI.TONGTIEN,DUTOANTHUCHI.MOTA,DUTOANTHUCHI.FK_DONVI,DUTOANTHUCHI.NAM,DMNGUONKINHPHI.C_NAME as NGUONKINHPHI FROM DUTOANTHUCHI LEFT OUTER JOIN DMNGUONKINHPHI ON DMNGUONKINHPHI.PK_ID = DUTOANTHUCHI.FK_NGUONKINHPHI WHERE NAM =@NAM AND LOAI=1 AND FK_DONVI=@FK_DONVI"
        UpdateCommand="UPDATE DUTOANTHUCHI SET FK_NGUONKINHPHI=@FK_NGUONKINHPHI,TONGTIEN=@TONGTIEN,MOTA = @MOTA WHERE PK_ID = @PK_ID">
        <UpdateParameters>
            <asp:Parameter Name="FK_NGUONKINHPHI" Type="Int32" />
            <asp:Parameter Name="TONGTIEN" Type="String" />
            <asp:Parameter Name="MOTA" Type="String" />
        </UpdateParameters>
        <SelectParameters>
             <asp:QueryStringParameter Name="FK_DONVI" Type="Int32" QueryStringField="dtID" />
             <asp:ControlParameter Name="NAM" Type="Int32" ControlID="cmbYear" DefaultValue="0"/>
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="PK_ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>      
            <asp:Parameter Name="FK_NGUONKINHPHI" Type="Int32" />
            <asp:Parameter Name="TONGTIEN" Type="String" />
            <asp:Parameter Name="MOTA" Type="String" />
            <asp:QueryStringParameter Name="FK_DONVI" Type="Int32" QueryStringField="dtID" />
            <asp:ControlParameter Name="NAM" Type="Int32" ControlID="cmbYear" DefaultValue="0"/>
        </InsertParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="NGUONKINHPHIDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
   SelectCommand="SELECT DMNGUONKINHPHI.PK_ID,DMNGUONKINHPHI.C_NAME,DMNGUONKINHPHI.C_DESC FROM DMNGUONKINHPHI">
</asp:SqlDataSource>
