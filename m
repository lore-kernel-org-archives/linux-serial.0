From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 04/27] serial: sh-sci: Update DT binding documentation for BRG support
Date: Mon, 14 Dec 2015 19:57:13 +0100
Message-ID: <1450119456-964-5-git-send-email-geert+renesas@glider.be>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Amend the DT bindings to include the optional clock sources for the Baud
Rate Generator for External Clock (BRG), as found on some SCIF variants
and on HSCIF.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org
---
v3:
  - Add Acked-by,
  - Rename "int_clk" to "brg_int".
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 31cc0631ef7ca22d..f4ad30ef1628f8da 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -56,6 +56,12 @@ Required properties:
     On (H)SCI(F) and some SCIFA, an additional clock may be specified:
       - "hsck" for the optional external clock input (on HSCIF),
       - "sck" for the optional external clock input (on other variants).
+    On UARTs equipped with a Baud Rate Generator for External Clock (BRG)
+    (some SCIF and HSCIF), additional clocks may be specified:
+      - "brg_int" for the optional internal clock source for the frequency
+	divider (typically the (AXI or SHwy) bus clock),
+      - "scif_clk" for the optional external clock source for the frequency
+	divider (SCIF_CLK).
 
 Note: Each enabled SCIx UART should have an alias correctly numbered in the
 "aliases" node.
-- 
1.9.1

