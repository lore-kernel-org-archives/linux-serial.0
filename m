From: Srinivas KANDAGATLA <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH v2 10/11] ARM:stih41x: Add B2000 board support
Date: Mon, 10 Jun 2013 10:28:10 +0100
Message-ID: <1370856490-7283-1-git-send-email-srinivas.kandagatla@st.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1370855828-5318-1-git-send-email-srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
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
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>, Stephen Gallimore <stephen.gallimore-qxv4g6HH51o@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stuart Menefy <stuart.menefy-qxv4g6HH51o@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

B2000 board is reference board for STIH415/416 SOCs, it has
2 x UART, 4x USB, 2 x Ethernet, 1 x SATA, 1 x PCIe, and 1GB RAM.

This patch add initial support to b2000 with STiH415/416 with UART2 as
console and a heard beat LED.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
CC: Stephen Gallimore <stephen.gallimore-qxv4g6HH51o@public.gmane.org>
CC: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
---
 arch/arm/boot/dts/Makefile           |    2 +
 arch/arm/boot/dts/stih415-b2000.dts  |   15 ++++++++++++
 arch/arm/boot/dts/stih416-b2000.dts  |   16 +++++++++++++
 arch/arm/boot/dts/stih41x-b2000.dtsi |   41 ++++++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/stih415-b2000.dts
 create mode 100644 arch/arm/boot/dts/stih416-b2000.dts
 create mode 100644 arch/arm/boot/dts/stih41x-b2000.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f0895c5..d4615fd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -177,6 +177,8 @@ dtb-$(CONFIG_ARCH_SPEAR3XX)+= spear300-evb.dtb \
 	spear320-evb.dtb \
 	spear320-hmi.dtb
 dtb-$(CONFIG_ARCH_SPEAR6XX)+= spear600-evb.dtb
+dtb-$(CONFIG_ARCH_STIXXXX)+= stih415-b2000.dtb \
+	stih416-b2000.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += \
 	sun4i-a10-cubieboard.dtb \
 	sun4i-a10-mini-xplus.dtb \
diff --git a/arch/arm/boot/dts/stih415-b2000.dts b/arch/arm/boot/dts/stih415-b2000.dts
new file mode 100644
index 0000000..d4af531
--- /dev/null
+++ b/arch/arm/boot/dts/stih415-b2000.dts
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
diff --git a/arch/arm/boot/dts/stih416-b2000.dts b/arch/arm/boot/dts/stih416-b2000.dts
new file mode 100644
index 0000000..a5eb6ee
--- /dev/null
+++ b/arch/arm/boot/dts/stih416-b2000.dts
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
index 0000000..8e694d2
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
+		linux,stdout-path = &serial2;
+	};
+
+	aliases {
+		ttyAS0 = &serial2;
+	};
+
+	soc {
+		serial2: serial@fed32000 {
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
-- 
1.7.6.5
