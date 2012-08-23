From: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Subject: [PATCHv4 1/9] arm: vt8500: Add device tree files for VIA/Wondermedia
 SoC's
Date: Thu, 23 Aug 2012 19:35:37 +1200
Message-ID: <1345707346-9035-2-git-send-email-linux@prisktech.co.nz>
References: <1345707346-9035-1-git-send-email-linux@prisktech.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1345707346-9035-1-git-send-email-linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
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
To: vt8500-wm8505-linux-kernel-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Add device tree files for VT8500, WM8505 and WM8650 SoC's and
reference boards.

Signed-off-by: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
---
 arch/arm/boot/dts/vt8500-bv07.dts |   31 ++++++++
 arch/arm/boot/dts/vt8500.dtsi     |  115 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/wm8505-ref.dts  |   31 ++++++++
 arch/arm/boot/dts/wm8505.dtsi     |  142 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/wm8650-mid.dts  |   31 ++++++++
 arch/arm/boot/dts/wm8650.dtsi     |  146 +++++++++++++++++++++++++++++++++++++
 6 files changed, 496 insertions(+)
 create mode 100644 arch/arm/boot/dts/vt8500-bv07.dts
 create mode 100644 arch/arm/boot/dts/vt8500.dtsi
 create mode 100644 arch/arm/boot/dts/wm8505-ref.dts
 create mode 100644 arch/arm/boot/dts/wm8505.dtsi
 create mode 100644 arch/arm/boot/dts/wm8650-mid.dts
 create mode 100644 arch/arm/boot/dts/wm8650.dtsi

