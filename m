From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 3/5] ARM: dts: imx6: rename the uart's compatible property
Date: Tue, 2 Jul 2013 14:30:26 +0800
Message-ID: <1372746628-20092-4-git-send-email-b32955@freescale.com>
References: <1372746628-20092-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [213.199.154.188] ([213.199.154.188]:58507 "EHLO
	db8outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752794Ab3GBG6A (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Jul 2013 02:58:00 -0400
In-Reply-To: <1372746628-20092-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, Huang Shijie <b32955@freescale.com>

The imx6 uart can supports the DMA, imx uart driver has added a new
compatible property for the imx6 uart.

In order to enable the DMA for some uart port in imx6, we rename the
uart's compatible property to "fsl,imx6-uart".

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi |   10 +++++-----
 arch/arm/boot/dts/imx6sl.dtsi  |   10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 0509344..d4ab0ee 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -179,7 +179,7 @@
 				};
 
 				uart1: serial@02020000 {
-					compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
+					compatible = "fsl,imx6-uart";
 					reg = <0x02020000 0x4000>;
 					interrupts = <0 26 0x04>;
 					clocks = <&clks 160>, <&clks 161>;
@@ -787,7 +787,7 @@
 			};
 
 			uart2: serial@021e8000 {
-				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
+				compatible = "fsl,imx6-uart";
 				reg = <0x021e8000 0x4000>;
 				interrupts = <0 27 0x04>;
 				clocks = <&clks 160>, <&clks 161>;
@@ -796,7 +796,7 @@
 			};
 
 			uart3: serial@021ec000 {
-				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
+				compatible = "fsl,imx6-uart";
 				reg = <0x021ec000 0x4000>;
 				interrupts = <0 28 0x04>;
 				clocks = <&clks 160>, <&clks 161>;
@@ -805,7 +805,7 @@
 			};
 
 			uart4: serial@021f0000 {
-				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
+				compatible = "fsl,imx6-uart";
 				reg = <0x021f0000 0x4000>;
 				interrupts = <0 29 0x04>;
 				clocks = <&clks 160>, <&clks 161>;
@@ -814,7 +814,7 @@
 			};
 
 			uart5: serial@021f4000 {
-				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
+				compatible = "fsl,imx6-uart";
 				reg = <0x021f4000 0x4000>;
 				interrupts = <0 30 0x04>;
 				clocks = <&clks 160>, <&clks 161>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 9138c67..ca1527f 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -152,7 +152,7 @@
 				};
 
 				uart5: serial@02018000 {
-					compatible = "fsl,imx6sl-uart", "fsl,imx21-uart";
+					compatible = "fsl,imx6-uart";
 					reg = <0x02018000 0x4000>;
 					interrupts = <0 30 0x04>;
 					clocks = <&clks IMX6SL_CLK_UART>,
@@ -162,7 +162,7 @@
 				};
 
 				uart1: serial@02020000 {
-					compatible = "fsl,imx6sl-uart", "fsl,imx21-uart";
+					compatible = "fsl,imx6-uart";
 					reg = <0x02020000 0x4000>;
 					interrupts = <0 26 0x04>;
 					clocks = <&clks IMX6SL_CLK_UART>,
@@ -172,7 +172,7 @@
 				};
 
 				uart2: serial@02024000 {
-					compatible = "fsl,imx6sl-uart", "fsl,imx21-uart";
+					compatible = "fsl,imx6-uart";
 					reg = <0x02024000 0x4000>;
 					interrupts = <0 27 0x04>;
 					clocks = <&clks IMX6SL_CLK_UART>,
@@ -209,7 +209,7 @@
 				};
 
 				uart3: serial@02034000 {
-					compatible = "fsl,imx6sl-uart", "fsl,imx21-uart";
+					compatible = "fsl,imx6-uart";
 					reg = <0x02034000 0x4000>;
 					interrupts = <0 28 0x04>;
 					clocks = <&clks IMX6SL_CLK_UART>,
@@ -219,7 +219,7 @@
 				};
 
 				uart4: serial@02038000 {
-					compatible = "fsl,imx6sl-uart", "fsl,imx21-uart";
+					compatible = "fsl,imx6-uart";
 					reg = <0x02038000 0x4000>;
 					interrupts = <0 29 0x04>;
 					clocks = <&clks IMX6SL_CLK_UART>,
-- 
1.7.1


