Imports Twitterizer.Framework

Partial Class Site
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            RefreshTweets()
        End If
    End Sub

    Public Sub RefreshTweets()
        Dim twitterUser As String = ConfigurationManager.AppSettings("username")
        Dim twitterPassword As String = ConfigurationManager.AppSettings("password")

        Try
            Dim twit As New Twitter(twitterUser, twitterPassword)
            lvTweets.DataSource = twit.Status.UserTimeline()

            'To only get back the N most recent statuses, use the following three lines instead of the one above
            'Dim twitParameters As New TwitterParameters
            'twitParameters.Add(TwitterParameterNames.Count, 3)
            'lvTweets.DataSource = twit.Status.UserTimeline(twitParameters)

            lvTweets.DataBind()


        Catch
            'Fail silently...
        End Try
    End Sub

    Protected Function RelativeTime(ByVal dtTime As DateTime) As String
        Dim timeDiff As TimeSpan = DateTime.Now.ToUniversalTime().Subtract(dtTime)

        If timeDiff.TotalMinutes < 1 Then
            Return "less than a minute ago."
        ElseIf timeDiff.TotalMinutes < 2 Then
            Return "about one minute ago"
        ElseIf timeDiff.TotalMinutes < 60 Then
            Return String.Format("about {0:N0} minutes ago", timeDiff.TotalMinutes)
        ElseIf timeDiff.TotalHours < 2 Then
            Return "about an hour ago"
        ElseIf timeDiff.TotalHours < 12 Then
            Return String.Format("about {0:N0} hours ago", timeDiff.TotalHours)
        ElseIf timeDiff.TotalDays < 365 Then
            Return dtTime.ToString("MMM d")
        Else
            Return dtTime.ToString("MMM d, yyyy")
        End If
    End Function

    Protected Sub tmrRefreshTweets_Tick(ByVal sender As Object, ByVal e As System.EventArgs) Handles tmrRefreshTweets.Tick
        RefreshTweets()
    End Sub
End Class

