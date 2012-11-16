From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH v3 3/3] ARM: dts: enable dma support for auart0 in mx28
Date: Fri, 16 Nov 2012 16:03:54 +0800
Message-ID: <1353053034-10944-4-git-send-email-b32955@freescale.com>
References: <1353053034-10944-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:14801
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750980Ab2KPIoK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Nov 2012 03:44:10 -0500
In-Reply-To: <1353053034-10944-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, vinod.koul@intel.com, lauri.hintsala@bluegiga.com, Huang Shijie <b32955@freescale.com>

enable the dma support for auart0 in mx28.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx28.dtsi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 55c57ea..b4587b2 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -799,6 +799,7 @@
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x8006a000 0x2000>;
 				interrupts = <112 70 71>;
+				fsl,auart-dma-channel = <8 9>;
 				clocks = <&clks 45>;
 				status = "disabled";
 			};
-- 
1.7.0.4


