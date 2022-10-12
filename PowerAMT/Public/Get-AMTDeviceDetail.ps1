function Get-AMTDeviceDetail {
    <#
        .SYNOPSIS
        List details about a device.
        
        .DESCRIPTION
        List details about a device. The list contains Hardware info, BIOS info and more, but it's a bit clustered.

        .PARAMETER GUID
        Specify a device GUID to display details about this device.

        .INPUTS
        You can pipe one or more device GUIDs into Get-AMTDeviceDetail.

        .OUTPUTS
        System.Object

        .EXAMPLE
        PS> Get-AMTDeviceDetail -GUID 1ada9c84-780e-4ccc-831c-0edb26994b18

        CIM_ComputerSystemPackage : @{response=; responses=System.Object[]; status=200}
        CIM_SystemPackaging       : @{responses=System.Object[]; status=200}
        CIM_Chassis               : @{response=; responses=System.Object[]; status=200}
        CIM_Chip                  : @{responses=System.Object[]; status=200}
        CIM_Card                  : @{response=; responses=System.Object[]; status=200}
        CIM_BIOSElement           : @{response=; responses=System.Object[]; status=200}
        CIM_Processor             : @{responses=System.Object[]; status=200}
        CIM_PhysicalMemory        : @{responses=System.Object[]; status=200}
        CIM_MediaAccessDevice     : @{responses=System.Object[]; status=200}
        CIM_PhysicalPackage       : @{responses=System.Object[]; status=200}

        .EXAMPLE
        PS> Get-AMTDevice -Name Client-01 | Get-AMTDeviceDetail

        CIM_ComputerSystemPackage : @{response=; responses=System.Object[]; status=200}
        CIM_SystemPackaging       : @{responses=System.Object[]; status=200}
        CIM_Chassis               : @{response=; responses=System.Object[]; status=200}
        CIM_Chip                  : @{responses=System.Object[]; status=200}
        CIM_Card                  : @{response=; responses=System.Object[]; status=200}
        CIM_BIOSElement           : @{response=; responses=System.Object[]; status=200}
        CIM_Processor             : @{responses=System.Object[]; status=200}
        CIM_PhysicalMemory        : @{responses=System.Object[]; status=200}
        CIM_MediaAccessDevice     : @{responses=System.Object[]; status=200}
        CIM_PhysicalPackage       : @{responses=System.Object[]; status=200}

        .LINK
        Online version: https://github.com/netricsag/PowerAMT/tree/main/Docs

    #>
    param (
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][string]$GUID
    )

    if($null -eq $Global:AMTSession){
        throw "No active AMT session. Create a session first with Connect-AMTManagement"
    }
    $headers=@{}
    $headers.Add("Authorization", "Bearer $($Global:AMTSession.Token)")

    if($null -ne $GUID -and $GUID -ne ""){
        $uri = "https://" + $Global:AMTSession.Address + "/mps/api/v1/amt/hardwareInfo/$GUID"
        
        if ($PSVersionTable.PSVersion.Major -le 5) {
            $response = Invoke-WebRequest -Uri $uri -Headers $headers -Method GET
        } else {
            $response = Invoke-WebRequest -Uri $uri -Headers $headers -Method GET -SkipCertificateCheck
        }

        return $response.content | ConvertFrom-Json
    }
}