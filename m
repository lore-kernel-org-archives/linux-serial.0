From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/4] serial: sh-sci: Add DMA support to the DT binding documentation
Date: Wed, 20 May 2015 19:46:24 +0200
Message-ID: <1432143987-10308-2-git-send-email-geert+renesas@glider.be>
References: <1432143987-10308-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1432143987-10308-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index ae73bb0e9ad9e58b..b91fcff4b7d48133 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -44,6 +44,11 @@ Required properties:
 Note: Each enabled SCIx UART should have an alias correctly numbered in the
 "aliases" node.
 
+Optional properties:
+  - dmas: Must contain a list of two references to DMA specifiers, one for
+	  transmission, and one for reception.
+  - dma-names: Must contain a list of two DMA names, "tx" and "rx".
+
 Example:
 	aliases {
 		serial0 = &scifa0;
@@ -56,4 +61,6 @@ Example:
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA0>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
+		dma-names = "tx", "rx";
 	};
-- 
1.9.1

