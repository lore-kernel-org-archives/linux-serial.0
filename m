From: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH resend v3] dt-bindings: mvebu-uart: update documentation with extended UART
Date: Thu,  7 Dec 2017 11:12:59 +0100
Message-ID: <20171207101259.2213-1-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Update the device tree binding documentation for the Marvell EBU UART,
in order to allow describing the extended UART IP block, in addition to
the already supported standard UART IP. This requires adding a new
compatible string, the introduction of a clocks property, and extensions
to the interrupts property.

Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---

Hello,

Due to a conflict when applying this patch it did not make it to the last
release. This time it should apply cleanly.

Thanks,
Miquèl


 .../devicetree/bindings/serial/mvebu-uart.txt      | 50 +++++++++++++++++++---
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/mvebu-uart.txt b/Documentation/devicetree/bindings/serial/mvebu-uart.txt
index d37fabe17bd1..2ae2fee7e023 100644
--- a/Documentation/devicetree/bindings/serial/mvebu-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mvebu-uart.txt
@@ -1,13 +1,53 @@
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
+- clocks: UART reference clock used to derive the baudrate. If no clock
+      is provided (possible only with the "marvell,armada-3700-uart"
+      compatible string for backward compatibility), it will only work
+      if the baudrate was initialized by the bootloader and no baudrate
+      change will then be possible.
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
 	};
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
