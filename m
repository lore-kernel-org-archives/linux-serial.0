From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: sh-sci: Add device tree bindings for r8a7793
Date: Mon, 19 Oct 2015 14:31:49 +0200
Message-ID: <1445257909-4914-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Also replaces "R-Car M2" with "R-Car M2-W" to avoid confusion.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/serial/renesas,sci-serial.txt        | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 73f825e5e6448815..ce23378064227775 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -15,10 +15,14 @@ Required properties:
     - "renesas,scifa-r8a7790" for R8A7790 (R-Car H2) SCIFA compatible UART.
     - "renesas,scifb-r8a7790" for R8A7790 (R-Car H2) SCIFB compatible UART.
     - "renesas,hscif-r8a7790" for R8A7790 (R-Car H2) HSCIF compatible UART.
-    - "renesas,scif-r8a7791" for R8A7791 (R-Car M2) SCIF compatible UART.
-    - "renesas,scifa-r8a7791" for R8A7791 (R-Car M2) SCIFA compatible UART.
-    - "renesas,scifb-r8a7791" for R8A7791 (R-Car M2) SCIFB compatible UART.
-    - "renesas,hscif-r8a7791" for R8A7791 (R-Car M2) HSCIF compatible UART.
+    - "renesas,scif-r8a7791" for R8A7791 (R-Car M2-W) SCIF compatible UART.
+    - "renesas,scifa-r8a7791" for R8A7791 (R-Car M2-W) SCIFA compatible UART.
+    - "renesas,scifb-r8a7791" for R8A7791 (R-Car M2-W) SCIFB compatible UART.
+    - "renesas,hscif-r8a7791" for R8A7791 (R-Car M2-W) HSCIF compatible UART.
+    - "renesas,scif-r8a7793" for R8A7793 (R-Car M2-N) SCIF compatible UART.
+    - "renesas,scifa-r8a7793" for R8A7793 (R-Car M2-N) SCIFA compatible UART.
+    - "renesas,scifb-r8a7793" for R8A7793 (R-Car M2-N) SCIFB compatible UART.
+    - "renesas,hscif-r8a7793" for R8A7793 (R-Car M2-N) HSCIF compatible UART.
     - "renesas,scif-r8a7794" for R8A7794 (R-Car E2) SCIF compatible UART.
     - "renesas,scifa-r8a7794" for R8A7794 (R-Car E2) SCIFA compatible UART.
     - "renesas,scifb-r8a7794" for R8A7794 (R-Car E2) SCIFB compatible UART.
-- 
1.9.1
