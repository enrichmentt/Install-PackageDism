# Install SNMP Provider without internet from iso image
# Download from internet en_windows_10_features_on_demand_part_1_version_1903_x64_dvd_1076e85a.iso

# Set Variables
$PathIso = "C:\Windows\Temp\"
$FileNameIso = "en_windows_10_features_on_demand_part_1_version_1903_x64_dvd_1076e85a.iso"
$FullPathIso = [System.IO.Path]::Combine($PathIso, $FileNameIso)

#Mount ISO disk
$DriveLetter = Mount-DiskImage -ImagePath $FullPathIso | Get-DiskImage | Get-Volume

#Start DISM with agrument list
$ArgumentList = "/Online /Add-Package /PackagePath:$($DriveLetter.DriveLetter):\Microsoft-Windows-SNMP-Client-Package~31bf3856ad364e35~amd64~~.cab"
Start-Process "DISM" -Verb runas -ArgumentList $ArgumentList -Wait -WindowStyle Hidden

$ArgumentList = "/Online /Add-Package /PackagePath:$($DriveLetter.DriveLetter):\Microsoft-Windows-WMI-SNMP-Provider-Client-Package~31bf3856ad364e35~amd64~~.cab"
Start-Process "DISM" -Verb runas -ArgumentList $ArgumentList -Wait  -WindowStyle Hidden


#UnMount ISO disk
Dismount-DiskImage -ImagePath $FullPathIso

#Remove ISO file
Remove-Item $FullPathIso
