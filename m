From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 2/2] ARM: MX6q: enable DMA support for UART2
Date: Thu, 26 Apr 2012 18:37:12 +0800
Message-ID: <1335436632-29499-3-git-send-email-b32955@freescale.com>
References: <1335436632-29499-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:18620
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755487Ab2DZKdi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Apr 2012 06:33:38 -0400
In-Reply-To: <1335436632-29499-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, B20223@freescale.com, r58066@freescale.com, B20596@freescale.com, s.hauer@pengutronix.de, Huang Shijie <b32955@freescale.com>

add uart2 for mx6q-arm2 board, and enable the DMA support for it.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6q-arm2.dts |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index ce1c823..c9a6cb3 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -46,6 +46,14 @@
 				status = "okay";
 			};
 
+			uart2: uart@021e8000 {
+				fsl,uart-has-rtscts;
+				fsl,enable-dma;
+				fsl,uart-dma-events = <27 28>;
+				fsl,enable-dte;
+				status = "okay";
+			};
+
 			uart4: uart@021f0000 {
 				status = "okay";
 			};
-- 
1.7.0.4


