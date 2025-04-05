@echo off
setlocal EnableDelayedExpansion

:: name (e.g., Wi-Fi, Ethernet)
set interface="Ethernet"

:: address (locally administered and unicast)
set /a oct1=0x02 + ((%RANDOM% %% 4) * 4)  :: ensures it's 02, 06, 0A, or 0E
set /a oct2=%RANDOM%%%256
set /a oct3=%RANDOM%%%256
set /a oct4=%RANDOM%%%256
set /a oct5=%RANDOM%%%256
set /a oct6=%RANDOM%%%256


for %%A in (%oct1% %oct2% %oct3% %oct4% %oct5% %oct6%) do (
    set hex=0%%~A
    set mac=!mac!!hex:~-2!-
)

set newMAC=!mac:~0,-1!

:: Generated MAC: !newMAC!


netsh interface set interface name=%interface% admin=disable


reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "NetworkAddress" /d !newMAC! /f >nul


netsh interface set interface name=%interface% admin=enable

:: MAC address changed to: !newMAC!
