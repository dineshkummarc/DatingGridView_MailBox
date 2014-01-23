using System;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using Singleton;


public partial class _Default : System.Web.UI.Page
{
    protected override void OnInit(EventArgs e)
    {
        InitializeComponent();
        base.OnInit(e);
    }

    private void InitializeComponent()
    {
        this.Load += new System.EventHandler(this.Page_Load);

    }

    private void Page_Load(object sender, System.EventArgs e)
    {

        try
        {
            if (!IsPostBack)
            {
                //ddStates1.SelectedIndex = 4;
                // disable page caching
                //Response.Expires = 0;
                //Response.Cache.SetNoStore();
                //Response.AppendHeader("Pragma", "no-cache");

                //ExpirePageCache();
            }
        }
        catch (Exception ex)
        {
            //Me.lblError.Text = ex.Message 
        }

    }

    /// <summary>
    /// This function prevent the page being retrieved from broswer cache
    /// </summary>
    private void ExpirePageCache()
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetExpires(DateTime.Now - new TimeSpan(1, 0, 0));
        Response.Cache.SetLastModified(DateTime.Now);
        Response.Cache.SetAllowResponseInBrowserHistory(false);
    }


    protected void BTN_Login_Click(object sender, ImageClickEventArgs e)
    {
        singleton oSingleton = singleton.GetCurrentSingleton();
        oSingleton.ProfileId = 1;
        oSingleton.Username = "johndoe";
        oSingleton.Locked = 0;
        oSingleton.Blocked = 0;
        oSingleton.Roles = "Members";
        oSingleton.RememberUsername = true;

        FormsAuthentication.SignOut();
        FormsAuthenticationTicket ticket = null; 
        ticket = new FormsAuthenticationTicket(1, oSingleton.Username, DateTime.Now,
                    DateTime.Now.AddMinutes(50), oSingleton.RememberUsername, oSingleton.Roles, 
                    FormsAuthentication.FormsCookiePath); 
        string hashCookies = FormsAuthentication.Encrypt(ticket);
        HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, hashCookies); // Hashed ticket
        Response.Cookies.Add(cookie);
        Response.Redirect("~/Members/MailBox.aspx?tabID=0");

    }



}


