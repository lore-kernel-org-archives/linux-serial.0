From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: =?UTF-8?q?=5BRFC=206/8=5D=20ARM=3Astih41x=3A=20Add=20STiH416=20SOC=20support?=
Date: Wed,  8 May 2013 15:11:58 +0100
Message-ID: <1368022318-2380-1-git-send-email-srinivas.kandagatla@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@arm.linux.org.uk, arnd@arndb.de, olof@lixom.net
Cc: Rob Landley <rob@landley.net>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Samuel Ortiz <sameo@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Srinivas Kandagatla <srinivas.kandagatla@st.com>, Stuart Menefy <stuart.menefy@st.com>, Shawn Guo <shawn.guo@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Stephen Warren <swarren@nvidia.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Nicolas Pitre <nico@linaro.org>, Will Deacon <will.deacon@arm.com>, Dave Martin <dave.martin@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <dong.aisheng@linaro.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozla
List-Id: linux-serial@vger.kernel.org

=46rom: Srinivas Kandagatla <srinivas.kandagatla@st.com>

The STiH416 is advanced HD AVC processor with 3D graphics acceleration
and 1.2-GHz ARM Cortex-A9 SMP CPU.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
CC: Stephen Gallimore <stephen.gallimore@st.com>
CC: Stuart Menefy <stuart.menefy@st.com>
---
 Documentation/arm/STiH41x/stih416-overview.txt |   12 +
 arch/arm/boot/dts/stih416-clock.dtsi           |   41 ++
 arch/arm/boot/dts/stih416-pinctrl.dtsi         |  718 ++++++++++++++++=
++++++++
 arch/arm/boot/dts/stih416.dtsi                 |  103 ++++
 arch/arm/boot/dts/stih416.h                    |   24 +
 arch/arm/configs/stih41x_defconfig             |    1 +
 arch/arm/mach-stih41x/Kconfig                  |    9 +
 arch/arm/mach-stih41x/board-dt.c               |    2 +-
 8 files changed, 909 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/arm/STiH41x/stih416-overview.txt
 create mode 100644 arch/arm/boot/dts/stih416-clock.dtsi
 create mode 100644 arch/arm/boot/dts/stih416-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stih416.dtsi
 create mode 100644 arch/arm/boot/dts/stih416.h

