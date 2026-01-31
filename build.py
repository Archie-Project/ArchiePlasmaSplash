#! /usr/bin/env python3
import os, shutil

print("-=Splash theme builder=-")
print("These are the currently available themes:")
print('''    1 - Archlinux
    2 - Debian
    3 - Kubuntu
    4 - Ubuntu''')
while True:
    selection = input("Please select a number from above [1-4]: ")
    if not selection.isdecimal():
        print("Error, try again")
    elif int(selection) >= 1 and int(selection) <= 4:
        if not os.path.exists("build"): os.mkdir("build")
        name: str = ""
        match int(selection):
            case 1:
                name = "org.gearfox98.ArchieArch"
                if os.path.exists(f"build/{name}"):
                    print(f"Error: build/{name} already exists")
                    break
                shutil.copytree("arch", f"build/{name}")
            case 2:
                name = "org.gearfox98.ArchieDebian"
                if os.path.exists(f"build/{name}"):
                    print(f"Error: build/{name} already exists")
                    break
                shutil.copytree("debian", f"build/{name}")
            case 3:
                name = "org.gearfox98.ArchieKubuntu"
                if os.path.exists(f"build/{name}"):
                    print(f"Error: build/{name} already exists")
                    break
                shutil.copytree("kubuntu", f"build/{name}")
            case 4:
                name = "org.gearfox98.ArchieUbuntu"
                if os.path.exists(f"build/{name}"):
                    print(f"Error: build/{name} already exists")
                    break
                shutil.copytree("ubuntu", f"build/{name}")
        shutil.copytree("base", f"build/{name}", dirs_exist_ok=True)
    break
print("Done")
