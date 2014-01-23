<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TopMenu.ascx.cs" Inherits="Members_TopMenu" %>
<link href="images/style.css" rel="stylesheet" type="text/css" />
<div class="nav-top" align="center" style="width: 932px">     
<asp:HyperLink ID="HyperLink9" runat="server" CssClass="showblack" 
    NavigateUrl="~/Default.aspx">Mail</asp:HyperLink>
&nbsp;&nbsp;|&nbsp;&nbsp;<asp:HyperLink ID="HyperLink19" runat="server" CssClass="showblack" 
    NavigateUrl="~/Default.aspx">My Images</asp:HyperLink>    
&nbsp;&nbsp;|&nbsp;&nbsp;<asp:HyperLink ID="HyperLink17" runat="server" CssClass="showblack" 
    NavigateUrl="~/Default.aspx?fpid=0">View Profile</asp:HyperLink>
&nbsp;&nbsp;|&nbsp;&nbsp;<asp:HyperLink ID="HyperLink18" runat="server" CssClass="showblack" 
    NavigateUrl="~/Default.aspx">Edit Profile</asp:HyperLink>
&nbsp;&nbsp;|&nbsp;&nbsp;<asp:HyperLink ID="HyperLink20" runat="server" CssClass="showblack" 
    NavigateUrl="~/Default.aspx">My Settings</asp:HyperLink>
&nbsp;&nbsp;|&nbsp;&nbsp;<asp:LinkButton ID="LinkButton2" runat="server" 
        CssClass="showblack" onclick="LinkButton2_Click">Log Out</asp:LinkButton>
&nbsp;<br />
<asp:HyperLink ID="HyperLink21" runat="server" CssClass="showblack" 
NavigateUrl="~/Default.aspx">Search</asp:HyperLink>
&nbsp;|&nbsp;&nbsp;<asp:HyperLink ID="HyperLink22" runat="server" CssClass="showblack" 
NavigateUrl="~/Default.aspx">Online</asp:HyperLink>
&nbsp;&nbsp;|&nbsp;&nbsp;<asp:HyperLink ID="HyperLink23" runat="server" CssClass="showblack" 
NavigateUrl="~/Default.aspx">Forums</asp:HyperLink>
&nbsp;&nbsp;|&nbsp;&nbsp;<asp:HyperLink ID="HyperLink24" runat="server" CssClass="showblack" 
NavigateUrl="~/Default.aspx"><nobr>Local Events</nobr></asp:HyperLink>
&nbsp;&nbsp;|&nbsp;&nbsp;<asp:HyperLink ID="HyperLink25" runat="server" CssClass="showblack" 
NavigateUrl="~/Default.aspx" Target="_blank">Help</asp:HyperLink>
&nbsp;&nbsp;|&nbsp;&nbsp;<asp:HyperLink ID="HyperLink26" runat="server" CssClass="showblack" 
NavigateUrl="~/Default.aspx" Target="_blank"><nobr>Contact Us</nobr></asp:HyperLink>&nbsp;  
</div>
