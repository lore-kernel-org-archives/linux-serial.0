From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 10/11] ARM: dts: N900: Add bluetooth
Date: Tue, 21 Mar 2017 23:32:15 +0100
Message-ID: <20170321223216.11733-11-sre@kernel.org>
References: <20170321223216.11733-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170321223216.11733-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Add bcm2048 node and its system clock to the N900 device tree file.
Apart from that a reference to the new clock has been added to
wl1251 (which uses it, too).

Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
Changes since PATCHv1:
 - update compatible string
---
 arch/arm/boot/dts/omap3-n900.dts | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index b64cfda8dbb7..49f37084e435 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -155,6 +155,13 @@
 		compatible = "nokia,n900-ir";
 		pwms = <&pwm9 0 26316 0>; /* 38000 Hz */
 	};
+
+	/* controlled (enabled/disabled) directly by bcm2048 and wl1251 */
+	vctcxo: vctcxo {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <38400000>;
+	};
 };
 
 &omap3_pmx_core {
@@ -162,8 +169,10 @@
 
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x217a, PIN_INPUT | MUX_MODE0)		/* uart2_rx */
+			OMAP3_CORE1_IOPAD(0x2174, PIN_INPUT_PULLUP | MUX_MODE0)		/* uart2_cts */
+			OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT | MUX_MODE0)		/* uart2_rts */
 			OMAP3_CORE1_IOPAD(0x2178, PIN_OUTPUT | MUX_MODE0)		/* uart2_tx */
+			OMAP3_CORE1_IOPAD(0x217a, PIN_INPUT | MUX_MODE0)		/* uart2_rx */
 		>;
 	};
 
@@ -920,6 +929,8 @@
 
 		interrupt-parent = <&gpio2>;
 		interrupts = <10 IRQ_TYPE_NONE>; /* gpio line 42 */
+
+		clocks = <&vctcxo>;
 	};
 };
 
@@ -937,9 +948,17 @@
 };
 
 &uart2 {
-	interrupts-extended = <&intc 73 &omap3_pmx_core OMAP3_UART2_RX>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart2_pins>;
+
+	bcm2048: bluetooth {
+		compatible = "brcm,bcm2048-nokia", "nokia,h4p-bluetooth";
+		reset-gpios = <&gpio3 27 GPIO_ACTIVE_LOW>; /* 91 */
+		host-wakeup-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>; /* 101 */
+		bluetooth-wakeup-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>; /* 37 */
+		clocks = <&vctcxo>;
+		clock-names = "sysclk";
+	};
 };
 
 &uart3 {
-- 
2.11.0
