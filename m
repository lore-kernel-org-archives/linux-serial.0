From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 02/27] serial: sh-sci: Add fallback compatibility strings
Date: Mon, 14 Dec 2015 19:57:11 +0100
Message-ID: <1450119456-964-3-git-send-email-geert+renesas@glider.be>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Add fallback compatibility strings for R-Car Gen1, Gen2, and Gen3.
This is in keeping with the fallback scheme being adopted wherever
appropriate for drivers for Renesas SoCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org
---
v3:
  - New.
---
 .../devicetree/bindings/serial/renesas,sci-serial.txt   | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 2c9e6b8477e92792..7091213f02513cda 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -2,7 +2,7 @@
 
 Required properties:
 
-  - compatible: Must contain one of the following:
+  - compatible: Must contain one or more of the following:
 
     - "renesas,scif-r7s72100" for R7S72100 (RZ/A1H) SCIF compatible UART.
     - "renesas,scifa-r8a73a4" for R8A73A4 (R-Mobile APE6) SCIFA compatible UART.
@@ -27,6 +27,14 @@ Required properties:
     - "renesas,hscif-r8a7795" for R8A7795 (R-Car H3) HSCIF compatible UART.
     - "renesas,scifa-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFA compatible UART.
     - "renesas,scifb-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFB compatible UART.
+    - "renesas,rcar-gen1-scif" for R-Car Gen1 SCIF compatible UART,
+    - "renesas,rcar-gen2-scif" for R-Car Gen2 SCIF compatible UART,
+    - "renesas,rcar-gen3-scif" for R-Car Gen3 SCIF compatible UART,
+    - "renesas,rcar-gen2-scifa" for R-Car Gen2 SCIFA compatible UART,
+    - "renesas,rcar-gen2-scifb" for R-Car Gen2 SCIFB compatible UART,
+    - "renesas,rcar-gen1-hscif" for R-Car Gen1 HSCIF compatible UART,
+    - "renesas,rcar-gen2-hscif" for R-Car Gen2 HSCIF compatible UART,
+    - "renesas,rcar-gen3-hscif" for R-Car Gen3 HSCIF compatible UART,
     - "renesas,scif" for generic SCIF compatible UART.
     - "renesas,scifa" for generic SCIFA compatible UART.
     - "renesas,scifb" for generic SCIFB compatible UART.
@@ -34,8 +42,8 @@ Required properties:
     - "renesas,sci" for generic SCI compatible UART.
 
     When compatible with the generic version, nodes must list the
-    SoC-specific version corresponding to the platform first followed by the
-    generic version.
+    SoC-specific version corresponding to the platform first, followed by the
+    family-specific and/or generic versions.
 
   - reg: Base address and length of the I/O registers used by the UART.
   - interrupts: Must contain an interrupt-specifier for the SCIx interrupt.
@@ -58,7 +66,8 @@ Example:
 	};
 
 	scifa0: serial@e6c40000 {
-		compatible = "renesas,scifa-r8a7790", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7790",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c40000 0 64>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.9.1

