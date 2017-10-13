From: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 01/16] dt-bindings: mvebu-uart: update documentation with extended UART
Date: Fri, 13 Oct 2017 11:01:45 +0200
Message-ID: <20171013090200.31034-2-miquel.raynal@free-electrons.com>
References: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171013090200.31034-1-miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Update the Device Tree binding documentation for the Marvell EBU UART,
in order to allow describing the extended UART IP block, in addition to
the already supported standard UART IP. This requires adding a new
compatible string, the introduction of a clocks property, and extensions
to the interrupts property.

Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 .../devicetree/bindings/serial/mvebu-uart.txt      | 49 +++++++++++++++++++---
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/mvebu-uart.txt b/Documentation/devicetree/bindings/serial/mvebu-uart.txt
index d37fabe17bd1..3df3a3fab4bb 100644
--- a/Documentation/devicetree/bindings/serial/mvebu-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mvebu-uart.txt
@@ -1,13 +1,52 @@
-* Marvell UART : Non standard UART used in some of Marvell EBU SoCs (e.g., Armada-3700)
+* Marvell UART : Non standard UART used in some of Marvell EBU SoCs
+                 e.g., Armada-3700.
 
 Required properties:
-- compatible: "marvell,armada-3700-uart"
+- compatible:
+    - "marvell,armada-3700-uart" for the standard variant of the UART
+      (32 bytes FIFO, no DMA, level interrupts, 8-bit access to the
+      FIFO, baudrate limited to 230400).
+    - "marvell,armada-3700-uart-ext" for the extended variant of the
+      UART (128 bytes FIFO, DMA, front interrupts, 8-bit or 32-bit
+      accesses to the FIFO, baudrate unlimited by the dividers).
 - reg: offset and length of the register set for the device.
-- interrupts: device interrupt
+- clocks: UART reference clock used to derive the baudrate (only
+      mandatory with "marvell,armada-3700-uart-ext" compatible).
+- interrupts:
+    - Must contain three elements for the standard variant of the IP
+      (marvell,armada-3700-uart): "uart-sum", "uart-tx" and "uart-rx",
+      respectively the UART sum interrupt, the UART TX interrupt and
+      UART RX interrupt. A corresponding interrupt-names property must
+      be defined.
+    - Must contain two elements for the extended variant of the IP
+      (marvell,armada-3700-uart-ext): "uart-tx" and "uart-rx",
+      respectively the UART TX interrupt and the UART RX interrupt. A
+      corresponding interrupts-names property must be defined.
+    - For backward compatibility reasons, a single element interrupts
+      property is also supported for the standard variant of the IP,
+      containing only the UART sum interrupt. This form is deprecated
+      and should no longer be used.
 
 Example:
-	serial@12000 {
+	uart0: serial@12000 {
 		compatible = "marvell,armada-3700-uart";
 		reg = <0x12000 0x200>;
-		interrupts = <43>;
+		clocks = <&xtalclk>;
+		interrupts =
+		<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "uart-sum", "uart-tx", "uart-rx";
+		status = "disabled";
+	};
+
+	uart1: serial@12200 {
+		compatible = "marvell,armada-3700-uart-ext";
+		reg = <0x12200 0x30>;
+		clocks = <&xtalclk>;
+		interrupts =
+		<GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
+		<GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "uart-tx", "uart-rx";
+		status = "disabled";
 	};
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
