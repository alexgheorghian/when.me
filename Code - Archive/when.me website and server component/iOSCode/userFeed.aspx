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
       Dim toShowID As String
       Dim objConnection As New OdbcConnection(System.Configuration.ConfigurationManager.AppSettings("ConnString").ToString)
       
       sortType=request("sort")
       userID=request("userID")
       toShowID=request("toShowID")
       
    if sortType="1" then 'soon
        
         strSQL  = "Select planID,planText,createDate,latitude,longitude,planDate,planCompleteDate,plan.userID,uniqueID,joins,user.username," & _
                               " CASE WHEN (select ID from planJoins where userID=" & userID & " and uniqueID=plan.uniqueID) THEN '1'" & _
                              " ELSE '0'" & _
                              " END As joined" & _
                              " from plan" & _
                              " inner join user on plan.userID=user.userID" & _
                              " WHERE active=1 and planDate > now() and plan.userID =" & toShowID &"" & _
                              " ORDER BY planDate  limit 75"
       end if                       
   
        objConnection.Open()
        Dim objDataReader As OdbcDataReader
        objDataReader = New OdbcCommand(strSQL, objConnection).ExecuteReader()
        objDataReader.Read()
    
        If objDataReader.HasRows Then 'create the json
             dim myData as String
             myData= "{"
             myData=myData & """plans"": ["
              myData=myData &"{""planText"":""" & objDataReader("planText") & ""","
             myData=myData &"""planID"":"""  & objDataReader("planID") & ""","
             myData=myData &"""createDate"":"""  & objDataReader("createDate") & ""","
             myData=myData &"""latitude"":"""  & objDataReader("latitude") & ""","
             myData=myData &"""longitude"":"""  & objDataReader("longitude") & ""","
             myData=myData &"""planDate"":"""  & objDataReader("planDate") & ""","
             myData=myData &"""uniqueID"":"""  & objDataReader("uniqueID") & ""","
             myData=myData &"""username"":"""  & objDataReader("username") & ""","
             myData=myData &"""joined"":"""  & objDataReader("joined") & ""","
              myData=myData &"""userImage"":""http://www.when.me/userPhotos/" & objDataReader("userID") & "/userPhoto_" & objDataReader("userID") & ".png""," 
             myData=myData &"""userID"":"""  & objDataReader("userID") & """},"
            
             Do While objDataReader.Read()
             myData=myData &"{""planText"":""" & objDataReader("planText") & ""","
             myData=myData &"""planID"":"""  & objDataReader("planID") & ""","
             myData=myData &"""createDate"":"""  & objDataReader("createDate") & ""","
             myData=myData &"""latitude"":"""  & objDataReader("latitude") & ""","
             myData=myData &"""longitude"":"""  & objDataReader("longitude") & ""","
             myData=myData &"""planDate"":"""  & objDataReader("planDate") & ""","
             myData=myData &"""uniqueID"":"""  & objDataReader("uniqueID") & ""","
             myData=myData &"""username"":"""  & objDataReader("username") & ""","
             myData=myData &"""joined"":"""  & objDataReader("joined") & ""","
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