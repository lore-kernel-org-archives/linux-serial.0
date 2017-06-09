From: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v4 1/7] dt-bindings: serial: Add bindings for the Amlogic Meson UARTs
Date: Fri,  9 Jun 2017 11:49:10 +0200
Message-ID: <1497001756-942-2-git-send-email-narmstrong@baylibre.com>
References: <1497001756-942-1-git-send-email-narmstrong@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1497001756-942-1-git-send-email-narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: Helmut Klein <hgkr.klein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Helmut Klein <hgkr.klein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Add the documentation for the device tree binding of Amlogic Meson Serial UART.

Signed-off-by: Helmut Klein <hgkr.klein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 .../bindings/serial/amlogic,meson-uart.txt         | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
new file mode 100644
index 0000000..8ff65fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
@@ -0,0 +1,38 @@
+Amlogic Meson SoC UART Serial Interface
+=======================================
+
+The Amlogic Meson SoC UART Serial Interface is present on a large range
+of SoCs, and can be present either in the "Always-On" power domain or the
+"Everything-Else" power domain.
+
+The particularity of the "Always-On" Serial Interface is that the hardware
+is active since power-on and does not need any clock gating and is usable
+as very early serial console.
+
+Required properties:
+- compatible : compatible: value should be different for each SoC family as :
+	- Meson6 : "amlogic,meson6-uart"
+	- Meson8 : "amlogic,meson8-uart"
+	- Meson8b : "amlogic,meson8b-uart"
+	- GX (GXBB, GXL, GXM) : "amlogic,meson-gx-uart"
+	eventually followed by : "amlogic,meson-ao-uart" if this UART interface
+	is in the "Always-On" power domain.
+- reg : offset and length of the register set for the device.
+- interrupts : identifier to the device interrupt
+- clocks : a list of phandle + clock-specifier pairs, one for each
+	   entry in clock names.
+- clocks-names :
+   * "xtal" for external xtal clock identifier
+   * "pclk" for the bus core clock, either the clk81 clock or the gate clock
+   * "baud" for the source of the baudrate generator, can be either the xtal
+	or the pclk.
+
+e.g.
+uart_A: serial@84c0 {
+	compatible = "amlogic,meson-gx-uart";
+	reg = <0x0 0x84c0 0x0 0x14>;
+	interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
+	/* Use xtal as baud rate clock source */
+	clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
+	clock-names = "xtal", "pclk", "baud";
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
