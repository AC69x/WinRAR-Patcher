# Define the bytes to search for and replace
$licence_check = [byte[]]@(0x74, 0x04, 0xB0, 0x01)
$licence_check_replace = [byte[]]@(0x90, 0x90, 0xB0, 0x01)
$credits_text = [byte[]]@(0x52, 0x00, 0x65, 0x00, 0x67, 0x00, 0x69, 0x00, 0x73, 0x00, 0x74, 0x00, 0x65, 0x00, 0x72, 0x00, 0x65, 0x00, 0x64, 0x00, 0x20, 0x00, 0x74, 0x00, 0x6F)
$credits_text_replace = [byte[]]@(0x43, 0x00, 0x72, 0x00, 0x61, 0x00, 0x63, 0x00, 0x6B, 0x00, 0x20, 0x00, 0x62, 0x00, 0x79, 0x00, 0x20, 0x00, 0x4E, 0x00, 0x42, 0x00, 0x20, 0x00, 0x20)

# Check if the script is running with elevated privileges
$principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$admin = [Security.Principal.WindowsBuiltInRole]::Administrator
if ($principal.IsInRole($admin)) {
    try {
        # Get WinRAR path from registry
        $key = Get-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WinRAR
        $exePath = $key.exe64
        $fileData = [System.IO.File]::ReadAllBytes($exePath)

        # Replace license check bytes
        $index = [System.Array]::IndexOf($fileData, $licence_check, 0)
        while ($index -ne -1) {
            [System.Array]::Copy($licence_check_replace, 0, $fileData, $index, $licence_check_replace.Length)
            $index = [System.Array]::IndexOf($fileData, $licence_check, $index + $licence_check_replace.Length)
        }

        # Replace credits text bytes
        $index = [System.Array]::IndexOf($fileData, $credits_text, 0)
        while ($index -ne -1) {
            [System.Array]::Copy($credits_text_replace, 0, $fileData, $index, $credits_text_replace.Length)
            $index = [System.Array]::IndexOf($fileData, $credits_text, $index + $credits_text_replace.Length)
        }

        # Write modified bytes back to the file
        [System.IO.File]::WriteAllBytes($exePath, $fileData)

        # Show success message
        [System.Windows.Forms.MessageBox]::Show("Successfully Patched!", "NoirBird WR Patcher", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    }
    catch {
        # Show error message if an exception occurs
        [System.Windows.Forms.MessageBox]::Show("Error occurred: $_", "NoirBird WR Patcher", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
}
else {
    # If not running with elevated privileges, restart the script as administrator
    Start-Process -FilePath powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File $($MyInvocation.MyCommand.Path)" -Verb RunAs
}
