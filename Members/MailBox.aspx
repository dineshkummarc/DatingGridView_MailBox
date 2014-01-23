<%@ Page Language="C#" Debug="true" masterpagefile="~/Members/MembersSM.master" AutoEventWireup="true" CodeFile="MailBox.aspx.cs" Inherits="Members_MailBox" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<div class="blank-center" align="center"> 
            <br />
<table align="center" cellpadding="0" class="nav-top1" style="width: 932px">
            <tr>
                <td class="blank">
                    </td>
            </tr>
            <tr>
                <td align="center" class="blank-center">
                    <div ID="ad728_90Forums" class="blank"> 
                        <img src="images/728x90.gif" />
                    </div>
                </td>
            </tr>
        </table>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br />
            <div class="blank" align="center"> 
            <table align="center" cellpadding="0" cellspacing="0" class="style3">
                <tr>
                    <td valign="top">
                        <img alt="" src="images/spacer.gif" style="width: 65px; height: 1px" /></td>
                    <td valign="top">
                        <img alt="" src="images/spacer.gif" style="width: 510px; height: 1px" /></td>
                    <td valign="top">
                        <img alt="" src="images/spacer.gif" style="width: 10px; height: 1px" /></td>
                    <td valign="top">
                        <img alt="" src="images/spacer.gif" style="width: 250px; height: 1px" /></td>
                    <td valign="top">
                        <img alt="" src="images/spacer.gif" style="width: 65px; height: 1px" /></td>
                </tr>
                <tr>
                    <td class="blank">
                        </td>
                    <td align="right" valign="top" class="blank">
                        <asp:Label ID="LABEL_Messages" runat="server" CssClass="blank" Font-Bold="True" 
                            Font-Names="Arial" Font-Size="24pt" Text="Your Messages"></asp:Label>
                    </td>
                    <td align="center" valign="top" class="blank">
                        &nbsp;</td>
                    <td align="center" class="blank" valign="top">
                    </td>
                    <td class="blank">
                        </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
                    <td align="left" valign="top">
                        &nbsp;</td>
                    <td align="center" valign="top">
                        &nbsp;</td>
                    <td align="center" valign="top">
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
                    <td align="left" valign="top">
                    
                    <asp:UpdatePanel ID="updatePanel1" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>  
                        <table align="left" cellpadding="0" cellspacing="0" style="width:530px;" class="blank">
                            <tr>
                                <td>
                                    <asp:Label ID="LABEL_NoMessages" runat="server" CssClass="blank" 
                                        Font-Names="Arial" Font-Size="18pt"></asp:Label>
                                    &nbsp;&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:GridView ID="gvInbox" runat="server" AllowPaging="True" 
                                        AutoGenerateColumns="False" BorderStyle="Solid" BorderWidth="1px" 
                                        CellPadding="4" DataKeyNames="messageid" Font-Names="Arial" Font-Size="10pt" 
                                        ForeColor="Black" GridLines="None" Height="64px" 
                                        onpageindexchanging="gvInbox_PageIndexChanging" 
                                        onrowdatabound="gvInbox_RowDataBound" PageSize="5" Width="510px">
                                        <FooterStyle BackColor="#009933" Font-Bold="True" ForeColor="White" />
                                        <RowStyle BackColor="#ccff99" BorderStyle="None" BorderWidth="0px" />
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Image ID="Image2" runat="server" Height="64" 
                                                        ImageUrl="~/Members/images/nopic.jpg" 
                                                        src='<%#"ShowImage.ashx?InboxImage="+Eval("FromProfileId") %>' Width="64" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <div style="z-index: 10; font-family: Arial, Helvetica, sans-serif; width: 399px; height: 64px; text-align: left;">
                                                        <asp:HyperLink ID="HyperLink1" runat="server" CssClass="showgreen" 
                                                            NavigateUrl='<%#"~/Members/Profile.aspx?fpid="+Eval("FromProfileId")+"&msgid="+Eval("MessageId") %>'><%# Eval("FromUsername") %></asp:HyperLink>
                                                        <br />
                                                        <asp:HyperLink ID="HyperLink2" runat="server" 
                                                            NavigateUrl='<%#"~/Members/ShowMessage.aspx?fpid="+Eval("FromProfileId")+"&msgid="+Eval("MessageId") %>'><span 
                                                            style="font-weight: lighter;font-family: Arial, Helvetica, sans-serif; font-size: small;"><%# Eval("Subject")%></span></asp:HyperLink>
                                                        <br />
                                                        <div style="text-align: right; z-index: 22; position: relative; vertical-align: top; top: -27px; left: 241px; width: 152px; height: 43px;">
                                                            <asp:Label ID="Label1" runat="server" CssClass="showdate1" Font-Names="Arial" 
                                                                Font-Size="8pt" Text='<%# Eval("zdate") %>'></asp:Label>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                                <HeaderTemplate>
                                                    <asp:Button ID="btnDeleteSelected" runat="server" Font-Names="Arial" 
                                                        Font-Size="8pt" onclick="btnDeleteSelected_Click" 
                                                        onclientclick="showConfirm(this); return false;" Text="delete selected" 
                                                        Width="90px" />
                                                </HeaderTemplate>
                                                <HeaderStyle ForeColor="White" HorizontalAlign="Right" VerticalAlign="Middle" />
                                            </asp:TemplateField>
                                            <asp:TemplateField ControlStyle-Width="50px" HeaderStyle-Width="60px" 
                                                ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btnDelete" runat="server" BorderStyle="None" Height="16px" 
                                                        ImageAlign="AbsBottom" ImageUrl="~/images/delete.small.png" 
                                                        OnClick="BtnDelete_Click" OnClientClick="showConfirm(this); return false;" 
                                                        Text="Delete" Width="16px" />
                                                    <br />
                                                </ItemTemplate>
                                                <ControlStyle Height="16px" Width="16px" />
                                                <HeaderStyle Width="16px" />
                                                <ItemStyle Height="16px" HorizontalAlign="Center" VerticalAlign="Top" 
                                                    Width="16px" Wrap="False" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <AlternatingItemTemplate>
                                                    <asp:CheckBox ID="cb1" runat="server" />
                                                </AlternatingItemTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="cb1" runat="server" oncheckedchanged="cb1_CheckedChanged" />
                                                </ItemTemplate>
                                                <HeaderTemplate>
                                                    <asp:CheckBox ID="cbSelectAll" runat="server" CausesValidation="True" Text="" 
                                                        oncheckedchanged="cbSelectAll_CheckedChanged" />
                                                </HeaderTemplate>
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                                        <EmptyDataTemplate>
                                            No Messages
                                        </EmptyDataTemplate>
                                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                        <HeaderStyle BackColor="#009933" BorderColor="Black" BorderStyle="Solid" 
                                            BorderWidth="1px" Font-Bold="True" ForeColor="White" />
                                        <EditRowStyle BackColor="#2461BF" />
                                        <AlternatingRowStyle BackColor="White" />
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server" 
                                        BackgroundCssClass="modalBackground" BehaviorID="mdlPopup" 
                                        CancelControlID="btnNo" DropShadow="True" OkControlID="btnOk" 
                                        OnCancelScript="cancelClick();" OnOkScript="okClick();" 
                                        PopupControlID="divDeleteItem" TargetControlID="divDeleteItem" />
                                </td>
                            </tr>
                            <tr>
                                <td class="style3">
                                    </td>
                            </tr>
                        </table>
                        <div id="divDeleteItem" runat="server" align="center" class="confirm" style="display:none">
                            <table align="center" class="confirmtable">
                                <tr>
                                <td><img align="middle" src="images/warning.jpg" /></td>
                                <td>Are you sure you want to delete selected item(s)?&nbsp;</td>
                                <td><asp:Button ID="btnOk" runat="server" Text="Yes" class="confirmbutton" /></td>
                                <td><asp:Button ID="btnNo" runat="server" Text="No" class="confirmbutton" /></td>
                                </tr>
                            </table>      
                        </div> 
                        </ContentTemplate>
                    </asp:UpdatePanel>     
                        <br />
                        <br />
                        &nbsp;<br />
                    </td>
                    <td valign="top">
                        &nbsp;</td>
                    <td valign="top">                        
                    <br />
                        <br />
                        <div ID="ad250_250MailBox" class="blank" 
                            style="border-style: solid; border-width: 1px; border-color: inherit; width: 252px; height: 252px; text-align:center; text-align: center; z-index: 0;">
                            <img src="images/250x250.gif" />
                        </div>
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
            </table>
            </div> 
 
