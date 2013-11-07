<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.Odbc" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="System.Web.UI.HtmlControls" %>


<script runat="server"> 
     Dim PlanLatitude As String
     Dim PlanLongitude As String
     Dim ID As String
     Dim userID As String
     Dim PlanText As String
     Dim hasPlanPhoto As Integer
     Dim hasProfilePic As Integer
     Dim planDate As String
 Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

 
 ID=request("ID")
 'response.write("You are viewing plan "& ID)
 
        Dim objConnection As New OdbcConnection(System.Configuration.ConfigurationManager.AppSettings("ConnString").ToString)
       
     
    
        Dim strSQL as String
        strSQL  = "Select planID,planText,latitude,longitude,plan.userID,hasPlanPhoto,user.profilePicture,planDate" & _
                              " from plan" & _
                              " inner join user on plan.userID=user.userID" & _
                              " where uniqueID= '" & ID & "' "
   
        objConnection.Open()
        Dim objDataReader As OdbcDataReader
        objDataReader = New OdbcCommand(strSQL, objConnection).ExecuteReader()
        objDataReader.Read()
    
    
        If Not objDataReader.HasRows Then 'user doesn't exist
           
       
          
             objConnection.Close()   
                response.redirect("http://www.when.me")           
       
        Else 
       
       
        
        PlanText=objDataReader("PlanText")
        userID=objDataReader("userID")
        hasPlanPhoto=objDataReader("hasPlanPhoto")
        hasProfilePic=objDataReader("profilePicture")
        planDate=objDataReader("planDate")
        if (objDataReader("latitude") is DBNull.Value) or (objDataReader("longitude") is DBNull.Value) Then
         PlanLatitude="0"
         PlanLongitude="0"
        else
         PlanLatitude=objDataReader("latitude")
         PlanLongitude=objDataReader("longitude")
        end if
        
        myPlanText.text=PlanText
        
         'response.write(PlanLatitude & " " & PlanLongitude)
         objConnection.Close() 
        End If

 End Sub
</script> 

<head>
<title>I am going to <%=PlanText%></title>
<link rel="stylesheet" href="/css/main.css" type="text/css" />
<style type="text/css">
  html { height: 100% }
  body { height: 100%; margin: 0; padding: 0; }
  #map_canvas { height: 100% } 
