#Change CD drive letter
[CmdletBinding()]
param (
    $map
)

$drives = $map | ConvertFrom-Json
foreach ($drive in $drives) {
    $driveletter = $drive.letter
    $drv = Get-WmiObject win32_volume -filter "DriveLetter = `"$($driveletter):`""
    if ($drv -and ($drv.DriveLetter -eq 'E:')) {
        $drv.DriveLetter = "Z:"
        $drv.Put() | out-null
    }
    $disk = Get-Disk | Select-Object *,@{Name='DiskSize'; Expression = {$_.size/1GB}} | where {$_.partitionstyle -EQ 'raw' -and $_.disksize -eq $drive.size}
    $disk[0] | Initialize-Disk -PartitionStyle MBR -PassThru | New-Partition -UseMaximumSize -DriveLetter $driveletter | Format-Volume -FileSystem NTFS -NewFileSystemLabel "UserData" -Confirm:$false -Force
}
