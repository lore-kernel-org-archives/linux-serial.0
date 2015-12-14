From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v3 02/12] ARM: shmobile: sh73a0 dtsi: Rename the serial port clock to fck
Date: Mon, 14 Dec 2015 19:57:56 +0100
Message-ID: <1450119486-1285-3-git-send-email-geert+renesas@glider.be>
References: <1450119486-1285-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450119486-1285-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

The clock is really the device functional clock, not the interface
clock. Rename it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Acked-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
v3:
  - No changes,

v2:
  - Add Acked-by.
---
 arch/arm/boot/dts/sh73a0.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 3a6056f9f0d23f17..866ee5de09454d14 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -359,7 +359,7 @@
 		reg = <0xe6c40000 0x100>;
 		interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFA0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
@@ -369,7 +369,7 @@
 		reg = <0xe6c50000 0x100>;
 		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFA1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
@@ -379,7 +379,7 @@
 		reg = <0xe6c60000 0x100>;
 		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFA2>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
@@ -389,7 +389,7 @@
 		reg = <0xe6c70000 0x100>;
 		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFA3>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
@@ -399,7 +399,7 @@
 		reg = <0xe6c80000 0x100>;
 		interrupts = <0 78 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFA4>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
@@ -409,7 +409,7 @@
 		reg = <0xe6cb0000 0x100>;
 		interrupts = <0 79 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFA5>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
@@ -419,7 +419,7 @@
 		reg = <0xe6cc0000 0x100>;
 		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks SH73A0_CLK_SCIFA6>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
@@ -429,7 +429,7 @@
 		reg = <0xe6cd0000 0x100>;
 		interrupts = <0 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFA7>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
@@ -439,7 +439,7 @@
 		reg = <0xe6c30000 0x100>;
 		interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFB>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
