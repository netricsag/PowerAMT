function Invoke-AMTPowerAction {
    param(
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]$GUID,
        [Parameter(Mandatory)][int]$PowerAction
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
            "action"=$PowerAction
            "useSOL"=$false
        } | ConvertTo-Json
    
        if($null -ne $GUID -and $GUID -ne ""){
            return (Invoke-RestMethod -Uri ("https://" + $Global:AMTSession.Address + "/mps/api/v1/amt/power/bootoptions/$GUID") -Method POST `
            -UseBasicParsing -ContentType 'application/json' -Headers $headers -body $body).body
        }
    }
}