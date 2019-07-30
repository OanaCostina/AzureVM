[CmdletBinding()]
param (
    $string
)

if (!$string) { $string = 'test' }
New-Item -Path "C:\Users\BuildAdmin\Desktop\$string" -Type File
