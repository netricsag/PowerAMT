function Connect-AMTManagement {
    <#
        .SYNOPSIS
        Create a new session token from the Open AMT Cloud Kit API. 
        
        .DESCRIPTION
        On successful login the API address and received JWT token are then stored in an object inside a global variable and
        will also be returned from the function. To view or manipulate the variable type: $Global:AMTSession

        .PARAMETER AMTManagementAddress
        IP address or DNS address on which the Open AMT API is reachable.

        .PARAMETER AMTUsername
        Username to use for the Open AMT authentication.

        .PARAMETER AMTPassword
        Password to use for the Open AMT authentication.

        .INPUTS
        None. You cannot pipe objects to Connect-AMTManagement.

        .OUTPUTS
        System.Object
            An object which contains the API address and JWT token for authentication.

        .EXAMPLE
        PS> Connect-AMTManagement -AMTManagementAddress 192.168.1.100 -AMTUsername admin -AMTPassword P@ssw0rd

        Token                                                                                                     Address        
        -----                                                                                                     -------
        eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5hbnRJZCI6IiIsImlzcyI6Ik5pY2VUcnlMb2wiLCJleHAiOjExNjAzMDQwOTF9 192.168.200.200

        .EXAMPLE
        PS> Connect-AMTManagement -AMTManagementAddress amt.example.com -AMTUsername admin -AMTPassword P@ssw0rd

        Token                                                                                                     Address        
        -----                                                                                                     -------
        eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5hbnRJZCI6IiIsImlzcyI6Ik5pY2VUcnlMb2wiLCJleHAiOjExNjAzMDQwOTF9 amt.example.com

        .LINK
        Online version: https://github.com/netricsag/PowerAMT/tree/main/Docs

    #>

    param(
        [Parameter(Mandatory)][string] $AMTManagementAddress,
        [Parameter(Mandatory)][string]$AMTUsername,
        [Parameter(Mandatory)][securestring]$AMTPassword,
        [int]$TimeoutSec = 5
    )
    

    if ($PSVersionTable.PSVersion.Major -le 5) {
  
    add-type @"
using System.Net;
using System.Security.Cryptography.X509Certificates;
public class TrustAllCertsPolicy : ICertificatePolicy {
    public bool CheckValidationResult(
        ServicePoint srvPoint, X509Certificate certificate,
        WebRequest request, int certificateProblem) {
        return true;
    }
}
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

    $headers=@{}
    $headers.Add("Content-Type", "application/json")

    $Body = @{
        "username"=$AMTUsername
        "password"=$AMTPassword | ConvertFrom-SecureString -AsPlainText
    } | ConvertTo-Json

    $Response = Invoke-RestMethod -Uri ("https://" + $AMTManagementAddress + "/mps/login/api/v1/authorize") -Method POST -UseBasicParsing `
    -Body $Body -ContentType 'application/json' -Headers $headers -TimeoutSec $TimeoutSec

    if($?){
        $Global:AMTSession = New-Object -TypeName PSObject -Property @{
            "Address"=$AMTManagementAddress
            "Token"=$Response.token
        }
        $Global:AMTSession | Format-Table
    }
} elseif ($psversiontable.PSVersion.Major -gt 5) {
    $headers=@{}
    $headers.Add("Content-Type", "application/json")
    
    $Body = @{
        "username"=$AMTUsername
        "password"=$AMTPassword | ConvertFrom-SecureString -AsPlainText
    } | ConvertTo-Json

    $Response = Invoke-RestMethod -Uri ("https://" + $AMTManagementAddress + "/mps/login/api/v1/authorize") -Method POST -UseBasicParsing `
    -Body $Body -ContentType 'application/json' -Headers $headers -TimeoutSec $TimeoutSec -SkipCertificateCheck

    if($?){
        $Global:AMTSession = New-Object -TypeName PSObject -Property @{
            "Address"=$AMTManagementAddress
            "Token"=$Response.token
        }
        $Global:AMTSession | Format-Table
    }
 }

}