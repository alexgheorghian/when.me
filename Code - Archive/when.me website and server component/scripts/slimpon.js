function doSubscription(){

 email=$("#email").val();
 password=$("#password").val();
 
 $('#subscriptionMessage').fadeOut();
 
 $.ajax({
   type: "POST",
   url: "doSubscription.aspx",
   data: "email=" + email + "&password=" + password,
   success: function(msg){
     //check if ID was returned
     if (isNaN(parseFloat(msg))){
     
     $("#subscriptionMessage").html("<table cellpadding=0 cellspacing=0><tr><td valign=top style='padding-right:3px'><img src=images/error-icon.png></td><td style='font:10pt trebuchet ms;color:#fff0a5'> "+msg+"</td></tr></table>");
    $('#email').focus();
    }
    else{
    $('#subscribeToday').fadeOut('slow');
    
     $.get('profile.aspx?userID='+msg, function(data) {
                    $("#dealframe").html(data);
                     });
    }
    
   }
   
 });
 
 $('#subscriptionMessage').fadeIn();
  
}

function doLogin(){
 email=$("#loginemail").val();
 password=$("#loginpassword").val();
 
 $.ajax({
   type: "POST",
   url: "login.aspx",
   data: "email=" + email + "&password=" + password,
   success: function(msg){
     //check if ID was returned
     if (isNaN(parseFloat(msg))){
     
    $("#loginMessage").html("<table cellpadding=0 cellspacing=0><tr><td valign=top style='padding-right:3px'><img src=images/error-icon.png></td><td style='font:10pt trebuchet ms;color:#fff0a5'> "+msg+"</td></tr></table>");
    }
    else{
  
    $('#userLogin').slideUp('slow', function() {
                     window.location='default.aspx';
                           
                     });
    
     
    }
    
   }
   
 });

 
}

function changeFrame(toWhere){
 $('#loadingDeal').fadeIn(300);
                
                
                   
                    if (toWhere=="deal.aspx"){
                     $('#todayArrow').html('<img src="images/menu-arrow.gif">')
                     $('#pastArrow').html('<img src="images/menu-arrow-blank.gif">')
                     $('#contactArrow').html('<img src="images/menu-arrow-blank.gif">')
                    }
                    
                      if (toWhere=="contact.aspx"){
                     $('#todayArrow').html('<img src="images/menu-arrow-blank.gif">')
                     $('#pastArrow').html('<img src="images/menu-arrow-blank.gif">')
                     $('#contactArrow').html('<img src="images/menu-arrow.gif">')
                    }
                    
                    if (toWhere=="pastdeals.aspx"){
                     $('#todayArrow').html('<img src="images/menu-arrow-blank.gif">')
                     $('#contactArrow').html('<img src="images/menu-arrow-blank.gif">')
                     $('#pastArrow').html('<img src="images/menu-arrow.gif">')
                    }
                    
                    
                    
                    $('#dealframe').fadeOut('slow', function() {
 
                     
                    $.get(toWhere, function(data) {
                    $("#dealframe").html(data);
                     });

                     $('#dealframe').delay(2000).fadeIn('slow', function() {
                     $('#loadingDeal').hide();
                    
                           
                     }
                     
                     );
                     
  });
        }

function showLogin(){
$('#userLogin').slideDown('slow')
}