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
myLocation=$('#where').val();
myDate=$('#datepicker').datepicker( "getDate" )
if (myLocation==''){
 alert('Please Enter A Location');
}
}



