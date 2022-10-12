function Get-AMTDevicePowerState {
    <#
        .SYNOPSIS
        Get current power state of a device.  
        
        .DESCRIPTION
        Gets the current power state of a device. There are several possible power states which are listed bellow:
        "0" = "-"
        "2" = "On"
        "3" = "Sleep (Light)"
        "4" = "Sleep (Deep)"
        "6" = "Off"
        "7" = "Hybernate"
        "8" = "Off (Soft)"
        "9" = "Off (Hard)"
        "13" = "Off (Hard Graceful)"

        .PARAMETER GUID
        Specify a device GUID to display the specified device's power state.

        .INPUTS
        Takes device GUID(s) as pipeline input.

        .OUTPUTS
        System.Object
            An object which contains the device name, power state ID and power state display name.

        .EXAMPLE
        PS> Get-AMTDevicePowerState -GUID 1ada9c84-780e-4ccc-831c-0edb26994b18

        GUID                                 PowerStateDisplayName PowerStateID
        ----                                 --------------------- ------------
        1ada9c84-780e-4ccc-831c-0edb26994b18 Sleep (Deep)                     4

        .EXAMPLE
        PS> Get-AMTDevice | Get-AMTDevicePowerState

        GUID                                 PowerStateDisplayName PowerStateID
        ----                                 --------------------- ------------
        93525960-b4b5-4148-81e3-48a3d214a637 On                               2
        1ada9c84-780e-4ccc-831c-0edb26994b18 Sleep (Deep)                     4

        .LINK
        Online version: https://github.com/netricsag/PowerAMT/tree/main/Docs

    #>
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
            $uri = "https://" + $Global:AMTSession.Address + "/mps/api/v1/amt/power/state/$GUID"
            if ($PSVersionTable.PSVersion.Major -le 5) {
                $CurrentPowerState = (Invoke-RestMethod -Uri $uri -Method GET -Headers $headers).powerstate
            } else {
                $CurrentPowerState = (Invoke-RestMethod -Uri $uri -Method GET -Headers $headers -SkipCertificateCheck).powerstate
            }
            $ReturnObject = New-Object -TypeName psobject -Property @{
                GUID = $GUID
                PowerStateID = $CurrentPowerState
                PowerStateDisplayName = $PossiblePowerStates["$CurrentPowerState"]
            }
            return $ReturnObject | Select-Object GUID,PowerStateDisplayName,PowerStateID
        }
    }
}