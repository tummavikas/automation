@echo off
setlocal EnableDelayedExpansion
echo =====================================
echo Checking if winget, Git, and Python are installed...
echo =====================================

:: --- Check for winget ---
where winget >nul 2>&1
if %errorlevel% neq 0 (
    echo Downloading Winget .msixbundle...
    powershell -Command "Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile winget.msixbundle"

    echo Installing Winget...
    powershell -Command "Add-AppxPackage winget.msixbundle"

    echo Cleaning up installer...
    del winget.msixbundle

    echo.
    echo ✅ Winget installation process completed.
    pause
    exit /b 1
)
echo ✅ winget is available.

:: --- Check for Git ---
where git >nul 2>&1
if %errorlevel% neq 0 (
    echo 🔄 Git not found. Installing Git...
    powershell -Command "winget install --id Git.Git -e --source winget --silent --accept-package-agreements --accept-source-agreements"
    set "GIT_PATH=%ProgramFiles%\Git\cmd"
    if exist "%GIT_PATH%\git.exe" (
        echo ✅ Git installed at: %GIT_PATH%
        powershell -Command "Start-Process powershell -Verb runAs -ArgumentList 'setx /M PATH \"!PATH!;%GIT_PATH%\"'"
    ) else (
        echo ❌ Git installation failed or not found.
    )
) else (
    echo ✅ Git is already installed.
)

:: --- Remove Microsoft Store alias for python.exe ---
powershell -Command ^
  "$alias = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\App Execution Alias\python.exe';" ^
  "if (Test-Path $alias) { Remove-Item $alias -Force; Write-Output '🔧 Removed Microsoft Store Python alias.' }"

:: --- Search for actual Python installation ---
set "PYTHON_FOUND=0"
for /d %%D in ("%LocalAppData%\Programs\Python\Python3*") do (
    if exist "%%D\python.exe" (
        set "PYTHON_PATH=%%D"
        set "PYTHON_FOUND=1"
        goto InstallPythonPath
    )
)

:: --- Install Python if not found ---
if "%PYTHON_FOUND%"=="0" (
    echo 🔄 Python not found. Installing Python via winget...
    powershell -Command "winget install python --silent --accept-package-agreements --accept-source-agreements"

    :: Retry locating Python
    for /d %%D in ("%LocalAppData%\Programs\Python\Python3*") do (
        if exist "%%D\python.exe" (
            set "PYTHON_PATH=%%D"
            set "PYTHON_FOUND=1"
            goto InstallPythonPath
        )
    )
)

:: --- Still not found after installation ---
if "%PYTHON_FOUND%"=="0" (
    echo ❌ Python installation completed
    goto FinalCheck
)

:InstallPythonPath
echo ✅ Python located at: %PYTHON_PATH%
powershell -Command "Start-Process powershell -Verb runAs -ArgumentList 'setx /M PATH \"!PATH!;%PYTHON_PATH%;%PYTHON_PATH%\Scripts\"'"

:FinalCheck
echo.
echo =====================================
echo Verifying final installations...
echo =====================================
where git >nul 2>&1 && git --version || echo ❌ Git not found after install.
python --version 2>nul || echo ❌ Python not found after install.

echo.
pause
endlocal
