<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {
        // Code that runs on application startup

    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }


    /// <summary>
    /// Fires on every request from the browser
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Application_AuthenticateRequest(object sender, EventArgs e)
    {
        // look if any security information exists for this request
        if (HttpContext.Current.User != null)
        {
            // see if this user is authenticated, any authenticated cookie (ticket) exists for this user
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                // see if the authentication is done using FormsAuthentication
                if (HttpContext.Current.User.Identity is FormsIdentity)
                {
                    // Get the roles stored for this request from the ticket
                    // get the identity of the user
                    FormsIdentity identity = (FormsIdentity)HttpContext.Current.User.Identity;
                    // get the forms authetication ticket of the user
                    FormsAuthenticationTicket ticket = identity.Ticket;
                    // get the roles stored as UserData into the ticket 
                    string[] roles = ticket.UserData.Split(',');
                    // create generic principal and assign it to the current request
                    HttpContext.Current.User = new System.Security.Principal.GenericPrincipal(identity, roles);                    
                }
            }
        }
    }
    
    
</script>
