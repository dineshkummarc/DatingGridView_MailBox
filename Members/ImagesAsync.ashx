<%@ WebHandler Language="C#" Class="ImagesAsync" %>

using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Drawing;

/// <summary>
/// Asynchronous WebHandler for BLOB images. leon.segal@gmail.com
/// </summary>
public class ImagesAsync : IHttpAsyncHandler
{
    public ImagesAsync()
    {
    }

    #region IHttpAsyncHandler Members

    /// <summary>
    /// Called to initialize an asynchronous call to the HTTP handler. 
    /// </summary>
    /// <param name="context">An HttpContext that provides references to intrinsic server objects used to service HTTP requests.</param>
    /// <param name="cb">The AsyncCallback to call when the asynchronous method call is complete.</param>
    /// <param name="extraData">Any state data needed to process the request.</param>
    /// <returns>An IAsyncResult that contains information about the status of the process.</returns>
    public IAsyncResult BeginProcessRequest(HttpContext context, AsyncCallback cb, object extraData)
    {
        try
        {
            string ImageId = context.Request.QueryString[0].ToString();

            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["AsynMatchElf"].ConnectionString);
            conn.Open();
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = "SELECT TOP 1 ImageData, ContentType FROM Images WHERE (LEN(ContentType) > 1) " +
                    " AND (ImageId = " + ImageId + ") ORDER BY PrimaryImage DESC";
            
           
            // store our Command to be later retrieved by EndProcessRequest
            context.Items.Add("cmd", cmd);

            // start async DB read
            return cmd.BeginExecuteReader(cb, context,
                CommandBehavior.SequentialAccess |  // doesn't load whole column into memory
                CommandBehavior.SingleRow |         // performance improve since we only want one row
                CommandBehavior.CloseConnection);   // close connection immediately after read
        }
        catch (Exception exc)
        {
            // will return an image with the error text
            //this.renderError(context, "ERROR: " + exc.Message);
            this.renderError(context, "");
            context.Response.StatusCode = 500;
            context.Response.End();
            // just to avoid compilation errors
            throw;
        }
        return null;
    }

    /// <summary>
    /// Provides an end method for an asynchronous process. 
    /// </summary>
    /// <param name="result">An IAsyncResult that contains information about the status of the process.</param>
    public void EndProcessRequest(IAsyncResult result)
    {
        HttpContext context = (HttpContext)result.AsyncState;

        try
        {
            // restore used Command
            SqlCommand cmd = (SqlCommand)context.Items["cmd"];
            // retrieve result
            using (SqlDataReader reader = cmd.EndExecuteReader(result))
            {
                this.renderImage(context, reader);
            }
        }
        catch (Exception exc)
        {
            // will return an image with the error text
            //this.renderError(context, "ERROR: " + exc.Message);
            this.renderError(context, "");
            context.Response.StatusCode = 500;
        }
    }

    #endregion

    #region IHttpHandler Members

    public bool IsReusable
    {
        get { return true; }
    }

    public void ProcessRequest(HttpContext context)
    {
        // should never get called
        throw new Exception("The method or operation is not implemented.");
    }

    #endregion

    /// <summary>
    /// Render a BLOB field to the Response stream as JPEG
    /// </summary>
    /// <param name="context">HttpContext of current request</param>
    /// <param name="myReader">open SqlDataReader to read BLOB from</param>
    private void renderImage(HttpContext context, SqlDataReader myReader)
    {
        // Size of the BLOB buffer.
        const int bufferSize = 1024;
        long startIndex = 0;
        byte[] outbyte = new byte[bufferSize];
        long retval;

        myReader.Read();

        context.Response.Clear();
        context.Response.ContentType = "image/jpeg";

        do
        {
            //context.Response.ContentType = myReader.GetString(1);
            retval = myReader.GetBytes(0, startIndex, outbyte, 0, bufferSize);
            // reposition the start index
            startIndex += bufferSize;
            // output buffer
            context.Response.BinaryWrite(outbyte);
            context.Response.Flush();
        } while (retval == bufferSize);
    }

    /// <summary>
    /// Renders an Error image
    /// </summary>
    /// <param name="context">HttpContext of current request</param>
    /// <param name="msg">message text to render</param>
    private void renderError(HttpContext context, string msg)
    {
        //context.Response.Clear();
        //context.Response.ContentType = "image/jpeg";
        //// calculate the image width by message length
        ////Bitmap bitmap = new Bitmap(7 * msg.Length, 30);
        //Bitmap bitmap = new Bitmap(64, 64);
        //Graphics g = Graphics.FromImage(bitmap);
        //// create a background filler
        //g.FillRectangle(new SolidBrush(Color.DarkRed), 0, 0, bitmap.Width, bitmap.Height);
        //// draw our message
        //g.DrawString(msg, new Font("Tahoma", 10, FontStyle.Bold), new SolidBrush(Color.White), new PointF(5, 5));
        //// stream it to the output
        //bitmap.Save(context.Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg);
    }

}