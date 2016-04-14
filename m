From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 1/5] doc: DT: Add Generic Serial Device Tree Bindings
Date: Thu, 14 Apr 2016 14:13:19 +0200
Message-ID: <1460636003-3011-2-git-send-email-geert+renesas@glider.be>
References: <1460636003-3011-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460636003-3011-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Barry Song <baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Document a set of generic properties for describing UARTs in a
device tree:
  1. The GPIO modem control properties are currently duplicated across
     hardware-specific binding documentation,
  2. The property for dedicated RTS/CTS hardware flow control lines is
     already supported by several drivers, albeit with a vendor-specific
     prefix, hence make it generic.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 .../devicetree/bindings/serial/serial.txt          | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/serial.txt

diff --git a/Documentation/devicetree/bindings/serial/serial.txt b/Documentation/devicetree/bindings/serial/serial.txt
new file mode 100644
index 0000000000000000..21afdbd973b07a44
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/serial.txt
@@ -0,0 +1,61 @@
+Generic Serial DT Bindings
+
+This document lists a set of generic properties for describing UARTs in a
+device tree.  Whether these properties apply to a particular device depends on
+the DT bindings for the actual device.
+
+Optional properties:
+  - cts-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
+    used as the UART's CTS line.
+  - dcd-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
+    used as the UART's DCD line.
+  - dsr-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
+    used as the UART's DSR line.
+  - dtr-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
+    used as the UART's DTR line.
+  - out1-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
+    used as the UART's OUT1 line.
+  - out2-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
+    used as the UART's OUT2 line.
+  - rng-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
+    used as the UART's RNG line.
+  - rts-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
+    used as the UART's RTS line.
+
+  - uart-has-rtscts: The presence of this property indicates that the
+    UART has dedicated lines for RTS/CTS hardware flow control, and that
+    they are available for use (wired and enabled by pinmux configuration).
+    This depends on both the UART hardware and the board wiring.
+    Note that this property is mutually-exclusive with "cts-gpios" and
+    "rts-gpios" above.
+
+
+Examples:
+
+	uart1: serial@48022000 {
+		compatible = "ti,am3352-uart", "ti,omap3-uart";
+		ti,hwmods = "uart2";
+		clock-frequency = <48000000>;
+		reg = <0x48022000 0x2000>;
+		interrupts = <73>;
+		dmas = <&edma 28 0>, <&edma 29 0>;
+		dma-names = "tx", "rx";
+		dtr-gpios = <&gpio2 22 GPIO_ACTIVE_LOW>;
+		dsr-gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
+		dcd-gpios = <&gpio2 24 GPIO_ACTIVE_LOW>;
+		rng-gpios = <&gpio2 25 GPIO_ACTIVE_LOW>;
+		cts-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+		rts-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
+		status = "okay";
+	};
+
+	scifa4: serial@e6c80000 {
+		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
+		reg = <0xe6c80000 0x100>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_SCIFA4>;
+		clock-names = "fck";
+		power-domains = <&pd_a3sp>;
+		uart-has-rtscts;
+		status = "okay";
+	};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
