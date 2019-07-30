#Change CD drive letter
[CmdletBinding()]
param (
    $drvLetter
)

$driveletter = $drvLetter
$drv = Get-WmiObject win32_volume -filter "DriveLetter = `"$($driveletter):`""
if ($drv) {
$drv.DriveLetter = "Z:"
$drv.Put() | out-null
}

$disk = Get-Disk | where partitionstyle -EQ 'raw' 
$disk | Initialize-Disk -PartitionStyle MBR -PassThru | New-Partition -UseMaximumSize -DriveLetter $driveletter | Format-Volume -FileSystem NTFS -NewFileSystemLabel "UserData" -Confirm:$false -Force
