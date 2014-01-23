using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Security.Cryptography;
using System.Web.Security;
using System.Text.RegularExpressions;
using System.Collections.Specialized;
using System.Configuration;
using System.Text;

namespace Singleton
{
    /// <summary>
    /// Summary description for CPSingleton
    /// Dim oSingleton As singleton = singleton.GetCurrentSingleton()
    /// oSingleton.UserName = "Sysop"
    /// </summary>
    [Serializable]
    public class singleton
    {
        //Name that will be used as key for Session object
        private const string SESSION_SINGLETON = "SINGLETON";

        string sRoles = "";
        public string Roles
        {
            get { return sRoles; }
            set { sRoles = value; }
        }

        int _ProfileId = 0;
        public int ProfileId
        {
            get { return _ProfileId; }
            set { _ProfileId = value; }
        }

        int _FromProfileId = 0;
        public int FromProfileId
        {
            get { return _FromProfileId; }
            set { _FromProfileId = value; }
        }

        string _Username = string.Empty;
        public string Username
        {
            get { return _Username; }
            set { _Username = value; }
        }

        string _Password = string.Empty;
        public string Password
        {
            get { return _Password; }
            set { _Password = value; }
        }

        string _PasswordHash = string.Empty;
        public string PasswordHash
        {
            get { return _PasswordHash; }
            set { _PasswordHash = value; }
        }

        int _Locked = 1;
        public int Locked
        {
            get { return _Locked; }
            set { _Locked = value; }
        }

        int _Blocked = 0;
        public int Blocked
        {
            get { return _Blocked; }
            set { _Blocked = value; }
        }


        bool _RememberUsername = false;
        public bool RememberUsername
        {
            get { return _RememberUsername; }
            set { _RememberUsername = value; }
        }


        ArrayList MessagesIDList = new ArrayList();
        public ArrayList messagesIDList
        {
            get
            {
                return MessagesIDList;
            }
            set
            {
                MessagesIDList = value;
            }
        }

        
        // Private constructor so cannot create an instance
        // without using correct method which is critical to 
        // implementing this as a singleton object which cannot 
        // be created from outside this class
        private singleton()
        {
        }

        //Create as a static method so this can be called using
        // just the class name (no object instance is required).
        // It simplifies other code because it will always return
        // the single instance of this class, either newly created
        // or from the session
        public static singleton GetCurrentSingleton()
        {
            singleton oSingleton;

            if (null == System.Web.HttpContext.Current.Session[SESSION_SINGLETON])
            {
                //No current session object exists, use private constructor to 
                // create an instance, place it into the session
                oSingleton = new singleton();
                System.Web.HttpContext.Current.Session[SESSION_SINGLETON] = oSingleton;
            }
            else
            {
                //Retrieve the already instance that was already created
                oSingleton = (singleton)System.Web.HttpContext.Current.Session[SESSION_SINGLETON];
            }

            //Return the single instance of this class that was stored in the session
            return oSingleton;
        }

        public static void Dispose()
        {
            //Cleanup this object so that GC can reclaim space
            System.Web.HttpContext.Current.Session.Remove(SESSION_SINGLETON);
        }

    }
}


