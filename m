From: Yuan Yao <yao.yuan@freescale.com>
Subject: [PATCH 1/2] ARM: dts: vf610: lpuart: Add eDMA support
Date: Thu, 9 Jan 2014 11:04:40 +0800
Message-ID: <1389236681-30372-2-git-send-email-yao.yuan@freescale.com>
References: <1389236681-30372-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-db9lp0248.outbound.messaging.microsoft.com ([213.199.154.248]:50086
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751585AbaAIEAw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Jan 2014 23:00:52 -0500
In-Reply-To: <1389236681-30372-1-git-send-email-yao.yuan@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, shawn.guo@linaro.org
Cc: linux@arm.linux.org.uk, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
---
 arch/arm/boot/dts/vf610.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 365e0fa..ed6b053 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -118,6 +118,9 @@
 				interrupts = <0 61 0x00>;
 				clocks = <&clks VF610_CLK_UART0>;
 				clock-names = "ipg";
+				dma-names = "lpuart-tx","lpuart-rx";
+				dmas = <&edma0 0 VF610_EDMA_MUXID0_UART0_TX>,
+					<&edma0 0 VF610_EDMA_MUXID0_UART0_RX>;
 				status = "disabled";
 			};
 
@@ -127,6 +130,9 @@
 				interrupts = <0 62 0x04>;
 				clocks = <&clks VF610_CLK_UART1>;
 				clock-names = "ipg";
+				dma-names = "lpuart-tx","lpuart-rx";
+				dmas = <&edma0 0 VF610_EDMA_MUXID0_UART1_TX>,
+					<&edma0 0 VF610_EDMA_MUXID0_UART1_RX>;
 				status = "disabled";
 			};
 
@@ -136,6 +142,9 @@
 				interrupts = <0 63 0x04>;
 				clocks = <&clks VF610_CLK_UART2>;
 				clock-names = "ipg";
+				dma-names = "lpuart-tx","lpuart-rx";
+				dmas = <&edma0 0 VF610_EDMA_MUXID0_UART2_TX>,
+					<&edma0 0 VF610_EDMA_MUXID0_UART2_RX>;
 				status = "disabled";
 			};
 
@@ -145,6 +154,9 @@
 				interrupts = <0 64 0x04>;
 				clocks = <&clks VF610_CLK_UART3>;
 				clock-names = "ipg";
+				dma-names = "lpuart-tx","lpuart-rx";
+				dmas = <&edma0 0 VF610_EDMA_MUXID0_UART3_TX>,
+					<&edma0 0 VF610_EDMA_MUXID0_UART3_RX>;
 				status = "disabled";
 			};
 
-- 
1.8.4