diff --git a/Documentation/arm/STiH41x/stih416-overview.txt b/Documenta=
tion/arm/STiH41x/stih416-overview.txt
new file mode 100644
index 0000000..e060867
--- /dev/null
+++ b/Documentation/arm/STiH41x/stih416-overview.txt
@@ -0,0 +1,12 @@
+			STiH416 Overview
+			=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Introduction
+------------
+
+    The STiH416 is the next generation of HD, AVC set-top box processo=
rs
+    for satellite, cable, terrestrial and IP-STB markets.
+
+    Features
+    - ARM Cortex-A9 1.2 GHz dual core CPU
+    - SATA2=C3=972,USB 2.0=C3=973, PCIe, Gbit Ethernet MAC=C3=972
diff --git a/arch/arm/boot/dts/stih416-clock.dtsi b/arch/arm/boot/dts/s=
tih416-clock.dtsi
new file mode 100644
index 0000000..7026bf1
--- /dev/null
+++ b/arch/arm/boot/dts/stih416-clock.dtsi
@@ -0,0 +1,41 @@
+/*
+ * Copyright (C) 2013 STMicroelectronics R&D Limited
+ * <stlinux-devel@stlinux.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/ {
+	clocks {
+		/*
+		 * Fixed 30MHz oscillator inputs to SoC
+		 */
+		CLK_SYSIN: CLK_SYSIN {
+			#clock-cells =3D <0>;
+			compatible =3D "fixed-clock";
+			clock-frequency =3D <30000000>;
+			clock-output-names =3D "CLK_SYSIN";
+		};
+
+		/*
+		 * ARM Peripheral clock for timers
+		 */
+		arm_periph_clk: arm_periph_clk {
+			#clock-cells =3D <0>;
+			compatible =3D "fixed-clock";
+			clock-frequency =3D <600000000>;
+		};
+
+		/*
+		 * Bootloader initialized system infrastructure clock for
+		 * serial devices.
+		 */
+		CLK_S_ICN_REG_0: clockgenA0@4 {
+			#clock-cells =3D <0>;
+			compatible =3D "fixed-clock";
+			clock-frequency =3D <100000000>;
+			clock-output-names =3D "CLK_S_ICN_REG_0";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/stih416-pinctrl.dtsi b/arch/arm/boot/dts=
/stih416-pinctrl.dtsi
new file mode 100644
index 0000000..f1266bb
--- /dev/null
+++ b/arch/arm/boot/dts/stih416-pinctrl.dtsi
@@ -0,0 +1,718 @@
+
+/*
+ * Copyright (C) 2013 STMicroelectronics Limited.
+ * Author: Srinivas Kandagatla <srinivas.kandagatla@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ */
+#include "stixxxx-pincfg.h"
+#include "stih416.h"
+/ {
+
+	aliases {
+		gpio0	=3D &PIO0;
+		gpio1	=3D &PIO1;
+		gpio2	=3D &PIO2;
+		gpio3	=3D &PIO3;
+		gpio4	=3D &PIO4;
+		gpio5	=3D &PIO40;
+		gpio6	=3D &PIO5;
+		gpio7	=3D &PIO6;
+		gpio8	=3D &PIO7;
+		gpio9	=3D &PIO8;
+		gpio10	=3D &PIO9;
+		gpio11	=3D &PIO10;
+		gpio12	=3D &PIO11;
+		gpio13	=3D &PIO12;
+		gpio14	=3D &PIO30;
+		gpio15	=3D &PIO31;
+		gpio16	=3D &PIO13;
+		gpio17	=3D &PIO14;
+		gpio18	=3D &PIO15;
+		gpio19	=3D &PIO16;
+		gpio20	=3D &PIO17;
+		gpio21	=3D &PIO18;
+		gpio22	=3D &PIO100;
+		gpio23	=3D &PIO101;
+		gpio24	=3D &PIO102;
+		gpio25	=3D &PIO103;
+		gpio26	=3D &PIO104;
+		gpio27	=3D &PIO105;
+		gpio28	=3D &PIO106;
+		gpio29	=3D &PIO107;
+	};
+
+
+	soc {
+		pin-controller {
+			#address-cells	=3D <1>;
+			#size-cells	=3D <1>;
+			#retime-delay-cells	=3D <14>;
+			compatible	=3D "st,stixxxx-pinctrl", "simple-bus";
+			st,retime-in-delay	=3D <0 300 500 750 1000 1250 1500 1750 2000 2250=
 2500 2750 3000 3250>;
+			st,retime-out-delay	=3D <0 300 500 750 1000 1250 1500 1750 2000 225=
0 2500 2750 3000 3250>;
+			ranges;
+			PIO0: pinctrl@fe610000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfe610000 0x100>;
+				st,bank-name 	=3D "PIO0";
+				st,alt-control	=3D <&SYSCFG_SBC(0) 0 31>;
+				st,oe-control	=3D <&SYSCFG_SBC(40) 0 7>;
+				st,pu-control	=3D <&SYSCFG_SBC(50) 0 7>;
+				st,od-control	=3D <&SYSCFG_SBC(60) 0 7>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_SBC(100) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_SBC(101) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_SBC(102) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_SBC(103) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_SBC(104) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_SBC(105) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_SBC(106) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_SBC(107) 0 31>;
+			};
+			PIO1: pinctrl@fe611000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfe611000 0x100>;
+				st,bank-name 	=3D "PIO1";
+				st,alt-control	=3D <&SYSCFG_SBC(1) 0 31>;
+				st,oe-control	=3D <&SYSCFG_SBC(40) 8 15>;
+				st,pu-control	=3D <&SYSCFG_SBC(50) 8 15>;
+				st,od-control	=3D <&SYSCFG_SBC(60) 8 15>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_SBC(108) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_SBC(109) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_SBC(110) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_SBC(111) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_SBC(112) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_SBC(113) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_SBC(114) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_SBC(115) 0 31>;
+			};
+			PIO2: pinctrl@fe612000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfe612000 0x100>;
+				st,bank-name 	=3D "PIO2";
+				st,alt-control	=3D <&SYSCFG_SBC(2) 0 31>;
+				st,oe-control	=3D <&SYSCFG_SBC(40) 16 23>;
+				st,pu-control	=3D <&SYSCFG_SBC(50) 16 23>;
+				st,od-control	=3D <&SYSCFG_SBC(60) 16 23>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_SBC(116) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_SBC(117) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_SBC(118) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_SBC(119) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_SBC(120) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_SBC(121) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_SBC(122) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_SBC(123) 0 31>;
+			};
+			PIO3: pinctrl@fe613000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfe613000 0x100>;
+				st,bank-name 	=3D "PIO3";
+				st,alt-control	=3D <&SYSCFG_SBC(3) 0 31>;
+				st,oe-control	=3D <&SYSCFG_SBC(40) 24 31>;
+				st,pu-control	=3D <&SYSCFG_SBC(50) 24 31>;
+				st,od-control	=3D <&SYSCFG_SBC(60) 24 31>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_SBC(124) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_SBC(125) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_SBC(126) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_SBC(127) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_SBC(128) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_SBC(129) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_SBC(130) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_SBC(131) 0 31>;
+			};
+
+			PIO4: pinctrl@fe614000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfe614000 0x100>;
+				st,bank-name 	=3D "PIO4";
+				st,alt-control	=3D <&SYSCFG_SBC(4) 0 31>;
+				st,oe-control	=3D <&SYSCFG_SBC(41) 0 7>;
+				st,pu-control	=3D <&SYSCFG_SBC(51) 0 7>;
+				st,od-control	=3D <&SYSCFG_SBC(61) 0 7>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_SBC(132) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_SBC(133) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_SBC(134) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_SBC(135) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_SBC(136) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_SBC(137) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_SBC(138) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_SBC(139) 0 31>;
+			};
+
+			PIO40: pinctrl@fe615000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfe615000 0x100>;
+				st,bank-name 	=3D "PIO40";
+				st,alt-control	=3D <&SYSCFG_SBC(5) 0 31>;
+				st,oe-control	=3D <&SYSCFG_SBC(41) 8 15>;
+				st,pu-control	=3D <&SYSCFG_SBC(51) 8 15>;
+				st,od-control	=3D <&SYSCFG_SBC(61) 8 15>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0x7f>;
+				st,retime-control0	=3D <&SYSCFG_SBC(140) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_SBC(141) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_SBC(142) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_SBC(143) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_SBC(144) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_SBC(145) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_SBC(146) 0 31>;
+			};
+
+			PIO5: pinctrl@fee00000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfee00000 0x100>;
+				st,bank-name 	=3D "PIO5";
+				st,alt-control	=3D <&SYSCFG_FRONT(1000) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FRONT(1040) 0 7>;
+				st,pu-control	=3D <&SYSCFG_FRONT(1050) 0 7>;
+				st,od-control	=3D <&SYSCFG_FRONT(1060) 0 7>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_FRONT(1100) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FRONT(1101) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_FRONT(1102) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_FRONT(1103) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_FRONT(1104) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_FRONT(1105) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_FRONT(1106) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_FRONT(1107) 0 31>;
+			};
+			PIO6: pinctrl@fee01000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfee01000 0x100>;
+				st,bank-name 	=3D "PIO6";
+				st,alt-control	=3D <&SYSCFG_FRONT(1001) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FRONT(1040) 8 15>;
+				st,pu-control	=3D <&SYSCFG_FRONT(1050) 8 15>;
+				st,od-control	=3D <&SYSCFG_FRONT(1060) 8 15>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_FRONT(1108) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FRONT(1109) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_FRONT(1110) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_FRONT(1111) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_FRONT(1112) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_FRONT(1113) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_FRONT(1114) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_FRONT(1115) 0 31>;
+			};
+			PIO7: pinctrl@fee02000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfee02000 0x100>;
+				st,bank-name 	=3D "PIO7";
+				st,alt-control	=3D <&SYSCFG_FRONT(1002) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FRONT(1040) 16 23>;
+				st,pu-control	=3D <&SYSCFG_FRONT(1050) 16 23>;
+				st,od-control	=3D <&SYSCFG_FRONT(1060) 16 23>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_FRONT(1116) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FRONT(1117) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_FRONT(1118) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_FRONT(1119) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_FRONT(1120) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_FRONT(1121) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_FRONT(1122) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_FRONT(1123) 0 31>;
+			};
+			PIO8: pinctrl@fee03000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfee03000 0x100>;
+				st,bank-name 	=3D "PIO8";
+				st,alt-control	=3D <&SYSCFG_FRONT(1003) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FRONT(1040) 24 31>;
+				st,pu-control	=3D <&SYSCFG_FRONT(1050) 24 31>;
+				st,od-control	=3D <&SYSCFG_FRONT(1060) 24 31>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_FRONT(1124) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FRONT(1125) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_FRONT(1126) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_FRONT(1127) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_FRONT(1128) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_FRONT(1129) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_FRONT(1130) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_FRONT(1131) 0 31>;
+			};
+
+			PIO9: pinctrl@fee04000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfee04000 0x100>;
+				st,bank-name 	=3D "PIO9";
+				st,alt-control	=3D <&SYSCFG_FRONT(1004) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FRONT(1041) 0 7>;
+				st,pu-control	=3D <&SYSCFG_FRONT(1051) 0 7>;
+				st,od-control	=3D <&SYSCFG_FRONT(1061) 0 7>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_FRONT(1132) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FRONT(1133) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_FRONT(1134) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_FRONT(1135) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_FRONT(1136) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_FRONT(1137) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_FRONT(1138) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_FRONT(1139) 0 31>;
+			};
+			PIO10: pinctrl@fee05000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfee05000 0x100>;
+				st,bank-name 	=3D "PIO10";
+				st,alt-control	=3D <&SYSCFG_FRONT(1005) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FRONT(1041) 8 15>;
+				st,pu-control	=3D <&SYSCFG_FRONT(1051) 8 15>;
+				st,od-control	=3D <&SYSCFG_FRONT(1061) 8 15>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_FRONT(1140) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FRONT(1141) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_FRONT(1142) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_FRONT(1143) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_FRONT(1144) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_FRONT(1145) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_FRONT(1146) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_FRONT(1147) 0 31>;
+			};
+			PIO11: pinctrl@fee06000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfee06000 0x100>;
+				st,bank-name 	=3D "PIO11";
+				st,alt-control	=3D <&SYSCFG_FRONT(1006) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FRONT(1041) 16 23>;
+				st,pu-control	=3D <&SYSCFG_FRONT(1051) 16 23>;
+				st,od-control	=3D <&SYSCFG_FRONT(1061) 16 23>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_FRONT(1148) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FRONT(1149) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_FRONT(1150) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_FRONT(1151) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_FRONT(1152) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_FRONT(1153) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_FRONT(1154) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_FRONT(1155) 0 31>;
+			};
+			PIO12: pinctrl@fee07000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfee07000 0x100>;
+				st,bank-name 	=3D "PIO12";
+				st,alt-control	=3D <&SYSCFG_FRONT(1007) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FRONT(1041) 24 31>;
+				st,pu-control	=3D <&SYSCFG_FRONT(1051) 24 31>;
+				st,od-control	=3D <&SYSCFG_FRONT(1061) 24 31>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_FRONT(1156) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FRONT(1157) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_FRONT(1158) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_FRONT(1159) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_FRONT(1160) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_FRONT(1161) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_FRONT(1162) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_FRONT(1163) 0 31>;
+			};
+
+			PIO30: pinctrl@fee08000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfee08000 0x100>;
+				st,bank-name 	=3D "PIO30";
+				st,alt-control	=3D <&SYSCFG_FRONT(1008) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FRONT(1042) 0 7>;
+				st,pu-control	=3D <&SYSCFG_FRONT(1052) 0 7>;
+				st,od-control	=3D <&SYSCFG_FRONT(1062) 0 7>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_FRONT(1164) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FRONT(1165) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_FRONT(1166) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_FRONT(1167) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_FRONT(1168) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_FRONT(1169) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_FRONT(1170) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_FRONT(1171) 0 31>;
+			};
+
+			PIO31: pinctrl@fee09000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfee09000 0x100>;
+				st,bank-name 	=3D "PIO31";
+				st,alt-control	=3D <&SYSCFG_FRONT(1009) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FRONT(1042) 8 15>;
+				st,pu-control	=3D <&SYSCFG_FRONT(1052) 8 15>;
+				st,od-control	=3D <&SYSCFG_FRONT(1062) 8 15>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_FRONT(1172) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FRONT(1173) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_FRONT(1174) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_FRONT(1175) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_FRONT(1176) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_FRONT(1177) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_FRONT(1178) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_FRONT(1179) 0 31>;
+			};
+
+
+
+			PIO13: pinctrl@fe820000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfe820000 0x100>;
+				st,bank-name 	=3D "PIO13";
+				st,alt-control	=3D <&SYSCFG_REAR(2000) 0 31>;
+				st,oe-control	=3D <&SYSCFG_REAR(2040) 0 7>;
+				st,pu-control	=3D <&SYSCFG_REAR(2050) 0 7>;
+				st,od-control	=3D <&SYSCFG_REAR(2060) 0 7>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_REAR(2100) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_REAR(2101) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_REAR(2102) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_REAR(2103) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_REAR(2104) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_REAR(2105) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_REAR(2106) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_REAR(2107) 0 31>;
+			};
+			PIO14: pinctrl@fe821000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfe821000 0x100>;
+				st,bank-name 	=3D "PIO14";
+				st,alt-control	=3D <&SYSCFG_REAR(2001) 0 31>;
+				st,oe-control	=3D <&SYSCFG_REAR(2040) 8 15>;
+				st,pu-control	=3D <&SYSCFG_REAR(2050) 8 15>;
+				st,od-control	=3D <&SYSCFG_REAR(2060) 8 15>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_REAR(2108) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_REAR(2109) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_REAR(2110) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_REAR(2111) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_REAR(2112) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_REAR(2113) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_REAR(2114) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_REAR(2115) 0 31>;
+			};
+			PIO15: pinctrl@fe822000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfe822000 0x100>;
+				st,bank-name 	=3D "PIO15";
+				st,alt-control	=3D <&SYSCFG_REAR(2002) 0 31>;
+				st,oe-control	=3D <&SYSCFG_REAR(2040) 16 23>;
+				st,pu-control	=3D <&SYSCFG_REAR(2050) 16 23>;
+				st,od-control	=3D <&SYSCFG_REAR(2060) 16 23>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_REAR(2116) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_REAR(2117) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_REAR(2118) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_REAR(2119) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_REAR(2120) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_REAR(2121) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_REAR(2122) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_REAR(2123) 0 31>;
+			};
+			PIO16: pinctrl@fe823000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfe823000 0x100>;
+				st,bank-name 	=3D "PIO16";
+				st,alt-control	=3D <&SYSCFG_REAR(2003) 0 31>;
+				st,oe-control	=3D <&SYSCFG_REAR(2040) 24 31>;
+				st,pu-control	=3D <&SYSCFG_REAR(2050) 24 31>;
+				st,od-control	=3D <&SYSCFG_REAR(2060) 24 31>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_REAR(2124) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_REAR(2125) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_REAR(2126) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_REAR(2127) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_REAR(2128) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_REAR(2129) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_REAR(2130) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_REAR(2131) 0 31>;
+			};
+
+			PIO17: pinctrl@fe824000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfe824000 0x100>;
+				st,bank-name 	=3D "PIO17";
+				st,alt-control	=3D <&SYSCFG_REAR(2004) 0 31>;
+				st,oe-control	=3D <&SYSCFG_REAR(2041) 0 7>;
+				st,pu-control	=3D <&SYSCFG_REAR(2051) 0 7>;
+				st,od-control	=3D <&SYSCFG_REAR(2061) 0 7>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_REAR(2132) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_REAR(2133) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_REAR(2134) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_REAR(2135) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_REAR(2136) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_REAR(2137) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_REAR(2138) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_REAR(2139) 0 31>;
+			};
+
+			PIO18: pinctrl@fe825000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfe825000 0x100>;
+				st,bank-name 	=3D "PIO18";
+				st,alt-control	=3D <&SYSCFG_REAR(2005) 0 31>;
+				st,oe-control	=3D <&SYSCFG_REAR(2041) 8 15>;
+				st,pu-control	=3D <&SYSCFG_REAR(2051) 8 15>;
+				st,od-control	=3D <&SYSCFG_REAR(2061) 8 15>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xf>;
+				st,retime-control0	=3D <&SYSCFG_REAR(2140) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_REAR(2141) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_REAR(2142) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_REAR(2143) 0 31>;
+			};
+			PIO100: pinctrl@fd6b0000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfd6b0000 0x100>;
+				st,bank-name 	=3D "PIO100";
+				st,alt-control	=3D <&SYSCFG_FVDP_FE(5000) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FVDP_FE(5040) 0 7>;
+				st,pu-control	=3D <&SYSCFG_FVDP_FE(5050) 0 7>;
+				st,od-control	=3D <&SYSCFG_FVDP_FE(5060) 0 7>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_FVDP_FE(5100) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FVDP_FE(5101) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_FVDP_FE(5102) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_FVDP_FE(5103) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_FVDP_FE(5104) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_FVDP_FE(5105) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_FVDP_FE(5106) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_FVDP_FE(5107) 0 31>;
+			};
+
+			PIO101: pinctrl@fd6b1000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfd6b1000 0x100>;
+				st,bank-name 	=3D "PIO101";
+				st,alt-control	=3D <&SYSCFG_FVDP_FE(5001) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FVDP_FE(5040) 8 15>;
+				st,pu-control	=3D <&SYSCFG_FVDP_FE(5050) 8 15>;
+				st,od-control	=3D <&SYSCFG_FVDP_FE(5060) 8 15>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_FVDP_FE(5108) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FVDP_FE(5109) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_FVDP_FE(5110) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_FVDP_FE(5111) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_FVDP_FE(5112) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_FVDP_FE(5113) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_FVDP_FE(5114) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_FVDP_FE(5115) 0 31>;
+			};
+
+			PIO102: pinctrl@fd6b2000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfd6b2000 0x100>;
+				st,bank-name 	=3D "PIO102";
+				st,alt-control	=3D <&SYSCFG_FVDP_FE(5002) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FVDP_FE(5040) 16 23>;
+				st,pu-control	=3D <&SYSCFG_FVDP_FE(5050) 16 23>;
+				st,od-control	=3D <&SYSCFG_FVDP_FE(5060) 16 23>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_FVDP_FE(5116) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FVDP_FE(5117) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_FVDP_FE(5118) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_FVDP_FE(5119) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_FVDP_FE(5120) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_FVDP_FE(5121) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_FVDP_FE(5122) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_FVDP_FE(5123) 0 31>;
+			};
+
+
+
+			PIO103: pinctrl@fd330000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfd330000 0x100>;
+				st,bank-name 	=3D "PIO103";
+				st,alt-control	=3D <&SYSCFG_FVDP_LITE(6000) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FVDP_LITE(6040) 0 7>;
+				st,pu-control	=3D <&SYSCFG_FVDP_LITE(6050) 0 7>;
+				st,od-control	=3D <&SYSCFG_FVDP_LITE(6060) 0 7>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_FVDP_LITE(6100) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FVDP_LITE(6101) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_FVDP_LITE(6102) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_FVDP_LITE(6103) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_FVDP_LITE(6104) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_FVDP_LITE(6105) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_FVDP_LITE(6106) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_FVDP_LITE(6107) 0 31>;
+			};
+			PIO104: pinctrl@fd331000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfd331000 0x100>;
+				st,bank-name 	=3D "PIO104";
+				st,alt-control	=3D <&SYSCFG_FVDP_LITE(6001) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FVDP_LITE(6040) 8 15>;
+				st,pu-control	=3D <&SYSCFG_FVDP_LITE(6050) 8 15>;
+				st,od-control	=3D <&SYSCFG_FVDP_LITE(6060) 8 15>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_FVDP_LITE(6108) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FVDP_LITE(6109) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_FVDP_LITE(6110) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_FVDP_LITE(6111) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_FVDP_LITE(6112) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_FVDP_LITE(6113) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_FVDP_LITE(6114) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_FVDP_LITE(6115) 0 31>;
+			};
+			PIO105: pinctrl@fd332000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfd332000 0x100>;
+				st,bank-name 	=3D "PIO105";
+				st,alt-control	=3D <&SYSCFG_FVDP_LITE(6002) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FVDP_LITE(6040) 16 23>;
+				st,pu-control	=3D <&SYSCFG_FVDP_LITE(6050) 16 23>;
+				st,od-control	=3D <&SYSCFG_FVDP_LITE(6060) 16 23>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_FVDP_LITE(6116) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FVDP_LITE(6117) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_FVDP_LITE(6118) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_FVDP_LITE(6119) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_FVDP_LITE(6120) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_FVDP_LITE(6121) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_FVDP_LITE(6122) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_FVDP_LITE(6123) 0 31>;
+			};
+			PIO106: pinctrl@fd333000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfd333000 0x100>;
+				st,bank-name 	=3D "PIO106";
+				st,alt-control	=3D <&SYSCFG_FVDP_LITE(6003) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FVDP_LITE(6040) 24 31>;
+				st,pu-control	=3D <&SYSCFG_FVDP_LITE(6050) 24 31>;
+				st,od-control	=3D <&SYSCFG_FVDP_LITE(6060) 24 31>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xff>;
+				st,retime-control0	=3D <&SYSCFG_FVDP_LITE(6124) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FVDP_LITE(6125) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_FVDP_LITE(6126) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_FVDP_LITE(6127) 0 31>;
+				st,retime-control4	=3D <&SYSCFG_FVDP_LITE(6128) 0 31>;
+				st,retime-control5	=3D <&SYSCFG_FVDP_LITE(6129) 0 31>;
+				st,retime-control6	=3D <&SYSCFG_FVDP_LITE(6130) 0 31>;
+				st,retime-control7	=3D <&SYSCFG_FVDP_LITE(6131) 0 31>;
+			};
+
+			PIO107: pinctrl@fd334000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg	=3D <0xfd334000 0x100>;
+				st,bank-name 	=3D "PIO107";
+				st,alt-control	=3D <&SYSCFG_FVDP_LITE(6004) 0 31>;
+				st,oe-control	=3D <&SYSCFG_FVDP_LITE(6041) 0 7>;
+				st,pu-control	=3D <&SYSCFG_FVDP_LITE(6051) 0 7>;
+				st,od-control	=3D <&SYSCFG_FVDP_LITE(6061) 0 7>;
+				st,retime-style	=3D "dedicated";
+				st,retime-pin-mask	=3D <0xf>;
+				st,retime-control0	=3D <&SYSCFG_FVDP_LITE(6132) 0 31>;
+				st,retime-control1	=3D <&SYSCFG_FVDP_LITE(6133) 0 31>;
+				st,retime-control2	=3D <&SYSCFG_FVDP_LITE(6134) 0 31>;
+				st,retime-control3	=3D <&SYSCFG_FVDP_LITE(6135) 0 31>;
+			};
+
+			uart2 {
+				pinctrl_uart2: uart2-0 {
+					st,function =3D <ALT2>;
+					st,pins {
+						tx	=3D <&PIO17 4 OUT>;
+						rx	=3D <&PIO17 5 IN>;
+						output-enable	=3D <&PIO11 3 OUT>;
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
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416=
=2Edtsi
new file mode 100644
index 0000000..47439b3
--- /dev/null
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -0,0 +1,103 @@
+/*
+ * Copyright (C) 2012 STMicroelectronics Limited.
+ * Author: Srinivas Kandagatla <srinivas.kandagatla@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ */
+#include "stih41x.dtsi"
+#include "stih416-clock.dtsi"
+#include "stih416-pinctrl.dtsi"
+/ {
+	L2: cache-controller {
+		compatible =3D "arm,pl310-cache";
+		reg =3D <0xfffe2000 0x1000>;
+		arm,data-latency =3D <3 3 3>;
+		arm,tag-latency =3D <2 2 2>;
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
+		syscfg_sbc:syscon@fe600000{
+			compatible	=3D "syscon";
+			reg		=3D <0xfe600000 0x1000>;
+			syscon-name	=3D "SYSCFG_SBC";
+		};
+		syscfg_front:syscon@fee10000{
+			compatible	=3D "syscon";
+			reg		=3D <0xfee10000 0x1000>;
+			syscon-name	=3D "SYSCFG_FRONT";
+		};
+		syscfg_rear:syscon@fe830000{
+			compatible	=3D "syscon";
+			reg		=3D <0xfe830000 0x1000>;
+			syscon-name	=3D "SYSCFG_REAR";
+		};
+
+		/* MPE */
+		syscfg_fvdp_fe:syscon@fddf0000{
+			compatible	=3D "syscon";
+			reg		=3D <0xfddf0000 0x1000>;
+			syscon-name	=3D "SYSCFG_FVDP_FE";
+		};
+		syscfg_fvdp_lite:syscon@fd6a0000{
+			compatible	=3D "syscon";
+			reg		=3D <0xfd6a0000 0x1000>;
+			syscon-name	=3D "SYSCFG_FVDP_LITE";
+		};
+
+		syscfg_cpu:syscon@fdde0000{
+			compatible	=3D "syscon";
+			reg		=3D <0xfdde0000 0x1000>;
+			syscon-name	=3D "SYSCFG_CPU";
+		};
+
+		syscfg_compo:syscon@fd320000{
+			compatible	=3D "syscon";
+			reg		=3D <0xfd320000 0x1000>;
+			syscon-name	=3D "SYSCFG_COMPO";
+		};
+
+		syscfg_transport:syscon@fd690000{
+			compatible	=3D "syscon";
+			reg		=3D <0xfd690000 0x1000>;
+			syscon-name	=3D "SYSCFG_TRANSPORT";
+		};
+
+		syscfg_lpm:syscon@fe4b5100{
+			compatible	=3D "syscon";
+			reg		=3D <0xfe4b5100 0x54>;
+			syscon-name	=3D "LPM_CFG_REGS";
+		};
+
+		uart2: uart@fed32000{
+			compatible	=3D "st,asc";
+			status 		=3D "disabled";
+			reg		=3D <0xfed32000 0x2c>;
+			interrupts	=3D <0 197 0>;
+			clocks          =3D <&CLK_S_ICN_REG_0>;
+			pinctrl-names 	=3D "default";
+			pinctrl-0 	=3D <&pinctrl_uart2>;
+		};
+
+		/* SBC_UART1 */
+		sbc_uart1: uart@fe531000 {
+			compatible	=3D "st,asc";
+			status 		=3D "disabled";
+			reg		=3D <0xfe531000 0x2c>;
+			interrupts	=3D <0 210 0>;
+			pinctrl-names 	=3D "default";
+			pinctrl-0 	=3D <&pinctrl_sbc_uart1>;
+			clocks          =3D <&CLK_SYSIN>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/stih416.h b/arch/arm/boot/dts/stih416.h
new file mode 100644
index 0000000..2e27792
--- /dev/null
+++ b/arch/arm/boot/dts/stih416.h
@@ -0,0 +1,24 @@
+#ifndef __STIH416_H_
+#define __STIH416_H_
+
+#define CONFIG_SBC(num)		num
+#define CONFIG_FRONT(num)	(num - 1000)
+#define CONFIG_REAR(num)	(num - 2000)
+#define CONFIG_FVDP_FE(num)	(num - 5000)
+#define CONFIG_FVDP_LITE(num)	(num - 6000)
+#define CONFIG_CPU(num)		(num - 7000)
+#define CONFIG_COMPO(num)	(num - 8000)
+#define CONFIG_TRANSPORT(num)	(num - 9000)
+#define CONFIG_LPM(num)		num
+
+#define SYSCFG_SBC(num)		syscfg_sbc CONFIG_SBC(num)
+#define SYSCFG_FRONT(num)	syscfg_front CONFIG_FRONT(num)
+#define SYSCFG_REAR(num)	syscfg_rear CONFIG_REAR(num)
+#define SYSCFG_FVDP_FE(num)	syscfg_fvdp_fe CONFIG_FVDP_FE(num)
+#define SYSCFG_FVDP_LITE(num)	syscfg_fvdp_lite CONFIG_FVDP_LITE(num)
+#define SYSCFG_CPU(num)		syscfg_cpu CONFIG_CPU(num)
+#define SYSCFG_COMPO(num)	syscfg_compo CONFIG_COMPO(num)
+#define SYSCFG_TRANSPORT(num)	syscfg_transport CONFIG_TRANSPORT(num)
+#define SYSCFG_LPM(num)		syscfg_lpm CONFIG_LPM(num)
+
+#endif /* __STIH416_H_ */
diff --git a/arch/arm/configs/stih41x_defconfig b/arch/arm/configs/stih=
41x_defconfig
index dd9268b..cc4e2dc 100644
--- a/arch/arm/configs/stih41x_defconfig
+++ b/arch/arm/configs/stih41x_defconfig
@@ -24,6 +24,7 @@ CONFIG_MODULE_SRCVERSION_ALL=3Dy
 CONFIG_BLK_DEV_INTEGRITY=3Dy
 CONFIG_ARCH_STIH41X=3Dy
 CONFIG_SOC_STIH415=3Dy
+CONFIG_SOC_STIH416=3Dy
 # CONFIG_ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA is not set
 # CONFIG_SWP_EMULATE is not set
 CONFIG_ARM_ERRATA_720789=3Dy
diff --git a/arch/arm/mach-stih41x/Kconfig b/arch/arm/mach-stih41x/Kcon=
fig
index 9c40540..848d3e8 100644
--- a/arch/arm/mach-stih41x/Kconfig
+++ b/arch/arm/mach-stih41x/Kconfig
@@ -31,5 +31,14 @@ config SOC_STIH415
 	  and other digital audio/video applications using Flattned Device
 	  Trees.
=20
+config SOC_STIH416
+	bool "STiH416 STMicroelectronics Consumer Electronics family"
+	select PLAT_STIXXXX
+	help
+	  This enables support for STMicroelectronics Digital Consumer
+	  Electronics family StiH416 parts, primarily targetted at set-top-bo=
x
+	  and other digital audio/video applications using Flattened Device
+	  Trees.
+
 endmenu
 endif
diff --git a/arch/arm/mach-stih41x/board-dt.c b/arch/arm/mach-stih41x/b=
oard-dt.c
index c51e2c9..8005f71 100644
--- a/arch/arm/mach-stih41x/board-dt.c
+++ b/arch/arm/mach-stih41x/board-dt.c
@@ -66,7 +66,7 @@ static const char *stih41x_dt_match[] __initdata =3D =
{
 	NULL
 };
=20
-DT_MACHINE_START(STM, "STiH415 SoC with Flattened Device Tree")
+DT_MACHINE_START(STM, "STiH415/416 SoC with Flattened Device Tree")
 	.map_io		=3D stih41x_map_io,
 	.init_time	=3D stih41x_timer_init,
 	.init_machine	=3D stih41x_dt_init,
--=20
1.7.6.5
