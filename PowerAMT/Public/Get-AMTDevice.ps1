function Get-AMTDevice {
    <#
        .SYNOPSIS
        List one or multiple devices which are registered on the Open AMT MPS server.
        
        .DESCRIPTION
        List one or multiple devices which are registered on the Open AMT MPS server.

        .PARAMETER Name
        Specify a device name to only return a specific device.

        .PARAMETER GUID
        Specify a device GUID to only return a specific device.

        .PARAMETER Limit
        By default, 1000 devices are returned. Use this parameter to limit the number of devices returned.

        .INPUTS
        You can pipe one or more device names into Get-AMTDevice.

        .OUTPUTS
        System.Object

        .EXAMPLE
        PS> Get-AMTDevice

        TenantID         :
        Tags             : {Store1,London}
        Hostname         : Client-01
        MPSInstance      : mps
        ConnectionStatus : True
        MPSUsername      : admin
        GUID             : 1ada9c84-780e-4ccc-831c-0edb26994b18

        TenantID         :
        Tags             : {Store2,NewYork}
        Hostname         : Device-09
        MPSInstance      :
        ConnectionStatus : False
        MPSUsername      : admin
        GUID             : 39270bdb-9488-4695-8f8f-0d9e5366c54e
        ...

        .EXAMPLE
        PS> Get-AMTDevice -Name Client-01

        TenantID         :
        Tags             : {Store1,London}
        Hostname         : Client-01
        MPSInstance      : mps
        ConnectionStatus : True
        MPSUsername      : admin
        GUID             : 1ada9c84-780e-4ccc-831c-0edb26994b18

        .EXAMPLE
        PS> Get-AMTDevice -GUID 1ada9c84-780e-4ccc-831c-0edb26994b18

        TenantID         :
        Tags             : {Store1,London}
        Hostname         : Client-01
        MPSInstance      : mps
        ConnectionStatus : True
        MPSUsername      : admin
        GUID             : 1ada9c84-780e-4ccc-831c-0edb26994b18

        .EXAMPLE
        PS> "Client-01","Client-02" | Get-AMTDevice

        TenantID         :
        Tags             : {Store1,London}
        Hostname         : Client-01
        MPSInstance      : mps
        ConnectionStatus : True
        MPSUsername      : admin
        GUID             : 1ada9c84-780e-4ccc-831c-0edb26994b18

        TenantID         :
        Tags             : {Store2,London}
        Hostname         : Client-02
        MPSInstance      : mps
        ConnectionStatus : True
        MPSUsername      : admin
        GUID             : 93525960-b4b5-4148-81e3-48a3d214a637

        .LINK
        Online version: https://github.com/netricsag/PowerAMT/tree/main/Docs

    #>

    param (
        [Parameter(ValueFromPipeline,ValueFromPipelineByPropertyName)][string]$Name,
        [Parameter(ValueFromPipelineByPropertyName)][string]$GUID,
        [int]$Limit = 1000,
        [int]$TimeoutSec = 5
    )

    begin {
        if($null -eq $Global:AMTSession){
            throw "No active AMT session. Create a session first with Connect-AMTManagement"
        }
    }
    
    process {
        $headers=@{}
        $headers.Add("Authorization", "Bearer $($Global:AMTSession.Token)")
        
        if(-not $Name -and -not $GUID) {
            $returnArray = @()
            if($PSVersionTable.PSVersion.Major -le 5) {
                $ResponseArray = Invoke-RestMethod -Uri ("https://" + $Global:AMTSession.Address + "/mps/api/v1/devices?%24top=$Limit") -Method GET -UseBasicParsing -Headers $headers -TimeoutSec $TimeoutSec
            } else {
                $ResponseArray = Invoke-RestMethod -Uri ("https://" + $Global:AMTSession.Address + "/mps/api/v1/devices?%24top=$Limit") -Method GET -UseBasicParsing -Headers $headers -SkipCertificateCheck -TimeoutSec $TimeoutSec
            }
            foreach($Response in $ResponseArray){
                $returnObject = New-Object -TypeName PSObject -Property @{
                    "GUID" = $Response.GUID
                    "Hostname" = $Response.hostname
                    "Tags" = $Response.tags
                    "MPSInstance" = $Response.MPSInstance
                    "ConnectionStatus" = $Response.ConnectionStatus
                    "MPSUsername" = $Response.MPSUsername
                    "TenantID" = $Response.tenantid
                }
                $returnArray += $returnObject
            }
            return $returnArray
        }
    
        if($null -ne $Name -and  $Name -ne ""){
            $uri = "https://" + $Global:AMTSession.Address + "/mps/api/v1/devices?%24top=$Limit"
            $returnArray = @()

            if($PSVersionTable.PSVersion.Major -le 5) {
                $ResponseArray = Invoke-RestMethod -Uri $uri -Method GET -UseBasicParsing -Headers $headers -TimeoutSec $TimeoutSec
            } else {
                $ResponseArray = Invoke-RestMethod -Uri $uri -Method GET -UseBasicParsing -Headers $headers -SkipCertificateCheck -TimeoutSec $TimeoutSec
            }
            foreach($Response in $ResponseArray){
                $returnObject = New-Object -TypeName PSObject -Property @{
                    "GUID" = $Response.GUID
                    "Hostname" = $Response.hostname
                    "Tags" = $Response.tags
                    "MPSInstance" = $Response.MPSInstance
                    "ConnectionStatus" = $Response.ConnectionStatus
                    "MPSUsername" = $Response.MPSUsername
                    "TenantID" = $Response.tenantid
                }
                $returnArray += $returnObject
            }
            return $returnArray | Where-Object {$_.hostname -eq $Name}
        }
    
        if($null -ne $GUID -and $GUID -ne ""){
            $uri = "https://" + $Global:AMTSession.Address + "/mps/api/v1/devices/" + $GUID
            if ($psversiontable.PSVersion.Major -le 5) {
                $Response = Invoke-RestMethod -Uri $uri -Method GET -UseBasicParsing -Headers $headers -TimeoutSec $TimeoutSec
            } else {
                $Response = Invoke-RestMethod -Uri $uri -Method GET -UseBasicParsing -Headers $headers -SkipCertificateCheck -TimeoutSec $TimeoutSec
            }
            return $Response
        }
    }
    
}