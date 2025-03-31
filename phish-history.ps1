# Define variables
$RemoteServer = "//v-fs1-prd/dfs-test/"  # Change this to your server's UNC path
$Username = $env:USERNAME
$UserFolder = "$RemoteServer\$Username"
$Timestamp = Get-Date -Format 'yyyyMMdd_HHmmss'

# Define file paths
$LocalHistoryPath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\History"
$BackupFileName = "Chrome_History_$Timestamp.db"
$BackupPath = "$UserFolder\$BackupFileName"

# Log file for usernames
$UserLogFile = "$UserFolder\User_Logins.txt"
$LogEntry = "$Timestamp - User: $Username ran the script"

# Ensure the user's folder exists on the remote server
if (!(Test-Path $UserFolder)) {
    New-Item -ItemType Directory -Path $UserFolder -Force
    Write-Host "Created user folder: $UserFolder"
}

# Stop Chrome to unlock the file (optional)
Write-Host "Stopping Chrome to unlock history file..."
Stop-Process -Name "chrome" -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2  # Wait for Chrome to close

# Check if the history file exists
if (Test-Path $LocalHistoryPath) {
    try {
        # Copy the history file to the user's folder on the remote server
        Copy-Item -Path $LocalHistoryPath -Destination $BackupPath -Force
        Write-Host "History file copied successfully to $BackupPath"

        # Log the username
        Add-Content -Path $UserLogFile -Value $LogEntry
        Write-Host "User login recorded in $UserLogFile"
    }
    catch {
        Write-Host "Failed to copy history file: $_"
    }
} else {
    Write-Host "Chrome history file not found!"
}

# Restart Chrome
Start-Process "chrome.exe"

Write-Host "Script completed!"