diff --git a/arch/arm/boot/dts/vt8500-bv07.dts b/arch/arm/boot/dts/vt8500-bv07.dts
new file mode 100644
index 0000000..339a664
--- /dev/null
+++ b/arch/arm/boot/dts/vt8500-bv07.dts
@@ -0,0 +1,31 @@
+/*
+ * vt8500-bv07.dts - Device tree file for Benign BV07 Netbook
+ *
+ * Copyright (C) 2012 Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
+ *
+ * Licensed under GPLv2 or later
+ */
+
+/dts-v1/;
+/include/ "vt8500.dtsi"
+
+/ {
+	model = "Benign BV07 Netbook";
+
+	/*
+	 * Display node is based on Sascha Hauer's patch on dri-devel.
+	 * Added a bpp property to calculate the size of the framebuffer
+	 * until the binding is formalized.
+	 */
+	display: display {
+		xres = <800>;
+		yres = <480>;
+		left-margin = <88>;
+		right-margin = <40>;
+		hsync-len = <0>;
+		upper-margin = <32>;
+		lower-margin = <11>;
+		vsync-len = <1>;
+		bpp = <16>;
+	};
+};
diff --git a/arch/arm/boot/dts/vt8500.dtsi b/arch/arm/boot/dts/vt8500.dtsi
new file mode 100644
index 0000000..17a1d0d
--- /dev/null
+++ b/arch/arm/boot/dts/vt8500.dtsi
@@ -0,0 +1,115 @@
+/*
+ * vt8500.dtsi - Device tree file for VIA VT8500 SoC
+ *
+ * Copyright (C) 2012 Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
+ *
+ * Licensed under GPLv2 or later
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "via,vt8500";
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+		interrupt-parent = <&intc>;
+
+		intc: interrupt-controller@d8140000 {
+			compatible = "via,vt8500-intc";
+			interrupt-controller;
+			reg = <0xd8140000 0x10000>;
+			#interrupt-cells = <1>;
+		};
+
+		gpio: gpio-controller@d8110000 {
+			compatible = "via,vt8500-gpio";
+			gpio-controller;
+			reg = <0xd8110000 0x10000>;
+			#gpio-cells = <3>;
+		};
+
+		pmc@d8130000 {
+			compatible = "via,vt8500-pmc";
+			reg = <0xd8130000 0x1000>;
+
+			clocks {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ref24: ref24M {
+					#clock-cells = <0>;
+					compatible = "fixed-clock";
+					clock-frequency = <24000000>;
+				};
+			};
+		};
+
+		timer@d8130100 {
+			compatible = "via,vt8500-timer";
+			reg = <0xd8130100 0x28>;
+			interrupts = <36>;
+		};
+
+		ehci@d8007900 {
+			compatible = "via,vt8500-ehci";
+			reg = <0xd8007900 0x200>;
+			interrupts = <43>;
+		};
+
+		uhci@d8007b00 {
+			compatible = "platform-uhci";
+			reg = <0xd8007b00 0x200>;
+			interrupts = <43>;
+		};
+
+		fb@d800e400 {
+			compatible = "via,vt8500-fb";
+			reg = <0xd800e400 0x400>;
+			interrupts = <12>;
+			via,display = <&display>;
+		};
+
+		ge_rops@d8050400 {
+			compatible = "wm,prizm-ge-rops";
+			reg = <0xd8050400 0x100>;
+		};
+
+		uart@d8200000 {
+			compatible = "via,vt8500-uart";
+			reg = <0xd8200000 0x1040>;
+			interrupts = <32>;
+			clocks = <&ref24>;
+		};
+
+		uart@d82b0000 {
+			compatible = "via,vt8500-uart";
+			reg = <0xd82b0000 0x1040>;
+			interrupts = <33>;
+			clocks = <&ref24>;
+		};
+
+		uart@d8210000 {
+			compatible = "via,vt8500-uart";
+			reg = <0xd8210000 0x1040>;
+			interrupts = <47>;
+			clocks = <&ref24>;
+		};
+
+		uart@d82c0000 {
+			compatible = "via,vt8500-uart";
+			reg = <0xd82c0000 0x1040>;
+			interrupts = <50>;
+			clocks = <&ref24>;
+		};
+
+		rtc@d8100000 {
+			compatible = "via,vt8500-rtc";
+			reg = <0xd8100000 0x10000>;
+			interrupts = <48>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/wm8505-ref.dts b/arch/arm/boot/dts/wm8505-ref.dts
new file mode 100644
index 0000000..fcd9836
--- /dev/null
+++ b/arch/arm/boot/dts/wm8505-ref.dts
@@ -0,0 +1,31 @@
+/*
+ * wm8505-ref.dts - Device tree file for Wondermedia WM8505 reference netbook
+ *
+ * Copyright (C) 2012 Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
+ *
+ * Licensed under GPLv2 or later
+ */
+
+/dts-v1/;
+/include/ "wm8505.dtsi"
+
+/ {
+	model = "Wondermedia WM8505 Netbook";
+
+	/*
+	 * Display node is based on Sascha Hauer's patch on dri-devel.
+	 * Added a bpp property to calculate the size of the framebuffer
+	 * until the binding is formalized.
+	 */
+	display: display {
+		xres = <800>;
+		yres = <480>;
+		left-margin = <88>;
+		right-margin = <40>;
+		hsync-len = <0>;
+		upper-margin = <32>;
+		lower-margin = <11>;
+		vsync-len = <1>;
+		bpp = <32>;
+	};
+};
diff --git a/arch/arm/boot/dts/wm8505.dtsi b/arch/arm/boot/dts/wm8505.dtsi
new file mode 100644
index 0000000..aa6d492
--- /dev/null
+++ b/arch/arm/boot/dts/wm8505.dtsi
@@ -0,0 +1,142 @@
+/*
+ * wm8505.dtsi - Device tree file for Wondermedia WM8505 SoC
+ *
+ * Copyright (C) 2012 Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
+ *
+ * Licensed under GPLv2 or later
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "wm,wm8505";
+
+	cpus {
+		cpu@0 {
+			compatible = "arm,arm926ejs";
+		};
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+		interrupt-parent = <&intc0>;
+
+		intc0: interrupt-controller@d8140000 {
+			compatible = "via,vt8500-intc";
+			interrupt-controller;
+			reg = <0xd8140000 0x10000>;
+			#interrupt-cells = <1>;
+		};
+
+		/* Secondary IC cascaded to intc0 */
+		intc1: interrupt-controller@d8150000 {
+			compatible = "via,vt8500-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			reg = <0xD8150000 0x10000>;
+			interrupts = <56 57 58 59 60 61 62 63>;
+		};
+
+		gpio: gpio-controller@d8110000 {
+			compatible = "wm,wm8505-gpio";
+			gpio-controller;
+			reg = <0xd8110000 0x10000>;
+			#gpio-cells = <3>;
+		};
+
+		pmc@d8130000 {
+			compatible = "via,vt8500-pmc";
+			reg = <0xd8130000 0x1000>;
+			clocks {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ref24: ref24M {
+					#clock-cells = <0>;
+					compatible = "fixed-clock";
+					clock-frequency = <24000000>;
+				};
+			};
+		};
+
+		timer@d8130100 {
+			compatible = "via,vt8500-timer";
+			reg = <0xd8130100 0x28>;
+			interrupts = <36>;
+		};
+
+		ehci@d8007100 {
+			compatible = "via,vt8500-ehci";
+			reg = <0xd8007100 0x200>;
+			interrupts = <43>;
+		};
+
+		uhci@d8007300 {
+			compatible = "platform-uhci";
+			reg = <0xd8007300 0x200>;
+			interrupts = <43>;
+		};
+
+		fb@d8050800 {
+			compatible = "wm,wm8505-fb";
+			reg = <0xd8050800 0x200>;
+			via,display = <&display>;
+		};
+
+		ge_rops@d8050400 {
+			compatible = "wm,prizm-ge-rops";
+			reg = <0xd8050400 0x100>;
+		};
+
+		uart@d8200000 {
+			compatible = "via,vt8500-uart";
+			reg = <0xd8200000 0x1040>;
+			interrupts = <32>;
+			clocks = <&ref24>;
+		};
+
+		uart@d82b0000 {
+			compatible = "via,vt8500-uart";
+			reg = <0xd82b0000 0x1040>;
+			interrupts = <33>;
+			clocks = <&ref24>;
+		};
+
+		uart@d8210000 {
+			compatible = "via,vt8500-uart";
+			reg = <0xd8210000 0x1040>;
+			interrupts = <47>;
+			clocks = <&ref24>;
+		};
+
+		uart@d82c0000 {
+			compatible = "via,vt8500-uart";
+			reg = <0xd82c0000 0x1040>;
+			interrupts = <50>;
+			clocks = <&ref24>;
+		};
+
+		uart@d8370000 {
+			compatible = "via,vt8500-uart";
+			reg = <0xd8370000 0x1040>;
+			interrupts = <31>;
+			clocks = <&ref24>;
+		};
+
+		uart@d8380000 {
+			compatible = "via,vt8500-uart";
+			reg = <0xd8380000 0x1040>;
+			interrupts = <30>;
+			clocks = <&ref24>;
+		};
+
+		rtc@d8100000 {
+			compatible = "via,vt8500-rtc";
+			reg = <0xd8100000 0x10000>;
+			interrupts = <48>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/wm8650-mid.dts b/arch/arm/boot/dts/wm8650-mid.dts
new file mode 100644
index 0000000..d37dbf0
--- /dev/null
+++ b/arch/arm/boot/dts/wm8650-mid.dts
@@ -0,0 +1,31 @@
+/*
+ * wm8650-mid.dts - Device tree file for Wondermedia WM8650-MID Tablet
+ *
+ * Copyright (C) 2012 Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
+ *
+ * Licensed under GPLv2 or later
+ */
+
+/dts-v1/;
+/include/ "wm8650.dtsi"
+
+/ {
+	model = "Wondermedia WM8650-MID Tablet";
+
+	/*
+	 * Display node is based on Sascha Hauer's patch on dri-devel.
+	 * Added a bpp property to calculate the size of the framebuffer
+	 * until the binding is formalized.
+	 */
+	display: display {
+		xres = <800>;
+		yres = <480>;
+		left-margin = <88>;
+		right-margin = <40>;
+		hsync-len = <0>;
+		upper-margin = <32>;
+		lower-margin = <11>;
+		vsync-len = <1>;
+		bpp = <16>;
+	};
+};
diff --git a/arch/arm/boot/dts/wm8650.dtsi b/arch/arm/boot/dts/wm8650.dtsi
new file mode 100644
index 0000000..372a734
--- /dev/null
+++ b/arch/arm/boot/dts/wm8650.dtsi
@@ -0,0 +1,146 @@
+/*
+ * wm8650.dtsi - Device tree file for Wondermedia WM8650 SoC
+ *
+ * Copyright (C) 2012 Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
+ *
+ * Licensed under GPLv2 or later
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "wm,wm8650";
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+		interrupt-parent = <&intc0>;
+
+		intc0: interrupt-controller@d8140000 {
+			compatible = "via,vt8500-intc";
+			interrupt-controller;
+			reg = <0xd8140000 0x10000>;
+			#interrupt-cells = <1>;
+		};
+
+		/* Secondary IC cascaded to intc0 */
+		intc1: interrupt-controller@d8150000 {
+			compatible = "via,vt8500-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			reg = <0xD8150000 0x10000>;
+			interrupts = <56 57 58 59 60 61 62 63>;
+		};
+
+		gpio: gpio-controller@d8110000 {
+			compatible = "wm,wm8650-gpio";
+			gpio-controller;
+			reg = <0xd8110000 0x10000>;
+			#gpio-cells = <3>;
+		};
+
+		pmc@d8130000 {
+			compatible = "via,vt8500-pmc";
+			reg = <0xd8130000 0x1000>;
+
+			clocks {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ref25: ref25M {
+					#clock-cells = <0>;
+					compatible = "fixed-clock";
+					clock-frequency = <25000000>;
+				};
+
+				ref24: ref24M {
+					#clock-cells = <0>;
+					compatible = "fixed-clock";
+					clock-frequency = <24000000>;
+				};
+
+				plla: plla {
+					#clock-cells = <0>;
+					compatible = "wm,wm8650-pll-clock";
+					clocks = <&ref25>;
+					reg = <0x200>;
+				};
+
+				pllb: pllb {
+					#clock-cells = <0>;
+					compatible = "wm,wm8650-pll-clock";
+					clocks = <&ref25>;
+					reg = <0x204>;
+				};
+
+				arm: arm {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&plla>;
+					divisor-reg = <0x300>;
+				};
+
+				sdhc: sdhc {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&pllb>;
+					divisor-reg = <0x328>;
+					divisor-mask = <0x3f>;
+					enable-reg = <0x254>;
+					enable-bit = <18>;
+				};
+			};
+		};
+
+		timer@d8130100 {
+			compatible = "via,vt8500-timer";
+			reg = <0xd8130100 0x28>;
+			interrupts = <36>;
+		};
+
+		ehci@d8007900 {
+			compatible = "via,vt8500-ehci";
+			reg = <0xd8007900 0x200>;
+			interrupts = <43>;
+		};
+
+		uhci@d8007b00 {
+			compatible = "platform-uhci";
+			reg = <0xd8007b00 0x200>;
+			interrupts = <43>;
+		};
+
+		fb@d8050800 {
+			compatible = "wm,wm8505-fb";
+			reg = <0xd8050800 0x200>;
+			via,display = <&display>;
+		};
+
+		ge_rops@d8050400 {
+			compatible = "wm,prizm-ge-rops";
+			reg = <0xd8050400 0x100>;
+		};
+
+		uart@d8200000 {
+			compatible = "via,vt8500-uart";
+			reg = <0xd8200000 0x1040>;
+			interrupts = <32>;
+			clocks = <&ref24>;
+		};
+
+		uart@d82b0000 {
+			compatible = "via,vt8500-uart";
+			reg = <0xd82b0000 0x1040>;
+			interrupts = <33>;
+			clocks = <&ref24>;
+		};
+
+		rtc@d8100000 {
+			compatible = "via,vt8500-rtc";
+			reg = <0xd8100000 0x10000>;
+			interrupts = <48>;
+		};
+	};
+};
-- 
1.7.9.5
