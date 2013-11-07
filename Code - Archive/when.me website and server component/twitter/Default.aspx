<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>
<%@ MasterType VirtualPath="~/Site.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>Welcome!</h3>
    <p>
        This demo shows how to integrate Twitter into an ASP.NET website using
        <a href="http://code.google.com/p/twitterizer/">twitterizer</a>, an open source
        .NET project. The left hand column shows recent tweets from
        <asp:Label ID="lblTwitterUser" runat="server" 
            Text='<%$ AppSettings:username %>' Font-Bold="True"></asp:Label>. These
        recent tweets are automatically updated every 15 seconds using an UpdatePanel and Timer Web
        control. (You can configure which user's tweets show up in the right by editing the <code>username</code>
        <code>&lt;appSetting&gt;</code> value in <code>Web.config</code>.)
    </p>
    <p>
        To tweet from this website, use the text box below. Please note that any tweet you leave will be posted to the
        Twitter account <asp:Label ID="Label1" runat="server" Text='<%$ AppSettings:username %>' Font-Bold="True"></asp:Label>.
        If this is the test account I created for this demo, please be polite and do not leave an offensive or off-color tweet.
    </p>
    <p>
        <b>Tweet Away!</b><br />
        <asp:TextBox ID="txtTweet" runat="server" TextMode="MultiLine" Width="95%" Rows="4"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvTweet" runat="server" Display="Dynamic" ErrorMessage="<br />Tweet text required." ControlToValidate="txtTweet"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="regexpTweet" runat="server" Display="Dynamic" ErrorMessage="<br />Tweet text must be 140 characters or less." ControlToValidate="txtTweet" ValidationExpression="(.|\n){0,140}"></asp:RegularExpressionValidator>
    </p>
    <p>
        <asp:Button ID="btnSaveTweet" runat="server" Text="Post My Tweet" />
    </p>
    <p>
        <table align="center" class="noteBox">
            <tr><th style="text-align:center"><span style="color:red">WARNING:</span> This Code Will Stop Working in June 2010!</th></tr>
            <tr><td>
                <p>Twitterizer version 1.0 uses BASIC authentication to communicate with Twitter.
                Starting in June 2010, Twitter will <b>end support for BASIC authentication</b>.
                To access protected functions, such as sending a tweet from a web page, you will need
                to use Twitterizer version 2.0, which supports <a href="http://oauth.net/">OAuth authentication</a>.
                </p>
                <p>
                    For more information on Twitterizer 2.0 and using OAuth authentication, see:
                    <a href="http://www.4guysfromrolla.com/articles/051210-1.aspx">Integrating Twitter Into An ASP.NET
                    Website Using OAuth</a>
                </p>
            </td></tr>
        </table>
    </p>
</asp:Content>

