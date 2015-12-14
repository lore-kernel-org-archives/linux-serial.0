From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 12/12] arm64: renesas: r8a7795 dtsi: Rename the serial port clock to fck
Date: Mon, 14 Dec 2015 19:58:06 +0100
Message-ID: <1450119486-1285-13-git-send-email-geert+renesas@glider.be>
References: <1450119486-1285-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119486-1285-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The clock is really the device functional clock, not the interface
clock. Rename it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v3:
  - Add Acked-by,

v2:
  - New.
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index dd266e56f23ded2c..a5afd9bad6791398 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -393,7 +393,7 @@
 			reg = <0 0xe6540000 0 96>;
 			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 520>;
-			clock-names = "sci_ick";
+			clock-names = "fck";
 			dmas = <&dmac1 0x31>, <&dmac1 0x30>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -407,7 +407,7 @@
 			reg = <0 0xe6550000 0 96>;
 			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 519>;
-			clock-names = "sci_ick";
+			clock-names = "fck";
 			dmas = <&dmac1 0x33>, <&dmac1 0x32>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -421,7 +421,7 @@
 			reg = <0 0xe6560000 0 96>;
 			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 518>;
-			clock-names = "sci_ick";
+			clock-names = "fck";
 			dmas = <&dmac1 0x35>, <&dmac1 0x34>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -435,7 +435,7 @@
 			reg = <0 0xe66a0000 0 96>;
 			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 517>;
-			clock-names = "sci_ick";
+			clock-names = "fck";
 			dmas = <&dmac0 0x37>, <&dmac0 0x36>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -449,7 +449,7 @@
 			reg = <0 0xe66b0000 0 96>;
 			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 516>;
-			clock-names = "sci_ick";
+			clock-names = "fck";
 			dmas = <&dmac0 0x39>, <&dmac0 0x38>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -462,7 +462,7 @@
 			reg = <0 0xe6e60000 0 64>;
 			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 207>;
-			clock-names = "sci_ick";
+			clock-names = "fck";
 			dmas = <&dmac1 0x51>, <&dmac1 0x50>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -475,7 +475,7 @@
 			reg = <0 0xe6e68000 0 64>;
 			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 206>;
-			clock-names = "sci_ick";
+			clock-names = "fck";
 			dmas = <&dmac1 0x53>, <&dmac1 0x52>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -488,7 +488,7 @@
 			reg = <0 0xe6e88000 0 64>;
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 310>;
-			clock-names = "sci_ick";
+			clock-names = "fck";
 			dmas = <&dmac1 0x13>, <&dmac1 0x12>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -501,7 +501,7 @@
 			reg = <0 0xe6c50000 0 64>;
 			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 204>;
-			clock-names = "sci_ick";
+			clock-names = "fck";
 			dmas = <&dmac0 0x57>, <&dmac0 0x56>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -514,7 +514,7 @@
 			reg = <0 0xe6c40000 0 64>;
 			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 203>;
-			clock-names = "sci_ick";
+			clock-names = "fck";
 			dmas = <&dmac0 0x59>, <&dmac0 0x58>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -527,7 +527,7 @@
 			reg = <0 0xe6f30000 0 64>;
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 202>;
-			clock-names = "sci_ick";
+			clock-names = "fck";
 			dmas = <&dmac1 0x5b>, <&dmac1 0x5a>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
-- 
1.9.1

