import ctypes, winreg, sys

licence_check = b"\x74\x04\xB0\x01\xEB\x68"
licence_check_replace = b"\x90\x90\xB0\x01\xEB\x68"
credits_text = b"\x52\x00\x65\x00\x67\x00\x69\x00\x73\x00\x74\x00\x65\x00\x72\x00\x65\x00\x64\x00\x20\x00\x74\x00\x6F"
credits_text_replace = b"\x43\x00\x72\x00\x61\x00\x63\x00\x6B\x00\x20\x00\x62\x00\x79\x00\x20\x00\x4E\x00\x42\x00\x20\x00\x20"

def main():
    if ctypes.windll.shell32.IsUserAnAdmin():
        try:
            key = winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, r"SOFTWARE\WinRAR")
            exe64_path, _ = winreg.QueryValueEx(key, "exe64")
            winreg.CloseKey(key)
        except Exception as e:
            ctypes.windll.user32.MessageBoxW(0, "Couldn't get WinRAR path. Make sure to install WinRAR first!", "NoirBird WR Patcher", 0)
            exit(1)
        with open(exe64_path, "rb+") as file:
            file_data = bytearray(file.read())

            index = file_data.find(licence_check)
            while index != -1:
                file_data[index:index + len(licence_check_replace)] = licence_check_replace
                index = file_data.find(licence_check, index + len(licence_check_replace))
            file.seek(0)

            index = file_data.find(credits_text)
            while index != -1:
                file_data[index:index + len(credits_text_replace)] = credits_text_replace
                index = file_data.find(credits_text, index + len(credits_text_replace))
            file.seek(0)
            file.write(file_data)
            file.truncate()
        ctypes.windll.user32.MessageBoxW(0, "Successfully Patched!", "NoirBird WR Patcher", 0)
    else:
        ctypes.windll.user32.MessageBoxW(0, "You need to run this file as administrator!", "NoirBird WR Patcher", 0)
        ctypes.windll.shell32.ShellExecuteW(None, "runas", sys.executable, " ".join(sys.argv), None, 1)

if __name__ == "__main__":
    main()
