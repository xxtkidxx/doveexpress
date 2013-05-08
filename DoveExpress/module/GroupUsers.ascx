<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GroupUsers.ascx.cs" Inherits="company_GroupUsers" %>
<telerik:RadCodeBlock ID="RadCodeBlockGroupUser" runat="server">
  <script type="text/javascript">
      function OnClientLinkClicked(type, guIDvalue) {
          if (type == "1") {
              radopen("Popup.aspx?ctl=User_Priv_Module&guID=" + guIDvalue, "Phân quyền Modoule");

          }
          return false;
      }
</script> 
</telerik:RadCodeBlock>
<telerik:RadAjaxLoadingPanel Skin="Vista" ID="RadAjaxLoadingPanelGroupUser" runat="server" />
<telerik:RadGrid ID="RadGridGroupUser" runat="server" Skin="Vista" 
    AllowPaging="True" PageSize="20" AllowSorting="True" 
    AllowFilteringByColumn="True" GridLines="None" ShowStatusBar="true"
    AutoGenerateColumns="False"  
    AllowMultiRowEdit="True" AllowAutomaticDeletes="True" 
    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
    DataSourceID="GroupUsersDataSource" ShowFooter="True"
    ondatabound="RadGridGroupUser_DataBound" 
    onitemdeleted="RadGridGroupUser_ItemDeleted" oniteminserted="RadGridGroupUser_ItemInserted" 
    onitemupdated="RadGridGroupUser_ItemUpdated" 
    onitemcommand="RadGridGroupUser_ItemCommand" 
    onitemdatabound="RadGridGroupUser_ItemDataBound">
    <PagerStyle FirstPageToolTip="Trang đầu" LastPageToolTip="Trang cuối" NextPagesToolTip="Các trang tiếp" NextPageToolTip="Trang tiếp" 
    PageSizeLabelText="Số bản ghi hiển thị:" PrevPagesToolTip="Các trang sau" PrevPageToolTip="Trang sau" PagerTextFormat="Change page: {4} &nbsp;Trang <strong>{0}</strong>/<strong>{1}</strong>, Bản ghi <strong>{2}</strong> đến <strong>{3}</strong> của tất cả <strong>{5}</strong> bản ghi" />    
    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" Excel-Format="ExcelML"></ExportSettings>   
     <GroupingSettings CaseSensitive ="false"  />
    <MasterTableView CommandItemDisplay="Top" DataSourceID="GroupUsersDataSource" DataKeyNames="PK_ID" ClientDataKeyNames="PK_ID" EditMode="PopUp" NoMasterRecordsText="Không có dữ liệu">
        <CommandItemTemplate>
                    <div style="padding: 5px 5px;float:left;width:auto">
                        <b>Quản lý nhóm người dùng</b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditSelected" Visible='<%# RadGridGroupUser.EditIndexes.Count == 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Edit.gif" />Sửa</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# RadGridGroupUser.EditIndexes.Count > 0 %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Update.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGridGroupUser.EditIndexes.Count > 0 || RadGridGroupUser.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Hủy bỏ</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# !RadGridGroupUser.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/AddRecord.gif" />Thêm</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="PerformInsert" Visible='<%# RadGridGroupUser.MasterTableView.IsItemInserted %>'><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Insert.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:return confirm('Bạn có muốn xóa bản ghi đã chọn không?')" runat="server" CommandName="DeleteSelected"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Delete.gif" />Xóa</asp:LinkButton>&nbsp;&nbsp;
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
                <telerik:GridBoundColumn UniqueName="PK_ID" HeaderText="ID Nhóm" DataField="PK_ID"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                 <FilterTemplate >
                   <asp:Button ID="btnSearch" Text="Tìm" runat="server"/>
                   <asp:ImageButton ID="btnShowAll" runat="server" ImageUrl="../Images/Grid/filterCancel.gif" AlternateText="Xem tất" ToolTip="Xem tất" OnClick="btnShowAll_Click" Style="vertical-align: middle" />
                 </FilterTemplate>
                 <HeaderStyle HorizontalAlign ="Center" Width ="80px" />
                 <ItemStyle HorizontalAlign ="Center" Width ="80px" />
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_NAME" HeaderText="Tên nhóm" DataField="C_NAME"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="C_DESC" HeaderText="Mô tả nhóm" DataField="C_DESC"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn UniqueName="UserPrivModule" HeaderText="Phân quyền Module" DataField="PK_ID" AllowFiltering="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="libUserPrivModule" OnClientClick='<%# String.Format("javascript:return OnClientLinkClicked(1,{0})", Eval("PK_ID"))%>' runat="server">Phân quyền</asp:LinkButton>&nbsp;&nbsp;
                    </ItemTemplate>
                </telerik:GridTemplateColumn>        
        </Columns>
        <EditFormSettings InsertCaption="Thêm nhóm mới" CaptionFormatString="Sửa nhóm: <b>{0}</b>" CaptionDataField="C_NAME" EditFormType="Template" PopUpSettings-Width="300px">
        <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
           <FormTemplate>
              <table id="tblEdit" class ="TableEditInGrid" cellspacing="3" cellpadding="3" style="width: 100%" border="0">
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                ID Nhóm:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtID" Text='<%# Bind( "PK_ID") %>'  ReadOnly='<%# !(Container is GridEditFormInsertItem)%>' runat="server"></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="rfvID" runat="server" ErrorMessage="ID nhóm không thể rỗng" ControlToValidate="txtID" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvID" runat="server" ErrorMessage="ID nhóm phải là số nguyên dương" Operator="DataTypeCheck" Type="Integer" ControlToValidate="txtID" Display="Dynamic" ValidationGroup="G1"></asp:CompareValidator>
                                <asp:CustomValidator ID="cuvID" ControlToValidate="txtID" OnServerValidate="CheckID" runat="server" ErrorMessage="ID đã tồn tại" Display="Dynamic" ValidationGroup="G1"></asp:CustomValidator>

                            </td>
                        </tr>
                        <tr>
                            <td>
                                Tên nhóm:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtName" Text='<%# Bind( "C_NAME") %>' runat="server"></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Tên nhóm không thể rỗng" ControlToValidate="txtName" SetFocusOnError="True" Display="Dynamic" ValidationGroup="G1"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="cuvName" ControlToValidate="txtName" OnServerValidate="CheckName" runat="server" ErrorMessage="Tên nhóm đã tồn tại" Display="Dynamic" ValidationGroup="G1"></asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Mô tả nhóm:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtGroupUserDesc" TextMode="MultiLine" Rows ="2" Columns ="1" Width ="95%" Text='<%# Bind( "C_DESC") %>' runat="server"></telerik:RadTextBox>
                            </td>
                        </tr>                   
                    </table>
                    <table style="width: 100%">
                        <tr>
                            <td align="right" colspan="2">
                                <asp:Button ID="Button1" Text='<%# (Container is GridEditFormInsertItem) ? "Lưu" : "Lưu" %>'
                                    runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>' ValidationGroup="G1">
                                </asp:Button>&nbsp;
                                <asp:Button ID="Button2" Text="Hủy bỏ" runat="server" CausesValidation="False" CommandName="Cancel">
                                </asp:Button>
                            </td>
                        </tr>
                    </table>
             </FormTemplate>
        </EditFormSettings>
        </MasterTableView>
        <ValidationSettings CommandsToValidate="PerformInsert,Update" ValidationGroup="G1"/>
        <ClientSettings>
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
            <ClientEvents OnPopUpShowing="PopUpShowingSmall" />
            <ClientEvents OnRowDblClick="RowDblClick" />
        </ClientSettings>
        <SortingSettings SortedAscToolTip="Sắp xếp tăng dần" 
            SortedDescToolTip="Sắp xếp giảm dần" SortToolTip="Click để sắp xếp" />
        <StatusBarSettings LoadingText="Đang tải..." ReadyText="Sẵn sàng" />
