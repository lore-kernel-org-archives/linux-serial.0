From: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: [PATCH] serial: 8250_uniphier: add bindings document for UniPhier UART
Date: Fri, 12 Jun 2015 18:04:17 +0900
Message-ID: <1434099857-13594-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This is binding information for the UniPhier on-chip UART driver
(drivers/tty/serial/8250/8250_uniphier.c).

Signed-off-by: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
---

Greg,

If not too late, can you merge this patch into your tty repository
for the upcoming merge window, please?


 .../devicetree/bindings/serial/uniphier-uart.txt   | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/uniphier-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/uniphier-uart.txt b/Documentation/devicetree/bindings/serial/uniphier-uart.txt
new file mode 100644
index 0000000..0b3892a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/uniphier-uart.txt
@@ -0,0 +1,23 @@
+UniPhier UART controller
+
+Required properties:
+- compatible: should be "socionext,uniphier-uart".
+- reg: offset and length of the register set for the device.
+- interrupts: a single interrupt specifier.
+- clocks: phandle to the input clock.
+
+Optional properties:
+- fifo-size: the RX/TX FIFO size.  Defaults to 64 if not specified.
+
+Example:
+	aliases {
+		serial0 = &serial0;
+	};
+
+	serial0: serial@54006800 {
+		compatible = "socionext,uniphier-uart";
+		reg = <0x54006800 0x40>;
+		interrupts = <0 33 4>;
+		clocks = <&uart_clk>;
+		fifo-size = <64>;
+	};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
