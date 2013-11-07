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
  dim userID As String
  dim URL as String
  userID=request("userID")
  URL="http://www.when.me/userPhotos/" & userID & "/userPhoto_" & userID &".png"
 response.redirect (URL)
  
 End Sub
</script>