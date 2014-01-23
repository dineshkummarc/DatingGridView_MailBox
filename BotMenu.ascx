<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BotMenu.ascx.cs" Inherits="BotMenu" %>
<link href="images/style.css" rel="stylesheet" type="text/css" />
<div class="nav-top" align="center" style="width: 932px">     
    <span style="color: rgb(255,255,255); font-size: 11px; font-family: verdana;">
        <a class="homefooter" href="Default.aspx" target="_self">Home</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a class="homefooter" href="Default.aspx" target="_new">about 
    us</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a class="homefooter" href="Default.aspx" target="_new">our tv 
    show</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a class="homefooter" href="Default.aspx" target="_new">faq/help</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a class="homefooter" href="Default.aspx" target="_new">become an affiliate</a>
&nbsp;|&nbsp;&nbsp;<a class="homefooter" href="Default.aspx" target="_new">local listings</a>&nbsp;&nbsp;|&nbsp;&nbsp;</span><asp:LinkButton ID="BTN_SignOut" runat="server" CssClass="homefooter" 
                    Font-Names="Arial" Font-Size="9pt" ForeColor="White" 
                    onclick="BTN_SignOut_Click">sign out</asp:LinkButton>
</div>
