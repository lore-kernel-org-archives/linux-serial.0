From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH v3 5/6] ARM: dts: imx6q{dl}: add a DTE uart pinctrl for uart2
Date: Fri, 5 Jul 2013 14:12:31 +0800
Message-ID: <1373004752-21302-6-git-send-email-b32955@freescale.com>
References: <1373004752-21302-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:16706
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755792Ab3GEGjg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Jul 2013 02:39:36 -0400
In-Reply-To: <1373004752-21302-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: shawn.guo@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Huang Shijie <b32955@freescale.com>

In the arm2 board, the UART2 works in the dte mode.
So add a pinctrl for both the imx6q{dl} boards.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6dl.dtsi |    9 +++++++++
 arch/arm/boot/dts/imx6q.dtsi  |    9 +++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 2b5628d..5f61722 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -223,6 +223,15 @@
 							MX6DL_PAD_EIM_D27__UART2_RX_DATA 0x1b0b1
 						>;
 					};
+
+					pinctrl_uart2_2: uart2grp-2 { /* DTE mode */
+						fsl,pins = <
+							MX6DL_PAD_EIM_D26__UART2_RX_DATA 0x1b0b1
+							MX6DL_PAD_EIM_D27__UART2_TX_DATA 0x1b0b1
+							MX6DL_PAD_EIM_D28__UART2_CTS_B   0x1b0b1
+							MX6DL_PAD_EIM_D29__UART2_RTS_B	 0x1b0b1
+						>;
+					};
 				};
 
 				uart4 {
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 6f4d6ab..4ac3df5 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -266,6 +266,15 @@
 							MX6Q_PAD_EIM_D27__UART2_RX_DATA 0x1b0b1
 						>;
 					};
+
+					pinctrl_uart2_2: uart2grp-2 { /* DTE mode */
+						fsl,pins = <
+							MX6Q_PAD_EIM_D26__UART2_RX_DATA 0x1b0b1
+							MX6Q_PAD_EIM_D27__UART2_TX_DATA 0x1b0b1
+							MX6Q_PAD_EIM_D28__UART2_CTS_B	0x1b0b1
+							MX6Q_PAD_EIM_D29__UART2_RTS_B	0x1b0b1
+						>;
+					};
 				};
 
 				uart4 {
-- 
1.7.1


