From: Erin Lo <erin.lo@mediatek.com>
Subject: [PATCH v7 6/6] arm64: dts: mt8183: add spi node
Date: Fri, 15 Feb 2019 14:02:38 +0800
Message-ID: <1550210558-30516-7-git-send-email-erin.lo@mediatek.com>
References: <1550210558-30516-1-git-send-email-erin.lo@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550210558-30516-1-git-send-email-erin.lo@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com, erin.lo@mediatek.com, mars.cheng@mediatek.com, eddie.huang@mediatek.com, linux-clk@vger.kernel.org, Mengqi Zhang <Mengqi.Zhang@mediatek.com>
List-Id: linux-serial@vger.kernel.org

Add spi DTS node to the mt8183 and mt8183-evb.

Signed-off-by: Mengqi Zhang <Mengqi.Zhang@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts | 105 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi    |  79 +++++++++++++++++++++
 2 files changed, 184 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index 9b52559..b12c6ea 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -26,6 +26,111 @@
 	};
 };
 
+&pio {
+	spi_pins_0: spi0{
+		pins_spi{
+			pinmux = <PINMUX_GPIO85__FUNC_SPI0_MI>,
+				 <PINMUX_GPIO86__FUNC_SPI0_CSB>,
+				 <PINMUX_GPIO87__FUNC_SPI0_MO>,
+				 <PINMUX_GPIO88__FUNC_SPI0_CLK>;
+			bias-disable;
+		};
+	};
+
+	spi_pins_1: spi1{
+		pins_spi{
+			pinmux = <PINMUX_GPIO161__FUNC_SPI1_A_MI>,
+				 <PINMUX_GPIO162__FUNC_SPI1_A_CSB>,
+				 <PINMUX_GPIO163__FUNC_SPI1_A_MO>,
+				 <PINMUX_GPIO164__FUNC_SPI1_A_CLK>;
+			bias-disable;
+		};
+	};
+
+	spi_pins_2: spi2{
+		pins_spi{
+			pinmux = <PINMUX_GPIO0__FUNC_SPI2_CSB>,
+				 <PINMUX_GPIO1__FUNC_SPI2_MO>,
+				 <PINMUX_GPIO2__FUNC_SPI2_CLK>,
+				 <PINMUX_GPIO94__FUNC_SPI2_MI>;
+			bias-disable;
+		};
+	};
+
+	spi_pins_3: spi3{
+		pins_spi{
+			pinmux = <PINMUX_GPIO21__FUNC_SPI3_MI>,
+				 <PINMUX_GPIO22__FUNC_SPI3_CSB>,
+				 <PINMUX_GPIO23__FUNC_SPI3_MO>,
+				 <PINMUX_GPIO24__FUNC_SPI3_CLK>;
+			bias-disable;
+		};
+	};
+
+	spi_pins_4: spi4{
+		pins_spi{
+			pinmux = <PINMUX_GPIO17__FUNC_SPI4_MI>,
+				 <PINMUX_GPIO18__FUNC_SPI4_CSB>,
+				 <PINMUX_GPIO19__FUNC_SPI4_MO>,
+				 <PINMUX_GPIO20__FUNC_SPI4_CLK>;
+			bias-disable;
+		};
+	};
+
+	spi_pins_5: spi5{
+		pins_spi{
+			pinmux = <PINMUX_GPIO13__FUNC_SPI5_MI>,
+				 <PINMUX_GPIO14__FUNC_SPI5_CSB>,
+				 <PINMUX_GPIO15__FUNC_SPI5_MO>,
+				 <PINMUX_GPIO16__FUNC_SPI5_CLK>;
+			bias-disable;
+		};
+	};
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_pins_0>;
+	mediatek,pad-select = <0>;
+	status = "okay";
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_pins_1>;
+	mediatek,pad-select = <0>;
+	status = "okay";
+};
+
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_pins_2>;
+	mediatek,pad-select = <0>;
+	status = "okay";
+};
+
+&spi3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_pins_3>;
+	mediatek,pad-select = <0>;
+	status = "okay";
+};
+
+&spi4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_pins_4>;
+	mediatek,pad-select = <0>;
+	status = "okay";
+};
+
+&spi5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_pins_5>;
+	mediatek,pad-select = <0>;
+	status = "okay";
+
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 1bd1399..165b859 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/mt8183-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include "mt8183-pinfunc.h"
 
 / {
 	compatible = "mediatek,mt8183";
@@ -267,6 +268,84 @@
 			status = "disabled";
 		};
 
+		spi0: spi@1100a000 {
+			compatible = "mediatek,mt8183-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x1100a000 0 0x1000>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_SYSPLL_D5_D2>,
+				 <&topckgen CLK_TOP_MUX_SPI>,
+				 <&infracfg CLK_INFRA_SPI0>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		spi1: spi@11010000 {
+			compatible = "mediatek,mt8183-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11010000 0 0x1000>;
+			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_SYSPLL_D5_D2>,
+				 <&topckgen CLK_TOP_MUX_SPI>,
+				 <&infracfg CLK_INFRA_SPI1>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		spi2: spi@11012000 {
+			compatible = "mediatek,mt8183-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11012000 0 0x1000>;
+			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_SYSPLL_D5_D2>,
+				 <&topckgen CLK_TOP_MUX_SPI>,
+				 <&infracfg CLK_INFRA_SPI2>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		spi3: spi@11013000 {
+			compatible = "mediatek,mt8183-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11013000 0 0x1000>;
+			interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_SYSPLL_D5_D2>,
+				 <&topckgen CLK_TOP_MUX_SPI>,
+				 <&infracfg CLK_INFRA_SPI3>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		spi4: spi@11018000 {
+			compatible = "mediatek,mt8183-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11018000 0 0x1000>;
+			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_SYSPLL_D5_D2>,
+				 <&topckgen CLK_TOP_MUX_SPI>,
+				 <&infracfg CLK_INFRA_SPI4>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		spi5: spi@11019000 {
+			compatible = "mediatek,mt8183-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11019000 0 0x1000>;
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_SYSPLL_D5_D2>,
+				 <&topckgen CLK_TOP_MUX_SPI>,
+				 <&infracfg CLK_INFRA_SPI5>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
 		audiosys: syscon@11220000 {
 			compatible = "mediatek,mt8183-audiosys", "syscon";
 			reg = <0 0x11220000 0 0x1000>;
-- 
1.9.1
