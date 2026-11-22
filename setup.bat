@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion
title Zippo Tournament Manager - Instalator Srodowiska

for /F "delims=#" %%E in ('"prompt #$E# & for %%F in (1) do rem"') do set "ESC=%%E"

set "C_RESET=%ESC%[0m"
set "C_BOLD=%ESC%[1m"
set "C_DIM=%ESC%[90m"
set "C_GOLD=%ESC%[93m"
set "C_AMBER=%ESC%[33m"
set "C_GREEN=%ESC%[92m"
set "C_RED=%ESC%[91m"
set "C_CYAN=%ESC%[96m"
set "C_MAGENTA=%ESC%[95m"
set "C_WHITE=%ESC%[97m"

set "DOTNET_MAJOR=10"
set "WINGET_PKG=Microsoft.DotNet.Runtime.10"
set "DIRECT_INSTALLER_URL=https://aka.ms/dotnet/10.0/dotnet-runtime-win-x64.exe"
set "INSTALLER_PATH=%TEMP%\dotnet-runtime-%DOTNET_MAJOR%-win-x64.exe"

set "IS_ADMIN=0"
net session >nul 2>&1
if %errorlevel% equ 0 set "IS_ADMIN=1"

set "WIN_NAME=Nieznany Windows"
set "WIN_BUILD=0"
set "WIN_VER="

for /f "tokens=4-5 delims=. " %%i in ('ver') do set "WIN_VER=%%i.%%j"
for /f "tokens=3" %%b in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuildNumber 2^>nul ^| findstr /i "CurrentBuildNumber"') do set "WIN_BUILD=%%b"

if "%WIN_VER%"=="10.0" (
    if !WIN_BUILD! GEQ 22000 (
        set "WIN_NAME=Windows 11 (Build !WIN_BUILD!)"
    ) else (
        set "WIN_NAME=Windows 10 (Build !WIN_BUILD!)"
    )
) else if "%WIN_VER%"=="6.3" (
    set "WIN_NAME=Windows 8.1"
) else if "%WIN_VER%"=="6.2" (
    set "WIN_NAME=Windows 8"
) else if "%WIN_VER%"=="6.1" (
    set "WIN_NAME=Windows 7"
) else (
    set "WIN_NAME=Windows %WIN_VER%"
)

cls
echo %C_GOLD%┌──────────────────────────────────────────────────────┐%C_RESET%
echo %C_GOLD%│%C_BOLD%%C_WHITE%      ZIPPO TOURNAMENT MANAGER - INSTALATOR (.NET)    %C_RESET%%C_GOLD%│%C_RESET%
echo %C_GOLD%└──────────────────────────────────────────────────────┘%C_RESET%
echo.
echo %C_CYAN%┌──────────────────────────────────────────────────────┐%C_RESET%
echo %C_CYAN%│ %C_WHITE%System: %C_MAGENTA%!WIN_NAME!%C_RESET%
echo %C_CYAN%│ %C_WHITE%Cel:    %C_GOLD%.NET %DOTNET_MAJOR% Runtime%C_RESET%
echo %C_CYAN%└──────────────────────────────────────────────────────┘%C_RESET%
echo.
echo %C_CYAN% [*] %C_WHITE%Sprawdzanie zainstalowanych bibliotek...%C_RESET%
echo.

set "ENV_OK=0"
where dotnet >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=1 delims=." %%V in ('dotnet --list-runtimes 2^>nul ^| findstr /i "Microsoft.NETCore.App %DOTNET_MAJOR%."') do set "ENV_OK=1"
    if "!ENV_OK!"=="0" (
        for /f "tokens=1 delims=." %%V in ('dotnet --list-sdks 2^>nul ^| findstr /b "%DOTNET_MAJOR%."') do set "ENV_OK=1"
    )
)

if "!ENV_OK!"=="1" (
    echo %C_GREEN%┌──────────────────────────────────────────────────────┐%C_RESET%
    echo %C_GREEN%│ %C_BOLD%[OK] Biblioteki .NET %DOTNET_MAJOR% sa juz zainstalowane.        %C_RESET%
    echo %C_GREEN%│ %C_CYAN%[i]  Twoj system jest gotowy do pracy.                 %C_RESET%
    echo %C_GREEN%└──────────────────────────────────────────────────────┘%C_RESET%
    echo.
    pause
    exit /b 0
)

echo %C_RED%┌──────────────────────────────────────────────────────┐%C_RESET%
echo %C_RED%│ %C_BOLD%[!] Brak wymaganych bibliotek .NET %DOTNET_MAJOR%!                %C_RESET%
echo %C_RED%└──────────────────────────────────────────────────────┘%C_RESET%
echo.

