From: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 2/2] doc: dt: add documentation for nxp,lpc1850-uart
Date: Sat, 30 May 2015 23:14:45 +0200
Message-ID: <1433020485-20994-3-git-send-email-manabian@gmail.com>
References: <1433020485-20994-1-git-send-email-manabian@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1433020485-20994-1-git-send-email-manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org
Cc: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Add device tree binding documentation for nxp,lpc1850-uart.

Signed-off-by: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../bindings/serial/nxp,lpc1850-uart.txt           | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/nxp,lpc1850-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/nxp,lpc1850-uart.txt b/Documentation/devicetree/bindings/serial/nxp,lpc1850-uart.txt
new file mode 100644
index 000000000000..04e23e63ee4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/nxp,lpc1850-uart.txt
@@ -0,0 +1,28 @@
+* NXP LPC1850 UART
+
+Required properties:
+- compatible	: "nxp,lpc1850-uart", "ns16550a".
+- reg		: offset and length of the register set for the device.
+- interrupts	: should contain uart interrupt.
+- clocks	: phandle to the input clocks.
+- clock-names	: required elements: "uartclk", "reg".
+
+Optional properties:
+- dmas		: Two or more DMA channel specifiers following the
+		  convention outlined in bindings/dma/dma.txt
+- dma-names	: Names for the dma channels, if present. There must
+		  be at least one channel named "tx" for transmit
+		  and named "rx" for receive.
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
