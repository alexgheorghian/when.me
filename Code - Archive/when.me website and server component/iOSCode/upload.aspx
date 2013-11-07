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
   Dim userID As String
   Dim secretKey As String
   Dim pathToCreate As String
   
   userID=request("userID")
   secretKey=request("secretKey")
   if secretKey<>"387213549" then
    response.write("You are not allowed to do that")
    response.end
   end if
   
   Dim objConnection As New OdbcConnection(System.Configuration.ConfigurationManager.AppSettings("ConnString").ToString)
       
     
 
        dim MD5password As String
        dim strSQL as String
        MD5password=request("password")
        
        strSQL  = "Select userID" & _
                              " from user" & _
                              " where userID= '" & userID & "' and password= '" & MD5password & "'"
   
        objConnection.Open()
        Dim objDataReader As OdbcDataReader
        objDataReader = New OdbcCommand(strSQL, objConnection).ExecuteReader()
        objDataReader.Read()
    
    
        If Not objDataReader.HasRows Then 'user doesn't exist
           
          response.write ("You are not authorized to do that ")
          
                objConnection.Close()              
  
        Else 
   
pathToCreate = "../userPhotos/" & userID
if(Directory.Exists(Server.MapPath(pathToCreate)))

else
Directory.CreateDirectory(Server.MapPath(pathToCreate))
end if

Dim MyFilecollection As HttpFileCollection = Request.Files
MyFilecollection(0).SaveAs(Server.MapPath("../userPhotos/" & userID & "/" & MyFilecollection(0).FileName))
strSQL = "update user set profilePicture=1 where userID=" & userID
                   
Dim objCommand As New OdbcCommand(strSQL, objConnection)
                objCommand.ExecuteNonQuery()
                End if
  
    End Sub
</script> 
