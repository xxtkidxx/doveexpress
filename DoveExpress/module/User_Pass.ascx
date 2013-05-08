<%@ Control Language="C#" AutoEventWireup="true" CodeFile="User_Pass.ascx.cs" Inherits="Admin_Modules_User_Pass" %>
<asp:DetailsView id="dvUser_Pass" runat="server" DataSourceID="User_PassDataSource" 
      DataKeyNames="PK_ID" Width="100%" HorizontalAlign="Center" AutoGenerateRows="False" 
      DefaultMode="Edit" OnItemUpdating="dvUser_Pass_ItemUpdating"  CssClass ="classDetaiview"
      HeaderText="Thay đổi mật khẩu" OnItemUpdated="dvUser_Pass_ItemUpdated" 
    BackColor="White" BorderWidth="0px" >
     <Fields>
        <asp:TemplateField ShowHeader ="false"> 
        <EditItemTemplate >
        <table class ="TableEditInGrid">
        <tr>
        <td style =" width:150px; padding-left :15px;"> Mật khẩu cũ: </td>
        <td>
                 <asp:TextBox ID="txtPassword1" TextMode="Password" runat="server" Width="300"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="rfvPassword1" runat="server" ErrorMessage="Mật khẩu cũ không thể rỗng" ControlToValidate="txtPassword1" SetFocusOnError="True"  ValidationGroup="User_PassG1" Display="Dynamic">*</asp:RequiredFieldValidator>
                 <asp:CustomValidator ID="cvPassword1" ControlToValidate="txtPassword1"  OnServerValidate="CheckPassword" runat="server" ErrorMessage="Sai mật khẩu cũ" ValidationGroup="User_PassG1" Display="Dynamic"></asp:CustomValidator>
           
        </td>
        </tr>
        <tr>
        <td style =" width:150px; padding-left :15px;">Mật khẩu mới</td>
        <td>
         <asp:TextBox ID="txtPassword2" TextMode="Password" runat="server"  Width="300"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="rfvPassword2" runat="server" ErrorMessage="Mật khẩu mới không thể rỗng" ControlToValidate="txtPassword2" SetFocusOnError="True" ValidationGroup="User_PassG1" Display="Dynamic">*</asp:RequiredFieldValidator>
        </td>
        </tr>
         <tr>
        <td style =" width:150px; padding-left :15px;">Xác nhận mật khẩu mới</td>
        <td><asp:TextBox ID="txtPassword3" TextMode="Password" runat="server"  Width="300"></asp:TextBox>
                  <asp:CompareValidator ID="cvPassword3" runat="server" ErrorMessage="Xác nhận mật khẩu không trùng nhau" ControlToCompare="txtPassword2" ControlToValidate="txtPassword3" SetFocusOnError="True" ValidationGroup="User_PassG1" Display="Dynamic">*</asp:CompareValidator>
                  <asp:ValidationSummary ID="vsUser_Pass"  ShowSummary="false" HeaderText="Vui lòng kiểm tra lại :" runat="server" ShowMessageBox="True" ValidationGroup="User_PassG1" />   
        </td>
        </tr>
        </table>
        <div class="headerthongtin">
              <ul>
                <li class="lifirst"><asp:LinkButton ID="btnSave" runat="server" ValidationGroup ="User_PassG1" CommandName="Update"><img src="Images/img_save.jpg" />Lưu</asp:LinkButton></li>
               </ul>
            </div>  
        </EditItemTemplate>
        <ItemTemplate>
         <table class ="TableEditInGrid">
        <tr>
        <td style =" width:150px; padding-left :15px;"> Mật khẩu cũ: </td>
        <td>
                 <asp:TextBox Enabled ="false" ID="txtPassword1" Text ="1111111" TextMode="Password" runat="server" Width="300"></asp:TextBox>
        </td>
        </tr>
        <tr>
        <td style =" width:150px; padding-left :15px;">Mật khẩu mới</td>
        <td>
         <asp:TextBox ID="txtPassword2" Enabled ="false" TextMode="Password" runat="server"  Width="300"></asp:TextBox>
        </td>
        </tr>
         <tr>
        <td style =" width:150px; padding-left :15px;">Xác nhận mật khẩu mới</td>
        <td><asp:TextBox ID="txtPassword3" Enabled ="false"  TextMode="Password" runat="server"  Width="300"></asp:TextBox>
        </td>
        </tr>
        </table>
        <div class="headerthongtin"></div> 
        </ItemTemplate>
        </asp:TemplateField>
     </Fields>
      <HeaderStyle   CssClass ="headerDetaiView"/>
      <HeaderTemplate>
       <asp:Image ID="Image1" BorderWidth ="0" AlternateText="" runat="server" Width ="25px" Height ="25px" ImageUrl="~/images/img_changPass.png" />
      <b>Thay đổi mật khẩu</b>
      </HeaderTemplate>
</asp:DetailsView> 
   
   
<asp:SqlDataSource ID="User_PassDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DOVEEXPRESSConnectionString %>"
     UpdateCommand="UPDATE [USERS] SET C_PASSWORD =@C_PASSWORD WHERE PK_ID=@PK_ID"
     SelectCommand="SELECT [PK_ID] FROM [USERS] WHERE [PK_ID]=@PK_ID"
    >
    <SelectParameters>
         <asp:SessionParameter Name="PK_ID" SessionField="UserID" Type="int32" />
    </SelectParameters>
   <UpdateParameters>
         <asp:Parameter Name="PK_ID" Type="int32" />
         <asp:Parameter Name="C_PASSWORD"/>
   </UpdateParameters> 
</asp:SqlDataSource>
