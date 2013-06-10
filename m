From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: =?UTF-8?q?=5BPATCH=20v2=2007/11=5D=20ARM=3Astixxxx=3A=20Add=20STiH416=20SOC=20support?=
Date: Mon, 10 Jun 2013 10:27:05 +0100
Message-ID: <1370856425-7135-1-git-send-email-srinivas.kandagatla@st.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Stultz <john.stultz@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux@arm.linux.org.uk, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Mark Brown <broonie@kernel.org>, Mauro Carvalho Chehab <mchehab@redhat.com>, Olof Johansson <olof@lixom.net>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Samuel Ortiz <sameo@linux.intel.com>, Srinivas Kandagatla <srinivas.kandagatla@st.com>, Stephen Gallimore <stephen.gallimore@st.com>, Stuart Menefy <stuart.menefy@st.com>, Thomas Gleixner <tglx@linutronix.de>, Tony Prisk <linux@prisktech.co.nz>
List-Id: linux-serial@vger.kernel.org

The STiH416 is advanced HD AVC processor with 3D graphics acceleration
and 1.2-GHz ARM Cortex-A9 SMP CPU.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
CC: Stephen Gallimore <stephen.gallimore@st.com>
CC: Stuart Menefy <stuart.menefy@st.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/arm/stixxxx/stih416-overview.txt |   12 +
 arch/arm/boot/dts/stih416-clock.dtsi           |   41 +++
 arch/arm/boot/dts/stih416-pinctrl.dtsi         |  377 ++++++++++++++++=
++++++++
 arch/arm/boot/dts/stih416.dtsi                 |  111 +++++++
 arch/arm/mach-stixxxx/board-dt.c               |    3 +-
 5 files changed, 543 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/arm/stixxxx/stih416-overview.txt
 create mode 100644 arch/arm/boot/dts/stih416-clock.dtsi
 create mode 100644 arch/arm/boot/dts/stih416-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stih416.dtsi

