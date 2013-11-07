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
    
dim userLocation As String=request("userLocation")
dim birthday As String=request("birthday")
dim username As String=request("username")
dim locale As String=request("locale")
dim gender As String=request("gender")
dim lastName As String=request("lastName")
dim firstName As String=request("firstName")
dim email As String=request("email")

dim myLocation As String=request("myLocation")
dim myTime As String=request("myTime")
dim myDate As String=request("myDate")

userLocation=replace(userLocation,"'","\'")
birthday=replace(birthday,"'","\'")
username=replace(username,"'","\'")
locale=replace(locale,"'","\'")
gender=replace(gender,"'","\'")
lastName=replace(lastName,"'","\'")
firstName=replace(firstName,"'","\'")
email=replace(email,"'","\'")

myLocation=replace(myLocation,"'","\'")
myTime=replace(myTime,"'","\'")
myDate=replace(myDate,"'","\'")

dim strSQL As String

Dim myAMPM As String
Dim timeKeys() As String=myTime.Split(" ")
 myTime=timeKeys(0)
 myAMPM=timeKeys(1)
if (birthday<>"undefined") then
Dim arrKeys() As String = birthday.Split("/")
birthday=arrKeys(2)&"/"&arrKeys(0)&"/"&arrKeys(1)

end if

Dim arrKeys2() As String = myDate.Split("/")
myDate=arrKeys2(2)&"/"&arrKeys2(0)&"/"&arrKeys2(1)
    
    
       'find or create a user
       Dim objConnection As New OdbcConnection("DRIVER={MySQL ODBC 3.51 Driver};Server=whenme.db.8294901.hostedresource.com;Database=whenme;uid=whenme;pwd=Eenglish49;option=3;max pool size=100; min pool size=20")
       
     
    
        dim userID As String
        strSQL  = "Select userID" & _
                              " from user" & _
                              " where email = '" & email & "'"
   
        objConnection.Open()
        Dim objDataReader As OdbcDataReader
        objDataReader = New OdbcCommand(strSQL, objConnection).ExecuteReader()
        objDataReader.Read()
        'response.write ("here")
        'response.end
    
        If Not objDataReader.HasRows Then 'insert a new user
           
          strSQL = "Insert into user (email,firstName,lastName,gender,locale,username,birthday,location,lastActivity,createdDateTime) " & _
                   "Values ('" & email &"','" & firstname &"','" & lastName &"','" & gender &"','" & locale &"','" & username &"','" & String.Format("{0:u}", birthday) & "','" & userLocation &"',now(),now())"
                   
                  
                   
                objConnection.Close()              
                objConnection.Open()
                Dim objCommand As New OdbcCommand(strSQL, objConnection)
                objCommand.ExecuteNonQuery()
                
                
                strSQL="SELECT userID FROM user where email='" & email & "'"
                objDataReader = New OdbcCommand(strSQL, objConnection).ExecuteReader()
                objDataReader.Read()
                userID = objDataReader("userID")
                response.write("user " & userID & "inserted")
    
                 
               
        Else 
         userID=objDataReader("userID")
        End If
        
        'we have the user, insert the check-in
        strSQL="Insert into checkIn (location,date,time,AMPM,userID,createdDateTime) Values ('" & myLocation &"','" & myDate & "','" & myTime & "','" & myAMPM & "'," & userID &",now())"
        objConnection.Close()              
        objConnection.Open()
        Dim objCommand2 As New OdbcCommand(strSQL, objConnection)
        objCommand2.ExecuteNonQuery()
        
        strSQL="Update user set lastActivity=now() where userID=" & userID
        objConnection.Close()              
        objConnection.Open()
        Dim objCommand3 As New OdbcCommand(strSQL, objConnection)
        objCommand3.ExecuteNonQuery()
        
    
    
    objDataReader.Close()
    'objDataReader.Dispose()
    objConnection.Close()
    objConnection.Dispose()
    
    End Sub
</script>  
