Imports Twitterizer.Framework
Imports System.Configuration

Partial Class _Default
    Inherits BasePage

    Protected Sub btnSaveTweet_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveTweet.Click
        If Not Page.IsValid Then Exit Sub

        Dim twitterUser As String = ConfigurationManager.AppSettings("username")
        Dim twitterPassword As String = ConfigurationManager.AppSettings("password")

        Try
            'The source parameter determines where the tweet came "from." Omit this parameter to have the tweet 
            'report as "from Twitterizer." Use a non-valid source name (such as random GUID) to have it report
            'as "from web".
            Dim source As String = Guid.NewGuid().ToString()

            Dim twit As New Twitter(twitterUser, twitterPassword, source)
            twit.Status.Update(txtTweet.Text.Trim())

            txtTweet.Text = String.Empty    'Clear out the Tweeting text box

            'Refresh the list of tweets in the left column
            Master.RefreshTweets()

            MyBase.DisplayAlert("Tweet posted!")

        Catch tex As TwitterizerException
            MyBase.DisplayAlert("There was an error working with Twitter. Check the username/password in Web.config." & vbCrLf & vbCrLf & tex.Message)

            'You can see details about the data sent to Twitter and the error message via the properties:
            '   tex.RequestData
            '   tex.RawXML

        Catch ex As Exception
            MyBase.DisplayAlert("There was an unknown error." & vbCrLf & vbCrLf & ex.Message)
        End Try
    End Sub

End Class
