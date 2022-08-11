function Restart-AMTDevice {
    param(
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]$GUID,
        [switch]$Soft
    )
    begin {
        if($null -eq $Global:AMTSession){
            throw "No active AMT session. Create a session first with Connect-AMTManagement"
        }
    }
    
    process {
        $headers=@{}
        $headers.Add("Authorization", "Bearer $($Global:AMTSession.Token)")
    
        $Body = @{
            "action"=if ($soft) {14} else {10}
            "useSOL"=$false
        } | ConvertTo-Json
    
        if($null -ne $GUID -and $GUID -ne ""){
            return (Invoke-RestMethod -Uri ("https://" + $Global:AMTSession.Address + "/mps/api/v1/amt/power/action/$GUID") -Method POST `
            -UseBasicParsing -ContentType 'application/json' -Headers $headers -body $body).body
        }
    }
}