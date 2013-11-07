Imports Microsoft.VisualBasic

Public Class BasePage
    Inherits System.Web.UI.Page

    Protected Sub DisplayAlert(ByVal msg As String)
        ClientScript.RegisterStartupScript(Me.GetType(), Guid.NewGuid().ToString(), String.Format("alert('{0}');", msg.Replace("'", "\'").Replace(vbCrLf, "\n")), True)
    End Sub
End Class
