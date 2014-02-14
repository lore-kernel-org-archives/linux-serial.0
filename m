From: Yuan Yao <yao.yuan@freescale.com>
Subject: [PATCH v5 1/3] ARM: dts: vf610: lpuart: Add eDMA support
Date: Fri, 14 Feb 2014 15:27:17 +0800
Message-ID: <1392362839-8004-2-git-send-email-yao.yuan@freescale.com>
References: <1392362839-8004-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [207.46.163.27] ([207.46.163.27]:35742 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751788AbaBNIbe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Feb 2014 03:31:34 -0500
In-Reply-To: <1392362839-8004-1-git-send-email-yao.yuan@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, shawn.guo@linaro.org, mark.rutland@arm.com
Cc: linux@arm.linux.org.uk, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

Add lpuart dts node properties for eDMA support, them depend on the eDMA driver.

Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
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


