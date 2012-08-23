From: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Subject: [PATCHv4 7/9] arm: vt8500: doc: Add device tree bindings for arch-vt8500 devices
Date: Thu, 23 Aug 2012 19:35:43 +1200
Message-ID: <1345707346-9035-8-git-send-email-linux@prisktech.co.nz>
References: <1345707346-9035-1-git-send-email-linux@prisktech.co.nz>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1345707346-9035-1-git-send-email-linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vt8500-wm8505-linux-kernel-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Mike Turquette <mturquette-l0cyMroinI0@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Bindings for gpio, interrupt controller, power management controller,
timer, realtime clock, serial uart, ehci and uhci controllers and
framebuffer controllers used on the arch-vt8500 platform.

Framebuffer binding also specifies a 'display' node which is required
for determining the lcd panel data.

Signed-off-by: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
---
 Documentation/devicetree/bindings/arm/vt8500.txt   |   15 ++++
 .../bindings/arm/vt8500/via,vt8500-intc.txt        |   16 +++++
 .../bindings/arm/vt8500/via,vt8500-pmc.txt         |   13 ++++
 .../bindings/arm/vt8500/via,vt8500-timer.txt       |   15 ++++
 Documentation/devicetree/bindings/clock/vt8500.txt |   72 ++++++++++++++++++++
 .../devicetree/bindings/gpio/gpio-vt8500.txt       |   24 +++++++
 .../devicetree/bindings/rtc/via,vt8500-rtc.txt     |   15 ++++
 .../bindings/tty/serial/via,vt8500-uart.txt        |   17 +++++
 .../devicetree/bindings/usb/platform-uhci.txt      |   15 ++++
 .../devicetree/bindings/usb/via,vt8500-ehci.txt    |   15 ++++
 .../devicetree/bindings/vendor-prefixes.txt        |    2 +
 .../devicetree/bindings/video/via,vt8500-fb.txt    |   48 +++++++++++++
 .../devicetree/bindings/video/wm,prizm-ge-rops.txt |   13 ++++
 .../devicetree/bindings/video/wm,wm8505-fb.txt     |   22 ++++++
 14 files changed, 302 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/vt8500.txt
 create mode 100644 Documentation/devicetree/bindings/arm/vt8500/via,vt8500-intc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/vt8500/via,vt8500-pmc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/vt8500/via,vt8500-timer.txt
 create mode 100644 Documentation/devicetree/bindings/clock/vt8500.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-vt8500.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/via,vt8500-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/tty/serial/via,vt8500-uart.txt
 create mode 100644 Documentation/devicetree/bindings/usb/platform-uhci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/via,vt8500-ehci.txt
 create mode 100644 Documentation/devicetree/bindings/video/via,vt8500-fb.txt
 create mode 100644 Documentation/devicetree/bindings/video/wm,prizm-ge-rops.txt
 create mode 100644 Documentation/devicetree/bindings/video/wm,wm8505-fb.txt

