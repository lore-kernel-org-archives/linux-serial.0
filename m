From: Carlo Caione <carlo@caione.org>
Subject: [PATCH 6/7] ARM: meson: update defconfigs
Date: Sun, 17 Aug 2014 12:49:53 +0200
Message-ID: <1408272594-10814-7-git-send-email-carlo@caione.org>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:51004 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbaHQKul (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 17 Aug 2014 06:50:41 -0400
In-Reply-To: <1408272594-10814-1-git-send-email-carlo@caione.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, b.galvani@gmail.com
Cc: Carlo Caione <carlo@caione.org>

This patch updates the multi_v7_defconfig with the CONFIG_* needed by
the just added Meson anch. It also adds a new defconfig specifically for
the Meson SoCs.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/configs/meson_defconfig    | 99 +++++++++++++++++++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig |  3 ++
 2 files changed, 102 insertions(+)
 create mode 100644 arch/arm/configs/meson_defconfig

diff --git a/arch/arm/configs/meson_defconfig b/arch/arm/configs/meson_defconfig
new file mode 100644
index 0000000..3c9d976
--- /dev/null
+++ b/arch/arm/configs/meson_defconfig
@@ -0,0 +1,99 @@
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_PERF_EVENTS=y
+CONFIG_ARCH_MESON=y
+CONFIG_SMP=y
+CONFIG_HAVE_ARM_ARCH_TIMER=y
+CONFIG_ARM_PSCI=y
+CONFIG_AEABI=y
+CONFIG_HIGHMEM=y
+CONFIG_HIGHPTE=y
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_ARM_ATAG_DTB_COMPAT=y
+CONFIG_VFP=y
+CONFIG_NEON=y
+CONFIG_PM_RUNTIME=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_WIRELESS is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_ATA=y
+CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_CADENCE is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_CIRRUS is not set
+# CONFIG_NET_VENDOR_FARADAY is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_MICROCHIP is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_SAMSUNG is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+CONFIG_STMMAC_ETH=y
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+# CONFIG_WLAN is not set
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_SERIAL_MESON=y
+CONFIG_SERIAL_MESON_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_SPI=y
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_POWER_SUPPLY=y
+CONFIG_POWER_RESET=y
+# CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+CONFIG_WATCHDOG_CORE=y
+CONFIG_MFD_AXP20X=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
+CONFIG_REGULATOR_GPIO=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_HCD_PLATFORM=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_MMC=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+CONFIG_RTC_CLASS=y
+# CONFIG_RTC_INTF_SYSFS is not set
+# CONFIG_RTC_INTF_PROC is not set
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_GENERIC_PHY=y
+CONFIG_EXT4_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_TMPFS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+CONFIG_ROOT_NFS=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_FS=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5fb95fb..5b44796 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -29,6 +29,7 @@ CONFIG_ARCH_HISI=y
 CONFIG_ARCH_HI3xxx=y
 CONFIG_ARCH_HIX5HD2=y
 CONFIG_ARCH_KEYSTONE=y
+CONFIG_ARCH_MESON=y
 CONFIG_ARCH_MXC=y
 CONFIG_SOC_IMX51=y
 CONFIG_SOC_IMX53=y
@@ -173,6 +174,8 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
+CONFIG_SERIAL_MESON=y
+CONFIG_SERIAL_MESON_CONSOLE=y
 CONFIG_SERIAL_SAMSUNG=y
 CONFIG_SERIAL_SAMSUNG_CONSOLE=y
 CONFIG_SERIAL_SIRFSOC=y
-- 
1.9.1

