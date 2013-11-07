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
dim planText As String=request("planText")
dim planDigitPicked As String=request("planDigitPicked")
dim planTimeFramePicked As String=request("planTimeFramePicked")
dim planDate As String=request("planDate")
dim planLatitude As String=request("planLatitude")
dim planLongitude As String= request("planLongitude")

dim secretKey As String=request("secretKey")

if (secretKey<>"387213549")
 response.write ("Sorry, you are not authorized to do that.")
 response.end
end if 
planText=(replace(planText,"'","\'"))


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
         
         'mark requested plan as deleted
         dim uniqueID As String
         uniqueID=request("uniqueID")
         strSQL="update plan set active=0 where uniqueID='" & uniqueID & "'"
         Dim objCommand As New OdbcCommand(strSQL, objConnection)
         objCommand.ExecuteNonQuery()
         
         response.write("confirm_deleted")
     
         objConnection.Close()  
          
        End If





    
         
    End Sub

   

</script>