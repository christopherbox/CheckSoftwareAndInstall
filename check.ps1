# Script used to check if The Microsoft Visual C++ 2010 Redistributable is installed on the server
# This step is necessary for the CPP service to start.
#
$installListx86 = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object {$_.DisplayName -like "*Visual C++ 2010*"} | Select-Object DisplayName
Foreach ($application in $installListx86) 
{
    #if ($application -eq "Microsoft Visual C++ 2010  x86 Redistributable - 10.0.30319")
    if ($application.DisplayName -eq "Microsoft Visual C++ 2010  x86 Redistributable - 10.0.40219")
    {
        write-host "Micosoft Visual C++ 2010 x86 Redistributable was found. Skipping install."
    }   
    else
    {
        Write-host "Microsoft Visual C++ 2010 x86 Redistributable not found. Starting the install"
        \\server\installs\2010x86_vcredist_x86 /q /norestart

        if ($error.count -gt 1)
        {
            Write-Host "An error occured during the install. The redistributable was not installed correctly. Please install it manually"
        }
        else
        {
            Wite-Host "Microsoft Visual C++ 2010 x86 Redistributable was installed successfully"
        }
    }
}