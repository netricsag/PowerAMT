function Disconnect-AMTManagement {
    <#
        .SYNOPSIS
        Remove the AMT session object from the global variable. 
        
        .DESCRIPTION
        The variable $Global:AMTSession will be nulled. The session token however will still be valid, because the API does not support a propper logout method.

        .INPUTS
        None. You cannot pipe objects to Disconnect-AMTManagement.

        .OUTPUTS
        Nothing

        .EXAMPLE
        PS> Disconnect-AMTManagement

        .LINK
        Online version: https://github.com/netricsag/PowerAMT/tree/main/Docs

    #>
    
    $Global:AMTSession = $null
}