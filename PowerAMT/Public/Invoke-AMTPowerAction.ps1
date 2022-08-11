function Invoke-AMTPowerAction {
    <#
        .SYNOPSIS
        Send a power action to an AMT device.
        
        .DESCRIPTION
        Send a power action to an AMT device. Possible power actions can be listed with Get-AMTDeviceBootOptions.

        .PARAMETER GUID
        Specify a device GUID to send the power action to.

        .PARAMETER PowerAction
        Specify a power action which should be sent to the specified device.

        .INPUTS
        You can pipe one or more device GUIDs into Invoke-AMTPowerAction.

        .OUTPUTS
        System.Object
            GUID: Device GUID
            ReturnValue: Status number of command
            ReturnValueStr: Status message of command

        .EXAMPLE
        Reset device to BIOS:
        PS> Invoke-AMTPowerAction -GUID 1ada9c84-780e-4ccc-831c-0edb26994b18 -PowerAction 101

        GUID                                 ReturnValue ReturnValueStr
        ----                                 ----------- --------------
        1ada9c84-780e-4ccc-831c-0edb26994b18           0 SUCCESS       

        .EXAMPLE
        Boot all devices to PXE:
        PS> Get-AMTDevice | Invoke-AMTPowerAction -PowerAction 401

        GUID                                   ReturnValue ReturnValueStr
        ----                                   ----------- --------------
        1ada9c84-780e-4ccc-831c-0edb26994b18           0 SUCCESS       
        39270bdb-9488-4695-8f8f-0d9e5366c54e           0 SUCCESS       

        .LINK
        Online version: https://github.com/netricsag/PowerAMT/tree/main/Docs

    #>
    param(
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][string[]]$GUID,
        [Parameter(Mandatory)][int]$PowerAction
    )

    begin {
        if($null -eq $Global:AMTSession){
            throw "No active AMT session. Create a session first with Connect-AMTManagement"
        }
    }
    process {
        foreach($device in $GUID) {
            $headers=@{}
            $headers.Add("Authorization", "Bearer $($Global:AMTSession.Token)")
        
            $Body = @{
                "action"=$PowerAction
                "useSOL"=$false
            } | ConvertTo-Json
        
            if($null -ne $GUID -and $GUID -ne ""){
                $Response = (Invoke-RestMethod -Uri ("https://" + $Global:AMTSession.Address + "/mps/api/v1/amt/power/bootoptions/$device") -Method POST `
                -UseBasicParsing -ContentType 'application/json' -Headers $headers -body $body).body
                $ReturnObject = New-Object -TypeName PSObject -Property @{
                    GUID = $device
                    ReturnValue = $Response.ReturnValue
                    ReturnValueStr = $Response.ReturnValueStr
                }
                return $ReturnObject
            }
        }
    }
}