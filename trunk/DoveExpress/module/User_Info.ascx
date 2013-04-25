<%@ Control Language="C#" AutoEventWireup="true" CodeFile="User_Info.ascx.cs" Inherits="Admin_Modules_User_Info" %>
<asp:DetailsView id="dvUser_Info" runat="server" BorderColor ="White" CssClass ="classDetaiview"  
    DataSourceID="User_InfoDataSource" DataKeyNames="PK_ID" 
     Width="100%" AutoGenerateRows="False" BackColor="White" BorderWidth="0px"
     DefaultMode="Edit" HeaderText="Thay đổi thông tin" 
    OnItemUpdated="dvUser_Info_ItemUpdated">
        <Fields>
        <asp:TemplateField ShowHeader ="false" ControlStyle-CssClass ="classDetaiview"> 
        <EditItemTemplate >
        <table class ="TableEditInGrid">
        <tr>
        <td style =" width:150px; padding-left :15px;">Họ và tên"</td>
        <td><asp:TextBox ID="txtName" Text='<%# Bind("C_NAME") %>' runat="server" Width="200px"></asp:TextBox>  
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Họ và Tên không thể rỗng" ControlToValidate="txtName" SetFocusOnError="True" ValidationGroup="User_InfoG1" Display="Dynamic">*</asp:RequiredFieldValidator>
        </td>
        </tr>
        <tr>
        <td style =" width:150px; padding-left :15px;">Email:</td><td> <asp:TextBox ID="txtEmail" Text='<%# Bind("C_EMAIL") %>' Width="200px" runat="server"></asp:TextBox> 
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Email không thể rỗng" ControlToValidate="txtEmail" SetFocusOnError="True" ValidationGroup="User_InfoG1" Display="Dynamic">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ErrorMessage="Email sai định dạng" ControlToValidate="txtEmail" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"  ValidationGroup="User_InfoG1" Display="Dynamic">*</asp:RegularExpressionValidator>
                    <asp:CustomValidator ID="cvEmail" ControlToValidate="txtEmail" OnServerValidate="CheckEmail" runat="server" ErrorMessage="Email đã tồn tại"  ValidationGroup="User_InfoG1" Display="Dynamic"></asp:CustomValidator>
                    <asp:ValidationSummary ID="vsUser_Info" ShowSummary="false" HeaderText="Vui lòng kiểm tra lại :" runat="server" ShowMessageBox="True"  ValidationGroup="User_InfoG1" />   
        </td>
        </tr>
        <tr>
        <td style =" width:150px; padding-left :15px;">Điện thoại</td>
        <td> <asp:TextBox ID="txtTel" Text='<%# Bind("C_TEL") %>' Width="200px" runat="server"></asp:TextBox> </td>
        </tr>
        <tr>
        <td style =" width:150px; padding-left :15px;">Địa chỉ</td>
        <td><asp:TextBox ID="txtAddress" BorderWidth ="1" BorderColor="#cccccc" Text='<%# Bind("C_ADDRESS") %>' TextMode ="MultiLine" Columns="30" Rows="2" Width="90%" runat="server"></asp:TextBox> 
        </td>
        </tr>
        <tr>
        <td style =" width:150px; padding-left :15px;">Thông tin tóm tắt</td>
        <td> <telerik:RadTextBox ID="txtDesc" Text='<%# Bind( "C_DESC") %>' TextMode="MultiLine" runat="server" Columns="30" Rows="5" Width="90%"></telerik:RadTextBox>
        </td>
        </tr>
        </table>
        <div class="headerthongtin">
              <ul>
                <li class="lifirst"><asp:LinkButton ID="btnSave" runat="server" ValidationGroup ="User_InfoG1" CommandName="Update"><img src="Images/img_save.jpg" />Lưu</asp:LinkButton></li>
               </ul>
            </div>  
        </EditItemTemplate>
        <ItemTemplate>
         <table class ="TableEditInGrid">
        <tr>
        <td style =" width:150px; padding-left :15px;">Họ và tên"</td>
        <td><asp:TextBox ID="txtName" Enabled ="false"  Text='<%# Bind("C_NAME") %>' runat="server" Width="200px"></asp:TextBox>  
        </td>
        </tr>
        <tr>
        <td style =" width:150px; padding-left :15px;">Email:</td><td>
         <asp:TextBox ID="txtEmail" Enabled ="false"  Text='<%# Bind("C_EMAIL") %>' Width="200px" runat="server"></asp:TextBox> 
        </td>
        </tr>
        <tr>
        <td style =" width:150px; padding-left :15px;">Điện thoại</td>
        <td> <asp:TextBox Enabled ="false"  ID="txtTel" Text='<%# Bind("C_TEL") %>' Width="200px" runat="server"></asp:TextBox> </td>
        </tr>
        <tr>
        <td style =" width:150px; padding-left :15px;">Địa chỉ</td>
        <td><asp:TextBox Enabled ="false"  ID="txtAddress" BorderWidth ="1" BorderColor="#cccccc" Text='<%# Bind("C_ADDRESS") %>' TextMode ="MultiLine" Columns="30" Rows="2" Width="90%" runat="server"></asp:TextBox> 
        </td>
        </tr>
        <tr>
        <td style =" width:150px; padding-left :15px;">Thông tin tóm tắt</td>
        <td> <telerik:RadTextBox Enabled ="false"  ID="txtDesc" Text='<%# Bind( "C_DESC") %>' TextMode="MultiLine" runat="server" Columns="30" Rows="5" Width="90%"></telerik:RadTextBox>
        </td>
        </tr>
        </table>
        <div class="headerthongtin"></div>  
        </ItemTemplate>
        </asp:TemplateField>
        </Fields>
         <HeaderStyle CssClass ="headerDetaiView"/>
         <HeaderTemplate>
          <asp:Image ID="Image1" BorderWidth ="0" AlternateText="" runat="server" Width ="25px" Height ="25px" ImageUrl="~/images/img_changeInfo.png" />
         <b>Thay đổi thông tin</b>
         </HeaderTemplate>
</asp:DetailsView>   
  
<asp:SqlDataSource ID="User_InfoDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CNCREPORTConnectionString %>"
    UpdateCommand="UPDATE [USERS] SET C_NAME=@C_NAME,C_EMAIL=@C_EMAIL,C_ADDRESS=@C_ADDRESS,C_TEL =@C_TEL,C_DESC=@C_DESC WHERE PK_ID=@PK_ID"
     SelectCommand="SELECT PK_ID,C_NAME,C_EMAIL,C_ADDRESS,C_TEL,C_DESC FROM [USERS] WHERE PK_ID=@PK_ID">
    <SelectParameters>
        <asp:SessionParameter Name="PK_ID"  SessionField="UserID" Type="int32" />
    </SelectParameters>
   <UpdateParameters>
         <asp:Parameter Name="PK_ID" Type="int32" />
         <asp:Parameter Name="C_NAME"/>
         <asp:Parameter Name="C_EMAIL"/>
         <asp:Parameter Name="C_ADDRESS"/>
         <asp:Parameter Name="C_TEL"/>
   </UpdateParameters> 
</asp:SqlDataSource>
