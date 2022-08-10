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
        return Invoke-RestMethod -Uri ("https://" + $Global:AMTSession.Address + "/mps/api/v1/devices/") -Method GET -Headers $headers | Format-Table *
    }

    if($null -ne $Name -and  $Name -ne ""){
        return ((Invoke-RestMethod -Uri ("https://" + $Global:AMTSession.Address + "/mps/api/v1/devices/") -Method GET -Headers $headers) | Where-Object {$_.hostname -eq $Name}) | Format-Table *
    }

    if($null -ne $GUID -and $GUID -ne ""){
        return (Invoke-RestMethod -Uri ("https://" + $Global:AMTSession.Address + "/mps/api/v1/devices/$GUID") -Method GET -Headers $headers) | Format-Table *
    }
}