diff --git a/Documentation/devicetree/bindings/arm/vt8500.txt b/Documentation/devicetree/bindings/arm/vt8500.txt
new file mode 100644
index 0000000..1b3b187
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/vt8500.txt
@@ -0,0 +1,15 @@
+VIA/Wondermedia VT8500 Platforms Device Tree Bindings
+---------------------------------------
+
+Boards with the VIA VT8500 SoC shall have the following properties:
+Required root node property:
+compatible = "via,vt8500";
+
+Boards with the Wondermedia WM8505 SoC shall have the following properties:
+Required root node property:
+compatible = "wm,wm8505";
+
+Boards with the Wondermedia WM8650 SoC shall have the following properties:
+Required root node property:
+compatible = "wm,wm8650";
+
diff --git a/Documentation/devicetree/bindings/arm/vt8500/via,vt8500-intc.txt b/Documentation/devicetree/bindings/arm/vt8500/via,vt8500-intc.txt
new file mode 100644
index 0000000..0a4ce10
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/vt8500/via,vt8500-intc.txt
@@ -0,0 +1,16 @@
+VIA/Wondermedia VT8500 Interrupt Controller
+-----------------------------------------------------
+
+Required properties:
+- compatible : "via,vt8500-intc"
+- reg : Should contain 1 register ranges(address and length)
+- #interrupt-cells : should be <1>
+
+Example:
+
+	intc: interrupt-controller@d8140000 {
+		compatible = "via,vt8500-intc";
+		interrupt-controller;
+		reg = <0xd8140000 0x10000>;
+		#interrupt-cells = <1>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/vt8500/via,vt8500-pmc.txt b/Documentation/devicetree/bindings/arm/vt8500/via,vt8500-pmc.txt
new file mode 100644
index 0000000..521b9c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/vt8500/via,vt8500-pmc.txt
@@ -0,0 +1,13 @@
+VIA/Wondermedia VT8500 Power Management Controller
+-----------------------------------------------------
+
+Required properties:
+- compatible : "via,vt8500-pmc"
+- reg : Should contain 1 register ranges(address and length)
+
+Example:
+
+	pmc@d8130000 {
+		compatible = "via,vt8500-pmc";
+		reg = <0xd8130000 0x1000>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/vt8500/via,vt8500-timer.txt b/Documentation/devicetree/bindings/arm/vt8500/via,vt8500-timer.txt
new file mode 100644
index 0000000..901c73f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/vt8500/via,vt8500-timer.txt
@@ -0,0 +1,15 @@
+VIA/Wondermedia VT8500 Timer
+-----------------------------------------------------
+
+Required properties:
+- compatible : "via,vt8500-timer"
+- reg : Should contain 1 register ranges(address and length)
+- interrupts : interrupt for the timer
+
+Example:
+
+	timer@d8130100 {
+		compatible = "via,vt8500-timer";
+		reg = <0xd8130100 0x28>;
+		interrupts = <36>;
+	};
diff --git a/Documentation/devicetree/bindings/clock/vt8500.txt b/Documentation/devicetree/bindings/clock/vt8500.txt
new file mode 100644
index 0000000..a880c70
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/vt8500.txt
@@ -0,0 +1,72 @@
+Device Tree Clock bindings for arch-vt8500
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : shall be one of the following:
+	"via,vt8500-pll-clock" - for a VT8500/WM8505 PLL clock
+	"wm,wm8650-pll-clock" - for a WM8650 PLL clock
+	"via,vt8500-device-clock" - for a VT/WM device clock
+
+Required properties for PLL clocks:
+- reg : shall be the control register offset from PMC base for the pll clock.
+- clocks : shall be the input parent clock phandle for the clock. This should
+	be the reference clock.
+- #clock-cells : from common clock binding; shall be set to 0.
+
+Required properties for device clocks:
+- clocks : shall be the input parent clock phandle for the clock. This should
+	be a pll output.
+- #clock-cells : from common clock binding; shall be set to 0.
+
+
+Device Clocks
+
+Device clocks are required to have one or both of the following sets of
+properties:
+
+
+Gated device clocks:
+
+Required properties:
+- enable-reg : shall be the register offset from PMC base for the enable
+	register.
+- enable-bit : shall be the bit within enable-reg to enable/disable the clock.
+
+
+Divisor device clocks:
+
+Required property:
+- divisor-reg : shall be the register offset from PMC base for the divisor
+	register.
+Optional property:
+- divisor-mask : shall be the mask for the divisor register. Defaults to 0x1f
+	if not specified.
+
+
+For example:
+
+ref25: ref25M {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <25000000>;
+};
+
+plla: plla {
+	#clock-cells = <0>;
+	compatible = "wm,wm8650-pll-clock";
+	clocks = <&ref25>;
+	reg = <0x200>;
+};
+
+sdhc: sdhc {
+	#clock-cells = <0>;
+	compatible = "via,vt8500-device-clock";
+	clocks = <&pllb>;
+	divisor-reg = <0x328>;
+	divisor-mask = <0x3f>;
+	enable-reg = <0x254>;
+	enable-bit = <18>;
+};
diff --git a/Documentation/devicetree/bindings/gpio/gpio-vt8500.txt b/Documentation/devicetree/bindings/gpio/gpio-vt8500.txt
new file mode 100644
index 0000000..f4dc523
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-vt8500.txt
@@ -0,0 +1,24 @@
+VIA/Wondermedia VT8500 GPIO Controller
+-----------------------------------------------------
+
+Required properties:
+- compatible : "via,vt8500-gpio", "wm,wm8505-gpio"
+	or "wm,wm8650-gpio" depending on your SoC
+- reg : Should contain 1 register range (address and length)
+- #gpio-cells : should be <3>.
+	1) bank
+	2) pin number
+	3) flags - should be 0
+
+Example:
+
+	gpio: gpio-controller@d8110000 {
+		compatible = "via,vt8500-gpio";
+		gpio-controller;
+		reg = <0xd8110000 0x10000>;
+		#gpio-cells = <3>;
+	};
+
+	vibrate {
+		gpios = <&gpio 0 1 0>; /* Bank 0, Pin 1, No flags */
+	};
diff --git a/Documentation/devicetree/bindings/rtc/via,vt8500-rtc.txt b/Documentation/devicetree/bindings/rtc/via,vt8500-rtc.txt
new file mode 100644
index 0000000..3c0484c
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/via,vt8500-rtc.txt
@@ -0,0 +1,15 @@
+VIA/Wondermedia VT8500 Realtime Clock Controller
+-----------------------------------------------------
+
+Required properties:
+- compatible : "via,vt8500-rtc"
+- reg : Should contain 1 register ranges(address and length)
+- interrupts : alarm interrupt
+
+Example:
+
+	rtc@d8100000 {
+		compatible = "via,vt8500-rtc";
+		reg = <0xd8100000 0x10000>;
+		interrupts = <48>;
+	};
diff --git a/Documentation/devicetree/bindings/tty/serial/via,vt8500-uart.txt b/Documentation/devicetree/bindings/tty/serial/via,vt8500-uart.txt
new file mode 100644
index 0000000..5feef1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/tty/serial/via,vt8500-uart.txt
@@ -0,0 +1,17 @@
+VIA/Wondermedia VT8500 UART Controller
+-----------------------------------------------------
+
+Required properties:
+- compatible : "via,vt8500-uart"
+- reg : Should contain 1 register ranges(address and length)
+- interrupts : UART interrupt
+- clocks : phandle to the uart source clock (usually a 24Mhz fixed clock)
+
+Example:
+
+	uart@d8210000 {
+		compatible = "via,vt8500-uart";
+		reg = <0xd8210000 0x1040>;
+		interrupts = <47>;
+		clocks = <&ref24>;
+	};
diff --git a/Documentation/devicetree/bindings/usb/platform-uhci.txt b/Documentation/devicetree/bindings/usb/platform-uhci.txt
new file mode 100644
index 0000000..a4fb071
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/platform-uhci.txt
@@ -0,0 +1,15 @@
+Generic Platform UHCI Controller
+-----------------------------------------------------
+
+Required properties:
+- compatible : "platform-uhci"
+- reg : Should contain 1 register ranges(address and length)
+- interrupts : UHCI controller interrupt
+
+Example:
+
+	uhci@d8007b00 {
+		compatible = "platform-uhci";
+		reg = <0xd8007b00 0x200>;
+		interrupts = <43>;
+	};
diff --git a/Documentation/devicetree/bindings/usb/via,vt8500-ehci.txt b/Documentation/devicetree/bindings/usb/via,vt8500-ehci.txt
new file mode 100644
index 0000000..17b3ad1
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/via,vt8500-ehci.txt
@@ -0,0 +1,15 @@
+VIA/Wondermedia VT8500 EHCI Controller
+-----------------------------------------------------
+
+Required properties:
+- compatible : "via,vt8500-ehci"
+- reg : Should contain 1 register ranges(address and length)
+- interrupts : ehci controller interrupt
+
+Example:
+
+	ehci@d8007900 {
+		compatible = "via,vt8500-ehci";
+		reg = <0xd8007900 0x200>;
+		interrupts = <43>;
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index db4d3af..5c63da2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -47,5 +47,7 @@ sirf	SiRF Technology, Inc.
 st	STMicroelectronics
 stericsson	ST-Ericsson
 ti	Texas Instruments
+via	VIA Technologies, Inc.
 wlf	Wolfson Microelectronics
+wm	Wondermedia Technologies, Inc.
 xlnx	Xilinx
diff --git a/Documentation/devicetree/bindings/video/via,vt8500-fb.txt b/Documentation/devicetree/bindings/video/via,vt8500-fb.txt
new file mode 100644
index 0000000..98ad14c
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/via,vt8500-fb.txt
@@ -0,0 +1,48 @@
+VIA VT8500 Framebuffer
+-----------------------------------------------------
+
+Required properties:
+- compatible : "via,vt8500-fb"
+- reg : Should contain 1 register ranges(address and length)
+- interrupts : framebuffer controller interrupt
+- via,display: a phandle pointing to the display node
+
+Required nodes:
+- display: a display node is required to initialize the lcd panel
+	This should be in the board dts.
+
+Example:
+
+	fb@d800e400 {
+		compatible = "via,vt8500-fb";
+		reg = <0xd800e400 0x400>;
+		interrupts = <12>;
+		via,display = <&display>;
+	};
+
+VIA VT8500 Display
+-----------------------------------------------------
+Required properties:
+- xres : lcd panel horizontal resolution
+- yres : lcd panel vertical resolution
+- left-margin,
+- right-margin,
+- hsync-len: lcd panel horizontal timings in pixels
+- upper-margin,
+- lower-margin,
+- vsync-len: lcd panel verticals timings in pixels
+- bpp: lcd panel bit-depth.
+	<16> for RGB565, <32> for RGB888
+
+Example:
+	display {
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
diff --git a/Documentation/devicetree/bindings/video/wm,prizm-ge-rops.txt b/Documentation/devicetree/bindings/video/wm,prizm-ge-rops.txt
new file mode 100644
index 0000000..a850fa0
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/wm,prizm-ge-rops.txt
@@ -0,0 +1,13 @@
+VIA/Wondermedia Graphics Engine Controller
+-----------------------------------------------------
+
+Required properties:
+- compatible : "wm,prizm-ge-rops"
+- reg : Should contain 1 register ranges(address and length)
+
+Example:
+
+	ge_rops@d8050400 {
+		compatible = "wm,prizm-ge-rops";
+		reg = <0xd8050400 0x100>;
+	};
diff --git a/Documentation/devicetree/bindings/video/wm,wm8505-fb.txt b/Documentation/devicetree/bindings/video/wm,wm8505-fb.txt
new file mode 100644
index 0000000..64f016a
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/wm,wm8505-fb.txt
@@ -0,0 +1,22 @@
+Wondermedia WM8505 Framebuffer
+-----------------------------------------------------
+
+Required properties:
+- compatible : "wm,wm8505-fb"
+- reg : Should contain 1 register ranges(address and length)
+- via,display: a phandle pointing to the display node
+
+Required nodes:
+- display: a display node is required to initialize the lcd panel
+	This should be in the board dts. See definition in
+	Documentation/devicetree/bindings/video/via,vt8500-fb.txt
+
+
+Example:
+
+	fb@d8050800 {
+		compatible = "wm,wm8505-fb";
+		reg = <0xd8050800 0x200>;
+		via,display = <&display>;
+	};
+
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
