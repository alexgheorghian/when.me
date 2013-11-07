<%
dim myLocation As String=request("myLocation")
dim myDate As String=request("myDate")
dim myTime As String=request("myTIme")
Response.Cookies("checkIn")("myLocation") = myLocation
Response.Cookies("checkIn")("myDate") = myDate
Response.Cookies("checkIn")("myTime") = myTime
Response.Cookies("checkIn").Expires = DateTime.Now.AddDays(1)


%>