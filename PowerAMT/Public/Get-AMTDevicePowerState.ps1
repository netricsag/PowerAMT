function Get-AMTDevicePowerState {
    param (
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)][string]$GUID
    )
    begin {
        $PossiblePowerStates = @{
            "0"= "-";
            "2"= "On";
            "3"= "Sleep (Light)";
            "4"= "Sleep (Deep)";
            "6"= "Off";
            "7"= "Hybernate";
            "8"= "Off (Soft)";
            "9"= "Off (Hard)";
            "13"= "Off (Hard Graceful)";
          }
    
        if($null -eq $Global:AMTSession){
            throw "No active AMT session. Create a session first with Connect-AMTManagement"
        }
    }
    process {
        $headers=@{}
        $headers.Add("Authorization", "Bearer $($Global:AMTSession.Token)")

        if($null -ne $GUID -and $GUID -ne ""){
            $CurrentPowerState = (Invoke-RestMethod -Uri ("https://" + $Global:AMTSession.Address + "/mps/api/v1/amt/power/state/$GUID") -Method GET -Headers $headers).powerstate
            $ReturnObject = New-Object -TypeName psobject -Property @{
                GUID = $GUID
                PowerStateID = $CurrentPowerState
                PowerStateDisplayName = $PossiblePowerStates["$CurrentPowerState"]
            }
            return $ReturnObject | Select-Object GUID,PowerStateDisplayName,PowerStateID
        }
    }
}