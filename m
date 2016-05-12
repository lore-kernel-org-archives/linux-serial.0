From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] serial: sh-sci: Document SoC specific bindings for r8a7796
Date: Thu, 12 May 2016 15:33:58 +0900
Message-ID: <1463034838-13322-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>

Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 528c3b90f23c..503bce3ad07d 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -31,6 +31,8 @@ Required properties:
     - "renesas,hscif-r8a7794" for R8A7794 (R-Car E2) HSCIF compatible UART.
     - "renesas,scif-r8a7795" for R8A7795 (R-Car H3) SCIF compatible UART.
     - "renesas,hscif-r8a7795" for R8A7795 (R-Car H3) HSCIF compatible UART.
+    - "renesas,scif-r8a7796" for R8A7796 (R-Car M3-W) SCIF compatible UART.
+    - "renesas,hscif-r8a7796" for R8A7796 (R-Car M3-W) HSCIF compatible UART.
     - "renesas,scifa-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFA compatible UART.
     - "renesas,scifb-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFB compatible UART.
     - "renesas,rcar-gen1-scif" for R-Car Gen1 SCIF compatible UART,
-- 
2.1.4