</div>  
</asp:Content>

<asp:Content ID="Content2" runat="server" contentplaceholderid="head">
    <script type="text/javascript">
        //  keeps track of the delete button for the row  that is going to be removed
        var _source;
        // keep track of the popup div
        var _popup;
        
        function showConfirm(source){
            this._source = source;
            this._popup = $find('mdlPopup');
            //  find the confirm ModalPopup and show it    
            this._popup.show();
        }
        
        function okClick(){
            //  find the confirm ModalPopup and hide it    
            this._popup.hide();
            //  use the cached button as the postback source
            __doPostBack(this._source.name, '');
        }
        
        function cancelClick(){
            //  find the confirm ModalPopup and hide it 
            this._popup.hide();
            //  clear the event source
            this._source = null;
            this._popup = null;
        }
    </script>
    <style>
        .modalBackground {
            background-color:Gray;
            filter:alpha(opacity=70);
            opacity:0.7;
        }
        .confirm{
           background-color:White;
           border-style:solid; 
           border-color: Red;
           padding:10px;
           width:400px;
           font-family:Arial;
           font-size: 11px;
        }
        .confirmtable{
           background-color:White;
           border-style:none; 
           border-color: Silver;
           padding:0px;
           width:400px;
           font-family:Arial;
           font-size: 11px;
        }
        .confirmbutton{
           font-family:Arial;
           font-size: 11px;
        }
        .style3
        {
            height: 19px;
            width: 931px;
        }
    </style>
<script type="text/javascript">
    function SelectAll(id) {
        var frm = document.forms[0];
        for (i=0;i<frm.elements.length;i++) {
            if (frm.elements[i].type == "checkbox") {
                frm.elements[i].checked = document.getElementById(id).checked;
            }
        }
    }  
</script>

</asp:Content>