if "!IS_ADMIN!"=="0" (
    echo %C_RED%┌──────────────────────────────────────────────────────┐%C_RESET%
    echo %C_RED%│ %C_BOLD%[!] WYMAGANE UPRAWNIENIA ADMINISTRATORA!             %C_RESET%
    echo %C_RED%│                                                      %C_RESET%
    echo %C_RED%│ %C_WHITE%Aby pobrac i zainstalowac biblioteki pod swoj          %C_RESET%
    echo %C_RED%│ %C_WHITE%system, uruchom plik prawym przyciskiem myszy:       %C_RESET%
    echo %C_RED%│ %C_GOLD%%C_BOLD%Uruchom jako administrator                            %C_RESET%
    echo %C_RED%└──────────────────────────────────────────────────────┘%C_RESET%
    echo.
    pause
    exit /b 1
)

echo %C_CYAN%┌──────────────────────────────────────────────────────┐%C_RESET%
echo %C_CYAN%│ %C_GREEN%[✓] %C_WHITE%Wykryto uprawnienia administratora.                 %C_RESET%
echo %C_CYAN%│ %C_GOLD%[*] %C_WHITE%Dobieranie metody instalacji pod system...          %C_RESET%
echo %C_CYAN%└──────────────────────────────────────────────────────┘%C_RESET%
echo.

where winget >nul 2>&1
if %errorlevel% equ 0 (
    echo %C_GOLD% [*] %C_WHITE%Uzywam %C_CYAN%winget%C_WHITE% - pobieranie %C_GOLD%%WINGET_PKG%%C_RESET%...
    echo.
    winget install --id %WINGET_PKG% --exact --silent --accept-package-agreements --accept-source-agreements
    if !errorlevel! equ 0 goto :INSTALL_SUCCESS
    echo.
    echo %C_AMBER% [!] winget nie powiodl sie. Przelaczam na pobieranie bezposrednie...%C_RESET%
    echo.
) else (
    echo %C_CYAN% [i] %C_WHITE%Brak winget. Przelaczam na pobieranie bezposrednie...%C_RESET%
    echo.
)

where powershell >nul 2>&1
if %errorlevel% neq 0 (
    echo %C_RED%┌──────────────────────────────────────────────────────┐%C_RESET%
    echo %C_RED%│ %C_BOLD%[!] Brak winget oraz PowerShell w tym systemie.       %C_RESET%
    echo %C_RED%└──────────────────────────────────────────────────────┘%C_RESET%
    echo %C_WHITE% Pobierz .NET %DOTNET_MAJOR% recznie: %C_CYAN%https://dotnet.microsoft.com/en-us/download/dotnet/%DOTNET_MAJOR%.0%C_RESET%
    echo.
    pause
    exit /b 1
)

echo %C_GOLD% [*] %C_WHITE%Pobieranie instalatora .NET %DOTNET_MAJOR% Runtime z Microsoft...%C_RESET%
powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%DIRECT_INSTALLER_URL%' -OutFile '%INSTALLER_PATH%'"

if not exist "%INSTALLER_PATH%" (
    echo %C_RED%┌──────────────────────────────────────────────────────┐%C_RESET%
    echo %C_RED%│ %C_BOLD%[!] Nie udalo sie pobrac pliku instalatora!           %C_RESET%
    echo %C_RED%└──────────────────────────────────────────────────────┘%C_RESET%
    echo %C_DIM% Sprawdz polaczenie z internetem i sprobuj ponownie.%C_RESET%
    echo.
    pause
    exit /b 1
)

echo %C_GOLD% [*] %C_WHITE%Instalowanie bibliotek .NET %DOTNET_MAJOR%...%C_RESET%
"%INSTALLER_PATH%" /install /quiet /norestart
set "INST_CODE=%errorlevel%"

if exist "%INSTALLER_PATH%" del /f /q "%INSTALLER_PATH%" >nul 2>&1

if not "!INST_CODE!"=="0" if not "!INST_CODE!"=="3010" (
    echo %C_RED%┌──────────────────────────────────────────────────────┐%C_RESET%
    echo %C_RED%│ %C_BOLD%[!] Blad instalacji (kod: !INST_CODE!).                %C_RESET%
    echo %C_RED%└──────────────────────────────────────────────────────┘%C_RESET%
    echo.
    pause
    exit /b 1
)

:INSTALL_SUCCESS
echo.
echo %C_GREEN%┌──────────────────────────────────────────────────────┐%C_RESET%
echo %C_GREEN%│ %C_BOLD%[OK] Biblioteki .NET %DOTNET_MAJOR% zostaly zainstalowane!       %C_RESET%
echo %C_GREEN%│ %C_CYAN%[i]  System: %C_MAGENTA%!WIN_NAME!%C_RESET%
echo %C_GREEN%└──────────────────────────────────────────────────────┘%C_RESET%
echo.
pause
endlocal