From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v3 9/9] ARM: sun8i: Add reset controller nodes
 to the DTSI
Date: Thu,  3 Jul 2014 22:55:49 +0800
Message-ID: <1404399349-20237-10-git-send-email-wens@csie.org>
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

The A23 has the same MMIO reset controllers matching the clocks gates,
just like in the A31. This patch adds the reset controller nodes and
the reset control phandles for the peripherals needing them to the
DTSI.

Unlike the sun6i DTSI, this patch uses sun6i-a31-clock-reset for
ahb1_rst. sun6i-a31-ahb-reset is for early init, and requires some
additions to the machine code. It is used to support the hstimer.
However the hstimer on sun8i only has 1 timer, which is somewhat
useless. Support for it will probably not be added. Hence the
decision to use sun6i-a31-clock-reset here to avoid the changes to
sun8i machine code.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 arch/arm/boot/dts/sun8i-a23.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index e10c708..7d47933 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -187,6 +187,24 @@
 		#size-cells = <1>;
 		ranges;
 
+		ahb1_rst: reset@01c202c0 {
+			#reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-clock-reset";
+			reg = <0x01c202c0 0xc>;
+		};
+
+		apb1_rst: reset@01c202d0 {
+			#reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-clock-reset";
+			reg = <0x01c202d0 0x4>;
+		};
+
+		apb2_rst: reset@01c202d8 {
+			#reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-clock-reset";
+			reg = <0x01c202d8 0x4>;
+		};
+
 		timer@01c20c00 {
 			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x01c20c00 0xa0>;
@@ -208,6 +226,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 16>;
+			resets = <&apb2_rst 16>;
 			status = "disabled";
 		};
 
@@ -218,6 +237,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 17>;
+			resets = <&apb2_rst 17>;
 			status = "disabled";
 		};
 
@@ -228,6 +248,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 18>;
+			resets = <&apb2_rst 18>;
 			status = "disabled";
 		};
 
@@ -238,6 +259,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 19>;
+			resets = <&apb2_rst 19>;
 			status = "disabled";
 		};
 
@@ -248,6 +270,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 20>;
+			resets = <&apb2_rst 20>;
 			status = "disabled";
 		};
 
-- 
2.0.1
