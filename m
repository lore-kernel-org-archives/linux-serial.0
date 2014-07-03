From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v3 8/9] ARM: sun8i: Add PRCM clock and reset
 controller nodes to the DTSI
Date: Thu,  3 Jul 2014 22:55:48 +0800
Message-ID: <1404399349-20237-9-git-send-email-wens@csie.org>
References: <1404399349-20237-1-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBCMILY6JWQBBBBG62WOQKGQEQH7UMHQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1404399349-20237-1-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-serial@vger.kernel.org

With sun8i PRCM support available, we can add the PRCM clock and
reset controller nodes to the DTSI. Also update R_UART's clock
phandle and add it's reset control phandle.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 arch/arm/boot/dts/sun8i-a23.dtsi | 48 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 79c4083..e10c708 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -262,13 +262,59 @@
 			interrupts = <1 9 0xf04>;
 		};
 
+		prcm@01f01400 {
+			compatible = "allwinner,sun8i-a23-prcm";
+			reg = <0x01f01400 0x200>;
+
+			ar100: ar100_clk {
+				compatible = "fixed-factor-clock";
+				#clock-cells = <0>;
+				clock-div = <1>;
+				clock-mult = <1>;
+				clocks = <&osc24M>;
+				clock-output-names = "ar100";
+			};
+
+			ahb0: ahb0_clk {
+				compatible = "fixed-factor-clock";
+				#clock-cells = <0>;
+				clock-div = <1>;
+				clock-mult = <1>;
+				clocks = <&ar100>;
+				clock-output-names = "ahb0";
+			};
+
+			apb0: apb0_clk {
+				compatible = "allwinner,sun8i-a23-apb0-clk";
+				#clock-cells = <0>;
+				clocks = <&ahb0>;
+				clock-output-names = "apb0";
+			};
+
+			apb0_gates: apb0_gates_clk {
+				compatible = "allwinner,sun8i-a23-apb0-gates-clk";
+				#clock-cells = <1>;
+				clocks = <&apb0>;
+				clock-indices = <0>, <2>, <3>, <4>, <6>;
+				clock-output-names = "apb0_pio", "apb0_timer",
+						"apb0_rsb", "apb0_uart",
+						"apb0_i2c";
+			};
+
+			apb0_rst: apb0_rst {
+				compatible = "allwinner,sun6i-a31-clock-reset";
+				#reset-cells = <1>;
+			};
+		};
+
 		r_uart: serial@01f02800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01f02800 0x400>;
 			interrupts = <0 38 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&osc24M>;
+			clocks = <&apb0_gates 4>;
+			resets = <&apb0_rst 4>;
 			status = "disabled";
 		};
 	};
-- 
2.0.1
