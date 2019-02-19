From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 2/5] dt-bindings: serial: sprd: Add clocks and clocks-names properties
Date: Tue, 19 Feb 2019 15:31:12 +0800
Message-ID: <c2b4db380c044bebe9fdf546b8a9f3aa351c6867.1550560916.git.baolin.wang@linaro.org>
References: <cover.1550560916.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1550560916.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1550560916.git.baolin.wang@linaro.org>
References: <cover.1550560916.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc: baolin.wang@linaro.org, broonie@kernel.org, lanqing.liu@unisoc.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Lanqing Liu <lanqing.liu@unisoc.com>

This patch adds clocks and clocks-names properties, which are used to do
power management for our UART driver.

Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/serial/sprd-uart.txt       |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
index cab40f0..6eb5863 100644
--- a/Documentation/devicetree/bindings/serial/sprd-uart.txt
+++ b/Documentation/devicetree/bindings/serial/sprd-uart.txt
@@ -7,7 +7,13 @@ Required properties:
 
 - reg: offset and length of the register set for the device
 - interrupts: exactly one interrupt specifier
-- clocks: phandles to input clocks.
+- clock-names: Should contain following entries:
+  "enable" for UART module enable clock,
+  "uart" for UART clock,
+  "source" for UART source (parent) clock.
+- clocks: Should contain a clock specifier for each entry in clock-names.
+  UART clock and source clock are optional properties, but enable clock
+  is required.
 
 Example:
 	uart0: serial@0 {
@@ -15,5 +21,6 @@ Example:
 			     "sprd,sc9836-uart";
 		reg = <0x0 0x100>;
 		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&ext_26m>;
+		clock-names = "enable", "uart", "source";
+		clocks = <&clk_ap_apb_gates 9>, <&clk_uart0>, <&ext_26m>;
 	};
-- 
1.7.9.5
