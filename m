From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 1/4] ARM: dts: r8a7778: Add HSCIF0/1 clocks
Date: Wed, 16 Mar 2016 18:10:07 +0100
Message-ID: <1458148210-21800-2-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1458148210-21800-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1458148210-21800-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: horms@verge.net.au
Cc: linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Based on Rev. 1.00 of the R-Car M1A datasheet.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7778.dtsi            | 4 ++++
 include/dt-bindings/clock/r8a7778-clock.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index f83a348..0407df1 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -543,6 +543,8 @@
 				 <&cpg_clocks R8A7778_CLK_P>,
 				 <&cpg_clocks R8A7778_CLK_P>,
 				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_S>,
+				 <&cpg_clocks R8A7778_CLK_S>,
 				 <&cpg_clocks R8A7778_CLK_P>,
 				 <&cpg_clocks R8A7778_CLK_P>,
 				 <&cpg_clocks R8A7778_CLK_P>,
@@ -559,6 +561,7 @@
 				R8A7778_CLK_SCIF0 R8A7778_CLK_SCIF1
 				R8A7778_CLK_SCIF2 R8A7778_CLK_SCIF3
 				R8A7778_CLK_SCIF4 R8A7778_CLK_SCIF5
+				R8A7778_CLK_HSCIF0 R8A7778_CLK_HSCIF1
 				R8A7778_CLK_TMU0 R8A7778_CLK_TMU1
 				R8A7778_CLK_TMU2 R8A7778_CLK_SSI0
 				R8A7778_CLK_SSI1 R8A7778_CLK_SSI2
@@ -568,6 +571,7 @@
 			clock-output-names =
 				"i2c0", "i2c1", "i2c2", "i2c3", "scif0",
 				"scif1", "scif2", "scif3", "scif4", "scif5",
+				"hscif0", "hscif1",
 				"tmu0", "tmu1", "tmu2", "ssi0", "ssi1",
 				"ssi2", "ssi3", "sru", "hspi";
 		};
diff --git a/include/dt-bindings/clock/r8a7778-clock.h b/include/dt-bindings/clock/r8a7778-clock.h
index f6b07c5..d0bff9e 100644
--- a/include/dt-bindings/clock/r8a7778-clock.h
+++ b/include/dt-bindings/clock/r8a7778-clock.h
@@ -30,6 +30,8 @@
 #define R8A7778_CLK_SCIF3	23
 #define R8A7778_CLK_SCIF4	22
 #define R8A7778_CLK_SCIF5	21
+#define R8A7778_CLK_HSCIF0	19
+#define R8A7778_CLK_HSCIF1	18
 #define R8A7778_CLK_TMU0	16
 #define R8A7778_CLK_TMU1	15
 #define R8A7778_CLK_TMU2	14
-- 
2.6.4
