[CmdletBinding()]
param (
    $string
)

New-Item -Path "C:\$string"