</telerik:RadGrid>
<telerik:RadWindowManager ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" ID="RadWindowManager1" 
    runat="server" VisibleStatusbar="False" Width="800px" Height="600px">  
</telerik:RadWindowManager> 
<asp:SqlDataSource ID="GroupUsersDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
        DeleteCommand="DELETE FROM GROUPUSER WHERE PK_ID = @PK_ID" 
        InsertCommand="INSERT INTO GROUPUSER (PK_ID, C_NAME, C_DESC,C_TYPE) VALUES (@PK_ID, @C_NAME, @C_DESC,@C_TYPE)"
        SelectCommand="SELECT PK_ID, C_NAME, C_DESC,C_TYPE FROM GROUPUSER WHERE PK_ID > 0 order by PK_ID"
        UpdateCommand="UPDATE GROUPUSER SET C_NAME = @C_NAME, C_DESC = @C_DESC WHERE PK_ID = @PK_ID">
        <UpdateParameters>
            <asp:Parameter Name="C_NAME" Type="String" />
            <asp:Parameter Name="C_DESC" Type="String" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="PK_ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="PK_ID" Type="Int32" />
            <asp:Parameter Name="C_NAME" Type="String" />
            <asp:Parameter Name="C_DESC" Type="String" />
            <asp:Parameter Name="C_TYPE" Type="Int32" />
        </InsertParameters>
</asp:SqlDataSource>