</style>
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=true&libraries=places,adsense"></script>



   <script type="text/javascript"> 
      var map;
      var adUnit;
 
      function initialize() {
        var myOptions = {
          zoom: 10,
          panControl: false,
          zoomControl: true,
          scaleControl: true,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        map = new google.maps.Map(document.getElementById('map_canvas'),
            myOptions);
            
        var adUnitDiv = document.createElement('div');
       var adUnitOptions = {
    format: google.maps.adsense.AdFormat.BUTTON,
    position: google.maps.ControlPosition.TOP_LEFT,
    map: map,
    visible: true,
    publisherId: 'pub-0776056806017912'
  }
  //adUnit = new google.maps.adsense.AdUnit(adUnitDiv, adUnitOptions);    
            

        //var infowindow = new google.maps.InfoWindow();
   
     
   
       
            var pos = new google.maps.LatLng(<%=PlanLatitude%>,
                                            <%=PlanLongitude%>);
 
           
var marker = new google.maps.Marker({
        position: pos, 
        map: map,
        title:"Hello World!"
    });         
            map.setCenter(pos);
            map.setZoom(17);
            //marker.setMap(map);
       
      }

 
      google.maps.event.addDomListener(window, 'load', initialize);
    </script> 


</head>
<body onload="initialize();setTimeout(function() { window.scrollTo(0, 1) }, 100);">
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=159535704125767";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

<center>
<table cellpadding="0" cellspacing="0" border="0" width="100%" height="35">
 <tr>
  <td style="background-image:url('images/topbar-backer.png');" align="center">
  <table cellpadding="0" cellspacing="0" border="0" width="999" height="35">
   <tr>
    <td align="left" width="333">
     <table cellpadding="0" cellspacing="0" border="0" >
      <tr>
       <td width="22"><a href="http://www.when.me"><img src="images/topbar-me.png" border="0"></a></td>
       <td width="7"></td>
       <td width="22"><a href="https://twitter.com/#!/WhenMeApp"><img src="images/topbar-twitter.png" border="0"></a></td>
       <td width="7"></td>
       <td width="22"><a href="http://www.facebook.com/whenmeapp"><img src="images/topbar-fb.png" border="0"></a></td>
      </tr>
     </table>
    </td>
    <td align="center" width="333"><a href="default.aspx"><img src="images/topbar-logo.png" border="0"></a></td>
    <td align="right" width="333"><a href="iTunes-redirect.html"><img src="images/topbar-getTheApp.png"></a></td>
   </tr>
  </table>
  </td>
 </tr>
</table>
<br><br>
<table width="1024" cellpadding="0" cellspacing="0" style="background-color:#ffffff" class="roundBox">
<tr><Td align="Center">
<br>
<table width="1000" cellpadding="0" cellspacing="0" style="background-color:#cac7c0" class="roundBox">
 <tr>
  <td align="Center">
  <br>
  <table cellpadding="0" cellspacing="0" border="0" style="background-color:#f7f5f0">
  <tr><td>
  <table cellpadding="0" cellspacing="0" border="0">
  <tr><Td style="width:880px;height:75px;background-image:url('images/i-am-going-to-topper.png');background-repeat:no-repeat;" valign="top" align="right">
  <span style="padding-right:20px;">
  <% if hasProfilePic=1 then %>
  <img style="border:2px solid #7c7c7c" src="userPhotos/<%=userID%>/userPhoto_<%=userID%>.png" width="65" height="65"></span>
  <%else%>
  <img style="border:2px solid #7c7c7c" src="images/noPhoto.png" width="65" height="65"></span>
  <%end if%>
  </TD></tr>
  </table> 
  <table cellpadding="0" cellspacing="0" boder="0">
  <tr><Td style="width:880px;background-color:#f7f5f0;">
  <span style="font:35pt Arial Rounded MT Bold;color:#b5845c;padding-left:10px;">"<asp:Label runat="server" id="myPlanText" />"</span>
  </TD></tr>
  </table>  
  </td></tr>
  </table> 
  <table cellpadding="0" cellspacing="0" border="0">
  <tr><td><img src="images/i-am-going-to-bottom.png"></td></tr>
  </table>
  
<br>
<table cellpadding="0" cellspacing="0" border="0" width="880">
 <tr>
 <Td width="122"><img src="images/whenplan.png"></TD>
 <Td valign="bottom" width="636" style="font:35pt Arial Rounded MT Bold;color:#ffffff;padding-left:10px;"><%=planDate%></TD>
 <td width="122"><a href="itunes-redirect.html"></a><img src="images/joinme-button.png" border="0" style="cursor:hand"></a></td>
 </tr>
</table>
<br>
  </td>
 </tr>
</table>
<br>
<table cellpadding="0" cellspacing="0" border="0">
<tr>
<td valign="top" >
<%if hasPlanPhoto=1 then %>
<img src="userPhotos/<%=userID%>/<%=ID%>/planPhoto_<%=ID%>.jpg" width="300" class="roundbox"></td>
<%else%>
<img src="images/noplanphoto.png" class="roundbox">
<%end if%>
<td width="10"></td>
<td valign="top">  
<%if PlanLatitude="0" then%>
<img src="images/nolocation.png" class="roundbox"></td>
<%else%>
<div id="map_canvas" style="width:690px;height:300px;" class="roundbox"></div></td>
<%end if%>
</tr>
</table>
<br>
<div class="fb-comments" data-href="http://www.when.me/<%=ID%>" data-num-posts="5" data-width="1000"></div>

</TD></tr></table>
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-66783-30']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>