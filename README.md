# PowerAMT

## Overview

This PowerShell module is a simple wrapper for the [Intel Open AMT Cloud Toolkit](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit) API.
It serves to make the API interaction and automation with PowerShell simpler.

In the current build only MPS functions (device management) are supported. RPS functions will be implemented in a later stage.

## Requirements

- PowerShell 5 or higher
- [Intel Open AMT Cloud Toolkit](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit)

## Installation

If you have the PowerShellGet module installed or PowerShell 5 or higher you can enter the following command:

```powershell
C:\> Install-Module -Name PowerAMT
```

## Maintainer

- [Michael Mumenthaler]("https://github.com/michaelmumenthaler") [![https://github.com/falkheiland][github-fh-badge]][github-fh]

## Todos:

- Implement Set-AMTDevice function to update device details
- Implement RPS functions

[psgallery-dl-badge]: https://img.shields.io/powershellgallery/dt/PowerAMT.svg?logo=powershell
[powershell-gallery]: https://www.powershellgallery.com/packages/PowerAMT/
