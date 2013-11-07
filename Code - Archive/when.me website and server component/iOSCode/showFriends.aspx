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
      Response.ContentType = "application/json"
      'Response.Write("<?xml version=""1.0"" encoding=""utf-8""?>" & vbCrLf)
      'Response.Write("<rss version=""2.0"" xmlns:atom=""http://www.w3.org/2005/Atom"">" & vbCrLf)
      dim strSQL As String
       Dim sortType As String
       Dim userID As String
       Dim objConnection As New OdbcConnection(System.Configuration.ConfigurationManager.AppSettings("ConnString").ToString)
       
       sortType=request("sort")
       userID=request("userID")
       
       if sortType="0" then 'following
     
        strSQL  = "select followingID,user.username,user.userID,user.firstname,(select planText from plan where plandate>now() and userID=user.userID order by planDate desc LIMIT 1) as recentPlan from friends" & _
                  " inner join user on followingID=userID" & _ 
                  " where followerID=" & userID
                           
        else if sortType="1" then 'followers
        
           strSQL  = "select followerID,user.username,user.userID,user.firstname,(select planText from plan where plandate>now() and userID=user.userID order by planDate desc LIMIT 1) as recentPlan from friends" & _
                  " inner join user on followerID=userID" & _ 
                  " where followingID=" & userID
      else if sortType="2" then 'search
      
      Dim strSearchString As String
      strSearchString=request("searchstring")
        
           strSQL  = "select username,userID,firstname,(select planText from plan where plandate>now() and userID=user.userID order by planDate desc LIMIT 1) as recentPlan from user" & _
                  " where username like '%" &  strSearchString & "%'"
        
       end if 
   
        objConnection.Open()
        Dim objDataReader As OdbcDataReader
        objDataReader = New OdbcCommand(strSQL, objConnection).ExecuteReader()
        objDataReader.Read()
    
        If objDataReader.HasRows Then 'create the json
             dim myData as String
             myData= "{"
             myData=myData & """friends"": ["
             myData=myData &"{""userName"":""" & objDataReader("username") & ""","
             myData=myData &"""firstname"":""" & objDataReader("firstname") & ""","
             myData=myData &"""userID"":""" & objDataReader("userID") & ""","
             myData=myData &"""recentPlan"":""" & objDataReader("recentPlan") & ""","
             myData=myData &"""userImage"":""http://www.when.me/userPhotos/" & objDataReader("userID") & "/userPhoto_" & objDataReader("userID") & ".png""," 
             myData=myData &"""userID"":"""  & objDataReader("userID") & """},"
            
             Do While objDataReader.Read()
             myData=myData &"{""userName"":""" & objDataReader("username") & ""","
             myData=myData &"""firstname"":""" & objDataReader("firstname") & ""","
             myData=myData &"""userID"":""" & objDataReader("userID") & ""","
             myData=myData &"""recentPlan"":""" & objDataReader("recentPlan") & ""","
             myData=myData &"""userImage"":""http://www.when.me/userPhotos/" & objDataReader("userID") & "/userPhoto_" & objDataReader("userID") & ".png""," 
             myData=myData &"""userID"":"""  & objDataReader("userID") & """},"
             

               
            Loop
         
          objConnection.Close()              
          myData=myData &"]}"
          myData = StrReverse(Replace(StrReverse(myData), StrReverse(","), _
StrReverse(""), , 1))
          
          response.write (myData)
        Else
            response.write ("0")
        End If 
 End Sub
</script> 