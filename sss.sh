device="$1"
need_repack="$2"

case $device in

    stone|sunstone|moonstone)
        echo "- Assembly has begun"
    ;;
    *)
        echo "- The selected device is incorrect, it must be stone, sunstone, or moonstone"
        exit 222
    ;;

esac

for dev in stone sunstone moonstone; do
    if [[ "$dev" == "$device" ]]; then
        if [[ -f device/xiaomi/$dev/bak_vendorsetup.sh ]]; then
            mv device/xiaomi/$dev/bak_vendorsetup.sh device/xiaomi/$dev/vendorsetup.sh
        fi
    else
        if [[ -f device/xiaomi/$dev/vendorsetup.sh ]]; then
            mv device/xiaomi/$dev/vendorsetup.sh device/xiaomi/$dev/bak_vendorsetup.sh
        fi
    fi
done

. ./build/envsetup.sh
lunch twrp_${device}-ap2a-eng
mka adbd vendorbootimage

if [[ -n "$need_repack" ]]; then
    device/xiaomi/$device/repack_image.sh move
else
    device/xiaomi/$device/repack_image.sh
fi

for dev in stone sunstone moonstone; do
    if [[ -f device/xiaomi/$dev/bak_vendorsetup.sh ]]; then
        mv device/xiaomi/$dev/bak_vendorsetup.sh device/xiaomi/$dev/vendorsetup.sh
    fi
done
