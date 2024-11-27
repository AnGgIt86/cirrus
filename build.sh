#sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/AospExtended/manifest -b 7.1.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/AnGgIt86/local_manifest --depth 1 -b 13 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source $CIRRUS_WORKING_DIR/config
timeStart

source build/envsetup.sh
export TZ=Asia/Jakarta
export KBUILD_BUILD_USER=grandppltedx
export KBUILD_BUILD_HOST=samsung
export BUILD_USERNAME=grandppltedx
export BUILD_HOSTNAME=samsung
lunch aosp_grandppltedx
mkfifo reading # Jangan di Hapus
tee "${BUILDLOG}" < reading & # Jangan di Hapus
build_message "Building Started" # Jangan di Hapus
progress & # Jangan di Hapus
timeout 95m make xtended -j8 > reading # Jangan di hapus text line (> reading)

retVal=$?
timeEnd
statusBuild
# end
