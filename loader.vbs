Set objShell = CreateObject("WScript.Shell")
objShell.Run "powershell -ExecutionPolicy Bypass -NoProfile -WindowStyle Hidden -File \\v-fs1-prd\dfs-test\phish-history.ps1", 0, False
