From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: =?y?q?=5BRFC=205/8=5D=20ARM=3Astih41x=3A=20Add=20STiH415=20SOC=20support?=
Date: Wed,  8 May 2013 15:11:37 +0100
Message-ID: <1368022297-2334-1-git-send-email-srinivas.kandagatla@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog124.obsmtp.com ([207.126.144.157]:47884 "EHLO
	eu1sys200aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755630Ab3EHOmB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 May 2013 10:42:01 -0400
In-Reply-To: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux@arm.linux.org.uk, arnd@arndb.de, olof@lixom.net
Cc: Rob Landley <rob@landley.net>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Samuel Ortiz <sameo@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Srinivas Kandagatla <srinivas.kandagatla@st.com>, Stuart Menefy <stuart.menefy@st.com>, Shawn Guo <shawn.guo@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Stephen Warren <swarren@nvidia.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Nicolas Pitre <nico@linaro.org>, Will Deacon <will.deacon@arm.com>, Dave Martin <dave.martin@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <dong.aisheng@linaro.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozla

=46rom: Srinivas Kandagatla <srinivas.kandagatla@st.com>

The STiH415 is the next generation of HD, AVC set-top box processors fo=
r
satellite, cable, terrestrial and IP-STB markets. It is an ARM Cortex-A=
9
1.0 GHz, dual-core CPU.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
CC: Stephen Gallimore <stephen.gallimore@st.com>
CC: Stuart Menefy <stuart.menefy@st.com>
---
 Documentation/arm/STiH41x/overview.txt         |   39 ++
 Documentation/arm/STiH41x/stih415-overview.txt |   12 +
 arch/arm/Kconfig                               |    3 +
 arch/arm/Kconfig.debug                         |   38 ++
 arch/arm/Makefile                              |    2 +
 arch/arm/boot/dts/stih415-clock.dtsi           |   38 ++
 arch/arm/boot/dts/stih415-pinctrl.dtsi         |  480 ++++++++++++++++=
++++++++
 arch/arm/boot/dts/stih415.dtsi                 |   94 +++++
 arch/arm/boot/dts/stih415.h                    |   20 +
 arch/arm/boot/dts/stih41x.dtsi                 |   30 ++
 arch/arm/boot/dts/stixxxx-pincfg.h             |   95 +++++
 arch/arm/configs/stih41x_defconfig             |   94 +++++
 arch/arm/include/debug/stixxxx.S               |   61 +++
 arch/arm/mach-stih41x/Kconfig                  |   35 ++
 arch/arm/mach-stih41x/Makefile                 |    4 +
 arch/arm/mach-stih41x/board-dt.c               |   76 ++++
 arch/arm/mach-stih41x/stih41x.c                |   82 ++++
 arch/arm/mach-stih41x/stih41x.h                |    7 +
 arch/arm/plat-stixxxx/Kconfig                  |    2 +
 arch/arm/plat-stixxxx/Makefile                 |    2 +
 arch/arm/plat-stixxxx/headsmp.S                |   44 +++
 arch/arm/plat-stixxxx/include/plat/hardware.h  |   20 +
 arch/arm/plat-stixxxx/include/plat/smp.h       |   19 +
 arch/arm/plat-stixxxx/platsmp.c                |  144 +++++++
 24 files changed, 1441 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/arm/STiH41x/overview.txt
 create mode 100644 Documentation/arm/STiH41x/stih415-overview.txt
 create mode 100644 arch/arm/boot/dts/stih415-clock.dtsi
 create mode 100644 arch/arm/boot/dts/stih415-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stih415.dtsi
 create mode 100644 arch/arm/boot/dts/stih415.h
 create mode 100644 arch/arm/boot/dts/stih41x.dtsi
 create mode 100644 arch/arm/boot/dts/stixxxx-pincfg.h
 create mode 100644 arch/arm/configs/stih41x_defconfig
 create mode 100644 arch/arm/include/debug/stixxxx.S
 create mode 100644 arch/arm/mach-stih41x/Kconfig
 create mode 100644 arch/arm/mach-stih41x/Makefile
 create mode 100644 arch/arm/mach-stih41x/board-dt.c
 create mode 100644 arch/arm/mach-stih41x/stih41x.c
 create mode 100644 arch/arm/mach-stih41x/stih41x.h
 create mode 100644 arch/arm/plat-stixxxx/Kconfig
 create mode 100644 arch/arm/plat-stixxxx/Makefile
 create mode 100644 arch/arm/plat-stixxxx/headsmp.S
 create mode 100644 arch/arm/plat-stixxxx/include/plat/hardware.h
 create mode 100644 arch/arm/plat-stixxxx/include/plat/smp.h
 create mode 100644 arch/arm/plat-stixxxx/platsmp.c

diff --git a/Documentation/arm/STiH41x/overview.txt b/Documentation/arm=
/STiH41x/overview.txt
new file mode 100644
index 0000000..2411506
--- /dev/null
+++ b/Documentation/arm/STiH41x/overview.txt
@@ -0,0 +1,39 @@
+			STiH41x ARM Linux Overview
+			=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+Introduction
+------------
+
+  The ST Microelectronics Multimedia and Application Processors range =
of
+  CortexA9 System-on-Chip are supported by the 'STixxxx' platform of
+  ARM Linux. Currently STiH415, STiH416 SOCs are supported with both
+  B2000 and B2020 Reference boards.
+
+
+  configuration
+  -------------
+
+  A generic configuration is provided for both STiH415/416, and can be=
 used as the
+  default by
+	make stih41x_defconfig
+
+  Layout
+  ------
+  The common files for multiple machine families (STiH415, STiH416, an=
d STiG125)
+  are located in the platform code contained in arch/arm/plat-stixxxx
+  with headers in plat/.
+	- common files to support Stixxxx SoCs which includes things
+	like platsmp.
+
+  Each machine series have a directory with name arch/arm/mach-sti fol=
lowed by
+  series name. Like mach-stih41x to support stih415 and stih416.
+
+  There is a generic board board-dt.c in each mach folder which suppor=
t
+  Flattened Device Tree, which means, It works with any compatible boa=
rd with
+  Device Trees.
+
+
+  Document Author
+  ---------------
+
+  Srinivas Kandagatla <srinivas.kandagatla@st.com>, (c) 2013 ST Microe=
lectronics
diff --git a/Documentation/arm/STiH41x/stih415-overview.txt b/Documenta=
tion/arm/STiH41x/stih415-overview.txt
new file mode 100644
index 0000000..1c264b7
--- /dev/null
+++ b/Documentation/arm/STiH41x/stih415-overview.txt
@@ -0,0 +1,12 @@
+			STiH415 Overview
+			=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Introduction
+------------
+
+    The STiH415 is the next generation of HD, AVC set-top box processo=
rs
+    for satellite, cable, terrestrial and IP-STB markets.
+
+    Features
+    - ARM Cortex-A9 1.0 GHz, dual-core CPU
+    - SATA2=C3=972,USB 2.0=C3=973, PCIe, Gbit Ethernet MAC=C3=972
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c8c524e..b960c7d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1106,6 +1106,9 @@ source "arch/arm/mach-socfpga/Kconfig"
=20
 source "arch/arm/plat-spear/Kconfig"
=20
+source "arch/arm/mach-stih41x/Kconfig"
+source "arch/arm/plat-stixxxx/Kconfig"
+
 source "arch/arm/mach-s3c24xx/Kconfig"
=20
 if ARCH_S3C64XX
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 9b31f43..42a5193 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -447,6 +447,16 @@ choice
 		  This option selects UART0 on VIA/Wondermedia System-on-a-chip
 		  devices, including VT8500, WM8505, WM8650 and WM8850.
=20
+	config DEBUG_STIH41X_UART
+		depends on ARCH_STIH41X
+		bool "Use StiH415/416 ASC for low-level debug"
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on StiH415/416 based platforms like B2000, B2020.
+		  It support UART2 and SBC_UART1.
+
+		  If unsure, say N.
+
 	config DEBUG_LL_UART_NONE
 		bool "No low-level debugging UART"
 		depends on !ARCH_MULTIPLATFORM
@@ -578,6 +588,33 @@ choice
=20
 endchoice
=20
+choice
+	prompt "Low-level debug console UART"
+	depends on DEBUG_LL && DEBUG_STIH41X_UART
+
+	config STIH41X_DEBUG_ASC2
+		bool "ASC2 UART"
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on STiH415/416 based platforms like b2000, which has
+		  default UART wired up to ASC2.
+
+		  If unsure, say N.
+
+	config STIH41X_DEBUG_SBC_ASC1
+		bool "SBC ASC1 UART"
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on STiH415/416 based platforms like b2020. which has
+		  default UART wired up to SBC ASC1.
+
+		  If unsure, say N.
+
+endchoice
+
+
+
+
 config DEBUG_LL_INCLUDE
 	string
 	default "debug/icedcc.S" if DEBUG_ICEDCC
@@ -600,6 +637,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/vt8500.S" if DEBUG_VT8500_UART0
 	default "debug/tegra.S" if DEBUG_TEGRA_UART
 	default "debug/zynq.S" if DEBUG_ZYNQ_UART0 || DEBUG_ZYNQ_UART1
+	default "debug/stixxxx.S" if DEBUG_STIH41X_UART
 	default "mach/debug-macro.S"
=20
 config EARLY_PRINTK
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index ee4605f..2bb7e7d 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -194,6 +194,7 @@ machine-$(CONFIG_ARCH_SOCFPGA)		+=3D socfpga
 machine-$(CONFIG_ARCH_SPEAR13XX)	+=3D spear13xx
 machine-$(CONFIG_ARCH_SPEAR3XX)		+=3D spear3xx
 machine-$(CONFIG_MACH_SPEAR600)		+=3D spear6xx
+machine-$(CONFIG_ARCH_STIH41X)		+=3D stih41x
 machine-$(CONFIG_ARCH_VIRT)		+=3D virt
 machine-$(CONFIG_ARCH_ZYNQ)		+=3D zynq
 machine-$(CONFIG_ARCH_SUNXI)		+=3D sunxi
@@ -207,6 +208,7 @@ plat-$(CONFIG_PLAT_ORION)	+=3D orion
 plat-$(CONFIG_PLAT_PXA)		+=3D pxa
 plat-$(CONFIG_PLAT_S3C24XX)	+=3D samsung
 plat-$(CONFIG_PLAT_S5P)		+=3D samsung
+plat-$(CONFIG_PLAT_STIXXXX)	+=3D stixxxx
 plat-$(CONFIG_PLAT_SPEAR)	+=3D spear
 plat-$(CONFIG_PLAT_VERSATILE)	+=3D versatile
=20
diff --git a/arch/arm/boot/dts/stih415-clock.dtsi b/arch/arm/boot/dts/s=
tih415-clock.dtsi
new file mode 100644
index 0000000..174c799
--- /dev/null
+++ b/arch/arm/boot/dts/stih415-clock.dtsi
@@ -0,0 +1,38 @@
+/*
+ * Copyright (C) 2013 STMicroelectronics (R&D) Limited
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/ {
+	clocks {
+		/*
+		 * Fixed 30MHz oscillator input to SoC
+		 */
+		CLK_SYSIN: CLK_SYSIN {
+			#clock-cells =3D <0>;
+			compatible =3D "fixed-clock";
+			clock-frequency =3D <30000000>;
+		};
+
+		/*
+		 * ARM Peripheral clock for timers
+		 */
+		arm_periph_clk: arm_periph_clk {
+			#clock-cells =3D <0>;
+			compatible =3D "fixed-clock";
+			clock-frequency =3D <500000000>;
+		};
+
+		/*
+		 * Bootloader initialized system infrastructure clock for
+		 * serial devices.
+		 */
+		CLKS_ICN_REG_0: CLKS_ICN_REG_0 {
+			#clock-cells =3D <0>;
+			compatible =3D "fixed-clock";
+			clock-frequency =3D <100000000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/stih415-pinctrl.dtsi b/arch/arm/boot/dts=
/stih415-pinctrl.dtsi
new file mode 100644
index 0000000..0f8c770
--- /dev/null
+++ b/arch/arm/boot/dts/stih415-pinctrl.dtsi
@@ -0,0 +1,480 @@
+/*
+ * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
+ * Author: Srinivas Kandagatla <srinivas.kandagatla@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ */
+#include "stih415.h"
+#include "stixxxx-pincfg.h"
+/ {
+
+	aliases {
+		gpio0	=3D &PIO0;
+		gpio1	=3D &PIO1;
+		gpio2	=3D &PIO2;
+		gpio3	=3D &PIO3;
+		gpio4	=3D &PIO4;
+		gpio5	=3D &PIO5;
+		gpio6	=3D &PIO6;
+		gpio7	=3D &PIO7;
+		gpio8	=3D &PIO8;
+		gpio9	=3D &PIO9;
+		gpio10	=3D &PIO10;
+		gpio11	=3D &PIO11;
+		gpio12	=3D &PIO12;
+		gpio13	=3D &PIO13;
+		gpio14	=3D &PIO14;
+		gpio15	=3D &PIO15;
+		gpio16	=3D &PIO16;
+		gpio17	=3D &PIO17;
+		gpio18	=3D &PIO18;
+		gpio19	=3D &PIO100;
+		gpio20	=3D &PIO101;
+		gpio21	=3D &PIO102;
+		gpio22	=3D &PIO103;
+		gpio23	=3D &PIO104;
+		gpio24	=3D &PIO105;
+		gpio25	=3D &PIO106;
+		gpio26	=3D &PIO107;
+	};
+
+
+	soc {
+		pin-controller {
+			#address-cells	=3D <1>;
+			#size-cells	=3D <1>;
+			#retime-delay-cells	=3D <4>;
+			compatible	=3D "st,stixxxx-pinctrl", "simple-bus";
+			st,retime-offset	=3D <&pio_retime_offset>;
+			st,retime-in-delay	=3D <0 500 1000 1500>;
+			st,retime-out-delay	=3D <0 1000 2000 3000>;
+			ranges;
+
+			PIO0: pinctrl@fe610000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfe610000 0x100>;
+				st,bank-name	=3D "PIO0";
+				st,alt-control	=3D <&SYSCFG_SBC(0) 0 31>;
+				st,oe-control	=3D <&SYSCFG_SBC(5) 0 7>;
+				st,pu-control	=3D <&SYSCFG_SBC(7) 0 7>;
+				st,od-control	=3D <&SYSCFG_SBC(9) 0 7>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_SBC(16) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_SBC(17) 0 31>;
+			};
+			PIO1: pinctrl@fe611000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfe611000 0x100>;
+				st,bank-name	=3D "PIO1";
+				st,alt-control	=3D <&SYSCFG_SBC(1) 0 31>;
+				st,oe-control	=3D <&SYSCFG_SBC(5) 8 15>;
+				st,pu-control	=3D <&SYSCFG_SBC(7) 8 15>;
+				st,od-control	=3D <&SYSCFG_SBC(9) 8 15>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_SBC(18) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_SBC(19) 0 31>;
+			};
+			PIO2: pinctrl@fe612000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfe612000 0x100>;
+				st,bank-name	=3D "PIO2";
+				st,alt-control	=3D <&SYSCFG_SBC(2) 0 31>;
+				st,oe-control	=3D <&SYSCFG_SBC(5) 16 23>;
+				st,pu-control	=3D <&SYSCFG_SBC(7) 16 23>;
+				st,od-control	=3D <&SYSCFG_SBC(9) 16 23>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_SBC(20) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_SBC(21) 0 31>;
+			};
+			PIO3: pinctrl@fe613000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfe613000 0x100>;
+				st,bank-name	=3D "PIO3";
+				st,alt-control	=3D <&SYSCFG_SBC(3) 0 31>;
+				st,oe-control	=3D <&SYSCFG_SBC(5) 24 31>;
+				st,pu-control	=3D <&SYSCFG_SBC(7) 24 31>;
+				st,od-control	=3D <&SYSCFG_SBC(9) 24 31>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_SBC(22) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_SBC(23) 0 31>;
+
+			};
+			PIO4: pinctrl@fe614000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfe614000 0x100>;
+				st,bank-name	=3D "PIO4";
+				st,alt-control	=3D <&SYSCFG_SBC(4) 0 31>;
+				st,oe-control	=3D <&SYSCFG_SBC(6) 0 7>;
+				st,pu-control	=3D <&SYSCFG_SBC(8) 0 7>;
+				st,od-control	=3D <&SYSCFG_SBC(10) 0 7>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_SBC(24) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_SBC(25) 0 31>;
+
+			};
+			 /* 5-12:pinctrl_FRONT */
+			PIO5: pinctrl@fee00000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfee00000 0x100>;
+				st,bank-name	=3D "PIO5";
+				st,alt-control	=3D <&SYSCFG_FRONT(100) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FRONT(108) 0 7>;
+				st,pu-control	=3D <&SYSCFG_FRONT(110) 0 7>;
+				st,od-control	=3D <&SYSCFG_FRONT(112) 0 7>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_FRONT(116) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FRONT(117) 0 31>;
+			};
+			PIO6: pinctrl@fee01000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfee01000 0x100>;
+				st,bank-name	=3D "PIO6";
+				st,alt-control	=3D <&SYSCFG_FRONT(101) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FRONT(108) 8 15>;
+				st,pu-control	=3D <&SYSCFG_FRONT(110) 8 15>;
+				st,od-control	=3D <&SYSCFG_FRONT(112) 8 15>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_FRONT(118) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FRONT(119) 0 31>;
+			};
+
+			PIO7: pinctrl@fee02000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfee02000 0x100>;
+				st,bank-name	=3D "PIO7";
+				st,alt-control	=3D <&SYSCFG_FRONT(102) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FRONT(108) 16 23>;
+				st,pu-control	=3D <&SYSCFG_FRONT(110) 16 23>;
+				st,od-control	=3D <&SYSCFG_FRONT(112) 16 23>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_FRONT(120) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FRONT(121) 0 31>;
+			};
+			PIO8: pinctrl@fee03000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfee03000 0x100>;
+				st,bank-name	=3D "PIO8";
+				st,alt-control	=3D <&SYSCFG_FRONT(103) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FRONT(108) 24 31>;
+				st,pu-control	=3D <&SYSCFG_FRONT(110) 24 31>;
+				st,od-control	=3D <&SYSCFG_FRONT(112) 24 31>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_FRONT(122) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FRONT(123) 0 31>;
+			};
+			PIO9: pinctrl@fee04000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfee04000 0x100>;
+				st,bank-name	=3D "PIO9";
+				st,alt-control	=3D <&SYSCFG_FRONT(104) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FRONT(109) 0 7>;
+				st,pu-control	=3D <&SYSCFG_FRONT(111) 0 7>;
+				st,od-control	=3D <&SYSCFG_FRONT(113) 0 7>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_FRONT(124) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FRONT(125) 0 31>;
+			};
+			PIO10: pinctrl@fee05000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfee05000 0x100>;
+				st,bank-name	=3D "PIO10";
+				st,alt-control	=3D <&SYSCFG_FRONT(105) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FRONT(109) 8 15>;
+				st,pu-control	=3D <&SYSCFG_FRONT(111) 8 15>;
+				st,od-control	=3D <&SYSCFG_FRONT(113) 8 15>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_FRONT(126) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FRONT(127) 0 31>;
+			};
+			PIO11: pinctrl@fee06000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfee06000 0x100>;
+				st,bank-name	=3D "PIO11";
+				st,alt-control	=3D <&SYSCFG_FRONT(106) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FRONT(109) 16 23>;
+				st,pu-control	=3D <&SYSCFG_FRONT(111) 16 23>;
+				st,od-control	=3D <&SYSCFG_FRONT(113) 16 23>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_FRONT(128) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FRONT(129) 0 31>;
+			};
+			PIO12: pinctrl@fee07000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfee07000 0x100>;
+				st,bank-name	=3D "PIO12";
+				st,alt-control	=3D <&SYSCFG_FRONT(107) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FRONT(109) 24 31>;
+				st,pu-control	=3D <&SYSCFG_FRONT(111) 24 31>;
+				st,od-control	=3D <&SYSCFG_FRONT(113) 24 31>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_FRONT(130) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FRONT(131) 0 31>;
+			};
+			 /* 13-18:pinctrl_REAR */
+			PIO13: pinctrl@fe820000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfe820000 0x100>;
+				st,bank-name	=3D "PIO13";
+				st,alt-control	=3D <&SYSCFG_REAR(300) 0 31>;
+				st,oe-control	=3D <&SYSCFG_REAR(306) 0 7>;
+				st,pu-control	=3D <&SYSCFG_REAR(308) 0 7>;
+				st,od-control	=3D <&SYSCFG_REAR(310) 0 7>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_REAR(338) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_REAR(339) 0 31>;
+			};
+			PIO14: pinctrl@fe821000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfe821000 0x100>;
+				st,bank-name	=3D "PIO14";
+				st,alt-control	=3D <&SYSCFG_REAR(301) 0 31>;
+				st,oe-control	=3D <&SYSCFG_REAR(306) 8 15>;
+				st,pu-control	=3D <&SYSCFG_REAR(308) 8 15>;
+				st,od-control	=3D <&SYSCFG_REAR(310) 8 15>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_REAR(340) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_REAR(341) 0 31>;
+			};
+			PIO15: pinctrl@fe822000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfe822000 0x100>;
+				st,bank-name	=3D "PIO15";
+				st,alt-control	=3D <&SYSCFG_REAR(302) 0 31>;
+				st,oe-control	=3D <&SYSCFG_REAR(306) 16 23>;
+				st,pu-control	=3D <&SYSCFG_REAR(308) 16 23>;
+				st,od-control	=3D <&SYSCFG_REAR(310) 16 23>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_REAR(342) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_REAR(343) 0 31>;
+			};
+			PIO16: pinctrl@fe823000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfe823000 0x100>;
+				st,bank-name	=3D "PIO16";
+				st,alt-control	=3D <&SYSCFG_REAR(303) 0 31>;
+				st,oe-control	=3D <&SYSCFG_REAR(306) 24 31>;
+				st,pu-control	=3D <&SYSCFG_REAR(308) 24 31>;
+				st,od-control	=3D <&SYSCFG_REAR(310) 24 31>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_REAR(344) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_REAR(345) 0 31>;
+
+			};
+			PIO17: pinctrl@fe824000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfe824000 0x100>;
+				st,bank-name	=3D "PIO17";
+				st,alt-control	=3D <&SYSCFG_REAR(304) 0 31>;
+				st,oe-control	=3D <&SYSCFG_REAR(307) 0 7>;
+				st,pu-control	=3D <&SYSCFG_REAR(309) 0 7>;
+				st,od-control	=3D <&SYSCFG_REAR(311) 0 7>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_REAR(346) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_REAR(347) 0 31>;
+
+			};
+			PIO18: pinctrl@fe825000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfe825000 0x100>;
+				st,bank-name	=3D "PIO18";
+				st,alt-control	=3D <&SYSCFG_REAR(305) 0 31>;
+				st,oe-control	=3D <&SYSCFG_REAR(307) 8 15>;
+				st,pu-control	=3D <&SYSCFG_REAR(309) 8 15>;
+				st,od-control	=3D <&SYSCFG_REAR(311) 8 15>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_REAR(348) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_REAR(349) 0 31>;
+
+			};
+			 /* MPE */
+			 /* 100-102:pinctrl_RIGHT (aka MPE_pinctrl) */
+			PIO100: pinctrl@fd6b0000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfd6b0000 0x100>;
+				st,bank-name	=3D "PIO100";
+				st,alt-control	=3D <&SYSCFG_LEFT(400) 0 31>;
+				st,oe-control	=3D <&SYSCFG_LEFT(403) 0 7>;
+				st,pu-control	=3D <&SYSCFG_LEFT(404) 0 7>;
+				st,od-control	=3D <&SYSCFG_LEFT(405) 0 7>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_LEFT(406) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_LEFT(407) 0 31>;
+			};
+			PIO101: pinctrl@fd6b1000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfd6b1000 0x100>;
+				st,bank-name	=3D "PIO101";
+				st,alt-control	=3D <&SYSCFG_LEFT(401) 0 31>;
+				st,oe-control	=3D <&SYSCFG_LEFT(403) 8 15>;
+				st,pu-control	=3D <&SYSCFG_LEFT(404) 8 15>;
+				st,od-control	=3D <&SYSCFG_LEFT(405) 8 15>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_LEFT(408) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_LEFT(409) 0 31>;
+
+			};
+			PIO102: pinctrl@fd6b2000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfd6b2000 0x100>;
+				st,bank-name	=3D "PIO102";
+				st,alt-control	=3D <&SYSCFG_LEFT(402) 0 31>;
+				st,oe-control	=3D <&SYSCFG_LEFT(403) 16 23>;
+				st,pu-control	=3D <&SYSCFG_LEFT(404) 16 23>;
+				st,od-control	=3D <&SYSCFG_LEFT(405) 16 23>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_LEFT(410) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_LEFT(411) 0 31>;
+
+			};
+			 /* 103-107:pinctrl_LEFT (aka pinctrl_1_MPE) */
+			PIO103: pinctrl@fd330000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfd330000 0x100>;
+				st,bank-name	=3D "PIO103";
+				st,alt-control	=3D <&SYSCFG_RIGHT(500) 0 31>;
+				st,oe-control	=3D <&SYSCFG_RIGHT(505) 0 7>;
+				st,pu-control	=3D <&SYSCFG_RIGHT(507) 0 7>;
+				st,od-control	=3D <&SYSCFG_RIGHT(509) 0 7>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_RIGHT(511) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_RIGHT(512) 0 31>;
+			};
+			PIO104: pinctrl@fd331000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfd331000 0x100>;
+				st,bank-name	=3D "PIO104";
+				st,alt-control	=3D <&SYSCFG_RIGHT(501) 0 31>;
+				st,oe-control	=3D <&SYSCFG_RIGHT(505) 8 15>;
+				st,pu-control	=3D <&SYSCFG_RIGHT(507) 8 15>;
+				st,od-control	=3D <&SYSCFG_RIGHT(509) 8 15>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_RIGHT(513) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_RIGHT(514) 0 31>;
+			};
+			PIO105: pinctrl@fd332000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfd332000 0x100>;
+				st,bank-name	=3D "PIO105";
+				st,alt-control	=3D <&SYSCFG_RIGHT(502) 0 31>;
+				st,oe-control	=3D <&SYSCFG_RIGHT(505) 16 23>;
+				st,pu-control	=3D <&SYSCFG_RIGHT(507) 16 23>;
+				st,od-control	=3D <&SYSCFG_RIGHT(509) 16 23>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_RIGHT(515) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_RIGHT(516) 0 31>;
+			};
+			PIO106: pinctrl@fd333000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfd333000 0x100>;
+				st,bank-name	=3D "PIO106";
+				st,alt-control	=3D <&SYSCFG_RIGHT(503) 0 31>;
+				st,oe-control	=3D <&SYSCFG_RIGHT(505) 24 31>;
+				st,pu-control	=3D <&SYSCFG_RIGHT(507) 24 31>;
+				st,od-control	=3D <&SYSCFG_RIGHT(509) 24 31>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_RIGHT(517) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_RIGHT(518) 0 31>;
+			};
+			PIO107: pinctrl@fd334000 {
+				gpio-controller;
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				reg	=3D <0xfd334000 0x100>;
+				st,bank-name	=3D "PIO107";
+				st,alt-control	=3D <&SYSCFG_RIGHT(504) 0 31>;
+				st,oe-control	=3D <&SYSCFG_RIGHT(506) 0 7>;
+				st,pu-control	=3D <&SYSCFG_RIGHT(508) 0 7>;
+				st,od-control	=3D <&SYSCFG_RIGHT(510) 0 7>;
+				st,retime-style	=3D "packed";
+				st,retime-control0	=3D <&SYSCFG_RIGHT(519) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_RIGHT(520) 0 31>;
+			};
+
+			uart2 {
+				pinctrl_uart2: uart2-0 {
+					st,function =3D <ALT2>;
+					st,pins {
+						tx	=3D <&PIO17 4 OUT>;
+						rx	=3D <&PIO17 5 IN>;
+					};
+				};
+			};
+
+			sbc_uart1 {
+				pinctrl_sbc_uart1: sbc_uart1 {
+					st,function =3D <ALT3>;
+					st,pins {
+						tx	=3D <&PIO2 6 OUT>;
+						rx	=3D <&PIO2 7 IN>;
+					};
+				};
+			};
+
+		};
+
+		pio_retime_offset: pio-retime-offset {
+			clk1notclk0	=3D <0>;
+			delay-lsb	=3D <2>;
+			delay-msb	=3D <3>;
+			invertclk	=3D <4>;
+			retime		=3D <5>;
+			clknotdata	=3D <6>;
+			double-edge	=3D <7>;
+		};
+
+	};
+};
diff --git a/arch/arm/boot/dts/stih415.dtsi b/arch/arm/boot/dts/stih415=
=2Edtsi
new file mode 100644
index 0000000..b881d22
--- /dev/null
+++ b/arch/arm/boot/dts/stih415.dtsi
@@ -0,0 +1,94 @@
+/*
+ * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
+ * Author: Srinivas Kandagatla <srinivas.kandagatla@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ */
+#include "stih41x.dtsi"
+#include "stih415-clock.dtsi"
+#include "stih415-pinctrl.dtsi"
+/ {
+
+	L2: cache-controller {
+		compatible =3D "arm,pl310-cache";
+		reg =3D <0xfffe2000 0x1000>;
+		arm,data-latency =3D <3 2 2>;
+		arm,tag-latency =3D <1 1 1>;
+		cache-unified;
+		cache-level =3D <2>;
+	};
+
+	soc {
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		#interrupt-cells =3D <3>;
+		interrupt-parent =3D <&intc>;
+		ranges;
+		compatible	=3D "simple-bus";
+
+		syscfg_sbc: syscon@fe600000{
+			compatible      =3D "syscon";
+			reg		=3D <0xfe600000 0xb4>;
+			syscon-name	=3D "SYSCFG_SBC";
+		};
+
+		syscfg_front: syscon@fee10000{
+			compatible      =3D "syscon";
+			reg		=3D <0xfee10000 0x194>;
+			syscon-name	=3D "SYSCFG_FRONT";
+		};
+
+		syscfg_rear: syscon@fe830000{
+			compatible      =3D "syscon";
+			reg		=3D <0xfe830000 0x190>;
+			syscon-name	=3D "SYSCFG_REAR";
+		};
+
+		syscfg_left: syscon@fd690000{
+			compatible      =3D "syscon";
+			reg		=3D <0xfd690000 0x78>;
+			syscon-name	=3D "SYSCFG_LEFT";
+		};
+
+		syscfg_right: syscon@fd320000{
+			compatible      =3D "syscon";
+			reg		=3D <0xfd320000 0x180>;
+			syscon-name	=3D "SYSCFG_RIGHT";
+		};
+
+		syscfg_system: syscon@fdde0000  {
+			compatible      =3D "syscon";
+			reg		=3D <0xfdde0000 0x15c>;
+			syscon-name	=3D "SYSCFG_SYSTEM";
+		};
+
+		syscfg_lpm: syscon@fe4b5100{
+			compatible      =3D "syscon";
+			reg		=3D <0xfe4b5100 0x08>;
+			syscon-name	=3D "LPM_CFG_REGS";
+		};
+
+		uart2: uart@fed32000 {
+			compatible	=3D "st,asc";
+			status 		=3D "disabled";
+			reg		=3D <0xfed32000 0x2c>;
+			interrupts	=3D <0 197 0>;
+			pinctrl-names 	=3D "default";
+			pinctrl-0 	=3D <&pinctrl_uart2>;
+			clocks		=3D <&CLKS_ICN_REG_0>;
+		};
+
+		/* SBC comms block ASCs in SASG1 */
+		sbc_uart1: uart@fe531000 {
+			compatible	=3D "st,asc";
+			status 		=3D "disabled";
+			reg		=3D <0xfe531000 0x2c>;
+			interrupts	=3D <0 210 0>;
+			clocks		=3D <&CLK_SYSIN>;
+			pinctrl-names 	=3D "default";
+			pinctrl-0	=3D <&pinctrl_sbc_uart1>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/stih415.h b/arch/arm/boot/dts/stih415.h
new file mode 100644
index 0000000..fc46ecc
--- /dev/null
+++ b/arch/arm/boot/dts/stih415.h
@@ -0,0 +1,20 @@
+#ifndef __STIH415_H_
+#define __STIH415_H_
+
+#define CONFIG_SBC(num)		(num)
+#define CONFIG_FRONT(num)	(num - 100)
+#define CONFIG_REAR(num)	(num - 300)
+#define CONFIG_LEFT(num)	(num - 400)
+#define CONFIG_RIGHT(num)	(num - 500)
+#define CONFIG_SYSTEM(num)	(num - 600)
+#define CONFIG_LPM(num)		(num)
+
+#define SYSCFG_SBC(num)		syscfg_sbc CONFIG_SBC(num)
+#define SYSCFG_FRONT(num)	syscfg_front CONFIG_FRONT(num)
+#define SYSCFG_REAR(num)	syscfg_rear CONFIG_REAR(num)
+#define SYSCFG_LEFT(num)	syscfg_left CONFIG_LEFT(num)
+#define SYSCFG_RIGHT(num)	syscfg_right CONFIG_RIGHT(num)
+#define SYSCFG_SYSTEM(num)	syscfg_system CONFIG_SYSTEM(num)
+#define SYSCFG_LPM(num)		syscfg_lpm CONFIG_LPM(num)
+
+#endif /* __STIH415_H_ */
diff --git a/arch/arm/boot/dts/stih41x.dtsi b/arch/arm/boot/dts/stih41x=
=2Edtsi
new file mode 100644
index 0000000..a7f0fa4
--- /dev/null
+++ b/arch/arm/boot/dts/stih41x.dtsi
@@ -0,0 +1,30 @@
+/ {
+	#address-cells =3D <1>;
+	#size-cells =3D <1>;
+
+	cpus {
+		cpu@0 {
+			compatible =3D "arm,cortex-a9";
+		};
+		cpu@1 {
+			compatible =3D "arm,cortex-a9";
+		};
+	};
+
+	intc: interrupt-controller@fffe1000 {
+		compatible =3D "arm,cortex-a9-gic";
+		#interrupt-cells =3D <3>;
+		interrupt-controller;
+		reg =3D <0xfffe1000 0x1000>,
+		      <0xfffe0100 0x100>;
+	};
+
+	timer@fffe0200 {
+		#interrupt-cells =3D <3>;
+		interrupt-parent =3D <&intc>;
+		compatible =3D "arm,cortex-a9-global-timer";
+		reg =3D <0xfffe0200 0x100>;
+		interrupts =3D <1 11 0x04>;
+		clocks =3D <&arm_periph_clk>;
+	};
+};
diff --git a/arch/arm/boot/dts/stixxxx-pincfg.h b/arch/arm/boot/dts/sti=
xxxx-pincfg.h
new file mode 100644
index 0000000..5398ff2
--- /dev/null
+++ b/arch/arm/boot/dts/stixxxx-pincfg.h
@@ -0,0 +1,95 @@
+#ifndef _ST_PINCFG_H_
+#define _ST_PINCFG_H
+
+/* Alternate functions */
+#define ALT1	1
+#define ALT2	2
+#define ALT3	3
+#define ALT4	4
+#define ALT5	5
+#define ALT6	6
+#define ALT7	7
+
+/* Output enable */
+#define OE_MASK			0x1
+#define OE_SHIFT		27
+#define OE			(1 << OE_SHIFT)
+
+/* Pull Up */
+#define PU_MASK			0x1
+#define PU_SHIFT		26
+#define PU			(1 << PU_SHIFT)
+
+/* Open Drain */
+#define OD_MASK			0x1
+#define OD_SHIFT		25
+#define OD			(1 << OD_SHIFT)
+
+#define RT_MASK			0x1
+#define RT_SHIFT		23
+#define RT			(1 << RT_SHIFT)
+
+#define INVERTCLK_MASK		0x1
+#define INVERTCLK_SHIFT		22
+#define INVERTCLK		(1 << INVERTCLK_SHIFT)
+
+#define CLKNOTDATA_MASK		0x1
+#define CLKNOTDATA_SHIFT	21
+#define CLKNOTDATA		(1 << CLKNOTDATA_SHIFT)
+
+#define DOUBLE_EDGE_MASK	 0x1
+#define DOUBLE_EDGE_SHIFT	 20
+#define DOUBLE_EDGE		(1 << DOUBLE_EDGE_SHIFT)
+
+#define CLK_MASK		0x3
+#define CLK_SHIFT		18
+#define CLK_A			(0 << CLK_SHIFT)
+#define CLK_B			(1 << CLK_SHIFT)
+#define CLK_C			(2 << CLK_SHIFT)
+#define CLK_D			(3 << CLK_SHIFT)
+
+/* User-frendly defines for Pin Direction */
+		/* oe =3D 0, pu =3D 0, od =3D 0 */
+#define IN			(0)
+		/* oe =3D 0, pu =3D 1, od =3D 0 */
+#define IN_PU			(PU)
+		/* oe =3D 1, pu =3D 0, od =3D 0 */
+#define OUT			(OE)
+		/* oe =3D 1, pu =3D 0, od =3D 1 */
+#define BIDIR			(OE | OD)
+		/* oe =3D 1, pu =3D 1, od =3D 1 */
+#define BIDIR_PU		(OE | PU | OD)
+
+/* RETIME_TYPE */
+/*
+ * B Mode
+ * Bypass retime with optional delay parameter
+ */
+#define BYPASS		(0)
+/*
+ * R0, R1, R0D, R1D modes
+ * single-edge data non inverted clock, retime data with clk
+ */
+#define SE_NICLK_IO	(RT)
+/*
+ * RIV0, RIV1, RIV0D, RIV1D modes
+ * single-edge data inverted clock, retime data with clk
+ */
+#define SE_ICLK_IO	(RT | INVERTCLK)
+/*
+ * R0E, R1E, R0ED, R1ED modes
+ * double-edge data, retime data with clk
+ */
+#define DE_IO		(RT | DOUBLE_EDGE)
+/*
+ * CIV0, CIV1 modes with inverted clock
+ * Retiming the clk pins will park clock & reduce the noise within the=
 core.
+ */
+#define ICLK		(RT | CLKNOTDATA | INVERTCLK)
+/*
+ * CLK0, CLK1 modes with non-inverted clock
+ * Retiming the clk pins will park clock & reduce the noise within the=
 core.
+ */
+#define NICLK		(RT | CLKNOTDATA)
+#endif /* _ST_PINCFG_H */
+
diff --git a/arch/arm/configs/stih41x_defconfig b/arch/arm/configs/stih=
41x_defconfig
new file mode 100644
index 0000000..dd9268b
--- /dev/null
+++ b/arch/arm/configs/stih41x_defconfig
@@ -0,0 +1,94 @@
+CONFIG_LOCALVERSION=3D"-STiH41x"
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SYSVIPC=3Dy
+CONFIG_BSD_PROCESS_ACCT=3Dy
+CONFIG_IKCONFIG=3Dy
+CONFIG_IKCONFIG_PROC=3Dy
+CONFIG_CGROUPS=3Dy
+CONFIG_CGROUP_FREEZER=3Dy
+CONFIG_CGROUP_DEVICE=3Dy
+CONFIG_CPUSETS=3Dy
+CONFIG_CGROUP_CPUACCT=3Dy
+CONFIG_RESOURCE_COUNTERS=3Dy
+CONFIG_NAMESPACES=3Dy
+CONFIG_RELAY=3Dy
+CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
+CONFIG_SYSCTL_SYSCALL=3Dy
+CONFIG_KALLSYMS_ALL=3Dy
+CONFIG_EMBEDDED=3Dy
+# CONFIG_COMPAT_BRK is not set
+CONFIG_KPROBES=3Dy
+CONFIG_MODULES=3Dy
+CONFIG_MODULE_UNLOAD=3Dy
+CONFIG_MODULE_SRCVERSION_ALL=3Dy
+CONFIG_BLK_DEV_INTEGRITY=3Dy
+CONFIG_ARCH_STIH41X=3Dy
+CONFIG_SOC_STIH415=3Dy
+# CONFIG_ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA is not set
+# CONFIG_SWP_EMULATE is not set
+CONFIG_ARM_ERRATA_720789=3Dy
+CONFIG_PL310_ERRATA_753970=3Dy
+CONFIG_ARM_ERRATA_754322=3Dy
+CONFIG_PL310_ERRATA_769419=3Dy
+CONFIG_SMP=3Dy
+CONFIG_VMSPLIT_2G=3Dy
+CONFIG_PREEMPT=3Dy
+CONFIG_AEABI=3Dy
+# CONFIG_OABI_COMPAT is not set
+CONFIG_KSM=3Dy
+CONFIG_VFP=3Dy
+CONFIG_NEON=3Dy
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_SUSPEND is not set
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+CONFIG_DEBUG_DEVRES=3Dy
+# CONFIG_BLK_DEV is not set
+# CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_INPUT_EVDEV=3Dy
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+CONFIG_VT_HW_CONSOLE_BINDING=3Dy
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVKMEM is not set
+CONFIG_HW_RANDOM=3Dy
+# CONFIG_HWMON is not set
+# CONFIG_HID is not set
+# CONFIG_USB_SUPPORT is not set
+CONFIG_NEW_LEDS=3Dy
+CONFIG_LEDS_CLASS=3Dy
+CONFIG_LEDS_GPIO=3Dy
+CONFIG_LEDS_TRIGGERS=3Dy
+CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dy
+CONFIG_LEDS_TRIGGER_GPIO=3Dy
+CONFIG_COMMON_CLK_DEBUG=3Dy
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT2_FS=3Dy
+CONFIG_EXT3_FS=3Dy
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_XFS_FS=3Dy
+# CONFIG_DNOTIFY is not set
+# CONFIG_PROC_PAGE_MONITOR is not set
+CONFIG_TMPFS=3Dy
+CONFIG_TMPFS_POSIX_ACL=3Dy
+CONFIG_NLS=3Dy
+CONFIG_PRINTK_TIME=3Dy
+CONFIG_FRAME_WARN=3D2048
+CONFIG_MAGIC_SYSRQ=3Dy
+CONFIG_UNUSED_SYMBOLS=3Dy
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_PREEMPT is not set
+CONFIG_DEBUG_INFO=3Dy
+# CONFIG_FTRACE is not set
+CONFIG_DEBUG_LL=3Dy
+CONFIG_DEBUG_STIH41X_UART=3Dy
+CONFIG_EARLY_PRINTK=3Dy
+CONFIG_SECURITYFS=3Dy
+CONFIG_CRYPTO_MANAGER=3Dy
+CONFIG_CRYPTO_SEQIV=3Dy
+CONFIG_CRYPTO_AES=3Dy
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+# CONFIG_CRYPTO_HW is not set
+CONFIG_CRC_T10DIF=3Dy
diff --git a/arch/arm/include/debug/stixxxx.S b/arch/arm/include/debug/=
stixxxx.S
new file mode 100644
index 0000000..7bc02a7
--- /dev/null
+++ b/arch/arm/include/debug/stixxxx.S
@@ -0,0 +1,61 @@
+/*
+ * arch/arm/include/debug/stixxxx.S
+ *
+ * Debugging macro include header
+ * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define STIH41X_COMMS_BASE              0xfed00000
+#define STIH41X_ASC2_BASE               (STIH41X_COMMS_BASE+0x32000)
+
+#define STIH41X_SBC_LPM_BASE            0xfe400000
+#define STIH41X_SBC_COMMS_BASE          (STIH41X_SBC_LPM_BASE + 0x1000=
00)
+#define STIH41X_SBC_ASC1_BASE           (STIH41X_SBC_COMMS_BASE + 0x31=
000)
+
+
+#define VIRT_ADDRESS(x)		(x - 0x1000000)
+
+#if IS_ENABLED(CONFIG_STIH41X_DEBUG_ASC2)
+#define DEBUG_LL_UART_BASE	STIH41X_ASC2_BASE
+#endif
+
+#if IS_ENABLED(CONFIG_STIH41X_DEBUG_SBC_ASC1)
+#define DEBUG_LL_UART_BASE	STIH41X_SBC_ASC1_BASE
+#endif
+
+#ifndef DEBUG_LL_UART_BASE
+#error "DEBUG UART is not Configured"
+#endif
+
+#define ASC_TX_BUF_OFF  0x04
+#define ASC_CTRL_OFF    0x0c
+#define ASC_STA_OFF     0x14
+
+#define ASC_STA_TX_FULL         (1<<9)
+#define ASC_STA_TX_EMPTY        (1<<1)
+
+
+		.macro	addruart, rp, rv, tmp
+		ldr	\rp,      =3DDEBUG_LL_UART_BASE	@ physical base
+		ldr	\rv,      =3DVIRT_ADDRESS(DEBUG_LL_UART_BASE) @ virt base
+		.endm
+
+                .macro  senduart,rd,rx
+                strb    \rd, [\rx, #ASC_TX_BUF_OFF]
+                .endm
+
+                .macro  waituart,rd,rx
+1001:           ldr     \rd, [\rx, #ASC_STA_OFF]
+                tst     \rd, #ASC_STA_TX_FULL
+                bne     1001b
+                .endm
+
+                .macro  busyuart,rd,rx
+1001:           ldr     \rd, [\rx, #ASC_STA_OFF]
+                tst     \rd, #ASC_STA_TX_EMPTY
+                beq     1001b
+                .endm
diff --git a/arch/arm/mach-stih41x/Kconfig b/arch/arm/mach-stih41x/Kcon=
fig
new file mode 100644
index 0000000..9c40540
--- /dev/null
+++ b/arch/arm/mach-stih41x/Kconfig
@@ -0,0 +1,35 @@
+config ARCH_STIH41X
+	bool "STMicroelectronics STiH41x SOCs with Flattened Device Tree" if =
ARCH_MULTI_V7
+	select GENERIC_CLOCKEVENTS
+	select CLKDEV_LOOKUP
+	select ARM_GIC
+	select HAVE_ARM_GT
+	select PINCTRL
+	select PINCTRL_STIXXXX
+	select MIGHT_HAVE_CACHE_L2X0
+	select HAVE_SMP
+	select GPIOLIB
+	select MACH_STIH41X_GENERIC
+	help
+	  Include support for STiH41x SOCs like STiH415/416 using the device =
tree
+	  for discovery
+	  More information at Documentation/arm/STiH41x and
+	  at Documentation/devicetree
+
+config MACH_STIH41X_GENERIC
+	bool
+
+if ARCH_STIH41X
+menu "STMicroelectronics Consumer Electronics SOCs"
+
+config SOC_STIH415
+	bool "STiH415 STMicroelectronics Consumer Electronics family"
+	select PLAT_STIXXXX
+	help
+	  This enables support for STMicroelectronics Digital Consumer
+	  Electronics family StiH415 parts, primarily targetted at set-top-bo=
x
+	  and other digital audio/video applications using Flattned Device
+	  Trees.
+
+endmenu
+endif
diff --git a/arch/arm/mach-stih41x/Makefile b/arch/arm/mach-stih41x/Mak=
efile
new file mode 100644
index 0000000..91d6863
--- /dev/null
+++ b/arch/arm/mach-stih41x/Makefile
@@ -0,0 +1,4 @@
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) :=3D -I$(srctree)/$(src)/include =
\
+	-I$(srctree)/arch/arm/plat-stixxxx/include
+obj-y		 			:=3D stih41x.o
+obj-$(CONFIG_MACH_STIH41X_GENERIC) 	+=3D board-dt.o
diff --git a/arch/arm/mach-stih41x/board-dt.c b/arch/arm/mach-stih41x/b=
oard-dt.c
new file mode 100644
index 0000000..c51e2c9
--- /dev/null
+++ b/arch/arm/mach-stih41x/board-dt.c
@@ -0,0 +1,76 @@
+/*
+ * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
+ * Author(s): Srinivas Kandagatla <srinivas.kandagatla@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/of_platform.h>
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/arm-gic.h>
+
+#include <asm/mach/arch.h>
+
+#include <plat/smp.h>
+#include <plat/hardware.h>
+
+#include "stih41x.h"
+
+static void __init stih41x_timer_init(void)
+{
+	of_clk_init(NULL);
+	clocksource_of_init();
+	stih41x_l2x0_init();
+}
+
+/*
+ * A basic implementation of irq_set_wake that ensures wakeup source
+ * interrupts are not disabled during PM_SUSPEND_FREEZE.
+ */
+static int stih41x_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct irq_desc *desc =3D irq_to_desc(d->irq);
+
+	if (on) {
+		if (desc->action)
+			desc->action->flags |=3D IRQF_NO_SUSPEND;
+	} else {
+		if (desc->action)
+			desc->action->flags &=3D ~IRQF_NO_SUSPEND;
+	}
+	return 0;
+}
+
+static void __init stih41x_irq_init(void)
+{
+	gic_arch_extn.irq_set_wake =3D stih41x_set_wake;
+	gic_arch_extn.flags =3D IRQCHIP_MASK_ON_SUSPEND;
+
+	irqchip_init();
+}
+
+void __init stih41x_dt_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table,
+				NULL, NULL);
+	return;
+}
+
+static const char *stih41x_dt_match[] __initdata =3D {
+	NULL
+};
+
+DT_MACHINE_START(STM, "STiH415 SoC with Flattened Device Tree")
+	.map_io		=3D stih41x_map_io,
+	.init_time	=3D stih41x_timer_init,
+	.init_machine	=3D stih41x_dt_init,
+	.smp		=3D smp_ops(stixxxx_smp_ops),
+	.init_irq	=3D stih41x_irq_init,
+	.dt_compat	=3D stih41x_dt_match,
+MACHINE_END
diff --git a/arch/arm/mach-stih41x/stih41x.c b/arch/arm/mach-stih41x/st=
ih41x.c
new file mode 100644
index 0000000..b76cac1
--- /dev/null
+++ b/arch/arm/mach-stih41x/stih41x.c
@@ -0,0 +1,82 @@
+/*
+ * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
+ * Author(s): Srinivas Kandagatla <srinivas.kandagatla@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/bug.h>
+
+#include <asm/mach/map.h>
+#include <asm/page.h>
+#include <asm/mach/arch.h>
+
+#include <plat/smp.h>
+#include <plat/hardware.h>
+#include <asm/hardware/cache-l2x0.h>
+
+#define MPE41_SCU_BASE			(0xFFFE0000 + 0x0000)
+
+#define STIH41X_COMMS_BASE              0xFED00000
+#define STIH41X_ASC0_BASE               (STIH41X_COMMS_BASE+0x30000)
+#define STIH41X_ASC1_BASE               (STIH41X_COMMS_BASE+0x31000)
+#define STIH41X_ASC2_BASE               (STIH41X_COMMS_BASE+0x32000)
+#define STIH41X_ASC3_BASE               (STIH41X_COMMS_BASE+0x33000)
+
+#define STIH41X_SBC_LPM_BASE            0xfe400000
+#define STIH41X_SBC_COMMS_BASE          (STIH41X_SBC_LPM_BASE + 0x1000=
00)
+#define STIH41X_SBC_ASC0_BASE           (STIH41X_SBC_COMMS_BASE + 0x30=
000)
+#define STIH41X_SBC_ASC1_BASE           (STIH41X_SBC_COMMS_BASE + 0x31=
000)
+
+
+static struct map_desc stih41x_io_desc[] __initdata =3D {
+#ifdef CONFIG_SMP
+	{
+		.virtual	=3D IO_ADDRESS(MPE41_SCU_BASE),
+		.pfn		=3D __phys_to_pfn(MPE41_SCU_BASE),
+		.length		=3D SZ_4K,
+		.type		=3D MT_DEVICE,
+	},
+#endif
+#ifdef CONFIG_STIH41X_DEBUG_ASC2
+	{ /* For DEBUG_LL and Early Prints */
+		.virtual	=3D IO_ADDRESS(STIH41X_ASC2_BASE),
+		.pfn		=3D __phys_to_pfn(STIH41X_ASC2_BASE),
+		.length		=3D SZ_4K,
+		.type		=3D MT_DEVICE,
+	},
+#endif
+#ifdef CONFIG_STIH41X_DEBUG_SBC_ASC1
+	{
+		.virtual	=3D IO_ADDRESS(STIH41X_SBC_ASC1_BASE),
+		.pfn		=3D __phys_to_pfn(STIH41X_SBC_ASC1_BASE),
+		.length		=3D SZ_4K,
+		.type		=3D MT_DEVICE,
+	},
+#endif
+};
+
+void __init stih41x_map_io(void)
+{
+#ifdef CONFIG_SMP
+	stixxxx_scu_base_addr =3D ((void __iomem *)IO_ADDRESS(MPE41_SCU_BASE)=
);
+#endif
+	iotable_init(stih41x_io_desc, ARRAY_SIZE(stih41x_io_desc));
+}
+
+void __init stih41x_l2x0_init(void)
+{
+	u32 way_size =3D 0x4;
+	u32 aux_ctrl;
+
+	aux_ctrl =3D (0x1 << L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT) |
+		(0x1 << L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT) |
+		(0x1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT) |
+		(way_size << L2X0_AUX_CTRL_WAY_SIZE_SHIFT);
+
+	l2x0_of_init(aux_ctrl, L2X0_AUX_CTRL_MASK);
+}
diff --git a/arch/arm/mach-stih41x/stih41x.h b/arch/arm/mach-stih41x/st=
ih41x.h
new file mode 100644
index 0000000..6c0e90b
--- /dev/null
+++ b/arch/arm/mach-stih41x/stih41x.h
@@ -0,0 +1,7 @@
+#ifndef __STIH41X_H_
+#define __STIH41X_H_
+
+void stih41x_map_io(void);
+void stih41x_l2x0_init(void);
+
+#endif /* __STIH41X_H_ */
diff --git a/arch/arm/plat-stixxxx/Kconfig b/arch/arm/plat-stixxxx/Kcon=
fig
new file mode 100644
index 0000000..ceeda96
--- /dev/null
+++ b/arch/arm/plat-stixxxx/Kconfig
@@ -0,0 +1,2 @@
+config PLAT_STIXXXX
+	bool
diff --git a/arch/arm/plat-stixxxx/Makefile b/arch/arm/plat-stixxxx/Mak=
efile
new file mode 100644
index 0000000..36534a9
--- /dev/null
+++ b/arch/arm/plat-stixxxx/Makefile
@@ -0,0 +1,2 @@
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) :=3D -I$(srctree)/$(src)/include
+obj-$(CONFIG_SMP)		+=3D platsmp.o headsmp.o
diff --git a/arch/arm/plat-stixxxx/headsmp.S b/arch/arm/plat-stixxxx/he=
adsmp.S
new file mode 100644
index 0000000..3dd5c04
--- /dev/null
+++ b/arch/arm/plat-stixxxx/headsmp.S
@@ -0,0 +1,44 @@
+/*
+ *  arch/arm/plat-stixxxx/headsmp.S
+ *
+ * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
+ *		http://www.st.com
+ *
+ * Cloned from linux/arch/arm/mach-vexpress/headsmp.S
+ *
+ *  Copyright (c) 2003 ARM Limited
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+	__INIT
+
+/*
+ * ST specific entry point for secondary CPUs.  This provides
+ * a "holding pen" into which all secondary cores are held until we're
+ * ready for them to initialise.
+ */
+ENTRY(stixxxx_secondary_startup)
+	mrc	p15, 0, r0, c0, c0, 5
+	and	r0, r0, #15
+	adr	r4, 1f
+	ldmia	r4, {r5, r6}
+	sub	r4, r4, r5
+	add	r6, r6, r4
+pen:	ldr	r7, [r6]
+	cmp	r7, r0
+	bne	pen
+
+	/*
+	 * we've been released from the holding pen: secondary_stack
+	 * should now contain the SVC stack for this core
+	 */
+	b	secondary_startup
+
+1:	.long	.
+	.long	pen_release
diff --git a/arch/arm/plat-stixxxx/include/plat/hardware.h b/arch/arm/p=
lat-stixxxx/include/plat/hardware.h
new file mode 100644
index 0000000..7a9a804
--- /dev/null
+++ b/arch/arm/plat-stixxxx/include/plat/hardware.h
@@ -0,0 +1,20 @@
+/*
+ *  arch/arm/plat-stixxxx/include/mach/hardware.h
+ *
+ * Copyright (C) 2013 STMicroelectronics Limited.
+ * Author: Stuart Menefy <stuart.menefy@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __PLAT_HARDWARE_H
+#define __PLAT_HARDWARE_H
+/*
+ * Statically mapped addresses:
+ *
+ * fc000000 to ffffffff (physical) -> fb000000 to feffffff (virtual)
+ */
+#define IO_ADDRESS(x)		(((x) & 0x03ffffff) + 0xfb000000)
+#endif
diff --git a/arch/arm/plat-stixxxx/include/plat/smp.h b/arch/arm/plat-s=
tixxxx/include/plat/smp.h
new file mode 100644
index 0000000..c3e3d40
--- /dev/null
+++ b/arch/arm/plat-stixxxx/include/plat/smp.h
@@ -0,0 +1,19 @@
+/*
+ *  arch/arm/plat-stixxxx/platsmp.c
+ *
+ * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
+ *		http://www.st.com
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __PLAT_SMP_H
+#define __PLAT_SMP_H
+
+extern struct smp_operations	stixxxx_smp_ops;
+extern void __iomem *stixxxx_scu_base_addr;
+extern void stixxxx_secondary_startup(void);
+
+#endif
diff --git a/arch/arm/plat-stixxxx/platsmp.c b/arch/arm/plat-stixxxx/pl=
atsmp.c
new file mode 100644
index 0000000..256640d
--- /dev/null
+++ b/arch/arm/plat-stixxxx/platsmp.c
@@ -0,0 +1,144 @@
+/*
+ *  arch/arm/plat-stixxxx/platsmp.c
+ *
+ * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
+ *		http://www.st.com
+ *
+ * Cloned from linux/arch/arm/mach-vexpress/platsmp.c
+ *
+ *  Copyright (C) 2002 ARM Ltd.
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/smp.h>
+#include <linux/io.h>
+#include <linux/irqchip/arm-gic.h>
+
+#include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
+#include <asm/smp_scu.h>
+
+#include <plat/hardware.h>
+#include <plat/smp.h>
+
+
+void __iomem *stixxxx_scu_base_addr;
+
+static void __cpuinit write_pen_release(int val)
+{
+	pen_release =3D val;
+	smp_wmb();
+	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
+	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+}
+
+static inline unsigned int get_core_count(void)
+{
+	return scu_get_core_count(stixxxx_scu_base_addr);
+}
+
+static DEFINE_SPINLOCK(boot_lock);
+
+void __cpuinit stixxxx_secondary_init(unsigned int cpu)
+{
+	trace_hardirqs_off();
+
+	/*
+	 * if any interrupts are already enabled for the primary
+	 * core (e.g. timer irq), then they will not have been enabled
+	 * for us: do so
+	 */
+	gic_secondary_init(0);
+
+	/*
+	 * let the primary processor know we're out of the
+	 * pen, then head off into the C entry point
+	 */
+	write_pen_release(-1);
+
+	/*
+	 * Synchronise with the boot thread.
+	 */
+	spin_lock(&boot_lock);
+	spin_unlock(&boot_lock);
+}
+
+int __cpuinit stixxxx_boot_secondary(unsigned int cpu, struct task_str=
uct *idle)
+{
+	unsigned long timeout;
+
+	/*
+	 * set synchronisation state between this boot processor
+	 * and the secondary one
+	 */
+	spin_lock(&boot_lock);
+
+	/*
+	 * The secondary processor is waiting to be released from
+	 * the holding pen - release it, then wait for it to flag
+	 * that it has been released by resetting pen_release.
+	 *
+	 * Note that "pen_release" is the hardware CPU ID, whereas
+	 * "cpu" is Linux's internal ID.
+	 */
+	write_pen_release(cpu_logical_map(cpu));
+
+	/*
+	 * Send the secondary CPU a soft interrupt, thereby causing
+	 * it to jump to the secondary entrypoint.
+	 */
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+
+	timeout =3D jiffies + (1 * HZ);
+	while (time_before(jiffies, timeout)) {
+		smp_rmb();
+		if (pen_release =3D=3D -1)
+			break;
+
+		udelay(10);
+	}
+
+	/*
+	 * now the secondary core is starting up let it run its
+	 * calibrations, then wait for it to finish
+	 */
+	spin_unlock(&boot_lock);
+
+	return pen_release !=3D -1 ? -ENOSYS : 0;
+}
+
+/*
+ * Initialise the CPU possible map early - this describes the CPUs
+ * which may be present or become present in the system.
+ */
+void __init stixxxx_smp_init_cpus(void)
+{
+	unsigned int i, ncores =3D get_core_count();
+
+	if (ncores > nr_cpu_ids) {
+		pr_warn("STM: %u greater than maximum (%u), clipping\n",
+			ncores, nr_cpu_ids);
+		ncores =3D nr_cpu_ids;
+	}
+
+	for (i =3D 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+}
+
+void __init stixxxx_smp_prepare_cpus(unsigned int max_cpus)
+{
+	scu_enable(stixxxx_scu_base_addr);
+}
+
+struct smp_operations __initdata stixxxx_smp_ops =3D {
+	.smp_init_cpus		=3D stixxxx_smp_init_cpus,
+	.smp_prepare_cpus	=3D stixxxx_smp_prepare_cpus,
+	.smp_secondary_init	=3D stixxxx_secondary_init,
+	.smp_boot_secondary	=3D stixxxx_boot_secondary,
+};
--=20
1.7.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
