From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 13/15] arm: dts: am33xx: add DMA properties for UART
Date: Fri, 15 Aug 2014 19:42:41 +0200
Message-ID: <1408124563-31541-14-git-send-email-bigeasy@linutronix.de>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Cc: devicetree@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/boot/dts/am33xx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 4a4e02d..cdccbd6 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -200,6 +200,8 @@
 			reg = <0x44e09000 0x2000>;
 			interrupts = <72>;
 			status = "disabled";
+			dmas = <&edma 26>, <&edma 27>;
+			dma-names = "tx", "rx";
 		};
 
 		uart1: serial@48022000 {
@@ -209,6 +211,8 @@
 			reg = <0x48022000 0x2000>;
 			interrupts = <73>;
 			status = "disabled";
+			dmas = <&edma 28>, <&edma 29>;
+			dma-names = "tx", "rx";
 		};
 
 		uart2: serial@48024000 {
@@ -218,6 +222,8 @@
 			reg = <0x48024000 0x2000>;
 			interrupts = <74>;
 			status = "disabled";
+			dmas = <&edma 30>, <&edma 31>;
+			dma-names = "tx", "rx";
 		};
 
 		uart3: serial@481a6000 {
-- 
2.0.1

