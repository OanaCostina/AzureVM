#Change CD drive letter
$driveletter = $args[0]
$drv = Get-WmiObject win32_volume -filter "DriveLetter = `"$driveletter`""
if ($drv) {
$drv.DriveLetter = "L:"
$drv.Put() | out-null
}

$disk = Get-Disk | where partitionstyle -EQ 'raw' 
$disk | Initialize-Disk -PartitionStyle MBR -PassThru | New-Partition -UseMaximumSize -DriveLetter $driveletter[0] | Format-Volume -FileSystem NTFS -NewFileSystemLabel "UserData" -Confirm:$false -Force
