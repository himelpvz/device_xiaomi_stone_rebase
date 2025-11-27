#!/bin/bash

fox_dir=$(pwd)

inject_self_repacker() {
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

# Clear existing OF_/FOX_ variables
s=""
for f in $(env | grep -E '^(OF_|FOX_)') ; do 
    if [ -z "$s" ]; then
        s="$f"
    else
        s+=", $f"
    fi
    unset "$(echo "$f" | cut -d '=' -f 1)"
done

echo -e "\n\nUnset variables:"
echo "$s" | grep -E '(OF_|FOX_)'
echo -e ""
env | grep -E '^(OF_|FOX_)'

inject_self_repacker 

# Disable ABGR checks
sed -i 's/ || defined(RECOVERY_ABGR)//g' "$fox_dir/bootable/recovery/minuitwrp/graphics.cpp"
sed -i 's/ || defined(RECOVERY_ABGR)//g' "$fox_dir/bootable/recovery/minuitwrp/resources.cpp"

# Allow missing deps during bringup (optional)
export ALLOW_MISSING_DEPENDENCIES=true

# Magisk ZIP path – ensure this file actually exists
export FOX_USE_SPECIFIC_MAGISK_ZIP="$fox_dir/device/xiaomi/stone/recovery/root/system/bin/Magisk-29.zip"

# Must be empty for all FOX source trees
export FOX_VERSION=""

# Load device-specific OrangeFox vars for stone
if [ -f "$fox_dir/device/xiaomi/stone/ofox_vars.sh" ]; then
    source "$fox_dir/device/xiaomi/stone/ofox_vars.sh"
else
    echo "Warning: device/xiaomi/stone/ofox_vars.sh not found; skipping device-specific FOX vars."
fi

s=""
for f in $(env | grep -E '^(OF_|FOX_)') ; do 
    if [ -z "$s" ]; then
        s="$f"
    else
        s+=", $f"
    fi
done

echo -e "New set variables:"
echo "$s" | grep -E '(OF_|FOX_)'
echo -e "\n"
