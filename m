From: jon-7zJyie9iPacdnm+yROfE0A@public.gmane.org
Subject: [PATCH v4 2/2] serial: sc16is7xx: Add bindings documentation for the SC16IS7XX UARTs
Date: Thu,  3 Apr 2014 00:49:15 -0400
Message-ID: <1396500555-28873-2-git-send-email-jon@ringle.org>
References: <1396500555-28873-1-git-send-email-jon@ringle.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1396500555-28873-1-git-send-email-jon-7zJyie9iPacdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jon Ringle <jringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Jon Ringle <jringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>

This patch adds the devicetree documentation for the NXP SC16IS7XX UARTs.

Signed-off-by: Jon Ringle <jringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>
---
 .../devicetree/bindings/serial/nxp,sc16is7xx.txt   | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt

diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
new file mode 100644
index 0000000..246c795
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
@@ -0,0 +1,33 @@
+* NXP SC16IS7xx advanced Universal Asynchronous Receiver-Transmitter (UART)
+
+Required properties:
+- compatible: Should be one of the following:
+  - "nxp,sc16is740" for NXP SC16IS740,
+  - "nxp,sc16is741" for NXP SC16IS741,
+  - "nxp,sc16is750" for NXP SC16IS750,
+  - "nxp,sc16is752" for NXP SC16IS752,
+  - "nxp,sc16is760" for NXP SC16IS760,
+  - "nxp,sc16is762" for NXP SC16IS762.
+- reg: I2C address of the SC16IS7xx device.
+- interrupt-parent: The phandle for the interrupt controller that
+  services interrupts for this IC.
+- interrupts: Should contain the UART interrupt
+- clocks: Reference to the IC source clock.
+
+Optional properties:
+- gpio-controller: Marks the device node as a GPIO controller.
+- #gpio-cells: Should be two. The first cell is the GPIO number and
+  the second cell is used to specify the GPIO polarity:
+    0 = active high,
+    1 = active low.
+
+Example:
+        sc16is750: sc16is750@51 {
+                compatible = "nxp,sc16is750";
+                reg = <0x51>;
+                clocks = <&clk20m>;
+                interrupt-parent = <&gpio3>;
+                interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+                gpio-controller;
+                #gpio-cells = <2>;
+        };
-- 
1.8.5.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
