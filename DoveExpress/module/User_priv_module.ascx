<%@ Control Language="C#" AutoEventWireup="true" CodeFile="User_Priv_Module.ascx.cs" Inherits="Admin_Modules_User_priv" %>
<%@ Register namespace="ITCLIB.Security" tagprefix="Security" %>
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
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
</script>
</telerik:RadCodeBlock>
<telerik:RadGrid ID="RadGridUserPrivModule" runat="server" PageSize ="100"
    DataSourceID="UserPrivModuleDataSource" Skin="Vista" AllowPaging="True" 
    AutoGenerateColumns="False" 
    onitemcommand="RadGridUserPrivModule_ItemCommand" 
    ondatabound="RadGridUserPrivModule_DataBound">
<MasterTableView CommandItemDisplay ="Top"  DataSourceID="UserPrivModuleDataSource" DataKeyNames ="FK_MODULE" ClientDataKeyNames ="FK_MODULE">
<CommandItemTemplate>
<div style="padding: 5px 5px;float:left;width:auto">
 Phân quyền đối với nhóm :<b> <asp:Label ID="lblGroupUserName" runat="server" onprerender="lblGroupUserName_PreRender" ></asp:Label></b>&nbsp;&nbsp;&nbsp;
    <asp:LinkButton ID="lbtSave" runat="server" CommandName ="UpdatePriv"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Update.gif" />Lưu</asp:LinkButton>&nbsp;&nbsp;|&nbsp;&nbsp;
    <asp:LinkButton ID="lbtReset" runat="server" CommandName="RebindGrid"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Refresh.gif" />Làm mới</asp:LinkButton>&nbsp;&nbsp;|&nbsp;&nbsp;
    <asp:LinkButton ID="lbtClose" runat="server" OnClientClick ="CancelEdit()"><img style="border:0px;vertical-align:middle;" alt="" src="Images/Grid/Cancel.gif" />Đóng</asp:LinkButton>
</div> 
</CommandItemTemplate>
<Columns>
<telerik:GridBoundColumn DataField ="C_NAME" UniqueName ="C_NAME" HeaderText ="Module" SortExpression ="C_NAME" >
</telerik:GridBoundColumn>
<telerik:GridTemplateColumn HeaderText ="Xem">
<ItemStyle HorizontalAlign ="Center" Width ="50px" />
<HeaderStyle HorizontalAlign ="Center" Width ="50px"/>
<ItemTemplate>
            <asp:CheckBox ID="chkView" name="chkView" class="checkbox" Checked = <%# Security.ConvertPermissionToView((int)Eval("C_LEVELPERMISSION"),1) %> runat="server" />
</ItemTemplate>
</telerik:GridTemplateColumn>
<telerik:GridTemplateColumn HeaderText ="Thêm">
<ItemStyle HorizontalAlign ="Center" Width ="50px" />
<HeaderStyle HorizontalAlign ="Center" Width ="50px"/>
<ItemTemplate>
 <asp:CheckBox ID="chkAdd" name="chkAdd" class="checkbox" Checked = <%# Security.ConvertPermissionToView((int)Eval("C_LEVELPERMISSION"),2) %> runat="server" /> 
</ItemTemplate>
</telerik:GridTemplateColumn>
<telerik:GridTemplateColumn HeaderText ="Sửa">
<ItemStyle HorizontalAlign ="Center" Width ="50px" />
<HeaderStyle HorizontalAlign ="Center" Width ="50px"/>
<ItemTemplate>
              <asp:CheckBox ID="chkEdit" name="chkEdit" class="checkbox" Checked = <%# Security.ConvertPermissionToView((int)Eval("C_LEVELPERMISSION"),3) %> runat="server" />
</ItemTemplate>
</telerik:GridTemplateColumn>
<telerik:GridTemplateColumn HeaderText ="Xóa">
<ItemStyle HorizontalAlign ="Center" Width ="50px" />
<HeaderStyle HorizontalAlign ="Center" Width ="50px"/>
<ItemTemplate>
              <asp:CheckBox ID="chkDelete" name="chkDelete" class="checkbox" Checked = <%# Security.ConvertPermissionToView((int)Eval("C_LEVELPERMISSION"),4) %> runat="server" />
</ItemTemplate>
</telerik:GridTemplateColumn>
<telerik:GridTemplateColumn HeaderText ="In">
<ItemStyle HorizontalAlign ="Center" Width ="50px" />
<HeaderStyle HorizontalAlign ="Center" Width ="50px"/>
<ItemTemplate>
              <asp:CheckBox ID="chkPrint" name="chkPrint" class="checkbox" Checked = <%# Security.ConvertPermissionToView((int)Eval("C_LEVELPERMISSION"),5) %> runat="server" />
</ItemTemplate>
</telerik:GridTemplateColumn>
<telerik:GridTemplateColumn Visible ="false">
<ItemTemplate>
        <asp:HiddenField ID="hfModule" runat="server" Value ='<%#Eval("FK_MODULE") %>' />
</ItemTemplate>
</telerik:GridTemplateColumn>
<telerik:GridBoundColumn DataField="FK_MODULE" UniqueName ="FK_MODULE" Visible ="false" ></telerik:GridBoundColumn>
</Columns>
<AlternatingItemStyle BackColor ="#E6EFFB" />
</MasterTableView>
<HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default"></HeaderContextMenu>
</telerik:RadGrid>
<asp:SqlDataSource ID="UserPrivModuleDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
   SelectCommand="SELECT MODULE.C_NAME,GROUPUSER_MODULE.FK_MODULE,GROUPUSER_MODULE.C_LEVELPERMISSION FROM GROUPUSER_MODULE INNER JOIN MODULE ON GROUPUSER_MODULE.FK_MODULE = MODULE.PK_ID INNER JOIN GROUPUSER ON GROUPUSER_MODULE.FK_GROUPUSER = GROUPUSER.PK_ID WHERE GROUPUSER_MODULE.FK_GROUPUSER=@FK_GROUPUSER">
    <SelectParameters>
        <asp:QueryStringParameter DefaultValue="0" Name="FK_GROUPUSER" QueryStringField="guID" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>