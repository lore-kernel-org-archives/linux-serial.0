From: Paul Osmialowski <pawelo-rhuoMcPwk82rDJvtcaxF/A@public.gmane.org>
Subject: [PATCH v2 9/9] arm: twr-k70f120m: use Freescale lpuart driver with Kinetis SoC
Date: Tue, 30 Jun 2015 14:27:30 +0200
Message-ID: <1435667250-28299-10-git-send-email-pawelo@king.net.pl>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435667250-28299-1-git-send-email-pawelo-rhuoMcPwk82rDJvtcaxF/A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Uwe Kleine-Koenig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Paul Osmialowski <pawelo-rhuoMcPwk82rDJvtcaxF/A@public.gmane.org>, Anson Huang <b20788-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Frank Li <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Jingchang Lu <jingchang.lu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Rob Herring <r.herring-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Yuri Tikhonov <yur-qv+LCo8X3VpBDgjK7y7TUQ@public.gmane.org>, Sergei Poselenov <sposelenov-qv+LCo8X3VpBDgjK7y7TUQ@public.gmane.org>, Alexander Potashev <aspotashev-qv+LCo8X3VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Note that enabling tx DMA resulted in messy output, so I didn't configure
it in the .dts file - however nothing in the code prevents one from doing
so. Also note that original reference UART driver from Emcraft did not
implement tx DMA at all.

Signed-off-by: Paul Osmialowski <pawelo-rhuoMcPwk82rDJvtcaxF/A@public.gmane.org>
---
 arch/arm/boot/dts/kinetis-twr-k70f120m.dts | 23 +++++++++
 arch/arm/boot/dts/kinetis.dtsi             | 78 ++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/arch/arm/boot/dts/kinetis-twr-k70f120m.dts b/arch/arm/boot/dts/kinetis-twr-k70f120m.dts
index a6efc29..5d8470a 100644
--- a/arch/arm/boot/dts/kinetis-twr-k70f120m.dts
+++ b/arch/arm/boot/dts/kinetis-twr-k70f120m.dts
@@ -10,11 +10,34 @@
 	model = "Freescale TWR-K70F120M Development Kit";
 	compatible = "fsl,kinetis-twr-k70f120m";
 
+	chosen {
+		bootargs = "console=ttyLP2,115200";
+	};
+
 	memory {
 		reg = <0x8000000 0x8000000>;
 	};
 };
 
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "ok";
+};
+
+&portE {
+	status = "ok";
+
+	uart2 {
+		uart2_pins: pinmux_uart2_pins {
+			fsl,pins = <
+				16	0x300 /* E.16 = UART2_TX */
+				17	0x300 /* E.17 = UART2_RX */
+			>;
+		};
+	};
+};
+
 &pit0 {
 	status = "ok";
 };
diff --git a/arch/arm/boot/dts/kinetis.dtsi b/arch/arm/boot/dts/kinetis.dtsi
index c2861f5..fedafe3 100644
--- a/arch/arm/boot/dts/kinetis.dtsi
+++ b/arch/arm/boot/dts/kinetis.dtsi
@@ -16,9 +16,87 @@
 		pmx3 = &portD;
 		pmx4 = &portE;
 		pmx5 = &portF;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
 	};
 
 	soc {
+		uart0: serial@4006a000 {
+			compatible = "fsl,kinetis-lpuart";
+			reg = <0x4006a000 0x1000>;
+			interrupts = <45>, <46>;
+			interrupt-names = "uart-stat", "uart-err";
+			clocks = <&mcg_cclk_gate 3 10>;
+			clock-names = "ipg";
+			dmas = <&edma 0 2>;
+			dma-names = "rx";
+			status = "disabled";
+		};
+
+		uart1: serial@4006b000 {
+			compatible = "fsl,kinetis-lpuart";
+			reg = <0x4006b000 0x1000>;
+			interrupts = <47>, <48>;
+			interrupt-names = "uart-stat", "uart-err";
+			clocks = <&mcg_cclk_gate 3 11>;
+			clock-names = "ipg";
+			dmas = <&edma 0 4>;
+			dma-names = "rx";
+			status = "disabled";
+		};
+
+		uart2: serial@4006c000 {
+			compatible = "fsl,kinetis-lpuart";
+			reg = <0x4006c000 0x1000>;
+			interrupts = <49>, <50>;
+			interrupt-names = "uart-stat", "uart-err";
+			clocks = <&mcg_pclk_gate 3 12>;
+			clock-names = "ipg";
+			dmas = <&edma 0 6>;
+			dma-names = "rx";
+			status = "disabled";
+		};
+
+		uart3: serial@4006d000 {
+			compatible = "fsl,kinetis-lpuart";
+			reg = <0x4006d000 0x1000>;
+			interrupts = <51>, <52>;
+			interrupt-names = "uart-stat", "uart-err";
+			clocks = <&mcg_pclk_gate 3 13>;
+			clock-names = "ipg";
+			dmas = <&edma 0 8>;
+			dma-names = "rx";
+			status = "disabled";
+		};
+
+		uart4: serial@400ea000 {
+			compatible = "fsl,kinetis-lpuart";
+			reg = <0x400ea000 0x1000>;
+			interrupts = <53>, <54>;
+			interrupt-names = "uart-stat", "uart-err";
+			clocks = <&mcg_pclk_gate 0 10>;
+			clock-names = "ipg";
+			dmas = <&edma 0 10>;
+			dma-names = "rx";
+			status = "disabled";
+		};
+
+		uart5: serial@400eb000 {
+			compatible = "fsl,kinetis-lpuart";
+			reg = <0x400eb000 0x1000>;
+			interrupts = <55>, <56>;
+			interrupt-names = "uart-stat", "uart-err";
+			clocks = <&mcg_pclk_gate 0 11>;
+			clock-names = "ipg";
+			dmas = <&edma 0 12>;
+			dma-names = "rx";
+			status = "disabled";
+		};
+
 		edma: dma-controller@40008000 {
 			compatible = "fsl,kinetis-edma";
 			reg = <0x40008000 0x2000>, /* DMAC */
-- 
2.3.6

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
