<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CONFIG.ascx.cs" Inherits="module_CONFIG" %>
<telerik:RadCodeBlock ID="RadCodeBlockCONFIG" runat="server">
    <script type="text/javascript">
        function RowDblClick(sender, eventArgs) {
            sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
        }
    </script>
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelCONFIG" runat="server" />
<div style="width: 90%; margin: 10px 10px 10px 10px;">
    Vùng làm việc:&nbsp;
    <telerik:RadComboBox ID="cmbVungLamViec" DataTextField="C_NAME" DataValueField="C_CODE" AutoPostBack="true"
        DataSourceID="VUNGLAMVIECDataSource" ShowToggleImage="True" runat="server" EmptyMessage="Chọn vùng làm việc"
        OnPreRender="cmbVungLamViec_PreRender">
    </telerik:RadComboBox>
</div>
<telerik:RadGrid ID="RadGridCONFIG" runat="server" Skin="Vista"
    AllowPaging="True" PageSize="20" AllowSorting="True"
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="true"
    AutoGenerateColumns="False"
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True"
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True"
    DataSourceID="CONFIGDataSource" ShowFooter="True"
    OnDataBound="RadGridCONFIG_DataBound"
    OnItemUpdated="RadGridCONFIG_ItemUpdated"
    OnItemCommand="RadGridCONFIG_ItemCommand"
    OnItemDataBound="RadGridCONFIG_ItemDataBound">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp"
        PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>
    <GroupingSettings CaseSensitive="false" />
    <MasterTableView CommandItemDisplay="Top" DataSourceID="CONFIGDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="InPlace" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
            <div style="padding: 5px 5px; float: left; width: auto">
                <b>Quản lý thông tin cấu hình</b>&nbsp;&nbsp;&nbsp;&nbsp;                        
                        <asp:LinkButton ID="LinkButton4" runat="server" CommandName="RebindGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Refresh.gif" />Làm mới</asp:LinkButton>
            </div>
        </CommandItemTemplate>
        <Columns>
            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn" HeaderStyle-Width="80px" EditImageUrl="~/images/grid/Edit.gif"></telerik:GridEditCommandColumn>
            <telerik:GridTemplateColumn DataField="PK_ID" DataType="System.Decimal" UniqueName="C_CUOCPHI" Visible="false">
                <ItemTemplate>
                    <telerik:RadTextBox runat="server" ID="txtPK_ID" Width="100px" Enabled="false" Text='<%# Eval("PK_ID") %>'>
                    </telerik:RadTextBox>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadTextBox runat="server" ID="txtPK_ID" Text='<%# Bind("PK_ID") %>'>
                    </telerik:RadTextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn DataField="C_NAME" UniqueName="C_NAME" AllowFiltering="false" HeaderText="Tên cấu hình">
                <ItemTemplate>
                    <%# Eval("C_NAME") %>
                </ItemTemplate>
                <EditItemTemplate>
                    <%# Eval("C_NAME") %>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn DataField="C_VALUE" UniqueName="C_VALUE" AllowFiltering="false" HeaderText="Giá trị">
                <ItemTemplate>
                    <%# Eval("C_VALUE") %>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadTextBox runat="server" ID="txtC_VALUE" Width="100px" Text='<%# Bind("C_VALUE") %>'>
                    </telerik:RadTextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
        </Columns>
    </MasterTableView>
    <ClientSettings AllowKeyboardNavigation="true" KeyboardNavigationSettings-AllowSubmitOnEnter="true" ClientEvents-OnKeyPress="KeyPressed">
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
        <ClientEvents OnRowDblClick="RowDblClick" />
    </ClientSettings>
    <SortingSettings SortedAscToolTip="Sắp xếp tăng dần"
        SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
    <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<telerik:RadWindowManager ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" ID="RadWindowManager1"
    runat="server" VisibleStatusbar="False" Width="800px" Height="600px">
</telerik:RadWindowManager>
<asp:SqlDataSource ID="CONFIGDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT DMCAUHINH.PK_ID, DMCAUHINH.C_NAME, (SELECT DMCAUHINHVALUE.C_VALUE FROM DMCAUHINHVALUE WHERE DMCAUHINHVALUE.FK_VUNGLAMVIEC = @FK_VUNGLAMVIEC AND DMCAUHINH.C_VALUE = '1' AND DMCAUHINHVALUE.FK_CAUHINH= DMCAUHINH.PK_ID) as C_VALUE FROM DMCAUHINH"
    UpdateCommand="IF (NOT EXISTS(SELECT PK_ID FROM DMCAUHINHVALUE WHERE DMCAUHINHVALUE.FK_VUNGLAMVIEC = @FK_VUNGLAMVIEC AND DMCAUHINHVALUE.FK_CAUHINH = @PK_ID)) BEGIN INSERT INTO DMCAUHINHVALUE(FK_VUNGLAMVIEC, FK_CAUHINH, C_VAlUE) VALUES(@FK_VUNGLAMVIEC, @PK_ID, @C_VAlUE) END ELSE BEGIN UPDATE DMCAUHINHVALUE SET C_VAlUE = @C_VAlUE WHERE DMCAUHINHVALUE.FK_VUNGLAMVIEC = @FK_VUNGLAMVIEC AND DMCAUHINHVALUE.FK_CAUHINH = @PK_ID END">
    <UpdateParameters>
        <asp:ControlParameter ControlID="cmbVungLamViec" DefaultValue="Hà Nội" Name="FK_VUNGLAMVIEC"
            PropertyName="SelectedValue" />
        <asp:Parameter Name="PK_ID" Type="Int32" />
        <asp:Parameter Name="C_VAlUE" Type="String" />
    </UpdateParameters>
    <SelectParameters>
        <asp:ControlParameter ControlID="cmbVungLamViec" DefaultValue="Hà Nội" Name="FK_VUNGLAMVIEC"
            PropertyName="SelectedValue" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="VUNGLAMVIECDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
    SelectCommand="SELECT DMVUNGLAMVIEC.* FROM DMVUNGLAMVIEC"></asp:SqlDataSource>
