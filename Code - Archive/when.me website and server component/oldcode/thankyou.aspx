<head>
<meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0, user-scalable=no" />
 <script type="text/javascript" src="scripts/jquery-1.6.1.min.js"></script> 
 <script type="text/javascript" src="scripts/jquery-ui-1.8.13.custom.min.js"></script>
 <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=true&libraries=places,adsense"></script>
    <style type="text/css">
  html { height: 100% }
  body { height: 100%; margin: 0; padding: 0; }
  #map_canvas { height: 100% } 
</style>
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
    publisherId: 'pub-0776056806017912',
    channelNumber: '3000803723'
  }
  adUnit = new google.maps.adsense.AdUnit(adUnitDiv, adUnitOptions);    
            

        var input = document.getElementById('where');
        var autocomplete = new google.maps.places.Autocomplete(input);
        
        autocomplete.bindTo('bounds', map);
        
        var infowindow = new google.maps.InfoWindow();
        var marker = new google.maps.Marker({
          map: map
        });
        
        google.maps.event.addListener(autocomplete, 'place_changed', function() {
          infowindow.close();
          var place = autocomplete.getPlace();
          if (place.geometry.viewport) {
            map.fitBounds(place.geometry.viewport);
          } else {
            map.setCenter(place.geometry.location);
            map.setZoom(17);  // Why 17? Because it looks good.
          }
 
          var image = new google.maps.MarkerImage(
              place.icon,
              new google.maps.Size(71, 71),
              new google.maps.Point(0, 0),
              new google.maps.Point(17, 34),
              new google.maps.Size(35, 35));
          marker.setIcon(image);
          marker.setPosition(place.geometry.location);
 
          var address = '';
          if (place.address_components) {
            address = [(place.address_components[0] &&
                        place.address_components[0].short_name || ''),
                       (place.address_components[1] &&
                        place.address_components[1].short_name || ''),
                       (place.address_components[2] &&
                        place.address_components[2].short_name || '')
                      ].join(' ');
          }
 
          infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address );
          infowindow.open(map, marker);
        });
        
        // Try HTML5 geolocation
        if(navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(function(position) {
            var pos = new google.maps.LatLng(position.coords.latitude,
                                             position.coords.longitude);
 
 
            map.setCenter(pos);
          }, function() {
            handleNoGeolocation(true);
          });
        } else {
          // Browser doesn't support Geolocation
          handleNoGeolocation(false);
        }
      }
 
      function handleNoGeolocation(errorFlag) {
        if (errorFlag) {
          var content = 'Error: The Geolocation service failed.';
        } else {
          var content = 'Error: Your browser doesn\'t support geolocation.';
        }
 
        var options = {
          map: map,
          position: new google.maps.LatLng(60, 105),
          content: content
        };
 
        var infowindow = new google.maps.InfoWindow(options);
        map.setCenter(options.position);
      }
 
      google.maps.event.addDomListener(window, 'load', initialize);
    </script> 
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
</head>
<body>
<div id="fb-root"></div>
<script src="http://connect.facebook.net/en_US/all.js"></script>
<script>
var dataToSend;

  FB.init({
    appId  : '159535704125767',
    status : true, // check login status
    cookie : true, // enable cookies to allow the server to access the session
    xfbml  : true, // parse XFBML

    oauth  : true // enable OAuth 2.0
  });
  
  FB.getLoginStatus(function(response) {
  if (response.authResponse) {
    
     FB.api('/me', function(user) {
           if(user != null) {
              var fbimage = document.getElementById('fbimage');
              fbimage.src = 'http://graph.facebook.com/' + user.id + '/picture';
              //var email = document.getElementById('email');
              var email = user.email;
              var firstName=user.first_name;
              var lastName=user.last_name;
              var gender=user.gender;
              var locale=user.locale;
              var username=user.username;
              var birthday=user.birthday;
              var userLocation=user.location.name;
              
              myLocation=readCookie('myLocation');
			  myDate=readCookie('myDate');
			  myTime=readCookie('myTime');
			  
			  //var map = document.getElementById('map');
			  //map.src="http://maps.googleapis.com/maps/api/staticmap?center=" + myLocation + "&zoom=15&size=100x100&maptype=roadmap&sensor=false"


var dataToSend="userLocation=" + userLocation + "&birthday=" + birthday + "&username=" + username + "&locale=" + locale + "&gender=" + gender + "&lastName=" + lastName + "&firstName=" + firstName + "&email=" + email + "&myLocation="+ myLocation +" &myTime=" + myTime + "&myDate="+ myDate

              //alert("Authroized user Data To Send:" + dataToSend)
              $.ajax({
   url: "save.aspx",
   data: dataToSend,
   success: function(){
   //alert('back from the server!')
    document.getElementById('locationLabel').innerHTML=myLocation
    document.getElementById('timeLabel').innerHTML=myTime
    document.getElementById('dateLabel').innerHTML=myDate
   }
 });

              
           }
         });
         $("#fblogin").hide();
    
  } else {
    window.location="http://www.facebook.com/dialog/oauth?client_id=159535704125767&redirect_uri=http://www.when.me/thankyou.aspx&display=touch&scope=email,publish_stream,user_location,user_birthday"
  }
});



function readCookie(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}
</script>

<table cellpadding="0" cellspacing="0" border="0" width="100%;height:50px;">
<tr>
<td width="50"><img src="images/whenme-logo-50.gif"></td>
<td style="padding-left:10px""><span style="font:30pt arial; font-weight:bold;color:#7fa779">when<span style="color:#ff9a03">.me</span></span></td>
<td align="right" style="">
<div id="fblogin"><a href="http://www.facebook.com/dialog/oauth?client_id=159535704125767&redirect_uri=http://www.when.me&display=touch&scope=email,publish_stream,user_location,user_birthday"><img src="images/facebook-login-button.gif"></a></div>
<img id="fbimage"/>
</td>
</tr>
</table>


<div style="background-color:#7fa779;padding-top:10px;padding-bottom:10px;">
<center>

<table cellpadding="0" cellspacing="0" border="0" style="">
<tr>
<td  style="font:30pt arial;color:white;font-weight:bold">Your Check In:<bR></td>
</tr>

<tr>
<td  style="font:20pt arial;color:white;font-weight:bold">Where:</td>
</tr>
<tr>
<td style=""><div id="locationLabel" style="font:20pt arial;color:white;"></div></td>
</tr>
<tr>
<td style="font:20pt arial;color:white;font-weight:bold">When:</td>
</tr>
<tr>
<td>
 <table cellpadding="0" cellspacing="0" border="0">
 <tr>
 

 <td valign="middle">
<div id="timeLabel" style="font:20pt arial;color:white;"></div>
 </td>
  <td valign="middle" style="padding-left:5px;">
  <div id="dateLabel" style="font:20pt arial;color:white;"></div>
  </td>
 </tr>
 </table> 

</td>
</tr>
</table>
</center>
 </div>
 <div id="map_canvas" style="width:100%;height:100%"></div>

</body>


