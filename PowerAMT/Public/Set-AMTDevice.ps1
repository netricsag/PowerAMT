function Set-AMTDevice {
    param(
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)][string]$GUID,
        [string] $Name,
        [string[]] $Tags
    )

    begin {
        if($null -eq $Global:AMTSession){
            throw "No active AMT session. Create a session first with Connect-AMTManagement"
        }
    }
    process {

        $headers=@{}
        $headers.Add("Authorization", "Bearer $($Global:AMTSession.Token)")
        $headers.Add("Content-Type", "application/json")

        $body = @{
            "guid"=$GUID
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
            return (Invoke-RestMethod -Uri 'https://192.168.200.200/mps/api/v1/devices' -Method PATCH -Headers $headers -ContentType 'application/json' -Body $body)
        }
    }

}