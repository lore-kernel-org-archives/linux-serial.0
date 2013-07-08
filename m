From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH v4 5/6] ARM: dts: imx6q{dl}: add a DTE uart pinctrl for uart2
Date: Mon, 8 Jul 2013 17:14:21 +0800
Message-ID: <1373274862-2695-6-git-send-email-b32955@freescale.com>
References: <1373274862-2695-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:33622
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751134Ab3GHJmI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Jul 2013 05:42:08 -0400
In-Reply-To: <1373274862-2695-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, Huang Shijie <b32955@freescale.com>

In the arm2 board, the UART2 works in the dte mode.
So add a pinctrl for both the imx6q{dl} boards.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6dl.dtsi |    9 +++++++++
 arch/arm/boot/dts/imx6q.dtsi  |    9 +++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 2b5628d..a1302ed 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -223,6 +223,15 @@
 							MX6DL_PAD_EIM_D27__UART2_RX_DATA 0x1b0b1
 						>;
 					};
+
+					pinctrl_uart2_2: uart2grp-2 { /* DTE mode */
+						fsl,pins = <
+							MX6DL_PAD_EIM_D26__UART2_RX_DATA   0x1b0b1
+							MX6DL_PAD_EIM_D27__UART2_TX_DATA   0x1b0b1
+							MX6DL_PAD_EIM_D28__UART2_DTE_CTS_B 0x1b0b1
+							MX6DL_PAD_EIM_D29__UART2_DTE_RTS_B 0x1b0b1
+						>;
+					};
 				};
 
 				uart4 {
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 6f4d6ab..e0b7bad 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -266,6 +266,15 @@
 							MX6Q_PAD_EIM_D27__UART2_RX_DATA 0x1b0b1
 						>;
 					};
+
+					pinctrl_uart2_2: uart2grp-2 { /* DTE mode */
+						fsl,pins = <
+							MX6Q_PAD_EIM_D26__UART2_RX_DATA   0x1b0b1
+							MX6Q_PAD_EIM_D27__UART2_TX_DATA   0x1b0b1
+							MX6Q_PAD_EIM_D28__UART2_DTE_CTS_B 0x1b0b1
+							MX6Q_PAD_EIM_D29__UART2_DTE_RTS_B 0x1b0b1
+						>;
+					};
 				};
 
 				uart4 {
-- 
1.7.1


