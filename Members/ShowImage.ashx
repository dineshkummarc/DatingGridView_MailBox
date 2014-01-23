<%@ WebHandler Language="C#" Class="GetImages" %>
 
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
 
public class GetImages : IHttpHandler
{
    
    
    public void ProcessRequest(HttpContext context)
    {
        Int32 picid = 0;
        context.Response.ContentType = "image/jpeg";
        if (context.Request.QueryString["InboxImage"] != null)
        {
            if (!string.IsNullOrEmpty(context.Request.QueryString["InboxImage"].ToString()))
            {
                string sImageId = context.Request.QueryString["InboxImage"].ToString();
                if (!string.IsNullOrEmpty(sImageId))
                {
                    picid = Convert.ToInt32(sImageId);
                }
            }

            SqlDataReader dr = null;

            if (picid > 0)
            {
                try
                {
                    string strConn = GetConnectionString("DatingConnectionString");
                    string sql = "SELECT TOP 1 ImageData, ContentType FROM Images WHERE (LEN(ContentType) > 1) "+
                    " AND (ProfileId = " + picid.ToString() + ") ORDER BY PrimaryImage DESC;";
                    
                    
                    dr = SqlHelper.SqlHelper.ExecuteReader(strConn, CommandType.Text, sql);
                    if ((dr != null) && (dr.HasRows))
                    {
                        while (dr.Read())
                        {
                            if (dr["ContentType"] != DBNull.Value)
                            {
                                context.Response.ContentType = dr["ContentType"].ToString();
                                //object img = (object[])dr["ImageData"];
                                Stream strm = new MemoryStream((byte[])dr["ImageData"]);
                                byte[] buffer = new byte[4096];
                                int byteSeq = strm.Read(buffer, 0, 4096);
                                while (byteSeq > 0)
                                {
                                    context.Response.OutputStream.Write(buffer, 0, byteSeq);
                                    byteSeq = strm.Read(buffer, 0, 4096);
                                }
                                buffer = null;
                            }
                            GC.Collect();
                        }
                    }
                    else
                        picid = 0;
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    picid = 0;
                }
            }           
        }

        if (picid < 1)
        {
            string fileName = string.Empty;
            fileName = context.Server.MapPath(@"Images\nopic.jpg");
            using (FileStream fileStream = new FileStream(fileName, FileMode.Open, FileAccess.Read))
            {
                byte[] img;
                img = new byte[fileStream.Length];
                fileStream.Read(img, 0, img.Length);
                fileStream.Close();
                //theImage = Image.FromStream(new MemoryStream(img));
                Stream strm = new MemoryStream(img);
                byte[] buffer = new byte[8192];
                int byteSeq = strm.Read(buffer, 0, 8192);
                while (byteSeq > 0)
                {
                    context.Response.OutputStream.Write(buffer, 0, byteSeq);
                    byteSeq = strm.Read(buffer, 0, 8192);
                }
                img = null;
            }
            GC.Collect();           
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