diff --git a/Documentation/arm/stixxxx/stih416-overview.txt b/Documenta=
tion/arm/stixxxx/stih416-overview.txt
new file mode 100644
index 0000000..e060867
--- /dev/null
+++ b/Documentation/arm/stixxxx/stih416-overview.txt
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
index 0000000..15843a9
--- /dev/null
+++ b/arch/arm/boot/dts/stih416-pinctrl.dtsi
@@ -0,0 +1,377 @@
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
+	soc {
+		pin-controller-sbc {
+			#address-cells	=3D <1>;
+			#size-cells	=3D <1>;
+			compatible	=3D "st,stih416-pinctrl", "simple-bus";
+			st,retime-in-delay	=3D <0 300 500 750 1000 1250 1500 1750 2000 2250=
 2500 2750 3000 3250>;
+			st,retime-out-delay	=3D <0 300 500 750 1000 1250 1500 1750 2000 225=
0 2500 2750 3000 3250>;
+			st,syscfg		=3D <&syscfg_sbc>;
+			st,syscfg-offsets	=3D <0 40 50 60 100>;
+			ranges;
+			PIO0: pinctrl@fe610000 {
+				#gpio-cells =3D <1>;
+				compatible =3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfe610000 0x100>;
+				st,bank-name  =3D "PIO0";
+				st,retime-pin-mask =3D <0xff>;
+			};
+			PIO1: pinctrl@fe611000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfe611000 0x100>;
+				st,bank-name  =3D "PIO1";
+				st,retime-pin-mask =3D <0xff>;
+			};
+			PIO2: pinctrl@fe612000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfe612000 0x100>;
+				st,bank-name  =3D "PIO2";
+				st,retime-pin-mask =3D <0xff>;
+			};
+			PIO3: pinctrl@fe613000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfe613000 0x100>;
+				st,bank-name  =3D "PIO3";
+				st,retime-pin-mask =3D <0xff>;
+			};
+
+			PIO4: pinctrl@fe614000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfe614000 0x100>;
+				st,bank-name  =3D "PIO4";
+				st,retime-pin-mask =3D <0xff>;
+			};
+
+			PIO40: pinctrl@fe615000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfe615000 0x100>;
+				st,bank-name  =3D "PIO40";
+				st,retime-pin-mask =3D <0x7f>;
+			};
+
+			sbc_serial1 {
+				pinctrl_sbc_serial1: sbc_serial1 {
+					st,function =3D <ALT3>;
+					st,pins {
+						tx	=3D <&PIO2 6 OUT>;
+						rx	=3D <&PIO2 7 IN>;
+					};
+				};
+			};
+		};
+
+		pin-controller-front {
+			#address-cells	=3D <1>;
+			#size-cells	=3D <1>;
+			compatible	=3D "st,stih416-pinctrl", "simple-bus";
+			st,retime-in-delay	=3D <0 300 500 750 1000 1250 1500 1750 2000 2250=
 2500 2750 3000 3250>;
+			st,retime-out-delay	=3D <0 300 500 750 1000 1250 1500 1750 2000 225=
0 2500 2750 3000 3250>;
+			st,syscfg		=3D <&syscfg_front>;
+			st,syscfg-offsets	=3D <0 40 50 60 100>;
+			ranges;
+
+			PIO5: pinctrl@fee00000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfee00000 0x100>;
+				st,bank-name  =3D "PIO5";
+				st,retime-pin-mask =3D <0xff>;
+			};
+			PIO6: pinctrl@fee01000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfee01000 0x100>;
+				st,bank-name  =3D "PIO6";
+				st,retime-pin-mask =3D <0xff>;
+			};
+			PIO7: pinctrl@fee02000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfee02000 0x100>;
+				st,bank-name  =3D "PIO7";
+				st,retime-pin-mask =3D <0xff>;
+			};
+			PIO8: pinctrl@fee03000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfee03000 0x100>;
+				st,bank-name  =3D "PIO8";
+				st,retime-pin-mask =3D <0xff>;
+			};
+
+			PIO9: pinctrl@fee04000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfee04000 0x100>;
+				st,bank-name  =3D "PIO9";
+				st,retime-pin-mask =3D <0xff>;
+			};
+			PIO10: pinctrl@fee05000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfee05000 0x100>;
+				st,bank-name  =3D "PIO10";
+				st,retime-pin-mask =3D <0xff>;
+			};
+			PIO11: pinctrl@fee06000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfee06000 0x100>;
+				st,bank-name  =3D "PIO11";
+				st,retime-pin-mask =3D <0xff>;
+			};
+			PIO12: pinctrl@fee07000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfee07000 0x100>;
+				st,bank-name  =3D "PIO12";
+				st,retime-pin-mask =3D <0xff>;
+			};
+
+			PIO30: pinctrl@fee08000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfee08000 0x100>;
+				st,bank-name  =3D "PIO30";
+				st,retime-pin-mask =3D <0xff>;
+			};
+
+			PIO31: pinctrl@fee09000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfee09000 0x100>;
+				st,bank-name  =3D "PIO31";
+				st,retime-pin-mask =3D <0xff>;
+			};
+		};
+
+		pin-controller-rear {
+			#address-cells	=3D <1>;
+			#size-cells	=3D <1>;
+			compatible	=3D "st,stih416-pinctrl", "simple-bus";
+			st,retime-in-delay	=3D <0 300 500 750 1000 1250 1500 1750 2000 2250=
 2500 2750 3000 3250>;
+			st,retime-out-delay	=3D <0 300 500 750 1000 1250 1500 1750 2000 225=
0 2500 2750 3000 3250>;
+			st,syscfg		=3D <&syscfg_rear>;
+			st,syscfg-offsets	=3D <0 40 50 60 100>;
+			ranges;
+
+			PIO13: pinctrl@fe820000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfe820000 0x100>;
+				st,bank-name  =3D "PIO13";
+				st,retime-pin-mask =3D <0xff>;
+			};
+			PIO14: pinctrl@fe821000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfe821000 0x100>;
+				st,bank-name  =3D "PIO14";
+				st,retime-pin-mask =3D <0xff>;
+			};
+			PIO15: pinctrl@fe822000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfe822000 0x100>;
+				st,bank-name  =3D "PIO15";
+				st,retime-pin-mask =3D <0xff>;
+			};
+			PIO16: pinctrl@fe823000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfe823000 0x100>;
+				st,bank-name  =3D "PIO16";
+				st,retime-pin-mask =3D <0xff>;
+			};
+
+			PIO17: pinctrl@fe824000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfe824000 0x100>;
+				st,bank-name  =3D "PIO17";
+				st,retime-pin-mask =3D <0xff>;
+			};
+
+			PIO18: pinctrl@fe825000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfe825000 0x100>;
+				st,bank-name  =3D "PIO18";
+				st,retime-pin-mask =3D <0xf>;
+			};
+
+			serial2 {
+				pinctrl_serial2: serial2-0 {
+					st,function =3D <ALT2>;
+					st,pins {
+						tx	=3D <&PIO17 4 OUT>;
+						rx	=3D <&PIO17 5 IN>;
+						output-enable	=3D <&PIO11 3 OUT>;
+					};
+				};
+			};
+		};
+
+		pin-controller-fvdp-fe {
+			#address-cells	=3D <1>;
+			#size-cells	=3D <1>;
+			compatible	=3D "st,stih416-pinctrl", "simple-bus";
+			st,retime-in-delay	=3D <0 300 500 750 1000 1250 1500 1750 2000 2250=
 2500 2750 3000 3250>;
+			st,retime-out-delay	=3D <0 300 500 750 1000 1250 1500 1750 2000 225=
0 2500 2750 3000 3250>;
+			st,syscfg		=3D <&syscfg_fvdp_fe>;
+			st,syscfg-offsets	=3D <0 40 50 60 100>;
+			ranges;
+
+			PIO100: pinctrl@fd6b0000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfd6b0000 0x100>;
+				st,bank-name  =3D "PIO100";
+				st,retime-pin-mask =3D <0xff>;
+			};
+
+			PIO101: pinctrl@fd6b1000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfd6b1000 0x100>;
+				st,bank-name  =3D "PIO101";
+				st,retime-pin-mask =3D <0xff>;
+			};
+
+			PIO102: pinctrl@fd6b2000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfd6b2000 0x100>;
+				st,bank-name  =3D "PIO102";
+				st,retime-pin-mask =3D <0xff>;
+			};
+		};
+
+		pin-controller-fvdp-lite {
+			#address-cells	=3D <1>;
+			#size-cells	=3D <1>;
+			compatible	=3D "st,stih416-pinctrl", "simple-bus";
+			st,retime-in-delay	=3D <0 300 500 750 1000 1250 1500 1750 2000 2250=
 2500 2750 3000 3250>;
+			st,retime-out-delay	=3D <0 300 500 750 1000 1250 1500 1750 2000 225=
0 2500 2750 3000 3250>;
+			st,syscfg		=3D <&syscfg_fvdp_lite>;
+			st,syscfg-offsets	=3D <0 40 50 60 100>;
+			ranges;
+
+			PIO103: pinctrl@fd330000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfd330000 0x100>;
+				st,bank-name  =3D "PIO103";
+				st,retime-pin-mask =3D <0xff>;
+			};
+			PIO104: pinctrl@fd331000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfd331000 0x100>;
+				st,bank-name  =3D "PIO104";
+				st,retime-pin-mask =3D <0xff>;
+			};
+			PIO105: pinctrl@fd332000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfd332000 0x100>;
+				st,bank-name  =3D "PIO105";
+				st,retime-pin-mask =3D <0xff>;
+			};
+			PIO106: pinctrl@fd333000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfd333000 0x100>;
+				st,bank-name  =3D "PIO106";
+				st,retime-pin-mask =3D <0xff>;
+			};
+
+			PIO107: pinctrl@fd334000 {
+				#gpio-cells	=3D <1>;
+				compatible	=3D "st,stixxxx-gpio";
+				gpio-controller;
+				reg =3D <0xfd334000 0x100>;
+				st,bank-name  =3D "PIO107";
+				st,retime-pin-mask =3D <0xf>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416=
=2Edtsi
new file mode 100644
index 0000000..7dbe450
--- /dev/null
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -0,0 +1,111 @@
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
+		interrupt-parent =3D <&intc>;
+		ranges;
+		compatible	=3D "simple-bus";
+
+		syscfg_sbc:syscfg@fe600000{
+			compatible	=3D "st,stih416-syscfg";
+			reg		=3D <0xfe600000 0x1000>;
+			syscfg-range	=3D <0 999>;
+			syscfg-name	=3D "SYSCFG_SBC";
+		};
+		syscfg_front:syscfg@fee10000{
+			compatible	=3D "st,stih416-syscfg";
+			reg		=3D <0xfee10000 0x1000>;
+			syscfg-range	=3D <1000 999>;
+			syscfg-name	=3D "SYSCFG_FRONT";
+		};
+		syscfg_rear:syscfg@fe830000{
+			compatible	=3D "st,stih416-syscfg";
+			reg		=3D <0xfe830000 0x1000>;
+			syscfg-range	=3D <2000 999>;
+			syscfg-name	=3D "SYSCFG_REAR";
+		};
+
+		/* MPE */
+		syscfg_fvdp_fe:syscfg@fddf0000{
+			compatible	=3D "st,stih416-syscfg";
+			reg		=3D <0xfddf0000 0x1000>;
+			syscfg-range	=3D <5000 999>;
+			syscfg-name	=3D "SYSCFG_FVDP_FE";
+		};
+		syscfg_fvdp_lite:syscfg@fd6a0000{
+			compatible	=3D "st,stih416-syscfg";
+			reg		=3D <0xfd6a0000 0x1000>;
+			syscfg-range	=3D <6000 999>;
+			syscfg-name	=3D "SYSCFG_FVDP_LITE";
+		};
+
+		syscfg_cpu:syscfg@fdde0000{
+			compatible	=3D "st,stih416-syscfg";
+			reg		=3D <0xfdde0000 0x1000>;
+			syscfg-range	=3D <7000 999>;
+			syscfg-name	=3D "SYSCFG_CPU";
+		};
+
+		syscfg_compo:syscfg@fd320000{
+			compatible	=3D "st,stih416-syscfg";
+			reg		=3D <0xfd320000 0x1000>;
+			syscfg-range	=3D <8000 999>;
+			syscfg-name	=3D "SYSCFG_COMPO";
+		};
+
+		syscfg_transport:syscfg@fd690000{
+			compatible	=3D "st,stih416-syscfg";
+			reg		=3D <0xfd690000 0x1000>;
+			syscfg-range	=3D <9000 999>;
+			syscfg-name	=3D "SYSCFG_TRANSPORT";
+		};
+
+		syscfg_lpm:syscfg@fe4b5100{
+			compatible	=3D "st,stih416-syscfg";
+			reg		=3D <0xfe4b5100 0x8>;
+			syscfg-range	=3D <0 10>;
+			syscfg-name	=3D "LPM_CFG_REGS";
+		};
+
+		serial2: serial@fed32000{
+			compatible	=3D "st,asc";
+			status 		=3D "disabled";
+			reg		=3D <0xfed32000 0x2c>;
+			interrupts	=3D <0 197 0>;
+			clocks          =3D <&CLK_S_ICN_REG_0>;
+			pinctrl-names 	=3D "default";
+			pinctrl-0 	=3D <&pinctrl_serial2>;
+		};
+
+		/* SBC_UART1 */
+		sbc_serial1: serial@fe531000 {
+			compatible	=3D "st,asc";
+			status 		=3D "disabled";
+			reg		=3D <0xfe531000 0x2c>;
+			interrupts	=3D <0 210 0>;
+			pinctrl-names 	=3D "default";
+			pinctrl-0 	=3D <&pinctrl_sbc_serial1>;
+			clocks          =3D <&CLK_SYSIN>;
+		};
+	};
+};
diff --git a/arch/arm/mach-stixxxx/board-dt.c b/arch/arm/mach-stixxxx/b=
oard-dt.c
index 52ce665..2b2552e 100644
--- a/arch/arm/mach-stixxxx/board-dt.c
+++ b/arch/arm/mach-stixxxx/board-dt.c
@@ -37,10 +37,11 @@ static void __init stih41x_timer_init(void)
=20
 static const char *stih41x_dt_match[] __initdata =3D {
 	"st,stih415",
+	"st,stih416",
 	NULL
 };
=20
-DT_MACHINE_START(STM, "STiH415 SoC with Flattened Device Tree")
+DT_MACHINE_START(STM, "STiH415/416 SoC with Flattened Device Tree")
 	.init_time	=3D stih41x_timer_init,
 	.smp		=3D smp_ops(stixxxx_smp_ops),
 	.dt_compat	=3D stih41x_dt_match,
--=20
1.7.6.5

