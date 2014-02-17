From: Yuan Yao <yao.yuan@freescale.com>
Subject: [PATCH v6 1/3] ARM: dts: vf610: lpuart: Add eDMA support
Date: Mon, 17 Feb 2014 13:28:06 +0800
Message-ID: <1392614888-10261-2-git-send-email-yao.yuan@freescale.com>
References: <1392614888-10261-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:3570 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753093AbaBQGcD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Feb 2014 01:32:03 -0500
In-Reply-To: <1392614888-10261-1-git-send-email-yao.yuan@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, shawn.guo@linaro.org, mark.rutland@arm.com
Cc: arnd@arndb.de, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

Add lpuart dts node properties for eDMA support, them depend on the eDMA driver.

Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/vf610.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 365e0fa..8f523b0 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -94,6 +94,9 @@
 				interrupts = <0 61 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_UART0>;
 				clock-names = "ipg";
+				dmas = <&edma0 0 2>,
+					<&edma0 0 3>;
+				dma-names = "rx","tx";
 				status = "disabled";
 			};
 
@@ -103,6 +106,9 @@
 				interrupts = <0 62 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_UART1>;
 				clock-names = "ipg";
+				dmas = <&edma0 0 4>,
+					<&edma0 0 5>;
+				dma-names = "rx","tx";
 				status = "disabled";
 			};
 
@@ -112,6 +118,9 @@
 				interrupts = <0 63 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_UART2>;
 				clock-names = "ipg";
+				dmas = <&edma0 0 6>,
+					<&edma0 0 7>;
+				dma-names = "rx","tx";
 				status = "disabled";
 			};
 
@@ -121,6 +130,9 @@
 				interrupts = <0 64 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_UART3>;
 				clock-names = "ipg";
+				dmas = <&edma0 0 8>,
+					<&edma0 0 9>;
+				dma-names = "rx","tx";
 				status = "disabled";
 			};
 
-- 
1.8.4


