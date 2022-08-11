# PowerAMT

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/netricsag/PowerAMT/CI)
![GitHub all releases](https://img.shields.io/github/downloads/netricsag/PowerAMT/total?label=Downloads&logo=github)
![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/PowerAMT?label=Downloads&logo=powershell)
![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/PowerAMT?label=PowerShell%20Gallery&logo=powerShell)

## Overview

This PowerShell module is a simple wrapper for the [Intel Open AMT Cloud Toolkit](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit) API.
It serves to make the API interaction and automation with PowerShell simpler.

In the current build only MPS functions (device management) are supported. RPS functions will be implemented in a later stage.

## Requirements

- PowerShell 5.1 or higher (Version 3 might work but it's not tested and not supported)
- [Intel Open AMT Cloud Toolkit](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit)

## Installation

If you have the PowerShellGet module installed or PowerShell 5.1 or higher you can enter the following command:

```powershell
C:\> Install-Module -Name PowerAMT
```

## Documentation

The documentation is currently only available via the Get-Help command.

```PowerShell
PS> Get-Help Get-AMTDevices
```

## Maintainer

- [Michael Mumenthaler](https://github.com/michaelmumenthaler)

## Todos:

- Implement RPS functions
