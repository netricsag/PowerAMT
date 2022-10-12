function Start-AMTDevice {
    <#
        .SYNOPSIS
        Start an AMT device.
        
        .DESCRIPTION
        Start an AMT device.

        .PARAMETER GUID
        Specify a device GUID to start.

        .INPUTS
        You can pipe one or more device GUIDs into Start-AMTDevice.

        .OUTPUTS
        System.Object
            GUID: Device GUID
            ReturnValue: Status number of command
            ReturnValueStr: Status message of command

        .EXAMPLE
        PS> Start-AMTDevice -GUID 1ada9c84-780e-4ccc-831c-0edb26994b18

        GUID                                 ReturnValue ReturnValueStr
        ----                                 ----------- --------------
        1ada9c84-780e-4ccc-831c-0edb26994b18           0 SUCCESS       

        .EXAMPLE
        PS> Get-AMTDevice | Start-AMTDevice

        GUID                                   ReturnValue ReturnValueStr
        ----                                   ----------- --------------
        1ada9c84-780e-4ccc-831c-0edb26994b18           0 SUCCESS       
        39270bdb-9488-4695-8f8f-0d9e5366c54e           0 SUCCESS       

        .LINK
        Online version: https://github.com/netricsag/PowerAMT/tree/main/Docs

    #>
    param(
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][string[]] $GUID
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
                "action"=2
                "useSOL"=$false
            } | ConvertTo-Json
        
            if($null -ne $GUID -and $GUID -ne ""){

                $uri = "https://" + $Global:AMTSession.Address + "/mps/api/v1/amt/power/action/$device"

                if($PSVersionTable.PSVersion.Major -le 5){
                    $Response = (Invoke-RestMethod -Uri $uri -Method POST `
                    -UseBasicParsing -ContentType 'application/json' -Headers $headers -body $body).body
                } else {
                    $Response = (Invoke-RestMethod -Uri $uri -Method POST `
                    -UseBasicParsing -ContentType 'application/json' -Headers $headers -body $body -SkipCertificateCheck).body
                }
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