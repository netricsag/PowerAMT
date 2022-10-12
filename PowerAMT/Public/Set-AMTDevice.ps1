function Set-AMTDevice {
    <#
        .SYNOPSIS
        Change the name or tags of an AMT device.
        
        .DESCRIPTION
        Change the name or tags of an AMT device. If tags is set to $null, all tags will be removed.
        
        .PARAMETER GUID
        Specify a device GUID to as an identifier to which device should be changed.

        .PARAMETER Name
        Specify a new name for a device.

        .PARAMETER Tags
        Specify one or more tags to assign to the device.

        .INPUTS
        You can pipe one or more device names into Set-AMTDevice.

        .OUTPUTS
        System.Object

        .EXAMPLE
        PS> Set-AMTDevice -GUID 1ada9c84-780e-4ccc-831c-0edb26994b18 -Name ClientLondon01 -Tags "London","Store01"

        guid             : 1ada9c84-780e-4ccc-831c-0edb26994b18
        hostname         : ClientLondon01
        tags             : {London, Store01}
        mpsInstance      : mps
        connectionStatus : True
        mpsusername      : admin
        tenantId         : 

        .EXAMPLE
        Remove all tags of a device
        PS> Set-AMTDevice -GUID 1ada9c84-780e-4ccc-831c-0edb26994b18 -Tags $null

        TenantID         :
        Tags             : {}
        Hostname         : Client-01
        MPSInstance      : mps
        ConnectionStatus : True
        MPSUsername      : admin
        GUID             : 1ada9c84-780e-4ccc-831c-0edb26994b18

        .EXAMPLE
        PS> Get-AMTDevice | Set-AMTDevice -Tags "NewYork","LAN_123","Register"

        TenantID         :
        Tags             : {NewYork,LAN_123,Register}
        Hostname         : Client-01
        MPSInstance      : mps
        ConnectionStatus : True
        MPSUsername      : admin
        GUID             : 1ada9c84-780e-4ccc-831c-0edb26994b18

        TenantID         :
        Tags             : {NewYork,LAN_123,Register}
        Hostname         : Client-02
        MPSInstance      : mps
        ConnectionStatus : True
        MPSUsername      : admin
        GUID             : 93525960-b4b5-4148-81e3-48a3d214a637

        ...

        .LINK
        Online version: https://github.com/netricsag/PowerAMT/tree/main/Docs

    #>
    param(
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][string[]]$GUID,
        [string] $Name,
        [string[]] $Tags
    )

    begin {
        if($null -eq $Global:AMTSession){
            throw "No active AMT session. Create a session first with Connect-AMTManagement"
        }
    }
    process {

        foreach($device in $GUID){
            $headers=@{}
            $headers.Add("Authorization", "Bearer $($Global:AMTSession.Token)")
            $headers.Add("Content-Type", "application/json")
    
            $body = @{
                "guid"=$device
            }
    
            if($Name -ne "" -and $null -ne $Name){
                $body | Add-Member -NotePropertyName "hostname" -NotePropertyValue $Name
            }
    
            if($Tags.Count -gt 0){
                $body | Add-Member -NotePropertyName "tags" -NotePropertyValue $Tags
            }
    
            if($null -eq $Tags){
                $body | Add-Member -NotePropertyName "tags" -NotePropertyValue @()
            }
    
            $body = $body | ConvertTo-Json
    
            if($null -ne $GUID -and $GUID -ne ""){
                $uri = "https://"+ $Global:AMTSession.Address + "/mps/api/v1/devices"

                if ($PSVersionTable.PSVersion.Major -le 5){
                    $Response = Invoke-RestMethod -Uri $uri -Method PATCH -Headers $headers -ContentType 'application/json' -Body $body
                } else {
                    $Response = Invoke-RestMethod -Uri $uri -Method PATCH -Headers $headers -ContentType 'application/json' -Body $body -SkipCertificateCheck
                }

                return $Response
            }
        }
    }

}