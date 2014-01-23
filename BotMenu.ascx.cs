using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

public partial class BotMenu : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }




    /// <summary>
    ///After some research I ran into following Microsoft article: http://support.microsoft.com/kb/900111. 
    ///The article explains that FormsAuthentication.SignOut() method does not prevent cookie reply attack, 
    ///which essentially means that the cookie, even though it was destroyed, it was considered to be valid 
    ///and all calls to the application that utilized this particular cookie were considered authenticated. 
    /// </summary>
    public void LogOut()
    {
        /* Create new session ticket that expires immediately */
        FormsAuthenticationTicket ticket =
            new FormsAuthenticationTicket(
                1,
                this.Context.User.Identity.Name,
                DateTime.Now,
                DateTime.Now,
                false,
                Guid.NewGuid().ToString());

        /* Encrypt the ticket */
        string encrypted_ticket = FormsAuthentication.Encrypt(ticket);

        /* Create cookie */
        HttpCookie cookie = new HttpCookie(
            FormsAuthentication.FormsCookieName,
            encrypted_ticket);

        /* Add cookie */
        this.Context.Response.Cookies.Add(cookie);

        /* Abandon session object to destroy all session variables */
        this.Context.Session.Clear();
        this.Context.Session.Abandon();
    }

    protected void BTN_SignOut_Click(object sender, EventArgs e)
    {
        LogOut();
        Response.Redirect("~/Default.aspx");

    }


    protected void BTN_CloseAccount_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Members/CloseAccount.aspx");
    }
}
