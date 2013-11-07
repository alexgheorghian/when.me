<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.Odbc" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="System.Web.UI.HtmlControls" %>


<script runat="server"> 
    
 Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
   
dim followerID As String=request("followerID")
dim followingID As String=request("followingID")
dim followType As String=request("followtype")
dim secretKey As String=request("secretKey")
dim password As String=request("password")

if (secretKey<>"387213549")
 response.write ("followFailure")
 response.end
end if 

dim strSQL As String

       'verify user
        Dim objConnection As New OdbcConnection(System.Configuration.ConfigurationManager.AppSettings("ConnString").ToString)
       
   
        strSQL  = "Select userID,email,password" & _
                              " from user" & _
                              " where password = '" & password & "' and userID=" & followerID
   

     
        objConnection.Open()
        Dim objDataReader As OdbcDataReader
        objDataReader = New OdbcCommand(strSQL, objConnection).ExecuteReader()
        objDataReader.Read()
    
    
        If Not objDataReader.HasRows Then 'user doesn't exist
           
          response.write ("followFailure")
          objConnection.Close()              
       
        Else ' create or delete relationship
        'response.write ("create or delete relationship<br>")
            If (followType.Equals("1")) Then 
             'response.write ("create relationship<br>")
               strSQL="select ID from friends where followerID=" & followerID & " and followingID=" & followingID
               objDataReader = New OdbcCommand(strSQL, objConnection).ExecuteReader()
               objDataReader.Read()
               If Not objDataReader.HasRows Then 'create new relationship
                strSQL="insert into friends (followerID,followingID,status,createdDate)" & _
                " values (" & followerID & "," & followingID & ",1,now())"
                'response.write (strSQL & "<br>")
                Dim objCommand As New OdbcCommand(strSQL, objConnection)
  
                objCommand.ExecuteNonQuery()
               End If
               
         Else If (followType.Equals("0")) Then 'delete relationship
         strSQL="delete from friends where followingID=" & followingID & " and followerID= " & followerID
           Dim objCommand As New OdbcCommand(strSQL, objConnection)
    
         objCommand.ExecuteNonQuery()
          
         End If  
        
           response.write("followSuccess")
        
        End if 
         
                 
      
     
        objConnection.Close()  
          

  
    End Sub

</script>