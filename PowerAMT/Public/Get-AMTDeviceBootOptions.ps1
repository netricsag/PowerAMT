function Get-AMTDeviceBootOptions {
    <#
        .SYNOPSIS
        List available bootoptions for a device.
        
        .DESCRIPTION
        List available bootoptions for a device. The bootoption IDs can be used with Invoke-AMTPowerAction.

        .PARAMETER GUID
        Specify a device GUID to display a device's available boot options.

        .INPUTS
        You can pipe one or more device GUIDs into Get-AMTDeviceBootOptions.

        .OUTPUTS
        System.Object

        .EXAMPLE
        PS> Get-AMTDeviceBootOptions -GUID 1ada9c84-780e-4ccc-831c-0edb26994b18

        Power up                 : 2
        Power cycle              : 5
        Power down               : 8
        Reset                    : 10
        Soft-off                 : 12
        Soft-reset               : 14
        Sleep                    : 4
        Hibernate                : 7
        Power up to BIOS         : 100
        Reset to BIOS            : 101
        Reset to IDE-R Floppy    : 200
        Power on to IDE-R Floppy : 201
        Reset to IDE-R CDROM     : 202
        Power on to IDE-R CDROM  : 203
        Reset to PXE             : 400
        Power on to PXE          : 401

        .EXAMPLE
        PS> Get-AMTDevice | Get-AMTDeviceBootOptions

        Power up                 : 2
        Power cycle              : 5
        Power down               : 8
        Reset                    : 10
        Soft-off                 : 12
        Soft-reset               : 14
        Sleep                    : 4
        Hibernate                : 7
        Power up to BIOS         : 100
        Reset to BIOS            : 101
        Reset to IDE-R Floppy    : 200
        Power on to IDE-R Floppy : 201
        Reset to IDE-R CDROM     : 202
        Power on to IDE-R CDROM  : 203
        Reset to PXE             : 400
        Power on to PXE          : 401

        Power up                 : 2
        Power cycle              : 5
        Power down               : 8
        Reset                    : 10
        Soft-off                 : 12
        Soft-reset               : 14
        Sleep                    : 4
        Hibernate                : 7
        Power up to BIOS         : 100
        Reset to BIOS            : 101
        Reset to IDE-R Floppy    : 200
        Power on to IDE-R Floppy : 201
        Reset to IDE-R CDROM     : 202
        Power on to IDE-R CDROM  : 203
        Reset to PXE             : 400
        Power on to PXE          : 401

        ...

        .EXAMPLE
        PS> "1ada9c84-780e-4ccc-831c-0edb26994b18" | Get-AMTDeviceBootOptions

        Power up                 : 2
        Power cycle              : 5
        Power down               : 8
        Reset                    : 10
        Soft-off                 : 12
        Soft-reset               : 14
        Sleep                    : 4
        Hibernate                : 7
        Power up to BIOS         : 100
        Reset to BIOS            : 101
        Reset to IDE-R Floppy    : 200
        Power on to IDE-R Floppy : 201
        Reset to IDE-R CDROM     : 202
        Power on to IDE-R CDROM  : 203
        Reset to PXE             : 400
        Power on to PXE          : 401


        .LINK
        Online version: https://github.com/netricsag/PowerAMT/tree/main/Docs

    #>
    param (
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][string]$GUID
    )
    begin {
        if($null -eq $Global:AMTSession){
            throw "No active AMT session. Create a session first with Connect-AMTManagement"
        }
    }
    
    process {
        $headers=@{}
        $headers.Add("Authorization", "Bearer $($Global:AMTSession.Token)")
    
        $uri = "https://" + $Global:AMTSession.Address + "/mps/api/v1/amt/power/capabilities/$GUID"

        if($null -ne $GUID -and $GUID -ne ""){
            if ($PSVersionTable.PSVersion.Major -le 5) {
                $Response = Invoke-RestMethod -Uri $uri -Method GET -Headers $headers
            } else {
                $Response = Invoke-RestMethod -Uri $uri -Method GET -Headers $headers -SkipCertificateCheck
            }
            return $Response
        }
    }
}