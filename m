From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH v2 3/3] ARM: dts: enable dma support for auart0 in mx28
Date: Wed, 24 Oct 2012 18:27:36 +0800
Message-ID: <1351074456-25863-4-git-send-email-b32955@freescale.com>
References: <1351074456-25863-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:5732 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934677Ab2JXLCX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Oct 2012 07:02:23 -0400
In-Reply-To: <1351074456-25863-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, linux@arm.linux.org.uk, lauri.hintsala@bluegiga.com, vinod.koul@intel.com, Huang Shijie <b32955@freescale.com>

enable the dma support for auart0 in mx28.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx28.dtsi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index e16d631..73d1a9f 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -798,6 +798,7 @@
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x8006a000 0x2000>;
 				interrupts = <112 70 71>;
+				fsl,auart-dma-channel = <8 9>;
 				clocks = <&clks 45>;
 				status = "disabled";
 			};
-- 
1.7.0.4


