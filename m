From: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] doc: dt: add documentation for nxp,lpc1850-uart
Date: Fri, 15 May 2015 20:29:15 +0200
Message-ID: <1431714555-7063-3-git-send-email-manabian@gmail.com>
References: <1431714555-7063-1-git-send-email-manabian@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431714555-7063-1-git-send-email-manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Add device tree binding documentation for nxp,lpc1850-uart.

Signed-off-by: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/serial/nxp,lpc1850-uart.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/nxp,lpc1850-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/nxp,lpc1850-uart.txt b/Documentation/devicetree/bindings/serial/nxp,lpc1850-uart.txt
new file mode 100644
index 000000000000..68d1f3292585
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/nxp,lpc1850-uart.txt
@@ -0,0 +1,21 @@
+* NXP LPC1850 UART
+
+Required properties:
+- compatible	: "nxp,lpc1850-uart", "ns16550a".
+- reg		: offset and length of the register set for the device.
+- interrupts	: should contain uart interrupt.
+- clocks	: phandle to the input clocks.
+- clock-names	: required elements: "uartclk", "reg".
+
+Since it's also possible to also use the of_serial.c driver all
+parameters from 8250.txt also apply but are optional.
+
+Example:
+uart0: serial@40081000 {
+	compatible = "nxp,lpc1850-uart", "ns16550a";
+	reg = <0x40081000 0x1000>;
+	reg-shift = <2>;
+	interrupts = <24>;
+	clocks = <&ccu2 CLK_APB0_UART0>, <&ccu1 CLK_CPU_UART0>;
+	clock-names = "uartclk", "reg";
+};
-- 
1.8.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
