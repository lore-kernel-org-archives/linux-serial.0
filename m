From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v2 3/4] dt-bindings: serial: sprd: Add dma properties to support DMA mode
Date: Mon,  4 Mar 2019 16:58:23 +0800
Message-ID: <5ef1bbcf1d78829f28377a599d81d0adc7d61ef1.1551689518.git.baolin.wang@linaro.org>
References: <cover.1551689518.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1551689518.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1551689518.git.baolin.wang@linaro.org>
References: <cover.1551689518.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc: baolin.wang@linaro.org, broonie@kernel.org, lanqing.liu@unisoc.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Lanqing Liu <lanqing.liu@unisoc.com>

This patch adds dmas and dma-names properties for the UART DMA mode.

Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/serial/sprd-uart.txt       |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
index 6eb5863..9607dc6 100644
--- a/Documentation/devicetree/bindings/serial/sprd-uart.txt
+++ b/Documentation/devicetree/bindings/serial/sprd-uart.txt
@@ -15,12 +15,18 @@ Required properties:
   UART clock and source clock are optional properties, but enable clock
   is required.
 
+Optional properties:
+- dma-names: Should contain "rx" for receive and "tx" for transmit channels.
+- dmas: A list of dma specifiers, one for each entry in dma-names.
+
 Example:
 	uart0: serial@0 {
 		compatible = "sprd,sc9860-uart",
 			     "sprd,sc9836-uart";
 		reg = <0x0 0x100>;
 		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+		dma-names = "rx", "tx";
+		dmas = <&ap_dma 19>, <&ap_dma 20>;
 		clock-names = "enable", "uart", "source";
 		clocks = <&clk_ap_apb_gates 9>, <&clk_uart0>, <&ext_26m>;
 	};
-- 
1.7.9.5
