function Get-AMTDeviceDetail {
    param (
        [Parameter(Mandatory)][string]$GUID
    )

    if($null -eq $Global:AMTSession){
        throw "No active AMT session. Create a session first with Connect-AMTManagement"
    }
    $headers=@{}
    $headers.Add("Authorization", "Bearer $($Global:AMTSession.Token)")

    if($null -ne $GUID -and $GUID -ne ""){
        return (Invoke-RestMethod -Uri ("https://" + $Global:AMTSession.Address + "/mps/api/v1/amt/hardwareInfo/$GUID") -Method GET -Headers $headers)
    }
}