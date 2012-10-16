From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 3/3] ARM: dts: enable dma support for auart0 in mx28
Date: Tue, 16 Oct 2012 14:03:06 +0800
Message-ID: <1350367386-7742-4-git-send-email-b32955@freescale.com>
References: <1350367386-7742-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:27118
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754000Ab2JPGfo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Oct 2012 02:35:44 -0400
In-Reply-To: <1350367386-7742-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, linux@arm.linux.org.uk, lauri.hintsala@bluegiga.com, vinod.koul@intel.com, Huang Shijie <b32955@freescale.com>

enable the dma support for auart0 in mx28.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx28.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 6ed9215..738e023 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -798,6 +798,8 @@
 				compatible = "fsl,imx28-auart";
 				reg = <0x8006a000 0x2000>;
 				interrupts = <112 70 71>;
+				fsl,auart-dma-channel = <8 9>;
+				fsl,auart-enable-dma;
 				clocks = <&clks 45>;
 				status = "disabled";
 			};
-- 
1.7.0.4


