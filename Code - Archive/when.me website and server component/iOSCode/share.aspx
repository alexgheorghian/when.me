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
         
         'get a uniqueCode
         dim uniqueCode As String
         uniqueCode=GetUniqueCode()
         planDate=Convert.ToDateTime(planDate).ToString("yyyy-MM-dd HH:mm:ss")
         strSQL="Insert into plan (userID,planText,createDate,planDigit,planTimeFrame,planDate,latitude,longitude,active,uniqueID)" & _ 
         " values (" & userID & ",'" & planText & "',now(),'" & planDigitPicked & "','" & planTimeFramePicked &"', '" & planDate & "', " & planLatitude & ", " & planLongitude & ",1,'" & uniqueCode & "')"
         Dim objCommand As New OdbcCommand(strSQL, objConnection)
         objCommand.ExecuteNonQuery()
         strSQL="SELECT LAST_INSERT_ID() as LastInsertID from plan;"
         objDataReader = New OdbcCommand(strSQL, objConnection).ExecuteReader()
         objDataReader.Read()
         
         response.write("success_" & objDataReader("LastInsertID") & "_" & uniqueCode)
     
         objConnection.Close()  
          
        End If





    
         
    End Sub
    
 Private Function GetUniqueCode() As String

        Dim allChars As String = "abcdefghijklmnopqrstuvwxyz1234567890" 

        Dim GotUniqueCode As Boolean = False
        Dim uniqueCode As String = ""

        While Not GotUniqueCode

            Dim str As New System.Text.StringBuilder

            For i As Byte = 1 To 6 'length of req key
                Dim xx As Integer
                Randomize()
                xx = Rnd() * (Len(allChars) - 1) 'number of rawchars
                str.Append(allChars.Trim.Chars(xx))
            Next

            uniqueCode = str.ToString

            GotUniqueCode = IsUniqueCode(uniqueCode)

        End While

        Return uniqueCode

   End Function
   
Private Function IsUniqueCode(uniqueCode) As Boolean
   dim strSQL As String  = "Select planID" & _
                              " from plan" & _
                              " where uniqueID = '" & uniqueCode & "'"
   

        Dim objConnection As New OdbcConnection(System.Configuration.ConfigurationManager.AppSettings("ConnString").ToString)
        objConnection.Open()
        Dim objDataReader As OdbcDataReader
        objDataReader = New OdbcCommand(strSQL, objConnection).ExecuteReader()
        objDataReader.Read()
    
    
        If Not objDataReader.HasRows Then 'user doesn't exist
           
          return 1
          
                objConnection.Close()              

        Else 
          return 0
                objConnection.Close() 
         End If
          
End Function
</script>