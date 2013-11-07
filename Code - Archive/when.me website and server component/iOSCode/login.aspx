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
   
dim username As String=Request("username")
dim password As String=Request("password")
dim secretKey As String=Request("secretKey")

if (secretKey<>"387213549")
 response.write ("Sorry, you are not authorized to do that. Key:" & secretKey)
 response.end
end if 
username=lcase(replace(username,"'","\'"))


dim strSQL As String

       'find or create a user
       Dim objConnection As New OdbcConnection(System.Configuration.ConfigurationManager.AppSettings("ConnString").ToString)
       
     
    
        dim userID As String
        dim email As String
        dim MD5password As String
        dim profilePicture As String
        strSQL  = "Select userID,email,password,profilePicture" & _
                              " from user" & _
                              " where username= '" & username & "'"
   
        objConnection.Open()
        Dim objDataReader As OdbcDataReader
        objDataReader = New OdbcCommand(strSQL, objConnection).ExecuteReader()
        objDataReader.Read()
    
    
        If Not objDataReader.HasRows Then 'user doesn't exist
           
          response.write ("Username does not exist. Please try again. ")
          
                objConnection.Close()              
               
               
    
                 
               
        Else 
          userID = objDataReader("userID")
          email = objDataReader("email")
          MD5password = objDataReader("password")
          profilePicture = objDataReader("profilePicture")
          If MD5Encryption.Verify(password, MD5password) Then
           response.write("success_" & userID & "_" & MD5password & "_" & email & "_" & profilePicture)
          Else
           response.write("Password incorrect. Please try again.") 
          End If 
          objConnection.Close()  
          
        End If





    
         
    End Sub
</script> 