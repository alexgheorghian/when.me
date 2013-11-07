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
dim uniqueID As String=request("uniqueID")
dim addFriend As String=request("addFriend")

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
         
        strSQL="Select ID from planJoins where userID=" & userID & " and uniqueID='" & uniqueID & "'"
         
        objDataReader = New OdbcCommand(strSQL, objConnection).ExecuteReader()
        objDataReader.Read()
    
        strSQL="Insert into planJoins (userID,uniqueID,joinDate)" & _ 
         " values (" & userID & ",'" & uniqueID & "',now())"
       
        Dim objCommand As New OdbcCommand(strSQL, objConnection)
        If Not objDataReader.HasRows Then ' join doesn't exist
 

         
         
         objCommand.ExecuteNonQuery()
         
         strSQL="update plan set joins=joins+1 where uniqueID='" & uniqueID & "'"
         objCommand = New OdbcCommand(strSQL, objConnection)
         objCommand.ExecuteNonQuery()
        
        End if 
         
         If (addFriend.Equals("1")) Then 
           
           strSQL="select userID from plan where uniqueID='" & uniqueID &"'"
            objDataReader = New OdbcCommand(strSQL, objConnection).ExecuteReader()
            objDataReader.Read()
             If objDataReader.HasRows Then
               Dim planUserID As string=objDataReader("userID")
               strSQL="select ID from friends where followerID=" & userID & " and followingID=" & planUserID
               objDataReader = New OdbcCommand(strSQL, objConnection).ExecuteReader()
               objDataReader.Read()
               If Not objDataReader.HasRows Then
                strSQL="insert into friends (followerID,followingID,status,createdDate)" & _
                " values (" & userID & "," & planUserID & ",1,now())"
                objCommand = New OdbcCommand(strSQL, objConnection)
                objCommand.ExecuteNonQuery()
                
               End If
               
             End If  
           
         End If
                 
         response.write("success")
     
         objConnection.Close()  
          
        End If
  
    End Sub

</script>