From: Huang Shijie <shijie8@gmail.com>
Subject: [PATCH v3 3/3] ARM: dts: imx28-evk: add the RTS/CTS property for auart0
Date: Sat,  3 Aug 2013 10:09:16 -0400
Message-ID: <1375538956-15862-4-git-send-email-shijie8@gmail.com>
References: <1375538956-15862-1-git-send-email-shijie8@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:47815 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785Ab3HCCF3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Aug 2013 22:05:29 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so1246828pde.38
        for <linux-serial@vger.kernel.org>; Fri, 02 Aug 2013 19:05:28 -0700 (PDT)
In-Reply-To: <1375538956-15862-1-git-send-email-shijie8@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de, Huang Shijie <b32955@freescale.com>

From: Huang Shijie <b32955@freescale.com>

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
1.7.4.4

