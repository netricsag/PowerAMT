function Get-AMTDeviceBootOptions {
    param (
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)][string]$GUID
    )
    begin {
        if($null -eq $Global:AMTSession){
            throw "No active AMT session. Create a session first with Connect-AMTManagement"
        }
    }
    
    process {
        $headers=@{}
        $headers.Add("Authorization", "Bearer $($Global:AMTSession.Token)")
    
        if($null -ne $GUID -and $GUID -ne ""){
            return (Invoke-RestMethod -Uri ("https://" + $Global:AMTSession.Address + "/mps/api/v1/amt/power/capabilities/$GUID") -Method GET -Headers $headers)
        }
    }
}