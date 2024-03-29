#
# Modulmanifest für das Modul "PowerAMT"
#
# Generiert von: Michael Mumenthaler
#
# Generiert am: 10.08.2022
#

@{

    # Die diesem Manifest zugeordnete Skript- oder Binärmoduldatei.
    RootModule = 'PowerAMT.psm1'

    # Die Versionsnummer dieses Moduls
    ModuleVersion = '<ModuleVersion>'

    # ID zur eindeutigen Kennzeichnung dieses Moduls
    GUID = '1b2204d2-02ae-4edf-9be8-949366a1458c'

    # Autor dieses Moduls
    Author = 'Michael Mumenthaler'

    # Unternehmen oder Hersteller dieses Moduls
    CompanyName = 'Netrics Thun AG'

    # Urheberrechtserklärung für dieses Modul
    Copyright = '(c) 2023 Michael Mumenthaler. Alle Rechte vorbehalten.'

    # Beschreibung der von diesem Modul bereitgestellten Funktionen
    Description = 'PowerShell module to manage AMT Devices with the Open AMT Cloud Toolkit API'

    # Die für dieses Modul mindestens erforderliche Version des Windows PowerShell-Moduls
    PowerShellVersion = '5.1'

    # Aus diesem Modul zu exportierende Funktionen. Um optimale Leistung zu erzielen, verwenden Sie keine Platzhalter und löschen den Eintrag nicht. Verwenden Sie ein leeres Array, wenn keine zu exportierenden Funktionen vorhanden sind.
    FunctionsToExport = '*'

    # HelpInfo URI für dieses Modul
    HelpInfoURI = 'https://github.com/netricsag/PowerAMT'

    PrivateData = @{
        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags = @('AMT','intel','OpenAMT','OACT', 'vPro')

            # A URL to the license for this module.
            LicenseUri = 'https://github.com/netricsag/PowerAMT/blob/main/LICENSE'
        }
    }

}

