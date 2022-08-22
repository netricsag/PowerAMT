# PowerAMT

![Github Workflow](https://github.com/netricsag/PowerAMT/actions/workflows/main.yml/badge.svg)
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

## Quickstart

### Installation

If you have the PowerShellGet module installed or PowerShell 5.1 or higher you can enter the following command:

```powershell
C:\> Install-Module -Name PowerAMT
```

### Basic usage

Import module:

```powershell
C:\> Import-Module -Name PowerAMT
```

Create a session:

```powershell
C:\> Connect-AMTManagement -AMTManagementAddress 192.168.1.100 -AMTUsername admin -AMTPassword P@ssw0rd

Token           Address
-----           -------
<JWT Token>     192.168.1.100
```

Retrieve all devices:

```powershell
C:\> Get-AMTDevice

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
```

Start a specific device:

```powershell
C:\> Start-AMTDevice -GUID 1ada9c84-780e-4ccc-831c-0edb26994b18

GUID                                 ReturnValue ReturnValueStr
----                                 ----------- --------------
1ada9c84-780e-4ccc-831c-0edb26994b18           0 SUCCESS
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
