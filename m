From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v4 09/10] ARM: dts: STiH407-family: Use new Pinctrl groups
Date: Fri,  3 Feb 2017 10:23:18 +0000
Message-ID: <20170203102319.23489-10-lee.jones@linaro.org>
References: <20170203102319.23489-1-lee.jones@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170203102319.23489-1-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Having just defined some new Pinctrl groups for when HW flow-control
is {en,dis}abled, let's reference them for use within the driver.

Acked-by: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 3 +--
 arch/arm/boot/dts/stih410-b2260.dts   | 5 ++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index c8b2944..e480e32 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -222,9 +222,8 @@
 			compatible = "st,asc";
 			reg = <0x9830000 0x2c>;
 			interrupts = <GIC_SPI 122 IRQ_TYPE_NONE>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_serial0>;
 			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+			/* Pinctrl moved out to a per-board configuration */
 
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index fa16aba..cbcbcb4 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -62,8 +62,11 @@
 		/* Low speed expansion connector */
 		uart0: serial@9830000 {
 			label = "LS-UART0";
-			status = "okay";
+			pinctrl-names = "default", "no-hw-flowctrl";
+			pinctrl-0 = <&pinctrl_serial0_hw_flowctrl>;
+			pinctrl-1 = <&pinctrl_serial0>;
 			rts-gpios = <&pio17 3 GPIO_ACTIVE_LOW>;
+			status = "okay";
 		};
 
 		/* Low speed expansion connector */
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
