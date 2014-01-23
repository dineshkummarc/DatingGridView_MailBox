<%@ WebHandler Language="C#" Class="ShowHtml" %>
 
using System;
using System.Configuration;
using System.Web;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Xml;
using System.Text;
using Singleton;
using SqlHelper = Microsoft.ApplicationBlocks.Data;
 
public class ShowHtml : IHttpHandler
{


    public void ProcessRequest(HttpContext context)
    {
        TextWriter zout = null; 
        context.Response.ContentType = "image/jpeg";
        if (context.Request.QueryString[0] != null)
        {
            if (!string.IsNullOrEmpty(context.Request.QueryString[0].ToString()))
            {
                string sImageId = context.Request.QueryString["InboxImage"].ToString();
                context.Server.HtmlDecode(sImageId);

            }
        }

      
    }

    public static  System.Drawing.Image LoadImageFromFile(string fileName)
    {
        System.Drawing.Image theImage = null;
        using (FileStream fileStream = new FileStream(fileName, FileMode.Open, FileAccess.Read))
        {
            byte[] img;
            img = new byte[fileStream.Length];
            fileStream.Read(img, 0, img.Length);
            fileStream.Close();
            theImage = System.Drawing.Image.FromStream(new MemoryStream(img));
            img = null;
        }
        GC.Collect();
        return theImage;
    }
    
    private static byte[] GetImageByteArr(System.Drawing.Image img)
    {
        byte[] ImgByte;
        using (MemoryStream stream = new MemoryStream())
        {
            img.Save(stream, System.Drawing.Imaging.ImageFormat.Jpeg);
            ImgByte = stream.ToArray();
        }
        return ImgByte;
    }
    
    public Stream ShowInboxImage(int picid)
    {

        string conn = GetConnectionString("MatchElfConnectionString");
        SqlConnection connection = new SqlConnection(conn);
        string sql = "SELECT ImageData FROM [MatchElf].[dbo].[Images] WHERE ImageId = " + picid.ToString();
        object img = SqlHelper.SqlHelper.ExecuteScalar(connection, CommandType.Text, sql);

        try
        {
            return new MemoryStream((byte[])img);
        }
        catch
        {
            return null;
        }
        finally
        {
            connection.Close();
        }
    }
 
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    public string GetConnectionString(string _connectionStringsName)
    {
        System.Configuration.ConnectionStringSettingsCollection config = System.Configuration.ConfigurationManager.ConnectionStrings;
        for (int i = 0; i < config.Count; i++)
        {
            if (config[i].Name.Equals(_connectionStringsName, StringComparison.OrdinalIgnoreCase))
                return config[i].ToString();
        }
        return String.Empty;
    }
 
}
