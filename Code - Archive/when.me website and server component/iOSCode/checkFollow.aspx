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
dim secretKey As String=request("secretKey")

if (secretKey<>"387213549")
 response.write ("isfollowing_0")
 response.end
end if 

dim strSQL As String

       'verify user
        Dim objConnection As New OdbcConnection(System.Configuration.ConfigurationManager.AppSettings("ConnString").ToString)
       
   
        strSQL  = "Select ID" & _
                              " from friends" & _
                              " where followerID = '" & followerID & "' and followingID=" & followingID
   

     
        objConnection.Open()
        Dim objDataReader As OdbcDataReader
        objDataReader = New OdbcCommand(strSQL, objConnection).ExecuteReader()
        objDataReader.Read()
    
    
        If Not objDataReader.HasRows Then 'user doesn't exist
           
          response.write ("isfollowing_0")

       
        Else 
           response.write ("isfollowing_1")    
        End if 
             
        objConnection.Close()  
          
    End Sub

</script>
