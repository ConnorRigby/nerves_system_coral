################################################################################
#
# compulab
#
################################################################################

COMPULAB_VERSION = 14f548ef600
COMPULAB_SITE = https://github.com/compulab-yokneam/buildroot/archive
COMPULAB_SOURCE = $(COMPULAB_VERSION).tar.gz

COMPULAB_DEPENDENCIES = \
	host-imx-mkimage \
	host-uboot-tools

HOST_UBOOT_TOOLS_PRE_BUILD_HOOKS += HOST_COMPULAB_PRE_BUILD_HOOK
HOST_UBOOT_TOOLS_POST_INSTALL_HOOKS += HOST_COMPULAB_POST_INSTALL_HOOK

define HOST_COMPULAB_PRE_BUILD_HOOK
	$(MAKE) host-compulab -C $(BASE_DIR)
endef

define HOST_COMPULAB_POST_INSTALL_HOOK
	$(HOST_COMPULAB_DIR)/scripts/imx8-bootloader-prepare.sh \
		"unused" $(UBOOT_DIR)/arch/arm/dts/iot-gate-imx8plus.dtb
endef

define HOST_COMPULAB_CONFIGURE_CMDS
	ln -s \
		$(@D)/buildroot/board/compulab-aarch64-efi/imx8mp/scripts \
		$(@D)/scripts
endef

$(eval $(host-generic-package))
