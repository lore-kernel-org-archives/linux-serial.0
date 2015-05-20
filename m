From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 4/4] ARM: shmobile: r8a7794 dtsi: Describe DMA for the serial ports
Date: Wed, 20 May 2015 19:46:27 +0200
Message-ID: <1432143987-10308-5-git-send-email-geert+renesas@glider.be>
References: <1432143987-10308-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432143987-10308-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Add DMA properties to all SCIF, SCIFA, SCIFB, and HSCIF device nodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 arch/arm/boot/dts/r8a7794.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 01cf54f70501e8c2..b738194233113402 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -174,6 +174,8 @@
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFA0>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -183,6 +185,8 @@
 		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFA1>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x25>, <&dmac0 0x26>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -192,6 +196,8 @@
 		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFA2>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x27>, <&dmac0 0x28>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -201,6 +207,8 @@
 		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7794_CLK_SCIFA3>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -210,6 +218,8 @@
 		interrupts = <0 30 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7794_CLK_SCIFA4>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x1f>, <&dmac0 0x20>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -219,6 +229,8 @@
 		interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7794_CLK_SCIFA5>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x23>, <&dmac0 0x24>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -228,6 +240,8 @@
 		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFB0>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -237,6 +251,8 @@
 		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFB1>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -246,6 +262,8 @@
 		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFB2>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -255,6 +273,8 @@
 		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF0>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -264,6 +284,8 @@
 		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF1>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -273,6 +295,8 @@
 		interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF2>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -282,6 +306,8 @@
 		interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF3>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x2f>, <&dmac0 0x30>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -291,6 +317,8 @@
 		interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF4>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -300,6 +328,8 @@
 		interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF5>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -309,6 +339,8 @@
 		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_HSCIF0>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -318,6 +350,8 @@
 		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_HSCIF1>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -327,6 +361,8 @@
 		interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_HSCIF2>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
