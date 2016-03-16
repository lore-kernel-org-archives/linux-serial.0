From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 3/4] ARM: dts: r8a7779: Add HSCIF0/1 device nodes
Date: Wed, 16 Mar 2016 18:10:09 +0100
Message-ID: <1458148210-21800-4-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1458148210-21800-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1458148210-21800-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: horms@verge.net.au
Cc: linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Based on Rev. 1.00 of the R-Car H1 datasheet.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7779.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 14b28c2..71a48c0 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -285,6 +285,32 @@
 		status = "disabled";
 	};
 
+	hscif0: serial@ffe48000 {
+		compatible = "renesas,hscif-r8a7779",
+			     "renesas,rcar-gen1-hscif", "renesas,hscif";
+		reg = <0 0xffe48000 0 96>;
+		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_HSCIF0>,
+			 <&cpg_clocks R8A7779_CLK_S>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	hscif1: serial@ffe49000 {
+		compatible = "renesas,hscif-r8a7779",
+			     "renesas,rcar-gen1-hscif", "renesas,hscif";
+		reg = <0 0xffe49000 0 96>;
+		interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_HSCIF0>,
+			 <&cpg_clocks R8A7779_CLK_S>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
 	pfc: pfc@fffc0000 {
 		compatible = "renesas,pfc-r8a7779";
 		reg = <0xfffc0000 0x23c>;
-- 
2.6.4
