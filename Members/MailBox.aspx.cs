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

using System.Security.Cryptography;
using System.Xml;
using System.Text;
using System.IO;

using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using System.Data.Sql;
using Singleton;

public partial class Members_MailBox : System.Web.UI.Page
{
    singleton oSingleton;
    string message = string.Empty;
    DataSet ds = null;
    private static string mstrConn = String.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (! HttpContext.Current.User.IsInRole("Members"))
            Response.Redirect("~/Default.aspx");

        try
        {
            if (!IsPostBack)
            {
                System.Threading.Thread.CurrentThread.CurrentCulture = System.Globalization.CultureInfo.InvariantCulture;
                mstrConn = GetConnectionString("DatingConnectionString");
                
                singleton oSingleton = singleton.GetCurrentSingleton();
                oSingleton.messagesIDList.Clear();

                SaveCheckedValues();
                PopulateMailbox("","");
                LoadSavedCheckValues(); 

            }
        }
        catch (Exception ex)
        {
            //Me.lblError.Text = ex.Message 
        }


    }

    public static string GetConnectionString(string _connectionStringsName)
    {
        System.Configuration.ConnectionStringSettingsCollection config = System.Configuration.ConfigurationManager.ConnectionStrings;
        for (int i = 0; i < config.Count; i++)
        {
            if (config[i].Name.Equals(_connectionStringsName, StringComparison.OrdinalIgnoreCase))
                return config[i].ToString();
        }
        return String.Empty;
    }

    private void PopulateMailbox(string SortExpression, string DeleteString)
    {
        oSingleton = singleton.GetCurrentSingleton();

        if ((oSingleton.ProfileId < 1) || (oSingleton.Username.Length < 2))
            return;

        try
        {
            ds = SqlHelper.ExecuteDataset(mstrConn, "usp_GetMessages", oSingleton.ProfileId, oSingleton.Username, DeleteString);

            if ((ds != null) && (ds.Tables[0] != null) && (ds.Tables[0].Rows.Count > 0))
            {
                LABEL_NoMessages.Text = string.Empty;
                gvInbox.AllowPaging = true;
                gvInbox.PageSize = 2;
                //gvInbox.PagerStyle.Mode = PagerMode.NumericPages;
                // Add filter for inbox, drafts, etc.
                //gvInbox.DataSource.DefaultView.RowFilter = String.Concat("Station = \'", sStation, "\'");
                gvInbox.DataSource = ds.Tables[0].DefaultView;
                gvInbox.Visible = true;
                gvInbox.DataBind();
            }
            else
            {
                gvInbox.Visible = false;
                LABEL_NoMessages.Text = "No Messages";
            }

            return;
        }
        catch (SqlException e)
        {
            //str1 = e.Message;
            //throw e;
        }
    }

    protected void gvInbox_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        SaveCheckedValues();
        gvInbox.PageIndex = e.NewPageIndex;
        PopulateMailbox("", "");
        LoadSavedCheckValues(); 
    }


    protected void gvInbox_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            //Add attribute for onclick event on check box in header passing MessageId of Select All checkbox 
            ((CheckBox)e.Row.FindControl("cbSelectAll")).Attributes.Add("onclick", "javascript:SelectAll('" + ((CheckBox)e.Row.FindControl("cbSelectAll")).ClientID + "')");
        }

        //Other ways to do the same thing:
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
        //    LinkButton l = (LinkButton)e.Row.FindControl("LinkButton1");
        //    l.Attributes.Add("onclick", "javascript:return " +
        //         "confirm('Are you sure you want to delete this message? " +
        //         DataBinder.Eval(e.Row.DataItem, "MessageId") + "')");
        //}
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
        //    ImageButton iBtn = (ImageButton)e.Row.FindControl("IBTN_Delete");
        //    iBtn.OnClientClick = "if (ConfirmDelete()) {__doPostBack('" + gvInbox.UniqueID + "','Delete$" + e.Row.RowIndex.ToString() + "')} else { return false;};";
        //}  
    }

    private void LoadSavedCheckValues()
    {
        singleton oSingleton = singleton.GetCurrentSingleton();
        if (oSingleton.messagesIDList != null && oSingleton.messagesIDList.Count > 0)
        {
            foreach (GridViewRow row in gvInbox.Rows)
            {
                int index = (int)gvInbox.DataKeys[row.RowIndex].Value;
                if (oSingleton.messagesIDList.Contains(index))
                {
                    CheckBox myCheckBox = (CheckBox)row.FindControl("cb1");
                    myCheckBox.Checked = true;
                }
            }
        }
    }

    private void SaveCheckedValues()
    {
        singleton oSingleton = singleton.GetCurrentSingleton();
        int index = -1;
        foreach (GridViewRow row in gvInbox.Rows)
        {
            index = (int)gvInbox.DataKeys[row.RowIndex].Value;
            bool result = ((CheckBox)row.FindControl("cb1")).Checked;

            if (result)
            {
                if (!oSingleton.messagesIDList.Contains(index))
                    oSingleton.messagesIDList.Add(index);
            }
            else
                oSingleton.messagesIDList.Remove(index);
        }
    }



    protected void btnDeleteSelected_Click(object sender, EventArgs e)
    {
        SaveCheckedValues();
        singleton oSingleton = singleton.GetCurrentSingleton();
        string sDelete = string.Empty;
        if (oSingleton.messagesIDList != null && oSingleton.messagesIDList.Count > 0)
        {
            for (int i = 0; i < oSingleton.messagesIDList.Count; i++ )
            {
                if (sDelete.Length < 1)
                    sDelete = oSingleton.messagesIDList[i].ToString();
                else
                    sDelete = sDelete + "," + oSingleton.messagesIDList[i].ToString();
            }
        }

        if (sDelete.Length < 1)
            return;

        SaveCheckedValues();
        PopulateMailbox("", sDelete);
        LoadSavedCheckValues(); 
    }

    protected void cb1_CheckedChanged(object sender, EventArgs e)
    {
        SaveCheckedValues();
    }
    
    protected void cbSelectAll_CheckedChanged(object sender, EventArgs e)
    {
        SaveCheckedValues();
    }

    protected void BtnDelete_Click(object sender, ImageClickEventArgs e)
    {
        int index = -1;
        ImageButton btnDelete = sender as ImageButton;
        GridViewRow row = (GridViewRow)btnDelete.NamingContainer;
        index = (int)gvInbox.DataKeys[row.RowIndex].Value;
        SaveCheckedValues();
        PopulateMailbox("", index.ToString());
        LoadSavedCheckValues();
    }

}



