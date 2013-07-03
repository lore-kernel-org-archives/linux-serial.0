From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH v2 3/5] ARM: dts: imx6sl: add "fsl,imx6q-uart" for uart compatible
Date: Wed, 3 Jul 2013 17:42:35 +0800
Message-ID: <1372844557-3078-4-git-send-email-b32955@freescale.com>
References: <1372844557-3078-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [213.199.154.252] ([213.199.154.252]:11385 "EHLO
	db9outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755352Ab3GCKKn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Jul 2013 06:10:43 -0400
In-Reply-To: <1372844557-3078-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, Huang Shijie <b32955@freescale.com>

In order to enable the DMA for some uart port in imx6sl, we add the
"fsl,imx6q-uart" to the uart's compatible property.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6sl.dtsi |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 9138c67..0a297af 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -152,7 +152,8 @@
 				};
 
 				uart5: serial@02018000 {
-					compatible = "fsl,imx6sl-uart", "fsl,imx21-uart";
+					compatible = "fsl,imx6sl-uart",
+						   "fsl,imx6q-uart", "fsl,imx21-uart";
 					reg = <0x02018000 0x4000>;
 					interrupts = <0 30 0x04>;
 					clocks = <&clks IMX6SL_CLK_UART>,
@@ -162,7 +163,8 @@
 				};
 
 				uart1: serial@02020000 {
-					compatible = "fsl,imx6sl-uart", "fsl,imx21-uart";
+					compatible = "fsl,imx6sl-uart",
+						   "fsl,imx6q-uart", "fsl,imx21-uart";
 					reg = <0x02020000 0x4000>;
 					interrupts = <0 26 0x04>;
 					clocks = <&clks IMX6SL_CLK_UART>,
@@ -172,7 +174,8 @@
 				};
 
 				uart2: serial@02024000 {
-					compatible = "fsl,imx6sl-uart", "fsl,imx21-uart";
+					compatible = "fsl,imx6sl-uart",
+						   "fsl,imx6q-uart", "fsl,imx21-uart";
 					reg = <0x02024000 0x4000>;
 					interrupts = <0 27 0x04>;
 					clocks = <&clks IMX6SL_CLK_UART>,
@@ -209,7 +212,8 @@
 				};
 
 				uart3: serial@02034000 {
-					compatible = "fsl,imx6sl-uart", "fsl,imx21-uart";
+					compatible = "fsl,imx6sl-uart",
+						   "fsl,imx6q-uart", "fsl,imx21-uart";
 					reg = <0x02034000 0x4000>;
 					interrupts = <0 28 0x04>;
 					clocks = <&clks IMX6SL_CLK_UART>,
@@ -219,7 +223,8 @@
 				};
 
 				uart4: serial@02038000 {
-					compatible = "fsl,imx6sl-uart", "fsl,imx21-uart";
+					compatible = "fsl,imx6sl-uart",
+						   "fsl,imx6q-uart", "fsl,imx21-uart";
 					reg = <0x02038000 0x4000>;
 					interrupts = <0 29 0x04>;
 					clocks = <&clks IMX6SL_CLK_UART>,
-- 
1.7.1


