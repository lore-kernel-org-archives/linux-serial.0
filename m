From: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: [PATCH v4 4/6] arm64: dts: fsl: Add device tree for S32V234-EVB
Date: Thu, 5 Sep 2019 11:58:37 +0000
Message-ID: <20190905115803.19565-5-stefan-gabriel.mirea@nxp.com>
References: <20190905115803.19565-1-stefan-gabriel.mirea@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190905115803.19565-1-stefan-gabriel.mirea@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "corbet@lwn.net" <corbet@lwn.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>
Cc: "jslaby@suse.com" <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Cosmin Stefan Stoica <cosmin.stoica@nxp.com>, Dan Nica <dan.nica@nxp.com>, Larisa Ileana Grigore <larisa.grigore@nxp.com>
List-Id: linux-serial@vger.kernel.org

From: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>

Add initial version of device tree for S32V234-EVB, including nodes for the
4 Cortex-A53 cores, AIPS bus with UART modules, ARM architected timer and
Generic Interrupt Controller (GIC).

Keep SoC level separate from board level to let future boards with this SoC
share common properties, while the dts files will keep board-dependent
properties.

Signed-off-by: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
Signed-off-by: Mihaela Martinas <Mihaela.Martinas@freescale.com>
Signed-off-by: Dan Nica <dan.nica@nxp.com>
Signed-off-by: Larisa Grigore <Larisa.Grigore@nxp.com>
Signed-off-by: Phu Luu An <phu.luuan@nxp.com>
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 arch/arm64/boot/dts/freescale/s32v234-evb.dts |  25 ++++
 arch/arm64/boot/dts/freescale/s32v234.dtsi    | 139 ++++++++++++++++++
 3 files changed, 166 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/s32v234-evb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/s32v234.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/f=
reescale/Makefile
index c043aca66572..9aff21324146 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -26,3 +26,5 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-librem5-devkit.dtb
 dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-zii-ultra-rmb3.dtb
 dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-zii-ultra-zest.dtb
 dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-mek.dtb
+
+dtb-$(CONFIG_ARCH_S32) +=3D s32v234-evb.dtb
diff --git a/arch/arm64/boot/dts/freescale/s32v234-evb.dts b/arch/arm64/boo=
t/dts/freescale/s32v234-evb.dts
new file mode 100644
index 000000000000..4b802518cefc
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32v234-evb.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2015-2016 Freescale Semiconductor, Inc.
+ * Copyright 2016-2017 NXP
+ */
+
+/dts-v1/;
+#include "s32v234.dtsi"
+
+/ {
+	model =3D "NXP S32V234-EVB2 Board";
+	compatible =3D "fsl,s32v234-evb", "fsl,s32v234";
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status =3D "okay";
+};
+
+&uart1 {
+	status =3D "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/s32v234.dtsi b/arch/arm64/boot/d=
ts/freescale/s32v234.dtsi
new file mode 100644
index 000000000000..37225191ccbf
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32v234.dtsi
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2015-2016 Freescale Semiconductor, Inc.
+ * Copyright 2016-2018 NXP
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/memreserve/ 0x80000000 0x00010000;
+
+/ {
+	compatible =3D "fsl,s32v234";
+	interrupt-parent =3D <&gic>;
+	#address-cells =3D <2>;
+	#size-cells =3D <2>;
+
+	aliases {
+		serial0 =3D &uart0;
+		serial1 =3D &uart1;
+	};
+
+	cpus {
+		#address-cells =3D <2>;
+		#size-cells =3D <0>;
+
+		cpu0: cpu@0 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a53";
+			reg =3D <0x0 0x0>;
+			enable-method =3D "spin-table";
+			cpu-release-addr =3D <0x0 0x80000000>;
+			next-level-cache =3D <&cluster0_l2_cache>;
+		};
+
+		cpu1: cpu@1 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a53";
+			reg =3D <0x0 0x1>;
+			enable-method =3D "spin-table";
+			cpu-release-addr =3D <0x0 0x80000000>;
+			next-level-cache =3D <&cluster0_l2_cache>;
+		};
+
+		cpu2: cpu@100 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a53";
+			reg =3D <0x0 0x100>;
+			enable-method =3D "spin-table";
+			cpu-release-addr =3D <0x0 0x80000000>;
+			next-level-cache =3D <&cluster1_l2_cache>;
+		};
+
+		cpu3: cpu@101 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a53";
+			reg =3D <0x0 0x101>;
+			enable-method =3D "spin-table";
+			cpu-release-addr =3D <0x0 0x80000000>;
+			next-level-cache =3D <&cluster1_l2_cache>;
+		};
+
+		cluster0_l2_cache: l2-cache0 {
+			compatible =3D "cache";
+		};
+
+		cluster1_l2_cache: l2-cache1 {
+			compatible =3D "cache";
+		};
+	};
+
+	timer {
+		compatible =3D "arm,armv8-timer";
+		interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>;
+		/* clock-frequency might be modified by u-boot, depending on the
+		 * chip version.
+		 */
+		clock-frequency =3D <10000000>;
+	};
+
+	gic: interrupt-controller@7d001000 {
+		compatible =3D "arm,cortex-a15-gic", "arm,cortex-a9-gic";
+		#interrupt-cells =3D <3>;
+		#address-cells =3D <0>;
+		interrupt-controller;
+		reg =3D <0 0x7d001000 0 0x1000>,
+		      <0 0x7d002000 0 0x2000>,
+		      <0 0x7d004000 0 0x2000>,
+		      <0 0x7d006000 0 0x2000>;
+		interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
+					 IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	soc {
+		#address-cells =3D <2>;
+		#size-cells =3D <2>;
+		compatible =3D "simple-bus";
+		interrupt-parent =3D <&gic>;
+		ranges;
+
+		aips0: aips-bus@40000000 {
+			compatible =3D "simple-bus";
+			#address-cells =3D <2>;
+			#size-cells =3D <2>;
+			interrupt-parent =3D <&gic>;
+			reg =3D <0x0 0x40000000 0x0 0x7D000>;
+			ranges;
+
+			uart0: serial@40053000 {
+				compatible =3D "fsl,s32v234-linflexuart";
+				reg =3D <0x0 0x40053000 0x0 0x1000>;
+				interrupts =3D <GIC_SPI 59 IRQ_TYPE_EDGE_RISING>;
+				status =3D "disabled";
+			};
+		};
+
+		aips1: aips-bus@40080000 {
+			compatible =3D "simple-bus";
+			#address-cells =3D <2>;
+			#size-cells =3D <2>;
+			interrupt-parent =3D <&gic>;
+			reg =3D <0x0 0x40080000 0x0 0x70000>;
+			ranges;
+
+			uart1: serial@400bc000 {
+				compatible =3D "fsl,s32v234-linflexuart";
+				reg =3D <0x0 0x400bc000 0x0 0x1000>;
+				interrupts =3D <GIC_SPI 60 IRQ_TYPE_EDGE_RISING>;
+				status =3D "disabled";
+			};
+		};
+	};
+};
--=20
2.22.0
