From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 2/2] ARM: dts: exynos4: Add stdout-path properties
Date: Fri, 23 Jan 2015 14:47:42 +0100
Message-ID: <1422020862-10169-3-git-send-email-m.szyprowski@samsung.com>
References: <1422020862-10169-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1422020862-10169-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, thomas.ab@samsung.com, Tomasz Figa <tomasz.figa@gmail.com>, Kukjin Kim <kgene@kernel.org>
List-Id: linux-serial@vger.kernel.org

From: Tomasz Figa <t.figa@samsung.com>

This patch adds stdout-path property to chosen nodes of Exynos4 boards
to enable use of earlycon feature without the need to hardcode port
number in kernel itself.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos4210-origen.dts         | 1 +
 arch/arm/boot/dts/exynos4210-smdkv310.dts       | 1 +
 arch/arm/boot/dts/exynos4210-trats.dts          | 1 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts | 1 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 4 ++++
 arch/arm/boot/dts/exynos4412-origen.dts         | 1 +
 arch/arm/boot/dts/exynos4412-smdk4412.dts       | 1 +
 arch/arm/boot/dts/exynos4412-tiny4412.dts       | 4 ++++
 arch/arm/boot/dts/exynos4412-trats2.dts         | 1 +
 9 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index f767c425d0b5..b81146141402 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -31,6 +31,7 @@
 
 	chosen {
 		bootargs ="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC2,115200 init=/linuxrc";
+		stdout-path = &serial_2;
 	};
 
 	regulators {
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 676e6e0c8cf3..86216fff1b4f 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -27,6 +27,7 @@
 
 	chosen {
 		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc";
+		stdout-path = &serial_1;
 	};
 
 	sdhci@12530000 {
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index f516da9e8b3a..b351c7bddf2d 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -28,6 +28,7 @@
 
 	chosen {
 		bootargs = "console=ttySAC2,115200N8 root=/dev/mmcblk0p5 rootwait earlyprintk panic=5";
+		stdout-path = &serial_2;
 	};
 
 	regulators {
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index d50eb3aa708e..e65ee3cb36c3 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -26,6 +26,7 @@
 
 	chosen {
 		bootargs = "console=ttySAC2,115200N8 root=/dev/mmcblk0p5 rw rootwait earlyprintk panic=5 maxcpus=1";
+		stdout-path = &serial_2;
 	};
 
 	sysram@02020000 {
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index c697ff01ae8d..7c49bddf44b6 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -11,6 +11,10 @@
 #include "exynos4412.dtsi"
 
 / {
+	chosen {
+		stdout-path = &serial_1;
+	};
+
 	firmware@0204F000 {
 		compatible = "samsung,secure-firmware";
 		reg = <0x0204F000 0x1000>;
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index de15114fd07c..bd8b73077d41 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -26,6 +26,7 @@
 
 	chosen {
 		bootargs ="console=ttySAC2,115200";
+		stdout-path = &serial_2;
 	};
 
 	firmware@0203F000 {
diff --git a/arch/arm/boot/dts/exynos4412-smdk4412.dts b/arch/arm/boot/dts/exynos4412-smdk4412.dts
index ded0b70f7644..b9256afbcc68 100644
--- a/arch/arm/boot/dts/exynos4412-smdk4412.dts
+++ b/arch/arm/boot/dts/exynos4412-smdk4412.dts
@@ -25,6 +25,7 @@
 
 	chosen {
 		bootargs ="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc";
+		stdout-path = &serial_1;
 	};
 
 	g2d@10800000 {
diff --git a/arch/arm/boot/dts/exynos4412-tiny4412.dts b/arch/arm/boot/dts/exynos4412-tiny4412.dts
index ea6929d9c621..d46fd4c2aeaa 100644
--- a/arch/arm/boot/dts/exynos4412-tiny4412.dts
+++ b/arch/arm/boot/dts/exynos4412-tiny4412.dts
@@ -18,6 +18,10 @@
 	model = "FriendlyARM TINY4412 board based on Exynos4412";
 	compatible = "friendlyarm,tiny4412", "samsung,exynos4412", "samsung,exynos4";
 
+	chosen {
+		stdout-path = &serial_0;
+	};
+
 	memory {
 		reg = <0x40000000 0x40000000>;
 	};
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 5e066cd87f66..c8b38359d54e 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -30,6 +30,7 @@
 
 	chosen {
 		bootargs = "console=ttySAC2,115200N8 root=/dev/mmcblk0p5 rootwait earlyprintk panic=5";
+		stdout-path = &serial_2;
 	};
 
 	firmware@0204F000 {
-- 
1.9.2
