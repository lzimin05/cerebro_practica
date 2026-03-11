# -*- coding: utf-8 -*-
import sys
import os
import string
import winreg

def get_available_drives():
    drives = []
    for letter in string.ascii_uppercase:
        path = f"{letter}:\\"
        if os.path.exists(path):
            drives.append(path)
    return drives

def search_filesystem(app_name, drives):
    found_paths = set()
    standard_folders = ["Program Files", "Program Files (x86)"]
    app_name_lower = app_name.lower()
    
    for drive in drives:
        for folder in standard_folders:
            root_path = os.path.join(drive, folder)
            if os.path.exists(root_path):
                try:
                    for entry in os.listdir(root_path):
                        full_path = os.path.join(root_path, entry)
                        if os.path.isdir(full_path):
                            if app_name_lower in entry.lower():
                                found_paths.add(full_path)
                except PermissionError:
                    continue
                except OSError:
                    continue
    return found_paths

def search_registry(app_name):
    found_paths = set()
    app_name_lower = app_name.lower()
    
    reg_path = r"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
    
    try:
        key = winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, reg_path, 0, 
                             winreg.KEY_READ | winreg.KEY_WOW64_64KEY)
    except PermissionError:
        print(f"Предупреждение: Нет доступа к разделу реестра: {reg_path}")
        return found_paths
    except Exception:
        return found_paths
        
    i = 0
    while True:
        try:
            subkey_name = winreg.EnumKey(key, i)
            subkey = winreg.OpenKey(key, subkey_name)
            try:
                display_name, _ = winreg.QueryValueEx(subkey, "DisplayName")
                
                if app_name_lower in display_name.lower():
                    try:
                        install_loc, _ = winreg.QueryValueEx(subkey, "InstallLocation")
                        if install_loc and os.path.exists(install_loc):
                            found_paths.add(install_loc)
                    except FileNotFoundError:
                        pass
            except FileNotFoundError:
                pass
            finally:
                winreg.CloseKey(subkey)
            i += 1
        except OSError:
            break
    winreg.CloseKey(key)
    
    return found_paths

def main():
    if len(sys.argv) != 2:
        print("Использование: python locate_app.py <название_приложения>")
        print("Пример: python locate_app.py photoshop")
        sys.exit(1)
        
    app_name = sys.argv[1]
    
    print(f"Поиск потенциальных директорий для: '{app_name}'")
    print("-" * 50)
    
    all_paths = set()
    
    drives = get_available_drives()
    fs_paths = search_filesystem(app_name, drives)
    all_paths.update(fs_paths)
    
    reg_paths = search_registry(app_name)
    all_paths.update(reg_paths)
    
    if all_paths:
        print(f"Найдено директорий: {len(all_paths)}")
        for path in sorted(all_paths):
            print(path)
    else:
        print("Ничего не найдено.")

if __name__ == "__main__":
    main()