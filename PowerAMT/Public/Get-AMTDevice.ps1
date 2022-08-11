function Get-AMTDevice {
    param (
        [string]$Name,
        [string]$GUID
    )

    if($null -eq $Global:AMTSession){
        throw "No active AMT session. Create a session first with Connect-AMTManagement"
    }
    $headers=@{}
    $headers.Add("Authorization", "Bearer $($Global:AMTSession.Token)")
    
    if(-not $Name -and -not $GUID) {
        $returnArray = @()
        $ResponseArray = Invoke-RestMethod -Uri ("https://" + $Global:AMTSession.Address + "/mps/api/v1/devices/") -Method GET -Headers $headers

        foreach($Response in $ResponseArray){
            $returnObject = New-Object -TypeName PSObject -Property @{
                "GUID" = $Response.GUID
                "Hostname" = $Response.hostname
                "Tags" = $Response.tags
                "MPSInstance" = $Response.MPSInstance
                "ConnectionStatus" = $Response.ConnectionStatus
                "MPSUsername" = $Response.MPSUsername
                "TenantID" = $Response.tenantid
            }
            $returnArray += $returnObject
        }
        return $returnArray
    }

    if($null -ne $Name -and  $Name -ne ""){
        $returnArray = @()
        $ResponseArray = Invoke-RestMethod -Uri ("https://" + $Global:AMTSession.Address + "/mps/api/v1/devices/") -Method GET -Headers $headers
        
        foreach($Response in $ResponseArray){
            $returnObject = New-Object -TypeName PSObject -Property @{
                "GUID" = $Response.GUID
                "Hostname" = $Response.hostname
                "Tags" = $Response.tags
                "MPSInstance" = $Response.MPSInstance
                "ConnectionStatus" = $Response.ConnectionStatus
                "MPSUsername" = $Response.MPSUsername
                "TenantID" = $Response.tenantid
            }
            $returnArray += $returnObject
        }
        return $returnArray | Where-Object {$_.hostname -eq $Name}
    }

    if($null -ne $GUID -and $GUID -ne ""){
        return (Invoke-RestMethod -Uri ("https://" + $Global:AMTSession.Address + "/mps/api/v1/devices/$GUID") -Method GET -Headers $headers)
    }
}