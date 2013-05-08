From: Srinivas KANDAGATLA <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
Subject: [RFC 7/8] ARM:stih41x: Add B2000 board support
Date: Wed,  8 May 2013 15:12:09 +0100
Message-ID: <1368022329-2424-1-git-send-email-srinivas.kandagatla@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1368022187-1633-1-git-send-email-srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org
Cc: Srinivas Kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Gallimore <stephen.gallimore-qxv4g6HH51o@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stuart Menefy <stuart.menefy-qxv4g6HH51o@public.gmane.org>, Dong Aisheng <dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>

B2000 board is reference board for STIH415/416 SOCs, it has
2 x UART, 4x USB, 2 x Ethernet, 1 x SATA, 1 x PCIe, and 1GB RAM.

This patch add initial support to b2000 with STiH415/416 with UART2 as
console and a heard beat LED.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
CC: Stephen Gallimore <stephen.gallimore-qxv4g6HH51o@public.gmane.org>
CC: Stuart Menefy <stuart.menefy-qxv4g6HH51o@public.gmane.org>
---
 arch/arm/boot/dts/Makefile           |    2 +
 arch/arm/boot/dts/stih415-b2000.dtsp |   15 ++++++++++++
 arch/arm/boot/dts/stih416-b2000.dtsp |   16 +++++++++++++
 arch/arm/boot/dts/stih41x-b2000.dtsi |   41 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-stih41x/board-dt.c     |    2 +
 5 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/stih415-b2000.dtsp
 create mode 100644 arch/arm/boot/dts/stih416-b2000.dtsp
 create mode 100644 arch/arm/boot/dts/stih41x-b2000.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9c62558..78b0271 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -147,6 +147,8 @@ dtb-$(CONFIG_ARCH_SPEAR3XX)+= spear300-evb.dtb \
 	spear320-evb.dtb \
 	spear320-hmi.dtb
 dtb-$(CONFIG_ARCH_SPEAR6XX)+= spear600-evb.dtb
+dtb-$(CONFIG_ARCH_STIH41X)+= stih415-b2000.dtb \
+	stih416-b2000.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun4i-a10-cubieboard.dtb \
 	sun4i-a10-hackberry.dtb \
 	sun5i-a13-olinuxino.dtb
diff --git a/arch/arm/boot/dts/stih415-b2000.dtsp b/arch/arm/boot/dts/stih415-b2000.dtsp
new file mode 100644
index 0000000..d4af531
--- /dev/null
+++ b/arch/arm/boot/dts/stih415-b2000.dtsp
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
+ * Author: Srinivas Kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ */
+/dts-v1/;
+#include "stih415.dtsi"
+#include "stih41x-b2000.dtsi"
+/ {
+	model = "STiH415 B2000 Board";
+	compatible = "st,stih415", "st,stih415-b2000";
+};
diff --git a/arch/arm/boot/dts/stih416-b2000.dtsp b/arch/arm/boot/dts/stih416-b2000.dtsp
new file mode 100644
index 0000000..a5eb6ee
--- /dev/null
+++ b/arch/arm/boot/dts/stih416-b2000.dtsp
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
+ * Author: Srinivas Kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ */
+/dts-v1/;
+#include "stih416.dtsi"
+#include "stih41x-b2000.dtsi"
+
+/ {
+	compatible = "st,stih416", "st,stih416-b2000";
+	model = "STiH416 B2000";
+};
diff --git a/arch/arm/boot/dts/stih41x-b2000.dtsi b/arch/arm/boot/dts/stih41x-b2000.dtsi
new file mode 100644
index 0000000..8c17e4a
--- /dev/null
+++ b/arch/arm/boot/dts/stih41x-b2000.dtsi
@@ -0,0 +1,41 @@
+/*
+ * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
+ * Author: Srinivas Kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ */
+/ {
+
+	memory{
+		device_type = "memory";
+		reg = <0x60000000 0x40000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyAS0,115200";
+		linux,stdout-path = &uart2;
+	};
+
+	aliases {
+		ttyAS0 = &uart2;
+	};
+
+	soc {
+		uart2: uart@fed32000 {
+			status = "okay";
+		};
+
+		leds {
+			compatible	= "gpio-leds";
+			fp_led {
+				#gpio-cells = <1>;
+				label	= "Front Panel LED";
+				gpios	= <&PIO105 7>;
+				linux,default-trigger	= "heartbeat";
+			};
+		};
+
+	};
+};
diff --git a/arch/arm/mach-stih41x/board-dt.c b/arch/arm/mach-stih41x/board-dt.c
index 8005f71..1f23aca 100644
--- a/arch/arm/mach-stih41x/board-dt.c
+++ b/arch/arm/mach-stih41x/board-dt.c
@@ -63,6 +63,8 @@ void __init stih41x_dt_init(void)
 }
 
 static const char *stih41x_dt_match[] __initdata = {
+	"st,stih415-b2000",
+	"st,stih416-b2000",
 	NULL
 };
 
-- 
1.7.6.5
