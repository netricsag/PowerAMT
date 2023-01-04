function Get-AMTDevicesStats {
    <#
        .SYNOPSIS
        Shows AMT Device statistics.
        
        .DESCRIPTION
        Shows statistics of currently AMT "joined" devices. It shows connected and disconnected counts.

        .INPUTS
        Get-AMTDevicesStats does not take pipeline inputs.

        .OUTPUTS
        System.Object

        .EXAMPLE
        PS> Get-AMTDevicesStats

        totalCount connectedCount disconnectedCount
        ---------- -------------- -----------------
                2              2                 0

        .LINK
        Online version: https://github.com/netricsag/PowerAMT/tree/main/Docs

    #>
    if($null -eq $Global:AMTSession){
        throw "No active AMT session. Create a session first with Connect-AMTManagement"
    }
    $headers=@{}
    $headers.Add("Authorization", "Bearer $($Global:AMTSession.Token)")

    $uri = "https://" + $Global:AMTSession.Address + "/mps/api/v1/devices/stats"

    if ($PSVersionTable.PSVersion.Major -le 5){
        $Response = Invoke-RestMethod -Uri $uri -Method GET -Headers $headers -TimeoutSec 5
    } else {
        $Response = Invoke-RestMethod -Uri $uri -Method GET -Headers $headers -SkipCertificateCheck -TimeoutSec 5
    }

    return $Response

}