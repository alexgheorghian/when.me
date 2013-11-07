Imports System.Security.Cryptography
Imports System.Text

Public Class MD5Encryption
    Private Shared EncStringBytes() As Byte
    Private Shared Encoder As New UTF8Encoding
    Private Shared MD5Hasher As New MD5CryptoServiceProvider


    'Encrptes the string in MD5 when passed as a string

    Public Shared Function Encrypt(ByVal EncString As String) As String
        'Variable Declarations

        Dim RanGen As New Random
        Dim RanString As String = ""
        Dim MD5String As String
        Dim RanSaltLoc As String

        'Generates a Random number of under 4 digits

        While RanString.Length <= 3
            RanString = RanString & RanGen.Next(0, 9)
        End While

        'Converts the String to bytes

        EncStringBytes = Encoder.GetBytes(EncString & RanString)

        'Generates the MD5 Byte Array

        EncStringBytes = MD5Hasher.ComputeHash(EncStringBytes)

        'Affixing Salt information into the MD5 hash

        MD5String = BitConverter.ToString(EncStringBytes)
        MD5String = MD5String.Replace("-", Nothing)

        'Finds a random location in the string to sit the salt

        RanSaltLoc = RanGen.Next(4, MD5String.Length)

        'Shoves the salt in the location

        MD5String = MD5String.Insert(RanSaltLoc, RanString)

        'Adds 0 for values under 10 so we always occupy 2 charater spaces

        If RanSaltLoc < 10 Then
            RanSaltLoc = "0" & RanSaltLoc
        End If

        'Shoves the salt location in the string at position 3

        MD5String = MD5String.Insert(3, RanSaltLoc)

        'Returns the MD5 encrypted string to the calling object

        Return MD5String
    End Function

    'Verifies the String entered matches the MD5 Hash

    Public Shared Function Verify(ByVal S As String, ByVal Hash As String) As Boolean
        'Variable Declarations

        Dim SaltAddress As Double
        Dim SaltID As String
        Dim NewHash As String

        'Finds the Salt Address and Removes the Salt Address from the string

        SaltAddress = Hash.Substring(3, 2)
        Hash = Hash.Remove(3, 2)

        'Finds the SaltID and removes it from the string

        SaltID = Hash.Substring(SaltAddress, 4)
        Hash = Hash.Remove(SaltAddress, 4)

        'Converts the string passed to us to Bytes

        EncStringBytes = Encoder.GetBytes(S & SaltID)

        'Encryptes the string passed to us with the salt

        EncStringBytes = MD5Hasher.ComputeHash(EncStringBytes)

        'Converts the Hash to a string

        NewHash = BitConverter.ToString(EncStringBytes)
        NewHash = NewHash.Replace("-", Nothing)

        'Tests the new has against the one passed to us

        If NewHash = Hash Then
            Return True
        ElseIf NewHash <> Hash Then
            Return False
        End If
    End Function
End Class