[CmdletBinding()]
param (
    $string
)

if (!$string) { $string = 'test' }
New-Item -Path "C:\$string" -ItemType Folder
