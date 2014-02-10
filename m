From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH 8/8] serial: max310x: Add bindings documentation for the MAX310X UARTs
Date: Mon, 10 Feb 2014 22:17:47 +0400
Message-ID: <1392056267-13806-1-git-send-email-shc_work@mail.ru>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

This patch adds the devicetree documentation for the Maxim MAX310X UARTs.

Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
---
 .../devicetree/bindings/serial/maxim,max310x.txt   | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/maxim,max310x.txt

diff --git a/Documentation/devicetree/bindings/serial/maxim,max310x.txt b/Documentation/devicetree/bindings/serial/maxim,max310x.txt
new file mode 100644
index 0000000..0daf780
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/maxim,max310x.txt
@@ -0,0 +1,36 @@
+* Maxim MAX310X advanced Universal Asynchronous Receiver-Transmitter (UART)
+
+Required properties:
+- compatible: Should be one of the following:
+  - "maxim,max3107" for Maxim MAX3107,
+  - "maxim,max3108" for Maxim MAX3108,
+  - "maxim,max3109" for Maxim MAX3109,
+  - "maxim,max14830" for Maxim MAX14830.
+- reg: SPI chip select number.
+- interrupt-parent: The phandle for the interrupt controller that
+  services interrupts for this IC.
+- interrupts: Specifies the interrupt source of the parent interrupt
+  controller. The format of the interrupt specifier depends on the
+  parent interrupt controller.
+- clocks: phandle to the IC source clock.
+- clock-names: Should be "osc" if clock is an external crystal or
+  "xtal" if an external clock source is used.
+
+Optional properties:
+- gpio-controller: Marks the device node as a GPIO controller.
+- #gpio-cells: Should be two. The first cell is the GPIO number and
+  the second cell is used to specify the GPIO polarity:
+    0 = active high,
+    1 = active low.
+
+Example:
+	max14830: max14830@0 {
+		compatible = "maxim,max14830";
+		reg = <0>;
+		clocks = <&clk20m>;
+		clock-names = "osc";
+		interrupt-parent = <&gpio3>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
