From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH v2 3/3] ARM: dts: imx28-evk: add the RTS/CTS property for auart0
Date: Tue, 16 Jul 2013 14:55:32 +0800
Message-ID: <1373957732-16638-4-git-send-email-b32955@freescale.com>
References: <1373957732-16638-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:33490
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750913Ab3GPHZI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Jul 2013 03:25:08 -0400
In-Reply-To: <1373957732-16638-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de, Huang Shijie <b32955@freescale.com>

Add the RTS/CTS property for auart0 which means we enable the
DMA support for it.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx28-evk.dts |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index e035f46..15715d9 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -220,6 +220,7 @@
 			auart0: serial@8006a000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&auart0_pins_a>;
+				fsl,uart-has-rtscts;
 				status = "okay";
 			};
 
-- 
1.7.1


