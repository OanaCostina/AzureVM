#Change CD drive letter
$driveletter = arg[0]
$drv = Get-WmiObject win32_volume -filter "DriveLetter = `"$driveletter`""
if ($drv) {
$drv.DriveLetter = "L:"
$drv.Put() | out-null
}

Initialize-Disk -VirtualDisk (Get-VirtualDisk -FriendlyName UserData) | New-Partition -UseMaximumSize -DriveLetter $driveletter
