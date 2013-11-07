<head>
<meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0, user-scalable=no" />
 <script type="text/javascript" src="scripts/jquery-1.6.1.min.js"></script> 
 <script type="text/javascript" src="scripts/jquery-ui-1.8.13.custom.min.js"></script>

<style type="text/css">
  html { height: 100% }
  body { height: 100%; margin: 0; padding: 0; }
  #map_canvas { height: 100% } 
</style>
 <link type="text/css" href="styles/ui-lightness/jquery-ui-1.8.13.custom.css" rel="stylesheet" /> 
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
<script>
$(function() {
		$( "#datepicker" ).datepicker({
			minDate: '-0d',
			showOn: "both",
			buttonImage: "images/calendar.gif",
			buttonImageOnly: true
		
		});
	});
	



function goNext(){
 var error=false;
 myLocation=$('#where').val();
 var day1 = $("#datepicker").datepicker('getDate').getDate();                 
                    var month1 = $("#datepicker").datepicker('getDate').getMonth() + 1;             
                    var year1 = $("#datepicker").datepicker('getDate').getFullYear();
                    var myDate = month1 + "/" + day1 + "/" + year1;
myTime=$('#time').val(); 

if (myLocation==''){
 alert('Please Enter A Location');
 error=true;
}

if (error==false) {
createCookie('myLocation',myLocation,7)
createCookie('myDate',myDate,7)
createCookie('myTime',myTime,7)


//window.location="http://www.facebook.com/dialog/oauth?
//    client_id=159535704125767&redirect_uri=www.when.me&display=touch"



window.location="http://www.facebook.com/dialog/feed?app_id=159535704125767&redirect_uri=http://www.when.me/thankyou.aspx&link=www.when.me&caption=Planned Check-In  @ " + myLocation +" &description=When To Find Me: " + myTime + ", "+ myDate + "&display=touch&scope=email,publish_stream,user_location,user_birthday&picture=http://www.when.me/images/whenme-qr.gif"
 


}
}

function createCookie(name,value,days) {
	if (days) {
		var date = new Date();
		date.setTime(date.getTime()+(days*24*60*60*1000));
		var expires = "; expires="+date.toGMTString();
	}
	else var expires = "";
	document.cookie = name+"="+value+expires+"; path=/";
}


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
<body onload="initialize();setTimeout(function() { window.scrollTo(0, 1) }, 100);">
<div id="fb-root"></div>
<script src="http://connect.facebook.net/en_US/all.js"></script>
<script>
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
              //var name = document.getElementById('name');
              //name.innerHTML = user.name
           }
         });
         $("#fblogin").hide();
    
  } else {
    //document.getElementById('FBlogin').style.visibility = "visible";
  }
});
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
<td  style="font:20pt arial;color:white;font-weight:bold">Where Are You Going?</td>
</tr>
<tr>
<td style=""><input type="text" id="where" style="font:12pt arial;width:100%"></td>
</tr>
<tr>
<td style="font:20pt arial;color:white;font-weight:bold">When?</td>
</tr>
<tr>
<td>
 <table cellpadding="0" cellspacing="0" border="0">
 <tr>
 

 <td valign="middle">
 <select name="time" id="time" style="font:13pt arial">
  <option value="1:00 AM">1:00 AM</option>
  <option value="2:00 AM">2:00 AM</option>
  <option value="3:00 AM">3:00 AM</option>
  <option value="4:00 AM">4:00 AM</option>
  <option value="5:00 AM">5:00 AM</option>
  <option value="6:00 AM">6:00 AM</option>
  <option value="7:00 AM">7:00 AM</option>
  <option value="8:00 AM">8:00 AM</option>
  <option value="9:00 AM" selected>9:00 AM</option>
  <option value="9:30 AM">9:30 AM</option>
  <option value="10:00 AM">10:00 AM</option>
  <option value="10:30 AM">10:30 AM</option>
  <option value="11:00 AM">11:00 AM</option>
  <option value="11:30 AM">11:30 AM</option>
  <option value="12:00 PM">12:00 PM</option>
  <option value="12:30 PM">12:30 PM</option>
  <option value="1:00 PM">1:00 PM</option>
  <option value="1:30 PM">1:30 PM</option>
  <option value="2:00 PM">2:00 PM</option>
  <option value="2:30 PM">2:30 PM</option>
  <option value="3:00 PM">3:00 PM</option>
  <option value="3:30 PM">3:30 PM</option>
  <option value="4:00 PM">4:00 PM</option>
  <option value="4:30 PM">4:30 PM</option>
  <option value="5:00 PM">5:00 PM</option>
  <option value="5:30 PM">5:30 PM</option>
  <option value="6:00 PM">6:00 PM</option>
  <option value="6:30 PM">6:30 PM</option>
  <option value="7:00 PM">7:00 PM</option>
  <option value="7:30 PM">7:30 PM</option>
  <option value="8:00 PM">8:00 PM</option>
  <option value="8:30 PM">8:30 PM</option>
  <option value="9:00 PM">9:00 PM</option>
  <option value="9:30 PM">9:30 PM</option>
  <option value="10:00 PM">10:00 PM</option>
  <option value="10:30 PM">10:30 PM</option>
  <option value="11:00 PM">11:00 PM</option>
  <option value="11:30 PM">11:30 PM</option>
  <option value="12:00 AM">12:00 AM</option>
  </select>
 </td>
  <td valign="middle" style="padding-left:5px;"><input type="text" value="Today" id="datepicker" style="font:12pt arial;width:150px;color:#a9a9a9;vertical-align: middle;" readonly="true"></td>
 </tr>
 </table> 

</td>
</tr>
<tr><td align="right" style="padding-top:5px;"><input type="image" src="images/sharebutton.gif" id="gobutton" onclick="goNext()"></td></tr>
</table>
</center>
 </div>
 <div id="map_canvas" style="width:100%;height:100%"></div>
<script src="http://mediaspree.publishers.appstores.com/campaigns/widget_slot/widget_attrs[source]=js_campaign_widget" type="text/javascript" charset="utf-8"></script>
</body>