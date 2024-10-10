# Ensure the script is running with administrative privileges
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Requesting administrative privileges..." -ForegroundColor Yellow
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

# Set error action preference to stop on error
$ErrorActionPreference = "Stop"

# Enable TLS 1.2 for compatibility with older clients
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

# Define hosts file location
$hostsFile = "$env:SystemRoot\System32\drivers\etc\hosts"

# Backup the original hosts file
Copy-Item -Path $hostsFile -Destination "$hostsFile.bak" -Force

# Function to add domains to the hosts file
function Add-HostEntries {
    param (
        [string[]]$domains
    )
    foreach ($domain in $domains) {
        $entry = "127.0.0.1 $domain"
        if (-not (Select-String -Path $hostsFile -Pattern $entry -Quiet)) {
            Add-Content -Path $hostsFile -Value $entry
            Write-Host "Blocked: $domain" -ForegroundColor Green
        } else {
            Write-Host "$domain is already blocked." -ForegroundColor Yellow
        }
    }
}

# CorelDRAW domains to block
$corelDomains = @(
    "corel.com", "apps.corel.com", "mc.corel.com", "iws.corel.com", "origin.corel.com"
)

# Adobe domains to block
$adobeDomains = @(
    "activate.adobe.com", "practivate.adobe.com", "ereg.adobe.com", "wip3.adobe.com", "3dns-3.adobe.com", 
    "3dns-2.adobe.com", "adobe-dns.adobe.com", "adobe-dns-2.adobe.com", "adobe-dns-3.adobe.com", 
    "ereg.wip3.adobe.com", "activate.wip3.adobe.com", "na2m-pr.licenses.adobe.com", 
    "hlrcv.stage.adobe.com", "lmlicenses.wip4.adobe.com", "ims-na1.adobelogin.com", "ccmdls.adobe.com", 
    "swupmf.adobe.com", "swupdl.adobe.com", "prod-rel-ffc-ccm.oobesaas.adobe.com", 
    "lm.licenses.adobe.com", "na1r.services.adobe.com", "oobesaas.adobe.com"
)

# Add CorelDRAW domains to hosts file
Write-Host "Blocking CorelDRAW domains..." -ForegroundColor Cyan
Add-HostEntries -domains $corelDomains

# Add Adobe domains to hosts file
Write-Host "Blocking Adobe domains..." -ForegroundColor Cyan
Add-HostEntries -domains $adobeDomains

# Flush DNS cache
Write-Host "Flushing DNS cache..." -ForegroundColor Cyan
ipconfig /flushdns | Out-Null

Write-Host "CorelDRAW and Adobe domains blocked successfully!" -ForegroundColor Green
