function Connect-AMTManagement {
    param(
    [Parameter(Mandatory)] $AMTManagementAddress,
    [Parameter(Mandatory)][string]$AMTUsername,
    [Parameter(Mandatory)][string]$AMTPassword
    )

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
        "password"=$AMTPassword
    } | ConvertTo-Json

    $Response = Invoke-RestMethod -Uri ("https://" + $AMTManagementAddress + "/mps/login/api/v1/authorize") -Method POST -UseBasicParsing `
    -Body $Body -ContentType 'application/json' -Headers $headers

    if($?){
        $Global:AMTSession = New-Object -TypeName PSObject -Property @{
            "Address"=$AMTManagementAddress
            "Token"=$Response.token
        }
        $Global:AMTSession | Format-Table
    }
}