### Powershell - Umsetzung zu:
###         Deaktivierung der Telemetriekomponente in Windows 10 21H2
### https://www.bsi.bund.de/SharedDocs/Downloads/DE/BSI/Cyber-Sicherheit/SiSyPHus/E20172000_BSI_Win10_AFUNKT_TELE_DEAKTIVIEREN_v1_0.pdf?__blob=publicationFile&v=5
###
### Datum: 23.10.2022

# Schritt 1
Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\DiagTrack\ -Name Start -Value 4
# Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\DiagTrack\ -Name Start

# Schritt 2
Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Diagtrack-Listener\ -Name Start -Value 0
# Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Diagtrack-Listener\ -Name Start

# Schritt 3
Remove-Item "$env:systemroot\System32\LogFiles\WMI\Diagtrack-Listener.etl*"
# Get-ChildItem $env:systemroot\System32\LogFiles\WMI

# Schritt 4
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection\ -name AllowTelemetry -Value 0
# Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection\ -name AllowTelemetry

# Schritt 5
Set-NetFirewallRule -Name "Microsoft-Windows-Unified-Telemetry-Client" -Action Block -Enabled True
#Get-NetFirewallRule -Name "Microsoft-Windows-Unified-Telemetry-Client"

# Schritt 6
New-NetFirewallRule -DisplayName "BlockDiagTrackService" -Name "BlockDiagTrackService" -Direction Outbound -Service "DiagTrack" -Action Block
#Get-NetFirewallRule -Name "BlockDiagTrackService"