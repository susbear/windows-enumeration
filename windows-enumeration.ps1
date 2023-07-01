# This tool serves as a privilege escalation enumeration script after getting initial shell on Windows
Write-Output "[*] Get current location"
Get-Location

Write-Output "[*] Show environment variables"
Get-Item -Path Env:*

Write-Output "[*] Show Powershell history file content"
Get-Content -Path "$env:APPDATA\Microsoft\Windows\Powershell\PSReadline\ConsoleHost_history.txt"


Write-Output "[*] Get SQL and backup files"
Get-ChildItem -Path C:\ -Include "*.bak*" -Recurse -ErrorAction SilentlyContinue
Get-ChildItem -Path C:\ -Include "*.sql*" -Recurse -ErrorAction SilentlyContinue

Write-Output "[*] Get local users and check if password is required"
Get-LocalUser
Get-LocalUser | Select-Object -Property Name,PasswordRequired

Write-Output "[*] Get AD users"
Get-ADUser

Write-Output "[*] Get local groups"
Get-LocalGroup

Write-Output "[*] Get all network interfaces and show IP addresses"
Get-NetIPAddress

Write-Output "[*] Get listening ports"
Get-NetTCPConnection -State Listen | Select-Object -Property LocalPort

Write-Output "[*] Get all services"
Get-Service | Sort-Object

Write-Output "[*] Show processes"
Get-Process | Sort-Object

Write-Output "[*] Show all files with API_KEY strings"
Get-ChildItem -Path C:\ -Recurse | Select-String "API_KEY" | Select-Path
Write-Output "[*] Show all files with password strings"
Get-ChildItem -Path C:\ -Recurse | Select-String "password" | Select-Path

Write-Output "[*] Show scheduled tasks"
Get-ScheduledTask

Write-Output "[*] Get owner of C:\ path"
Get-ACL C:\

