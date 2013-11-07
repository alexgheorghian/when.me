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

dim username As String=request("username")
dim email As String=request("email")
dim password As String=request("password")
dim secretKey As String=request("secretKey")

if (secretKey<>"387213549")
 response.write ("Sorry, you are not authorized to do that.")
 response.end
end if 

if (email="" or password="" or username="")
  
  response.write ("Sorry, you are not authorized to do that.")
 response.end
end if 

username=lcase(replace(username,"'","\'"))
email=lcase(replace(email,"'","\'"))
password=replace(password,"'","\'")

dim strSQL As String

       'find or create a user
        Dim objConnection As New OdbcConnection(System.Configuration.ConfigurationManager.AppSettings("ConnString").ToString)
       
     
    
        dim userID As String
        strSQL  = "Select userID" & _
                              " from user" & _
                              " where email = '" & email & "' or username= '" & username & "'"
   
        objConnection.Open()
        Dim objDataReader As OdbcDataReader
        objDataReader = New OdbcCommand(strSQL, objConnection).ExecuteReader()
        objDataReader.Read()
        'response.write ("here")
        'response.end
    
        If Not objDataReader.HasRows Then 'insert a new user
           
          Dim myMD5password As String
          myMD5password=MD5Encryption.Encrypt(password)
        
  
          strSQL = "Insert into user (email,username,password,lastActivity,createdDateTime) " & _
                   "Values ('" & email &"','" & username &"','" & myMD5password &"',now(),now())"
                   
                Dim objCommand As New OdbcCommand(strSQL, objConnection)
                objCommand.ExecuteNonQuery()
                
                
                
                
                strSQL="SELECT userID FROM user where email='" & email & "'"
                objDataReader = New OdbcCommand(strSQL, objConnection).ExecuteReader()
                objDataReader.Read()
                userID = objDataReader("userID")
                
               strSQL="insert into friends (followerID,followingID,status,createdDate)" & _
                " values (" & userID & ",111,1,now())"
                   
                objCommand = New OdbcCommand(strSQL, objConnection)
                objCommand.ExecuteNonQuery()
                
                response.write("success_" & userID & "_" &myMD5password )
                objConnection.Close() 
    
                 
               
        Else
        objConnection.Close()  
         response.write ("That username or email address already exists. Please try again or tap 'Login' ")
        End If





    
         
    End Sub
</script>  
