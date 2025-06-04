@echo off
setlocal EnableDelayedExpansion

echo =====================================
echo 🔍 Checking for Git and Python...
echo =====================================

:: --- Check for Git ---
where git >nul 2>&1
if %errorlevel% neq 0 (
    echo 🔄 Git not found. Downloading installer...
    powershell -Command "Invoke-WebRequest -Uri https://github.com/git-for-windows/git/releases/latest/download/Git-64-bit.exe -OutFile git-installer.exe"
    
    echo ✅ Installing Git silently...
    start /wait git-installer.exe /VERYSILENT /NORESTART
    del git-installer.exe

    :: Check common Git install path
    set "GIT_PATH=%ProgramFiles%\Git\cmd"
    if exist "!GIT_PATH!\git.exe" (
        echo ✅ Git installed at: !GIT_PATH!
        powershell -Command "Start-Process powershell -Verb RunAs -ArgumentList 'setx /M PATH \"!PATH!;!GIT_PATH!\"'"
    ) else (
        echo ⚠️ Git install path not found. You may need to add it to PATH manually.
    )
) else (
    echo ✅ Git is already installed.
)

:: --- Check for Python ---
where python >nul 2>&1
if %errorlevel% neq 0 (
    echo 🔄 Python not found. Downloading installer...
    powershell -Command "Invoke-WebRequest -Uri https://www.python.org/ftp/python/3.12.3/python-3.12.3-amd64.exe -OutFile python-installer.exe"

    echo ✅ Installing Python silently...
    start /wait python-installer.exe /quiet InstallAllUsers=1 PrependPath=0 Include_test=0
    del python-installer.exe

    :: Search for installed Python path
    set "PYTHON_PATH="
    for /d %%D in ("%ProgramFiles%\Python3*") do (
        if exist "%%D\python.exe" (
            set "PYTHON_PATH=%%D"
            goto FoundPython
        )
    )
    for /d %%D in ("%LocalAppData%\Programs\Python\Python3*") do (
        if exist "%%D\python.exe" (
            set "PYTHON_PATH=%%D"
            goto FoundPython
        )
    )

    :FoundPython
    if defined PYTHON_PATH (
        echo ✅ Python installed at: !PYTHON_PATH!
        powershell -Command "Start-Process powershell -Verb RunAs -ArgumentList 'setx /M PATH \"!PATH!;!PYTHON_PATH!;!PYTHON_PATH!\Scripts\"'"
    ) else (
        echo ⚠️ Python path not found. You may need to add it to PATH manually.
    )
) else (
    echo ✅ Python is already installed.
)

:: --- Final check ---
echo.
echo =====================================
echo 🔁 Verifying final installations...
echo =====================================
git --version || echo ❌ Git not found.
python --version || echo ❌ Python not found.

echo.
pause
endlocal
