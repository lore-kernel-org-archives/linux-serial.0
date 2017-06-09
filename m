From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v4 3/7] ARM64: dts: meson-gx: use stable UART bindings with correct gate clock
Date: Fri,  9 Jun 2017 11:49:12 +0200
Message-ID: <1497001756-942-4-git-send-email-narmstrong@baylibre.com>
References: <1497001756-942-1-git-send-email-narmstrong@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497001756-942-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, khilman@baylibre.com
Cc: Helmut Klein <hgkr.klein@gmail.com>, linux-serial@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
List-Id: linux-serial@vger.kernel.org

From: Helmut Klein <hgkr.klein@gmail.com>

This patch switches to the stable UART bindings but also add the correct
gate clock to the non-AO UART nodes for GXBB and GXL SoCs.

Signed-off-by: Helmut Klein <hgkr.klein@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 12 +++++-------
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 25 +++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 25 +++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 436b875..d2b8d52 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -225,7 +225,7 @@
 			};
 
 			uart_A: serial@84c0 {
-				compatible = "amlogic,meson-uart";
+				compatible = "amlogic,meson-gx-uart";
 				reg = <0x0 0x84c0 0x0 0x14>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&xtal>;
@@ -233,7 +233,7 @@
 			};
 
 			uart_B: serial@84dc {
-				compatible = "amlogic,meson-uart";
+				compatible = "amlogic,meson-gx-uart";
 				reg = <0x0 0x84dc 0x0 0x14>;
 				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&xtal>;
@@ -279,7 +279,7 @@
 			};
 
 			uart_C: serial@8700 {
-				compatible = "amlogic,meson-uart";
+				compatible = "amlogic,meson-gx-uart";
 				reg = <0x0 0x8700 0x0 0x14>;
 				interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&xtal>;
@@ -366,18 +366,16 @@
 			};
 
 			uart_AO: serial@4c0 {
-				compatible = "amlogic,meson-uart";
+				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
 				reg = <0x0 0x004c0 0x0 0x14>;
 				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>;
 				status = "disabled";
 			};
 
 			uart_AO_B: serial@4e0 {
-				compatible = "amlogic,meson-uart";
+				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
 				reg = <0x0 0x004e0 0x0 0x14>;
 				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index dbd300f..1ae8da7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -675,6 +675,31 @@
 	clocks = <&clkc CLKID_SPI>;
 };
 
+&uart_A {
+	clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
+	clock-names = "xtal", "pclk", "baud";
+};
+
+&uart_AO {
+	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
+	clock-names = "xtal", "pclk", "baud";
+};
+
+&uart_AO_B {
+	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
+	clock-names = "xtal", "pclk", "baud";
+};
+
+&uart_B {
+	clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
+	clock-names = "xtal", "core", "baud";
+};
+
+&uart_C {
+	clocks = <&xtal>, <&clkc CLKID_UART2>, <&xtal>;
+	clock-names = "xtal", "core", "baud";
+};
+
 &vpu {
 	compatible = "amlogic,meson-gxbb-vpu", "amlogic,meson-gx-vpu";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 4dfc22b..0c601f8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -616,6 +616,31 @@
 	clocks = <&clkc CLKID_SPI>;
 };
 
+&uart_A {
+	clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
+	clock-names = "xtal", "core", "baud";
+};
+
+&uart_AO {
+	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
+	clock-names = "xtal", "pclk", "baud";
+};
+
+&uart_AO_B {
+	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
+	clock-names = "xtal", "pclk", "baud";
+};
+
+&uart_B {
+	clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
+	clock-names = "xtal", "core", "baud";
+};
+
+&uart_C {
+	clocks = <&xtal>, <&clkc CLKID_UART2>, <&xtal>;
+	clock-names = "xtal", "core", "baud";
+};
+
 &vpu {
 	compatible = "amlogic,meson-gxl-vpu", "amlogic,meson-gx-vpu";
 };
-- 
1.9.1
