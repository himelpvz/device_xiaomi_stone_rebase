#!/bin/bash

fox_dir=$(pwd)

inject_self_repacker(){
    file="$fox_dir/bootable/recovery/twrpRepacker.cpp"
    # Check if the file exists
    if [ ! -f "$file" ]; then
        echo "File not found: $file"
        exit 1
    fi
    if grep -q "bool twrpRepacker::Flash_Current_Twrp()" "$file"; then
        echo "Function twrpRepacker::Flash_Current_Twrp() found in file"
        if ! grep -q "if (TWFunc::Path_Exists(\"/system/bin/reflash_twrp.sh\"))" "$file"; then
            echo "Inserting code into twrpRepacker::Flash_Current_Twrp()"
            sed -i '/bool twrpRepacker::Flash_Current_Twrp() {/a \
    if (TWFunc::Path_Exists("/system/bin/reflash_twrp.sh")) {\
        gui_print("- Starting custom reflash recovery script\\n");\
        int pipe_fd[2];\
        if (pipe(pipe_fd) == -1) {\
            LOGERR("Failed to create pipe");\
            return false;\
        }\
        if (TWFunc::Path_Exists("/system/bin/reflash_twrp.sh")) {\
            std::string command = "/system/bin/reflash_twrp.sh " + std::to_string(pipe_fd[1]) + " " + std::to_string(pipe_fd[0]);\
            gui_print("- Reflashing recovery\\n");\
            int result = TWFunc::Exec_Cmd(command);\
            if (result != 0) {\
                LOGERR("Script reflash_twrp.sh failed with error code: %d", result);\
                gui_print_color("error", "Script reflash_twrp.sh failed with error code: %d\\n", result);\
                return false;\
            }\
            gui_print_color("green", "- Successfully flashed recovery to both slots\\n");\
            close(pipe_fd[0]);\
            close(pipe_fd[1]);\
            return true;\
        }\
        return false;\
    }' "$file"
            echo "Code successfully inserted."
        else
            echo "Code is already present inside twrpRepacker::Flash_Current_Twrp()."
        fi
    else
        echo "Function twrpRepacker::Flash_Current_Twrp() not found in file."
        exit 1
    fi
}

# cp ./system/core/libvndksupport/include/vndksupport/linker.h /home/leegar/fox_14.1/system/libhidl/transport/include/vndksupport/

# nano hardware/interfaces/usb/aidl/Android.bp
# recovery_available = true
# // frozen = true

# nano hardware/interfaces/stats/aidl/Android.bp
# recovery_available = true
# // frozen = true

# nano hardware/interfaces/usb/gadget/aidl/Android.bp
# recovery_available = true
# // frozen = true

# nano hardware/interfaces/thermal/aidl/Android.bp
# recovery_available = true
# // frozen = true

# transport/ServiceManagement.cpp
#             // else {
#             //     handle = android_load_sphal_library(fullPath.c_str(), dlMode);
#             // }
# // void preloadPassthroughService(const std::string &descriptor) {
# //     PassthroughServiceManager::openLibs(descriptor,
# //         [&](void* /* handle */, const std::string& /* lib */, const std::string& /* sym */) {
# //             // do nothing
# //             return true; // open all libs
# //         });
# // }

s=""
for f in $(env | grep -E '^(OF_|FOX_)') ; do 
    if [ -z "$s" ]; then
        s="$f"
    else
        s+=", $f"
    fi
    unset "$(echo $f | cut -d '=' -f 1)"
done

echo -e "\n\nUnset variables:"
echo $s | grep -E '(OF_|FOX_)'
echo -e ""
env | grep -E '^(OF_|FOX_)'

inject_self_repacker 

sed -i 's/ || defined(RECOVERY_ABGR)//g' $fox_dir/bootable/recovery/minuitwrp/graphics.cpp
sed -i 's/ || defined(RECOVERY_ABGR)//g' $fox_dir/bootable/recovery/minuitwrp/resources.cpp

export ALLOW_MISSING_DEPENDENCIES=true
# Purpose: Allows building even if some dependencies are missing. Used to simplify builds with incomplete device trees.
# Necessity: Useful for testing, but for production it's better to resolve missing dependencies.
# Move to .mk: Not required — this is a global build environment setting.
# Note: Leave in vendorsetup.sh. Remove only if all dependencies are correctly configured.

export FOX_USE_SPECIFIC_MAGISK_ZIP="$fox_dir/device/google/shiba/recovery/root/system/bin/Magisk-29.zip"

export FOX_VERSION=""
# Must be set to an empty value for all FOX source trees
source $fox_dir/device/google/shiba/ofox_vars.sh

s=""
for f in $(env | grep -E '^(OF_|FOX_)') ; do 
    if [ -z "$s" ]; then
        s="$f"
    else
        s+=", $f"
    fi
done

echo -e "New set variables:"
echo $s | grep -E '(OF_|FOX_)'
echo -e "\n"