From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v4 28/29] serial: sh-sci: Add device tree bindings documentation
Date: Thu, 28 Nov 2013 00:18:38 +0100
Message-ID: <1385594319-5758-29-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385594319-5758-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1385594319-5758-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Document the device tree bindings for the sci serial port devices.

Cc: devicetree@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../bindings/serial/renesas,sci-serial.txt         | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
new file mode 100644
index 0000000..f372cf2
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -0,0 +1,46 @@
+* Renesas SH-Mobile Serial Communication Interface
+
+Required properties:
+
+  - compatible: Must contain one of the following:
+
+    - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
+    - "renesas,scifa-r8a7790" for R8A7790 (R-Car H2) SCIFA compatible UART.
+    - "renesas,scifb-r8a7790" for R8A7790 (R-Car H2) SCIFB compatible UART.
+    - "renesas,hscif-r8a7790" for R8A7790 (R-Car H2) HSCIF compatible UART.
+    - "renesas,scif-r8a7791" for R8A7791 (R-Car M2) SCIF compatible UART.
+    - "renesas,scifa-r8a7791" for R8A7791 (R-Car M2) SCIFA compatible UART.
+    - "renesas,scifb-r8a7791" for R8A7791 (R-Car M2) SCIFB compatible UART.
+    - "renesas,hscif-r8a7791" for R8A7791 (R-Car M2) HSCIF compatible UART.
+    - "renesas,scif" for generic SCIF compatible UART.
+    - "renesas,scifa" for generic SCIFA compatible UART.
+    - "renesas,scifb" for generic SCIFB compatible UART.
+    - "renesas,hscif" for generic HSCIF compatible UART.
+
+    When compatible with the generic version, nodes must list the
+    SoC-specific version corresponding to the platform first followed by the
+    generic version.
+
+  - reg: Base address and length of the I/O registers used by the UART.
+  - interrupts: Must contain an interrupt-specifier for the SCIx interrupt.
+
+  - clocks: Must contain a phandle and clock-specifier pair for each entry
+    in clock-names.
+  - clock-names: Must contain "sci_ick" for the SCIx UART interface clock.
+
+Note: Each enabled SCIx UART should have an alias correctly numbered in the
+"aliases" node.
+
+Example:
+	aliases {
+		serial0 = &scifa0;
+	};
+
+	scifa0: serial@e6c40000 {
+		compatible = "renesas,scifa-r8a7790", "renesas,scifa-generic";
+		reg = <0 0xe6c40000 0 64>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7790_CLK_SCIFA0>;
+		clock-names = "sci_ick";
+	};
-- 
1.8.3.2

