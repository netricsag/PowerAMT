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

    return (Invoke-RestMethod -Uri ("https://" + $Global:AMTSession.Address + "/mps/api/v1/devices/stats") -Method GET -Headers $headers)

}