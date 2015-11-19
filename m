From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 14/16] arm64: renesas: r8a7795 dtsi: Rename the serial port clock to fck
Date: Thu, 19 Nov 2015 19:36:11 +0100
Message-ID: <1447958173-543-15-git-send-email-geert+renesas@glider.be>
References: <1447958173-543-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1447958173-543-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The clock is really the device functional clock, not the interface
clock. Rename it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 979a087d2b596c03..53a2a8fb42b7480c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -363,7 +363,7 @@
 			reg = <0 0xe6540000 0 96>;
 			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 520>;
-			clock-names = "sci_ick";
+			clock-names = "fck";
 			dmas = <&dmac1 0x31>, <&dmac1 0x30>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -375,7 +375,7 @@
 			reg = <0 0xe6550000 0 96>;
 			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 519>;
-			clock-names = "sci_ick";
+			clock-names = "fck";
 			dmas = <&dmac1 0x33>, <&dmac1 0x32>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -387,7 +387,7 @@
 			reg = <0 0xe6560000 0 96>;
 			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 518>;
-			clock-names = "sci_ick";
+			clock-names = "fck";
 			dmas = <&dmac1 0x35>, <&dmac1 0x34>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -399,7 +399,7 @@
 			reg = <0 0xe66a0000 0 96>;
 			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 517>;
-			clock-names = "sci_ick";
+			clock-names = "fck";
 			dmas = <&dmac0 0x37>, <&dmac0 0x36>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -411,7 +411,7 @@
 			reg = <0 0xe66b0000 0 96>;
 			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 516>;
-			clock-names = "sci_ick";
+			clock-names = "fck";
 			dmas = <&dmac0 0x39>, <&dmac0 0x38>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -423,7 +423,7 @@
 			reg = <0 0xe6e60000 0 64>;
 			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 207>;
-			clock-names = "sci_ick";
+			clock-names = "fck";
 			dmas = <&dmac1 0x51>, <&dmac1 0x50>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -435,7 +435,7 @@
 			reg = <0 0xe6e68000 0 64>;
 			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 206>;
-			clock-names = "sci_ick";
+			clock-names = "fck";
 			dmas = <&dmac1 0x53>, <&dmac1 0x52>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -447,7 +447,7 @@
 			reg = <0 0xe6e88000 0 64>;
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 310>;
-			clock-names = "sci_ick";
+			clock-names = "fck";
 			dmas = <&dmac1 0x13>, <&dmac1 0x12>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -459,7 +459,7 @@
 			reg = <0 0xe6c50000 0 64>;
 			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 204>;
-			clock-names = "sci_ick";
+			clock-names = "fck";
 			dmas = <&dmac0 0x57>, <&dmac0 0x56>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -471,7 +471,7 @@
 			reg = <0 0xe6c40000 0 64>;
 			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 203>;
-			clock-names = "sci_ick";
+			clock-names = "fck";
 			dmas = <&dmac0 0x59>, <&dmac0 0x58>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -483,7 +483,7 @@
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

