<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Security" %>
<%@ Import Namespace="System.Data.Odbc" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="System.Web.UI.HtmlControls" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Drawing"%>
<%@ Import Namespace="System.Drawing.Imaging"%>
<%@ Import Namespace="System.Drawing.Text" %>
<%@ Import Namespace="System.Drawing.Drawing2D" %>


<script runat="server"> 
    
 Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

 Dim pathToCreate As String
   
pathToCreate = "../userPhotos/testDir"
Response.write(Server.MapPath(pathToCreate))
'Response.end


if(Directory.Exists(Server.MapPath(pathToCreate)))

else
Directory.CreateDirectory( Server.MapPath(pathToCreate) )
end if

End Sub
</script> 