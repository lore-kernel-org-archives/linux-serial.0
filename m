From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v2] sh-sci: document R8A7743/5 support
Date: Fri, 21 Oct 2016 23:00:43 +0300
Message-ID: <4258682.UW6HhKP1CC@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Renesas RZ/G SoC also have the SCIF, SCIFA, SCIFB, and HSCIF ports and
they  seem compatible with the R-Car gen2 SoC  in this respect...
Document RZ/G1[ME] (also known as R8A774[35]) SoC bindings.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
This patch is against the 'tty-next' branch of GregKH's 'tty.git' repo.

Changes in version 2:
- removed the RZ/G  family specific bindings, renamed the patch;
- added Simon's and Geert's ACKs.

 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: tty/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
===================================================================
--- tty.orig/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ tty/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -9,6 +9,14 @@ Required properties:
     - "renesas,scifb-r8a73a4" for R8A73A4 (R-Mobile APE6) SCIFB compatible UART.
     - "renesas,scifa-r8a7740" for R8A7740 (R-Mobile A1) SCIFA compatible UART.
     - "renesas,scifb-r8a7740" for R8A7740 (R-Mobile A1) SCIFB compatible UART.
+    - "renesas,scif-r8a7743" for R8A7743 (RZ/G1M) SCIF compatible UART.
+    - "renesas,scifa-r8a7743" for R8A7743 (RZ/G1M) SCIFA compatible UART.
+    - "renesas,scifb-r8a7743" for R8A7743 (RZ/G1M) SCIFB compatible UART.
+    - "renesas,hscif-r8a7743" for R8A7743 (RZ/G1M) HSCIF compatible UART.
+    - "renesas,scif-r8a7745" for R8A7745 (RZ/G1E) SCIF compatible UART.
+    - "renesas,scifa-r8a7745" for R8A7745 (RZ/G1E) SCIFA compatible UART.
+    - "renesas,scifb-r8a7745" for R8A7745 (RZ/G1E) SCIFB compatible UART.
+    - "renesas,hscif-r8a7745" for R8A7745 (RZ/G1E) HSCIF compatible UART.
     - "renesas,scif-r8a7778" for R8A7778 (R-Car M1) SCIF compatible UART.
     - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART.
     - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
