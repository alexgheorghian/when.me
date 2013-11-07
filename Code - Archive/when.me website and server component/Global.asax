<%@ Application Language="VB" %>
<%@ Import Namespace="System.Diagnostics" %>
<script runat="server">
Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application startup
    End Sub
    
    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
    End Sub

Sub Application_BeginRequest(ByVal sender As Object, ByVal e As EventArgs)
'response.redirect("http://www.google.com")
'Dim URL As String 
'URL=HttpContext.Current.Request.Url.ToString()
'response.write (URL)
'response.end

End Sub



</script>