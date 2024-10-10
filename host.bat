@echo off
:: CorelDRAW and Adobe Host Blocker Script

echo Blocking CorelDRAW and Adobe domains...

:: Take ownership of the hosts file
takeown /f %windir%\System32\drivers\etc\hosts
icacls %windir%\System32\drivers\etc\hosts /grant administrators:f

:: Backup the original hosts file
copy %windir%\System32\drivers\etc\hosts %windir%\System32\drivers\etc\hosts.bak

:: Block CorelDRAW domains by redirecting them to 127.0.0.1
echo 127.0.0.1 corel.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 apps.corel.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 mc.corel.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 iws.corel.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 origin.corel.com >> %windir%\System32\drivers\etc\hosts

:: Block Adobe domains by redirecting them to 127.0.0.1
echo 127.0.0.1 activate.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 practivate.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 ereg.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 wip3.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 3dns-3.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 3dns-2.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 adobe-dns.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 adobe-dns-2.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 adobe-dns-3.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 ereg.wip3.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 activate.wip3.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 na2m-pr.licenses.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 hlrcv.stage.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 lmlicenses.wip4.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 na2m-pr.licenses.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 ims-na1.adobelogin.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 ccmdls.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 swupmf.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 swupdl.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 prod-rel-ffc-ccm.oobesaas.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 na2m-pr.licenses.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 hlrcv.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 lm.licenses.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 na1r.services.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 hlrcv.stage.adobe.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 oobesaas.adobe.com >> %windir%\System32\drivers\etc\hosts

:: Flush DNS cache
ipconfig /flushdns

echo CorelDRAW and Adobe domains blocked successfully.
pause
