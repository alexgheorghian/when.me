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
   
dim userID As String=request("userID")
dim password As String=request("password")
dim tokens As String = request("tokens")

dim secretKey As String=request("secretKey")

if (secretKey<>"387213549")
 response.write ("Sorry, you are not authorized to do that.")
 response.end
end if 

dim strSQL As String

       'verify user
        Dim objConnection As New OdbcConnection(System.Configuration.ConfigurationManager.AppSettings("ConnString").ToString)
       
   
        strSQL  = "Select userID,email,password" & _
                              " from user" & _
                              " where password = '" & password & "' and userID=" & userID
   

     
        objConnection.Open()
        Dim objDataReader As OdbcDataReader
        objDataReader = New OdbcCommand(strSQL, objConnection).ExecuteReader()
        objDataReader.Read()
    
    
        If Not objDataReader.HasRows Then 'user doesn't exist
           
          response.write ("Password not correct. Please try again. ")
          
                objConnection.Close()              
               
       
        Else 
         
         'update the tokens
         strSQL="update user set tokens=" & tokens &" where userID='" & userID & "'"
         Dim objCommand As New OdbcCommand(strSQL, objConnection)
         objCommand.ExecuteNonQuery()
         
         response.write("success")
     
         objConnection.Close()  
          
        End If





    
         
    End Sub

   

</script>