<%@ page language="C#" masterpagefile="~/Site.master" autoeventwireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>
   


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div style="margin: 8px; background: rgb(255, 255, 255) none repeat scroll 0%; position: relative; width: 919px; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial; top: 4px; left: 0px; height: 369px;">

		<table border="0" cellpadding="0" cellspacing="0" 
            style="width: 909px; height: 363px;">
		<tbody>
		<tr>
		<td align="left" valign="top" width="605">
        <div align="center" 
            
                style="padding: 4px; height: 308px; font-family: Arial, Helvetica, sans-serif; font-size: small; width: 899px;">
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            Simply click the button below to login
            <br />
            into the site and read your messages<br />
            <br />
            <asp:ImageButton ID="BTN_Login" runat="server" 
                ImageUrl="~/images/BtnLogin.gif" onclick="BTN_Login_Click" />
            <br /></div>
        </td>
		</tr>
		</tbody></table>
		
	</div>
	
</asp:Content>

