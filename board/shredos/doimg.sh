#!/bin/bash -e

cp "board/shredos/grub.cfg"                "${BINARIES_DIR}/grub.cfg"    || exit 1
cp "board/shredos/bootx64.efi"             "${BINARIES_DIR}/bootx64.efi" || exit 1
cp "${HOST_DIR}/lib/grub/i386-pc/boot.img" "${BINARIES_DIR}/boot.img"    || exit 1

# copy the ShredOS icon and windows files, if a stick is plugged into a  Windows system
# it is identified as ShredOS - Dangerous as a warning to users that that know what ShredOS is.
cp "board/shredos/autorun.inf"             "${BINARIES_DIR}/autorun.inf" || exit 1
cp "board/shredos/README.txt"              "${BINARIES_DIR}/README.txt"  || exit 1
cp "board/shredos/shredos.ico"             "${BINARIES_DIR}/shredos.ico" || exit 1

rm -rf "${BUILD_DIR}/genimage.tmp"                                       || exit 1
genimage --rootpath="${TARGET_DIR}" --inputpath="${BINARIES_DIR}" --outputpath="${BINARIES_DIR}" --config="board/shredos/genimage.cfg" --tmppath="${BUILD_DIR}/genimage.tmp" || exit 1

# renaming
SUFFIXIMG=2020.05.007_x86_64-0.30.001_$(date +%Y%m%d)
#SUFFIXIMG=$(date +%Y%m%d)
FINAL_IMAGE_PATH="${BINARIES_DIR}/shredos-${SUFFIXIMG}.img"
mv "${BINARIES_DIR}/shredos.img" "${FINAL_IMAGE_PATH}" || exit 1

echo "File ${FINAL_IMAGE_PATH} created successfully"

exit 0
